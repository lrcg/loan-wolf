class TransfersController < ApplicationController
  before_filter :authenticate_user!

  def index
  	@transfers_as_creditor = current_user.credits.current
    @transfers_as_debtor = current_user.debts.current
    @quote = Quote.offset(rand(Quote.count)).first
  end

  def newTo
  	@users = User.where('id != ?', current_user.id)
  end

  def newFrom
  	@users = User.where('id != ?', current_user.id)
  end

  def destroy
    @transfer = Transfer.find(params[:id])
    @transfer.destroy

    DestroyNotificationMailer.new_destroy_notification_email(@transfer.creditor,@transfer.debtor,@transfer).deliver

    respond_to do |format|
      format.html { redirect_to '' }
      format.json { head :no_content }
    end
  end

  def sendPaymentReminder
    @transfer = Transfer.find(params[:id])
    PaymentReminderMailer.new_payment_reminder_email(@transfer).deliver
    redirect_to root_url, :notice => 'Reminder email was sent.'
  end

  def markApproved
    @transfer = Transfer.find(params[:id])
    respond_to do |format|
      if @transfer.can_be_marked_approved_by? current_user
        @transfer.approved_by_user_id = current_user.id
        @transfer.approved_date = Date.today
        if @transfer.save :validate => false
          format.html { redirect_to '', notice: 'Transfer was marked approved!'}
        else
          format.html { redirect_to '', alert: 'Transfer was not marked approved!'}
        end
      else
        format.html { redirect_to '', notice: 'You aren\'t allowed to approve it!'}
      end
    end
  end

  def markPaid
    @transfer = Transfer.find(params[:id])
    respond_to do |format|
      if @transfer.can_be_marked_paid_by? current_user
        @transfer.is_archived = true
        if @transfer.save :validate => false
          format.html { redirect_to '', notice: 'Transfer was marked paid!'}
        else
          format.html { redirect_to '', alert: 'Transfer was not marked paid!'}
        end
      else
        format.html { redirect_to '', notice: 'You aren\'t allowed to mark it zero!'}
      end
    end
  end

  def create
    authorize!

    @users = User.where('id != ?', current_user.id)
    @transfer = Transfer.new(params[:Transfer])

    # TODO: Find a better way to return to the view that submitted the form
    newView = params[:View]

    # TODO: Refactor -- handling of admin / user inputs should not be in the controller
    if current_user.admin?
      @transfer.approved_by_user_id = current_user.id
      @transfer.approved_date = Date.today
    else
      if @transfer.creditor_user_id.nil?
        @transfer.creditor_user_id = current_user.id
      elsif @transfer.debtor_user_id.nil?
        @transfer.debtor_user_id = current_user.id
        @transfer.approved_by_user_id = current_user.id
        @transfer.approved_date = Date.today
      end
    end


    respond_to do |format|
      if @transfer.save

        eventLog = EventLog.newTransferCreateUnbound
        eventLog.hr_summary = 'An unbound transfer was created by '
        eventLog.primary_model_instance = @transfer
        logger.debug eventLog
        #eventLog.save!


        if newView == "newTo"
          ApprovalRequestMailer.new_debtor_approval_email(@transfer).deliver
        end
        format.html { redirect_to '', notice: 'Transfer was successfully created.' }
        format.json { render json: @transfer, status: :created, location: @transfer }
      else
        # TODO: Putting validation errors into flash messages here seems like the wrong spot
        flash[:alert] = @transfer.errors.full_messages.first if @transfer.errors.any?
        format.html { render action: newView, alert: 'this doesnt show up' }
        format.json { render json: @transfer.errors, status: :unprocessable_entity }
     end
    end
  end
end

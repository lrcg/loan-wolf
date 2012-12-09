class LoansController < ApplicationController
  before_filter :authenticate_user!

  def index
  	@loans_as_creditor = current_user.credits.current
    @loans_as_debtor = current_user.debts.current
    @quote = Quote.offset(rand(Quote.count)).first
  end
  def newTo
  	@users = User.where('id != ?', current_user.id)
  end

  def newFrom
  	@users = User.where('id != ?', current_user.id)
  end

  def destroy
    @loan = Loan.find(params[:id])
    @loan.destroy

    DestroyNotificationMailer.new_destroy_notification_email(@loan.creditor,@loan.debtor,@loan).deliver

    respond_to do |format|
      format.html { redirect_to '' }
      format.json { head :no_content }
    end
  end

  def markApproved
    @loan = Loan.find(params[:id])
    respond_to do |format|
      if @loan.can_be_marked_approved_by? current_user
        @loan.approved_by_user_id = current_user.id
        @loan.approved_date = Date.today
        if @loan.save :validate => false
          format.html { redirect_to '', notice: 'Loan was marked approved!'}
        else
          format.html { redirect_to '', alert: 'Loan was not marked approved!'}
        end
      else
        format.html { redirect_to '', notice: 'You aren\'t allowed to approve it!'}
      end
    end
  end

  def markPaid
    @loan = Loan.find(params[:id])
    respond_to do |format|
      if @loan.can_be_marked_paid_by? current_user
        @loan.is_archived = true
        if @loan.save :validate => false
          format.html { redirect_to '', notice: 'Loan was marked paid!'}
        else
          format.html { redirect_to '', alert: 'Loan was not marked paid!'}
        end
      else
        format.html { redirect_to '', notice: 'You aren\'t allowed to mark it zero!'}
      end
    end
  end

  def create
    @users = User.where('id != ?', current_user.id)
    @loan = Loan.new(params[:Loan])

    if @loan.creditor_user_id.nil?
      @failAction = "newTo"
      @loan.creditor_user_id = current_user.id
      @user = User.where('id == ?', @loan.creditor_user_id)
    elsif @loan.debtor_user_id.nil?
      @failAction = "newFrom"
      @loan.debtor_user_id = current_user.id
      @loan.approved_by_user_id = current_user.id
      @loan.approved_date = Date.today
      @user = User.where('id == ?', @loan.debtor_user_id)
    end

    respond_to do |format|
      if @loan.save
        if @failAction == "newTo"
          ApprovalRequestMailer.new_debtor_approval_email(@loan).deliver
        end
        format.html { redirect_to '', notice: 'Loan was successfully created.' }
        format.json { render json: @loan, status: :created, location: @loan }
      else
        # TODO: Putting validation errors into flash messages here seems like the wrong spot
        flash[:alert] = @loan.errors.full_messages.first if @loan.errors.any?
        format.html { render action: @failAction, alert: 'this doesnt show up' }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
     end
    end
  end

  def list
  end

  def listAll
  end
end

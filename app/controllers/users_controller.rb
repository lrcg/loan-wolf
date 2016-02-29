class UsersController < ApplicationController
  before_filter :authenticate_user!

  def optInShareDebtsPublicly
    current_user.opt_to_share_debt = true
    current_user.save :validate => false
    respond_to do |format|
      format.html { redirect_to '', notice: 'You are now sharing the amount you owe as a debtor publicly.'}
    end
  end

  def optOutShareDebtsPublicly
    current_user.opt_to_share_debt = false
    current_user.save :validate => false
    respond_to do |format|
      format.html { redirect_to '', notice: 'The amount you owe as a debtor is now private.'}
    end
  end
end

class CopyCreditUserIdToCreditorUserIdForLoan < ActiveRecord::Migration
  def up
  	loans = Loan.all
  	loans.each do |loan|
		loan.creditor_user_id = loan.credit_user_id
		loan.save :validate => false
  	end
  end

  def down
  	loans = Loan.all
  	loans.each do |loan|
  		loan.credit_user_id = loan.creditor_user_id
  		loan.save :validate => false
  	end
  end
end

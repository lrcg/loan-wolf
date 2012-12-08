class ApprovalRequestMailer < ActionMailer::Base
  default from: "do-not-reply@theloanshark.com"

 def new_debtor_approval_email(loan)
    @loan = loan
    @url  = "http://l-thurston.mpb.cichq.com:3000"
    #mail(:to => @loan.debtor.email, :subject => "Loan Confirmation Requested")
    mail(:to => 'lucas@castironcoding.com', :subject => "Loan Confirmation Requested")
  end
end

class ApprovalRequestMailer < ActionMailer::Base
  default from: "do-not-reply@theloanwolf.com"

 def new_debtor_approval_email(loan)
    @loan = loan
    @url  = "http://loanwolf.cichq.com"
    mail(:to => 'lucas@castironcoding.com', :subject => "Loan Confirmation Requested")
  end
end

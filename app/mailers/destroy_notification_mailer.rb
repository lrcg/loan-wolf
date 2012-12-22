class DestroyNotificationMailer < ActionMailer::Base
 default from: "do-not-reply@theloanwolf.com"

 def new_destroy_notification_email(creditor,debtor,loan)
 	@creditor = creditor
    @debtor = debtor
    @loan = loan
    @url  = "http://loanwolf.cichq.com"
    mail(:to => debtor.email, :subject => "Loan Confirmation Requested")
  end
end


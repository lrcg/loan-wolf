class DestroyNotificationMailer < ActionMailer::Base
 default from: "do-not-reply@theloanshark.com"

 def new_destroy_notification_email(creditor,debtor,loan)
 	@creditor = creditor
    @debtor = debtor
    @loan = loan
    @url  = "http://l-thurston.mpb.cichq.com:3000"
    #mail(:to => debtor.email, :subject => "Loan Confirmation Requested")
    mail(:to => 'lucas@castironcoding.com', :subject => "Loan Confirmation Requested")
  end
end


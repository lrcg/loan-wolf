class PaymentReminderMailer < ActionMailer::Base
 default from: "do-not-reply@theloanwolf.com"

 def new_payment_reminder_email(loan)
    @loan = loan
    @url  = "http://l-thurston.mpb.cichq.com:3000"
    #mail(:to => creditor.email, :subject => "Payment Reminder")
    mail(:to => 'lucas@castironcoding.com', :subject => "Payment Reminder")
  end
end

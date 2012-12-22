class PaymentReminderMailer < ActionMailer::Base
 default from: "do-not-reply@theloanwolf.com"

 def new_payment_reminder_email(loan)
    @loan = loan
    @url  = "http://loanwolf.cichq.com"
    mail(:to => @loan.creditor.email, :subject => "Payment Reminder")
  end
end
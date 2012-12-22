class DevelopmentMailInterceptor
  def self.delivering_email(message)
    message.to = NOTIFY_EMAIL_OVERRIDE if defined?(NOTIFY_EMAIL_OVERRIDE)
  end
end
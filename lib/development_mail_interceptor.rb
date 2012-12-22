class DevelopmentMailInterceptor
  def self.delivering_email(message)
    message.to = 'lucas@castironcoding.com'
  end
end
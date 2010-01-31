if ENV['RAILS_ENV'] == "production"
  
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    :address => '127.0.0.1',
    :port => 25,
    :domain => 'localhost'
  }
	ActionMailer::Base.default_content_type = "text/html"	

else

  #setup tlsmail so we can send email through SSLed SMTP
  require 'tlsmail'
  Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)

  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    :address => 'smtp.gmail.com',
    :port => 587,
    :domain => 'gmail.com',
    :authentication => :plain,
    :user_name => 'tgannon@gmail.com',
    :password => 'apeman78'
  }
  ActionMailer::Base.default_content_type = "text/html"	

end #end if

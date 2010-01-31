class Emailer < ActionMailer::Base

	default_url_options[:host] = RAILS_ENV != "production" ? "localhost:3000" : "turningseasons.heroku.com" 
  def activation_instructions(user)
		recipients  user.email
		from        "tgannon@gmail.com"
		subject     "Turning Seasons TCM registration confirmation"
    sent_on       Time.now
    body          :account_activation_url => register_url(user.perishable_token), :user => user

  end

  def activation_confirmation(user)
    subject       "Activation Complete"
    from          "tgannon@gmail.com"
    recipients    user.email
    sent_on       Time.now
    body          :root_url => root_url

  end	
	
	def try_this
    subject       "Activation Complete"
    from          "tgannon@gmail.com"
    recipients    "tgannon@gmail.com"
    sent_on       Time.now
    body          "Hello, World!"

  end	
end

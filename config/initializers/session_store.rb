# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key    => '_tcm_student_web_session',
  :secret => '6425e385982bc9e9097da0050a25036f85958f565b226e45e7b9370c531b105350da9dfd9973d3bef6b4afdd364e2b04ee722a14a753eb308c4dd306013cedc6'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

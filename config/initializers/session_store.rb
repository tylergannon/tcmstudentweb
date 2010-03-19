# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key    => '_tcm_student_web_session',
  :secret => 'e0a86d075b47222c79677249d1e91ac4d3cdabd80129fa511c74e152f61c6723b816d6a89938183643f0a4e28d3e5a8c41e60fd9f3c4a894387387afcce13267'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

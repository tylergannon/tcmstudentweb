# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key    => '_tcm_student_web_session',
  :secret => 'a3d83976091eeafc85b35a385925b85d2e70d6a0c73dc36186348538fbfc877b14ccf46d38abf4ad779ee0084120662d0f14ca51b370c5aec7430d75e777ce83'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

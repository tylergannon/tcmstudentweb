# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key    => '_tcm_student_web_session',
  :secret => '768f9437eb88cb0f49a45ef62243b236ce7b32aa6904db7549cc166614dc65122eafc67864e97d7750e1f1396af9c541b7882149a27c1827a2cdcc9a811a21a8'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

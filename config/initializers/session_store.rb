# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_herbs_session',
  :secret      => '6c940e773bf3868b9bef141993c8a4af52e07234ae60c895036cbdaa0f38370503d6a933d7361073eb75868f8d5be0771c2300bff458c00389c2056e27460deb'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

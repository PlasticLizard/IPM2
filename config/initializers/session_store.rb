# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_ipm_session',
  :secret      => 'e0dafe6357f3a3e0e18d7e83d122665a241ab96f68d1ef55ef733efdcb3ff4e85b9ede49f6eeedf84359e3f737fd75de5e713cd5843b93c56220bc1b56b6b3b5'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

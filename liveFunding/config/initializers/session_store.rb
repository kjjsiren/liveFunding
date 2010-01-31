# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_liveFunding_session',
  :secret      => '2ed6d0d2933c75656dbc97351e7962a1bfd6721e93ac4e39ecb10d4e90b34cdc8a941f52722ee14c84b64a72f503a6c0a2182251d97d6a238aea014eb9e0e647'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

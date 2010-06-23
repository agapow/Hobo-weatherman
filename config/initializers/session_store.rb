# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_weatherman_session',
  :secret      => 'f1f7d01f23e45db0ff9f14d46fc36d2e1c2f736f44c088ba0c7108c1d9720f9aa48b61f54657abebe903d67abb20f90e89a7549c2c69d9dd1fe7275bbb385f73'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

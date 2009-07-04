# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_audiator_session',
  :secret      => '273253d24d97ac9766a47571b8e5418e7586c64bcb689be2aff7c4b8d287cf0c75365b4ba4161b71761498f496e913b9ffc49386b901cb8a36d02319986269d8'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

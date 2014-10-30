# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_egzaminator_ror_session',
  :secret      => '4fe160fde53ae35db7d51b181abb480067aa71de2235fbd859673ac136a2fd2fd582f7e2daaff50d9520d54f2899d2d1db9246b28f8c5df3e691cfabae4b2cbd'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

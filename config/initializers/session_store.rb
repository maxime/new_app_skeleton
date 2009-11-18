# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_sofa_session',
  :secret      => 'efa9b595278a1067127dbde84f87ae2a227d2f2b00faaf9809d8431da27cc6a28db083ade20f78552ca685ce3415a679a653d49bd897814a79506df00c0e5829'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

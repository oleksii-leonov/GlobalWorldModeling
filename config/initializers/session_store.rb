# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_world_session',
  :secret      => '3185469d129280823ebc37e017f5b44dddd5ce8dbf778d5f7105b04f4bce407f05c31c79d55f9e20289c85b3ac3f83cbcb934d344f5e5ebe20e1054898e9475d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

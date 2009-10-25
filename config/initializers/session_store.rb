# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_listode_session',
  :secret      => 'bf2da1f63747b5a144499cbf8bfeeb366ec49c085762d65faafb0ede3cea144bdb4d749300f990d824cfc98b8b68a74167f997787b59c7ccf082785e60e18212'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

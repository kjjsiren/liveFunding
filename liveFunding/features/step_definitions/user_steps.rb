require 'uri'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require 'lib/user_authentication.rb'
include UserAuthentication

Given /^I am logged_in$/ do
  authenticated_user = User.authenticate('test', '12345')
  log_user_in(authenticated_user)
end
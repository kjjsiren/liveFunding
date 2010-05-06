require 'uri'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require 'lib/user_authentication.rb'
include UserAuthentication

Given /^\/\^on failure save_and_open_page\$\/$/ do
    save_and_open_page
    raise
end

Given /^I fill in the amount "([^\"]*)"$/ do |arg1|
  fill_in "transaction[amount]", :with => arg1
end

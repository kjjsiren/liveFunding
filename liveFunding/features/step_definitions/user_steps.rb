require 'uri'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require 'lib/user_authentication.rb'
include UserAuthentication

Given /^I am logged_in$/ do
  @current_user = User.create!(
    :firstname => 'quentin',
    :email => 'joe@shmoe.com',
    :username => 'test',
    :password => '12345',
    :password_confirmation => '12345')

   begin
     visit "/"
     fill_in("user[username]", :with => "test")
     fill_in("user[password]", :with => "12345") 
     post session_path, :user=>{:username => "test", :password=>"12345"}
    rescue
      save_and_open_page
   raise
 end
end
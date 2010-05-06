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

Given /^I am logged_in as "([^\"]*)" with password "([^\"]*)"$/ do |user, password|
  visit "/"
  post session_path, :user=>{:username=>user, :password=>password}
end  

When /^I click the create_button$/ do
    begin
      post users_path, :user=>{:firstname => "john",
                               :lastname => "Scott",
                               :email => "john@me.com",
                               :username => "john",
                               :password => "12345",
                               :password_confirmation => "12345"}
    rescue
      save_and_open_page
    raise  
  end    
end  

When /^I go to my profile$/ do
  @current_user = User.find_by_username("test")
  id = @current_user.id
  visit "/users/"+id.to_s+"/edit/"  
end  
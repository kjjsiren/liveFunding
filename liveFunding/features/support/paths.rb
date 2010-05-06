module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name
    
    when /the home\s?page/
      '/'
      
    when /home_page/i
      root_path
 
    when /new_entity_path/
      '/entities/new'

    when /entity_info_path/
      '/entities'
    
    when /profile_editing_page/i
      edit_user_path
    
    when /registration_page/i
      new_user_path 
    
    when /comment_new_page/i
      new_transaction_comment_path
    
    when /transactions_listing_page/i
      transactions_path

	  when /transaction_page/i
		  transactions_path

	  when /amount_page/i
		  transactions_path

	  when /from_page/i
		  transactions_path

	  when /to_page/i
		  transactions_path	
	
	  when /createtime_page/i
		  transactions_path	
	
	  when /transactions_listing_page/i
      transactions_path
    
      when /transaction_show_page/i
        transaction_path
      
      when /^(.*) transaction_show_page$/i
        transaction_path(Transaction.find_by_id($1))

    when /transactions_show_page/i
      transactions_path
      
    when /user_edit_profile_page/i
      edit_user_path  

        
>>>>>>> c99f7186cac44368f88b4f8052e4459e24b5c226
    
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)

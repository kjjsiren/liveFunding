# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  include UserAuthentication # /lib/user_authentication.rb
  
    def page_generation_timestamp
      Time.now.strftime("%d.%m.%Y %H:%M")
    end

    def current_user_id
      session[:user_id]
    end
    
    def is_a_number?(s)
      s.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
    end
    
    def date_in_finnish_format(date)
      date.strftime("%d.%m.%Y")
    end
end

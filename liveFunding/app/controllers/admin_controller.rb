class AdminController < ApplicationController
  helper :all # include all helpers, all the time
 
  before_filter :is_authenticated?

  
  layout "admin"
  
  def index
  end
  
  def is_authenticated?
     if logged_in? and is_admin?
       return true
     else
       redirect_to root_path
       flash[:error] = "Insufficient rights to the admin control panel"
     end
   end
  
  
  def export_db
    `sqlite3 db/development.sqlite3 .dump .quit >> export.sqlite.sql` 
    send_file "export.sqlite.sql"
   end
  
  def import_db
    
    `sqlite3 db/development.sqlite3 < export.sqlite.sql`
    
    render :action => "index"
    flash[:notice] = "Import complete"
  end
  
  end

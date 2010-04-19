class AdminController < ApplicationController
  helper :all # include all helpers, all the time
 
 
  layout "admin"
  
  def index
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

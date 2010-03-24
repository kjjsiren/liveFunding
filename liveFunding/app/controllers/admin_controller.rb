class AdminController < ApplicationController
  helper :all # include all helpers, all the time
 
 
  layout "admin"
  
  def index
  end
  
  def export_db
    db_file = sqlite3 db/development.sqlite3 .dump .quit >> export.sqlite.sql
    send_file db_file 
   end
  
  
  end

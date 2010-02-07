class CommentsController < ApplicationController
  
  def index
      @transactions = Transaction.comments.find(:all)  
      respond_to do |format| 
        format.html # index.html.erb  
      end 
  end
  
  def new
  end
  
  def edit
  end
  
  def destroy
  end
  
  def show
  end        
  
end

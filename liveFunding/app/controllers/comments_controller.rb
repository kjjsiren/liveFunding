class CommentsController < ApplicationController
  
  #Create a new comment for the ID-specified transaction. If succesful redirect to
  #show the transaction and its comments:
  def create
     @transaction = Transaction.find(params[:transaction_id])
     @comment = @transaction.comments.build(params[:comment])
        if @comment.save
          redirect_to transaction_url(@transaction) 
        else  
          render :action => "new"
        end 
  end
  
  def new
    @transaction = Transaction.find(params[:transaction_id]) 
    @comment = @transaction.comments.build 
  end
  
  #Edit a comment:
  def edit
    @transaction = Transaction.find(params[:transaction_id])
    @comment = @transaction.comments.find(params[:id]) 
  end
  
  #Update a edited comment:
  def update
    @transaction = Transaction.find(params[:transaction_id])
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(params[:comment])
        redirect_to transaction_url(@transaction)
    else
      render :action => "edit"
    end 
  end
  
  #Deletes the ID-specified comment:
  def destroy
    @transaction = Transaction.find(params[:transaction_id])
    @comment = Comment.find(params[:id]) 
    @comment.destroy 
    respond_to do |format| 
      format.html { redirect_to transaction_path(@transaction) }
      format.xml { head :ok } 
    end 
  end 
  
  #Show a single comment belonging to a specified transaction:
  def show
    @transaction = Transaction.find(params[:transaction_id]) 
    @comment = @transaction.comments.find(params[:id])
  end        
  
end

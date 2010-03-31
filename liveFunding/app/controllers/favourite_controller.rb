class FavouriteController < ApplicationController
  
  before_filter :is_authenticated?
  
  # Enables user to favourite a transaction:
  def favourite_transaction
    #Get user_id from session and transaction_id from params.
    @user = User.find_by_id(session[:user_id])
    @transaction = Transaction.find_by_id(params[:id])
       
    @user.transactions <<  @transaction
    
    respond_to do |format|
      if @user.save
        flash[:notice] = I18n.t('flash.favourite.added')
        format.html { redirect_to(transactions_url) }
        format.xml  { head :ok }
      else 
        flash[:notice] = I18n.t('flash.favourite.fail')
        format.html { redirect_to(transactions_url) }
      end    
    end
  end  
  
  # Deletes the transaction from user's favourites:
  def delete_from_favourites  
   @user = User.find_by_id(session[:user_id])
   @favourite = @user.transactions.find(params[:id])
   @user.transactions.delete(@favourite) 
    
    respond_to do |format|
     flash[:notice] = I18n.t('flash.favourite.deleted')
     format.html { redirect_to(transactions_url) }
     format.xml  { head :ok }
    end
  end
   
end

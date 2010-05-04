class InformationSourceController < ApplicationController
  
  def incr_rank
    @information_source = InformationSource.find(params[:id])
    @information_source.rank = @information_source.rank==nil ? 1 : @information_source.rank+1
    @information_source.save!()
    #raise params.inspect
    respond_to do |format|
      format.html { redirect_to(transaction_url(@information_source.transaction_id)) }
      format.xml  { head :ok }
    end
  rescue
    flash[:notice] = I18n.t('flash.transactions.invalid_id')
    redirect_to :action => "index"
  end  
    
  def decr_rank
    @information_source = InformationSource.find(params[:id])
    if @information_source.rank != 0
      @information_source.rank = @information_source.rank==nil ? 0 : @information_source.rank-1
    end
    
    @information_source.save!()
    #raise params.inspect
    respond_to do |format|
      format.html { redirect_to(transaction_url(@information_source.transaction_id)) }
      format.xml  { head :ok }
    end
  rescue
    flash[:notice] = I18n.t('flash.transactions.invalid_id')
    redirect_to :action => "index"
  end    
  
end

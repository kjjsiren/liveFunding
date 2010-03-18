class TransactionsController < ApplicationController
  #display all the transactions by default
  layout "application", :except => [ :export_csv ]
  
  def index
    @transactions = Transaction.all
    @transaction = Transaction.new
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @transactions }
    end
  end


  def new
    @transaction = Transaction.new
  
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @transaction }
    end
  end
  

  def create
    @transaction = Transaction.new(params[:transaction])
    
    respond_to do |format|
      if @transaction.save
       
        flash[:notice] = 'Transaction was successfully created.'
        format.html { redirect_to(@transaction) }
        format.xml  { render :xml => @transaction, :status => :created, :location => @transaction }
      else
         flash[:notice] = 'Transaction creation failed.'
        format.html { render :action => "new" }
        format.xml  { render :xml => @transaction.errors, :status => :unprocessable_entity }
      end
    end
  end
  

  def edit
    @transaction = Transaction.find(params[:id])
  end
  

  def update
    @transaction = Transaction.find(params[:id])

    respond_to do |format|
      if @transaction.update_attributes(params[:transaction])
        flash[:notice] = 'Transaction was successfully updated.'
        format.html { redirect_to(@transaction) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @transaction.errors, :status => :unprocessable_entity }
      end
    end
  end
  

  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to(transactions_url) }
      format.xml  { head :ok }
    end
  end
  

  def incr_rank
    @transaction = Transaction.find(params[:id])
    @transaction.rank = @transaction.rank==nil ? 1 : @transaction.rank+1
    @transaction.save!()
    #raise params.inspect
    respond_to do |format|
      format.html { redirect_to(transactions_url) }
      format.xml  { head :ok }
    end
  end
  
  
  def incr_ilike
    @transaction = Transaction.find(params[:id])
    @transaction.ilike = @transaction.ilike==nil ? 1 : @transaction.ilike+1
    @transaction.save!()

    respond_to do |format|
      format.html { redirect_to(transactions_url) }
      format.xml  { head :ok }
    end
  end
  
  
  def decr_rank
    @transaction = Transaction.find(params[:id])
    if @transaction.rank != 0
      @transaction.rank = @transaction.rank==nil ? 0 : @transaction.rank-1
    end
    
    @transaction.save!()
    #raise params.inspect
    respond_to do |format|
      format.html { redirect_to(transactions_url) }
      format.xml  { head :ok }
    end
  end  
  
  
  def decr_ilike
    @transaction = Transaction.find(params[:id])
    if @transaction.ilike != 0
      @transaction.ilike = @transaction.ilike==nil ? 0 : @transaction.ilike-1
    end
    
    @transaction.save!()
    #raise params.inspect
    respond_to do |format|
      format.html { redirect_to(transactions_url) }
      format.xml  { head :ok }
    end
  end
  
  
  def top
    @transactions = Transaction.top

    respond_to do |format|
      format.html # top.html.erb
      format.xml  { render :xml => @transactions }
    end
  end
  
  
  def fundtop
    @transactions = Transaction.fundtop

    respond_to do |format|
      format.html # top.html.erb
      format.xml  { render :xml => @transactions }
    end
  end
  
  def newsfeed
    @transactions = Transaction.newsfeed

    respond_to do |format|
      format.html # top.html.erb
      format.xml  { render :xml => @transactions }
    end
  end

  
  def show
    @transaction = Transaction.find(params[:id])
  end
  
  def search
    @transactions_from = Transaction.find(:all, :conditions => {:recipient => params[:transaction][:recipient]})
    @transactions_to = Transaction.find(:all, :conditions => {:donor => params[:transaction][:recipient]})
  end


  def export_csv
    #raise params.inspect
    @transactions = Transaction.find(:all)
    #raise f.inspect
    #respond_to do |format|
    #  format.html { redirect_to(transactions_url) }
    #  format.xml  { head :ok }
    #end
  end

	require 'faster_csv'
	
  def import_csv   
  n=0
		FasterCSV.parse(params[:transaction][:file],:headers=>false) do |row|
    	transaction = Transaction.new       
			transaction.amount = row[0]        
			rec = row[1]
			don = row[2]
			transaction.recipient = Entity.find(:first, :conditions =>"name = '#{rec}'")
			transaction.donor = Entity.find(:first, :conditions =>"name = '#{don}'")        
      if transaction.save  
         n=n+1  
         GC.start if n%50==0  
      end             
			flash.now[:notice]="CSV Import Successful"
		end
	end
end

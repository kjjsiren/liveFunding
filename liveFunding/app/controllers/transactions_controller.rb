class TransactionsController < ApplicationController
  #display all the transactions by default
	require 'faster_csv'
	require 'tempfile'

  layout "application", :except => [ :export_csv ]
  
  def index
    @transactions = Transaction.all
    sort_by = params[:sort_by]
    sort_order = params[:sort_order]
    if sort_by == "from"
      if sort_order == "0"
        @transactions = Transaction.find(:all, :order => '"from" DESC')
      else
        @transactions = Transaction.find(:all, :order => '"from" ASC')
      end
    end
    
    if sort_by == "amount"
      if sort_order == "0"
        @transactions = Transaction.find(:all, :order => 'amount DESC')
      else
        @transactions = Transaction.find(:all, :order => 'amount ASC')
      end
    end

    if sort_by == "to"
      if sort_order == "0"
        @transactions = Transaction.find(:all, :order => '"to" DESC')
      else
        @transactions = Transaction.find(:all, :order => '"to" ASC')
      end
    end
    
    if sort_by == "create_time"
      if sort_order == "0"
        @transactions = Transaction.find(:all, :order => 'created_at DESC')
      else
        @transactions = Transaction.find(:all, :order => 'created_at ASC')
      end
    end
    
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
  rescue
    flash[:notice] = I18n.t('flash.transactions.invalid_id')
    redirect_to :action => "index"  
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
  rescue
    flash[:notice] = I18n.t('flash.transactions.invalid_id')
    redirect_to :action => "index"  
  end
  

	# Increase the rank
  def incr_rank
    @transaction = Transaction.find(params[:id])
    @transaction.rank = @transaction.rank==nil ? 1 : @transaction.rank+1
    @transaction.save!()
    #raise params.inspect
    respond_to do |format|
      format.html { redirect_to(transactions_url) }
      format.xml  { head :ok }
    end
  rescue
    flash[:notice] = I18n.t('flash.transactions.invalid_id')
    redirect_to :action => "index"  
  end
  
  
  # Increase the ilike
  def incr_ilike
    @transaction = Transaction.find(params[:id])
    @transaction.ilike = @transaction.ilike==nil ? 1 : @transaction.ilike+1
    @transaction.save!()

    respond_to do |format|
      format.html { redirect_to(transactions_url) }
      format.xml  { head :ok }
    end
  rescue
    flash[:notice] = I18n.t('flash.transactions.invalid_id')
    redirect_to :action => "index"  
  end
  
  
  # Decrease the rank
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
  rescue
    flash[:notice] = I18n.t('flash.transactions.invalid_id')
    redirect_to :action => "index"  
  end  
  
  
  # Decrease the ilike
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
  rescue
    flash[:notice] = I18n.t('flash.transactions.invalid_id')
    redirect_to :action => "index"  
  end
  
  
  def top
    @transactions = Transaction.top

    respond_to do |format|
      format.html # top.html.erb
      format.xml  { render :xml => @transactions }
    end
  end
  
  
  # Show the top 10 transactions
  def fundtop
    @transactions = Transaction.fundtop

    respond_to do |format|
      format.html # top.html.erb
      format.xml  { render :xml => @transactions }
    end
  end
  
  # Show the newest transactions
  def newsfeed
    @transactions = Transaction.newsfeed

    respond_to do |format|
      format.html # top.html.erb
      format.xml  { render :xml => @transactions }
    end
  end

  
  def show
    @transaction = Transaction.find(params[:id])
  rescue
    flash[:notice] = I18n.t('flash.transactions.invalid_id')
    redirect_to :action => "index"  
  end
  
  def search
    find = Entity.find(:first, :conditions => {:name => params[:transaction][:donor]})
    @transactions_to = Transaction.find(:all, :conditions => {:recipient_id => find})
    @transactions_from = Transaction.find(:all, :conditions => {:donor_id => find})
    if @transactions_from.size == 0 && @transactions_to.size == 0
      flash[:error]="No results"
    end
  end


	# Export transactions to csv file
  def export_csv
    @outfile = "transactions_" + Time.now.strftime("%m-%d-%Y") + ".csv"
     @transactions = Transaction.find(:all)
     csv_string = ''
     @transactions.each do |transaction|
       csv_string += FasterCSV.generate do |csv|
         csv << [transaction.id, transaction.amount, transaction.created_at, transaction.updated_at, transaction.recipient.name, transaction.donor.name, transaction.rank, transaction.entity_id, transaction.ilike]
       end
     end
     send_data csv_string, :type => 'text/csv; charset=iso-8859-1; header=present',
     :disposition => "attachment; filename=#{@outfile}"
  end

	
	# Import csv file to transactions
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
      	 # Clean the waste  
         n=n+1  
         GC.start if n%50==0  
      end             
			flash.now[:notice]=I18n.t('transactions.importcsv.successful')
		end
	end
end

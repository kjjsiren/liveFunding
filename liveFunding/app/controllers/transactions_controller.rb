class TransactionsController < ApplicationController
  
	require 'faster_csv'
	require 'tempfile'

  layout "application", :except => [ :export_csv ]
  
  #Display all the transactions by default
  def index
    @transactions = Transaction.all
    sort_by = params[:sort_by]
    sort_order = params[:sort_order]
	message = String.new
    if sort_by == "from"
		message = "Transaction has been ranked by donor"
      if sort_order == "0"
        @transactions = Transaction.find(:all, :include => :donor, :order =>"entities.name DESC")
      else
         @transactions = Transaction.find(:all, :include => :donor, :order =>"entities.name ASC")
      end
    end
    
    if sort_by == "amount"
		message = "Transaction has been ranked by amount"
      if sort_order == "0"
        @transactions = Transaction.find(:all, :order => 'amount DESC')
      else
        @transactions = Transaction.find(:all, :order => 'amount ASC')
      end
    end

    if sort_by == "to"
		message = "Transaction has been ranked by recipent"
      if sort_order == "0"
        @transactions = Transaction.find(:all, :include => :recipient, :order => "entities.name DESC")
      else
        @transactions = Transaction.find(:all, :include => :recipient, :order => "entities.name ASC")
      end
    end
    
    if sort_by == "create_time"
		message = "Transaction has been ranked by create time"
      if sort_order == "0"
        @transactions = Transaction.find(:all, :order => 'created_at DESC')
      else
        @transactions = Transaction.find(:all, :order => 'created_at ASC')
      end
    end
    
    respond_to do |format|
      flash[:notice] = message
	  format.html # index.html.erb
      format.rss
      format.xml  { render :xml => @transactions }
    end
  end

  #Display the form for a new transaction:
  def new
    @transaction = Transaction.new
    @inforomation_source = InformationSource.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @transaction }
    end
  end
  
  #Create a new transaction into the database:
  def create
    @transaction = Transaction.new(params[:transaction])
    
    #Associate the doning and receiving entities:
    @association = Association.new 
    @association.entity_id = params[:recipient_id] 
    @association.knows_entity_id = Entity.find(params[:transaction][:donor_id])
    @association.description = "Money transfer logged by the system" 
    @association.infosource = "liveFund" 
    @association.save 
    @association = Association.new 
    @association.entity_id = params[:donor_id]
    @association.knows_entity_id = Entity.find(params[:transaction][:recipient_id]) 
    @association.description = "Money transfer logged by the system" 
    @association.infosource = "liveFund" 
    @association.save
    
    creator_id = session[:user_id]
    if creator_id != nil
      @transaction.creator_id = creator_id
    end

    respond_to do |format|
      if @transaction.save
        @information_source = InformationSource.new(params[:information_sources])
        @information_source.transaction_id = @transaction.id
        @information_source.save
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
  
  #Edit a transaction:
  def edit
    @transaction = Transaction.find(params[:id])
  rescue
    flash[:notice] = I18n.t('flash.transactions.invalid_id')
    redirect_to :action => "index"  
  end
  
  #Update the transaction model in the database:
  def update
    @transaction = Transaction.find(params[:id])
    respond_to do |format|
      if @transaction.update_attributes(params[:transaction])
            @information_source = InformationSource.find_by_transaction_id(@transaction.id)
            @information_source.source = params[:information_sources][:source]
            @information_source.rank = params[:information_sources][:rank]
            @information_source.save
        flash[:notice] = 'Transaction was successfully updated.'
        format.html { redirect_to(@transaction) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @transaction.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  #Delete the transaction from the database:
  def destroy
    @transaction = Transaction.find(params[:id])
    if @information_source = InformationSource.find_by_transaction_id(@transaction.id) != nil
      @information_source.destroy
    end  
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to(transactions_url) }
      format.xml  { head :ok }
    end
  rescue
    flash[:notice] = I18n.t('flash.transactions.invalid_id')
    redirect_to :action => "index"  
  end
  

	# Increase the rank of a transaction:
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
  
  
  # Increase the ilike:
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
  
  
  # Decrease the rank:
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
  
  
  # Decrease the ilike:
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

  #Show a single transaction:
  def show
    @user = User.find_by_id(session[:user_id])
    if(@user == nil)
      @user = User.new
    end
    @transaction = Transaction.find(params[:id])
    #@information_source = InformationSource.find(params[:id])
  rescue
    flash[:notice] = I18n.t('flash.transactions.invalid_id')
    redirect_to :action => "index"  
  end
  
  def search
    @entity = Entity.find(:first, :conditions => {:name => params[:transaction][:donor]})
    @transactions_to = Transaction.find(:all, :conditions => {:recipient_id => @entity})
    @transactions_from = Transaction.find(:all, :conditions => {:donor_id => @entity})
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
	
	
	# Only for test purpose
	include PageParser
	def test
    @test_str = get_all_pdfs

    respond_to do |format|
      format.html # test.html.erb
      format.xml  { render :xml => @transactions }
    end
  end
	
end


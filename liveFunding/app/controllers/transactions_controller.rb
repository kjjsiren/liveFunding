class TransactionsController < ApplicationController
  #display all the transactions by default
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
    to_entity_id = params[:transaction][:recipient]
    from_entity_id = params[:transaction][:donor]
    params[:transaction][:recipient] = Entity.find(params[:transaction][:recipient]).name
    params[:transaction][:donor] = Entity.find(params[:transaction][:donor]).name
    @transaction = Transaction.new(params[:transaction])
    
    respond_to do |format|
      if @transaction.save
        @association = Association.new
        @association.entity_id = to_entity_id
        @association.thirdpartyperson_id = Entity.find(from_entity_id).name
        @association.description = "Money transfer logged by the system"
        @association.infosource = "liveFund"
        @association.save
        @association = Association.new
        @association.entity_id = from_entity_id
        @association.thirdpartyperson_id = Entity.find(to_entity_id).name
        @association.description = "Money transfer logged by the system"
        @association.infosource = "liveFund"
        @association.save
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
    @transaction.decrease_rank
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

end

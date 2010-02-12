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
    @transaction = Transaction.new(params[:transaction])

    respond_to do |format|
      if @transaction.save
        flash[:notice] = 'Transaction was successfully created.'
        format.html { redirect_to(@transaction) }
        format.xml  { render :xml => @transaction, :status => :created, :location => @transaction }
      else
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
    @transaction.increment_rank
  end
  
  def decr_rank
    transaction = Transaction.find(params[:id])
    transaction.decrease_rank
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
    @transactions_from = Transaction.find(:all, :conditions => {:from => params[:transaction][:from]})
    @transactions_to = Transaction.find(:all, :conditions => {:to => params[:transaction][:from]})
  end

end

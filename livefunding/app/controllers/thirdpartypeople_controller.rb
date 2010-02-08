class ThirdpartypeopleController < ApplicationController
  # GET /thirdpartypeople
  # GET /thirdpartypeople.xml
  def index
    @thirdpartypeople = Thirdpartyperson.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @thirdpartypeople }
    end
  end

  # GET /thirdpartypeople/1
  # GET /thirdpartypeople/1.xml
  def show
    @thirdpartyperson = Thirdpartyperson.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @thirdpartyperson }
    end
  end

  # GET /thirdpartypeople/new
  # GET /thirdpartypeople/new.xml
  def new
    @thirdpartyperson = Thirdpartyperson.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @thirdpartyperson }
    end
  end

  # GET /thirdpartypeople/1/edit
  def edit
    @thirdpartyperson = Thirdpartyperson.find(params[:id])
  end

  # POST /thirdpartypeople
  # POST /thirdpartypeople.xml
  def create
    @thirdpartyperson = Thirdpartyperson.new(params[:thirdpartyperson])

    respond_to do |format|
      if @thirdpartyperson.save
        flash[:notice] = 'Thirdpartyperson was successfully created.'
        format.html { redirect_to(@thirdpartyperson) }
        format.xml  { render :xml => @thirdpartyperson, :status => :created, :location => @thirdpartyperson }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @thirdpartyperson.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /thirdpartypeople/1
  # PUT /thirdpartypeople/1.xml
  def update
    @thirdpartyperson = Thirdpartyperson.find(params[:id])

    respond_to do |format|
      if @thirdpartyperson.update_attributes(params[:thirdpartyperson])
        flash[:notice] = 'Thirdpartyperson was successfully updated.'
        format.html { redirect_to(@thirdpartyperson) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @thirdpartyperson.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /thirdpartypeople/1
  # DELETE /thirdpartypeople/1.xml
  def destroy
    @thirdpartyperson = Thirdpartyperson.find(params[:id])
    @thirdpartyperson.destroy

    respond_to do |format|
      format.html { redirect_to(thirdpartypeople_url) }
      format.xml  { head :ok }
    end
  end
end

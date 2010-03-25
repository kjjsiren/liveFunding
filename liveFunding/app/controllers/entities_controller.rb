class EntitiesController < ApplicationController
  
  #List all the entities including entity name, leader, email, phone
  #descriptions and the association with other entities
  def index
    @entities = Entity.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @entities }
    end
  end
  
  #Show the entity information 
  def show
     @entity = Entity.find(params[:id]) 
       respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @entity }
    end
  end
  
  #create a new entity
  def new
    @entity = Entity.new
#    @entity = @transaction.entities.build 
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @entity }
    end
  end
  
    def create
    @entity = Entity.new(params[:entity])
    #@entity = @transaction.entities.build(params[:entity])
    respond_to do |format|
      if @entity.save
        flash[:notice] = 'Entity was successfully created.'
        format.html { redirect_to(@entity) }
        format.xml  { render :xml => @entity, :status => :created, :location => @entity }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @entity.errors, :status => :unprocessable_entity }
      end
    end
  end  
  
  #Edit the entity
  def edit
    @entity = Entity.find(params[:id])
   #@entity = @transaction.entities.find(params[:id]) 
  end
 
  #Update an edited entity  
  def update
   @entity = Entity.find(params[:id])
    respond_to do |format|
      if @entity.update_attributes(params[:entity])
        flash[:notice] = 'Entity was successfully updated.'
        format.html { redirect_to(@entity) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @entity.errors, :status => :unprocessable_entity }
      end
    end
  end

  #Delete the entity
  def destroy
	  @entity = Entity.find(params[:id]) 
    @entity.destroy 
    respond_to do |format|
      format.html { redirect_to(entities_url) }
      format.xml  { head :ok }
    end
  end
end

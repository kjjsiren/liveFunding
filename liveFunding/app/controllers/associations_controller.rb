class AssociationsController < ApplicationController
  #Create a new association 
  def create
     @entity = Entity.find(params[:entity_id])
     @association = @entity.associations.build(params[:id])
        if @association.save
          flash[:notice] = "A new association was added."
          redirect_to entity_url(@entity) 
        else
          flash[:notice] = "Invalid association"  
          render :action => "new"
        end 
  end
  
  def new
    @entity = Entity.find(params[:entity_id]) 
    @association = @entity.associations.build 
  end
  
  #Edit
  def edit
    @entity = Entity.find(params[:entity_id])
    @association = @transaction.associations.find(params[:id]) 
  end
  
  #Update a edited association:
  def update
    @entity = Entity.find(params[:entity_id])
    @association = Association.find(params[:id])
    if @association.update_attributes(params[:association])
      flash[:notice] = "Association succesfully updated."
      redirect_to association_url(@association)
    else
      flash[:notice] = "Invalid association"
      render :action => "edit"
    end 
  end
  
  #Deletes the ID-specified association:
  def destroy
    @entity = Entity.find(params[:entity_id])
    @association = Association.find(params[:id]) 
    @association.destroy 
    respond_to do |format|
      flash[:notice] = "Association succesfully deleted." 
      format.html { redirect_to association_path(@association) }
      format.xml { head :ok } 
    end 
  end 
  
  #Show a single association belonging to a specified entity:
  def show
    @entity = Entity.find(params[:entity_id]) 
    @association = @entity.associations.find(params[:id])
  end  
end

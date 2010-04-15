class AssociationsController < ApplicationController
  #Create a new association 
  def create
  	     @entity = Entity.find(params[:entity_id])
  	     @association = Association.new(params[:association])
  	     @association.entity_id = params[:entity_id]
  	        if @association.save
  	          flash[:notice] = "A new association created"
  	          @reverse_association = Association.new(params[:association])
        	    @reverse_association.entity_id = params[:association][:knows_entity_id]
        	    @reverse_association.knows_entity_id = params[:entity_id]
              if @reverse_association.save
  	            flash[:notice] = "A new association created between both entities."
              end
  	          redirect_to entity_url(@entity)
  	        else
  	          flash[:notice] = "Creation of association failed" 
  	          render :action => "new"
  	        end 
  	  end
  	  
  	  
  # Is this assocation already in the database?
  def is_assoc_exist(id_1, id_2)
    b_exist = false
    @association = Association.find(id])
    
  end

  
  # New an association
  def new
    @entity = Entity.find(params[:entity_id])
    @association = Association.new 
  end
  
  #Edit
  def edit
    @entity = Entity.find(params[:entity_id])
    @association = @transaction.associations.find(params[:id]) 
  end
  
  # Update a edited association:
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
  
  # Deletes the ID-specified association:
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
  
  # Show a single association belonging to a specified entity:
  def show
    @entity = Entity.find(params[:entity_id]) 
    @association = @entity.associations.find(params[:id])
        @test = Association.find(id])
  end  
end

 class AssociationsController < ApplicationController
  #Create a new association 
  def create
  	     @entity = Entity.find(params[:entity_id])
  	     @association = Association.new(params[:association])
  	     @association.entity_id = params[:entity_id]
  	       if is_assoc_exist(@entity, @association)
	              flash[:notice] = "Association already exists"
                redirect_to entity_url(@entity)
	         end
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
  	  
  	  
  # Is this association already in the database?
  # Parameters:
  # e_id -> entity_id
  # k_id -> knows_entity_id
  def is_assoc_exist(e_id, k_id)
    return Association.exists?(:entity_id => e_id, :knows_entity_id => k_id)
  end

  
  # New association
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
  end  
end

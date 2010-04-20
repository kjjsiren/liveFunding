class EntitiesController < ApplicationController
  #layout "application", :except => [:new_ajax]
  
  #List all the entities including entity name, leader, email, phone
  #descriptions and the association with other entities
  $associations_list = Association.all
  
  def index
    @entities = Entity.all(:order =>"name")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @entities }
    end
  end
  
  #Show the entity information 
  def show
     @entity = Entity.find(params[:id]) 
     id = @entity.id
     @transactions_from = Transaction.find(:all, :conditions=>["donor_id = #{id}"])
     @transactions_to = Transaction.find(:all, :conditions=>["recipient_id = #{id}"])

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
  
  #create a new entity
  def new_ajax
    @entity = Entity.new
    render :layout => false
  end
  
  def create
    @entity = Entity.new(params[:entity])
    #@entity = @transaction.entities.build(params[:entity])
    respond_to do |format|
      if @entity.save
        flash[:notice] = 'Entity was successfully created.'
        if params[:from_ajax] == '0'
          format.html { redirect_to(@entity) }
          format.xml  { render :xml => @entity, :status => :created, :location => @entity }
        else
          format.html { render :action => "new_ajax", :layout => false }
          format.xml  { render :xml => @entity, :status => :created, :location => @entity }
        end
      else
        if params[:from_ajax] == '0'
          format.html { render :action => "new" }
          format.xml  { render :xml => @entity.errors, :status => :unprocessable_entity }
        else
          format.html { render :action => "new_ajax", :layout => false }
          format.xml  { render :xml => @entity.errors, :status => :unprocessable_entity }
        end
      end
    end
  end  
  
  
  #Edit the entity
  def edit
    @entity = Entity.find(params[:id])
   #@entity = @transaction.entities.find(params[:id]) 
  end
 
  def map
    @entity = Entity.find(params[:id])
    data = File.new("public/javascripts/mapJs/data.js", "w")
    beginning = "var Log = {
        elem: false,
        write: function(text){
            if (!this.elem) 
                this.elem = document.getElementById('log');
            this.elem.innerHTML = text;
            this.elem.style.left = (500 - this.elem.offsetWidth / 2) + 'px';
        }
    };

    function addEvent(obj, type, fn) {
        if (obj.addEventListener) obj.addEventListener(type, fn, false);
        else obj.attachEvent('on' + type, fn);
    };


    function init(){
        //init data
        var json = {
          \"id\": \"#{@entity.id}\",
          \"name\": \"#{@entity.name}\",
          \"children\": ["
    $association_list = Association.all
    children = childgenerator(@entity, 3)

     
    ending =  "\t\t\t\t], \n\t\t\t\t\"data\": []
     };
        //end
        var infovis = document.getElementById('infovis');
        var w = infovis.offsetWidth - 50, h = infovis.offsetHeight - 50;

        //init canvas
        //Create a new canvas instance.
        var canvas = new Canvas('mycanvas', {
            'injectInto': 'infovis',
            'width': w,
            'height': h
        });
        //end
        var style = document.getElementById('mycanvas').style;
        style.marginLeft = style.marginTop = \"25px\";
        //init Hypertree
        var ht = new Hypertree(canvas, {
            //Change node and edge styles such as
            //color, width and dimensions.
            Node: {
                dim: 9,
                color: \"#f00\"
            },

            Edge: {
                lineWidth: 2,
                color: \"#088\"
            },

            onBeforeCompute: function(node){
                Log.write(\"centering\");
            },
            //Attach event handlers and add text to the
            //labels. This method is only triggered on label
            //creation
            onCreateLabel: function(domElement, node){
                domElement.innerHTML = node.name;
                addEvent(domElement, 'click', function () {
                    ht.onClick(node.id);
                });
            },
            //Change node styles when labels are placed
            //or moved.
            onPlaceLabel: function(domElement, node){
                var style = domElement.style;
                style.display = '';
                style.cursor = 'pointer';
                if (node._depth <= 1) {
                    style.fontSize = \"0.8em\";
                    style.color = \"#ddd\";

                } else if(node._depth == 2){
                    style.fontSize = \"0.7em\";
                    style.color = \"#555\";

                } else {
                    style.display = 'none';
                }

                var left = parseInt(style.left);
                var w = domElement.offsetWidth;
                style.left = (left - w / 2) + 'px';
            },

            onAfterCompute: function(){
                Log.write(\"done\");

                //Build the right column relations list.
                //This is done by collecting the information (stored in the data property) 
                //for all the nodes adjacent to the centered node.
                var node = Graph.Util.getClosestNodeToOrigin(ht.graph, \"pos\");
                var html = \"<h4>\" + node.name + \"</h4><b>Connections:</b>\";
                html += \"<ul>\";
                Graph.Util.eachAdjacency(node, function(adj){
                    var child = adj.nodeTo;
                    if (child.data) {
                        var rel = (child.data.band == node.name) ? child.data.relation : node.data.relation;
                        html += \"<li>\" + child.name + \" \" + \"<div class=\\\"relation\\\">(relation: \" + rel + \")</div></li>\";
                    }
                });
                html += \"</ul>\";
                document.getElementById('inner-details').innerHTML = html;
            }
        });

        //load JSON data.
        ht.loadJSON(json);
        //compute positions and plot.
        ht.refresh();
        //end
        ht.controller.onAfterCompute();
    }
  "
    data.puts(beginning)
    data.puts(children)
    data.puts(ending)
    data.close
    render :layout => false
  end
  
  def childgenerator(entity,times)
    @ent = Entity.find(entity)
    $associations_list.delete_if{|x| x.knows_entity == @ent}
    @associations = @ent.associations
    children =" "
     if @associations != nil #&& $associations_list.size >0 && $associations_list.include?(@associations.first) 
        children += "\t\t\t\t\n{\n"
        i = 0;
      for a in @associations do
         #if($associations_list.include?(a))
         if i > 0
           children += ",\n\t\t\t\t{\n"
         end
         children += "\t\t\t\t\"id\": \"" + (a.knows_entity.id).to_s + "\","
         children += "\n\t\t\t\t\"name\": \"" + a.knows_entity.name + "\","
         children += "\n\t\t\t\t\"data\": { \n\t\t\t\t\t\"band\": \"" + a.entity.name + "\"," 
         children += "\n\t\t\t\t\t\"relation\": \"" + a.description + "\"},"
         children += "\n\t\t\t\t\"children\": ["
         if times >= 0 
           children += childgenerator(a.knows_entity, times-1)
          end
          children+= "]\n\t\t\t\t}"
       
          i += 1
        end
     #  end
     end
     return children
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
  
  # Delete the image of the entity  
	def delete_image
    @entity = Entity.find(params[:entity])
    @entity.photo = nil
    @entity.save
    params[:id]=@entity.id
    redirect_to :back
  end
end

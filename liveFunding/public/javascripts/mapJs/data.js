var Log = {
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
          "id": "1",
          "name": "avc",
          "children": [
 				
{
				"id": "2",
				"name": "ddddd",
				"data": { 
					"band": "avc",
					"relation": "bbb"},
				"children": [ 				
{
				"id": "1",
				"name": "avc",
				"data": { 
					"band": "ddddd",
					"relation": "bbb"},
				"children": [ 				
{
				"id": "2",
				"name": "ddddd",
				"data": { 
					"band": "avc",
					"relation": "bbb"},
				"children": [ 				
{
				"id": "1",
				"name": "avc",
				"data": { 
					"band": "ddddd",
					"relation": "bbb"},
				"children": [ 				
{
				"id": "2",
				"name": "ddddd",
				"data": { 
					"band": "avc",
					"relation": "bbb"},
				"children": []
				}]
				}]
				}]
				}]
				}
				], 
				"data": []
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
        style.marginLeft = style.marginTop = "25px";
        //init Hypertree
        var ht = new Hypertree(canvas, {
            //Change node and edge styles such as
            //color, width and dimensions.
            Node: {
                dim: 9,
                color: "#f00"
            },

            Edge: {
                lineWidth: 2,
                color: "#088"
            },

            onBeforeCompute: function(node){
                Log.write("centering");
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
                    style.fontSize = "0.8em";
                    style.color = "#ddd";

                } else if(node._depth == 2){
                    style.fontSize = "0.7em";
                    style.color = "#555";

                } else {
                    style.display = 'none';
                }

                var left = parseInt(style.left);
                var w = domElement.offsetWidth;
                style.left = (left - w / 2) + 'px';
            },

            onAfterCompute: function(){
                Log.write("done");

                //Build the right column relations list.
                //This is done by collecting the information (stored in the data property) 
                //for all the nodes adjacent to the centered node.
                var node = Graph.Util.getClosestNodeToOrigin(ht.graph, "pos");
                var html = "<h4>" + node.name + "</h4><b>Connections:</b>";
                html += "<ul>";
                Graph.Util.eachAdjacency(node, function(adj){
                    var child = adj.nodeTo;
                    if (child.data) {
                        var rel = (child.data.band == node.name) ? child.data.relation : node.data.relation;
                        html += "<li>" + child.name + " " + "<div class=\"relation\">(relation: " + rel + ")</div></li>";
                    }
                });
                html += "</ul>";
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
  

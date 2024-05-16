// 마인드맵 생성 시작
var st = "";
function startMindMap(){
	//init Spacetree
	//Create a new ST instance
	st = new $jit.ST({
	    //id of viz container element
	    injectInto: 'global-mindmap-obj',
	    //set duration for the animation
	    duration: 500,
	    //set animation transition type
	    transition: $jit.Trans.Quart.easeInOut,
	    //set distance between node and its children
	    levelDistance: 60,
	    //enable panning
	    Navigation: {
	        enable:true,
	        panning:true
	    },
	    //set node and edge styles
	    //set overridable=true for styling individual
	    //nodes or edges
	    Node: {
	        width: 150,
	        height: 80,
	        type: 'rectangle',
	        color: '#aaa',
	        overridable: true
	    },
	    
	    Edge: {
	        type: 'bezier',
	        overridable: true,
	        color: '#99ccff'
	    },
	    
	    levelsToShow: 1,
	    
	    //This method is called on DOM label creation.
	    //Use this method to add event handlers and styles to
	    //your node.
	    onCreateLabel: function(label, node){
	    	 label.id = node.id;            
	        label.innerHTML = node.name;
		        
	    	var nodeData = _.find(mindmapData, {infsId:node.id});
	    	var parentData = null;
	    	if(nodeData){
	    		parentData = _.find(mindmapData, {infsId:nodeData.parInfsId});
	    	}
	
	        var style = label.style;
	        
	        label.onclick = function(){
	            _.forEach(st.labels.labels, function(value, key) {
	                if (value) {
	                    if ($(value).hasClass('depth' + node._depth)) {
	                    	 if (!$(value).is('.link')) {
	                    		 $(value).attr('title',$(value).text());
	                    	 }
		                	
	                        $(value).removeClass('active');
	                    }
	                }
	            });
	
	            $(label).addClass('active');
	            if (!$(label).is('.link')) {
	            	 $(label).attr('title',$(label).text() + ' 선택됨');
	            }
	           
	            if (node.data.infoPopup && node.data.infoPopup.url) {
	                if (node.data.infoPopup.target === 'new') {
	                	
	                	var popWidth = $(window).width();
	                	var popHeight = $(window).height();

	                    //window.open(node.data.infoPopup.url, 'popup', 'width=' + popWidth + ', height=' + popHeight + ', menubar=no, status=no, toolbar=no, scrollbars=1');
	                    window.open(node.data.infoPopup.url, 'mindMapPopup');
	                    return;
	                } else {
	                    location = node.data.infoPopup.url;
	                }
	                st.onClick(node.id);
	            } else {
	            	st.onClick(node.id);
	            }
	        };
	
	        if (node._depth === 0) {
	            //set label styles     
	
	        	node.data.width = 170;
	        	node.data.height = 191;
	        	
	            style.width = node.data.width + 'px';
	            style.height = node.data.height + 'px';            
	            style.cursor = 'pointer';
	            style.color = 'transparent';
	            style.fontSize = '1.2em';
	            style.textAlign= 'center';
	            style.border = 'none';
	            // style.backgroundImage = 'url(' + node.data.bg + ')';
	            // style.backgroundRepeat = 'no-repeat';
	            
	            label.innerHTML = '<img src="' + node.data.bg + '" style="width:px' + node.data.width + '; height:' + node.data.height + 'px;" alt="열린국회정보">';
	            label.setAttribute('tabIndex', 0);
	            label.setAttribute('title', node.name);
	        } else if (node._depth === 1) {
	            $(label).addClass('depth1');
	
	            style.backgroundColor = node.data.bgColor;
	
	            label.setAttribute('tabIndex', 0);
	            label.setAttribute('title', node.name);
	            
	            if (node.data.infoPopup) {
	            	$(label).addClass('link');
		            label.setAttribute('title', '새창열림-'+node.name);
	            } else {
	            	$(label).removeClass('link');
		            label.setAttribute('title',node.name);
	            }
	        }
	        else if (node._depth === 2) {
	            $(label).addClass('depth2');
	
	            label.setAttribute('tabIndex', 0);
	            label.setAttribute('title', node.name);
	
	            // if (node.selected) {
	            //     console.log('aa');
	            // }
	            if (node.data.infoPopup) {
	            	$(label).addClass('link');
		            label.setAttribute('title', '새창열림-'+node.name);
	            } else {
	            	$(label).removeClass('link');
		            label.setAttribute('title',node.name);
	            }
	        } else if (node._depth > 2) {
	        	if (node._depth === 3) {
	        		$(label).addClass('depth3');	
	        	} else {
	        		$(label).addClass('depth4');
	        	}
	            
//	            setTimeout(function() {
//	            	$(label).fitText();
//	            }, 0);
	
	            if (node.data.infoPopup) {
	            	$(label).addClass('link');
		            label.setAttribute('title', '새창열림-'+node.name);
	            } else {
	            	$(label).removeClass('link');
		            label.setAttribute('title',node.name);
	            }
	
	            label.setAttribute('tabindex', 0);
	        }
//	        console.log(nodeData);
//	        console.log(parentData);
//	        console.log(node);
	        if(nodeData && parentData){
	        	if(nodeData['vOrder'] == 1){
	        		$('#global-mindmap-obj-label').append('<h'+(nodeData['Level']+1)+' style="position:absolute;top:-99999px;left:-99999px;">'+ parentData['infsNm'] +' 목록</h'+(nodeData['Level']+1)+'>')
	        		//if(!$('#label-'+parentData['infsNm']).size() < 1){
	        			//$('#global-mindmap-obj-label').append('<h'+(nodeData['Level']+1)+' style="" id="label-'+ parentData['infsId'] +'">'+ parentData['infsNm'] +' 목록</h'+(nodeData['Level']+1)+'>')
	        		//}
	        		
	        	}
	        }
	    },
	    
	    //This method is called right before plotting
	    //a node. It's useful for changing an individual node
	    //style properties before plotting it.
	    //The data properties prefixed with a dollar
	    //sign will override the global node style properties.
	    onBeforePlotNode: function(node){
	        // if (node.id === 'root') {
	        //     node.setPos(new $jit.Complex(-50, -100), 'start');
	        //     node.setPos(new $jit.Complex(-50, -100), 'end');
	        //     node.setPos(new $jit.Complex(-50, -100), 'current');
	        // }
	
	        if (node._depth === 0) {
	        	node.data.width = 170;
	        	node.data.height = 191;
	        	
	            node.data.$width = node.data.width;
	            node.data.$height = node.data.height;
	
	            node.eachSubnode(function(n) {
	                n.setData('width', 150, 'start');
	                n.setData('width', 150, 'end');
	                n.setData('height', 80, 'start');
	                n.setData('height', 80, 'end');
	            });
	        } else if (node._depth === 1) {
	            node.setData('width', 150, 'start');
	            node.setData('width', 150, 'end');
	            node.setData('height', 80, 'start');
	            node.setData('height', 80, 'end');
	
	            node.eachSubnode(function(n) {
	                n.setData('width', 150, 'start');
	                n.setData('width', 150, 'end');
	                n.setData('height', 50, 'start');
	                n.setData('height', 50, 'end');
	            });
	        }
	        else if (node._depth >= 3) {
	           node.data.$width = 170;
	           node.data.$height = 50;
	
	           node.eachSubnode(function(n) {
	               n.setData('width', 170, 'start');
	               n.setData('width', 170, 'end');
	               n.setData('height', 50, 'start');
	               n.setData('height', 50, 'end');
	           });
	        }
	        else if (node._depth >= 2) {
	           node.data.$width = 150;
	           node.data.$height = 50;
	
	           node.eachSubnode(function(n) {
	               n.setData('width', 150, 'start');
	               n.setData('width', 150, 'end');
	               n.setData('height', 50, 'start');
	               n.setData('height', 50, 'end');
	           });
	        }
	
	        node.data.$color = 'transparent';
	        
	        /*
	        //add some color to the nodes in the path between the
	        //root node and the selected node.
	        if (node.selected) {
	            node.data.$color = "#ff7";
	        }
	        else {
	            delete node.data.$color;
	            //if the node belongs to the last plotted level
	            if(!node.anySubnode("exist")) {
	                //count children number
	                var count = 0;
	                node.eachSubnode(function(n) { count++; });
	                //assign a node color based on
	                //how many children it has
	                node.data.$color = '#f2f2f2';                    
	            }
	        }
	        */
	    },
	    
	    //This method is called right before plotting
	    //an edge. It's useful for changing an individual edge
	    //style properties before plotting it.
	    //Edge data proprties prefixed with a dollar sign will
	    //override the Edge global style properties.
	    onBeforePlotLine: function(adj){
	        // https://philogb.github.io/jit/static/v20/Docs/files/Options/Options-Edge-js.html
	        if (adj.nodeTo._depth === 1) {
	            adj.data.$type = 'arrow';
	        }
	
	        if (adj.nodeFrom.selected && adj.nodeTo.selected) {
	            adj.data.$color = "#fff32e";
	            adj.data.$lineWidth = 3;
	        }
	        else {
	            delete adj.data.$color;
	            delete adj.data.$lineWidth;
	        }
	    }
	});
}


// 차트 생성 끝

// 차트의 노드에 포커스가 갔을 때 엔터키를 치면 클릭 이벤트 발생시킴
$(document).on('keyup', '.node', function(e) {
    if (e.keyCode === 13) {
        $(this).trigger('click');
    }
});


// 초기화 버튼 클릭
$('#reset').on('click', function() {
    st.onClick(st.root);
});
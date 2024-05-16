/**
 * 마인드맵 데이터 로드
 * 
 * @param data {Array} 데이터
 */
var data = {
		id: 'root',
		name: '열린국회정보',
		data: {
	        width: 212,
	        height: 239,
	        bg: com.wise.help.url("/img/Jit/menu_1depth.png")
	    },
		children: []
};

var nodeCnt = 0;
var mindmapData = null;

function loadMindMap() {
    // 데이터를 검색한다.
	$.ajax({
		type : 'POST',
		dataType : 'json',
		async : false,
		url : com.wise.help.url("/portal/stat/searchOpenDsCate.do"),
		success : function(res) {
			var menuData = res.data;
			mindmapData = menuData;
			make1LevelData(menuData);
			
		},
		complete : function() {
			//load json data
			st.loadJSON(data);
			//compute node positions and layout
			st.compute();
			//optional: make a translation of the tree
			st.geom.translate(new $jit.Complex(-200, 0), "current");
			//emulate a click on the root node.
			st.onClick(st.root);
			//end
	    }

	});
	
}

function make1LevelData(menuData) {

	var dataCnt = 1;
	$.each(menuData, function(key, value){
		var menuObj = new Object();
		if(value.parInfsId == "T"){
			
			menuObj.id = value.infsId;
			menuObj.name = value.infsNm;
			menuObj.data = obj1LevelData(dataCnt);
			menuObj.children = makeChildren(menuData, value.infsId);
			data.children.push(menuObj);
			dataCnt++;
		}
		
	});
}

function obj1LevelData(cnt){
	var dataObj = new Object();
	dataObj.width = 200;
	dataObj.height = 68;
	if(cnt==1) dataObj.bgColor = "#004E9D";
	if(cnt==2) dataObj.bgColor = "#438db8";
	if(cnt==3) dataObj.bgColor = "#259c98";
	if(cnt==4) dataObj.bgColor = "#438db8";
	if(cnt==5) dataObj.bgColor = "#004E9D";
	if(cnt==6) dataObj.bgColor = "#438db8";
	if(cnt==7) dataObj.bgColor = "#259c98";
	if(cnt==8) dataObj.bgColor = "#438db8";
	if(cnt==9) dataObj.bgColor = "#004E9D";
	if(cnt>=10) dataObj.bgColor = "#259c98";
	
	return dataObj;
}

function makeChildren(menuData, parInfsId) {

	var menuArr = new Array();
	$.each(menuData, function(key, value){
		var menuObj = new Object();
		if(value.parInfsId == parInfsId){
			menuObj.name = value.infsNm;
			
			if(value.leaf === 0){
				menuObj.id = value.infsId;
				menuObj.data = {};
				menuObj.children = makeChildren(menuData, value.infsId);
			}else{
				//menuObj.id = nodeCnt + "" + value.infsId;
				menuObj.id = value.infsId;
				menuObj.data = {infoPopup: {
					                        			url: com.wise.help.url(value.infsUrl),
					                        			target: 'new'
													  }
									   };
				menuObj.children = [];
				nodeCnt++; //id값에 중복된 값이 들어가지 않도록 하기 위해 처리
			}
			menuArr.push(menuObj);
		}
	});
	
	return menuArr;
}
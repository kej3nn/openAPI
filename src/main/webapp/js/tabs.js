var tabMiunsSize = 55;    

function OpenTab(tabId,tabContentClass,tabBody){
	if($("."+tabContentClass).length < 2){                                                        
		alert(tabContentClass+"는 반드시 2개 이상이어야 합니다.");
	}                                                       
	this.TabId  = tabId; //탭 객체 id
	this.TabContentClass = tabContentClass; //탭 내용 class id
	this.TabTemplate = "<li class='on'><a href='#' id='#{href}' name='tab-a' title='#{label}'>#{label}</a> <a href='#' class='tab_close'>x</a></li>";
	this.TabData =""; // 탭추가시 조회 변수
	this.TabName =""; // 탭이름
	this.LabelObj =""; // show 라벨 오브젝트                             
	this.ContentObj =""; // show 내용 오브젝트                    
	this.Tabmap = new Map(); //탭 맵객체 생성                       
	this.TabBody = tabBody;    
	this.TabObj;                
	$("."+this.TabContentClass).eq(0).attr("name","tabs-Template");                                     
	$("."+this.TabContentClass).eq(1).attr("name","tabs-main");                               
	$("."+this.TabId).find("a").first().attr("title","전체목록").attr("name","tab-a").attr("id","tabs-main");
	$(".more_list").hover(                                                     
			function(){         
				$(".other_list").show();
			},               
			function(){     
				$(".other_list").hide();                                                                                     
			}
	);    
	$(".more").click(function(e) {
		$(".other_list").show();
		return false;                             
	});             
	$(".other_list").empty();             
}            
            
OpenTab.prototype ={
		setTabTemplate : function (tabTemplate) { //탭 템플릿 변경               
			this.TabTemplate = tabTemplate;
		}, 
		SetTabData : function (tabData) {  //조회변수 추가                           
			this.TabData = tabData;                              
		},                           
		addTab : function (id,title,url,callback) {   //탭추가     
			this.addProcess(id,title,url,callback);         
		}, 
		addRegTab : function (id,title,callback) {   //등록 탭 추가     
			this.addProcess(id,title,"",callback);
		},                       
		
		addProcess : function(id,title,url,callback){    
			//this.tabModalOpen;                                    
			this.TabName = "tabs-" + id;
			this.ContentObj = $("div[name="+this.TabName+"]");      
			$("."+this.TabId).find(".on").removeClass("on");         
			
			if ($("a[id="+this.TabName+"]").length == 0) {//탭이 존재하는지 확인    
				$(".all_list").after(this.TabTemplate.replace( /#\{href\}/g,this.TabName ).replace( /#\{label\}/g, XSSfilter(title) ) );
				var tabs = $("."+this.TabContentClass);          
				tabs.hide();                                             
				this.removeTab(tabs);                                               
				this.addContent();   
				if(url != ""){
					this.selectTabContent(url,callback);
				}else{
					callback(this.TabObj);                
				}
				this.addTabClickEvent();
				this.tabPutMap();             
			}else{                
				if($("a[id="+this.TabName+"]").parent().parent().attr("class") == "other_list"){
					var appendTab = $("a[id="+this.TabName+"]").parent().clone(true);         
					appendTab.addClass("on");            
					$(".all_list").after(appendTab);                                                                                                  
					$("a[id="+this.TabName+"]").parent().remove();    
					 addhideTab(this.TabId);                  
					 hideTab();
				}
				var divClass = this.TabContentClass;                                   
				$("."+divClass).hide();    
				this.tabGetMap(this.TabName);
				if(url == ""){                  
					$("div[name="+this.TabName+"]").find("input").val("");            
				}
				$("a[id="+this.TabName+"]").parent().addClass("on");  
				if(url == ""){                  
					callback(this.TabObj);                
				}                     
			}     
			this.LabelObj = $("a[id="+this.TabName+"]").parent(); //현재 탭 object 저장
			
		},
		                        
		addTabClickEvent: function(){     //탭 이벤트 추가   
			var tabId = $("."+this.TabId);
			var divClass = this.TabContentClass;       
			var tabObj = this.TabObj;        
			var tabALen = tabId.find("a[name=tab-a]").length -1;    
			if(tabALen > 1){ 
				tabALen = 1;           
			}
			tabId.find("a[name=tab-a]").eq(tabALen).click(function(e) {
				tabId.find(".on").removeClass("on");     
				var tabs = $("."+divClass);                                   
				tabs.hide();                                   
				tabObj.removeTab(tabs);                       
				tabObj.tabGetMap($(this).attr("id"));                 
				if($(this).parent().parent().attr("class") != "other_list"){  //숨김탭이 아니면
					if($(this).parent().attr("class") !="all_list"){ //전체목록제외
						$(this).parent().addClass("on");                                
					}
				}else{                           
					var appendTab = $(this).parent().clone(true); 
					appendTab.addClass("on");            
					$(".all_list").after(appendTab);                                                                                     
					$(this).parent().remove();          
					addhideTab(tabId);
					hideTab();
				}
				if(typeof(window["buttonEventAdd"]) == "function") { 
					buttonEventAdd();           
				}  
				return false;
			});                                                       
			tabId.find(".tab_close").eq(0).click(function(e) {      
				var tabs = $("."+divClass);             
				if($(this).parent().parent().attr("class") != "other_list"){ //다른 탭이 아니면                          
					tabObj.removeTab(tabs);           
					/* 탭이 2개 이상 오픈 된 상태에서 목록탭에서 탭을 닫는 경우 발생하는 오류 처리 */
					var moveTabid = "";
					
					if(tabId.find("li").length > 2){
						if($(this).parent().attr("class") != "on"){ //활성화 탭을 닫는 경우가 아닌경우
							tabId.find("li").each(function(index, item){
								if($(item).attr("class") == "on"){
									moveTabid = $(item).find("a[name=tab-a]").attr("id");
								}
							});
							if(moveTabid == "") moveTabid = "tabs-main";
						}else{
							moveTabid = $(this).parent().prev().find("a[name=tab-a]").attr("id");
						}
					}else{
						moveTabid = "tabs-main";
					}
					//tabObj.tabGetMap($(this).parent().prev().find("a[name=tab-a]").attr("id"));// 이전 a객체의 title
					
					tabObj.tabGetMap(moveTabid); // 이전 a객체의 title
					
					if($(this).parent().prev().attr("class") !="all_list"){ //전체목록제외
						if($(this).parent().attr("class") == "on"){             
							$(this).parent().prev().addClass("on");                                    
						}                                            
					}      
				}
				$(this).parent().remove();
				if($(this).parent().parent().attr("class") != "other_list"){  //다른 탭이 아니면
					$(this).parent().remove();
					var tabSize = 0;             
					var tabAllSize =tabId.width()-tabMiunsSize;                             
					tabId.find("li").each(function(index,item){ 
						tabSize +=$(item).width();
					});                                                            
					if(tabAllSize > tabSize){  // 탭사이즈가 전체li 탭보다 클경우               
						var appendTab = $(".other_list").find("li").first().clone(true);//숨김 탭에서 가져온다.    
						tabId.append(appendTab);                      
						var tabSize2 = 0;             
						var tabAllSize2 =tabId.width()-tabMiunsSize;                             
						tabId.find("li").each(function(index,item){ 
							tabSize2 +=$(item).width();
						});    
						if(tabAllSize2 < tabSize2){ //숨김탭에서 가져와서 길이를 더했을때  탭길이가 크면 add한탭 삭제                    
							tabId.find("li").last().remove();                
						}else{
							 $(".other_list").find("li").first().remove();             
						}
					}                            
				}                       
				hideTab();
				if(typeof(window["scrollEventAdd"]) == "function") { 
					scrollEventAdd();           
				}  
				return false;
			});      
			addhideTab(tabId);                                                  
		},                                                 
		addContent: function (){   //ajax db 조회             
			$("."+this.TabBody).append( $("div[name=tabs-Template]").clone(true).attr("name",this.TabName));
			var divObj = $("div[name="+this.TabName+"]");                                       
			divObj.show();      
			this.ContentObj = divObj;          
		},
		selectTabContent:function (url,callback){   //ajax db 조회    
			var tabObj = this.TabObj;
			$.ajax({                          
			      url:url,
			      async: false,   
			      type: "POST",                       
			      data: JSON.stringify(this.TabData), 
			      beforeSend : function(xhr) {           
						xhr.setRequestHeader("AJAX", "true");                  
					},
			      contentType: 'application/json',                                    
			      dataType: 'json', 
			      success:function(json){    
			    	  callback(tabObj,json);                                                                     
				      },          
			      error:function(request,textStatus){
			     	 if(request.status == 9999){                
			     		 $("form").eq(0).attr("action",getContextPath+"/admin/admin.do").submit();
			     	 }else{
			     		alert('에러발생...' + textStatus);
			     	 }
			      }
			});        
		},      
		removeShowTab : function(){
			this.LabelObj.remove(); 
			this.ContentObj.remove();                             
		}                        
		,tabPutMap : function(){
			//탭이름, 탭객체                     
			this.Tabmap.put(this.TabName,this.ContentObj);
		}
		,tabGetMap : function(tabName){
			//탭이름                              
			var mapObj = this.Tabmap.get(tabName);    
			if(mapObj != null && mapObj !="" && mapObj != "undefined" ){
				$("."+this.TabBody).append(mapObj); 
			}
			var divObj = $("div[name="+tabName+"]");    
			divObj.show();   
			this.ContentObj = divObj;                                                  
		},
		removeTab : function(tabs){
			for(var i=0; i<tabs.length; i++){   
				if(tabs.eq(i).attr("name") !="tabs-Template" && tabs.eq(i).attr("name") !="tabs-main" ){
					tabs.eq(i).remove();                 
				}
			}         
		},
		tabExits : function(id){
			if ($("a[id="+"tabs-" + id+"]").length == 1) {
				return true;               
			}else{
				return false;                    
			}          
		}
		,tabModalOpen : function(){
			var html = "<div class='abcd' style='display:none;position: absolute; left: 20px; top: 420px; width: 996px; height: 600px; display: block;z-index: 264;background:#FFFFFF;opacity: 0.5;filter: alpha(opacity=50)'>&nbsp;</div>";
			html+="<div class='abcd' style='display:none;position: absolute; width: 50px; left: 400px; top: 700px; visibility: visible; display: block;z-index: 266;'><img id='procimg' src='http://www.fios.go.kr/js/Main/search.png' alt='조회 중 입니다.' /></div>";      
			$("body").append(html);  
		}
		,tabModalClose : function(){
			$(".abcd").remove();             
		}
};                                                       
                      
//상세 callback 함수          
//callback을 사용 못할경우 overriding하여 사용해야함   
function tabCallBack(tab,json){ //callBack 함수 
	tab.ContentObj.find("a[name=a_reg]").remove();             
	if(typeof(window["setTabButton"]) == "function") { //탭 이벤트 추가(반드시 선언해서 사용해야함)
		setTabButton();       
    }
	if(json.DATA != null){               
		$.each(json.DATA,function(key,state){ 
			if(tab.ContentObj.find("[name="+key+"]").attr("type") == 'radio'){          
				tab.ContentObj.find("[name="+key+"]"+":radio[value='"+state+"']").prop("checked",true);                                                                          
			}else if(tab.ContentObj.find("[name="+key+"]").attr("type") == 'checkbox'){          
				tab.ContentObj.find("[name="+key+"]"+":checkbox[value='"+state+"']").prop("checked",true);                                                                          
			}else{          
				tab.ContentObj.find("[name="+key+"]").val(state).change();                           
			}
		}); 
	}        
	  
	
	if(typeof(window["tabFunction"]) == "function") { // 또 다른 작업이 있을 경우 페이지에 tabFunction 만들어서 사용함
		//tabFunction 없으면 동작안함.
		tabFunction(tab, json);                                 
    }  
}   
  
//등록 callback 함수     
//callback을 사용 못할경우 overriding하여 사용해야함
function tabCallRegBack(tab){ //callBack 함수                    
	tab.ContentObj.find("a[name=a_modify]").remove();                                      
	tab.ContentObj.find("a[name=a_del]").remove();        
	
	if(typeof(window["regUserFunction"]) == "function") { // 또 다른 작업이 있을 경우 페이지에 regUserFunction 만들어서 사용함
		//regUserFunction 없으면 동작안함.
		regUserFunction(tab);       
    }  
	
	if(typeof(window["setTabButton"]) == "function") { //탭 이벤트 추가(반드시 선언해서 사용해야함)
		setTabButton();       
    }  
}


function addhideTab(tabId){
	var flag =true;                    
	while(flag){ //여러건이 숨긴탭으로 이동할 수 있음...      
		var tabSize = 0;
		var tabAllSize =tabId.width()-tabMiunsSize;                             
		tabId.find("li").each(function(index,item){ 
			tabSize +=$(item).width();                                
		});            
		if(tabAllSize < tabSize){                                                                                                          
			$(".more_list").show();        
			var appendTab = tabId.find("li").last().clone(true);        
			tabId.find("li").last().remove();                     
			$(".other_list").append(appendTab);
		}else{
			flag = false;                                   
		}
	}
}

function hideTab(){
	if($(".other_list").find("li").length == 0){//숨김탭이 없을 경우 hiiden                  
		$(".more_list").hide();    
		$(".other_list").hide();                                 
	}
}


function getTabShowObj(){
	var obj ="";                         
	$("."+tabContentClass).each(function(index,item){                        
		if($(item).css("display") != "none"){
			obj = $(item);
		}                                                                        
	});                  
	return obj;
}

function getTabShowObjForm(divNm){              
	var obj = getTabShowObj();                  
	return tabObjForm(obj,divNm);                                        
}

function tabObjForm(item,divNm){
	var obj ="";              
	item.find("div[name="+divNm+"]").each(function(index2,item2){ 
		if($(item2).css("display") != "none"){   
			obj =  $(item2);                                                
		}        
	});             
	return obj;
}

var XSSfilter = function( content ) {
    return content.replace(/</g, "&lt;").replace(/>/g, "&gt;");
};
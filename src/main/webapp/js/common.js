//================================================
// IBSheet 그리드 내용을 JSON으로 변경하여 ajax 처리한다.
// 저장 결과는 callback 함수를 정의하여 처리한다.
//================================================
var ibsSaveJson = null; //IBS 그리드 시트 저장용 JSON 변수
function IBSpostJson(urls, param, callback) {
	var ajaxurl = urls;
	if(param != null && param != "") {
		ajaxurl = urls + "?" +param;
	}
	 $.ajax({
      url: ajaxurl,
      async: false,
      type: "POST",
      data: JSON.stringify(ibsSaveJson),
      beforeSend : function(xhr) {// ajax 호출시 사용자 인증정보가 잇는지 확인
			xhr.setRequestHeader("AJAX", "true");                  
		},
      contentType: 'application/json',             
      dataType: 'json', 
      success: callback,
      error:function(request,textStatus){
     	 if(request.status == 9999){                
     		 $("form").eq(0).attr("action",getContextPath+"/admin/admin.do").submit();
     	 }else{
     		 alert('에러발생...' + textStatus);
     	 }
      }
  });
	                                      
}


function IBSpostJsonAjax(obj, urls, param, callback) {
	var ajaxurl = urls;
	if(param != null && param != "") {
		ajaxurl = urls + "?" +param;
	}
	
	 obj.ajaxSubmit({
      url: ajaxurl,
      async: false,
      type: "POST",
      data: JSON.stringify(ibsSaveJson),
      beforeSend : function(xhr) {// ajax 호출시 사용자 인증정보가 잇는지 확인
			xhr.setRequestHeader("AJAX", "true");                  
		},
      contentType: 'application/json',             
      dataType: 'json', 
      success: callback,
      error:function(request,textStatus){
     	 if(request.status == 9999){                
     		 $("form").eq(0).attr("action",getContextPath+"/admin/admin.do").submit();
     	 }else{
     		 alert('에러발생...' + textStatus);
     	 }
      }
  });
	                                      
}


function IBSpostJsonFile(form,urls, callback) {
	var ajaxurl = urls;                     
	ajaxurl = urls + "?" +ibsSaveJson;
	form.ajaxSubmit({                                                                  
      url: ajaxurl,                  
      async: false,                                 
      type: "POST",                     
      beforeSend : function(xhr) {// ajax 호출시 사용자 인증정보가 잇는지 확인
			xhr.setRequestHeader("AJAX", "true");                  
		},                
        contentType: 'application/x-www-form-urlencoded;charset=UTF-8',             
      dataType: 'json',                                           
      success: callback,
      error:function(request,textStatus){
     	 if(request.status == 9999){                
     		 $("form").eq(0).attr("action",getContextPath+"/admin/admin.do").submit();
     	 }else{
     		 alert('에러발생...' + textStatus);
     	 }
      }
  });
	                                      
}

function PostJsonFile(form,urls, callback) {
	var ajaxurl = urls;                     
	//ajaxurl = urls + "?" +ibsSaveJson;
	form.ajaxSubmit({                                                                  
      url: ajaxurl,                  
      async: false,                                 
      type: "POST",                     
      beforeSend : function(xhr) {// ajax 호출시 사용자 인증정보가 잇는지 확인
			xhr.setRequestHeader("AJAX", "true");                  
		},                
        contentType: 'application/x-www-form-urlencoded;charset=UTF-8',             
      dataType: 'json',                                           
      success: callback,
      error:function(request,textStatus){
     	 if(request.status == 9999){                
     		 $("form").eq(0).attr("action",getContextPath+"/admin/admin.do").submit();
     	 }else{
     		 alert('에러발생...' + textStatus);
     	 }
      }
  });
	                                      
}

//================================================
//IBS 그리드 리스트 저장(삭제) 처리 후 콜백함수...
//================================================
function ibscallback(res){
    var result = res.RESULT.CODE;
    if(result == 0) {
    	alert(res.RESULT.MESSAGE);
    } else {
    	alert(res.RESULT.MESSAGE);
    }                   
    if(typeof(window["OnSaveEnd"]) == "function") {
    	OnSaveEnd();
    }                           
}   
                          
//================================================
//ajax 처리 후 콜백함수...
//================================================
function ajaxCallAdmin(url, param, callback) {
	 $.ajax({           
     url: url,                 
     async: false,                    
     type: "POST",           
     data: param,                                                         
     dataType: 'json', 
     beforeSend : function(xhr) {// ajax 호출시 사용자 인증정보가 잇는지 확인
			xhr.setRequestHeader("AJAX", "true");     
		
		},
	
     success: callback,                             
     error:function(request,textStatus){
    	 if(request.status == 9999){                
    		 $("form").eq(0).attr("action",getContextPath+"/admin/admin.do").submit();
    	 }else{
    		 alert('에러발생...' + textStatus);
    	 }
     }
 });
}


//================================================
//ajax 처리 후 콜백함수...
//================================================
function ajaxCallAdminASync(url, param, callback) {
	 $.ajax({           
   url: url,                 
   async: false,                    
   type: "POST",           
   data: param,                                                         
   dataType: 'json', 
   beforeSend : function(xhr) {// ajax 호출시 사용자 인증정보가 잇는지 확인
			xhr.setRequestHeader("AJAX", "true");                  
		},
   success: callback,                             
   error:function(request,textStatus){
  	 if(request.status == 9999){                
  		 $("form").eq(0).attr("action",getContextPath+"/admin/admin.do").submit();
  	 }else{
  		 alert('에러발생...' + textStatus);
  	 }
   }
});
}




// ================================================
// ajax 처리 후 콜백함수...
// ================================================
function ajaxCall(url, param, callback) {
	 $.ajax({           
   url: url,                 
   async: false,                    
   type: "POST",           
   data: param,                                    
   dataType: 'json', 
   beforeSend : function(xhr) {// ajax 호출시 사용자 인증정보가 잇는지 확인
			xhr.setRequestHeader("AJAX", "true");                  
		},
   success: callback,                             
   error:function(request,textStatus){
  	 if(request.status == 9999){                
  		 $("form").eq(0).attr("action",getContextPath+"/main.do").submit();
  	 }else{
  		 alert('에러발생...' + textStatus);
  	 }
   }
});
}


function ajaxCallASync(url, param, callback) {
	 $.ajax({           
  url: url,                 
  async: true,                    
  type: "POST",           
  data: param,                                    
  dataType: 'json', 
  beforeSend : function(xhr) {// ajax 호출시 사용자 인증정보가 잇는지 확인
			xhr.setRequestHeader("AJAX", "true");                  
		},
  success: callback,                             
  error:function(request,textStatus){
 	 if(request.status == 9999){                
 		 $("form").eq(0).attr("action",getContextPath+"/main.do").submit();
 	 }else{
 		 alert('에러발생...' + textStatus);
 	 }
  }
});
}

//================================================
//ajax 처리 후 콜백함수...
//================================================
function ajaxBeforeSendAdmin(url) {
	 $.ajax({           
	   url: url,                 
	   async: false,                    
	   type: "POST",           
	   dataType: 'json', 
	   beforeSend : function(xhr) {// ajax 호출시 사용자 인증정보가 잇는지 확인
				xhr.setRequestHeader("AJAX", "true");                  
			},
	   error:function(request,textStatus){
	  	 if(request.status == 9999){                
	  		 $("form").eq(0).attr("action",getContextPath+"/admin/admin.do").submit();
	  	 }
	   }
	});
}

function saveCallBack(res){      
    alert(res.RESULT.MESSAGE);
    openTab.removeShowTab();
    $("a[id=tabs-main]").click();                            
    OnSaveEnd();
 
}

function saveCallBackCheckbox(res){      
    alert(res.RESULT.MESSAGE);
    //설문관리페이지에서 사용. 체크박스풀어준다.
    $("input:checkbox[id='user1Yn']").attr("checked",false);
	$("input:checkbox[id='user2Yn']").attr("checked",false);
    openTab.removeShowTab();
    $("a[id=tabs-main]").click();
    OnSaveEnd();
    
}

function updateCallBack(res){      
    alert(res.RESULT.MESSAGE);
    openTab.removeShowTab();                       
    $("a[id=tabs-main]").click();                  
    OnSaveEnd();                
}

function deleteCallBack(res){      
    alert(res.RESULT.MESSAGE);             
    openTab.removeShowTab();
    $("a[id=tabs-main]").click();                  
    OnSaveEnd();
}



/* 팝업으로 열기 */
function OpenWindow(target, wName, wWidth, wHeight, wScroll){
	
  var xpos = ( screen.width -  wWidth  ) / 2; 
  var ypos = ( screen.height - wHeight )  / 2;  
  
  //윈도우 이름이 틀리면 새창으로 팝업이 열리고, 같으면 이름이 같이 창이 Replace된다.
  if (wName == null) wName = "";
	  
  popupWindow = window.open(target,wName,'toolbar=no,status=no,top='+ ypos +',left='+ xpos +',width=' + wWidth + ',height=' + wHeight +',directories=no,scrollbars=yes,location=no,resizable=yes,border=0,menubar=no,status=yes');
  popupWindow.focus();
  return popupWindow;
}

/* 모달 팝업으로 열기 */
function OpenModal(target, wName, wWidth, wHeight, wScroll){
	
	var xpos = ( screen.width -  wWidth  ) / 2; 
	var ypos = ( screen.height - wHeight )  / 2;  
	
	//윈도우 이름이 틀리면 새창으로 팝업이 열리고, 같으면 이름이 같이 창이 Replace된다.
	if (wName == null) wName = "";
	
	popupWindow = window.open(target,wName,'top='+ ypos +',left='+ xpos +',width=' + wWidth + ',height=' + wHeight +',directories=no,scrollbars=yes,location=no,resizable=yes,border=0,menubar=no,status=no,toolbar=no,modal=yes');
	return popupWindow;
}


function return_pop(obj,arrayValue){
	
	var formObj;   
	for(var i = 0; i < obj.length; i++){         
		if(obj.eq(i).css("display") != "none"){
			formObj = obj.eq(i).find("form"); 
		}
	}                
	           
	$.each(arrayValue,function(key,state){
		formObj.find("[name="+key+"]").val(state);
	}); 
	window.close();
}

/**
 * 2015-07-14 탭제거 전용 팝업 return
 * @param obj
 * @param index
 * @param arrayValue
 */
function return_popIndex(obj,index,arrayValue){
	var formObj;   
	
	formObj = obj.eq(Number(index)).find("form");
	$.each(arrayValue,function(key,state){
		formObj.find("[name="+key+"]").val(state);
	}); 
	window.close();
}

/** 2015-07-08 IBSheet 용 팝업 return ( SetColValue )
 * @author ijshin 
 * @param obj
 * @param arrayValue
 */
function returnIBS_pop(sheet,arrayValue){	
	$.each(arrayValue,function(key,state){
		sheet.SetCellValue(sheet.GetSelectRow(),key,state);
	}); 
	window.close();
}


function setTabForm(classObj){
	var formParam="";
	var formObj="";            
	var Obj = new Array(2);
	for(var i = 0; i < classObj.length; i++){         
		if(classObj.eq(i).css("display") != "none"){      
			formObj = classObj.eq(i).find("form"); //jquery form 객체화
			formParam = formObj.serialize(); // parameter 셋팅
			formObj = document.getElementsByName(formObj.attr("name"))[i]; //validate하기 위해 javasciprt 변수로 변경(form명이 변경되므로)                                                                
		}
	}
	Obj[0] = formParam;
	Obj[1] = formObj;
	return Obj;
}


function setTabForm2(classObj,formNm){
	var formParam;                                           
	var formObj;             
	var Obj = new Array(2);                  
	for(var i = 0; i < classObj.length; i++){         
		if(classObj.eq(i).css("display") != "none"){      
			formObj = classObj.eq(i).find("form[name="+formNm+"]"); //jquery form 객체화
			formParam = formObj.serialize(); // parameter 셋팅
			formObj = document.getElementsByName(formObj.attr("name"))[i]; //validate하기 위해 javasciprt 변수로 변경(form명이 변경되므로)                                                                
		}
	}
	Obj[0] = formParam;
	Obj[1] = formObj;
	return Obj;
}  


function gridMove(gridObj,rowNo,rowNm,orderByYn){
	gridObj.DataMove(rowNo);               
	if(orderByYn == "Y"){                      
		orderByGrid(gridObj,rowNm);
	}
}
function orderByGrid(gridObj,rowNm){                 
	for(var i = 1 ; i < gridObj.RowCount()+1; i++){     
		gridObj.SetCellValue(i,rowNm,i);                            
	}
}

function gridTreeMoveDown(gridObj,rowNm,orderNm, orderByYn){ //obj, eventType(down,up),컬럼명,정렬여부
	var row = gridObj.GetSelectRow();                   
	var level = gridObj.GetCellValue(row,rowNm);
	var nextLevel =0;
	var nextLevel2=0;
	var cnt = 0;           
	var flag = true;
	for(var i = row+1 ; i < gridObj.RowCount()+1; i++)
	{
		if(flag){
			if(level == gridObj.GetCellValue(i,rowNm)){
				if(cnt == 1){
					nextLevel2 = i;
				}else{
					nextLevel = i;
				}                
				cnt++;      
			}else if(level > gridObj.GetCellValue(i,rowNm)){
				flag=false;
			}
		}
	}             
	if(cnt ==0){
		return;                
	}else if(nextLevel2 != ""){        
		gridObj.DataMove(nextLevel2);                     
	}else{
		gridObj.DataMove(nextLevel+1);                 
	}
	
	if(orderByYn == "Y"){                                  
		orderByGrid(gridObj,orderNm);
	}
}
function gridTreeMoveUp(gridObj,rowNm,orderNm, orderByYn){ //obj, eventType(down,up),컬럼명,정렬여부
	var row = gridObj.GetSelectRow();                   
	var level = gridObj.GetCellValue(row,rowNm);
	var nextLevel =0;
	var cnt = 0;           
	var flag = true;
	for(var i = row-1 ; i > 0; i--){                   
		if(flag){
			if(level == gridObj.GetCellValue(i,rowNm)){
				if(cnt == 0){
					nextLevel = i;                 
				}     
				cnt++;
			}else if(level > gridObj.GetCellValue(i,rowNm)){
				flag=false;             
			} 
		}
	}               
	
	if(cnt ==0){
		return;                
	}else{                          
		gridObj.DataMove(nextLevel);                 
	}
	
	if(orderByYn == "Y"){                               
		orderByGrid(gridObj,orderNm);
	}                           
}
            

function setCalendar() {
	 var clareCalendar = {
		        monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		        dayNamesMin: ['일','월','화','수','목','금','토'],
		        weekHeader: 'Wk',
		        dateFormat: 'yy-mm-dd', //형식(20120303)
		        autoSize: false, //오토리사이즈(body등 상위태그의 설정에 따른다)
		        changeMonth: true, //월변경가능
		        changeYear: true, //년변경가능
		        showMonthAfterYear: true, //년 뒤에 월 표시
		        buttonImageOnly: true, //이미지표시
		        buttonText: '달력선택', //버튼 텍스트 표시
		        buttonImage: com.wise.help.url("/images/admin/icon_calendar.png"), //이미지주소                                                                      
		        showOn: "both", //엘리먼트와 이미지 동시 사용(both,button)                 
		        yearRange: '1900:2100', //1990년부터 2020년까지
		        showButtonPanel: true, 
				closeText: 'close'
		        };   
    $("#ui-datepicker-div").hide(); //자동으로 생성되는 div객체 숨김
    $(".ui-datepicker-trigger").attr("style","vertical-align:middle;margin:0 3px;cursor:hand;"); //이미지버튼 style적용
    return clareCalendar;  
}

function setCalendarFormat(format) {
	 var clareCalendar = {
		        monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		        dayNamesMin: ['일','월','화','수','목','금','토'],
		        weekHeader: 'Wk',
		        dateFormat: format,
		        autoSize: false, //오토리사이즈(body등 상위태그의 설정에 따른다)
		        changeMonth: true, //월변경가능
		        changeYear: true, //년변경가능
		        showMonthAfterYear: true, //년 뒤에 월 표시
		        buttonImageOnly: true, //이미지표시
		        buttonText: '달력선택', //버튼 텍스트 표시
		        buttonImage: com.wise.help.url("/images/admin/icon_calendar.png"), //이미지주소                                                                      
		        showOn: "both", //엘리먼트와 이미지 동시 사용(both,button)                 
		        yearRange: '1900:2100', //1990년부터 2020년까지
		        showButtonPanel: true, 
				closeText: 'close'
		        };   
   $("#ui-datepicker-div").hide(); //자동으로 생성되는 div객체 숨김
   $(".ui-datepicker-trigger").attr("style","vertical-align:middle;margin:0 3px;cursor:hand;"); //이미지버튼 style적용
   return clareCalendar;  
}

//오늘 이후의 날짜만 선택하게 하는 달력
function setOpenCalendar() {
	 var clareCalendar = {
		        monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		        dayNamesMin: ['일','월','화','수','목','금','토'],
		        weekHeader: 'Wk',
		        dateFormat: 'yy-mm-dd', //형식(20120303)
		        autoSize: false, //오토리사이즈(body등 상위태그의 설정에 따른다)
		        changeMonth: true, //월변경가능
		        changeYear: true, //년변경가능
		        showMonthAfterYear: true, //년 뒤에 월 표시
		        buttonImageOnly: true, //이미지표시
		        buttonText: '달력선택', //버튼 텍스트 표시
		        buttonImage: com.wise.help.url("/images/admin/icon_calendar.png"), //이미지주소                                                                      
		        showOn: "both", //엘리먼트와 이미지 동시 사용(both,button)                 
		        yearRange: '1900:2100', //1990년부터 2020년까지
		        showButtonPanel: true, 
		        minDate:'-0d',
				closeText: 'close'   
		        };   
   $("#ui-datepicker-div").hide(); //자동으로 생성되는 div객체 숨김
   $(".ui-datepicker-trigger").attr("style","vertical-align:middle;margin:0 3px;cursor:pointer;"); //이미지버튼 style적용
   return clareCalendar;  
}


function setCalendarView(dataF) {
	 var clareCalendar = {
		        monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		        dayNamesMin: ['일','월','화','수','목','금','토'],
		        weekHeader: 'Wk',
		        dateFormat: dataF, //형식(20120303)
		        autoSize: false, //오토리사이즈(body등 상위태그의 설정에 따른다)
		        changeMonth: true, //월변경가능               
		        changeYear: true, //년변경가능
		        showMonthAfterYear: true, //년 뒤에 월 표시                        
		        buttonImageOnly: true, //이미지표시                                                                
		        buttonText: '달력선택', //버튼 텍스트 표시
		        buttonImage: com.wise.help.url("/images/admin/icon_calendar.png"), //이미지주소                                                     
		        showOn: "both", //엘리먼트와 이미지 동시 사용(both,button)                 
		        yearRange: '1900:2100', //1990년부터 2020년까지
		        showButtonPanel: true, 
				closeText: 'close'         
		        };                    
   $("#ui-datepicker-div").hide(); //자동으로 생성되는 div객체 숨김
   $(".ui-datepicker-trigger").attr("style","vertical-align:middle;margin:0 3px;cursor:pointer;"); //이미지버튼 style적용
   return clareCalendar;                     
}
function datepickerTrigger(){
	 $(".ui-datepicker-trigger").attr("style","vertical-align:middle;margin:0 3px;cursor:pointer;"); //이미지버튼 style적용
}

function openIframePop(iframeNm,url,width){
	if(iframeNm == "" || iframeNm == undefined){
		iframeNm = "iframePopUp";               
	}           
	
	var height = 500;
	
	$(".back").css("width", $(document).width())                                                 
		.css("height", $(document).height())
		.css("top", 0)               
		.css("left", 0)
		.show();             
	
	 $("iframe[name="+iframeNm+"]")
	 	.attr("src", url)                         
	 	.css("position","absolute")
	 	.css("height", height + "px")                                         
	 	.css("width", width+"px")
	 	.css("top",  ((screen.height - height) / 2) + $(window).scrollTop() + "px")
	 	.css("left", (($(window).width() - width) / 2) + $(window).scrollLeft() + "px")
		.show();    
}     

function openIframeStatPop(iframeNm, url, _width, _height){
	var width = _width || "660";
	var height = _height || "530";
	
	if(iframeNm == "" || iframeNm == undefined){
		iframeNm = "iframePopUp";               
	}  
	
	$(".back").css("width", $(document).width())                                                 
		.css("height", $(document).height())
		.css("top", 0)               
		.css("left", 0)
		.show();           
	
	 $("iframe[name="+iframeNm+"]")
	 	.attr("src", url)                     
	 	.css("position","absolute")
	 	.css("height", height + "px")                                         
	 	.css("width", width+"px")
	 	.css("top",  ((screen.height - height) / 2) + $(window).scrollTop() + "px")
	 	.css("left", (($(window).width() - width) / 2) + $(window).scrollLeft() + "px")
		.show();   
}  
     
               
function closeIframePop(iframeNm){           
	if(iframeNm == "" || iframeNm == undefined){
		iframeNm = "iframePopUp";
	}
	 $("iframe[name="+iframeNm+"]")                                 
	 	//.attr("src", "")                     
	 	.css("width","")       
	 	.css("height","")
	 	.css("top","")                            
	 	.css("left","")                              
	 	.hide();     
	 $(".back").css("width","")
		.css("heigth","")
		.css("top","0")
		.css("left","0")
		.hide();  
}
               
function reSizeIframePop(iframeNm){
	return false;
	if(iframeNm == "" || iframeNm == undefined){
		iframeNm = "iframePopUp";
	}                   
	//팝업 사이즈 구하기
	 var height = $("body").css("height");                       
	 var width = $("body").css("width");
	 height = Number(height.replace("px",""));
	 width = Number(width.replace("px",""));                 
	 var xpos = ( screen.width -  width) / 2;                                                      
	 var ypos = ( screen.height - height)  / 2;   
	 parent.$("iframe[name="+iframeNm+"]")                                         
	 	.css("width",width+"px")
	 	.css("height",height+"px")                                                      
	 	.css("top",ypos+"px")         
	 	.css("left",xpos+"px")               
	 	.show();                 
}

function objInValNull(obj){                                                      
	obj.find("input:text").val("");            
	obj.find("select").val("");           
	obj.find("input:radio").attr("checked",false);                       
	obj.find("input:checkbox").attr("checked",false);           
}

function inputCheckYn(name){                           
	if($("input:checkbox[name='"+name+"']").is(":checked") == true){
		return "Y";                
	}                 
	return "N";
}

function inputRadioYn(name){                           
	if($("input:radio[name='"+name+"']").is(":checked") == true){
		return "Y";                
	}                 
	return "N";
}

                                
function inputRadioVal(name){               
	var value = $("input:radio[name='"+name+"']:checked").val();
	if(value !=undefined){              
		return value;      
	}                 
	return "";
}

/**
 * 트리순서 위로 이동(동일 레벨간에만 이동가능)
 * @param obj			ibsheet객체
 * @param sortColNm		sort될 컬럼 savename
 * @returns {Boolean}
 */
function fncTreeUp(obj, sortColNm) {
	
	var selRow = obj.GetSelectRow();
	if ( selRow < 0 ) 	return false;
	
	var selRowOrder, prevRowOrder;
	var prevRow = obj.GetPrevSiblingRow(selRow);
	
	if ( prevRow > 0 ) {
		selRowOrder = obj.GetCellValue(selRow, sortColNm);
		prevRowOrder = obj.GetCellValue(prevRow, sortColNm);
		
		// 순서 컬럼 값이 같은경우 동일레벨 관계에서는 순번 새로 지정해준다.
		if ( selRowOrder == prevRowOrder ) {
			obj.DataMove(prevRow, selRow);	// toRow, FromRow
			fncSetTreeOrder(obj, sortColNm);
		}
		else {
			obj.SetCellValue(selRow, sortColNm, prevRowOrder);
			obj.SetCellValue(prevRow, sortColNm, selRowOrder);
			obj.DataMove(prevRow, selRow);	// toRow, FromRow
		}
		
		obj.ReNumberSeq();		// seq 재조정
	}
	else {
		alert("동일 레벨간에만 이동할 수 있습니다.");
		return false;
	}
}

/**
 * 트리순서 아래로 이동(동일 레벨간에만 이동가능)
 * @param obj			ibsheet객체
 * @param sortColNm		sort될 컬럼 savename
 * @returns {Boolean}
 */
function fncTreeDown(obj, sortColNm) {
	
	var selRow = obj.GetSelectRow();
	if ( selRow < 0 ) 	return false;
	
	var selRowOrder, nextRowOrder;
	var nextRow = obj.GetNextSiblingRow(selRow);
	
	if ( nextRow > 0 ) {
		selRowOrder = obj.GetCellValue(selRow, sortColNm);
		nextRowOrder = obj.GetCellValue(nextRow, sortColNm);
		
		// 순서 컬럼 값이 같은경우 동일레벨 관계에서는 순번 새로 지정해준다.
		if ( selRowOrder == nextRowOrder ) {
			obj.DataMove(selRow, nextRow);
			fncSetTreeOrder(obj, sortColNm);
		}
		else {
			obj.SetCellValue(selRow, sortColNm, nextRowOrder);
			obj.SetCellValue(nextRow, sortColNm, selRowOrder);
			obj.DataMove(selRow, nextRow);
		}
		
		// 데이터 이동하고 현재 선택하는 selectRow 변경
		var moveRow = obj.GetNextSiblingRow(selRow);
		obj.SetSelectRow(moveRow);
		
		obj.ReNumberSeq();	// seq 재조정
	}
	else {
		alert("동일 레벨간에만 이동할 수 있습니다.");
		return false;
	}
}

/**
 * 트리순서 위/아래로 조정시 동일순서가 있는경우 이동이 안되어
 * 동일레벨 관계에서는 순번 새로 지정해준다.
 * @param obj			ibsheet객체
 * @param sortColNm		sort될 컬럼 savename
 * @returns {Boolean}
 */
function fncSetTreeOrder(obj, sortColNm) {
	var selR = obj.GetSelectRow();
	if ( selR < 0 ) 	return false;
	
	var selRLvl = obj.GetRowLevel(selR);
	var prntR = obj.GetParentRow(selR);
	var prntRLvl = obj.GetRowLevel(prntR);
	
	var ord = 1;
	var i = prntR;
	
	while ( i++ < obj.RowCount() ) {
		var curRLvl = obj.GetRowLevel(i);

		if ( selRLvl == curRLvl ) {
			obj.SetCellValue(i, sortColNm, ord++);
		}
		else if ( selRLvl < curRLvl ) {
			continue;
		} else if ( selRLvl > curRLvl ) {
			break;
		}
	}
}


//트리순서 위로 이동
function treeUp(ibsObj, sortYn, sortColNm) {
	var moveCnt;
	var selectRow = ibsObj.GetSelectRow();						//현재 선택행
	var selectRowLevel = ibsObj.GetRowLevel(selectRow);			//현재 선택행 레벨
	var selectHighRowLevel = ibsObj.GetRowLevel(selectRow-1);	//현재 선택행 상위행레벨
	var childNodeCnt = ibsObj.GetChildNodeCount(selectRow);		//하위 노드숫자
	
	if ( selectRow == "" ) return;
	if ( selectRow == 1  ) return;
	
	if ( selectRowLevel == 0 ) {		//최 상위 레벨
		for ( var i=selectRow; i>0; i-- ) {
			if ( selectRowLevel > ibsObj.GetRowLevel(i-1) ) {
				alert("같은 레벨간에만 이동 가능합니다.");
				return;
			} else if ( selectRowLevel == ibsObj.GetRowLevel(i-1) ) {
				moveCnt = i-1;
				break;
			}
		}
		ibsObj.DataMove(moveCnt, selectRow);
		ibsObj.ReNumberSeq();
		if ( sortYn == true ) {
			treeOrderSet(ibsObj, sortColNm);
		}
		return; 
	 }
	
	if ( childNodeCnt == 0 ) {		// 최 하위 레벨이면
		if ( selectRowLevel != selectHighRowLevel ) {
			alert("같은 레벨간에만 이동 가능합니다.");
			return;
		} else {
			ibsObj.DataMove(selectRow-1, selectRow);
		}
	} else {								// 중간 레벨이면
		for ( var i=selectRow; i>0; i-- ) {
			if ( selectRowLevel > ibsObj.GetRowLevel(i-1) ) {
				alert("같은 레벨간에만 이동 가능합니다.");
				return;
			} else if ( selectRowLevel == ibsObj.GetRowLevel(i-1) ) {
				moveCnt = i-1;
				break;
			}
		}
		ibsObj.DataMove(moveCnt, selectRow);
	}
	ibsObj.ReNumberSeq();	
	
	if ( sortYn == true ) {
		treeOrderSet(ibsObj, sortColNm);
	}
}

//트리 순서 아래로 이동
function treeDown(ibsObj, sortYn, sortColNm) {
	var moveCnt;
	var selectRow = ibsObj.GetSelectRow();						//현재 선택행
	var selectRowLevel = ibsObj.GetRowLevel(selectRow);			//현재 선택행 레벨
	var selectLowRowLevel = ibsObj.GetRowLevel(selectRow+1);	//현재 선택행 상위행레벨
	var childNodeCnt = ibsObj.GetChildNodeCount(selectRow);		//하위 노드숫자
	
	if ( selectRow == "" ) return;
	if ( selectRow == ibsObj.RowCount() ) return;
	
	if ( childNodeCnt == 0 ) {		// 최 하위 레벨이면
		if ( selectRowLevel != selectLowRowLevel ) {
			alert("같은 레벨간에만 이동 가능합니다."); 
			return;
		} else {
			ibsObj.DataMove(selectRow+2, selectRow);
		}
	} else {								// 중간 레벨이면
		for ( var i=selectRow; i<ibsObj.RowCount(); i++ ) {
			if ( selectRowLevel > ibsObj.GetRowLevel(i+1) ) {
				alert("같은 레벨간에만 이동 가능합니다.");
				return;
			} else if ( selectRowLevel == ibsObj.GetRowLevel(i+1) ) {
				moveCnt = i+2;
				break;
			}
		}
		ibsObj.DataMove(moveCnt, selectRow);
	}
	ibsObj.ReNumberSeq();
	
	if ( sortYn == true ) {
		treeOrderSet(ibsObj, sortColNm);
	}
}

//트리정렬
function treeOrderSet(ibsObj, sortColNm) {
	var selectRowLevel, prevRowLevel;
	var arrOrder = new Array();
	var vOrder, xOrder, tOrder;
	
	tOrder = 1;
	for ( var i=1; i <= ibsObj.RowCount(); i++ ) {
		selectRowLevel = ibsObj.GetRowLevel(i);
		prevRowLevel = ibsObj.GetRowLevel(i-1);
		if ( ibsObj.GetRowLevel(i) == 0 ) {					//최상위 레벨인 경우
			ibsObj.SetCellValue(i, sortColNm, tOrder);
			tOrder++;
			for ( var j=0; j<15; j++ ) {						//배열 및 order 변수 초기화
				arrOrder[j] = 0;
			}
			vOrder = 0;
			xOrder = 1;
		} else if ( selectRowLevel == 1 ) {					//1번째 레벨인경우 1씩 증가
			vOrder++;
			ibsObj.SetCellValue(i, sortColNm, vOrder);
		} else if ( prevRowLevel < selectRowLevel  ) {		//현재행의 레벨이 이전행의 레벨보다 큰 경우
			ibsObj.SetCellValue(i, sortColNm, 1);			//무조건 1순위
		} else if ( prevRowLevel == selectRowLevel  ) {		//현재행의 레벨이 이전 행의 레벨과 같은경우
			if ( ibsObj.GetRowLevel(i-2) < selectRowLevel ) {	//현재행의 레벨이 전전행의 레벨보다 큰경우
				xOrder = 1;										//무조건 1순위
			}
			xOrder++;
			arrOrder[selectRowLevel] = xOrder; 					//현재 레벨에 order 순서를 입력
			ibsObj.SetCellValue(i, sortColNm, arrOrder[selectRowLevel]);
			
		} else if ( prevRowLevel > selectRowLevel  ) {			//현재행의 레벨보다 이전행의 레벨보다 작은경우
			arrOrder[selectRowLevel] = arrOrder[selectRowLevel]+1; 	//현재행의 레벨의 배열정보 이용하여 순위 +1
			ibsObj.SetCellValue(i, sortColNm, arrOrder[selectRowLevel]);
		}
	}
}

//그리드 row 한줄 위로
function gridMoveUpChgVal(sheet, chgCol) {
	var selectRow = sheet.GetSelectRow();
	if (selectRow == 0) return false;
	var selectRowVal = sheet.GetCellValue(selectRow, chgCol);
	var upRowVal = sheet.GetCellValue(selectRow-1, chgCol);
	sheet.DataMove(selectRow-1, selectRow);
	sheet.SetCellValue(selectRow, chgCol, selectRowVal);
	sheet.SetCellValue(selectRow-1, chgCol, upRowVal);
	sheet.SetSelectRow(selectRow-1);
	sheet.ReNumberSeq();
}
//그리드 row 한줄 아래로
function gridMoveDownChgVal(sheet, chgCol) {
	var selectRow = sheet.GetSelectRow();
	if (selectRow == sheet.RowCount())	return false; 
	var selectRowVal = sheet.GetCellValue(selectRow, chgCol);
	var downRowVal = sheet.GetCellValue(selectRow+1, chgCol);
	sheet.DataMove(selectRow, selectRow+1);
	sheet.SetCellValue(selectRow, chgCol, selectRowVal);
	sheet.SetCellValue(selectRow+1, chgCol, downRowVal);
	sheet.SetSelectRow(selectRow+1);
	sheet.ReNumberSeq();
}


function getFileExt(fileNm) {
	var len = fileNm.length;
	var last = fileNm.lastIndexOf(".") + 1;
	if ( last > 0 ) {
		var ext = fileNm.substring(last, len);
		return ext;
	} else {
		return "";
	}
}

function copyClipBoard(text) {
	var IE = (document.all) ? true : false;
	if ( IE ){
		window.clipboardData.setData("text", text);
		return false;
	} else {
		prompt("Ctrl+C를 눌러 클립보드로 복사하세요", text);
		return false;
	}
}

/**
 * 현재날짜를 YYYYMMDD 형태로 리턴
 */
function fncToDate(format) {
	var today = new Date(); 										//날짜 변수선언
	var dateNow = fncLPAD(String(today.getDate()), "0", 2);			//일자
	var monthNow = fncLPAD(String((today.getMonth()+1)), "0", 2);	//월 구함
	var yearNow = String(today.getFullYear());						//년
	
	return yearNow + format + monthNow + format + dateNow;
}

/**
 * 원하는 텍스트를 왼쪽에 추가
 * val : 원래 값
 * set : 왼쪽에 추가하려는 값
 * cnt : set 갯수
 */
function fncLPAD(val, set, cnt) {
	if ( !set || !cnt || val.length >= cnt ) {
		return val;
	}
	
	var max = ( cnt - val.length ) / set.length;
	for ( var i=0; i < max; i++) {
		val = set + val;
	}
	
	return val;
}

/**
 * 시작보다 종료 날짜가 클 경우 false
 */
function fncBooleanDateDiff(startDate, endDate) {
	var startDate = startDate.split("-");
	var endDate = endDate.split("-");
	var sDate = new Date(startDate[0], startDate[1], startDate[2]);
	var eDate = new Date(endDate[0], endDate[1], endDate[2]);
	if ( sDate >= eDate ) {
		return false;
	}
	return true;
}
//******************************************************************************

function openRealceAll(val,pattern,replaceChar){
	if(val =="" || val ==null || val =="null"){                
		return "";
	}else{                           
		return val.replace(/[\n]/gi, "<br/>");     
	}
}

//탭 사용시 달력초기화(초기화 하지 않으면 탭안에서 동작안됨)
function datepickerInitTab(obj) {
	obj.next().remove();  
	obj.removeClass("hasDatepicker");  
}

/**
 * HTML Convertor 경로 생성
 */
function getFolderPath(mstSeq, convertDir) {
	if(mstSeq.length < 3) {
		return convertDir + "/1/" + mstSeq + "/";
	} else {
		return convertDir + "/" + mstSeq.substring(0,mstSeq.length-2) + "00/" + mstSeq + "/";
	}
}

/**
 * 탭에 속해 있는 폼 객체를 가져온다.
 * @param formNm	폼 명
 */
function getTabFormObj(formNm) {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name="+formNm+"]");
	return formObj
}

/**
 * 폼 내에 있는 grid 순서조정 관련 버튼을 숨김처리 한다.
 * 	위로 이동, 아래로 이동, 순서 저장버튼
 * @param formNm	폼 name
 */
function toggleShowHideOrderBtn(formNm) {
	var formObj = $("form[name="+ formNm +"]");
	if ( com.wise.util.isBlank(formObj.find("input[name=searchVal]").val()) ) {
		formObj.find("a[name=a_treeUp], a[name=a_treeDown], a[name=a_vOrderSave]").show();
	} else {
		formObj.find("a[name=a_treeUp], a[name=a_treeDown], a[name=a_vOrderSave]").hide();
	}
}

/**
 * 데이터 처리 후 처리중인 탭 닫고 메인 리스트 조회 후 탭으로 이동
 */
function afterTabRemove(data){
	if (data.success) {
		var tabOnId = $(".tab li.on").children(":eq(0)").attr("id") ;	//열려 있는 탭 id 찾기
		$("#"+tabOnId).closest("li").remove();							//열려 있는 탭 ID li 제거
	    $("a[id=tabs-main]").click();   //메인 탭 클릭      
	    $("button[name=btn_inquiry]").click();
    }
}

function gfn_isNull(str) {
	if (str == null) return true;
	if (str == "NaN") return true;
	if (new String(str).valueOf() == "undefined") return true;    
	var chkStr = new String(str);
	if( chkStr.valueOf() == "undefined" ) return true;
	if (chkStr == null) return true;    
	if (chkStr.toString().length == 0 ) return true;   
	return false; 
}

function ComAjax(opt_formId){
	this.url = "";		
	this.formId = gfn_isNull(opt_formId) == true ? "commonForm" : opt_formId;
	this.param = "";
	this.async = false;
	
	if(this.formId == "commonForm" && $("#commonForm")[0]){
		$("#commonForm")[0].reset();
		$("#commonForm").empty();
	}
	
	this.setUrl = function setUrl(url){
		this.url = url;
	};
	
	this.setCallback = function setCallback(callBack){
		fv_ajaxCallback = callBack;
	};
	
	this.setAsync = function setAsync(async){
		this.async = async;
	};


	this.addParam = function addParam(key,value){ 
		this.param = this.param + "&" + key + "=" + value; 
	};
	
	this.ajax = function ajax(){
		if(this.formId != "commonForm"){
			this.param += "&" + $("#" + this.formId).serialize();
		}
		$.ajax({
			url : this.url,    
			type : "POST",   
			data : this.param,
			async : this.async, 
			//beforeSend: function() {
			//	return loginCheck(this.url);
			//},
			success : function(data, status) {
				if(typeof(fv_ajaxCallback) == "function"){
					fv_ajaxCallback(data);
				}
				else {
					eval(fv_ajaxCallback + "(data);");
				}
				
			},
		});
	};
}

function jsonfy(form){
	 
	var result = { }; 
	$.each($(form).serializeArray(), function(i, obj) { result[obj.name] = obj.value }) 
	return result;
}


/**
 * GET 파라미터를 인자의 KEY값으로 가져온다. 
 */
var getParam = function(key){
    var _parammap = {};
    document.location.search.replace(/\??(?:([^=]+)=([^&]*)&?)/g, function () {
        function decode(s) {
            return decodeURIComponent(s.split("+").join(" "));
        }

        _parammap[decode(arguments[1])] = decode(arguments[2]);
    });

    return _parammap[key];
};

/**
 * 2018.04.24 김정호
 * 	영문 문자의 첫번째만 대문자로 변경
 */
function initCap(str) {
	return str.charAt(0).toUpperCase() + str.slice(1);
 }

/**
 * 2018.04.24 김정호
 * 	> 웹 접근성 인증마크 관련 Tree에 탭 이벤트 및 클릭이벤트를 바인드한다.(메인화면 통계표 트리)
 * @param _id		트리 id
 * @param _isSelf	현재의 element에게 이벤트를 줄때(false시는 체크박스르 체크한다.) 
 * @returns {Boolean}
 */
function eventZTreeTabFocus(_id, _isSelf) {
	if ( gfn_isNull(_id) ) {
		return false;
	}
	
	var _isSelf = _isSelf || false;
	
	// 트리 id 의 길이만큼 for loop
	$("#" + _id + " li").each(function(index, element) {
		var li = $(this);
		var liId = $(this).attr("id");
		
		// 트리의 열기/접기 엔터 이벤트 처리
		$("#"+ liId + "_switch").each(function(index, element) {
			// 아이템이 없는경우 해당 아이템으로 탭 이동 안되도록 처리
			if ( $(this).hasClass("center_docu") || $(this).hasClass("bottom_docu") || $(this).hasClass("root_docu") || $(this).hasClass("roots_docu") ) {
	        	$(this).attr("tabindex", "1");
			}
			else {
	        	$(this).attr("title", "열기/닫기");
	        	$(this).bind("keydown", function(event) {
	        		if (event.which == 13) {
	        			$(this).click();

	        			// root 트리는 하위 재귀호출 안함.
	        			if ( !li.hasClass("level0") ) {
	        				eventZTreeTabFocus(liId, _isSelf);
	        			} 
	        			return false;
	        		}
	        	});
	        }
		});
		
		// 아이콘에 title을 처리한다.
		$("#"+ liId + "_ico").each(function(index, element) {
			if ( $(this).hasClass("ico_docu") ) {
        		$(this).attr("title", "아이템");
        	} 
			else {
        		$(this).attr("title", "폴더");
        	}
		});
		
		// 아이템에 엔터 이벤트를 준다.
		$("#"+ liId + "_a").each(function(index, element) {
			$(this).bind("keydown", function(event) {
	    		if (event.which == 13) {
	    			if ( _isSelf ) {
	    				$(this).click();
	    			} 
	    			else {
	    				// 탭에서 호출한 경우는 엔터 이벤트시 체크박스가 선택되어야 함.
	    				li.find("#" + liId + "_check").click();
	    			}
	    			return false;
	    		}
	    	});
		});
	});
	
}

/**
 * 조회된 데이터를 dynaTree 구조에 맞게 변경
 * @param jsonData
 * @returns {Array}
 */
function buildTreeStructure(jsonData) {  
	var treeJson = [];  
	var children = [];    
	for (i = 0; i < jsonData.length; i++) {  
	   var item = jsonData[i];  
	   item.title = item.viewItmNm;
	   item.key = item.datano;
	   item.isFolder = item.leaf == "C" || item.leaf == "O" ? true : false;
	   item.expand = item.open == "true" ? true : false;
	   item.select = item.checked == "true" ? true : false;
			   
	   var parentid = item.parDatano;  
	   var id = item.datano;  
	   if (children[parentid]) {  
	      if (!children[parentid].children) {  
	         children[parentid].children = [];  
	      }  
	      children[parentid].children[children[parentid].children.length] = item;  
	      children[id] = item;  
	   }  
	   else {  
	      children[id] = item;  
	      //treeJson[id] = children[id];  
	      treeJson.push(children[id]);
	   }  
	}  
	return treeJson;  
} 

/**
 * GET으로 입력된 parameter를 array단위로 추출
 * @param param	전체 파라미터 String
 * @param key	추출하려는 키값
 * @returns 	{Array}
 */
function getParamStringArr(param, key) {
	var key = key || ""
	var arr = [];
	var param = param || ""; 
	var s = param.split("&"); // 설정하려는 파라미터 값들
	
	for (var i = 0; i < s.length; i++) {
		var el = s[i]; // ex) dtacycleCd=MM
		var elDt = el.substr(el.indexOf("=") + 1); // key를 뺀 값
		if (!gfn_isNull(key)) {
			if (el.indexOf(key) > -1) {
				// 키 값이 str에 있으면
				arr.push(elDt);
			}
		} else {
			arr.push(elDt);
		}
	}
	return arr;
}

/**
 * GET으로 입력된 parameter를 값으로 추출
 * @param param	전체 파라미터 String
 * @param key	추출하려는 키값
 * @returns 	{String}
 */
function getParamString(param, key) {
	var val = "";
	var param = param || ""; 
	var key = key || "";
	var s = param.split("&"); // 설정하려는 파라미터 값들
	for (var i = 0; i < s.length; i++) {
		var el = s[i];
		var elDt = el.substr(el.indexOf("=") + 1); // key를 뺀 값
		if (el.indexOf(key) > -1) {
			val = elDt;
		}
	}
	return val;
}

function mix_sheet(sheet_obj)
{
	with (sheet_obj)  
	{
		//헤더설정
		SetHeaderBackColor("#7590af");			//해더행 배경색옅은 하늘색
		SetHeaderFontBold(true);				//해더행 볼드
		SetHeaderFontColor("#ffffff");			//해더행 글자색
		SetHeaderRowHeight(24); 				//해더 행 높이         
		
		//데이터설정
		SetDataBackColor("#FFFFFF");			//데이터행 배경색(홀수)
		SetDataAlternateBackColor("#FFFFFF");	//데이터행 배경색(짝수)
		SetDataFontColor("#444444");			//데이터행 글자색
		SetDataRowHeight(23);					//데이터행 높이
		
		//합계설정
		SetSumBackColor("#E6E6E6");
		SetSubSumBackColor("#00FF00");			//소계행 배경색         
		SetSumFontBold(true);					//합계행 볼드
		SetSumFontColor("#5a5a5a");				//합계행 글자색
		
		//기타설정
		SetSheetFontName("Malgun Gothic");		//글자체 설정
		SetSheetFontSize(11);					//글자크기 설정
		SetSelectionMode(1);					//셀 선택 모드(0:셀단위, 1:행단위)
		SetCountPosition(4);					//건수위치,0:없음,1:좌상,2:우상,3:좌하,4:우하
		SetWaitImageVisible(1);					//대기이미지표시 여부
		//SetWaitImage("Url");					//대기이미지설정
		//SetSavingImage("Url");				//저장이미지설정
		
		SetEditableColorDiff(0)					//편집가능 여부에 따른 셀의 배경색을 구분하여 표시할지 여부를 설정 한다.
	}
}

/**
 * 난수생성
 * @param fixed 자를 자리수
 * @returns fixed 만큼 자른 문자열
 */
function gfn_randomToFixed(fixed) {
	var seed = com.wise.util.formatDate('', 'yyyyMMddHH24mmssSSS');
	var x = Math.sin(seed++) * 10000;
	var strNum = (x - Math.floor(x)).toString();
	fixed = fixed || strNum.length;
	return strNum.substr(strNum.indexOf(".")+1, (fixed <= strNum.length ? fixed : strNum.length));
}

/**
 * 난수생성
 * @returns	랜덤 숫자
 */
function gfn_random() {
	var seed = com.wise.util.formatDate('', 'yyyyMMddHH24mmssSSS');
	var x = Math.sin(seed++) * 10000;
	return x - Math.floor(x);
}

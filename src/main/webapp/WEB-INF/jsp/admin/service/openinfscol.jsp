<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>       
<!--
	validate 사용시 반드시 선언
	formName명과 validate 함수명이 연결되어있음
	adminCommUsr -> validateAdminCommUsr 체크함
	resources/validator/*.* xml을 만들어서 사용
  -->
<validator:javascript formName="adminOpenInfScol" staticJavascript="false" xhtml="true" cdata="false"/>       
<script language="javascript">                
//<![CDATA[                              

function setScol(SSheet){   
	var srvYn = false;
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenInfScol]");
	
	var append = "";
	append += "<div>";  
	if (formObj.find("input[name=tmnlImgFile]").val() != "") {
		formObj.find("input[name=uploadTmnlfile]").hide();
		var tmnlImgFile = formObj.find("input[name=tmnlImgFile]").val();
		var infId = formObj.find("input[name=infId]").val();
		var param = "downCd=SH&fileSeq=1&seq=1&etc="+infId;
		append += "<div class='img-box'>";
		append += "<p><img src=\"<c:url value='/admin/service/fileDownload.do?"+param+"'/>\" alt='"+tmnlImgFile+"' width='120' height='120'/></p>";
		append += "</div> ";
	} else{
		formObj.find("button[name=btn_init]").eq(0).hide();
		formObj.find(".appendImg div").remove();
	}
	append += "</div>";
	formObj.find(".appendImg").append(append);
	
	formObj.find("button[name=btn_init]").eq(0).click(function(e) {				//썸네일초기화
		doActionScol('tmnlInit');
		return false; 
	});
	
	formObj.find("a[name=a_reg]").click(function(e) { //등록
		doActionScol('reg');                 
		return false;                 
	});                 
	formObj.find("a[name=a_save]").click(function(e) { //저장
		doActionScol('save');                 
		return false;                 
	});          
	formObj.find("a[name=a_up]").click(function(e) { //위로
		doActionScol('moveUp');                 
		return false;                 
	}); 
	formObj.find("a[name=a_down]").click(function(e) { //아래로
		doActionScol('moveDown');                 
		return false;                 
	}); 
	formObj.find("a[name=a_view]").click(function(e) { //미리보기
		doActionScol('view');                 
		return false;                 
	});
	formObj.find(':radio[name="srvYn"]').click(function(e) {    	//서비스여부 변경시 이전value와 비교 
		if ( $(this).val() != formObj.find("input[name=beforeSrvYn]").val()) {
			formObj.find("input[name=dataModified]").val("Y");
		} else {
			formObj.find("input[name=dataModified]").val("");
		}
 	});
	if(formObj.find(':radio[name="srvYn"]:checked').val() !=undefined){
		formObj.find("a[name=a_reg]").hide();
		srvYn = true;                                         
	}else{               
		formObj.find("a[name=a_up]").hide();          
		formObj.find("a[name=a_down]").hide();               
		formObj.find("a[name=a_save]").hide();
		formObj.find("a[name=a_view]").hide();                  
	}     
	
	if(formObj.find("input[name=SSheetNm]").val() ==""){
		formObj.find("input[name=SSheetNm]").val(SSheet);    
	}
	
	//데이터셋상세 팝업
	objTab.find("button[name=btn_dataSetDtl]").click(function(e) {
		doAction('dataSetDtl');                 
		return false;                            
	});
	//메타상세 팝업
	objTab.find("button[name=btn_metaDtl]").click(function(e) { 
		doAction('metaDtl');                 
		return false;                            
	});
	
	formObj.find("input[name=beforeSrvYn]").val(formObj.find(':radio[name="srvYn"]:checked').val());	//저장한내역 확인하기위해
	
	formObj.find("input[name=srvCd]").val("S"); 
	setLabal(formObj,"S");            
			                       
	return srvYn;
} 
           
function initScol(sheetName,Scol){
	 var srvYn  = setScol(Scol);                      
	 if(srvYn){
		 LoadPageScol(sheetName)
	 }         
 }
 function LoadPageScol(sheetName)                
{                               
	var gridTitle = "<spring:message code='labal.status'/>";  
	    gridTitle += "|NO"       
		gridTitle +="|"+"<spring:message code='labal.infId'/>";           
		gridTitle +="|"+"<spring:message code='labal.infSeq'/>";   
		gridTitle +="|"+"<spring:message code='labal.colSeq'/>";   
		gridTitle +="|"+"<spring:message code='labal.colId'/>";        
		gridTitle +="|"+"<spring:message code='labal.colNm'/>";    
		gridTitle +="|"+"<spring:message code='labal.viewCd'/>";    
		//gridTitle +="|"+"<spring:message code='labal.alignTag'/>";  
		gridTitle +="|"+"출력정렬";
		gridTitle +="|"+"<spring:message code='labal.viewSize'/>";    
		gridTitle +="|"+"<spring:message code='labal.sortTag'/>";  
		gridTitle +="|"+"<spring:message code='labal.viewYn'/>";   
		gridTitle +="|"+"<spring:message code='labal.optSet'/>";    
		gridTitle +="|"+"<spring:message code='labal.useYn'/>";
		gridTitle += "|순서"
	
    with(sheetName){
    	                     
    	var cfg = {SearchMode:3,Page:50};                                        
        SetConfig(cfg);  
        var headers = [                                                                   
                    {Text:gridTitle, Align:"Center"}                          
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:1};         
                        
        InitHeaders(headers, headerInfo); 
            
        
        //문자는 왼쪽정렬
        //숫자는 오른쪽정렬
        //코드값은 가운데정렬
        var cols = [                 
					{Type:"Status",	SaveName:"status",				Width:50,	Align:"Center",		Edit:false}      
					,{Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"infId",			Width:100,	Align:"Right",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"infSeq",			Width:100,	Align:"Right",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"colSeq",			Width:100,	Align:"Right",		Edit:false, Hidden:true}
					,{Type:"Popup",		SaveName:"colId",			Width:150,	Align:"Center",		Edit:true}
					,{Type:"Text",		SaveName:"colNm",			Width:200,	Align:"Left",		Edit:false}
					,{Type:"Combo",		SaveName:"viewCd",			Width:70,	Align:"Center",		Edit:true}
					,{Type:"Combo",		SaveName:"alignTag",		Width:70,	Align:"Center",		Edit:true}
					,{Type:"Int",		SaveName:"viewSize",		Width:70,	Align:"Right",		Edit:true}             
					,{Type:"Combo",		SaveName:"sortTag",			Width:70,	Align:"Center",		Edit:true}
					,{Type:"CheckBox",	SaveName:"viewYn",		Width:70,	Align:"Center",		Edit:true, TrueValue:"Y", FalseValue:"N"}
					,{Type:"Popup",		SaveName:"soptSet",			Width:90,	Align:"Center",		Edit:true}
					,{Type:"CheckBox",	SaveName:"useYn",		Width:70,	Align:"Center",		Edit:true, TrueValue:"Y", FalseValue:"N"}
					,{Type:"Text",		SaveName:"vOrder",			Width:30,	Align:"Right",		Edit:false,	Hidden:true}
                                         
                ];                                                                   
                                                            
               
        InitColumns(cols);                              
        SetExtendLastCol(1);   
        FitColWidth();  
        //SetColProperty("colId", 	${codeMap.viewCdIbs}  );    //InitColumns 이후에 셋팅 
        SetColProperty("viewCd", 	${codeMap.viewCdIbs});    //InitColumns 이후에 셋팅 
        SetColProperty("sortTag", 	{ComboCode:"|A|D", 	ComboText:"|Asc|Desc"});    //InitColumns 이후에 셋팅 
        SetColProperty("alignTag", 	{ComboCode:"L|C|R", 	ComboText:"Left|Center|Right"});    //InitColumns 이후에 셋팅 
    }                   
    default_sheet(sheetName);              
    doActionScol("search")
}   


function doActionScol(sAction)                                  
{
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var actObj = setTabForm2(classObj,"adminOpenInfScol"); // 0: form data, 1: form 객체
	var sheetObj; //IbSheet 객체         
	var param = actObj[0]  ;  
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	
	var formObj = objTab.find("form[name=adminOpenInfScol]");
	sheetObj =formObj.find("input[name=SSheetNm]").val();     
	ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
	var gridObj = window[sheetObj];
	switch(sAction)                    
	{          
		case "tmnlInit": 	// 썸네일 초기화
	 		formObj.find("input[name=uploadTmnlfile]").show();
	 		formObj.find("input[name=tmnlImgFile]").val("");
	 		formObj.find(".appendImg div").remove();
	 		formObj.find("button[name=btn_init]").eq(0).hide();
	 		break;
		case "search":      //조회    
			gridObj.DoSearch("<c:url value='/admin/service/openInfColList.do'/>", param); 
		
		
			break;                    
		case "reg":      //등록
			if (!validateAdminOpenInfScol(document.adminOpenInfScol[1])){
				return;                               
			}
		
			if(formObj.find("input[name=ownerCd]").val() == ""){
				alert("데이터셋이 등록되지 않았습니다.");           
				return;    
			}
			var url ="<c:url value='/admin/service/openInfColReg.do'/>";
			
			$(formObj).ajaxSubmit({
 		        beforeSubmit:function(data, form, options) {
 		            return true;
 		        },
 		        url:url,
 		        dataType:"json",
 		        success:colScallback,
 		        error:function(request, status, error) {
 		        }
 		    });
			
			//ajaxCallAdmin(url, param,colcallback);
			LoadPageScol(gridObj)                                   
			formObj.find("a[name=a_reg]").hide();
			formObj.find("a[name=a_up]").show();        
			formObj.find("a[name=a_down]").show();
			formObj.find("a[name=a_save]").show();
			formObj.find("a[name=a_view]").show();                   
			break;                                        
		case "save":      //저장            
			//ibsSaveJson = gridObj.GetSaveString();                                          
			ibsSaveJson = gridObj.GetSaveJson();                                          
			if(ibsSaveJson.data.length == 0) return;
			
			var dataModified = false;
 			if ( formObj.find("input[name=dataModified]").val() == "Y" ) {		//서비스여부 변경하였는지 체크
 				dataModified = true;
 			}
 			if ( formObj.find("input[name=tmnlImgFile]").val() == "") {		//서비스여부 변경하였는지 체크
 				formObj.find("input[name=dataModified]").val("Y"); 
 				 dataModified = true;
 			}
 			
 			if ( !gridObj.IsDataModified() ) {
 				if ( !dataModified ) {
 					alert("저장할 내역이 없습니다.");
 					return;
 				}
 			}
			
			var url = "<c:url value='/admin/service/openInfScolSave.do'/>";
			
			
			formObj.ajaxSubmit({
	            url : com.wise.help.url("/admin/service/openInfScolSave.do") + "?ibsSaveJson=" + encodeURIComponent(JSON.stringify(ibsSaveJson))
	            , async : false
	            , type : 'post'
	            , dataType: 'json' 
	            //, data: {ibsSaveJson: JSON.stringify(ibsSaveJson)}
	            , contentType : 'application/x-www-form-urlencoded;charset=UTF-8'
	            //, contentType: 'application/json'
	            , beforeSubmit : function() {
	               return true;
	            }   
	            , success : function(res, status) {
	            	 alert("저장되었습니다.");  
	            	 doActionScol("search");
	            	 alert("회원들에게 API정보 변경 알림이 발송됩니다.");
	            }
	            , error: function(jqXHR, textStatus, errorThrown) {
	               alert("처리 도중 에러가 발생하였습니다.");
	            }
	         });
			break;         
		case "moveUp":
				var row = gridObj.GetSelectRow();
				gridMove(gridObj,row-1,"vOrder","Y"); //그리드객체, 이동번호, 정렬컬럼, 정렬여부
			break;                 
		case "moveDown":                         
				var row = gridObj.GetSelectRow();               
				gridMove(gridObj,row+2,"vOrder","Y");                                  
			break;       
		case "view":                         
			var infId = formObj.find("input[name=infId]").val();                  
			var srvCd = formObj.find("input[name=srvCd]").val();
			var target = "<c:url value='/admin/service/openInfColViewPopUp.do?infId="+infId+"&srvCd="+srvCd+"'/>";
			var wName = "scolview"        
			var wWidth = "1100";
			var wHeight = "768" ;                               
			var wScroll ="no";
			OpenWindow(target, wName, wWidth, wHeight, wScroll);                
		break; 
	}                           
}
function colScallback(res){
    var result = res.RESULT.CODE;
    if(result > 0) {
    	alert(res.RESULT.MESSAGE);                  
    	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
    	var objTabDiv = getTabShowObjForm("srvColDiv");//탭이 oepn된 div객체가져옴
    	var val =objTabDiv.find(':radio[name="srvYn"]:checked').val();
    	var srvCd = objTabDiv.find("input[name=srvCd]").val();
    	var index = typeIndex(srvCd);
    	if(val =="Y"){                                 	                    
    		objTab.find(".tab-inner").find("a").eq(index).removeClass("no-service").addClass("service");
		}else{                 
			objTab.find(".tab-inner").find("a").eq(index).removeClass("no-service").removeClass("service");                       
		}                                  
    	doActionFcol("getMstSeq");
    	doActionFcol("getInfSeq");
    } else {                               
    	alert(res.RESULT.MESSAGE);                  
    }
}  
//]]>            
</script>             
<div name="srvColDiv" style="display:none">                                                  
	<form name="adminOpenInfScol"  method="post" action="#" enctype="multipart/form-data" >
				<input type="hidden" name="infId">                          
				<input type="hidden" name="SSheetNm"> 
				<input type="hidden" name="srvCd" value="">
				<input type="hidden" name="prssAccCd">
				<input type="hidden" name="dataModified">
				<input type="hidden" name="beforeSrvYn" value="">                        
				<table class="list01">
					<caption>공공데이터목록리스트</caption>
					<colgroup>
						<col width="150"/>
						<col width=""/>
					</colgroup>
					<tr>
						<th><spring:message code='labal.infNm'/></th>            
						<td>
							<input type="text" name="infNm" value="" style="width:500px" placeholder="(한)" ReadOnly/>
							${sessionScope.button.btn_dataSetDtl}         
							${sessionScope.button.btn_metaDtl}
						</td>         
					</tr>        
					<tr>   
						<th><spring:message code='labal.dataSet'/></th>
						<td id="sinfo">
							<input type="text" name="ownerCd"  style="width:150px" value="" placeholder="OWNER" ReadOnly/> 
							<input type="text" name="dsId" style="width:200px" value="" placeholder="DS_ID" ReadOnly/>
							<input type="text" name="dsNm"  style="width:250px"value="" placeholder="DS_NM" ReadOnly/>
							
							
							<!-- 
							
							요기여.. 요기..
							<input type="radio" name="apiVersion" onclick="apiVersion_click(1);" value="V1" checked=checked /><b>V1</b>
							&nbsp;&nbsp;
							<input type="radio" name="apiVersion" onclick="apiVersion_click(2);" value="V2" /><b>V2</b>
							&nbsp;&nbsp;
							<select name="sgrpCd">
								<option value="">제헌</option>
								
								<option value="">제2대</option>
								<option value="">제3대</option>
								<option value="">제4대</option>
								<option value="">제5대</option>
								<option value="">제6대</option>
								<option value="">제7대</option>
								<option value="">제8대</option>
								<option value="">제9대</option>
								<option value="">제10대</option>
								<option value="">제11대</option>
								<option value="">제12대</option>
								<option value="">제13대</option>
								<option value="">제14대</option>
								<option value="">제15대</option>
								<option value="">제16대</option> 
								<option value="">제17대</option>
								<option value="">제18대</option>
								<option value="">제19대</option>
								<option value="">제20대</option>
								<option value="">제21대</option>
								
								
							</select> -->
						</td>
					</tr>
					<tr>						
						<th>서비스 구분</th>                 
						<td>
							<select name="sgrpCd">
								<option value="">선택</option>
								<c:forEach var="code" items="${codeMap.fileCd}" varStatus="status">
									<option value="${code.ditcCd}">${code.ditcNm}</option>
								</c:forEach>
							</select>
						</td>
					</tr>   
					<tr>
						<th rowspan="2">이미지</th>                 
						<td>
							<div class="appendImg">
							</div>
							<input type="hidden" id="tmnlImgFile" name="tmnlImgFile"/> 
							<input type="file" id="uploadTmnlfile" name="uploadTmnlfile" accept="image/*" /> 
							${sessionScope.button.btn_init}
						</td>
					</tr>
					<tr>
						<td>
							size : 96*136px
						</td>
					</tr>
					<tr>
						<th><spring:message code='labal.srvYn'/> <span>*</span></th>                 
						<td>                          
							<input type="radio" value="Y" id="Suse" name="srvYn"/>
							<label for="Suse"><spring:message code='labal.yes'/></label>  
							<input type="radio" value="N" id="Sunuse" name="srvYn"/>
							<label for="Sunuse"><spring:message code='labal.no'/></label>
						</td>
					</tr>        
				</table>	
				
				
				<!-- ibsheet 영역 -->
				<div class="ibsheet_area" name="Scol">               
				</div>                       
				
				<div class="buttons">
					${sessionScope.button.a_up}       
					${sessionScope.button.a_down}           
					${sessionScope.button.a_reg}       
					<%-- ${sessionScope.button.a_save} --%>
					<a href="javascript:;" class="btn03" title="저장" name="a_save">저장</a>       
					${sessionScope.button.a_view}       
				</div>		
	</form> 
</div>
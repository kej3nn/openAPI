
$(document).ready(function()    {    
	LoadPage();                                                               
	init();
	setDate(); //날짜
	setCate();
	doAction('search');
}); 

function init(){
	var formObj = $("form[name=statUse]");
	formObj.find("input[name=pubDttmTo]").datepicker(setCalendar());          
	formObj.find("input[name=pubDttmFrom]").datepicker(setCalendar());      
	datepickerTrigger();     
	formObj.find("button[name=btn_inquiry]").click(function(e) { //조회
		doAction("search");
		return false;
	});
	formObj.find("input[name=infNm]").bind("keydown", function(event) {
        if (event.which == 13) {
    		doAction("search");
    		return false;
        }
    });
	formObj.find("button[name=btn_xlsDown]").click(function(e) { //엑셀다운
		doAction("excel");
		return false;
	});
}

function setDate(){
	var formObj = $("form[name=statUse]");

	var now = new Date(Date.parse(new Date)-1*1000*60*60*24);
	var before = new Date(Date.parse(new Date)-1*1000*60*60*24);
	before.setMonth(before.getMonth()-1);
	var monTo = (now.getMonth()+1)>9?now.getMonth()+1:'0'+(now.getMonth()+1);
	var monFrom = (before.getMonth()+1)>9?before.getMonth()+1:'0'+(before.getMonth()+1);
	var day = (now.getDate())>9?(now.getDate()):'0'+(now.getDate());
	var dayFrom = (before.getDate())>9?(before.getDate()):'0'+(before.getDate());
	var dateTo=now.getFullYear()+'-'+monTo+'-'+day;
	var dateFrom=before.getFullYear()+'-'+monFrom+'-'+dayFrom;
	formObj.find("input[name=pubDttmFrom]").val(dateFrom);
	formObj.find("input[name=pubDttmTo]").val(dateTo);
	
	formObj.find("img[src='../../images/admin/icon_calendar.png']").attr("src", "../../../images/admin/icon_calendar.png")
}

function setCate() {
	$.post(getContextPath+'/admin/mainmng/selectListCate.do', function(data){
		var formObj = $("form[name=statUse]");
		var select = formObj.find("select[name=cateId]");
		$.each(data.DATA, function(i, data) {
			select.append('<option value="' + data.cateId + '">'+data.cateNm+'</option>');
		});
	});
}

function LoadPage()                
{      
	//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	var gridTitle = "NO";
		gridTitle +="|"+"가입구분";
		gridTitle +="|"+"닉네임";
		gridTitle +="|"+"인증키";
		gridTitle +="|"+"공공데이터명";
		gridTitle +="|"+"API서비스명";
		gridTitle +="|"+"형태";
		gridTitle +="|"+"요청건수";
		gridTitle +="|"+"출력건수";
		gridTitle +="|"+"응답시간";
		gridTitle +="|"+"처리일시";
	
    with(mySheet){
    	                     
    	var cfg = {SearchMode:2,Page:50,VScrollMode:1};
        SetConfig(cfg);  
        var headers = [                                             
                    {Text:gridTitle, Align:"Center"}                 
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
        
        InitHeaders(headers, headerInfo); 
      	//문자는 왼쪽정렬
        //숫자는 오른쪽정렬
        //코드값은 가운데정렬        
        var cols = [ 
					 {Type:"Seq",		SaveName:"seq",				Width:25,	Align:"Center",		Edit:false, Sort:false}
					,{Type:"Text",		SaveName:"siteNm",			Width:30,	Align:"Left",		Edit:false, Sort:false}
					,{Type:"Text",		SaveName:"userNm",			Width:50,	Align:"Left",		Edit:false, Sort:false}
					,{Type:"Text",		SaveName:"actKey",			Width:100,	Align:"Left",		Edit:false, Sort:false}
					,{Type:"Text",		SaveName:"infnm",			Width:100,	Align:"Left",		Edit:false, Sort:false}
					,{Type:"Text",		SaveName:"apiResP",			Width:100,	Align:"Left",		Edit:false, Sort:false}
					,{Type:"Text",		SaveName:"dnType",			Width:50,	Align:"Center",		Edit:false, Sort:false}
					,{Type:"AutoSum",		SaveName:"reqCnt",			Width:30,	Align:"Right",		Edit:false, Sort:false}
					,{Type:"AutoSum",		SaveName:"rowCnt",			Width:30,	Align:"Right",		Edit:false, Sort:false}
					,{Type:"Text",		SaveName:"lendtime",			Width:30,	Align:"Right",		Edit:false, Sort:false}
					,{Type:"Text",		SaveName:"regDttm",			Width:50,	Align:"Center",		Edit:false, Sort:false}
                   ];       
                                      
        InitColumns(cols);                                                                           
        FitColWidth();                                                         
        SetExtendLastCol(1);   
    }               
    default_sheet(mySheet); 
    mySheet.SetCountPosition(4); 
    mySheet.SetSumValue(0,"dtNm","합계"); 
    mySheet.SetAutoSumPosition("1"); //autoSum 위치 지정 1은 최하단 0은 최상단
} 

/*Sheet 각종 처리*/                  
function doAction(sAction)                                  
{
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	var formObj = $("form[name=statUse]");
//	var flag = false;  
//	var pattern =/[&]/gi;             
//	var pattern2 =/[=]/gi;             
	switch(sAction)
	{          
		case "search":      //조회
			        
			fromObj = formObj.find("input[name=pubDttmFrom]");
			toObj = formObj.find("input[name=pubDttmTo]");
			dateValCheck(fromObj,toObj)// from , to 날짜 안맞을 경우 자동셋팅
			
			ajaxBeforeSendAdmin(getContextPath+"/admin/ajaxBeforeSendAdmin.do"); //IbSheet 조회전 세션 체크

			//시트 조회
			var param = {PageParam: "ibpage", Param: "onepagerow="+IBSHEETPAGENOW+"&"+actObj[0]};
			mySheet.DoSearchPaging(getContextPath+"/admin/stat/use/getActKeySheetAll.do", param);   
			
			//차트 조회
			//ajaxCallAdmin("<c:url value='/admin/stat/use/getUseStatDtChartAll.do'/>",formObj.serialize(),initializeChart);
			
			break;
			
			case "excel":      //엑셀다운 - 이 방법이 아니라 openinfccolview.jsp의 197라인을 참고해서 할수도있음(이방법은 현재 시트에 처리중입니다라고 뜸)
			/* mySheet.Down2Excel({FileName:'excel2',SheetName:'mySheet'});
			break; */
			//var param = {FileName:"Excel"+formObj.find("input[name=pubDttmTo]").val()+".xls",SheetName:"mySheet",Merge:1,SheetDesign:1 };
			mySheet.Down2Excel({FileName:'인증키활용현황.xls',SheetName:'mySheet'});
			break;
			
			/* formObj.find("input[name=queryString]").val(formObj.serialize());
			formObj.attr("action","<c:url value='/admin/stat/statUseXlsdownload.do'/>").submit();        
			break; */
	}           
}   
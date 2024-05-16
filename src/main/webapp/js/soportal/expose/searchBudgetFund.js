/*
 * @(#)searchBudgetFund.js 1.0 2019/07/22
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 정보공개 > 세입·세출예산운용 스크립트이다.
 *
 * @author SoftOn
 * @version 1.0 2018/04/19
 */
$(function() {
    // 컴포넌트를 초기화한다.
    initComp();

    // 이벤트를 바인딩한다.
    bindEvent();

    // 데이터를 로드한다.
    loadDataIn();
});

////////////////////////////////////////////////////////////////////////////////
// 초기화 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
	var now = new Date();
	var year= now.getFullYear();
	var mon = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
	var day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();
	var chan_val = year + '-' + mon + '-' + day;
	$(this).val(chan_val);
	
	//검색기간 select년도 Setting
	var startYY = 2014;
	var selHtml = "";
	for(var i=year; i>=startYY; i--){
		selHtml = "<option value='"+i+"'>"+i+"</option>";
		$("#FSCL_IN_YY").append(selHtml);
		$("#FSCL_OUT_YY").append(selHtml);
	}
	var startMM = 1;
	for(var i=startMM; i<=13; i++){
		var mi = i < 10 ? "0"+i : i;
		selHtml = "<option value='"+mi+"'>"+mi+"</option>";
		$("#EXE_IN_M").append(selHtml);
		$("#EXE_OUT_M").append(selHtml);
	}
	for(var i=1; i<=31; i++){
		var di = i < 10 ? "0"+i : i;
		selHtml = "<option value='"+di+"'>"+di+"</option>";
		$("#EXE_OUT_DATE").append(selHtml);
	}
	
 	var mm = "";
	$("#FSCL_IN_YY").val(year);
	$("#FSCL_OUT_YY").val(year);

	if(mon == '01'){
		$("#FSCL_IN_YY").val(year-1);
		$("#FSCL_OUT_YY").val(year-1);
		mon='13';
	}
	if(mon == '02'){
		$("#FSCL_IN_YY").val(year-1);
		$("#FSCL_OUT_YY").val(year-1);
		mon='14';
	}
	mm = mon-2;
	
	if(mm < 10) mm = "0"+mm;
	 
	$("#EXE_IN_M").val(mm);
	$("#EXE_OUT_M").val(mm);
}

/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {

	//탭 이벤트
	$("#tabs li").bind("click", function(e) {
		$("#tabs li").removeClass("on");
		$(this).addClass("on");
		
		var index = $(this).index()+1;
		$("div[id ^= \"contents_0\"]").hide();
		$("#contents_0"+index).show();
		
		if(index==1) searchFm_firstIn();
		if(index==2) searchFm_firstOut();
	});
}

/**
 * 데이터를 로드한다.
 */
function loadDataIn() {
	searchFm_firstIn();
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수 > 수입징수현황
////////////////////////////////////////////////////////////////////////////////
/**
 * 데이터를 검색한다.
 * 
 * @param page {String} 페이지 번호
 */
function searchFm_firstIn() {
	
	if($("#FSCL_IN_YY").val()==""){			
		alert("년도는 필수값 입니다.");
		return false;
	}
	
	if($("#EXE_IN_M").val()==""){			
		alert("월은 필수값 입니다.");
		return false;
	}
	
	searchVmFormIn();
}

/* 수입징수현황 */
function searchVmFormIn(){
	var frm = document.formIn;
	
	if(frm.s_gubunIn[0].checked == true){
		var day = $("#EXE_IN_DATE").val();
		
		if (day == "") {
			// 표 타이틀 수정
			$("#gubunTrIn1").show();
			$("#gubunTrIn2").hide();
			$("#gubunTrIn3").hide();
			searchVmFormIn1();
		}else {
			// 표 타이틀 수정
			$("#gubunTrIn1").hide();
			$("#gubunTrIn2").show();
			$("#gubunTrIn3").hide();
			searchVmFormIn2();
		}
	}else {
		// 표 타이틀 수정
		$("#gubunTrIn1").hide();
		$("#gubunTrIn2").hide();
		$("#gubunTrIn3").show();
		searchVmFormIn3();
	}
}

/* 월별 수입징수현황 (수입항)*/
function searchVmFormIn1()
{
    var params="";
	var innerHtml = "";
    params += "key=MXTJE1000010620151021040853FXSRB"; 
    params += "&type=json";
    params += "&FSCL_YY="+$("#FSCL_IN_YY").val();
    params += "&EXE_M="+$("#EXE_IN_M").val();
    params += "&OFFC_CD=006";
 
    var url="http://openapi.openfiscaldata.go.kr/VWFORM2?"+params+"&callback=?";
    
    
    $.getJSON(url, function (data) {
        if(typeof data.VWFORM2!="undefined"){
    		 for(var i = 0; i < data.VWFORM2[1].row.length; i++){
    			    innerHtml+="<tr>";
    	        	$.each( data.VWFORM2[1].row[i], function( key, val ) {
    	        		  if(key=="FSCL_NM"|| key=="IKWAN_NM"|| key=="IMOK_NM"){	        	        			  
    	        			  innerHtml +="<td align='center' id='" + key + "'><span>" + val + "</span></td>";
    	        		  }
    	        		  else if(key=="IHANG_NM"){
    	        			  innerHtml +="<td colspan='2' align='center' id='" + key + "'><span>" + val + "</span></td>";
    	        		  }
    	        		  else if(key=="BDG_CAMT"|| key=="RC_AMT" || key=="RC_AGGR_AMT"){
    	        			  innerHtml +="<td align='right' id='" + key + "'><span>" + comma(Math.round(val*0.000001)) + "</span></td>";
    	        		  }
    			    });
    	        	innerHtml+="</tr>";
    	        } 
        }else{
		    innerHtml="<tr>";
		    innerHtml+="<td class='noData' colspan='8'>조회된 데이터가 없습니다.</td>";
		    innerHtml+="</tr>";
        }

			 $('#vwFormIn').html(innerHtml);
    });
}

/* 일별 수입징수현황 (수입항)*/
function searchVmFormIn2()
{
    var params="";
	var innerHtml = "";
    params += "key=MXTJE1000010620151021040853FXSRB"; 
    params += "&type=json";
    params += "&FSCL_YY="+$("#FSCL_YY").val();
    params += "&EXE_DATE="+$("#FSCL_YY").val()+$("#EXE_IN_M").val()+$("#EXE_IN_DATE").val();
    params += "&OFFC_CD=006";
 
    var url="http://openapi.openfiscaldata.go.kr/VWFORD?"+params+"&callback=?";
    
    
    $.getJSON(url, function (data) {
        if(typeof data.VWFORD!="undefined"){
    		 for(var i = 0; i < data.VWFORD[1].row.length; i++){
    			    innerHtml+="<tr>";
    	        	$.each( data.VWFORD[1].row[i], function( key, val ) {
    	        		  if(key=="FSCL_NM"|| key=="IKWAN_NM"|| key=="IMOK_NM"){	        	        			  
    	        			  innerHtml +="<td align='center' id='" + key + "'><span>" + val + "</span></td>";
    	        		  }
    	        		  else if(key=="IHANG_NM"){
    	        			  innerHtml +="<td colspan='2' align='center' id='" + key + "'><span>" + val + "</span></td>";
    	        		  }
    	        		  else if(key=="BDG_CAMT"|| key=="TD_RC_AMT" || key=="RC_AGGR_AMT"){
    	        			  innerHtml +="<td align='right' id='" + key + "'><span>" + comma(Math.round(val*0.000001)) + "</span></td>";
    	        		  }
    			    });
    	        	innerHtml+="</tr>";
    	        } 
        }else{
		    innerHtml="<tr>";
		    innerHtml+="<td class='noData' colspan='8'>조회된 데이터가 없습니다.</td>";
		    innerHtml+="</tr>";
        }

			 $('#vwFormIn').html(innerHtml);
    });
}

/* 월별 수입징수현황 (수입목)*/
function searchVmFormIn3()
{
    var params="";
	var innerHtml = "";
    params += "key=MXTJE1000010620151021040853FXSRB"; 
    params += "&type=json";
    params += "&FSCL_YY="+$("#FSCL_IN_YY").val();
    params += "&EXE_M="+$("#EXE_IN_M").val();
    params += "&OFFC_CD=006";
 
    var url="http://openapi.openfiscaldata.go.kr/VWFORM?"+params+"&callback=?";
    
    
    $.getJSON(url, function (data) {
        if(typeof data.VWFORM!="undefined"){
    		 for(var i = 0; i < data.VWFORM[1].row.length; i++){
    			    innerHtml+="<tr>";
    	        	$.each( data.VWFORM[1].row[i], function( key, val ) {
    	        		  if(key=="FSCL_NM"|| key=="IKWAN_NM"|| key=="IHANG_NM" || key=="IMOK_NM"){	        	        			  
    	        			  innerHtml +="<td align='center' id='" + key + "'><span>" + val + "</span></td>";
    	        		  }else if(key=="BDG_CAMT"|| key=="RC_AMT" || key=="RC_AGGR_AMT"){
    	        			  innerHtml +="<td align='right' id='" + key + "'><span>" + comma(Math.round(val*0.000001)) + "</span></td>";
    	        		  }
    			    });
    	        	innerHtml+="</tr>";
    	        } 
        }else{
		    innerHtml="<tr>";
		    innerHtml+="<td class='noData' colspan='8'>조회된 데이터가 없습니다.</td>";
		    innerHtml+="</tr>";
        }

			 $('#vwFormIn').html(innerHtml);
    });
}

////////////////////////////////////////////////////////////////////////////////
//서비스 함수 > 지출집행현황
////////////////////////////////////////////////////////////////////////////////
/**
* 데이터를 검색한다.
* 
* @param page {String} 페이지 번호
*/
function searchFm_firstOut() {
	
	if($("#FSCL_OUT_YY").val()==""){			
		alert("년도는 필수값 입니다.");
		return false;
	}
	
	if($("#EXE_OUT_M").val()==""){			
		alert("월은 필수값 입니다.");
		return false;
	}
	
	searchVmFormOut();
}

/* 지출집행현황 */
function searchVmFormOut(){
	var frm = document.formOut;
	
	if(frm.s_gubunOut[1].checked == true){
		var day = $("#EXE_OUT_DATE").val();
		if (day == "") {			
			if($("#EXE_OUT_DATE").val()==""){			
				alert("일은 필수값 입니다.");
				return false;
			}
		}else {
			searchFm_X();

			// 표 타이틀 수정
			$("#gubunTrOut1").hide();
			$("#gubunTrOut2").hide();
			$("#gubunTrOut3").show();
			searchVmFoem3();
		}
	}else {
		searchFm_X();
		
		// 표 타이틀 수정
		$("#gubunTrOut1").show();
		$("#gubunTrOut2").hide();
		$("#gubunTrOut3").hide();
		searchVmFoem1();
	}
}

function searchFm_X(){
	innerHtml ="<tr>";
    innerHtml+="<td class='noData' colspan='11'>처리중입니다.</td>";
    innerHtml+="</tr>";
    $('#vwFormOut').html(innerHtml);
}

/* 월별 지출집행현황 */	
function searchVmFoem1(){
    var params="";
	var innerHtml = "";
    params += "key=MXTJE1000010620151021040853FXSRB"; 
    params += "&type=json";
    params += "&FSCL_YY="+$("#FSCL_OUT_YY").val();
    params += "&EXE_M="+$("#EXE_OUT_M").val();
    params += "&OFFC_CD=006";
    var url="http://openapi.openfiscaldata.go.kr/VWFOEM?"+params+"&callback=?";
    
    $.getJSON(url, function (data) {
    	if(typeof data.VWFOEM!="undefined"){
    		 for(var i = 0; i < data.VWFOEM[1].row.length; i++){
    			 innerHtml+="<tr>";
    	        	$.each( data.VWFOEM[1].row[i], function( key, val ) {
    	        		  /*  연도, 월, 회계, 분야, 부문, 프로그램, 단위사업, 예산, 당월집행액, 누계집행액  */
    	        		 if( key=="FSCL_NM"|| key=="FLD_NM"|| key=="SECT_NM"|| key=="PGM_NM" ){
    	        			 innerHtml +="<td align='center' id='" + key + "'><span>" + val + "</span></td>";	 
    	        		  }else if(key=="ACTV_NM"){
    	        			  innerHtml +="<td colspan='2' align='center' id='" + key + "'><span>" + val + "</span></td>";
    	        		  }else if(key=="ANEXP_BDG_CAMT" || key=="EP_AMT" || key=="THISM_AGGR_EP_AMT"){
    	        			  innerHtml +="<td align='right' id='" + key + "'><span>" + comma(Math.round(val*0.000001)) + "</span></td>";
    	        		  }
    			    });    
    	        	innerHtml+="</tr>";
    	        } 
        }else{
		    innerHtml ="<tr>";
		    innerHtml+="<td class='noData' colspan='11'>조회된 데이터가 없습니다.</td>";
		    innerHtml+="</tr>";
        }
			$('#vwFormOut').html(innerHtml);
    });
}

/* 월별 세부세출 집행현황 */	
function searchVmFoem2()
{
    var params="";
	var innerHtml = "";
    params += "key=MXTJE1000010620151021040853FXSRB"; 
    params += "&type=json";
    params += "&FSCL_YY="+$("#FSCL_OUT_YY").val();
    params += "&EXE_M="+$("#FSCL_OUT_YY").val()+$("#EXE_OUT_M").val();
    params += "&OFFC_CD=006";
    var url="http://openapi.openfiscaldata.go.kr/VWFOED?"+params+"&callback=?";
    
    $.getJSON(url, function (data) {
    	if(typeof data.VWFOED!="undefined"){
    		 for(var i = 0; i < data.VWFOED[1].row.length; i++){
    			 innerHtml+="<tr>";
    	        	$.each( data.VWFOED[1].row[i], function( key, val ) {
    	        		  /*  연도, 월, 회계, 분야, 부문, 프로그램, 단위사업, 예산, 당월집행액, 누계집행액  */
    	        		 if( key=="FSCL_NM"|| key=="FLD_NM"|| key=="SECT_NM"|| key=="PGM_NM" ){
    	        			 innerHtml +="<td align='center' id='" + key + "'><span>" + val + "</span></td>";	 
    	        		  }else if(key=="ACTV_NM" || key=="SACTV_NM"){
    	        			  innerHtml +="<td align='center' id='" + key + "'><span>" + val + "</span></td>";
    	        		  }else if(key=="ANEXP_BDG_CAMT" || key=="EP_AMT" || key=="THISM_AGGR_EP_AMT"){
    	        			  innerHtml +="<td align='right' id='" + key + "'><span>" + comma(Math.round(val*0.000001)) + "</span></td>";
    	        		  }
    			    });    
    	        	innerHtml+="</tr>";
    	        } 
        }else{
		    innerHtml ="<tr>";
		    innerHtml+="<td class='noData' colspan='11'>조회된 데이터가 없습니다.</td>";
		    innerHtml+="</tr>";
        }
			$('#"vwFormOut"').html(innerHtml);
    });
}

/* 일별 세부세출 집행현황 */	
function searchVmFoem3()
{
    var params="";
	var innerHtml = "";
    params += "key=MXTJE1000010620151021040853FXSRB"; 
    params += "&type=json";
    params += "&FSCL_YY="+$("#FSCL_OUT_YY").val();
    params += "&EXE_M="+$("#FSCL_OUT_YY").val()+$("#EXE_OUT_M").val();
    params += "&EXE_DATE="+$("#FSCL_OUT_YY").val()+$("#EXE_OUT_M").val()+$("#EXE_OUT_DATE").val();
    params += "&OFFC_CD=006&pSize=300";
    var url="http://openapi.openfiscaldata.go.kr/VWFOED?"+params+"&callback=?";
    
    $.getJSON(url, function (data) {
    	if(typeof data.VWFOED!="undefined"){
    		 for(var i = 0; i < data.VWFOED[1].row.length; i++){
    			 innerHtml+="<tr>";
    	        	$.each( data.VWFOED[1].row[i], function( key, val ) {
    	        		  /*  연도, 월, 회계, 분야, 부문, 프로그램, 단위사업, 예산, 당월집행액, 누계집행액  */
    	        		 if( key=="FSCL_NM"|| key=="FLD_NM"|| key=="SECT_NM"|| key=="PGM_NM" ){
    	        			 innerHtml +="<td align='center' id='" + key + "'><span>" + val + "</span></td>";	 
    	        		  }else if(key=="ACTV_NM" || key=="SACTV_NM"){
    	        			  innerHtml +="<td align='center' id='" + key + "'><span>" + val + "</span></td>";
    	        		  }else if(key=="ANEXP_BDG_CAMT" || key=="EP_AMT" || key=="THISM_AGGR_EP_AMT"){
    	        			  innerHtml +="<td align='right' id='" + key + "'><span>" + comma(Math.round(val*0.000001)) + "</span></td>";
    	        		  }
    			    });    
    	        	innerHtml+="</tr>";
    	        } 
        }else{
		    innerHtml ="<tr>";
		    innerHtml+="<td class='noData' colspan='11'>조회된 데이터가 없습니다.</td>";
		    innerHtml+="</tr>";
        }
			$('#vwFormOut').html(innerHtml);
    });
}


function comma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}

function fn_sGugunDivIn(){
	var frm = document.formIn;
	if(frm.s_gubunIn[0].checked == true){
		frm.EXE_IN_DATE.style.visibility='visible';
		frm.EXE_IN_DATE.value = "";
	}else{
		frm.EXE_IN_DATE.style.visibility='hidden';
	}
}
function fn_sGugunDivOut(){
	var frm = document.formOut;
	if(frm.s_gubunOut[1].checked == true){
		frm.EXE_OUT_DATE.style.visibility='visible';
		frm.EXE_OUT_DATE.value = "";
	}else{
		frm.EXE_OUT_DATE.style.visibility='hidden';
	}
}
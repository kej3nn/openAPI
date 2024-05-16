<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code='wiseopen.title'/></title>                  
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp"/>
</head>                                                
<style type="text/css">
body{background:none;}
a{text-decoration:none; color:#000000;}         
a:hover{color:#ff0000;}        

ul {
    list-style:square inside;
    margin:2px;
    padding:0;
}

li {
    margin: 0 20px 2px 0;
    padding: 7px 7px 0 0;
    border : 0;
    float: left;
}
</style>                  
<script language="javascript">       
var ctxPath = '<c:out value="${pageContext.request.contextPath}" />';

$(document).ready(function()    {
	doAjax({
		url : "/admin/stat/statMetaExpPopupData.do",
		params : {
			statblId : $("#statblId").val(), 
			statId   : $("#statId").val()
		},
		callback : function(res) {
			$("#statblNm h4").text( com.wise.util.isBlank(res.data.statblNm) ? "" : "⊙ " + res.data.statblNm);	//통계 제목
			
			/* 메타구분 테이블 세팅(메타코드의 갯수에 따라 테이블 생성(중복 포함 안함)) */
			var metaList = res.data.metaList;
			var div = $("#div-sect");
			var table = "";
			var preMetaCd = "";
			for ( var i in metaList ) {
				var metaCd = metaList[i].metaCd;
				if ( preMetaCd != metaCd ) {
					table = 
						"<h2 class=\"text-title2\">"+ metaList[i].metaCdNm +"</h2>" +
						"<table id=\"metaTb"+ metaCd +"\" class=\"list01\">" +              
						"<colgroup>" +
							"<col width=\"150\"/>" +
							"<col width=\"\"/>" +
						"</colgroup>" +
						"</table>";
						div.append(table);
				}
				preMetaCd = metaCd;
			}
			
			/* 메타 리스트 표시 */
			var metaCdTb = null;
			var metatyCd = "";
			for ( var i in metaList ) {
				metaCdTb = $("#metaTb" + metaList[i].metaCd);	//메타구분 테이블 가져온다.
				var row = $("<tr><th></th><td id=\"td\"></td></tr>");
				
				row.find("th").text(metaList[i].metaNm);	//메타명
				
				metaCont = com.wise.util.isNull(metaList[i].metaCont) ? "" : metaList[i].metaCont; 
				
				if ( metaList[i].metatyCd == "FL" ) {	//파일인 경우
					var statId = metaList[i].statId;
					var metaId = metaList[i].metaId;
					var downItem = $("<a href=\"#\" class=\"file atchFile\"></a>");
					downItem.text(metaCont).attr("id", "down_" + metaId);
					//다운로드 이벤트 준다.
					downItem.bind("click", {
		                param : "?statId=" + statId + "&metaId=" + metaId
		            }, function(event) {
		                // 파일을 다운로드한다.
		                downloadFile(event.data.param);
		                return false;
		            });
					row.find("#td").append(downItem)
				} else {
					row.find("#td").text(metaCont);
				}
				metaCdTb.append(row);
			}
			
			/* 연관된 통계표 리스트 표시 */
			var refStatList = res.data.refStatList;
			var refStat = null;
			for ( var i in refStatList ) {
				if ( res.data.statblId == refStatList[i].statblId ) {	//자기자신 제외
					refStat = $("<li>연관된 통계표가 없습니다.</li>"); 
				} else {
					refStat = $("<li><a href=\"javascript:;\"></a></li>");
					//링크 이동
					refStat.find("a")
						.text(refStatList[i].statblNm)
						.attr("href", ctxPath + "/admin/stat/popup/statMetaExpPopup.do?statblId=" + refStatList[i].statblId);
				}
				$("#refStatList").append(refStat);
			}
		}
	});
});

//파일을 다운로드 한다.
function downloadFile(params) {
	$("#download-frame").attr("src", com.wise.help.url("/admin/stat/downloadStatMetaFile.do") + params);
}

</script>                
<body>
<form name="statMetaExpPop"  method="post" action="#">
	<input type="hidden" id="statblId" value="${param.statblId}"/>
	<input type="hidden" id="statId" value="${param.statId}"/>
	<div class="popup">
		<h3>통계설명 미리보기</h3>
		<a href="#" class="popup_close">x</a>
		<div id="statblNm" style="color:#317bbb; font-size: 12pt; font-weight: bold; margin: 20px 0 0 11px;">
			<h4>표준항목 분류정의</h4>
		</div>
		<div id="div-sect" style="padding:15px;">
		</div>
		<div style="padding:15px;">
			<h2 class="text-title2">통계표</h2>
			<ul id="refStatList">
			</ul>
		</div>
	</div>
</form>
</body>
<iframe id="download-frame" name="download-frame"  title="다운로드 처리" height="0" style="width:100%; display:none;"></iframe>
</html>                             
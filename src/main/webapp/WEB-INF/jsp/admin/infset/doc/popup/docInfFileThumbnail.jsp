<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>미리보기</title>                    
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp"/>
</head>
<body onload="" style='background-image: url("");'>
	<form id="form">
		<input type="hidden" id="docId" 	name="docId"  	value="${param.docId}" />
		<input type="hidden" id="fileSeq"	name="fileSeq" 	value="${param.fileSeq}" />
		<input type="hidden" id="srcYn" 	name="srcYn"  	value="${param.srcYn}" />
		<div style="padding: 5px;">
			<button type="button" class="btn01" name="imgSrcView">원본파일보기</button>
		</div>
		<div style="padding: 5px;">
			<img alt="미리보기" src="">
		</div>
	</form>
</body>
<script type="text/javascript">
$(function() {
	
	// 최초 썸네일 이미지 보여준다.
	loadThumbnail("N");
	
	// 원본/썸네일 이미지 보기
	$("button[name=imgSrcView]").toggle(function() {
		loadThumbnail("Y");
	}, function() {
		loadThumbnail("N");
	});
});

/**
 * 이미지를 로드한다.
 */
function loadThumbnail(srcYn) {
	var defaultWidth = 30;		// 팝업창 기본 넓이
	var defaultHeight = 120;	// 팝업창 기본 높이
	
	srcYn = srcYn || "N";
	$("#srcYn").val(srcYn);
	
	var url = com.wise.help.url("/admin/infs/doc/selectDocInfFileThumbnail.do");
	
	$("img").attr("src", url + "?" + $("#form").serialize())
		.load(function() {
			$("button[name=imgSrcView]").text(srcYn=="Y"?"썸네일파일보기":"원본파일보기").show();
			window.resizeTo($(this).width()+defaultWidth, $(this).height()+defaultHeight);
		});
}
</script>
</html>
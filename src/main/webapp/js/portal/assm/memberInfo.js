/**
 * 국회의원 인적정보 스크립트 파일이다.
 * 
 * @author JHKIM
 * @version 1.0 2019/10/17
 */
////////////////////////////////////////////////////////////////////////////////
// GLOBAL VARIABLE
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// SCRIPT INIT
////////////////////////////////////////////////////////////////////////////////
$(function() {
	// 이벤트를 바인딩한다.
	bindEvent();
	
	$("#tab-btn-sect a:eq(0)").click();
	$("#result-profile-sect:eq(0)").show();
	
	//웹접근성 조치 20.11.09
	$(top.document).find("title").text($(".assemblyman_content_head > h3").text() + " | " + $("title").text());
	$("title").text($(".assemblyman_content_head > h3").text() + " | " + $("title").text());
});

function bindEvent() {
	// 탭 이벤트
	$("#tab-btn-sect a").each(function(idx, j) {

		$(this).bind("click", function() {
			//웹접근성 조치 23.11.06
			$("#tab-btn-sect a").removeClass("on").removeAttr("title");
			$(this).addClass("on").attr("title","선택됨");

			var tabBtn = $(this).find("a");
			var tabSect = $("#tab-cont-sect");
			
			$("input[name=profileCd]").val($(this).attr("data-gubun"));
			
			tabSect.children("div").hide();
			tabSect.children("div:eq("+idx+")").show();
			tabSect.children("div:eq("+idx+")").find(".info_line").css("display", "");
		});
	});

	// 인적정보
	$("#btnMembDown").bind("click", function(e) {
		e.preventDefault();
		var formObj = $("form[id=form]");
		
		formObj.find("input[name=excelNm]").val(parent.$(".assemblyman_name strong").text());
		formObj.append("<input type='hidden' name='isHistMemberSch' value='N'>");	// 역대국회의원 조회여부
		
		if ( formObj.find("input[name=empNo]").length == 0 ) {
			formObj.append("<input type='hidden' name='empNo' value='"+$("#lnbForm").find("input[name=empNo]").val()+"'>");
		}
		if ( formObj.find("input[name=unitCd]").length == 0 ) {
			formObj.append("<input type='hidden' name='unitCd' value='"+$("#lnbForm").find("input[name=unitCd]").val()+"'>");
		}
		
		if ( gfn_isNull($("#metaCmitsText").text()) ) {
			formObj.find("input[name=isHistMemberSch]").val("Y");
		}
	    gfn_fileDownload({
	    	url: "/portal/assm/downExcelMembInfo.do",
	    	params: formObj.serialize()
	    });
	});
}


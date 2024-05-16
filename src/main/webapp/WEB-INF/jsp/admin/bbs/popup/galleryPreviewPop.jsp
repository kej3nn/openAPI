<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%--                                                                        --%>
<%-- COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.            --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 마이페이지 > 활용갤러리 > 조회                      --%>
<%--                                                                        --%>
<%-- @author 장홍식                                                         --%>
<%-- @version 1.0 2015/08/17                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<script type="text/javascript">
$(function() {
    // 컴포넌트를 초기화한다.
    initComp();
    
    // 마스크를 바인딩한다.
    bindMask();
    
    // 이벤트를 바인딩한다.
    bindEvent();
    
    // 옵션을 로드한다.
    loadOptions();
    
    // 데이터를 로드한다.
    loadData();
});

////////////////////////////////////////////////////////////////////////////////
// 글로벌 변수
////////////////////////////////////////////////////////////////////////////////
/**
 * 템플릿
 */
var templates = {
    link:
        "<dt class=\"ty_B\">URL</dt>"                                                          +
        "<dd><a href=\"#\" class=\"link\" target=\"_blank\" title=\"새창으로 이동\"></a></dd>",
    data:
    	"<li class=\"\"><a href=\"#\" class=\"link\" target=\"_blank\" title=\"새창으로 이동\"></a></li>",
    none:
    	"<li class=\"\">"	+
    	"해당 자료가 없습니다."   +
        "</li>"
};
////////////////////////////////////////////////////////////////////////////////
// 초기화 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
    // Nothing to do.
}

/**
 * 마스크를 바인딩한다.
 */
function bindMask() {
    // Nothing to do.
}

/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
    // 갤러리 게시판 내용 조회 폼에 제출 이벤트를 바인딩한다.
    $("#gallery-select-form").bind("submit", function(event) {
        return false;
    });
    
    $(".gallery-grade-option").each(function(index, element) {
        var image = $(this).find("img");
        
        // 갤러리 게시판 내용 평가점수 옵션에 클릭 이벤트를 바인딩한다.
        $(this).bind("click", {
            src:image.attr("src"),
            alt:image.attr("alt")
        }, function(event) {
            // 갤러리 게시판 내용 평가점수를 변경한다.
            changeAppraisal(event.data);
            return false;
        });
        
        // 갤러리 게시판 내용 평가점수 옵션에 키다운 이벤트를 바인딩한다.
        $(this).bind("keydown", {
            src:image.attr("src"),
            alt:image.attr("alt")
        }, function(event) {
            if (event.which == 13) {
                // 갤러리 게시판 내용 평가점수를 변경한다.
                changeAppraisal(event.data);
                return false;
            }
        });
    });
    
}

/**
 * 옵션을 로드한다.
 */
function loadOptions() {
    // Nothing do do.
}

/**
 * 데이터를 로드한다.
 */
function loadData() {
    // 갤러리 게시판 내용을 조회한다.
    selectGallery();
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 갤러리 게시판 내용을 조회한다.
 */
function selectGallery() {
    // 데이터를 조회한다.
    doSelect({
        url:resolveUrl("/selectGalleryPop.do"),
        before:beforeSelectGallery,
        after:afterSelectGallery
    });
}


/**
 * 갤러리 게시판 내용 평가점수를 변경한다.
 * 
 * @param data {Object} 데이터
 */
function changeAppraisal(data) {
    var image = $(".gallery-grade-combo img:eq(0)");
    
    image.attr("src", data.src);
    image.attr("alt", data.alt);
    
    $(".gallery-grade-combo").click();
}

/**
 * 갤러리 게시판 내용 평가점수를 설정한다.
 * 
 * @param data {Object} 데이터
 */
function setAppraisal(data) {
    var image = $(".gallery-grade-image");
    
    if (data.apprVal == 0.0) {
        image.attr("src", com.wise.help.url("/img/ggportal/desktop/common/grade_0.png")).attr("alt", "총점 5점 중 평점 0점 아주 나쁨");
    }
    else if (data.apprVal > 0.0 && data.apprVal <= 0.5) {
        image.attr("src", com.wise.help.url("/img/ggportal/desktop/common/grade_1.png")).attr("alt", "총점 5점 중 평점 0.5점 아주 나쁨");
    }
    else if (data.apprVal > 0.5 && data.apprVal <= 1.0) {
        image.attr("src", com.wise.help.url("/img/ggportal/desktop/common/grade_2.png")).attr("alt", "총점 5점 중 평점 1점 아주 나쁨");
    }
    else if (data.apprVal > 1.0 && data.apprVal <= 1.5) {
        image.attr("src", com.wise.help.url("/img/ggportal/desktop/common/grade_3.png")).attr("alt", "총점 5점 중 평점 1.5점 아주 나쁨");
    }
    else if (data.apprVal > 1.5 && data.apprVal <= 2.0) {
        image.attr("src", com.wise.help.url("/img/ggportal/desktop/common/grade_4.png")).attr("alt", "총점 5점 중 평점 2점 나쁨");
    }
    else if (data.apprVal > 2.0 && data.apprVal <= 2.5) {
        image.attr("src", com.wise.help.url("/img/ggportal/desktop/common/grade_5.png")).attr("alt", "총점 5점 중 평점 2.5점 나쁨");
    }
    else if (data.apprVal > 2.5 && data.apprVal <= 3.0) {
        image.attr("src", com.wise.help.url("/img/ggportal/desktop/common/grade_6.png")).attr("alt", "총점 5점 중 평점 3점 보통");
    }
    else if (data.apprVal > 3.0 && data.apprVal <= 3.5) {
        image.attr("src", com.wise.help.url("/img/ggportal/desktop/common/grade_7.png")).attr("alt", "총점 5점 중 평점 3.5점 보통");
    }
    else if (data.apprVal > 3.5 && data.apprVal <= 4.0) {
        image.attr("src", com.wise.help.url("/img/ggportal/desktop/common/grade_8.png")).attr("alt", "총점 5점 중 평점 4점 좋음");
    }
    else if (data.apprVal > 4.0 && data.apprVal <= 4.5) {
        image.attr("src", com.wise.help.url("/img/ggportal/desktop/common/grade_9.png")).attr("alt", "총점 5점 중 평점 4.5점 좋음");
    }
    else if (data.apprVal > 4.5) {
        image.attr("src", com.wise.help.url("/img/ggportal/desktop/common/grade_10.png")).attr("alt", "총점 5점 중 평점 5점 아주 좋음");
    }
}

/**
 * URL을 반환한다.
 * 
 * @param url {String} URL
 */
function resolveUrl(url) {
    var matches = window.location.href.match(/\/admin\/[^\/]+\//);
    
    return matches[0] + "gallery".toLowerCase() + url;
}

////////////////////////////////////////////////////////////////////////////////
// 전처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 *  갤러리 게시판 내용 조회 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeSelectGallery(options) {
	 var data = {
		        // Nothing do do.
    };
    
    var form = $("#gallery-search-form");
    
    $.each(form.serializeArray(), function(index, element) {
        switch (element.name) {
            case "page":
            case "rows":
                break;
            default:
                data[element.name] = element.value;
                break;
        }
    });
  
    return data;
}

////////////////////////////////////////////////////////////////////////////////
// 후처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 갤러리 게시판 내용 조회 후처리를 실행한다.
 * 
 * @param data {Object} 데이터
 */
function afterSelectGallery(data) {
    
	$(".bbsTit").append(com.wise.help.XSSfilter(data.bbsTit));
	$(".list1SubNm").append(data.listSubNm);
         
    $(".userNm").text(data.userNm);
    $(".userDttm").text(data.userDttm);
    
    if (data.htmlYn == "Y") {
        $(".bbsCont").html(data.bbsCont);
    }
    else {
        $(".bbsCont").text(data.bbsCont ? data.bbsCont.replace(/\r/g, "") : "");
    }
    
    if (data.fileCnt) {
        if (data.files) {
            var list = $("#gallery-image-list");
            
            var item = null;
            
            for (var i = 0; i < data.files.length; i++) {
                var url = resolveUrl("/selectAttachFile.do?fileSeq=") + data.files[i].fileSeq;
                
                if (data.files[i].topYn == "Y") {
                	 $("#gallery-thumbnail-image").attr("src", url).attr("alt", data.bbsTit);
                }
                else {
                    if (item == null || item.find("span").length == 2) {
                        item = $("<li></li>");
                    }
                    
                    item.append("<span><img alt=\"\" /></span>");
                    
                    item.find("img:last").attr("src", url);
                    
                    if (item.find("span").length == 2 || i == data.files.length - 1) {
                        list.append(item);
                    }
                }
            }
        }
    }
    
    if (data.linkCnt) {
        var list = $("#gallery-data-list");
        
        for (var i = 0; i < data.link.length; i++) {
            var item = $(templates.link);
            
            item.find("a").attr("href", data.link[i].url).text(data.link[i].linkNm + " (" + data.link[i].url + ")");
            
            list.append(item);
        }
    }
    if (data.infCnt) {
        if (data.data) {
            var list = $("#gallery-usedLink");
            
            for (var i = 0; i < data.data.length; i++) {
                var item = $(templates.data);
                item.find("a").attr("href", "/portal/data/service/selectServicePage.do/"+data.data[i].infId).text(data.data[i].infNm);
                list.append(item);
            }
        }
        
    } else {
    	$("#gallery-usedLink").append(templates.none);
    }
    
    // 갤러리 게시판 내용 평가점수를 설정한다.
    setAppraisal(data);
    
    if(data.ansState == 'AC') {	//승인불가
    	$('.table_datail_B tr').last().after("<tr><td><b>[승인불가 의견]</b><br><pre>"+data.ansCont+"</pre></td></tr>");
    } else if (data.ansState == "AK") {
    	//승인완료
    	$("#gallery-delete-button").hide();
    }
    
    // bxslider.js 활용갤러리 이미지 slide 스크립트 참조
    mb = $(".imgGalleryDetail").bxSlider({
        mode:"horizontal",
        speed:500,
        pager:false,
        moveSlider:1,
        autoHover:true,
        controls:true,
        slideMargin:0,
        startSlide:0
    });
}



</script>
</head>
<body>
<!-- contents -->
   <!-- content -->
   <div id="content" class="content play_preview">
    <%-- <h2 class="hide"><c:out value="${requestScope.menu.lvl1MenuPath}" /></h2> --%>
       <form id="gallery-search-form" name="gallery-search-form" method="post">
            <input type="hidden" name="bbsCd" value="<c:out value="${param.bbsCd}" default="${data.bbsCd}" />" />
            <input type="hidden" name="seq" value="<c:out value="${param.seq}" default="" />" />
        </form>
	<!-- 상세 요약 -->
	<div class="detail_summary w_2 detail_figure detail_gallery">
		<figure class="thumbnail2">
			<figcaption>해당 서비스에 대한 thumbnail</figcaption>
			<img id="gallery-thumbnail-image" src="<c:url value="/img/ggportal/desktop/thumbnail/icon_gallery/icon_gallery_2.png" />"  alt="" />
		</figure>
		<div class="summary gly_txt">
			<span class="list1SubNm"></span><br>
			<strong class="tit listSubNm bbsTit"></strong>
			<dl id="gallery-data-list">
	          	<dt>제작자</dt>
               <dd class="userNm"></dd>
               <dt>등록일</dt>
               <dd class="userDttm"></dd>
               </dl>
		</div>
	</div>
	<!-- // 상세 요약 -->
       <section class="section_gallery_detail play_detail_gallery">
       <h4 class="hide"><c:out value="${requestScope.menu.lvl2MenuPath}" /> 상세</h4>
       <table class="table_datail_B w_1">
       <%--<caption><c:out value="${requestScope.menu.lvl2MenuPath}" /> 상세</caption>--%>
       <tr>
           <td class="cont">
           <div class="area_img_galleryDetail">
           <div class="img_galleryDetail">
               <ul id="gallery-image-list" class="imgGalleryDetail"></ul>
           </div>
           </div>
           <pre class="bbsCont"></pre>
           </td>
       </tr>
       </table>
       </section>
       <!-- // 활용 데이터 링크 -->
       <section class="section_gallery_usedLink">
	<span><strong>활용 데이터 링크</strong></span>
       <ul id= "gallery-usedLink">
       </ul>
       </section>
    </div>
   <!-- // content -->

   
<!-- // layout_A -->
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)header.jsp 1.0 2019/08/20 	  	                                  	--%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 문서관리 서비스 메타 조회 화면이다. 				                    --%>
<%--                                                                        --%>
<%-- @author JHKIM                                                         --%>
<%-- @version 1.0 2019/08/20                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<script type="text/javascript" src="<c:url value="/js/ggportal/kakao.min.js" />"></script>
<input type="hidden" name="docId" value="${docId }">
<div class="detail_summary">
    <figure class="thumbnail">
        <!-- <img src="/portal/data/dataset/selectThumbnail.do?seq=OYSWKW000808T616728&amp;metaImagFileNm=&amp;cateSaveFileNm=NA11000.png" alt=""> -->
        <c:choose>
        <c:when test="${!empty meta.cateSaveFileNm}">
        <img src="<c:url value="/portal/data/dataset/selectThumbnail.do" />?cateSaveFileNm=<c:out value="${meta.cateSaveFileNm}" />"  alt="" />
        </c:when>
        <c:otherwise>
        <img src="<c:url value="/img/ggportal/desktop/thumbnail/@thumbnail_100.jpg" />"  alt="" />
        </c:otherwise>
        </c:choose>
        <figcaption>${meta.topCateNm }</figcaption>
    </figure>
	<div class="summary">
		<strong class="tit">${meta.docNm }</strong>
	    <span class="opentyTagNm ot01">규정(지침)</span>
	    <div>${meta.docExp }</div>
		<div class="area_grade clfix">
        	<div class="flL">   
	            <strong class="tit_totalGrade">총평점</strong>
	            <c:choose>
	                <c:when test="${meta.apprVal == 0.0}">
	                <img src="/img/ggportal/desktop/common/grade_0.png" class="icon_grade service-grade-image" alt="총점 5점 중 평점 0점 아주 나쁨" />
	                </c:when>
	                <c:when test="${meta.apprVal > 0.0 && meta.apprVal <= 0.5}">
	                <img src="/img/ggportal/desktop/common/grade_1.png" class="icon_grade service-grade-image" alt="총점 5점 중 평점 0.5점 아주 나쁨" />
	                </c:when>
	                <c:when test="${meta.apprVal > 0.5 && meta.apprVal <= 1.0}">
	                <img src="/img/ggportal/desktop/common/grade_2.png" class="icon_grade service-grade-image" alt="총점 5점 중 평점 1점 아주 나쁨" />
	                </c:when>
	                <c:when test="${meta.apprVal > 1.0 && meta.apprVal <= 1.5}">
	                <img src="/img/ggportal/desktop/common/grade_3.png" class="icon_grade service-grade-image" alt="총점 5점 중 평점 1.5점 아주 나쁨" />
	                </c:when>
	                <c:when test="${meta.apprVal > 1.5 && meta.apprVal <= 2.0}">
	                <img src="/img/ggportal/desktop/common/grade_4.png" class="icon_grade service-grade-image" alt="총점 5점 중 평점 2점 나쁨" />
	                </c:when>
	                <c:when test="${meta.apprVal > 2.0 && meta.apprVal <= 2.5}">
	                <img src="/img/ggportal/desktop/common/grade_5.png" class="icon_grade service-grade-image" alt="총점 5점 중 평점 2.5점 나쁨" />
	                </c:when>
	                <c:when test="${meta.apprVal > 2.5 && meta.apprVal <= 3.0}">
	                <img src="/img/ggportal/desktop/common/grade_6.png" class="icon_grade service-grade-image" alt="총점 5점 중 평점 3점 보통" />
	                </c:when>
	                <c:when test="${meta.apprVal > 3.0 && meta.apprVal <= 3.5}">
	                <img src="/img/ggportal/desktop/common/grade_7.png" class="icon_grade service-grade-image" alt="총점 5점 중 평점 3.5점 보통" />
	                </c:when>
	                <c:when test="${meta.apprVal > 3.5 && meta.apprVal <= 4.0}">
	                <img src="/img/ggportal/desktop/common/grade_8.png" class="icon_grade service-grade-image" alt="총점 5점 중 평점 4점 좋음" />
	                </c:when>
	                <c:when test="${meta.apprVal > 4.0 && meta.apprVal <= 4.5}">
	                <img src="/img/ggportal/desktop/common/grade_9.png" class="icon_grade service-grade-image" alt="총점 5점 중 평점 4.5점 좋음" />
	                </c:when>
	                <c:when test="${meta.apprVal > 4.5}">
	                <img src="/img/ggportal/desktop/common/grade_10.png" class="icon_grade service-grade-image" alt="총점 5점 중 평점 5점 아주 좋음" />
	                </c:when>
	                <c:otherwise>
	                <img src="<c:url value="/img/ggportal/desktop/common/grade_0.png" />" class="icon_grade service-grade-image" alt="총점 5점 중 평점 0점 아주 나쁨" />
	                </c:otherwise>
                </c:choose>
	            <div class="make_grade">
	                <a href="javascript:;" class="toggle_grade service-grade-combo">
	                    <img src="/images/grade_s_1.png" alt="총점 5점 중 평점 1점 아주 나쁨">
	                    <img src="/images/toggle_open_grade.png" id="toggle_grade" alt="">
	                </a>
	                <ul id="view_grade" class="view_grade" style="display:none;">
	                <li><a href="#" class="service-grade-option"><img src="/images/grade_s_1.png" alt="총점 5점 중 평점 1점 아주 나쁨"></a></li>
	                <li><a href="#" class="service-grade-option"><img src="/images/grade_s_2.png" alt="총점 5점 중 평점 2점 나쁨"></a></li>
	                <li><a href="#" class="service-grade-option"><img src="/images/grade_s_3.png" alt="총점 5점 중 평점 3점 보통"></a></li>
	                <li><a href="#" class="service-grade-option"><img src="/images/grade_s_4.png" alt="총점 5점 중 평점 4점 좋음"></a></li>
	                <li><a href="#" class="service-grade-option"><img src="/images/grade_s_5.png" alt="총점 5점 중 평점 5점 아주 좋음"></a></li>
	                </ul>
	            </div>
	            <a href="#" class="btn_make_grade service-grade-button">OK</a>
			</div>
            <a href="javascript:;" class="toggle_metaInfo"><strong>메타 정보 닫기</strong>
            	<img src="/images/toggle_colse_metaInfo.png" alt="">
            </a>
            <div class="btn_sns">
             	<a href="#" id="shareFB" title="새창열림_페이스북" class="sns_facebook">페이스북</a>
				<a href="#" id="shareTW" title="새창열림_트위터" class="sns_twitter">트위터</a>
				<a href="#" id="shareBG" title="새창열림_네이버블로그" class="sns_blog">네이버블로그</a>
				<a href="#" id="shareKS" title="새창열림_카카오스토리" class="sns_kakaostory">카카오스토리</a>
				<a href="#" id="shareKT" title="새창열림_카카오톡" class="sns_kakaotalk">카카오톡</a>
			</div>
		</div>
	</div>
</div>


<script type="text/javascript">
$(function() {
	// 메타정보 열고 닫기
	var metaInfoOpenClose = false;
    $('.toggle_metaInfo').click(function(){
        $('#metaInfo').toggle(function(){
            if(metaInfoOpenClose == false){
            $('#metaInfo').removeClass('metaInfo').addClass('view_metaInfo');
            $('.toggle_metaInfo').html('<strong>메타 정보 닫기</strong><img src="' + com.wise.help.url("/img/ggportal/desktop/common/toggle_colse_metaInfo.png") + '" alt="" />');
            metaInfoOpenClose = true;
        }
        else {
            $('#metaInfo').removeClass('view_metaInfo').addClass('metaInfo');
            $('.toggle_metaInfo').html('<strong>메타 정보 열기</strong><img src="' + com.wise.help.url("/img/ggportal/desktop/common/toggle_open_metaInfo.png") + '" alt="" />');
            metaInfoOpenClose = false;
        }
        });
    });
	
 	// 별점 셀렉트 박스 클릭
 	var selectOpenClose = false; // 별점 셀렉트 열기닫기버튼의 활성화 지표
    $('.toggle_grade').click(function(){
        $('#view_grade').slideToggle(function(){
            if(selectOpenClose == false){
                $('#toggle_grade').attr('src',com.wise.help.url('/img/ggportal/desktop/common/toggle_open_grade.png'));
                selectOpenClose = true;
            }
            else {
                $('#toggle_grade').attr('src',com.wise.help.url('/img/ggportal/desktop/common/toggle_open_grade.png'));   
                selectOpenClose = false;
            }
        });
    });
 	
 	// 별점 셀렉트 박스 선택시
    $(".service-grade-option").each(function(index, element) {             	
        var image = $(this).find("img");
        
        // 서비스 평가점수 옵션에 클릭 이벤트를 바인딩한다.
        $(this).bind("click", {
            src:image.attr("src"),
            alt:image.attr("alt")
        }, function(event) {
            // 서비스 평가점수를 변경한다.
            changeApprVal(event.data);
            return false;
        });
        
        // 서비스 평가점수 옵션에 키다운 이벤트를 바인딩한다.
        $(this).bind("keydown", {
            src:image.attr("src"),
            alt:image.attr("alt")
        }, function(event) {
            if (event.which == 13) {
                // 서비스 평가점수를 변경한다.
                changeApprVal(event.data);
                return false;
            }
        });
    });
	
 	// 서비스 평가점수 등록
    $(".service-grade-button").bind("click", function(event) {
        insertApprVal();
        return false;
    }).bind("keydown", function(event) {
        if (event.which == 13) {
            insertApprVal();
            return false;
        }
    });
 	
 	// 목록으로 이동
 	$(".btn_list").bind("click", function() {
 		goInfsList();
 		return false;
 	}).bind("keydown", function(event) {
        if (event.which == 13) {
        	goInfsList();
     		return false;
        }
    });
 	
 	 //페이스북 공유
    $("#shareFB").bind("click", function(event) {
    	shareFace(location.href, $(".detail_summary .tit").text());
    });
    
    //트위터 공유
	$("#shareTW").bind("click", function(event) {
		shareTwitter(location.href, $(".detail_summary .tit").text());
    });
    
    //네이버 블로그 공유
	$("#shareBG").bind("click", function(event) {
		shareNaver(location.href, $(".detail_summary .tit").text());
    });
    //카카오 스토리 공유
	$("#shareKS").bind("click", function(event) {
		shareStory(location.href, $(".detail_summary .tit").text());
    });
    //카카오톡공유
	$("#shareKT").bind("click", function(event) {
		shareKT(location.href, $(".detail_summary .tit").text());
    });
    
});



/**
 * 서비스 평가점수를 변경
 */
function changeApprVal(data) {
    var image = $(".service-grade-combo img:eq(0)");
    
    image.attr("src", data.src);
    image.attr("alt", data.alt);
    
    $(".service-grade-combo").click();
}

/**
 * 서비스 평가점수 등 
 */
function insertApprVal() {
    // 데이터를 처리한다.
    doPost({
        url:"/portal/doc/insertDocInfAppr.do",
        before: beforeInsertApprVal,
        after: afterInsertApprVal
    });
}

/**
 * 서비스 평가점수 등록 전처리를 실행한다.
 */
function beforeInsertApprVal(options) {
    var data = {
    	docId: $("input[name=docId]").val(),
        apprVal:$(".service-grade-combo img:eq(0)").attr("alt").match(/\d/)[0]
    };
    
    if (com.wise.util.isBlank(data.docId)) {
        return null;
    }
    
    return data;
}

/**
 * 서비스 평가점수 등록 후처리를 실행한다.
 */
function afterInsertApprVal(data) {
    alert("평가해 주셔서 감사합니다.");
    
    var image = $(".service-grade-image");
    
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
 * 목록으로 이동
 */
function goInfsList() {
	goSelect({
        url:"/portal/infs/list/infsListPage.do",
        form:"searchForm",
        method: "post"
    });
}
</script>

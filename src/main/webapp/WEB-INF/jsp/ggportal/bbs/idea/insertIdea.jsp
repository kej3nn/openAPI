<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)insertIdea.jsp 1.0 2020/08/26                                     --%>
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
<%-- 이벤트 게시판 내용을 등록하는 화면이다.                                --%>
<%--                                                                        --%>
<%-- @author 김은삼                                                         --%>
<%-- @version 1.0 2015/06/15                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/ggportal/sect/head.jsp" %>
<script type="text/javascript" src="<c:url value="/js/ggportal/bbs/idea/insertIdea.js" />"></script>
</head>
<body>
<!-- layout_idea -->
<div class="layout_idea">
    <div class="area_logo">
        <a href="<c:url value="/portal/mainPage.do" />" title="국회 홈페이지 이동" class="logo" style="margin-top:36px;"><img src="<c:url value="/images/logo.png" />" alt="국회 홈페이지 이동" /></a>
        
    </div>
    <div class="area_idea">
        
        <!-- 이벤트 응모하기 -->
        <div>
        <form id="idea-insert-form" name="idea-insert-form" method="post" enctype="multipart/form-data"> 
        <table class="table_datail_AB w_1">
        <caption>이벤트 응모</caption>
        <tbody>
        <tr>
            <th scope="row"><label for="fileAdd">첨부파일</label></th>
            <td class="ty_AB ty_B">
                <ul id="idea-upload-list" class="file_B <c:out value="${data.extLimit}" />"></ul>
            </td>
        </tr>
        </tbody>
        </table>
        <p class="p_tyC">열린국회정보 옥에 티 찾기 이벤트 상품 발송과 관련하여 개인정보 보호법에 의거 귀하의 개인정보를 “수집ㆍ이용”에 동의를 얻고자 합니다. 참여하고자 하시는 분은 동의 여부를 체크, 서명하여 주시기 바랍니다.</p>
        <ul class="idea_bottom_txt">
        	<li>수집항목 : 성명, 휴대폰번호</li>
        	<li>보유 이용 기간 : 이벤트 운영 종료 시까지 보유ㆍ관리되며, 종료 시 보유 정보는 폐기됩니다.</li>
        	<li>동의 거부 권리 안내 : 개인정보 수집ㆍ이용 동의를 거부할 수 있습니다. 다만, 이 경우 이벤트 신청이 제한됩니다.</li>
        	<li class="idea_bottom_txt_last">수집된 개인정보는 위 목적 이외의 용도로는 이용되지 않으며, 제3자에게 제공하지 않습니다.</li>
        </ul>
        <div class="idea_agree2">
        	<input type="checkbox" value="Y" id="agree"> <label for="agree">상기내용을 숙지하였고 이에 동의합니다.</label>
        </div>
        <div class="area_btn_E">
            <c:choose>
            <c:when test="${data.bbsOpenYn == 'Y'}">
            <a href="#layerPopup_openIdea" id="btn_openIdea" class="btn_EB btn_view_layerPopup btn_view_layerPopup_openEvent idea-insert-button opened">이벤트 참여</a>
            </c:when>
            <c:otherwise>
            <a href="#layerPopup_openIdea" id="btn_openIdea" class="btn_EB btn_view_layerPopup btn_view_layerPopup_openEvent idea-insert-button closed">이벤트 참여 완료</a>
            </c:otherwise>
            </c:choose>
        </div>
        </form>
        </div>
        <!-- // 이벤트 응모하기 -->
        <!-- layerPopup 국회 나눔데이터 오픈이벤트 팝업 -->
        <div id="idea-confirm-sect" class="layout_layerPopup_A layout_layerPopup_A_openEvent">
            <div class="transparent"></div>
            <div id="layerPopup_openIdea" class="layerPopup_A">
                <h4 class="pop">열린국회정보 오픈 이벤트</h4>
                <!-- 내용 -->
                <div class="cont">
                    <div class="openEvent_pop">
                        <img src="<c:url value="/img/ggportal/desktop/popup/tit_idea.png" />" alt="옥의 티을 찾아라" />
                        <p class="p_ty_B_pop">이벤트에 참여해 주셔서 감사합니다.</p>
                    </div>
                    <div class="area_btn_A_pop">
                        <a href="#" class="btn_A idea-confirm-button">확인</a>
                    </div>
                </div>
                <!-- //내용 -->
                <a href="javascript:;" class="btn_close idea-close-button"><span>레이어 팝업 닫기</span></a>
            </div>
        </div>
    </div>
</div>
<!-- // layout_idea -->
</body>
</html>
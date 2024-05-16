<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)insertEvent.jsp 1.0 2015/06/15                                     --%>
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
    <script type="text/javascript" src="<c:url value="/js/ggportal/bbs/event/insertEvent.js" />"></script>
</head>
<body>
<!-- layout_event -->
<div class="layout_event">
    <div class="area_logo">
        <a href="<c:url value="/portal/mainPage.do" />" title="국회 홈페이지 이동" class="logo" style="margin-top:36px;"><img src="<c:url value="/images/logoAssm.png" />" alt="국회 홈페이지 이동" /></a>

    </div>
    <div class="area_event">

        <!-- 이벤트 응모하기 -->
        <div>
            <form id="event-insert-form" name="event-insert-form" method="post" enctype="multipart/form-data">
                <table class="table_datail_AB w_1">
                    <caption>이벤트 응모</caption>
                    <tbody>
                    <tr>
                        <th scope="row"><label for="sort">분류</label></th>
                        <td class="ty_AB ty_B">
                            <select id="sort" name="listSubCd" title="분류" class="listSubCd">
                                <option value="1">오타</option>
                                <option value="2">링크 오류</option>
                                <option value="3">프로그램 오류</option>
                                <option value="4">데이터 오류</option>
                                <option value="5">기타</option>
                                <option value="6">개선사항</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><label for="URL_address">제목</label></th>
                        <td class="ty_AB ty_B">
                            <input type="text" id="URL_address" name="bbsTit" class="f_100per bbsTit" autocomplete="on" style="ime-mode:active;" />
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><label for="contents">개선의견</label></th>
                        <td class="ty_AB ty_B">
                            <textarea id="contents" name="bbsCont" class="bbsCont" style="ime-mode:active;"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><label for="fileAdd">첨부파일</label></th>
                        <td class="ty_AB ty_B">
                            <ul id="event-upload-list" class="file_B <c:out value="${data.extLimit}" />"></ul>
                        </td>
                    </tr>
                    </tbody>
                </table>
                <h4 class="ty_A">이벤트 참여를 위한 개인정보 등록</h4>
                <table class="table_datail_AB w_1">
                    <caption>이벤트 참여를 위한 개인정보 등록</caption>
                    <tbody>
                    <tr>
                        <th scope="row"><label for="name">성명</label></th>
                        <td class="ty_AB ty_B">
                            <input type="text" id="name" name="userNm" value="<c:out value="${sessionScope.PortalLoginVO.userNm}" />" autocomplete="on" class="f_110px userNm" style="ime-mode:active;" />
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><label for="eMail"><abbr title="electronic mail">E-mail</abbr></label></th>
                        <td class="ty_AB ty_B">
                            <div class="area_form">
                                <input type="email" id="eMail" name="userEmail1" value="<c:out value="${sessionScope.PortalLoginVO.userEmailSplit1}" />" class="flL f_170px f_46per userEmail1 required" title="E-mail ID" autocomplete="on" style="ime-mode:disabled;" />
                                <span class="txt talC f_8per_mq_mobile">@</span>
                                <input type="email" id="eMail_2" name="userEmail2" value="<c:out value="${sessionScope.PortalLoginVO.userEmailSplit2}" />" class="flL f_110px f_46per userEmail2 required" title="E-mail 주소" autocomplete="on" style="ime-mode:disabled;" />
                                <span class="divi_select paL0_mq_mobile f_100per_mq_mobile f_mgT3_mq_mobile">
                                    <select id="eMail_3" name="userEmail3" class="f_100per_mq_mobile userEmail3" title="이메일 주소 번지 선택"></select>
                                </span>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><label for="name">국회직원 여부</label></th>
                        <td class="ty_AB ty_B">

                            <input type="checkbox" id="inworkYn_Y" name="list1SubCd" value="Y" style="-webkit-appearance: checkbox;"/>
                            <input type="hidden" id="inworkYn_N" name="list1SubCd" value="N"/>
                            <label for="inworkYn_Y">&nbsp; 국회직원일경우 체크</label>
                        </td>
                    </tr>
                    <%--<tr>
                        <th scope="row"><label for="cellphone">휴대폰</label></th>
                        <td class="ty_AB ty_B">
                            <input type="tel" id="cellphone"   name="userTel1" value="<c:out value="${sessionScope.PortalLoginVO.userTelSplit1}" />" pattern="[0-9]{3}" autocomplete="on" class="userTel1 required" style="width:50px; ime-mode:disabled;" title="휴대폰 첫 번째자리 입력" /> -
                            <input type="tel" id="cellphone_2" name="userTel2" value="<c:out value="${sessionScope.PortalLoginVO.userTelSplit2}" />" pattern="[0-9]{4}" autocomplete="on" class="userTel2 required" style="width:49px; ime-mode:disabled;" title="휴대폰 두 번째자리 입력" /> -
                            <input type="tel" id="cellphone_3" name="userTel3" value="<c:out value="${sessionScope.PortalLoginVO.userTelSplit3}" />" pattern="[0-9]{4}" autocomplete="on" class="userTel3 required" style="width:49px; ime-mode:disabled;" title="휴대폰 세 번째자리 입력" />
                        </td>
                    </tr>--%>
                    </tbody>
                </table>
                <p class="p_tyC">국회홈페이지 옥에 티 찾기 이벤트 상품 발송과 관련하여 개인정보 보호법에 의거 귀하의 개인정보를 “수집ㆍ이용”에 동의를 얻고자 합니다. 참여하고자 하시는 분은 동의 여부를 체크, 서명하여 주시기 바랍니다.</p>
                <ul class="event_bottom_txt">
                    <li>수집항목 : 성명, 이메일주소</li>
                    <li>보유 이용 기간 : 이벤트 운영 종료 시까지 보유ㆍ관리되며, 종료 시 보유 정보는 폐기됩니다.</li>
                    <li>동의 거부 권리 안내 : 개인정보 수집ㆍ이용 동의를 거부할 수 있습니다. 다만, 이 경우 이벤트 신청이 제한됩니다.</li>
                    <li class="event_bottom_txt_last">수집된 개인정보는 위 목적 이외의 용도로는 이용되지 않으며, 제3자에게 제공하지 않습니다.</li>
                </ul>
                <div class="event_agree2">
                    <input type="checkbox" value="Y" id="agree"> <label for="agree">상기내용을 숙지하였고 이에 동의합니다.</label>
                </div>
                <div class="area_btn_E">
                    <c:choose>
                        <c:when test="${data.bbsOpenYn == 'Y'}">
                            <a href="#layerPopup_openEvent" id="btn_openEvent" class="btn_EB btn_view_layerPopup btn_view_layerPopup_openEvent event-insert-button opened">이벤트 참여</a>
                        </c:when>
                        <c:otherwise>
                            <a href="#layerPopup_openEvent" id="btn_openEvent" class="btn_EB btn_view_layerPopup btn_view_layerPopup_openEvent event-insert-button closed">이벤트 참여 완료</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </form>
        </div>
        <!-- // 이벤트 응모하기 -->
        <!-- layerPopup 국회 나눔데이터 오픈이벤트 팝업 -->
        <div id="event-confirm-sect" class="layout_layerPopup_A layout_layerPopup_A_openEvent">
            <div class="transparent"></div>
            <div id="layerPopup_openEvent" class="layerPopup_A">
                <h4 class="pop">대한민국 국회 오픈 이벤트</h4>
                <!-- 내용 -->
                <div class="cont">
                    <div class="openEvent_pop">
                        <img src="<c:url value="/img/ggportal/desktop/popup/tit_event.png" />" alt="옥의 티을 찾아라" />
                        <p class="p_ty_B_pop">이벤트에 참여해 주셔서 감사합니다.</p>
                    </div>
                    <div class="area_btn_A_pop">
                        <a href="#" class="btn_A event-confirm-button">확인</a>
                    </div>
                </div>
                <!-- //내용 -->
                <a href="javascript:;" class="btn_close event-close-button"><span>레이어 팝업 닫기</span></a>
            </div>
        </div>
    </div>
</div>
<!-- // layout_event -->
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)updateBoard.jsp 1.0 2015/06/15                                     --%>
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
<%-- 일반 게시판 내용을 수정하는 화면이다.                                  --%>
<%--                                                                        --%>
<%-- @author 김은삼                                                         --%>
<%-- @version 1.0 2015/06/15                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<script type="text/javascript" src="<c:url value="/js/ggportal/bbs/board/updateBoard.js" />"></script>
</head>
<body>
<!-- layout_A -->
<div class="layout_A">
<c:choose>
<c:when test="${fn:indexOf(requestScope.uri, '/portal/bbs/guide/') >= 0}">
<%@ include file="/WEB-INF/jsp/portal/sect/headerOpen.jsp" %>
</c:when>
<c:when test="${fn:indexOf(requestScope.uri, '/portal/bbs/develop/') >= 0}">
<%@ include file="/WEB-INF/jsp/portal/sect/headerOpen.jsp" %>
</c:when>
<c:otherwise>
<%@ include file="/WEB-INF/jsp/portal/sect/header.jsp" %>
</c:otherwise>
</c:choose>
<div class="container" id="container">
<!-- leftmenu -->
<%@ include file="/WEB-INF/jsp/portal/sect/lnb.jsp" %>
<!-- //leftmenu -->

<!-- contents -->
	<div class="contents" id="contents">
		<div class="contents-title-wrapper">
		<c:choose>
           <c:when test="${data.bbsCd == 'DEVELOP'}">
           <h3><c:out value="${requestScope.menu.lvl3MenuPath}" /><span class="arrow"></span></h3>
           </c:when>
           <c:otherwise>
           <h3><c:out value="${requestScope.menu.lvl2MenuPath}" /><span class="arrow"></span></h3>
           </c:otherwise>
        </c:choose>
		</div>
<!-- wrap_layout_flex -->
<div class="wrap_layout_flex"><div class="layout_flex_100">
<!-- layout_flex -->
<div class="layout_flex">
    <!-- content -->
    <div id="content" class="content">
        <h2 class="hide"><c:out value="${requestScope.menu.lvl1MenuPath}" /></h2>
        <form id="board-update-form" name="board-update-form" method="post" enctype="multipart/form-data">
        <input type="hidden" name="bbsCd" class="bbsCd" />
        <input type="hidden" name="seq" class="seq" />
        <%--
        <fieldset>
        <legend>개인정보 수집 및 이용안내</legend>
        <section class="section_agreement"> 
            <h4 class="ty_A">개인정보 수집 및 이용안내</h4>
            <div class="box_B agreement">
                <ol>
                <li>1. 수집 개인정보 항목 : 문의자명, 메일주소, 전화번호</li>
                <li>2. 개인정보의 수집 및 이용목적 : 광고문의에 따른 본인확인 및 원활한 의사소통 경로 확보</li>
                <li>3. 개인정보의 이용기간 : 모든 검토가 완료된 후 6개월간 이용자의 조회를 위하여 보관하며, 이후 해당정보를 지체없이 파기합니다.</li>
                <li>4. 그 밖의 사항은 개인정보처리방침을 준수합니다.</li>
                </ol>
            </div>
            <p class="chk personalInformation_agree"><input type="checkbox" id="personalInformation_agree" name="agreeYn" value="Y" class="chk" /> <label for="personalInformation_agree">개인정보 수집 및 이용에 대해서 동의합니다.</label></p>
        </section>
        </fieldset>
        --%>
        <fieldset>
        <legend><c:out value="${requestScope.menu.lvl2MenuPath}" /> 글수정</legend>
        <section>
            <h4 class="ty_A mgTm10_mq_mobile">질문 수정</h4>
            <table class="table_datail_AB w_1">
            <caption><c:out value="${requestScope.menu.lvl2MenuPath}" /> 글수정</caption>
            <tbody>
            <%--
            <c:if test="${!empty data.listCd}">
            <tr>
                <th scope="row"><label for="sort">분류</label></th>
                <td class="ty_AB ty_B">
                    <select id="sort" name="listSubCd" class="f_170px f_100per listSubCd" title="게시글 분류 선택">
                        <c:forEach items="${data.sections}" var="section" varStatus="status">
                        <option value="<c:out value="${section.code}" />"><c:out value="${section.name}" /></option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            </c:if>
            --%>
            <tr>
                <th scope="row"><label for="title">제목</label></th>
                <td class="ty_AB ty_B">
                	<%-- 비밀글 기능 삭제
                    <c:choose>
                    <c:when test="${data.secretYn == 'Y'}">
                    <input type="text" id="title" name="bbsTit" class="f_90per f_70per bbsTit" autocomplete="on" style="ime-mode:active;" />
                    <span class="chk secret"><input type="checkbox" id="secret" name="secretYn" class="secretYn" value="Y" /><label for="secret">비밀글</label></span>
                    </c:when>
                    <c:otherwise>
                    <input type="text" id="title" name="bbsTit" class="bbsTit" autocomplete="on" style="width:100%; ime-mode:active;" />
                    </c:otherwise>
                    </c:choose> --%>
                    <input type="text" id="title" name="bbsTit" class="bbsTit" autocomplete="on" style="width:100%; ime-mode:active;" />
                </td>
            </tr>
            <tr>
                <th scope="row"><label for="contents">내용</label></th>
                <td class="ty_AB ty_B">
                    <c:choose>
                    <c:when test="${data.htmlYn == 'Y'}">
                    <textarea id="contents" name="bbsCont" class="bbsCont html" style="ime-mode:active;"></textarea>
                    </c:when>
                    <c:otherwise>
                    <textarea id="contents" name="bbsCont" class="bbsCont" style="ime-mode:active;"></textarea>
                    </c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <th scope="row"><label for="writer">작성자</label></th>
                <td class="ty_AB ty_B">
                    <input type="text" id="writer" name="userNm" autocomplete="on"  class="f_110px userNm" style="ime-mode:active;" readonly="readonly" />
                </td>
            </tr>
            <tr class="hide">
                <th scope="row"><label for="newBulletIdInfo">비밀번호</label></th>
                <td class="ty_AB ty_B">
                    <input type="password" id="newBulletIdInfo" name="newBulletIdInfo" autocomplete="on" class="pwd f_110px" sylte="ime-mode:disabled;" />
                </td>
            </tr>
            <c:if test="${data.telYn == 'Y'}">
            <tr>
                <th scope="row"><label for="telephone">연락처</label></th>
                <td class="ty_AB ty_B">
                    <c:choose>
                    <c:when test="${data.telNeedYn == 'Y'}">
                    <%--
                    <select id="telephone" name="userTel1" class="userTel1 required" style="width:50px;" title="연락처 앞번호 선택"></select> -
                    --%>
                    <input type="tel" id="telephone"   name="userTel1" pattern="[0-9]{3}" autocomplete="on" class="userTel1 required" style="width:50px; ime-mode:disabled;" /> -
                    <input type="tel" id="telephone_2" name="userTel2" pattern="[0-9]{4}" autocomplete="on" class="userTel2 required" style="width:49px; ime-mode:disabled;" /> -
                    <input type="tel" id="telephone_3" name="userTel3" pattern="[0-9]{4}" autocomplete="on" class="userTel3 required" style="width:49px; ime-mode:disabled;" />
                    </c:when>
                    <c:otherwise>
                    <%--
                    <select id="telephone" name="userTel1" class="userTel1" style="width:50px;" title="연락처 앞번호 선택"></select> -
                    --%>
                    <input type="tel" id="telephone"   name="userTel1" pattern="[0-9]{3}" autocomplete="on" class="userTel1" style="width:50px; ime-mode:disabled;" /> -
                    <input type="tel" id="telephone_2" name="userTel2" pattern="[0-9]{4}" autocomplete="on" class="userTel2" style="width:49px; ime-mode:disabled;" /> -
                    <input type="tel" id="telephone_3" name="userTel3" pattern="[0-9]{4}" autocomplete="on" class="userTel3" style="width:49px; ime-mode:disabled;" />
                    </c:otherwise>
                    </c:choose>
                </td>
            </tr>
            </c:if>
            <c:if test="${data.emailRegYn == 'Y'}">
            <tr>
                <th scope="row"><label for="eMail"><abbr title="electronic mail">E-mail</abbr></label></th>
                <td class="ty_AB ty_B">
                    <div class="area_form">
                        <c:choose>
                        <c:when test="${data.emailNeedYn == 'Y'}">
                        <input type="email" id="eMail" name="userEmail1" class="flL f_170px f_46per userEmail1 required" title="E-mail ID" placeholder="E-mail ID" autocomplete="on" style="ime-mode:disabled;" />
                        <span class="txt talC f_8per_mq_mobile">@</span>
                        <input type="email" id="eMail_2" name="userEmail2" class="flL f_110px f_46per userEmail2 required" title="E-mail 주소" placeholder="E-mail address" autocomplete="on" style="ime-mode:disabled;" />
                        </c:when>
                        <c:otherwise>
                        <input type="email" id="eMail" name="userEmail1" class="flL f_170px f_46per userEmail1" title="E-mail ID" placeholder="E-mail ID" autocomplete="on" style="ime-mode:disabled;" />
                        <span class="txt talC f_8per_mq_mobile">@</span>
                        <input type="email" id="eMail_2" name="userEmail2" class="flL f_110px f_46per userEmail2" title="E-mail 주소" placeholder="E-mail address" autocomplete="on" style="ime-mode:disabled;" />
                        </c:otherwise>
                        </c:choose>
                        <span class="divi_select paL0_mq_mobile f_100per_mq_mobile f_mgT3_mq_mobile">
                            <select id="eMail_3" name="userEmail3" class="f_100per_mq_mobile userEmail3" title="이메일 주소 번지 선택"></select>
                        </span>
                    </div>
                </td>
            </tr>
            </c:if>
            <c:if test="${data.atfileYn == 'Y'}">
            <tr>
                <th scope="row"><label for="board-upload-list">파일첨부</label></th>
                <td class="ty_AB ty_B">
                    <ul id="board-upload-list" class="file_B <c:out value="${data.extLimit}" />"></ul>
                    <ul id="board-attach-list" class="list_file"></ul>
                </td>
            </tr>
            </c:if>
            <%--
            <tr>
                <th scope="row"><label for="securityCode">보안코드</label></th>
                <td class="ty_AB ty_BB">
                    <input type="text" id="securityCode" name="secuCd" autocomplete="on" class="f_110px secuCd" style="ime-mode:disabled;" />
                    <img id="qna-catpcha-image" src="<c:url value="/simpleCaptchaImage" />" alt="" title="보안코드" />
                </td>
            </tr>
            --%>
            </tbody>
            </table>
        </section>
        </fieldset>
        <div class="area_btn_A">
            <a  id="board-search-button" href="#" class="btn_A">목록</a>
            <a id="board-update-button" href="#" class="btn_A">수정</a>
            <a id="board-cancel-button" href="#" class="btn_AB">취소</a>
        </div>
        </form>
        <form id="board-search-form" name="board-search-form" method="post">
            <input type="hidden" name="page" value="<c:out value="${ param.page }" default="1" />" />
            <input type="hidden" name="rows" value="<c:out value="${ param.rows }" default="${data.listCnt}" />" />
            <input type="hidden" name="bbsCd" value="<c:out value="${ param.bbsCd }" default="${data.bbsCd}" />" />
            <input type="hidden" name="listSubCd" value="<c:out value="${ param.listSubCd }" default="" />" />
            <input type="hidden" name="searchType" value="<c:out value="${ param.searchType }" default="" />" />
            <input type="hidden" name="searchWord" value="<c:out value="${ param.searchWord }" default="" />" />
            <input type="hidden" name="seq" value="<c:out value="${ param.seq }" default="" />" />
            <input type="hidden" name="noticeYn" value="<c:out value="${ param.noticeYn }" default="" />" />
        </form>
    </div>
    <!-- // content -->
</div>
<!-- // layout_flex -->
</div></div>        
<!-- // wrap_layout_flex -->
</div></div>    
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
</div>
<!-- // layout_A -->
</body>
</html>
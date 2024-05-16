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
<%-- 마이페이지 > Qna > 질문 등록                      --%>
<%--                                                                        --%>
<%-- @author 장홍식                                                         --%>
<%-- @version 1.0 2015/08/12                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<script type="text/javascript" src="<c:url value="/js/ggportal/myPage/myQna/insertMyQna.js" />"></script>
</head>
<body>
<!-- layout_A -->
<div class="layout_A">
<%@ include file="/WEB-INF/jsp/portal/sect/header.jsp" %>

<section>
	<div class="container" id="container">
		<%@ include file="/WEB-INF/jsp/portal/sect/lnb.jsp" %>
		<article>
			<div class="contents" id="contents">
				<div class="contents-title-wrapper">
					<h3>나의 질문내역<span class="arrow"></span></h3>
				</div>
				<div class="layout_flex">
					<div class="layout_flex_100">
						<div class="area_h3 area_h3_AB area_h3_AC deco_h3_4">
							<%-- <p> <strong>${sessionScope.portalUserNm}</strong>님 환영합니다.</p> --%>
						</div>
				        <form id="qna-insert-form" name="qna-insert-form" method="post" enctype="multipart/form-data">
				        
				        <fieldset>
				        <legend><c:out value="${requestScope.menu.lvl2MenuPath}" /> 글작성</legend>
				        <section>
				            <h4 class="ty_A mgTm10_mq_mobile">질문 입력</h4>
				            <table class="table_datail_AB w_1">
				            <caption><c:out value="${requestScope.menu.lvl2MenuPath}" /> 글작성</caption>
				            <tbody>
				            <tr>
				                <th scope="row"><label for="title">제목</label></th>
				                <td class="ty_AB ty_B">
				                	<%-- 
				                    <c:choose>
				                    <c:when test="${data.secretYn == 'Y'}">
				                    <input type="text" id="title" name="bbsTit" class="f_90per f_70per bbsTit" autocomplete="on" style="ime-mode:active;" />
				                    <span class="chk secret"><input type="checkbox" id="secret" name="secretYn" class="secretYn" value="Y" /><label for="secret">비밀글</label></span>
				                    </c:when>
				                    <c:otherwise>
				                    <input type="text" id="title" name="bbsTit" class="f_90per f_70per bbsTit" autocomplete="on" style="ime-mode:active;" />
				                    </c:otherwise>
				                    </c:choose> --%>
				                    <input type="text" id="title" name="bbsTit" class="f_90per f_70per bbsTit" autocomplete="on" style="width: 100%; ime-mode:active;" />
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
				                    <c:choose>
				                    <c:when test="${!empty sessionScope.PortalLoginVO.userNm}">
				                    <input type="text" id="writer" name="userNm" value="<c:out value="${sessionScope.PortalLoginVO.userNm}" />" autocomplete="on"  class="f_110px userNm" style="ime-mode:active;" readonly="readonly" />
				                    </c:when>
				                    <c:otherwise>
				                    <input type="text" id="writer" name="userNm" value="<c:out value="${sessionScope.PortalLoginVO.userNm}" />" autocomplete="on"  class="f_110px userNm" style="ime-mode:active;" />
				                    </c:otherwise>
				                    </c:choose>
				                </td>
				            </tr>
				            <c:if test="${empty sessionScope.PortalLoginVO.userId}">
				            <tr>
				                <th scope="row"><label for="password">비밀번호</label></th>
				                <td class="ty_AB ty_B">
				                    <input type="password" id="userPw" name="userPw" autocomplete="on" class="pwd f_110px" style="ime-mode:disabled;" />
				                </td>
				            </tr>
				            </c:if>
				            <c:if test="${data.telYn == 'Y'}">
				            <tr>
				                <th scope="row"><label for="telephone">연락처</label></th>
				                <td class="ty_AB ty_B">
				                    <c:choose>
				                    <c:when test="${data.emailNeedYn == 'Y'}">
				                    <%--
				                    <select id="telephone" name="userTel1" class="userTel1 required" style="width:50px;" title="연락처 앞번호 선택"></select> -
				                    --%>
				                    <input type="tel" id="telephone"   name="userTel1" value="<c:out value="${sessionScope.PortalLoginVO.userTelSplit1}" />" pattern="[0-9]{3}" autocomplete="on" class="userTel1 required" style="width:50px; ime-mode:disabled;" /> -
				                    <input type="tel" id="telephone_2" name="userTel2" value="<c:out value="${sessionScope.PortalLoginVO.userTelSplit2}" />" pattern="[0-9]{4}" autocomplete="on" class="userTel2 required" style="width:49px; ime-mode:disabled;" /> -
				                    <input type="tel" id="telephone_3" name="userTel3" value="<c:out value="${sessionScope.PortalLoginVO.userTelSplit3}" />" pattern="[0-9]{4}" autocomplete="on" class="userTel3 required" style="width:49px; ime-mode:disabled;" />
				                    </c:when>
				                    <c:otherwise>
				                    <%--
				                    <select id="telephone" name="userTel1" class="userTel1" style="width:50px;" title="연락저 앞번호 선택"></select> -
				                    --%>
				                    <input type="tel" id="telephone"   name="userTel1" value="<c:out value="${sessionScope.PortalLoginVO.userTelSplit1}" />" pattern="[0-9]{3}" autocomplete="on" class="userTel1" style="width:50px; ime-mode:disabled;" /> -
				                    <input type="tel" id="telephone_2" name="userTel2" value="<c:out value="${sessionScope.PortalLoginVO.userTelSplit2}" />" pattern="[0-9]{4}" autocomplete="on" class="userTel2" style="width:49px; ime-mode:disabled;" /> -
				                    <input type="tel" id="telephone_3" name="userTel3" value="<c:out value="${sessionScope.PortalLoginVO.userTelSplit3}" />" pattern="[0-9]{4}" autocomplete="on" class="userTel3" style="width:49px; ime-mode:disabled;" />
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
				                        <input type="email" id="eMail" name="userEmail1" value="<c:out value="${sessionScope.PortalLoginVO.userEmailSplit1}" />" class="flL f_170px f_46per userEmail1 required" title="E-mail ID" placeholder="E-mail ID" autocomplete="on" style="ime-mode:disabled;" />
				                        <span class="txt talC f_8per_mq_mobile">@</span>
				                        <input type="email" id="eMail_2" name="userEmail2" value="<c:out value="${sessionScope.PortalLoginVO.userEmailSplit2}" />" class="flL f_110px f_46per userEmail2 required" title="E-mail 주소" placeholder="E-mail address" autocomplete="on" style="ime-mode:disabled;" />
				                        </c:when>
				                        <c:otherwise>
				                        <input type="email" id="eMail" name="userEmail1" value="<c:out value="${sessionScope.PortalLoginVO.userEmailSplit1}" />" class="flL f_170px f_46per userEmail1" title="E-mail ID" placeholder="E-mail ID" autocomplete="on" style="ime-mode:disabled;" />
				                        <span class="txt talC f_8per_mq_mobile">@</span>
				                        <input type="email" id="eMail_2" name="userEmail2" value="<c:out value="${sessionScope.PortalLoginVO.userEmailSplit2}" />" class="flL f_110px f_46per userEmail2" title="E-mail 주소" placeholder="E-mail address" autocomplete="on" style="ime-mode:disabled;" />
				                        </c:otherwise>
				                        </c:choose>
				                        <span class="divi_select paL0_mq_mobile f_100per_mq_mobile f_mgT3_mq_mobile">
				                            <select id="eMail_3" name="userEmail3" class="f_100per_mq_mobile" title="이메일 주소 번지 선택"></select>
				                        </span>
				                    </div>
				                </td>
				            </tr>
				            </c:if>
				            <c:if test="${data.atfileYn == 'Y'}">
				            <tr>
				                <th scope="row"><label for="fileAdd">파일첨부</label></th>
				                <td class="ty_AB ty_B">
				                    <ul id="qna-upload-list" class="file_B <c:out value="${data.extLimit}" />"></ul>
				                </td>
				            </tr>
				            </c:if>
				            <%--
				            <tr>
				                <th scope="row"><label for="securityCode">보안코드</label></th>
				                <td class="ty_AB ty_BB">
				                    <input type="text" id="securityCode" name="secuCd" autocomplete="on" class="f_110px secuCd" style="ime-mode:disabled;" />
				                    <img id="board-catpcha-image" src="<c:url value="/simpleCaptchaImage" />" alt="" title="보안코드" />
				                </td>
				            </tr>
				            --%>
				            </tbody>
				            </table>
				        </section>
				        </fieldset>
				        <div class="area_btn_A">
				            <a  id="qna-search-button" href="#" class="btn_A">목록</a>
				            <a id="qna-insert-button" href="#" class="btn_A">저장</a>
				            <a id="qna-cancel-button" href="#" class="btn_AB">취소</a>
				        </div>
				        </form>
				        <form id="qna-search-form" name="qna-search-form" method="post">
				            <input type="hidden" name="page" value="<c:out value="${param.page}" default="1" />" />
				            <input type="hidden" name="rows" value="<c:out value="${param.rows}" default="${data.listCnt}" />" />
				            <input type="hidden" name="bbsCd" value="<c:out value="${param.bbsCd}" default="${data.bbsCd}" />" />
				            <input type="hidden" name="listSubCd" value="<c:out value="${param.listSubCd}" default="" />" />
				            <input type="hidden" name="searchType" value="<c:out value="${param.searchType}" default="" />" />
				            <input type="hidden" name="searchWord" value="<c:out value="${param.searchWord}" default="" />" />
				            <input type="hidden" name="seq" value="<c:out value="${param.seq}" default="" />" />
				            <input type="hidden" name="noticeYn" value="<c:out value="${param.noticeYn}" default="" />" />
				        </form>
					</div>				
				</div>				
			</div>
		</article>
</section>

<!-- // wrap_layout_flex -->
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
</div>
<!-- // layout_A -->
</body>
</html>
        
        
        
        
        
        
        
        
        
        
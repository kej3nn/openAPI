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
<%-- 마이페이지 > 활용갤러리 > 등록                      --%>
<%--                                                                        --%>
<%-- @author 장홍식                                                         --%>
<%-- @version 1.0 2015/08/13                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<script type="text/javascript" src="<c:url value="/js/ggportal/myPage/utilGallery/insertUtilGallery.js" />"></script>
</head>
<body>
<!-- layout_A -->
<div class="layout_A">
<%@ include file="/WEB-INF/jsp/portal/sect/headerOpen.jsp" %>
<div class="container" id="container">
<!-- leftmenu -->
<%@ include file="/WEB-INF/jsp/portal/sect/lnb.jsp" %>
<!-- //leftmenu -->

<!-- contents -->
	<div class="contents" id="contents">
		<div class="contents-title-wrapper">
			<h3><c:out value="${requestScope.menu.lvl2MenuPath}" /><span class="arrow"></span></h3>
		</div>
<!-- wrap_layout_flex -->
<div class="wrap_layout_flex fix_page">
<div class="layout_flex_100">
<!-- layout_flex -->
<div class="layout_flex">
	<%@ include file="/WEB-INF/jsp/ggportal/mypage/sect/left.jsp" %>
    <!-- content -->
    <div id="content" class="content">
        <h2 class="hide"><c:out value="${requestScope.menu.lvl1MenuPath}" /></h2>
		<div class="area_h3 area_h3_AB area_h3_AC deco_h3_4">
			<p> <strong>${sessionScope.portalUserNm}</strong>님 환영합니다.</p>
		</div>
        <form id="gallery-insert-form" name="gallery-insert-form" method="post" enctype="multipart/form-data">
		<fieldset>
		<legend>활용 사례 등록</legend>
		<section>
			<table class="table_datail_AB w_1">
            <caption>활용갤러리 등록</caption>
            <h4 class="ty_A mgTm10_mq_mobile">활용 사례 등록</h4>
			<tbody>
			 <tr>
				<th scope="row"><span class="text_require">* </span>활용 구분</th>
				<td class="ty_AB ty_B">
				<span class="area_form_radio_B">	
					<c:forEach items="${data.sections}" var="code" varStatus="status">
						<span class="radio"><input type="radio" id="listSubCd_${status.count}" name="listSubCd" value="${code.code }" <c:if test="${status.index == 0 }">checked="checked"</c:if> /><label for="listSubCd_${status.count }">${code.name }</label></span>
					</c:forEach>
				</span>
				</td>
			</tr>
			<tr>
		            <th scope="row"><span class="text_require">* </span>제작자 구분</th>
				<td class="ty_AB ty_B">
					<span class="radio"><input type="radio" id="prdCd_1" name="prdCd" value="1" checked="checked"/><label for="prdCd_1">개인</label></span>
					<span class="radio"><input type="radio" id="prdCd_2" name="prdCd" value="2" /><label for="prdCd_2">사업자</label></span>
				</td>
			</tr>
			<tr>
		            <th scope="row"><label for="writer"><span class="text_require">* </span>제작자명</label></th>
				<td class="ty_AB ty_B">
					<input type="text" id="writer" class="f_110px" autocomplete="on" name="userNm" title="유저명"/>
				</td>
		            
			</tr>
			<!-- <tr>
				<th scope="row"><label for="AuthorizationKey">활용 인증키</label></th>
				<td class="ty_AB ty_B">
					<select id="AuthorizationKey" name="keySeq" class="f_100per_mq_mobile" title="활용 인증키 선택">
						<option value="">출력할 API를 선택하세요.</option>
					</select>
				</td>
			</tr> -->
			<tr>
				<th scope="row"><label for="title"><span class="text_require">* </span>제목</label></th>
				<td class="ty_AB ty_B">
					<input type="text" id="title" class="f_100per" autocomplete="on" name="bbsTit" title="제목"/>
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="contents"><span class="text_require">* </span>주요기능</label></th>
				<td class="ty_AB ty_B"><textarea id="contents" name="bbsCont"></textarea></td>
			</tr>
			<tr>
				<th scope="row"><label for="useData">활용데이터</label></th>
				<td class="ty_AB ty_B">
					<span class="divi_form f_7per f_20per f_mgT3_mq_mobile"><a style="cursor:pointer" id="openInfBtn" class="btn_C">선택</a></span>
					<ul class="file_B file_BB" id="openInfList" name="openInfList">
					</ul>
				</td>
			</tr>
			<!-- <tr>
				<th scope="row"><label for="mainImg"></span>대표이미지</label></th>
				<td class="ty_AB ty_B">
					<ul class="file_B">
					<li>	
						<input type="file" name="mainImg" id="mainImg" class="f_65per f_80per" title="대표이미지 첨부파일" />
						<span class="desc">이미지 사이즈 : 205 X 205(pixel)</span>
					</li>
					</ul>
				</td>
			</tr> -->
			<tr>
				<th scope="row"><label><span class="text_require">* </span>화면 예시</label></th>
				<td class="ty_AB ty_B">
					<ul class="file_B" id="examImgList">
					<li>
						<input type="file" name="examImg" class="f_65per f_80per" title="화면 예시 첨부파일" />
						<a style="cursor:pointer" id="examImgAddBtn" class="btn_C">추가</a>
						<span class="desc">이미지 사이즈 : 300 X 350(pixel)</span>
					</li>
					</ul>
				</td>
			</tr>
			<tr>
				<th scope="row"><span class="text_require">* </span>연결</th>
				<td class="ty_AB ty_B">
					<ul id="linkUrlList">
					<li>	
						<div class="area_form area_connect">
							<div name="urlNmDiv" class="urlDiv">
								<span for="aaa">연결명</span>
								<input type="text" id="aaa" name="linkNm" title="링크명">
							</div>
							<div name="urlDiv" class="urlDiv">
								<span for="bbb">URL</span>
								<input type="text" id="bbb" name="url" title="url">
								<a href="javascript:;" id="linkUrlAddBtn" class="btn_C">추가</a>
							</div>
						</div>
					</li>
					</ul>
				</td>
			</tr>
			<tr>
				<th scope="row">안내수신</th>
				<td class="ty_AB ty_B">
					<div>
						<input type="checkbox" id="dvpEmailYn" name="dvpEmailYn" value="Y">
						<label for="dvpEmailYn">이메일</label>&nbsp;&nbsp;&nbsp;
						<input type="checkbox" id="dvpHpYn" name="dvpHpYn" value="Y">
						<label for="dvpHpYn">SMS</label>&nbsp;&nbsp;&nbsp;
						<input type="checkbox" id="dvpKakaoYn" name="dvpKakaoYn" value="Y">
						<label for="dvpKakaoYn">카카오알림톡</label>
					</div>
				</td>
			</tr>
			</tbody>
			</table>
		</section>
		</fieldset>
		
		<div class="area_btn_A">
            <a id="gallery-search-button" href="#" class="btn_A">목록</a>
            <a id="gallery-insert-button" href="#" class="btn_A">저장</a>
            <a id="gallery-cancel-button" href="#" class="btn_AB">취소</a>
		</div>
		</form>
		<form id="openInf-search-form" name="openInf-search-form" method="post">
		<div id="openInf-sect" style="display:none;">
			<div class="sheet-detail pd-resize" id="openInf-search-pop">
				<h5 class="sheet-header">활용데이터 선택</h5>
				<a href="javascript:;" class="pop-close sheet-close">닫기</a>
				<div class="theme_modal_box">
					<table>
						<colgroup>
							<col style="width:16%;">
							<col style="">
						</colgroup>
						<tr>
							<th>검색어</th>
							<td>
								<select id="searchGubun" name="searchGubun">
									<option value="INF_NM">활용데이터명</option>
								</select>
								<input type="text" id="searchVal" name="searchVal" value="" width="70%"/>
								<button type="button" class="btn_A" title="검색" name="btn_search">검색</button>
							</td>
						</tr>
					</table>
            	</div>
            	<div>
               		<div id="sheet" class="sheet"></div>
               	</div>
            	<div class="area_btn_A">
					<a href='#' class='btn_A'  title='추가' name='a_add'>추가</a>
					<a href='javascript:;' class='btn_A'  title='닫기' name='a_close'>닫기</a>
				</div>    
			</div>
			<div class="bgshadow">&nbsp;</div>
		</div>
		</form>
        <form id="gallery-search-form" name="gallery-search-form" method="post">
            <input type="hidden" name="page" value="<c:out value="${param.page}" default="1" />" />
            <input type="hidden" name="rows" value="<c:out value="${param.rows}" default="${data.listCnt}" />" />
            <input type="hidden" name="bbsCd" value="<c:out value="${param.bbsCd}" default="${data.bbsCd}" />" />
            <input type="hidden" name="listSubCd" value="<c:out value="${param.listSubCd}" default="" />" />
            <input type="hidden" name="list1SubCd" value="<c:out value="${param.list1SubCd}" default="" />" />
            <input type="hidden" name="searchType" value="<c:out value="${param.searchType}" default="" />" />
            <input type="hidden" name="searchWord" value="<c:out value="${param.searchWord}" default="" />" />
            <input type="hidden" name="seq" value="<c:out value="${param.seq}" default="" />" />
            <input type="hidden" name="noticeYn" value="<c:out value="${param.noticeYn}" default="" />" />
        </form>
 </div>
    <!-- // content -->
</div>
<!-- // layout_flex -->
</div></div>
<!-- // wrap_layout_flex -->

</div>
</div>
<c:import  url="/WEB-INF/jsp/inc/iframepopup.jsp"/>
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
</div>
<!-- // layout_A -->
</body>
</html>
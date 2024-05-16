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
<%-- 마이페이지 > 인증키 발급                      --%>
<%--                                                                        --%>
<%-- @author 장홍식                                                         --%>
<%-- @version 1.0 2015/08/11                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/ggportal/sect/head.jsp" %>
<script type="text/javascript">
var tabIdx = ${tabIdx};
</script>
<script type="text/javascript" src="<c:url value="/js/ggportal/myPage/actKey/actKey.js" />"></script>
<style type="text/css">
a { cursor:pointer;}
</style>
</head>
<body>
<!-- layout_A -->
<div class="layout_A">
<%@ include file="/WEB-INF/jsp/ggportal/sect/header.jsp" %>
<!-- wrap_layout_flex -->
<div class="wrap_layout_flex"><div class="layout_flex_100">
<%@ include file="/WEB-INF/jsp/ggportal/sect/gnb.jsp" %>
<!-- layout_flex #################### -->
<div class="layout_flex">
	<%@ include file="/WEB-INF/jsp/ggportal/mypage/sect/left.jsp" %>
    <!-- content -->
    <div id="content" class="content">
        <%@ include file="/WEB-INF/jsp/ggportal/sect/navigation.jsp" %>
        <h2 class="hide"><c:out value="${requestScope.menu.lvl1MenuPath}" /></h2>
		<div class="area_h3 area_h3_AB area_h3_AC deco_h3_4">
			<h3 class="ty_A"><span>국회 나눔데이터</span><strong>인증키 발급</strong></h3>
			<p> <strong>${sessionScope.portalUserNm}</strong>님 환영합니다.</p>
		</div>
		<h4 class="hide">인증키 발급</h4>
		<!-- tab_AB -->
		<div class="tab_AB  gT0_mq_mobile" id="tab_layout">
			<a id="tab_0" href="#actKey">인증키 발급 내역</a>
			<a id="tab_3" href="#actKey">인증키 이용 내역</a>
			<a id="tab_1" href="#actKey">인증키 발급</a>
			<a id="tab_2" href="#actKey">Open API 테스트</a>
		</div>
		
		<!-- 인증키 발급 내역 레이아웃 -->
		<div id="content_0" class="children_content" style="display:none;">
			<div class="area_btn_AC mq_tablet">
				<a class="btn_AC">인증키 발급</a>
			</div>
			<section>
				<h5 class="hide">인증키 발급 내역</h5>
				<ul class="search search_AC">
				<li class="ty_BB">
					<ul class="ty_A mq_tablet">
						<li id="actKey">전체 <strong class="totalNum">0</strong>건</li>
					</ul>
				</li>
				</ul>
				<!-- <span><a class="btn_C" id="api-search-btn">폐 기</a></span> -->
				<div class="area_btn_D">
					<a class="btn_D" id="delActKey-btn" href="#">폐기</a>
				</div>
				<!-- PC, tablet -->
				<table class="table_boardList_A table_boardList_AB mq_tablet">
				<caption>인증키 발급내역</caption>
				<colgroup>
					<col style="width:37%;"/>
					<col style="width:36%;"/>
					<col style="width:10%;"/>
					<col style="width:9%;"/>
					<col style="width:8%;"/>
				</colgroup>
				<thead>
				<tr>
					<th scope="col">인증키</th>
					<th scope="col">활용용도</th>
					<th scope="col">발급일</th>
					<th scope="col">호출건수</th>
					<th scope="col">사용여부</th>
				</tr>
				</thead>
				<tbody id="actkey-list">
				</tbody>
				</table>
				<!-- // PC, tablet -->
				<!-- mobile -->
				<ul class="list_board_A mq_mobile mgT10_mq_mobile"  id="actkey-list-mob">
				</ul>
				<!-- // mobile -->
			</section>
			<section>	
				<h5 class="ty_h4">Open API 이용제한에 대하여</h5>
				<div class="box_BB notice_authenticationKey">
					<p class="p_tyC">발급 받은 인증키가 지속적인 사용되는 경우에는 이용제한 기준일 전까지 활용갤러리에 등록하신 후 승인(등록 완료)을 받아야 합니다.<br />
					인증키 사용에 대한 자세한 내용은 인증키 이용내역을 통해 확인할 수 있습니다.</p>
					<p class="p_tyC mgT9">이용제한 기준 : <strong class="ty_A">최근 3개월 이내 이용일 기준으로 30일 이상 호출 발생</strong></p>
					<ul class="list_B_B mgT11">      
					<li>정상 상태의 인증키는 최대 15개까지 발급받을 수 있습니다.</li>
					<li>신청하신 인증키는 타인에게 양도할 수 없습니다.</li>
					<li>발급받은 인증키는 관리목적상 활용용도 별로 구분한 것으로 국회 나눔데이터의 모든 Open API에 활용 가능합니다.</li>
					<li>자세한 내용은 ‘참여 소통 활용 > 개발자 공간 > <a href="<c:url value="/portal/bbs/develop/searchBulletinPage.do?tab=3"/>" target="_self">Open API 사용방법</a>’을 참조하시기 바랍니다.</li>
					</ul>
				</div>
			</section>
			<div class="area_btn_AC mq_mobile">
				<a class="btn_AC">인증키 발급</a>
			</div>
		</div>
		<!-- // 인증키 발급 내역 레이아웃 -->
		
		<!-- 인증키 이용 내역 -->
		<div id="content_3" class="children_content" style="display:none;">
			<div class="area_btn_AC mq_tablet">
				<a class="btn_AC">인증키 발급</a>
			</div>
			<section>	
				<h5 class="ty_h4"> </h5>
				<div class="box_BB notice_authenticationKey" style="padding:10px 10px 10px 10px">
					<ul class="list_B_B">   
					<li>최근 1개월의 인증키 내역을 보실 수 있습니다.</li>
					<li>
						<span class="field">
							<select id="actKeySelect" style="border:1px solid #d5d5d5; width:90%;"title="인증키 선택">
								<option value="">인증키를 선택하세요.</option>
							</select>
							<a class="btn_C" id="act-key-select-btn">출력</a>
						</span>
					</li>
					</ul>
				</div>
				<!-- PC, tablet -->
				<table class="table_boardList_A table_boardList_AB mq_tablet">
				<caption>인증키 발급내역</caption>
				<colgroup>
					<col style="width:20%;"/>
					<col style="width:20%;"/>
					<col style="width:20%;"/>
					<col style="width:20%;"/>
					<col style="width:20%;"/>
				</colgroup>
				<thead>
				<tr>
					<th scope="col">이용일시</th>
					<th scope="col">호출(건)</th>
					<th scope="col">데이터(건)</th>
					<th scope="col">평균 응답속도(초)</th>
					<th scope="col">호출량(KB)</th>
				</tr>
				</thead>
				<tbody id="actkey-use-list">
					<tr><td colspan="5" class="noData">해당 자료가 없습니다.</td></tr>
				</tbody>
				</table>
				<!-- // PC, tablet -->
				<!-- mobile -->
				<ul class="list_board_A mq_mobile mgT10_mq_mobile"  id="actkey-use-list-mob">
					<li class="noData">해당 자료가 없습니다.</li>
				</ul>
				<!-- // mobile -->
			</section>
		</div>
		<!-- // 인증키 이용 내역 -->
		
		<!-- 인증키 발급 요청 레이아웃 -->
        <div id="content_1" class="children_content" style="display:none;">
			<div class="area_desc_AC">
				<p class="p_tyA">공공데이터를 이용하시려면 먼저 <span class="point">인증키를 발급</span> 받으셔야 합니다.</p>
			</div>
			<section>	
				<h5 class="ty_h4">공지사항</h5>
				<div class="box_BB notice_authenticationKey" style="padding:10px 10px 10px 10px">
					<ul class="list_B_B">   
					<li>Open API 호출 건 당 최대 1,000건 이상을 요청 할 수 없습니다. 데이터의 총 건수가 1,000건 이상일 경우 나누어 호출 하시기 바랍니다.</li>
					<li>발급 받은 인증키로 지속적인 사용(서비스 오픈 등)을 하시는 경우 활용 사례를 등록 하셔야 제한 없이 사용이 가능합니다.</li>
					</ul>
				</div>
			</section>
			
			<section>	
				<h5 class="ty_h4">Open API 인증키 이용 안내</h5>
            <div class="box_B area_service_agreement area_OpenAPI_guide"><div class="service_agreement">
            <ol>
            <li>
                <strong class="tit">[Open API 서비스의 제한]</strong>
                <ol>
                <li>① 국회는 특정 Open API 서비스의 범위를 제한하거나 별도의 이용가능 시간 또는 이용가능 횟수를 지정할 수 있으며, 관련 법률 개정으로 인해 Open API 서비스 제공 대상이 변경되어 더 이상 활용을 할 수 없을 경우, 서비스 활용으로 인해 제공기관의 업무에 지장을 초래하거나 인프라 성능 등의 이유로 서비스 제공 상의 성능 문제가 발생한 경우 활용을 제한할 수 있습니다. 이 경우 이를 회원에게 사전에 고지하여야 합니다.</li>
                <li>② 국회는 회원이 Open API 서비스를 이용함에 있어 법령을 위반하거나 약관 또는 서비스 이용기준 등을 위반한 경우, 제공된 정보를 임의로 위조·변조하여 저작권을 위반하는 경우에는 제 1항의 규정에도 불구하고 즉시 인증 Key의 이용을 정지하는 등의 조치를 취할 수 있습니다.</li>
                <li>③ 국회는 회원이 Open API 서비스에 대한 불법적인 해킹 시도, 비정상적인 방식을 통한 오남용 시도, 네트워크 사용 초과 등의 시도를 하는 경우 제 1항의 규정에도 불구하고 즉시 인증 Key의 사용을 정지시킬 수 있습니다.</li>
                <li>④ 국회는 회원이 Open API 서비스를 활용함에 있어, 일정량 이상의 트래픽을 유발하는 경우, Open API 활용사례 등록을 강제화 할 수 있습니다. 이러한 규정에도 불구하고, 활용사례를 등록하지 않을 경우 해당 인증 Key의 사용을 제한할 수 있습니다.</li>
                </ol>
            </li>
            <li>
                <strong class="tit">[인증 Key의 이용 및 관리]</strong>
                <ol>
                <li>① 회원은 발급 받은 인증 Key를 타인에게 제공·공개하거나 공유할 수 없으며, 발급 받은 회원 본인에 한하여 이를 사용할 수 있습니다.</li>
                <li>② 국회는 인증 Key를 발급함에 있어 이용기간을 지정할 수 있으며, 이용기간을 변경하고자 하는 경우에는 사전에 이를 고지하여야 합니다.</li>
                </ol>
            </li>
            </ol>
            </div></div>
			</section>
			
			<form id="actkey-insert-form" name="actkey-insert-form" method="post" enctype="multipart/form-data">
			<fieldset>
			<legend>내용 입력</legend>
			<section>
				<h5 class="ty_h4">내용 입력</h5>
				<table class="table_datail_AB w_1">
				<caption>내용 입력</caption>
				<tbody>
				<tr>
					<th scope="row"><label for="use">활용용도</label></th>
					<td class="ty_AB ty_B"><input type="text" id="use" name="useNm" autocomplete="on"  class="f_100per" title="유저명"/></td>
				</tr>
				<tr>
					<th scope="row"><label for="contents">내용</label></th>
					<td class="ty_AB ty_B"><textarea id="contents" name="useCont" class="ty_AB"></textarea></td>
				</tr>
				</tbody>
				</table>
			</section>
			</fieldset>
			<div class="area_btn_E">
				<a id="create-actKey-btn" class="btn_EB">인증키 발급 요청</a>
			</div>
			</form>
        </div>
		<!-- // 인증키 발급 요청 레이아웃 -->
		
		<!-- Open API 검색 레이아웃 -->
        <div id="content_2" class="children_content" style="display:none;">
			<div class="area_btn_AC mq_tablet">
				<a class="btn_AC">인증키 발급</a>
			</div>
			<fieldset>
			<legend>Open API 검색</legend>
			<section>
				<h5 class="hide">Open API 검색</h5>
				<div class="box_BB search_C mgT30 mgT10_mq_mobile">
					<table class="table_search_C w_2">
					<caption>Open API 검색</caption>
					<tr>
						<th scope="row" class="ty_B"><label for="API_search">API 검색</label></th>
						<td>
						<span class="field">	
							<input type="text" id="API_search" autocomplete="on" class="f_93per f_83per" name="infNm" title="검색"/>
							<a class="btn_C" id="api-search-btn">검색</a>
						</span>
						</td>
					</tr>
					<tr>
						<th scope="row" class="ty_B"><label for="APIname">API명</label></th>
						<td>
						<span class="field">	
							<select id="APIname" class="f_93per f_83per" style="height:auto;" title="API명 선택">
							<option value="">API를 선택하세요.</option>
							</select>
							<a class="btn_C" id="api-test-btn">출력</a>
							<span class="desc block">API명은 국회 자체에서 제공하는 API만 조회 가능합니다.</span>
						</span>
						</td>
					</tr>
					</table>
				</div>
			</section>
			</fieldset>
			
			<fieldset>
			<legend>내용 입력</legend>
			<section>
				<h5 class="ty_h4">Open API 결과</h5>
				<table class="table_datail_AB w_1">
				<caption>Open API 결과</caption>
				<tbody>
				<tr>
					<th scope="row">요청주소</th>
					<td class="ty_AB"><strong class="point" id="api-ep-url"></strong></td>
				</tr>
				<tr>
					<th scope="row">내용</th>
					<td class="ty_AB" >
					<iframe id="api-test-result" title="샘플 URL" style="width:100%; height:100%; marginwidth:0px; marginheight:0px; frameborder:0; scrolling:auto;"></iframe>
					</td>
				</tr>
				</tbody>
				</table>
			</section>
			</fieldset>
			<div class="area_btn_AC mq_mobile">
				<a class="btn_AC">인증키 발급</a>
			</div>
        </div>
		<!-- // Open API 검색 레이아웃 -->
	</div>
	<!-- // content -->
</div>
<!-- // layout_flex -->
</div></div>		
<!-- // wrap_layout_flex ############################## -->
<%@ include file="/WEB-INF/jsp/ggportal/sect/footer.jsp" %>
</div>
<!-- // layout_A -->
</body>
</html>
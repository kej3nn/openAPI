<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)searchBudgetFund.jsp 1.0 2019/08/12                                   --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 	--%>
<%-- 정보공개 > 세입·세출예산운용                 																												   	--%>
<%--                                                                        																						--%>
<%-- @author SoftOn                                                         								 												--%>
<%-- @version 1.0 2019/07/22                                                																			--%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 	--%>
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- head include -->
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
</head>
<body>

<!-- header html -->
<%@ include file="/WEB-INF/jsp/portal/sect/header.jsp" %>
<div class="container" id="container">
<!-- leftmenu -->
<%@ include file="/WEB-INF/jsp/portal/sect/lnb.jsp" %>
<!-- //leftmenu -->

<!-- contents -->
	<div class="contents" id="contents">
		<div class="contents-title-wrapper">
			<h3>세입·세출예산운용<span class="arrow"></span></h3>
        </div>

<div class="layout_flex">
    <div class="layout_flex_100">
        <fieldset>
        	<section>
        	
				<div id="tab_B">
			        <ul id="tabs" class="tabmenu-type02 depth2">
						<li class="on"><a href="javascript:;">수입징수현황</a></li>
					    <li><a href="javascript:;">지출집행현황</a></li>
				    </ul>
			    </div>
			    
			    <!-- 수입징수현황 -->
			    <div id="contents_01">

			        <fieldset>
			        <legend>수입징수현황</legend>
			        <section>
			        	<form name=formIn>
			            <table class="table_datail_CC width_A bt1x">
			            <caption>검색</caption>
			            <tbody>
			            <tr>
			                <th scope="row"><label for="title">항목선택</label></th>
			                <td>
					            <span class="select">
									<input type="radio" name="s_gubunIn" value="01" class="border_none" onclick="fn_sGugunDivIn();" checked><label for="organ"> 수입항별 </label>
									<input type="radio" name="s_gubunIn" value="02" class="border_none" onclick="fn_sGugunDivIn();"><label for="organ"> 수입목별 </label>
					            </span>
			                </td>
			                <th scope="row"><label for="title">검색기간</label></th>
			                <td>
					            <span class="select">
					                <select name="syear_writedate" id="FSCL_IN_YY" title="년도를 선택하세요.">
										<option value="">년도</option>
					                </select>
					            </span>
					            <span class="select">
					                <select name="smonth_writedate" id="EXE_IN_M" title="월을 선택하세요.">
										<option value="">월</option>
					                </select>
					            </span>
					            <span class="select">
					                <select name="sday_writedate" id="EXE_IN_DATE" title="일을 선택하세요.">
										<option value="">전체</option>
										<option value="01">금일</option>
					                </select>
					            </span>
			                </td>
			            </tr>
			            </tbody>
			            </table>
			            </form>
			        </section>
			        </fieldset>
			        <div class="area_btn_A">
			        	<a id="insert-button" href="#none" onclick="searchFm_firstIn();" class="btn_A">조회</a>
			        </div>
			
					<h5 class="title0401">수입징수현황(세입)</h5>
			        <!-- 목록 -->
			        <section id="tab_B_cont_1" class="tab_AB_cont">
			            <table id="data-table" class="table_boardList_A table_boardList_AB  mgTm10_mq_mobile mtable_layout" summary="게시판 목록에 대해 연도, 월, 회계, 수입관, 수입목, 예산, 당월수납액, 누계수납액 순으로 보실 수 있습니다.">
			            <caption>수입징수현황</caption>
			            <colgroup>
							<col width="8%" />
							<col style="width: 20%;" />
							<col style="width: 20%;" />
							<col style="width: 22%;" />
							<col style="width: 10%;" />
							<col style="width: 10%;" />
							<col style="width: 10%;" />
			            </colgroup>
			            <thead>
							 <tr id="gubunTrIn1">
								<th scope="col" >회계</th>
								<th scope="col" >수입관</th>
								<th colspan="2" scope="col" >수입항</th>
								<th scope="col" >예산</th>
								<th scope="col" >당월수납액</th>
								<th scope="col" >누계수납액</th>
							</tr>
							<tr id="gubunTrIn2" style="display: none;">
								<th scope="col" >회계</th>
								<th scope="col" >수입관</th>
								<th colspan="2" scope="col" >수입항</th>
								<th scope="col" >예산</th>
								<th scope="col" >당일수납액</th>
								<th scope="col" >누계수납액</th>
							</tr>
							<tr id="gubunTrIn3" style="display: none;">
								<th scope="col" >회계</th>
								<th scope="col" >수입관</th>
								<th scope="col" >수입항</th>
								<th scope="col" >수입목</th>
								<th scope="col" >예산</th>
								<th scope="col" >당월수납액</th>
								<th scope="col" >누계수납액</th>
							</tr>
			            </thead>
			            <tbody id="vwFormIn">
			            </tbody>
			            </table>
			        </section>
			        <!-- // 목록 -->
		
				</div>
				<!-- //수입징수현황 -->
				
				<!-- 지출집행현황 -->
				<div id="contents_02" style="display:none;">

			        <fieldset>
			        <legend>지출집행현황</legend>
			        <section>
			        	<form name=formOut>
			            <table class="table_datail_CC width_A bt1x">
			            <caption>검색</caption>
			            <tbody>
			            <tr>
			                <th scope="row"><label for="title">항목선택</label></th>
			                <td>
					            <span class="select">
									<input type="radio" name="s_gubunOut" value="01" class="border_none" onclick="fn_sGugunDivOut();" checked><label for="organ"> 단위사업별 </label>
									<input type="radio" name="s_gubunOut" value="02" class="border_none" onclick="fn_sGugunDivOut();"><label for="organ"> 세부사업별 </label>
					            </span>
			                </td>
			                <th scope="row"><label for="title">검색기간</label></th>
			                <td>
					            <span class="select">
					                <select name="syear_writedate" id="FSCL_OUT_YY" title="년도를 선택하세요.">
										<option value="">년도</option>
					                </select>
					            </span>
					            <span class="select">
					                <select name="smonth_writedate" id="EXE_OUT_M" title="월을 선택하세요.">
										<option value="">월</option>
					                </select>
					            </span>
					            <span class="select">
					                <select name="sday_writedate" id="EXE_OUT_DATE" title="일을 선택하세요.">
										<option value="">전체</option>
					                </select>
					            </span>
			                </td>
			            </tr>
			            </tbody>
			            </table>
			            </form>
			        </section>
			        </fieldset>
			        <div class="area_btn_A">
			        	<a id="insert-button" href="#none" onclick="searchFm_firstOut();" class="btn_A">조회</a>
			        </div>
			
					<h5 class="title0401">지출집행현황(세출)</h5>
			        <!-- 목록 -->
			        <section id="tab_B_cont_1" class="tab_AB_cont">
			            <table id="data-table" class="table_boardList_A table_boardList_AB  mgTm10_mq_mobile mtable_layout">
			            <caption><c:out value="${requestScope.menu.lvl3MenuPath}" /></caption>
			            <colgroup>
							<col width="8%" />
							<col style="width: 12%;" />
							<col style="width: 13%;" />
							<col style="width: 13%;" />
							<col style="width: 15%;" />
							<col style="width: 13%;" />
							<col style="width: 8%;" />
							<col style="width: 9%;" />
							<col style="width: 9%;" />
			            </colgroup>
			            <thead>
							 <tr id="gubunTrOut1" style="display: table-row;">
								<th scope="col">회계</th>
								<th scope="col">분야</th>
								<th scope="col">부문</th>
								<th scope="col">프로그램</th>
								<th colspan="2" scope="col">단위사업</th>
								<th scope="col">예산</th>
								<th scope="col">당월집행액</th>
								<th scope="col">누계집행액</th>
							</tr>
							<tr id="gubunTrOut2" style="display: none;">
								<th scope="col">회계</th>
								<th scope="col">분야</th>
								<th scope="col">부문</th>
								<th scope="col">프로그램</th>
								<th scope="col">단위사업</th>
								<th scope="col">세부사업</th>
								<th scope="col">예산</th>
								<th scope="col">당월집행액</th>
								<th scope="col">누계집행액</th>
							</tr>
							<tr id="gubunTrOut3" style="display: none;">
								<th scope="col">회계</th>
								<th scope="col">분야</th>
								<th scope="col">부문</th>
								<th scope="col">프로그램</th>
								<th scope="col">단위사업</th>
								<th scope="col">세부사업</th>
								<th scope="col">예산</th>
								<th scope="col">당일집행액</th>
								<th scope="col">누계집행액</th>
							</tr>
			            </thead>
			            <tbody id="vwFormOut">
			            </tbody>
			            </table>
			        </section>
			        <!-- // 목록 -->
			        
				</div>
				<!-- //지출집행현황 -->

       	 	</section>
        </fieldset>
        <div class="area_h3 area_h3_AB deco_h3_3 mb30">
			<p><strong class="point-color02" style="vertical-align: top;">* 13월:</strong> 연이월액 등 포함</p>
		</div>
	</div>
	<!-- // content -->
</div>

<!-- // layout_flex #################### -->
</div></div>

<!-- footer -->
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
<script type="text/javascript" src="<c:url value="/js/soportal/expose/nasCommon.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/soportal/expose/searchBudgetFund.js" />"></script>
<!-- jquery tree plugin [Dynatree] -->
<link rel="stylesheet" href="<c:url value="/js/soportal/tree/skin/ui.dynatree.css" />" type="text/css">
<script type="text/javascript" src="<c:url value="/js/soportal/tree/jquery.dynatree.js" />"></script> 
</body>
</html>
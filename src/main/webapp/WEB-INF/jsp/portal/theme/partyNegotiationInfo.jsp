<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 정당 및 교섭단체 화면을 조회하는 화면이다.                                --%>
<%--                                                                        --%>
<%-- @author jhkim                                                         --%>
<%-- @version 1.0 2019/12/24                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<!-- jquery chart plugin [high charts] -->
<script type="text/javascript" src="<c:url value="/js/common/highcharts/highstock.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/highcharts-more.js" />"></script>
<%-- <script type="text/javascript" src="<c:url value="/js/common/highcharts/highcharts-3d.js" />"></script> --%>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/modules/item-series.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/modules/exporting.js" />"></script>
<%-- <script type="text/javascript" src="<c:url value="/js/common/highcharts/modules/data.js" />"></script> --%>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/modules/treemap.js" />"></script>
<%-- <script type="text/javascript" src="<c:url value="/js/common/highcharts/modules/map.js" />"></script> --%>

<style type="text/css">
	#pop_wrapper{position:relative;}
	#pop_wrapper h2{font-size:19px; color:#fff; background:#0e2740; height:40px; padding:14px 0 0 25px;}
	#pop_wrapper h2 em{font-size:13px; font-style:normal; letter-spacing:-1px;}
	#pop_wrapper .close{position:absolute; top:15px; right:15px;}
	.pop_content{font-size:12px; padding:30px; color:#555555;}
	.pop_content.cult{height:497px; overflow:auto;}
	.pop_content p strong{color:#444;}
	.pop_tab{height:30px; position:relative; top:1px;}
	.pop_tab li{float:left; border:1px solid #e2e8ef; margin:0 1px 0 0;}
	.pop_tab li+li+li{margin:0;}
	.pop_tab li a{color:#586373; font-size:13px; font-weight:600; display:block; background:#f2f5f8; width:144px; height:24px; text-align:center; padding:4px 0 0 0;}
	.pop_tab li.on{border-bottom:1px solid #fff;}
	.pop_tab li.on a, .pop_tab li a:hover{color:#004f9c; background:#fff;}
	.post_search{border:1px solid #e2e8ef; margin:0; text-align:center; padding:30px 0 30px;}
	.post_search dt,.post_search dd{display:inline-block; zoom:1; *display:inline; vertical-align:middle;}
	.post_search dt.aw{width:auto;}
	.post_search dd{width:110px; text-align:left; margin:0 10px 0 0;}
	.post_search dd.aw{width:auto;}
	.post_search dl{padding:0 0 9px;}
	.post_search dl.tal{padding-left:157px; text-align:left;}
	.post_search dd select{width:110px;}
	.post_search dd input{width:102px;}
	.post_search p{color:#444; font-size:13px;  margin:10px 0 16px;}
	.post_search .btntxt01{margin:0 auto; width:39px;}
	.popw01{color:#001732;font-size:17px;border-bottom:3px solid #1961b6;font-family:"notoKrM";padding:0 0 5px 20px;margin:20px 0 15px 0;
		background:url(/images/icon_circle.png);
		background-position: 0 5px;
		background-repeat: no-repeat;
	}
	.chart_border > div{border:1px solid #e0e0e0;
		border-radius:3px;
		-webkit-border-radius:3px;
		-moz-border-radius:3px;
		-o-border-radius:3px;
	}
	.pop_content.chart_border{padding-top:0;}
</style>
</head>
<body>
<!-- wrapper -->
<div class="wrapper" id="wrapper">
<%@ include file="/WEB-INF/jsp/portal/sect/header.jsp" %>
	<form name="searchForm"  method="post" action="#">
	<input type="hidden" name="name">
	<!-- container -->
	<section>
		<div class="container hide-pc-lnb" id="container">
	
	    <!-- content -->
	    <article>
			<div class="contents" id="contents">
	        	<div class="contents-title-wrapper">
		            <h3>정당 및 교섭단체 정보<span class="arrow"></span></h3>
	        	</div>
	        
				<!-- CMS 시작 -->
		        <div class="layout_flex_100">
					 <div class="pop_content chart_border"> 
		           		<h3 class="popw01">정당별 의석수 현황</h3>
						<!-- <div id="chartTreeMapContainer"></div> -->
						<div id="chartParliamenContainer"></div>
						
						<h3 class="popw01">교섭단체 구성현황</h3>
						<div id="negotitaion-sect" class="themeBscrollx" style="border:none;height:auto;">
							<table>
					            <caption><c:out value="${requestScope.menu.lvl2MenuPath}" />_교섭단체 구성현황 : 번호,교섭단체,정당,지역구,비례대표,계,비고(%) 제공</caption>
					            <colgroup class="m_none">
					                <col style="width:8%;" />
					                <col style="width:25%;" />
					                <col style="width:25%;" /> 
					                <col style="width:10%;" />
					                <col style="width:10%;" />
					                <col style="width:10%;" />
					                <col style="width:12%;" />
					            </colgroup>
					            <thead>
					            <tr>
					                <th scope="col">번호</th>
					                <th scope="col">교섭단체</th>
					                <th scope="col">정당</th>
					                <th scope="col">지역구</th>
					                <th scope="col">비례대표</th>
					                <th scope="col">계</th>
					                <th scope="col">비고(%)</th>
					            </tr>
					            </thead>
					            <tbody id="hgNuMSeat-result-sect">
					            <tr>
					                <td colspan="7" class="noData">조회되는 데이터가 없습니다.</td>
					            </tr>
					            </tbody>
					            </table>
						</div>
						
						<span>「국회법」제33조제2항 및 제3항에 따른 보고 기준</span>
		           </div>
				</div>
				<!-- //CMS 끝 -->
							
			</div>
		</article>
		<!-- //contents  -->
	
	</div>
	</section>
	<!-- //container -->
	</form>
</div>
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
<script type="text/javascript" src="<c:url value="/js/portal/theme/partyNegotiationInfo.js" />"></script>
</body>
</html>

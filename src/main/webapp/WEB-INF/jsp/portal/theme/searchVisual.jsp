<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)naDataSitemap.jsp 1.0 2019/09/11                                   --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 정보서비스 사이트맵을 조회하는 화면이다.                                --%>
<%--                                                                        --%>
<%-- @author CSB                                                         --%>
<%-- @version 1.0 2019/09/11                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<!-- jquery chart plugin [high charts] -->
<script type="text/javascript" src="<c:url value="/js/common/highcharts/highstock.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/highcharts-more.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/highcharts-3d.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/modules/item-series.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/modules/exporting.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/modules/data.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/modules/drilldown.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/modules/treemap.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/modules/sunburst.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/modules/map.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/modules/data.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/lodash.min.js" />"></script>

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
			<nav>
				<div class="lnb">
					<h2>테마 정보공개</h2> 
					<ul>
						<li>
							<span><a href="" class="on">국회의원 통계</a></span>
						</li>
						<li>
							<span><a href="" class="">정당 및 교섭단체 정보</a></span>
						</li>
					</ul>
				</div>
			</nav>	
	    <!-- content -->
	    <article>
			<div class="contents" id="contents">
	        	<div class="contents-title-wrapper">
		            <h3>국회의원 통계<span class="arrow"></span></h3>
	        	</div>
	        
				<!-- CMS 시작 -->
		        <div class="layout_flex_100">
					 <div class="pop_content chart_border"> 
		           		<h3 class="popw01">정당별 의석수 현황</h3>
						<!-- <div id="chartTreeMapContainer"></div> -->
						<div id="chartParliamenContainer"></div>
						<h3 class="popw01">당선횟수별 의원현황</h3>
						<div id="chartColumnContainer"></div>
						<h3 class="popw01">성별 의원현황</h3>
						<div id="chartPieContainer"></div>
						<h3 class="popw01">연령별 의원현황</h3>
						<div id="chartColumnAgeContainer"></div>
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
<script type="text/javascript" src="<c:url value="/js/portal/theme/searchVisual.js" />"></script>
</body>
</html>

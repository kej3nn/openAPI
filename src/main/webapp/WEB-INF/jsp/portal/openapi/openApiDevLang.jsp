<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<!-- jquery chart plugin [high charts] -->
<script type="text/javascript" src="<c:url value="/js/common/highcharts/highstock.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/modules/exporting.js" />"></script>
</head>
<body>
<!-- wrapper -->
<div class="wrapper" id="wrapper">
<%@ include file="/WEB-INF/jsp/portal/sect/headerOpen.jsp" %>
<%-- <%@ include file="/WEB-INF/jsp/portal/include/navigation.jsp" %> --%>

<!-- container -->
<input type="hidden" id="kakaoKey" value="<spring:message code="Oauth2.Provider.Kakao.ClientId"/>">
<section>
	<div class="container" id="container">
	<!-- leftmenu -->
	<%@ include file="/WEB-INF/jsp/portal/sect/lnb.jsp" %>
	<!-- //leftmenu -->
	
    <!-- content -->
    <article>
		<div class="contents" id="contents">
			<div class="contents-title-wrapper">
				<h3>개발소스예제<span class="arrow"></span></h3>
				<ul class="sns_link">
					<li><a title="새창열림_페이스북" href="#" id="shareFB" class="sns_facebook">페이스북</a></li>
					<li><a title="새창열림_트위터" href="#" id="shareTW" class="sns_twitter">트위터</a></li>
					<li><a title="새창열림_네이버블로그" href="#" id="shareBG" class="sns_blog">네이버블로그</a></li>
					<li><a title="새창열림_카카오스토리" href="#" id="shareKS"  class="sns_kakaostory">카카오스토리</a></li>
					<li><a title="새창열림_카카오톡" href="#" id="shareKT" class="sns_kakaotalk">카카오톡</a></li>
				</ul>
        	</div>
        
	        <div class="layout_flex_100">
			<!-- CMS 시작 -->
				
				<!-- 개발소스예제 --> 
		        <div id="tab_B_cont_2">
		        	<div class="ECpage">
						<!-- 탭메뉴 -->
						<div class="ECsource">
							<ul class="tabmenu-type03">
								<li>
									<a href="#" class="on" onclick="return false;" id="sample-SAMPLE01" title="막대그래프형 소스보기">
										<img src="<c:url value="/images/icon_simbol030201@2x.png" />" alt="막대차트 아이콘" />
										<span>막대그래프형<br />소스보기</span>
									</a>
								</li>

								<li>
									<a href="#" onclick="return false;" id="sample-SAMPLE02" title="원그래프형 소스보기">
										<img src="<c:url value="/images/icon_simbol030202@2x.png" />" alt="파이차트 아이콘" />
										<span>원그래프형<br />소스보기</span>
									</a>
								</li>

								<li>
									<a href="#" onclick="return false;" id="sample-SAMPLE03" title="텍스트형 소스보기">
										<img src="<c:url value="/images/icon_simbol030203@2x.png" />" alt="테이블 아이콘" />
										<span>텍스트형<br />소스보기</span>
									</a>
								</li>
							</ul>
						</div>
						<!-- //탭메뉴 -->
						
			        	<div class="ECsource-content">
							<div id="contents-SAMPLE01" class="ECsource-content-area">
								<div id="chart002" class="ECsource-type-area">
									<div id="barChart"></div>
								</div>
<pre style="word-wrap:break-word;">
&lt;script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ=" crossorigin="anonymous"&gt;&lt;/script&gt;
&lt;script type="text/javascript" src="https://code.highcharts.com/highcharts.js" /&gt;&lt;/script&gt;
&lt;script type="text/javascript" src="https://code.highcharts.com/modules/exporting.js" /&gt;&lt;/script&gt;
&lt;script type="text/javascript"&gt;
	function getChartData() {
	    $.ajax({
	        url: 'https://open.assembly.go.kr/portal/openapi/ncocpgfiaoituanbr?AGE=21&BILL_NO=2106221&Type=json',
	        type: 'GET',
	        dataType: 'json',
	        success: function (result) {
	            drawBarChart(result);
	        },
	        error: function (result) {}
	    });
	}

	function drawBarChart(jsonData) {
	    var data = jsonData.ncocpgfiaoituanbr[1].row;
	
	    $('#barChart').highcharts({
	        credits: {enabled: false},
	        chart:  {type: 'column'},
	        title:  {text: data[0].BILL_NAME},
	        legend: {enabled: false},
	        xAxis:  {type: 'category'},
	        yAxis: {
	            title: {
	                text: ""
	            }
	
	        },
	        series: [{
	            name: "",
	            colorByPoint: true,
	            data: [{name: "찬성", y: data[0].YES_TCNT},
	                   {name: "반대", y: data[0].NO_TCNT},
	                   {name: "기권", y: data[0].BLANK_TCNT}
	                  ]
	               }]
	    });
	
	}
&lt;/script&gt;

&lt;div id="barChart" style="min-width:300px;height:400px;margin:0 auto;"&gt;&lt;/div&gt;
</pre>								
							</div>	
						
			        	
			        	<div style="display:none;" id="contents-SAMPLE02" class="ECsource-content-area">
				        	<div id="chart001" class="ECsource-type-area">
								<div id="pieChart"></div>
							</div>
<pre>
&lt;script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ=" crossorigin="anonymous"&gt;&lt;/script&gt;
&lt;script type="text/javascript" src="https://code.highcharts.com/highcharts.js" /&gt;&lt;/script&gt;
&lt;script type="text/javascript" src="https://code.highcharts.com/modules/exporting.js" /&gt;&lt;/script&gt;
&lt;script type="text/javascript"&gt;
	function getChartData() {
	    $.ajax({
	        url: 'https://open.assembly.go.kr/portal/openapi/ncocpgfiaoituanbr?AGE=21&BILL_NO=2106221&Type=json',
	        type: 'GET',
	        dataType: 'json',
	        success: function (result) {
	            drawPieChart(result);
	        },
	        error: function (result) {}
	    });
	}

	function drawPieChart(jsonData) {
	    var data = jsonData.ncocpgfiaoituanbr[1].row;
	
	    $('#pieChart').highcharts({
	        credits: {
	            enabled: false
	        },
	        chart: {
	            plotBackgroundColor: null,
	            plotBorderWidth: null,
	            plotShadow: false,
	            type: 'pie'
	        },
	        title: {
	            text: data[0].BILL_NAME
	        },
	        tooltip: {
	            pointFormat: '{series.name}: <b>{point.percentage:.0f}%</b>'
	        },
	        plotOptions: {
	            pie: {
	                allowPointSelect: true,
	                cursor: 'pointer',
	                dataLabels: {
	                    enabled: false
	                },
	                showInLegend: true
	            }
	        },
	        series: [{
	            name: '',
	            colorByPoint: true,
	            data: [{
	                name: '찬성',
	                y: data[0].YES_TCNT
	            }, {
	                name: '반대',
	                y: data[0].NO_TCNT
	            }, {
	                name: '기권',
	                y: data[0].BLANK_TCNT
	            }]
	        }]
	    });
	}
&lt;/script&gt;

&lt;div id="pieChart" style="min-width:300px;height:400px;margin:0 auto;"&gt;&lt;/div&gt;
</pre>							
						</div>	
			        	
			        	<div style="display:none;" id="contents-SAMPLE03" class="ECsource-content-area">
			        		
							<div class="board-list01 ECsource-type-area">
								<div>
									<table id="dataset-data-table"  style="width: 100%">
									<caption>찬성,반대,기권</caption>
										<colgroup>
											<col style="">
										</colgroup>
										<thead>
											<tr>
												<th class="name" scope="col">찬성</th>
												<th class="name" scope="col">반대</th>
												<th class="name" scope="col">기권</th>
											</tr>
										</thead>
										<tbody id="grid"></tbody>
									</table>
								</div>
							</div>
							<pre>
&lt;script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ=" crossorigin="anonymous"&gt;&lt;/script&gt;
&lt;script type="text/javascript"&gt;
	function getChartData() {
	    $.ajax({
	        url: 'https://open.assembly.go.kr/portal/openapi/ncocpgfiaoituanbr?AGE=21&BILL_NO=2106221&Type=json',
	        type: 'GET',
	        dataType: 'json',
	        success: function (result) {
	            drawGrid(result);
	        },
	        error: function (result) {}
	    });
	}

	function drawGrid(jsonData) {
	    var data = jsonData.ncocpgfiaoituanbr[1].row;
	    if (data) {
	        var html = '';
	        $.each(data, function (i, data) {
	
	            html += '<tr>';
	            html += '	<td>' + data.YES_TCNT + '</td>';
	            html += '	<td>' + data.NO_TCNT + '</td>';
	            html += '	<td>' + data.BLANK_TCNT + '</td>';
	            html += '</tr>';
	
	        });
	        $('#grid').append(html);
	    }
	}
&lt;/script&gt;

&lt;table&gt;
	&lt;colgroup&gt;
		&lt;col width=""&gt;
	&lt;/colgroup&gt;
	&lt;thead&gt;
		&lt;tr&gt;
			&lt;th col="row"&gt;찬성&lt;/th&gt;
			&lt;th col="row"&gt;반대&lt;/th&gt;
			&lt;th col="row"&gt;기권&lt;/th&gt;
		&lt;/tr&gt;
	&lt;/thead&gt;
	&lt;tbody id="grid"&gt;
	&lt;/tbody&gt;
&lt;/table&gt;

</pre>		
				    		</div>   
			    		</div>
			    	</div>
		    	</div>	
			    <!-- //개발소스예제 -->  
			  <!-- //CMS 끝 -->
			 </div>
		</div>
	</article>
	<!-- //contents  -->

	</div>
</section>       
		        
		        
		        
<script type="text/javascript">
//<![CDATA[ 

$(function () {

    $(".tabmenu-type03 > li > a").click(function () {
        var thisIndex = $(this).attr('id');;
        thisIndex = thisIndex.replace(/[^0-9]/g, "");
        $(".tabmenu-type03 > li > a").removeClass('on');
        $(this).addClass('on');

        $(".ECsource-content-area").hide();
        $("#contents-SAMPLE" + thisIndex).show();
    });

    $(".tabmenu-type04 > li > a").click(function () {
        var thisIndex = $(this).attr('id');;
        thisIndex = thisIndex.replace(/[^0-9]/g, "");
        $(".tabmenu-type04 > li > a").removeClass('on');
        $(this).addClass('on');

        $(".contents-LANG").hide();
        $("#contents-LANG" + thisIndex).show();
    });

    Highcharts.setOptions({
        lang: {
            thousandsSep: ','
        }
    });

    // 개발소스예제에서 사용될 데이타 조회(조회 성공시 전역변수 chartData에 json형 데이타가 치환된다.)
    getChartData();

});


function getChartData() {
	
    $.ajax({
         /* url: 'http://localhost:8080/portal/openapi/ncocpgfiaoituanbr?BILL_NO=2006481&Type=json', */ 
        url : 'https://open.assembly.go.kr/portal/openapi/ncocpgfiaoituanbr?AGE=21&BILL_NO=2106221&Type=json', //추후 URL변경
        type: 'GET',
        dataType: 'json',
        success: function (result) {
            drawBarChart(result);
            drawPieChart(result);
            drawGrid(result);

        },
        error: function (result) {}
    });
}

function drawBarChart(jsonData) {
    var data = jsonData.ncocpgfiaoituanbr[1].row;

    $('#barChart').highcharts({
        credits: {
            enabled: false
        },

        chart: {
            type: 'column'
        },
        title: {
            text: data[0].BILL_NAME + "(표결정보)"
        },
        legend: {
            enabled: false
        },

        xAxis: {
            type: 'category'
        },
        yAxis: {
            title: {
                text: ""
            }

        },
        series: [{
            name: "",
            colorByPoint: true,
            data: [{
                    name: "찬성",
                    y: data[0].YES_TCNT
                },
                {
                    name: "반대",
                    y: data[0].NO_TCNT
                },
                {
                    name: "기권",
                    y: data[0].BLANK_TCNT
                }
            ]
        }]
    });

}

function drawPieChart(jsonData) {
    var data = jsonData.ncocpgfiaoituanbr[1].row;

    $('#pieChart').highcharts({
        credits: {
            enabled: false
        },
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            type: 'pie'
        },
        title: {
            text: "표결정보"
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.0f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: false
                },
                showInLegend: true
            }
        },
        series: [{
            name: '',
            colorByPoint: true,
            data: [{
                name: '찬성',
                y: data[0].YES_TCNT
            }, {
                name: '반대',
                y: data[0].NO_TCNT
            }, {
                name: '기권',
                y: data[0].BLANK_TCNT
            }]
        }]
    });
}

function drawGrid(jsonData) {
    var data = jsonData.ncocpgfiaoituanbr[1].row;
    if (data) {
        var html = '';
        $.each(data, function (i, data) {

            html += '<tr>';
            html += '	<td>' + data.YES_TCNT + '</td>';
            html += '	<td>' + data.NO_TCNT + '</td>';
            html += '	<td>' + data.BLANK_TCNT + '</td>';
            html += '</tr>';

        });
        $('#grid').append(html);
    }
}

//]]>
</script>		
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
</div>
<script type="text/javascript" src="<c:url value="/js/portal/openapi/openApiSns.js" />"></script>
</body>
</html>
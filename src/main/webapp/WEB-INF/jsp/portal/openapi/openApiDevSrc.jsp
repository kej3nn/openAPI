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
<section>
	<div class="container" id="container">
	<!-- leftmenu -->
	<%@ include file="/WEB-INF/jsp/portal/sect/lnb.jsp" %>
	<!-- //leftmenu -->
	
    <!-- content -->
    <article>
		<div class="contents" id="contents">
			<div class="contents-title-wrapper">
				<h3>언어별 개발가이드<span class="arrow"></span></h3>
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
				
			    <div id="tab_B_cont_3">
		        	<ul class="tabmenu-type04 clear">
						<li ><a href="#" id="sample-LANG01" class="on">JAVA</a></li>
						<%--<li><a href="#" id="sample-LANG02">PHP</a></li>--%>
						<li><a href="#" id="sample-LANG03">.NET</a></li>
						<li><a href="#" id="sample-LANG04">PERL</a></li>
						<li><a href="#" id="sample-LANG05">EXCEL</a></li>
					</ul>
					<div id="contents-LANG01" class="contents-LANG" >
						<h5 class="title0401">
							JAVA 개발 메뉴얼
						</h5>
						
						<div class="contents-box">
							<h6 class="title0601">
								0. 환경
							</h6>
	
							<ul class="ul-list03">
								<li>
									Eclipse EE Luna(v4.4.2) or Latest version
								</li>
								<li>
									 Tomcat7
								</li>
							</ul>
						</div>
	
						<div class="contents-box">
							<h6 class="title0601">
								1. 프로젝트 생성
							</h6>
	
							<ul class="ul-list03">
								<li class=" mb20">
									Eclipse 실행 후 File > New > Project를 선택하여 프로젝트를 생성합니다.
									<div class="images-box pt10">
										<img src="<c:url value="/images/java01.png" />" alt="Eclipse 프로젝트 생성" />
									</div>
								</li>
	
								<li class="mb20">
									Dynamic Web Project를 선택합니다.
									<div class="images-box pt10">
										<img src="<c:url value="/images/java02.png" />" alt="Eclipse Dynamic Web Project 선택" />
									</div>
								</li>
	
								<li class="mb20">
									Project name을 입력하고 Finish를 눌러 마칩니다.
									<div class="images-box pt10">
										<img src="<c:url value="/images/java03.png" />" alt="Eclipse Project name을 입력하고 Finish 클릭" />
									</div>
								</li>
							</ul>
						</div>
	
						<div class="contents-box">
							<h6 class="title0601">
								2. jsp 코딩
							</h6>
	
							<ul class="ul-list03">
								<li class=" mb20">
									생성한 프로젝트의 WebContents 폴더하위에 sample.jsp 생성합니다.
									<div class="images-box pt10">
										<img src="<c:url value="/images/java04.png" />" alt="생성한 프로젝트의 WebContents 폴더하위에 sample.jsp 생성" />
									</div>
								</li>
	
								<li class="mb20">
									 sample.jsp를 다음과 같이 코딩합니다.
									<div class="images-box pt10">
										<img src="<c:url value="/images/java05.png" />" alt="sample.jsp 코딩" />
									</div>
								</li>
	
								<li class="mb20">
									stringUrl에 사용할 API주소를 입력합니다.
									<div class="source-code-wrapper">
										<p> &nbsp;&nbsp;&nbsp; source code</p>
	<pre>   &lt;%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%&gt;
	   &lt;%@ page import="java.io.*" %&gt;
	   &lt;%@ page import="java.net.*" %&gt;
	   &lt;%@ page import="javax.xml.*" %&gt;
	   &lt;%@ page import="javax.xml.parsers.*" %&gt;
	   &lt;%@ page import="org.w3c.dom.*" %&gt;
	   &lt;%
	   	URL url = null;
	   	URLConnection urlConnection = null;
	   	
	   	String stringUrl = "http://www.sample.kr/openapi/SttsApiTblData.do?STATBL_ID=T186503126543136&DTACYCLE_CD=QY&WRTTIME_IDTFR_ID=201704&Type=json";
	   	InputStream is = null;
	   	String data = "";
	   	
	   	try {
	   		
	   		url = new URL(stringUrl);
	   		urlConnection = url.openConnection();
	   		urlConnection.setDoOutput(true);
	   		
	   		is = urlConnection.getInputStream();
	   		 
	   	 	byte[] buf = new byte[2048];
	   	 	int len = -1;
	   	 	StringBuffer sb = new StringBuffer();
	   	 	
	   	 	while ((len = is.read(buf, 0, buf.length)) != -1) {
	   	 		sb.append(new String(buf, 0, len));
	   	 	}
	   		
	   	 	data = sb.toString();
	   	 	
	   	} catch (MalformedURLException e) {
	   		e.getMessage();
	   	} catch (IOException e) {
	   		e.getMessage();
	   	} finally {
	   		if (is != null) {
	   			is.close();
	   		}
	   	}
	   %&gt;
	   &lt;!DOCTYPE html&gt;
	   &lt;html&gt;
	   &lt;head&gt;
	   	&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
	   	&lt;title&gt;Insert title here&lt;/title&gt;
	   &lt;/head&gt;
	   &lt;body&gt;
	   	java sample page
	   	&lt;%=data%&gt;;
	   &lt;/body&gt;
	   &lt;/html&gt;</pre>
	
									</div>
								</li>
							</ul>
						</div>
	
	
						<div class="contents-box">
							<h6 class="title0601">
								3. 배포
							</h6>
	
							<ul class="ul-list03">
								<li class=" mb20">
									File > New > Other를 선택하여 서버를 생성합니다.
									<div class="images-box pt10">
										<img src="<c:url value="/images/java06.png" />" alt="File > New > Other를 선택하여 서버를 생성" />
									</div>
								</li>
	
								<li class="mb20">
									server를 선택하고 다음단계로 넘어갑니다.
									<div class="images-box pt10">
										<img src="<c:url value="/images/java07.png" />" alt="server를 선택" />
									</div>
								</li>
	
								<li class="mb20">
									Tomcat v7.0 Server를 선택하고 다음단계로 넘어갑니다.
									<div class="images-box pt10">
										<img src="<c:url value="/images/java08.png" />" alt="Tomcat v7.0 Server를 선택" />
									</div>
								</li>
	
								<li class="mb20">
									Available영역에 있는 프로젝트를 선택하고 Add를 눌러 Configured영역으로 이동시킵니다.
									<div class="images-box pt10">
										<img src="<c:url value="/images/java09.png" />" alt="Available영역에 있는 프로젝트를 선택하고 Add를 눌러 Configured영역으로 이동" />
									</div>
								</li>
	
								<li class="mb20">
									Servers 탭에 새로운 서버가 생성되었습니다.
									<div class="images-box pt10">
										<img src="<c:url value="/images/java10.png" />" alt="Servers 탭에 새로운 서버가 생성" />
									</div>
								</li>
	
								<li class="mb20">
									생성한 서버를 더블클릭하여 설정화면으로 들어갑니다. 아래에서 Modules탭을 선택합니다. 대상을 선택하고 Edit버튼을 클릭합니다.
									<div class="images-box pt10">
										<img src="<c:url value="/images/java11.png" />" alt="생성한 서버를 더블클릭하여 설정화면으로 들어 간 후 아래에서 Modules탭을 선택합니다. 대상을 선택하고 Edit버튼을 클릭" />
									</div>
								</li>
	
								<li class="mb20">
									 Path에 "/"를 입력합니다.
									<div class="images-box pt10">
										<img src="<c:url value="/images/java12.png" />" alt=" Path에 &quot;/&quot;를 입력" />
									</div>
								</li>
	
								<li class="mb20">
									Servers에서 서버를 선택하고 마우스우클릭 > Start로 실행시킵니다.
									<div class="images-box pt10">
										<img src="<c:url value="/images/java13.png" />" alt="Servers에서 서버를 선택하고 마우스우클릭 > Start로 실행시" />
									</div>
								</li>
							</ul>
						</div>
	
						<div class="contents-box">
							<h6 class="title0601">
								4. 확인
							</h6>
	
							<ul class="ul-list03">
								<li>
									브라우저 주소창에 http://localhost:8080/sample.jsp를 입력하고 결과를 확인합니다.
									<div class="images-box pt10">
										<img src="<c:url value="/images/java14.png" />" alt="브라우저 주소창에 http://localhost:8080/sample.jsp를 입력하고 결과를 확인" />
									</div>
								</li>
							</ul>
						</div>
					</div>
					
					<div id="contents-LANG02" class="contents-LANG" style="display:none;" >
						<h5 class="title0401">
							PHP 개발 메뉴얼
						</h5>
						
						<div class="contents-box">
							<h6 class="title0601">
								0. 환경
							</h6>

							<ul class="ul-list03">
								<li>
									PHP5
								</li>
								<li>
									Apache
								</li>
							</ul>
						</div>

						<div class="contents-box">
							<h6 class="title0601">
								1. php 코딩
							</h6>

							<ul class="ul-list03">
								<li class=" mb20">
									Apache에 설정된 DocumentRoot 폴더에 sample.php를 생성합니다.
									<div class="images-box pt10">
										<img src="<c:url value="/images/php01.png" />" alt="Apache에 설정된 DocumentRoot 폴더에 sample.php를 생성" />
									</div>
								</li>

								<li class="mb20">
									sample.php를 다음과 같이 코딩합니다.
									<div class="images-box pt10">
										<img src="<c:url value="/images/php02.png" />" alt="sample.php를 다음과 같이 코딩 " />
									</div>
								</li>

								<li class="mb20">
									 $URL에 사용할 API주소를 입력합니다.
									<div class="source-code-wrapper">
										<p>source code</p>

<pre>&lt;?php
        $URL = "http://www.sample.kr/openapi/SttsApiTblData.do?STATBL_ID=T182573126708314&DTACYCLE_CD=YY&ITM_DATANO=10001&CLS_DATANO=50022";
        $response = file_get_contents($URL);
?&gt;<br>&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;Insert title here&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
        &lt;p&gt;php sample page&lt;/p&gt;
        &lt;?php echo($response);?&gt;
&lt;/body&gt;
&lt;/html&gt;</pre>
									</div>
								</li>
							</ul>
						</div>

						<div class="contents-box">
							<h6 class="title0601">
								2. 확인
							</h6>

							<ul class="ul-list03">
								<li>
									브라우저 주소창에 http://localhost/sample.php를 입력하고 결과를 확인합니다.
									<div class="images-box pt10">
										<img src="<c:url value="/images/php03.png" />" alt="브라우저 주소창에 http://localhost/sample.php를 입력하고 결과를 확인" />
									</div>
								</li>
							</ul>
						</div>
					</div>
					
					<div id="contents-LANG03" class="contents-LANG" style="display:none;">
						<h5 class="title0401">
							.NET 개발 메뉴얼
						</h5>
						<div class="contents-box">
							<h6 class="title0601">
								0. 환경
							</h6>

							<ul class="ul-list03">
								<li>
									Visual Studio Express 2015 for Web
								</li>
							</ul>
						</div>

						<div class="contents-box">
							<h6 class="title0601">
								1. 프로젝트 생성
							</h6>

							<ul class="ul-list03">
								<li class=" mb20">
									 Visual Studio 실행 후 파일 > 새 웹 사이트를 선택하여 프로젝트를 생성합니다.
									<div class="images-box pt10">
										<img src="<c:url value="/images/net01.png" />" alt=" Visual Studio 실행 후 파일 > 새 웹 사이트를 선택하여 프로젝트를 생성" />
									</div>
								</li>

								<li class="mb20">
									템플릿에서 C#을 선택 후, ASP.NET 빈 웹 사이트를 선택하고 확인을 누릅니다.
									<div class="images-box pt10">
										<img src="<c:url value="/images/net02.png" />" alt="템플릿에서 C#을 선택 후, ASP.NET 빈 웹 사이트를 선택하고 확인" />
									</div>
								</li>

								<li class="mb20">
									솔루션 탐색에 추가된 프로젝에서 마우스우클릭 > 추가 > 웹 폼을 선택합니다.
									<div class="images-box pt10">
										<img src="<c:url value="/images/net03.png" />" alt=" 솔루션 탐색에 추가된 프로젝에서 마우스우클릭 > 추가 > 웹 폼을 선택" />
									</div>
								</li>

								<li class="mb20">
									이름은 Default로 입력하고 확인을 누릅니다.
									<div class="images-box pt10">
										<img src="<c:url value="/images/net04.png" />" alt="이름은 Default로 입력하고 확인" />
									</div>
								</li>

								<li class="mb20">
									 Default.aspx를 다음과 같이 코딩합니다.
									<div class="images-box pt10">
										<img src="<c:url value="/images/net05.png" />" alt=" Default.aspx를 다음과 같이 코딩" />
									</div>

									<div class="source-code-wrapper">
										<p>source code</p>

<pre>&lt;%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %&gt;
&lt;!DOCTYPE html&gt;
&lt;html xmlns="http://www.w3.org/1999/xhtml"&gt;
&lt;head runat="server"&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=utf-8"/&gt;
    &lt;title&gt;&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
    &lt;form id="form1" runat="server"&gt;
        asp.net sample page
        &lt;%=xmlData%&gt;;
    &lt;/form&gt;
&lt;/body&gt;
&lt;/html&gt;</pre>
								</div>
							</li>

							<li class="mb20">
								에디터영역에서 마우스우클릭 &gt; 코드보기를 선택합니다.
								<div class="images-box pt10">
									<img src="<c:url value="/images/net06.png" />" alt="에디터영역에서 마우스우클릭 &gt; 코드보기를 선택" />
								</div>
							</li>

							<li class="mb20">
								Default.aspx.cs를 다음과 같이 코딩합니다.
								<div class="images-box pt10">
									<img src="<c:url value="/images/net07.png" />" alt="Default.aspx.cs를 다음과 같이 코딩" />
								</div>
							</li>

							<li class="mb20">
								stringUrl에 사용할 API주소를 입력합니다.
								<div class="source-code-wrapper">
									<p>source code</p>
<pre>using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.IO;
public partial class _Default : System.Web.UI.Page
{
    public String xmlData;
    protected void Page_Load(object sender, EventArgs e)
    {
        String stringUrl = "http://www.sample.kr/openapi/SttsApiTblData.do?STATBL_ID=T182573126708314&DTACYCLE_CD=YY&ITM_DATANO=10001&CLS_DATANO=50022";
        WebRequest request = HttpWebRequest.Create(stringUrl);
        WebResponse response = request.GetResponse();
        StreamReader reader = new StreamReader(response.GetResponseStream());
        String result = reader.ReadToEnd();
        xmlData = result.ToString();
    }
}</pre>
								</div>
							</li>
						</ul>
					</div>

					<div class="contents-box">
						<h6 class="title0601">
							2. 확인
						</h6>

						<ul class="ul-list03">
							<li>
								솔루션 탐색기에서 프로젝트를 선택하고 마우스우클릭 > 브라우저에서 보기를 눌러 결과를 확인합니다.
								<div class="images-box pt10">
									<img src="<c:url value="/images/net08.png" />" alt="솔루션 탐색기에서 프로젝트를 선택하고 마우스우클릭 > 브라우저에서 보기를 눌러 결과를 확인" />
								</div>

								<div class="images-box pt10">
									<img src="<c:url value="/images/net09.png" />" alt="결과화면" />
								</div>
							</li>
						</ul>
					</div>
				</div>
				
				<div id="contents-LANG04" class="contents-LANG" style="display:none;">
					<h5 class="title0401">
						PERL 개발 메뉴얼
					</h5>
					<div class="contents-box">
						<h6 class="title0601">
							0. 환경
						</h6>

						<ul class="ul-list03">
							<li>
								Apache
							</li>
						</ul>
					</div>

					<div class="contents-box">
						<h6 class="title0601">
							1. perl 코딩
						</h6>

						<ul class="ul-list03">
							<li class=" mb20">
								cgi-bin 폴더에 sample.cgi를 생성합니다.
								<div class="images-box pt10">
									<img src="<c:url value="/images/perl01.png" />" alt="cgi-bin 폴더에 sample.cgi를 생성" />
								</div>
							</li>

							<li class="mb20">
								sample.cgi를 다음과 같이 코딩합니다.

								<div class="images-box pt10">
									<img src="<c:url value="/images/perl02.png" />" alt="sample.cgi를 다음과 같이 코딩" />
								</div>
							</li>

							<li class="mb20">
								$URL에 사용할 API주소를 입력합니다.
								<div class="source-code-wrapper">
									<p>source code</p>

<pre>#!/usr/bin/perl<br>
use LWP::Simple;<br>
$contents = get('http://www.sample.kr/openapi/SttsApiTblData.do?STATBL_ID=T182573126708314&DTACYCLE_CD=YY&ITM_DATANO=10001&CLS_DATANO=50022');<br>
print "Content-type: text/html";<br>print "&lt;!DOCTYPE html&gt;";
print "&lt;html&gt;";
print "&lt;head&gt;";
print "&lt;title&gt;perl sample&amp;lg;/title&gt;";
print "&lt;meta charset=\"utf-8\"/&gt;";
print "&lt;/head&gt;";
print "&lt;body&gt;";
print $contents
print "&lt;/body&gt;";
print "&lt;/html&gt;";</pre>
									</div>
								</li>
							</ul>
						</div>

						<div class="contents-box">
							<h6 class="title0601">
								2. 확인
							</h6>

							<ul class="ul-list03">
								<li>
									브라우저 주소창에 http://localhost/sample.php를 입력하고 결과를 확인합니다.
									<div class="images-box pt10">
										<img src="<c:url value="/images/perl03.png" />" alt="브라우저 주소창에 http://localhost/sample.php를 입력하고 결과를 확인" />
									</div>
								</li>
							</ul>
						</div>
					</div>
					
					<div id="contents-LANG05" class="contents-LANG" style="display:none;">
						<h5 class="title0401">
							EXCEL 개발 메뉴얼
						</h5>
						
						<div class="contents-box">
							<h6 class="title0601">
								0. 환경
							</h6>

							<ul class="ul-list03">
								<li>
									Microsoft Excel 2010 or Latest version
								</li>
							</ul>
						</div>

						<div class="contents-box">
							<h6 class="title0601">
								1. Excel 환경설정
							</h6>

							<ul class="ul-list03">
								<li class=" mb20">
									Microsoft Excel 2010 실행 후 파일 &gt; 옵션을 선택합니다.
									<div class="images-box pt10">
										<img src="<c:url value="/images/excel01.png" />" alt="Microsoft Excel 2010 실행 후 파일 &gt; 옵션을 선택" />
									</div>
								</li>

								<li class="mb20">
									리본 사용자 지정을 선택하고 오른쪽에 개발 도구에 체크를 합니다.
									<div class="images-box pt10">
										<img src="<c:url value="/images/excel02.png" />" alt="리본 사용자 지정을 선택하고 오른쪽에 개발 도구에 체크" />
									</div>
								</li>
							</ul>
						</div>

						<div class="contents-box">
							<h6 class="title0601">
								2. Visual Basic 코딩
							</h6>

							<ul class="ul-list03">
								<li class="mb20">
									메뉴에 개발 도구 항목을 선택한 후 Visual Basic을 누릅니다.
									<div class="images-box pt10">
										<img src="<c:url value="/images/excel03.png" />" alt="메뉴에 개발 도구 항목을 선택한 후 Visual Basic을 클릭" />
									</div>

									<div class="images-box pt10">
										<img src="<c:url value="/images/excel04.png" />" alt="메뉴에 개발 도구 항목을 선택한 후 Visual Basic을 클릭" />
									</div>
								</li>

								<li class="mb20">
									메뉴에서 삽입 &gt; 모듈을 선택합니다.
									<div class="images-box pt10">
										<img src="<c:url value="/images/excel05.png" />" alt="메뉴에서 삽입 &gt; 모듈을 선택" />
									</div>

									<div class="images-box pt10">
										<img src="<c:url value="/images/excel06.png" />" alt="메뉴에서 삽입 &gt; 모듈을 선택" />
									</div>
								</li>

								<li class="mb20">
									메뉴에서 도구 &gt; 참조를 선택합니다.
									<div class="images-box pt10">
										<img src="<c:url value="/images/excel07.png" />" alt="메뉴에서 도구 &gt; 참조를 선택" />
									</div>
								</li>

								<li class="mb20">
									Microsoft WinHTTP Services, version 5.1과 Microsoft XML v6.0을 찾아서 체크합니다.
									<div class="images-box pt10">
										<img src="<c:url value="/images/excel08.png" />" alt="Microsoft WinHTTP Services, version 5.1과 Microsoft XML v6.0을 찾아서 체크" />
									</div>
								</li>

								<li class="mb20">
									다음과 같이 코딩합니다.
									<div class="images-box pt10">
										<img src="<c:url value="/images/excel09.png" />" alt="다음과 같이 코딩" />
									</div>
								</li>

								<li class="mb20">
									callUrl에 사용할 API주소를 입력합니다.
									<div class="source-code-wrapper">
										<p>source code</p>

<pre>Sub callOpenapi()
    
    Dim callUrl As String
    Dim result As String
    Dim objHttp As New WinHttpRequest
    
    Dim nodeList As IXMLDOMNodeList
    Dim nodeRow As IXMLDOMNode
    Dim nodeCell As IXMLDOMNode
    
    Dim rowCount As Integer
    Dim cellCount As Integer
    Dim rowRange As Range
    Dim cellRange As Range
    Dim sheet As Worksheet
    
    callUrl = "http://www.sample.kr/openapi/SttsApiTblData.do?STATBL_ID=T182573126708314&DTACYCLE_CD=YY&ITM_DATANO=10001&CLS_DATANO=50022"
    objHttp.Open "GET", callUrl, False
    objHttp.Send
    
    If objHttp.Status = 200 Then
        result = objHttp.ResponseText
        
        Dim objXml As MSXML2.DOMDocument
        Set objXml = New DOMDocument
        objXml.LoadXML (result)
        
        Set sheet = ActiveSheet
        Set nodeList = objXml.SelectNodes("/SttsApiTblData/row")
        
        rowCount = 0
        For Each nodeRow In nodeList
            rowCount = rowCount + 1
            cellCount = 0
            For Each nodeCell In nodeRow.ChildNodes
                cellCount = cellCount + 1
                Set cellRange = sheet.Cells(rowCount, cellCount)
                cellRange.Value = nodeCell.Text
            Next nodeCell
        Next nodeRow
    End If
End Sub</pre>
									</div>
								</li>
							</ul>
						</div>

						<div class="contents-box">
							<h6 class="title0601">
								3. 실행
							</h6>

							<ul class="ul-list03">
								<li class="mb20">
									메뉴에서 매크로를 실행합니다.
									<div class="images-box pt10">
										<img src="<c:url value="/images/excel10.png" />" alt="메뉴에서 매크로를 실행" />
									</div>
								</li>
							</ul>
						</div>

						<div class="contents-box">
							<h6 class="title0601">
								4. 확인
							</h6>

							<ul class="ul-list03">
								<li class="mb20">
									엑셀문서를 확인합니다.
									<div class="images-box pt10">
										<img src="<c:url value="/images/excel11.png" />" alt="엑셀문서를 확인" />
									</div>
								</li>
							</ul>
						</div>
					</div>
					
						
		        </div>
			  <!-- //CMS 끝 -->
			 </div>
		</div>
	</article>
	<!-- //contents  -->

	</div>
</section>       
		        
		        
		        
<script type="text/javascript">
//<![CDATA[ 

$(function(){
	
	$(".tabmenu-type03 > li > a").click(function() {
		var thisIndex = $(this).attr('id');;
		thisIndex = thisIndex.replace(/[^0-9]/g,"");
		$(".tabmenu-type03 > li > a").removeClass('on');
		$(this).addClass('on');

		$(".ECsource-content-area").hide();
		$("#contents-SAMPLE" + thisIndex).show();
	});
	
	$(".tabmenu-type04 > li > a").click(function() {
		var thisIndex = $(this).attr('id');;
		thisIndex = thisIndex.replace(/[^0-9]/g,"");
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
	
	$.ajaxPrefilter('json', function(options, orig, jqXHR){
		return 'jsonp';
	});
	$.ajax({
		 url         : 'https://www.nabostats.go.kr/openapi/Sttsapitbldata.do?STATBL_ID=T188723004802681&DTACYCLE_CD=YY&Type=json', 
		/* url         : 'http://localhost/hub/SttsApiTblData?STATBL_ID=T182573126708314&DTACYCLE_CD=YY&ITM_DATANO=10001&CLS_DATANO=50022&Type=json', */		
		type        : 'GET',
		dataType    : 'json',
		success     : function (result) {
			//console.log(result);
			drawBarChart(result);
			drawPieChart(result);
			drawGrid(result);
			
		},
		error       : function (result) {
		}
	});
}

function drawBarChart(jsonData) {
	var rows = jsonData.Sttsapitbldata[1].row;
	if(rows) {
		var representativeRow = rows[0], statNm = representativeRow.STATBL_ID, itemNm1 = representativeRow.WRTTIME_IDTFR_ID, uiNm = representativeRow.UI_NM;

		var dataArray = [];
		$.each(rows, function(idx, row) {
			var tmp = [];
			tmp.push(row.ITM_NM);
			tmp.push(Number(row.DTA_VAL));
			dataArray.push(tmp);
		});

		$('#barChart').highcharts({
			chart: {
				type: 'column'
			},
	        credits: {
	            enabled: false
	        },
			title: {
				text: '총수입·총지출'
			},
			xAxis: {
				type: 'category',
				labels: {
					style: {
						fontSize: '13px',
						fontFamily: 'Verdana, sans-serif'
					}
				}
			},
			yAxis: {
				min: 0,
				title: {
					text: uiNm
				},
				 labels: {
				    	formatter: function(){
				    		return commaWon(this.value);
				    	}
						/* style: { color: Highcharts.getOptions().colors[0] } */
				    }
			},
			tooltip: {
				pointFormat: '{point.y}'+uiNm
			},
			series: [{
				name: itemNm1,
				data: dataArray
			}]
		});
	}
}

function drawPieChart(jsonData) {
	var rows = jsonData.Sttsapitbldata[1].row;
	if(rows) {
		var representativeRow = rows[0], statNm = representativeRow.STATBL_ID, itemNm1 = representativeRow.WRTTIME_IDTFR_ID, uiNm = representativeRow.UI_NM;

		var dataArray = [];
		$.each(rows, function(idx, row) {
			var tmp = [];
			tmp.push(row.ITM_NM);
			tmp.push(Number(row.DTA_VAL));
			dataArray.push(tmp);
		});

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
                text: '총수입·총지출'
            },
            tooltip: {
                pointFormat: '<b>{point.percentage:.1f}%</b>'
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true
                    },
                    showInLegend: true
                }
            },
            series: [{
                colorByPoint: true,
                data: dataArray
            }]
		});
	}
}

function drawGrid(jsonData) {
	var rows = jsonData.Sttsapitbldata[1].row;
	if(rows) {
		var html = '';
		$.each(rows, function(idx, row) {
			
			html += '<tr>';
			html += '	<td>' + row.ITM_NM + '</td>';
			html += '	<td>' + commaWon(row.DTA_VAL) + '</td>';
			html += '</tr>';
			
		});
		$('#grid').append(html);
	}
}

//원단위 콤마
function commaWon(n){
	var reg = /(^[+-]?\d+)(\d{3})/;   // 정규식
  	n += '';                          // 숫자를 문자열로 변환

	while (reg.test(n))
    n = n.replace(reg, '$1' + ',' + '$2');
   return n;
}

//]]>
</script>		
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
</div>
<script type="text/javascript" src="<c:url value="/js/portal/openapi/openApiSns.js" />"></script>
</body>
</html>
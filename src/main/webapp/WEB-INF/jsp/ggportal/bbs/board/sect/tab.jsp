<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)tab.jsp 1.0 2015/06/15                                             --%>
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
<%-- 하단 탭 섹션 화면이다.                                                 --%>
<%--                                                                        --%>
<%-- @author 김은삼                                                         --%>
<%-- @version 1.0 2015/06/15                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
        <c:if test="${data.bbsCd == 'DEVELOP'}">
        <!-- Open API 소개 -->
        <section id="tab_B_cont_2">
            <h4 class="hide">Open API 소개</h4>
            <h5 class="ty_h4">Open API란?</h5>
            <div class="box_B OpenAPI">
                <p>API는 응용프로그램이나 서비스를 개발하는데 필요한 운영체제(OS)나 라이브러리 등의 특정 기능을 추상화하여 사용하기 쉽도록 만든 인터페이스로 Single UNIX Specification, Windows API 등을 말합니다.</p> 
                <p>Open API는 Web 2.0 API, 통신망 서비스 API 등 주로 인터넷이나 통신망과 관련된 자원의 API를 의미하는 것으로, 여러 사람들이 공동으로 사용할 필요가 있는 자원에 대하여 이 자원의 사용을 개방하고, 사용자들이 자원에 대한 전문적인 지식이 없어도 쉽게 사용할 수 있도록 기능을 추상화하여 표준화한 인터페이스를 말합니다.</p> 
                <p>이러한 Open API 서비스는 아마존, 구글 등 글로벌 회사들이 자사의 서비스를 일반 개발자, 타사 등에 개방하여 다양한 Mashup 서비스가 생겨나게 하고, 이렇게 하는 것이 자사의 비즈니스를 더욱 확대하고 수익을 창출하게 되는 계기가 되는 것이 입증되었기에, 국내에서도 공공기관과 포털 사이트를 중심으로 Open API를 이용하여 자사의 자원을 개방하는 서비스가 보편화되고 있는 추세입니다.</p> 
                <img src="<c:url value="/img/ggportal/desktop/communication/img_OpenAPI.jpg" />" alt="API WEB Browser, Tablet, Smart Phone" />
            </div>
            <div class="area_btn_AC  mq_mobile">
                <a href="<c:url value="/portal/myPage/actKeyPage.do?tabIdx=1" />" class="btn_AC">인증키발급</a>
            </div>
        </section>
        <!-- // Open API 소개 -->
         
        <!-- Open API 사용방법 --> 
        <section id="tab_B_cont_3" class="section_OpenAPI_guide" style="display:none">
            <h4 class="hide">Open API 사용방법</h4>
            <h5 class="ty_h4_B">1. 사용할 Open API 정하기</h5>
            <p>국회 공공데이터를 검색합니다. 
            Open API로 이용할 공공데이터를 찾습니다.</p> 
            <h5 class="ty_h4_B">2. 명세서를 다운로드 받습니다.</h5>
            <p>명세서에는 Open API를 사용하기 위한 설명이 포함되어 있습니다.</p>  
            <img src="<c:url value="/img/ggportal/desktop/communication/img_OpenAPIguide_2.png" />" class="txt_OpenAPIguide" alt="명세서 다운로드에 대한 설명 그림" />
            <h5 class="ty_h4_B">3. 인증키 발급</h5>
            <p>국회 공공데이터에서 제공하는 Open API는 RESTful 방식의 웹서비스 입니다. 
            RESTful 웹서비스는 HTTP를 사용하는 웹기반 인터페이스로  GET 또는 POST 방식의 URI를 
            통해 서비스 되기에 파라미터의 값을 URL에 표기하여 페이지를 로딩합니다. 
            인증키를 발급 받기 위해서는 로그인을 하셔야 합니다.</p> 
            <img src="<c:url value="/img/ggportal/desktop/communication/img_OpenAPIguide_3.png" />" class="txt_OpenAPIguide" alt="인증키 발급에 대한 설명 그림" />
            <ol>
            <li class="num_1"><strong class="num">1</strong>활용용도를 입력합니다.</li> 
            <li class="num_2"><strong class="num">2</strong>내용을 입력합니다.</li> 
            <li class="num_3"><strong class="num">3</strong>인증키 발급 요청을 클릭하면 자동으로 인증키가 발급됩니다.</li> 
            </ol>
            <h5 class="ty_h4_B">4. URL 등록</h5>
            <img src="<c:url value="/img/ggportal/desktop/communication/img_OpenAPIguide_4.png" />" class="txt_OpenAPIguide" alt="URL 등록에 대한 설명 그림" />
            <ol>
            <li class="num_1"><strong class="num">1</strong>Open API URL : 국회 공공데이터의 Open API 주소는 http://data.assembly.go.kr 입니다.</li> 
            <li class="num_2"><strong class="num">2</strong>Open API 명 :  국회 공공데이터의 Open API 서비스는 고유명을 가지고 있습니다. 다운로드 받으신 명세표에 요청 주소가 표기되어 있습니다.</li> 
            <li class="num_3"><strong class="num">3</strong>기본인자 : 기본인자를 생략하면 명세표의 기본값으로 결과를 표기합니다. 
            인증키(KEY)는 발급을 받으신 후 발급 받은 인증키를 추가하여야 합니다.  
            만약 인증키가 없다면 기본값은 sample로 처리되어 5건 만 출력되므로 반드시 인증키를 입력하셔야 합니다. 
       
            호출문서(Type)은 xml 이나 json 등 출력하고자 하는 타입의 형태를 지정합니다. 기본값은 xml입니다. 
           
            페이지 위치(pIndex)는 출력하고자 하는 페이지 입니다. 데이터 수가 많은 경우에는 페이지 위치를 증가시키면서 여러 번에 나누어 호출하셔야 합니다. 
          
            페이지당 요청숫자(pSize)는 한 페이지에 출력될 건수입니다. 국회 나눔데이터는 1회 요청에 최대 1,000건 까지 데이터를 제공하므로 1~1,000 범위로
            지정되어야 합니다. 
            </li> 
            <li class="num_4"><strong class="num">4</strong>요청인자 : 국회 공공데이터의 각 서비스 별로 별도로 지정한 인자 값 입니다. 이 요청인자는 요청인자가 제공되는 서비스만 가능합니다. 
            예를 들어 국회의 데이터만 검색하고자 한다면 요청인자(SIGUN_CD)의 값을 “41310”으로 지정하여 URL을 요청하면 국회의 내용만 Open API에 제공됩니다.</li> 
            </ol>
            <h5 class="ty_h4_B">5. APP에서 Open API 요청</h5>
            <p>이제 Open API를 활용하여  새로운 App을 개발하였습니다.
            개발 된 App에서 요청한 데이터가 여러분께서 만든 앱의 내용에 표시됩니다.</p>
            <img src="<c:url value="/img/ggportal/desktop/communication/img_OpenAPIguide_5.png" />" class="txt_OpenAPIguide" alt="APP에서 Open API 요청에 대한 설명 그림" />
            <p>Open API를 활용하여 만든 App이나 서비스는 국회 공공데이터의 활용갤러리에 등록하여 홍보하실 수 있습니다.</p> 
            <div class="area_btn_AC  mq_mobile">
                <a href="<c:url value="/portal/myPage/actKeyPage.do?tabIdx=1" />" class="btn_AC">인증키발급</a>
            </div>
        </section>
        <!-- // Open API 사용방법 -->
        <c:if test="${!empty param.tab}">
        <script type="text/javascript">
            $(function() {
                $("#tab_B_" + "<c:out value="${param.tab}" />").click();
            });
        </script>
        </c:if>
        </c:if>
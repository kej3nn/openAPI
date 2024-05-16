<%@page import="org.codehaus.jackson.map.util.ObjectBuffer"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="HS"        value="<!HS>"  />
<c:set var="HS_VAL"    value="<span>" />
<c:set var="HE"        value="<!HE>"  />
<c:set var="HE_VAL"    value="</span>"  />
<c:set var="homepage_root"    value="https://www.assembly.go.kr"  />

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 통합검색
<%-- 
<%-- @author wisenut
<%-- @version 1.0 2019/11/05
<%--
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>

<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/portal/search.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/portal/search_mobile.css" />" />
<script type="text/javascript" src="<c:url value="/js/portal/search/d3.v3.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/portal/search/kcloud.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/portal/search/search.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/portal/search/ark.js" />"></script>
 <style>
.link {
stroke: #666;
opacity: 0.6;
stroke-width: 1.5px;
}
.node circle {
stroke: #fff;
opacity: 0.6;
stroke-width: 1.5px;
}
text {
font: 15px;
opacity: 0.6;
}
</style>
<script>
$(document).ready(function() {
	
	var onCol = '${vo.collection}';
	var onTab = '${vo.colTab}';
	var allCnt = '${colResult.allCount}';
	 page = '${vo.startCount}';
			
	$('.ytab > li').removeClass('on');
	$('.ylnb_sub > li > a').removeClass('on');
	$('#'+onCol + '_li').addClass('on');
	
	if(onCol == null || onCol =='')
		$('#ALL_li').addClass('on');
	
	if(onTab != '' && onTab != null)
	$('#'+onTab + '> a').addClass('on');
	
	$('#colT > li > a').removeClass('selected');
	
	if(onTab == 'iopenT' || onTab == null || onTab == ""){
		$('#iopenT > a').addClass('selected');
		$('#h3title').text($('#iopenT > a').text());
		$('#h3title').append('<span class="arrow"></span>');
	}else{
		$('#otherT > a').addClass('selected');
		$('#h3title').text($('#'+onTab + '> a').text());
		$('#h3title').append('<span class="arrow"></span>');
	}
	
	if(onCol!='ALL' && onCol!='ALLA' && onCol!='ALLR'){
		if(allCnt!=0 && allCnt != null ){
			pages = Math.ceil(allCnt / 10);	
			viewSearchPaging(allCnt,pages,page )
		}
	}
	
	//getCloud(20); //클라우드 가져올 단어수
	//drawNetwork("${vo.query}" );
	//getNetwork("${vo.query}" );
    getPopkeyword("D" , "iopenpop"); //D:일간 W:주간
	// 내가 찾은 검색어
	getMyKeyword("${vo.query}", '${colResult.allCount}');
	$("#colselect").val(onCol);	
	
	if("${vo.detailYn}" == "Y"){
		$("#detailsearch").addClass("on");
		$(".ysearch_detail").css('display','block');
	}

});
</script>

</head>

<body>

<!-- header -->
<%@ include file="/WEB-INF/jsp/portal/sect/header.jsp" %>
<!-- //header -->

<!-- wrapper -->
<div class="wrapper" id="wrapper">
<section>
  <div class="container" id="container"> 
    
    <!-- lnb -->
    <nav>
      <div class="lnb">
        <h2>통합검색</h2>
        <ul id="colT">
          <li id="iopenT"><a href="javascript:doCollection('ALL', 'iopenT')" class="menu_1">열린국회정보</a></li>
          <li id="otherT" ><a href="javascript:doCollection('ALLA', 'assemTab')" class="menu_2 selected" >국회정보서비스</a></li>
          <li>
            <ul class="ylnb_sub">
              	<li id="assemTab"><a href="javascript:doCollection('ALLA', 'assemTab')">국회홈페이지</a></li>
                <li id="billTab"><a href="javascript:doCollection('bill', 'billTab')">의안정보</a></li>
                <li id="recordTab"><a href="javascript:doCollection('record1', 'recordTab')">회의록</a></li>
                <li id="auditTab"><a href="javascript:doCollection('audit', 'auditTab')">국정감사</a></li>
                <li id="nalawTab"><a href="javascript:doCollection('nalaw', 'nalawTab')">국회법률정보</a></li>
                <li id="nasTab"><a href="javascript:doCollection('nas', 'nasTab')">국회사무처</a></li>
                <li id="committeeTab"><a href="javascript:doCollection('committee', 'committeeTab')">국회위원회</a></li>
                <li id="petitTab"><a href="javascript:doCollection('petit', 'petitTab')">청원</a></li>
              </ul>
          </li>
        </ul>
      </div>
    </nav>
    <!-- //lnb --> 
    <!-- content -->
    <article>
      <div class="contents mh990" id="contents">
        <div class="contents-title-wrapper">
          <h3 id="h3title"> 열린국회정보 <span class="arrow"></span></h3>
        </div>
        <div class="contents-area"> 
          <!-- 통합검색 시작 -->
          <form name="search" id="search"  action="javascript:doSearch();" method="post">
          <div class="ysearch">
              <div class="inner">
				  <input type="hidden" name="collection" value="${vo.collection }" title="collection" id="collection" />
				  <input type="hidden" name="startCount" value="${vo.startCount }" title="startCount" id="startCount" />
				  <input type="hidden" name="viewCount" value="${vo.viewCount }" id="viewCount"  title="viewCount"/>
				  <input type="hidden" name="sort" value="${vo.sort }" id="sort" title="collection" />
				  <input type="hidden" name="startDate" value="${vo.startDate }" id="startDate" title="startDate"/>
				  <input type="hidden" name="endDate" value="${vo.endDate }" id="endDate" title="endDate"/>
				  <input type="hidden" name ="reQuery"  value ="" title="reQuery"/>
				  <input type="hidden" name ="realQuery"  value ="${vo.realQuery }" title="realQuery"/>
				  <input type="hidden" name ="searchField"  value ="${vo.searchField }" title="searchField"/>
				  <input type="hidden" name ="colTab" value="${vo.colTab }" title="colTab"/>
				  <input type="hidden" name ="detailYn" value="${vo.detailYn }" title="detailYn"/>
				  <input type="hidden" name ="dateRange"  id="dateRange"  value="${vo.dateRange }" title="dateRange" />
                  <input type="text" name="query" id="query" value="${ vo.query }" class="input" title="통합검색어 입력" placeholder="검색어를 입력하세요">
                  <input type="hidden" name ="groupField" id="groupField" value="" title="groupField"/>
                  <button type="button" class="btn_src" onclick="doSearch()"><span>검색</span></button>
                  <button type="button" id="arkb" class="btn_hint"><span class="screen_out">검색 제안어 보기</span></button>
                  <!-- button class="on" 화살표 반대로 닫기 -->
              </div>

              <div class="ysearch_hint" id="ark_wrap" style="display:none">
                  <span class="screen_out">자동완성</span>
                  <ul id="ark_content_list">
                  </ul>
              </div>
          </div>
          </form>
          <!-- //통합검색 끝 --> 
        
          <!-- 결과내검색 상세검색 시작 -->
          <div class="ysearch_option">
              <span class="resultsearch"><input type="checkbox" name="reChk" id="reChk" onclick="checkReSearch()"> 결과내 검색</span>
              <a href="javascript:detailSearchOnOFF()" class="detailsearch" id="detailsearch"><span>상세검색</span></a>
              <!-- a href="#none" class="on" 화살표 반대로 닫기 -->
          </div>
          
          <!-- 상세검색 화면 시작 -->    
          <div class="ysearch_detail" style="display:none;">
              <table style="width: 100%">
                <caption>
                 상세검색
                </caption>
                <!--
                <colgroup>
                  <col width="20%">
                  <col width="80%">
                </colgroup>
                -->
                
                <tbody>
                  <!-- <tr>
                    <th scope="row">검색어</th>
                    <td class="srch"><input type="text"></td>
                  </tr> -->
                  <tr>
                    <th scope="row">기간설정</th>
                    <td>
                        <input type="text" class="term" name="stDt" id="stDt" value="${vo.startDate}" title="시작일" />
                        <!-- <a href="javascript:gfn_portalCalendar()"><img src="../../images/search/ic_cal.png" id="stDt" alt="달력"></a> -->
                        -
                        <input type="text" class="term" id="edDt" name="edDt"  value="${vo.endDate}" title="종료일" />
                       <!--  <a href="javascript:gfn_portalCalendar('')"><img src="../../images/search/ic_cal.png" alt="달력"></a> -->
                        <span><input type="radio" name="date_range" id="dateAll"  value ="A" title="전체"  onclick="setDate('A')" <c:if test="${vo.dateRange =='' || vo.dateRange =='A'}"> checked </c:if> /> 전체 </span>
                        <span><input type="radio" name="date_range"  value ="w" title="1주일" onclick="setDate('w')" <c:if test="${vo.dateRange =='w'}"> checked </c:if> /> 1주일</span>
                        <span><input type="radio" name="date_range"  value ="1m" title="1개월" onclick="setDate('1m')"  <c:if test="${vo.dateRange =='1m'}"> checked </c:if> /> 1개월</span>
                        <span><input type="radio" name="date_range"  value ="6m" title="6개월" onclick="setDate('6m')" <c:if test="${vo.dateRange =='6m'}"> checked </c:if> /> 6개월</span>
                        <span><input type="radio" name="date_range"  value ="1y" title="1년" onclick="setDate('1y')" <c:if test="${vo.dateRange =='1y'}"> checked </c:if> /> 1년</span>
                    </td>
                  </tr>
                  <tr>
                    <th scope="row">검색범위</th>
                    <td>
                        <span><input type="radio" name="s_field" id="sfieldAll" title="전체" value="ALL" <c:if test="${vo.searchField == null || vo.searchField =='ALL'}"> checked </c:if> /> 전체</span>
                        <span><input type="radio" name="s_field" title="제목" value="title"  <c:if test="${vo.searchField =='title'}"> checked </c:if> /> 제목</span>
                        <span><input type="radio" name="s_field" title="본문" value="content"  <c:if test="${ vo.searchField =='content'}"> checked </c:if> /> 본문</span>
                    </td>
                  </tr>
                  <tr>
                    <th scope="row">제외단어</th>
                    <td>
                        <input type="text" name="n_query" id="n_query" class="term2" title="제외단어입력" >
                    </td>
                  </tr>
                </tbody>
              </table>
              
              <ul class="bt_list">
                <li><button type="button" class="bt_reset" onclick="detailReset()">초기화</button></li>
                <li><button type="button" class="bt_dtsrch" onclick="doDetail()">상세검색</button></li>
              </ul>
          </div>
          <!-- //상세검색 화면 끝 -->
          <!-- //결과내검색 상세검색 끝 -->
          

          <ul class="ytab">
          	 <c:if test="${vo.collection == 'ALL' || fn:contains(vo.collection, 'iopen') }">
              <li id="ALL_li" class="on"><a href="javascript:doCollection('ALL', 'iopenT')">통합검색</a></li>
              <li id="iopen_name_li" class="on"><a href="javascript:doCollection('iopen_name', 'iopenT')">정보공개명칭</a></li>
              <li id="iopen_li" class="on"><a href="javascript:doCollection('iopen', 'iopenT')">정보공개데이터</a></li>
              <li id="iopen_file_li" class="on"><a href="javascript:doCollection('iopen_file', 'iopenT')">첨부파일</a></li>
              <li id="iopen_compass_li" class="on"><a href="javascript:doCollection('iopen_compass', 'iopenT')">국회정보나침반</a></li>
             <!--  <li id="iopen_chairman_li" class="on"><a href="javascript:doCollection('iopen_chairman', 'iopenT')">의원소개</a></li> -->
              <li id="iopen_notice_li" class="on"><a href="javascript:doCollection('iopen_notice', 'iopenT')">알림마당</a></li>
             </c:if>
            <%--  <c:if test="${vo.collection == 'ALLA' || vo.collection == 'assem_act' ||vo.collection == 'home_menu' 
             || vo.collection == 'homehelp' || vo.collection == 'notice' || vo.collection == 'cmmnt' 
             || vo.collection == 'chairman' || vo.collection == 'chairman_intro'}">  홈페이지 리뉴얼 --%>
             <c:if test="${vo.collection == 'ALLA'  ||  fn:contains(vo.collection, 'home_') }">
              <li id="ALLA_li" class="on"><a href="javascript:doCollection('ALLA', 'assemTab')">통합검색</a></li>
              <li id="home_data_li" class="on"><a href="javascript:doCollection('home_data', 'assemTab')">홈페이지 데이터</a></li>
              <li id="home_file_li" class="on"><a href="javascript:doCollection('home_file', 'assemTab')">홈페이지 첨부파일</a></li>
              <li id="home_magazine_li" class="on"><a href="javascript:doCollection('home_magazine', 'assemTab')">국회공보</a></li>
              <!-- <li id="home_menu_li" class="on"><a href="javascript:doCollection('home_menu', 'assemTab')">메뉴검색</a></li> -->
             <!--  <li id="assem_act_li" class="on"><a href="javascript:doCollection('assem_act', 'assemTab')">국회활동</a></li>
              <li id="chairman_li" class="on"><a href="javascript:doCollection('chairman', 'assemTab')">의원활동</a></li>
              <li id="notice_li" class="on"><a href="javascript:doCollection('notice', 'assemTab')">알림마당</a></li>
              <li id="cmmnt_li" class="on"><a href="javascript:doCollection('cmmnt', 'assemTab')">소통마당·국회소개</a></li> -->
             </c:if>
             <c:if test="${vo.collection == 'ALLR' || fn:contains(vo.collection, 'record') }">
              <!-- <li id="ALLR_li" class="on"><a href="javascript:doCollection('ALLR', 'recordTab')">통합검색</a></li> -->  
              <li id="record1_li"><a href="javascript:doCollection('record1', 'recordTab')">본회의</a></li>
              <li id="record2_li"><a href="javascript:doCollection('record2', 'recordTab')">상임위원회</a></li>
              <li id="record3_li"><a href="javascript:doCollection('record3', 'recordTab')">특별위원회</a></li>
              <li id="record4_li"><a href="javascript:doCollection('record4', 'recordTab')">예산결산특별위원회</a></li>
              <li id="record5_li"><a href="javascript:doCollection('record5', 'recordTab')">국정감사</a></li>
              <li id="record6_li"><a href="javascript:doCollection('record6', 'recordTab')">국정조사</a></li>
            </c:if>
            
             <c:if test="${ fn:contains(vo.collection, 'bill') }">
              <!-- <li id="ALLR_li" class="on"><a href="javascript:doCollection('ALLR', 'recordTab')">통합검색</a></li> -->  
              <li id="bill_li"><a href="javascript:doCollection('bill', 'billTab')">제안및이유</a></li>
              <li id="bill_simsa_li"><a href="javascript:doCollection('bill_simsa', 'billTab')">심사보고서</a></li>
              <li id="bill_review_li"><a href="javascript:doCollection('bill_review', 'billTab')">검토보고서</a></li>
            </c:if>
            
             <c:if test="${ vo.collection == 'audit' }">
              <!-- <li id="ALLR_li" class="on"><a href="javascript:doCollection('ALLR', 'recordTab')">통합검색</a></li> -->  
              <li id="audit_li"><a href="javascript:doCollection('audit', 'auditTab')">국정감사</a></li>
            </c:if>
             <c:if test="${ vo.collection == 'nalaw' }">
              <!-- <li id="ALLR_li" class="on"><a href="javascript:doCollection('ALLR', 'recordTab')">통합검색</a></li> -->  
              <li id="nalaw_li"><a href="javascript:doCollection('nalaw', 'nalawTab')">국회법률정보</a></li>
            </c:if>
            
            <c:if test="${ fn:contains(vo.collection, 'nas') }">
              <!-- <li id="ALLR_li" class="on"><a href="javascript:doCollection('ALLR', 'recordTab')">통합검색</a></li> -->  
              <li id="nas_li"><a href="javascript:doCollection('nas', 'nasTab')">국회사무처</a></li>
              <li id="nas_file_li"><a href="javascript:doCollection('nas_file', 'nasTab')">첨부파일</a></li>
              <li id="nas_ebook_li"><a href="javascript:doCollection('nas_ebook', 'nasTab')">연구용역보고서</a></li>
            </c:if>
            
            <c:if test="${ fn:contains(vo.collection, 'committee') }">
              <!-- <li id="ALLR_li" class="on"><a href="javascript:doCollection('ALLR', 'recordTab')">통합검색</a></li> -->  
              <li id="committee_li"><a href="javascript:doCollection('committee', 'committeeTab')">국회위원회</a></li>
              <li id="committee_file_li"><a href="javascript:doCollection('committee_file', 'committeeTab')">첨부파일</a></li>
            </c:if>
            
            <c:if test="${ vo.collection== 'petit' }">
              <!-- <li id="ALLR_li" class="on"><a href="javascript:doCollection('ALLR', 'recordTab')">통합검색</a></li> -->  
              <li id="petit_li"><a href="javascript:doCollection('petit', 'petitTab')">청원</a></li>
            </c:if>
          </ul>
          <!-- //탭 끝 -->
          
          <!-- 탭 모바일 시작 -->
          <select name="colselect" id="colselect" class="ytab_mobile" title="카테고리검색" onchange="doCollectionM()">
          	 <c:if test="${vo.collection == 'ALL' || fn:contains(vo.collection, 'iopen') }">
              	<option value="ALL" class="iopenT">통합검색</option>
              	<option value="iopen_name" class="iopenT">정보공개명칭</option>
             	<option value="iopen" class="iopenT">정보공개데이터</option>
             	<option value="iopen_file" class="iopenT">첨부파일</option>
              	<option value="iopen_compass" class="iopenT">국회정보나침반</option>
              	<option value="iopen_notice" class="iopenT">알림마당</option>
             </c:if>
              <%-- <c:if test="${vo.collection == 'ALLA' || vo.collection == 'assem_act' ||vo.collection == 'home_menu' 
             || vo.collection == 'homehelp' || vo.collection == 'notice' || vo.collection == 'cmmnt' 
             || vo.collection == 'chairman' || vo.collection == 'chairman_intro'}"> --%>
             
             <c:if test="${vo.collection == 'ALLA' ||  fn:contains(vo.collection, 'home_')}">
             	<option value="ALLA" class="assemTab">통합검색</option>
             	<option value="home_data" class="assemTab">홈페이지 데이터</option>
              	<option value="home_file" class="assemTab">홈페이지 첨부파일</option>
              	<option value="home_magazine" class="assemTab">국회공보</option>
             </c:if>
             
             <c:if test="${vo.collection == 'ALLR' || fn:contains(vo.collection, 'record') }">
             	<option value="record1" class="recordTab">본회의</option>
             	<option value="record2" class="recordTab">상임위원회</option>
              	<option value="record3" class="recordTab">특별위원회</option>
              	<option value="record4" class="recordTab">예산결산특별위원회</option>
              	<option value="record5" class="recordTab">국정감사</option>
              	<option value="record6" class="recordTab">국정조사</option>
             </c:if>
             
             <c:if test="${ fn:contains(vo.collection, 'bill') }">
              <!-- <li id="ALLR_li" class="on"><a href="javascript:doCollection('ALLR', 'recordTab')">통합검색</a></li> -->  
              	<option value="bill" class="billTab">제안및이유</option>
              	<option value="bill_simsa" class="billTab">심사보고서</option>
              	<option value="bill_review" class="billTab">검토보고서</option>
            </c:if>
            
            <c:if test="${ vo.collection == 'audit' }">
              <!-- <li id="ALLR_li" class="on"><a href="javascript:doCollection('ALLR', 'recordTab')">통합검색</a></li> -->  
              <option value="audit" class="auditTab">국정조사</option>
            </c:if>
            
            <c:if test="${ vo.collection == 'nalaw' }">
              <!-- <li id="ALLR_li" class="on"><a href="javascript:doCollection('ALLR', 'recordTab')">통합검색</a></li> -->  
              	<option value="nalaw" class="nalawTab">국회법률정보</option>
            </c:if>
            
            <c:if test="${ fn:contains(vo.collection, 'nas') }">
              <!-- <li id="ALLR_li" class="on"><a href="javascript:doCollection('ALLR', 'recordTab')">통합검색</a></li> -->  
              	<option value="nas" class="nasTab">국회사무처</option>
              	<option value="nas_file" class="nasTab">첨부파일</option>
              	<option value="nas_ebook" class="nasTab">연구용역보고서</option>
            </c:if>
            
            <c:if test="${ fn:contains(vo.collection, 'committee') }">
              <!-- <li id="ALLR_li" class="on"><a href="javascript:doCollection('ALLR', 'recordTab')">통합검색</a></li> -->  
				<option value="committee" class="committeeTab">국회위원회</option>
              	<option value="committee_file" class="committeeTab">첨부파일</option>
            </c:if>
            
            <c:if test="${ vo.collection== 'petit' }">
              <!-- <li id="ALLR_li" class="on"><a href="javascript:doCollection('ALLR', 'recordTab')">통합검색</a></li> -->  
              <option value="petit" class="petitTab">청원</option>
            </c:if>
          
          </select>
          <!-- //탭 모바일 끝 -->
          
        </div>
        <!-- //contents-area -->
        
        
        <!-- 새로운 컨텐츠에어리어 2단 시작 -->
        <div class="ycontents-area">
        	<!-- 검색결과 시작 -->
        	<div class="ysearch_result">
            	<div class="ysearch_result_num">‘${ vo.realQuery }’(으)로 검색한 게시물이 <span>총 <fmt:formatNumber value="${colResult.allCount}" pattern="#,###"/>개</span>가 존재합니다. </div>
                <div class="ysearch_result_sort">
                    <span><input type="radio" name="sort" title="정확도" onchange="doSorting('RANK')" <c:if test="${vo.sort == 'RANK' || vo.sort == null || vo.sort == '' }"> checked </c:if>  /> 정확도 </span>
                    <span><input type="radio" name="sort" title="최신순" onchange="doSorting('RDATE')" <c:if test="${vo.sort == 'RDATE'  }"> checked </c:if>  /> 최신순</span>
                </div>
           
           <!-- 정보공개포털 -->
            <c:if test="${vo.collection == 'ALL' || fn:contains(vo.collection, 'iopen_chairman') }">                
             <%@ include file="/WEB-INF/jsp/portal/search/result/iopen_chairman.jsp" %>
           </c:if>
            <c:if test="${vo.collection == 'ALL' || fn:contains(vo.collection, 'iopen_menu') }">                
             <%@ include file="/WEB-INF/jsp/portal/search/result/iopen_menu.jsp" %>
           </c:if>
            <c:if test="${vo.collection == 'ALL' ||vo.collection == 'iopen_name'}">                
             <%@ include file="/WEB-INF/jsp/portal/search/result/iopen_name.jsp" %>
           </c:if>
           <c:if test="${vo.collection == 'ALL' ||vo.collection == 'iopen'}">                
             <%@ include file="/WEB-INF/jsp/portal/search/result/iopen.jsp" %>
           </c:if>
            <c:if test="${vo.collection == 'ALL' ||vo.collection == 'iopen_file'}">                
             <%@ include file="/WEB-INF/jsp/portal/search/result/iopen_file.jsp" %>
           </c:if>
            <c:if test="${vo.collection == 'ALL' || fn:contains(vo.collection, 'iopen_compass') }">                
             <%@ include file="/WEB-INF/jsp/portal/search/result/iopen_compass.jsp" %>
           </c:if>
            <c:if test="${vo.collection == 'ALL' || fn:contains(vo.collection, 'iopen_notice') }">                
             <%@ include file="/WEB-INF/jsp/portal/search/result/iopen_notice.jsp" %>
           </c:if>
            
           <!-- 국회홈 페이지-->
           <c:if test="${vo.collection == 'ALLA' || fn:contains(vo.collection, 'home_data') }">                
             <%@ include file="/WEB-INF/jsp/portal/search/result/home_data.jsp" %>
           </c:if>
           <c:if test="${vo.collection == 'ALLA' || fn:contains(vo.collection, 'home_file') }">                
             <%@ include file="/WEB-INF/jsp/portal/search/result/home_file.jsp" %>
           </c:if>
           <c:if test="${ vo.collection=='home_magazine'}">                
             <%@ include file="/WEB-INF/jsp/portal/search/result/home_magazine.jsp" %>
           </c:if>
           
          <%--   <c:if test="${vo.collection == 'ALLA' || fn:contains(vo.collection, 'home_menu') }">                
             <%@ include file="/WEB-INF/jsp/portal/search/result/home_menu.jsp" %>
           </c:if> --%>
          <%--   <c:if test="${vo.collection == 'ALLA' || fn:contains(vo.collection, 'homehelp') }">                
             <%@ include file="/WEB-INF/jsp/portal/search/result/homehelp.jsp" %>
           </c:if>
           <c:if test="${vo.collection == 'ALLA' || fn:contains(vo.collection, 'chairman_intro') }">                
             <%@ include file="/WEB-INF/jsp/portal/search/result/chairman_intro.jsp" %>
           </c:if>
           <c:if test="${vo.collection == 'ALLA' || fn:contains(vo.collection, 'assem_act') }">                
             <%@ include file="/WEB-INF/jsp/portal/search/result/assem_act.jsp" %>
           </c:if>
           <c:if test="${vo.collection == 'ALLA' || vo.collection=='chairman' }">                
             <%@ include file="/WEB-INF/jsp/portal/search/result/chairman.jsp" %>
           </c:if>
            <c:if test="${vo.collection == 'ALLA' || vo.collection== 'notice' }">                
             <%@ include file="/WEB-INF/jsp/portal/search/result/notice.jsp" %>
           </c:if>
            <c:if test="${vo.collection == 'ALLA' || fn:contains(vo.collection, 'cmmnt') }">                
             <%@ include file="/WEB-INF/jsp/portal/search/result/cmmnt.jsp" %>
           </c:if> --%>
           
             
           <!-- 의안-->
            <c:if test="${vo.collection == 'bill_simsa' }">                
             <%@ include file="/WEB-INF/jsp/portal/search/result/bill_simsa.jsp" %>
           </c:if>
            <!-- 의안-->
            <c:if test="${vo.collection == 'bill_review' }">                
             <%@ include file="/WEB-INF/jsp/portal/search/result/bill_review.jsp" %>
           </c:if>
            <!-- 의안-->
            <c:if test="${vo.collection == 'bill' }">                
             <%@ include file="/WEB-INF/jsp/portal/search/result/bill.jsp" %>
           </c:if>
           
           <!-- 회의록 -->
		   <c:if test="${vo.collection == 'ALLR' || fn:contains(vo.collection, 'record1') }">                
             <%@ include file="/WEB-INF/jsp/portal/search/result/record1.jsp" %>
           </c:if>
           <c:if test="${vo.collection == 'ALLR' || fn:contains(vo.collection, 'record2') }">     
             <%@ include file="/WEB-INF/jsp/portal/search/result/record2.jsp" %>
             </c:if>
           <c:if test="${vo.collection == 'ALLR' || fn:contains(vo.collection, 'record3') }">     
             <%@ include file="/WEB-INF/jsp/portal/search/result/record3.jsp" %>
             </c:if>
           <c:if test="${vo.collection == 'ALLR' || fn:contains(vo.collection, 'record4') }">     
             <%@ include file="/WEB-INF/jsp/portal/search/result/record4.jsp" %>
           </c:if>
            <c:if test="${vo.collection == 'ALLR' || fn:contains(vo.collection, 'record5') }">     
             <%@ include file="/WEB-INF/jsp/portal/search/result/record5.jsp" %>
           </c:if>
            <c:if test="${vo.collection == 'ALLR' || fn:contains(vo.collection, 'record6') }">     
             <%@ include file="/WEB-INF/jsp/portal/search/result/record6.jsp" %>
           </c:if>
			
			<!-- 국정감사  -->
            <c:if test="${vo.collection == 'audit' }">     
             <%@ include file="/WEB-INF/jsp/portal/search/result/audit.jsp" %>
            </c:if>
            
			<!-- 국회법률정보  -->
            <c:if test="${vo.collection == 'nalaw' }">     
             <%@ include file="/WEB-INF/jsp/portal/search/result/nalaw.jsp" %>
            </c:if>
            
            <!-- 국회사무처  -->
            <c:if test="${vo.collection == 'nas' }">     
             <%@ include file="/WEB-INF/jsp/portal/search/result/nas.jsp" %>
            </c:if>
             <c:if test="${vo.collection == 'nas_file' }">     
             <%@ include file="/WEB-INF/jsp/portal/search/result/nas_file.jsp" %>
            </c:if>
             <c:if test="${vo.collection == 'nas_ebook' }">     
             <%@ include file="/WEB-INF/jsp/portal/search/result/nas_ebook.jsp" %>
            </c:if>
            
            
            <!-- 국회위원회  -->
            <c:if test="${vo.collection == 'committee' }">     
             <%@ include file="/WEB-INF/jsp/portal/search/result/committee.jsp" %>
            </c:if>
            <c:if test="${vo.collection == 'committee_file' }">     
             <%@ include file="/WEB-INF/jsp/portal/search/result/committee_file.jsp" %>
            </c:if>
			
			 <!-- 청원  -->
			<c:if test="${vo.collection == 'petit' }">     
             <%@ include file="/WEB-INF/jsp/portal/search/result/petit.jsp" %>
            </c:if>
           
           <c:if test="${colResult.allCount == 0 }"> 
 					<div class="no_result">	        	
					<strong>검색결과가 없습니다.</strong>
					<span>
						단어의 철자가 정확한지 확인해 보세요.<br>
						한글을 영어로 혹은 영어를 한글로 입력했는지 확인해 보세요.<br>
						검색어의 단어 수를 줄이거나, 보다 일반적인 검색어로 다시 검색해 보세요.<br>
						두 단어 이상의 검색어인 경우, 띄어쓰기를 확인해 보세요.
					</span>
	         	</div>
           
           </c:if>
           
          	<c:if test="${vo.collection != 'ALLR' && vo.collection != 'ALL' && vo.collection != 'ALLI' }"> 
            <!-- 페이징 시작 -->
             <div id="result-pager-sect">
                <!-- <p class="paging-navigation">  <strong class="page-number" style="cursor:default;">1</strong> <a href="#" class="btn-next btn_page_next" title="다음 5페이지 이동" style="cursor: default;">다음 5페이지 이동</a> <a href="#" class="btn-last btn_page_last" title="마지막페이지 이동" style="cursor: default;">마지막페이지 이동</a></p> -->
			</div>
			</c:if>         
            <!-- //페이징 끝 -->
           
            </div>
            <!-- //검색결과 끝 -->
            
            <!-- 각종 검색어 시작 -->
            <div class="ysearch_word">
            
            	<!-- <div class="ysearch_word_favor">
                	<div class="tit">인기검색어</div>
                    <div class="cont" >
                    	<ol id="poplist">
                        </ol>
                    </div>
                </div> -->
                
                <div class="ysearch_word_my">
                	<div class="tit">내가 찾은 검색어</div>
                    <div class="cont">
                    	<ul id="mykeyword">
                        </ul>
                    </div>
                </div>
                <!-- 2020.04.08 윤연선 주무관님 요청에 따라 hidden -->
                <!-- <div class="ysearch_word_link">
                	<div class="tit">연관검색어</div>
                    <div class="cont" id="network">
                    </div>
                </div> -->
                
                <!-- <div class="ysearch_word_tag">
                	<div class="tit">워드 클라우드</div>
                    <div class="cont" id="searchcloud">
                    </div>
                </div> -->
                
            </div>
            <!-- //각종 검색어 끝 -->
        </div>
        <!-- //새로운 컨텐츠에어리어 2단 끝 -->
        
      </div>
    </article>
  </div>
  <!-- //contents  --> 
</section>
</div>
	
<!-- footer -->
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
<!-- //footer -->	
	
</body>
</html>
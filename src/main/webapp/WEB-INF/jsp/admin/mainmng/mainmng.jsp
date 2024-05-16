<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code='wiseopen.title'/></title>            
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp"/>
<script type="text/javascript" src="<c:url value="/js/admin/mainmng/mainmng.js" />"></script>
<style type="text/css">
a {cursor:pointer;}
</style>
</head>                                                 
<script language="javascript">           
var ctxPath = '<c:out value="${pageContext.request.contextPath}" />';

///// message ////
var label00 = "<spring:message code='labal.status'/>";
var label01 = "<spring:message code='labal.cateId'/>";		// 분류 ID
var label02 = "<spring:message code='labal.cateNm'/>";	// 분류명

var label03 = "<spring:message code='labal.infId'/>";  
var label04 = "<spring:message code='labal.dtNm'/>";  
var label05 = "<spring:message code='labal.infNm'/>";        
var label06 = "<spring:message code='labal.cclCd'/>";  
var label07 = "<spring:message code='labal.fvtDataOrder'/>"; 
var label08 = "공공데이터순서";
var label09 = "<spring:message code='labal.cateNm'/>";        
var label10 = "<spring:message code='labal.useOrgCnt'/>";
var label11 = "<spring:message code='labal.openDttm'/>";        
var label12 = "<spring:message code='labal.infState'/>";        
var label13 = "개방서비스";   
var label14 = "<spring:message code='labal.aprvProcYn'/>";
var label15 = "상태";   


var ibSheetPageNow = <%= WiseOpenConfig.IBSHEETPAGENOW%>;


var niaId = "${codeMap.niaId}";

</script>         
</head>
<body onload="">
<div class="wrap">
		<c:import  url="/admin/admintop.do"/>   
		<!-- 내용 -->
		<div class="container">
			<!-- 상단 타이틀 -->   
			<div class="title">             
				<h2>${MENU_NM}</h2>                                      
				<p>${MENU_URL}</p>             
			</div>
			<ul class="tab">
				<li class="all_list"><a href="#">전체목록</a></li>                       
			</ul>
			
			<!-- 목록내용 -->
			<div class="content"  >
				<form name="admimMainMng"  method="post" action="#">
				<table class="list01">              
					<caption>보유데이터목록리스트</caption>
					<colgroup>
						<col width="150"/>
						<col width=""/>
					</colgroup>       
					<tr>
						<th>컨텐츠 구분</th>
						<td>
							<select name="homeTagCd"></select>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<button type="button" class="btn01B" name="btn_search"><spring:message code="btn.inquiry"/></button>
						</td>
					</tr>
					<tr>
						<th>검색어</th>
						<td>
							<select name="searchWd">
								<option value="1">서비스제목</option>
								<option value="2">연결URL</option>
							</select>
							<input type="text" name="searchWord" value=""/>
						</td>
					</tr>
					<tr>
						<th><spring:message code="labal.useYn"/></th>
						<td>
							<input type="radio" name="useYn" checked="checked"/>
							<label for="useAll"><spring:message code="labal.whole"/></label>
							<input type="radio" name="useYn"  value="Y"/>
							<label for="use"><spring:message code="labal.yes"/></label>
							<input type="radio" name="useYn" value="N"/>
							<label for="unuse"><spring:message code="labal.no"/></label>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="checkbox" name="chkTreeOpenClose"/>
							<label for="chkTreeOpen" name="chkTreeOpenCloseLabel">항목펼치기</label>
						</td>
					</tr>
				</table>
			</form>
			<!-- 메인페이지 관리 -->
			<div class="content">
			<script type="text/javascript">createIBSheet("mainSheet", "100%", "300px"); </script>                
				<div class="buttons" id="main-btns" style="margin-right:15px;">
					<a class="btn03" title="삭제" name="a_modify">삭제</a>
					<a class="btn02" title="위로" name="a_up">위로이동</a>
					<a class="btn02" title="아래로" name="a_down">아래로이동</a>
					<a class="btn03" title="수정" name="a_modify">수정</a>
				</div> 
				
				<form id="mainmng-insert-form" name="mainmng-insert-form" method="post" enctype="multipart/form-data" style="margin-top:20px;">
				<input type="hidden" name="seqceNo" value=""/>
				<table class="list01">
					<caption></caption>
					<colgroup>
						<col width="150"/>
						<col width=""/>
					</colgroup>
					<tr>
						<th>서비스제목<span>*</span></th>
						<td>
							<input type="text" value="" name="srvTit" maxlength="250"  style="width: 744px;"/>
						</td>
					</tr>
					<tr>
						<th>컨텐츠구분코드<span>*</span></th>
						<td>
							<select name="homeTagCd"></select>
						</td>
					</tr>
					<tr>
						<th>기간</th>
						<td>
							<input type="text" name="strtDttm" value="" readonly="readonly"/>
							<input type="text" name="endDttm" value="" readonly="readonly"/>       
							<button type="button" class="btn01" name="btn_dttm" id="dttm-init-btn">날짜초기화</button>       
						</td>
					</tr>
					<tr>
						<th>연결URL</th>
						<td>
							<input type="text" value="" name="linkUrl" maxlength="250"  style="width: 344px;"/><span id="flagLineDesc" style="display:none;padding-left: 5px;">연결URL을 입력하지 않으면 구분선이 됩니다.</span>
						</td>
					</tr>
					<tr>
						<th>이미지</th>
						<td>
							<input type="text" name="fileStatus" id="fileStatus" value="C" style="display:none;" readonly="">
							<input type="text" name="saveFileNm" id="saveFileNm" style="width: 200px;" value="" readonly="">
							<input type="file" name="file" id="file" onchange="fncFileChange2();" style="width: 80px; color: rgb(255, 255, 255);">
							<span>사이즈 : 500px * 520px (화면 하당 공지의 경우 139px * 112px 로 맞춰주십시오.)</span>
						</td>
					</tr>
					<tr style="display: none;">
						<th>배경이미지<span class="imgStar">*</span></th>
						<td>
							<input type="text" name="fileStatus2" id="fileStatus2" value="C" style="display:none;" readonly="">
							<input type="text" name="subSaveFileNm" id="subSaveFileNm" style="width: 200px;" value="" readonly="">
							<input type="file" name="file1" id="file1" onchange="fncFileChange3();" style="width: 80px; color: rgb(255, 255, 255);">
						</td>
					</tr>
					<tr>
						<th>팝업여부</th>
						<td>
							<select name="popupYn">
								<option value="N">N</option>
								<option value="Y">Y</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>사용여부<span>*</span></th>
						<td>
							<select name="useYn">
								<option value="Y">Y</option>
								<option value="N">N</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>팝업 템플릿 내용</th>
						<td>
							<textarea id="txta" name="srvCont" rows="3" cols="1" style="width: 75%;"></textarea>
						</td>
					</tr>
				</table>
				</form>           
				<div class="buttons" id="main-insert-btns" style="margin-right:15px;">
					<a class="btn02" title="초기화" name="a_init" id="mainmng-init-btn">초기화</a>
					<a class="btn03" title="등록" name="a_save" id="mainmng-save-btn">등록</a>
				</div> 
			</div>
			<!-- // 메인페이지 관리 -->

			<!-- 분류 관리 -->			
			<div class="content" style="display: none;">
			<h3 class="text-title2">분류정보 관리</h3>
				<script type="text/javascript">createIBSheet("cateSheet", "100%", "300px"); </script>             
				<div class="buttons" id="cate-btns" style="margin-right:15px;">
					<a class="btn02" title="위로" name="a_up">위로이동</a>
					<a class="btn02" title="아래로" name="a_down">아래로이동</a>
					<a class="btn03" title="수정" name="a_modify">수정</a>
				</div>
			</div>
			<!-- // 분류 관리 -->

			<!-- 메타 순서 관리 -->
			<div class="content" style="display: none;">
			<h3 class="text-title2">추천 데이터 관리</h3>
				<table class="list01">
					<caption>보유데이터목록리스트</caption>
					<colgroup>
						<col width="150"/>
						<col width=""/>
					</colgroup>  
					<tr>
						<th>검색어</th>
						<td>
							<input name="searchWord" type="text" value="" style="width:200px" maxlength="160" id="meta-search-word"/>
							<button type="button" class="btn01B" title="조회" name="btn_inquiry" id="meta-search-btn">조회</button>
						</td>
					</tr>
				</table>					
				<script type="text/javascript">createIBSheet("metaSheet", "100%", "300px"); </script>              
				<div class="buttons" id="meta-btns" style="margin-right:15px;">
					<a class="btn02" title="위로" name="a_up">위로이동</a>
					<a class="btn02" title="아래로" name="a_down">아래로이동</a>
					<a class="btn03" title="수정" name="a_modify">수정</a>
				</div>
			</div>
			<!-- // 메타 순서 관리 -->
		</div>
		<!-- // 내용 -->
	<c:import  url="/WEB-INF/jsp/inc/iframepopup.jsp"/>
	<!--##  푸터  ##-->                                       
	<c:import  url="/WEB-INF/jsp/admin/adminfooter.jsp"/>                                   
	<!--##  /푸터  ##-->            
</body>
</html>
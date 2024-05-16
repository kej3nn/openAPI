<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<div class="content" id="mst-sect" style="clear: both; display: none;">
		<form id="mst-form" name="mst-form" method="post" action="#">
		<ul class="tab-inner" name="tab-inner">   
			<li name="tab-inner-mst" class="tab-inner-li"><a href="#" class="service on">기본정보</a></li>
			<li name="tab-inner-exp" class="tab-inner-li"><a href="#" class="service" >설명</a></li>
			<li name="tab-inner-doc" class="tab-inner-li"><a href="#" class="service" >문서</a></li>
			<li name="tab-inner-open" class="tab-inner-li"><a href="#" class="service" >공공데이터</a></li>
			<li name="tab-inner-stat" class="tab-inner-li"><a href="#" class="service" >통계데이터</a></li>
		</ul>
		
		<div name="tab-inner-mst-sect" class="tab-inner-sect">
			<input type="hidden" id="expSheetNm"/>
			<input type="hidden" id="cateSheetNm"/>
			<input type="hidden" id="usrSheetNm"/>
			<input type="hidden" id="docSheetNm"/>
			<input type="hidden" id="openSheetNm"/>
			<input type="hidden" id="statSheetNm"/>
			<h3 class="text-title2">기본정보</h3>
			<table class="list01" style="position: relative;">
				<caption>기본정보</caption>
				<colgroup>
					<col width="150" />
					<col width="" />
					<col width="150" />
					<col width="" />
				</colgroup>
				<tr>
					<th><label>정보 ID</label> <span>*</span></th>
					<td colspan="3">
						<input type="text" name="infsId" id="infsId" value="" placeholder="ID 자동생성" readonly class="readonly" size="20" />&nbsp;&nbsp;
						<input type="checkbox" name="fvtDataYn" id="fvtDataYn"><label for="fvtDataYn">추천(홈페이지 노출)</label></input>
						<select id="fvtDataOrder" name="fvtDataOrder" style="width : 180px; display: none;">
						</select>
					</td>
				</tr>
				<tr>
					<th><label>정보명</label> <span>*</span></th>
					<td colspan="3">
						<input type="text" name="infsNm" id="infsNm" value="" placeholder="정보명" size="50" />
					</td>
				</tr>
				<tr>
					<th><label>분류</label> <span>*</span></th>
					<td colspan="3">※ 하단의 분류정보에서 확인할 수 있습니다.</td>
				</tr>
				<tr>
					<th>설명(요약)</th>
					<td colspan="3">
						<div style="padding: 3px 0 0 0"><input type="text" name="infsSmryExp" value="" placeholder="입력하세요" style="width:70%" /></div>
					</td>
				</tr>
				<tr>
					<th>키워드</th>
					<td colspan="3">
						<div style="padding: 3px 0 0 0"><label>※ 한글, 영문, 숫자만 입력하세요(키워드는 쉼표(,)로 구분하세요)</label></div>
						<div style="padding: 3px 0 0 0"><input type="text" name="schwTagCont" value="" placeholder="입력하세요" style="width:70%" /></div>
					</td>
				</tr>
				<tr>
					<th>사용여부 <span>*</span></th>
					<td colspan="3">
						<input type="radio" name="useYn" value="Y" checked="checked"><label>사용</label></input>&nbsp;&nbsp;
						<input type="radio" name="useYn" value="N"><label>사용안함</label></input>
					</td>
				</tr>	
			</table>
			
			<h3 class="text-title2" name="tblOpenH3">정보 공개</h3>
			<table class="list01" style="position: relative;" name="tblOpenTable">
				<caption>정보 공개</caption>
				<colgroup>
					<col width="150" />
					<col width="" />
					<col width="150" />
					<col width="" />
				</colgroup>
				<tr>
					<th><label>공개유형</label></th>
					<td colspan="3" class="serviceYn">
						<span class="icon-no-service" data-srv-gubun="D"><a href="javascript:;">문서</a></span>
						<span class="icon-no-service" data-srv-gubun="O"><a href="javascript:;">공공데이터</a></span>
						<span class="icon-no-service" data-srv-gubun="S"><a href="javascript:;">통계데이터</a></span>
					</td>
				</tr>
				<tr>				
					<th><label>공개일</label></th>
					<td colspan="3">
						<input type="hidden" name="openState" value="" />
						<input type="text" name="openDttm" value="" readonly="readonly" placeholder="공개일자" size="30" />
						<button type="button" class="btn01" id="openDttmInit" name="openDttmInit">초기화</button>
						<span style="float: right">
							${sessionScope.button.a_openState}
							${sessionScope.button.a_openStateCancel}
						</span>
					</td>
				</tr>
			</table>
			
			<!-- 분류정보 ibsheet 영역 -->
			<div style="width: 100%; float: left;">
				<div class="ibsheet-header">
					<h3 class="text-title2">분류정보</h3>
					<button type="button" class="btn01" name="cateAdd" style="float: right; margin-top: 30px;">추가</button>
				</div>
				
				<div style="clear: both;"></div>
				<div class="ibsheet_area_both">
					<div name="cateSheet" class="sheet"></div>
				</div>
			</div>
			
			<!-- 담당자정보 ibsheet 영역 -->
			<div style="width: 100%; float: left;">
				<div class="ibsheet-header">
					<h3 class="text-title2">담당자정보</h3>
					<button type="button" class="btn01" name="usrAdd" style="float: right; margin-top: 30px;">추가</button>
				</div>
				<div style="clear: both;"></div>
				<div class="ibsheet_area_both">
					<div name="usrSheet" class="sheet"></div>
				</div>
			</div>
			
			<div class="buttons">
				${sessionScope.button.a_modify} ${sessionScope.button.a_del} ${sessionScope.button.a_reg}
			</div>
		</div>
		
		<c:import  url="infSetMgmtExp.jsp"/>
		<c:import  url="infSetMgmtDoc.jsp"/>
		<c:import  url="infSetMgmtOpen.jsp"/>
		<c:import  url="infSetMgmtStat.jsp"/>
		</form>
	</div>

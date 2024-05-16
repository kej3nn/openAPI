<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<div class="content" id="sttsStatDtl" style="clear: both; display: none;">
		<form id="sttsStat-dtl-form" name="sttsStat-dtl-form" method="post" action="#" enctype="multipart/form-data">
		
		<div name="tab-inner-dtl-sect" class="tab-inner-sect">
			<input type="hidden" name="usrSheetNm"/>
			<h3 class="text-title2">통계메타 상세정보</h3>
			<table class="list01" style="position: relative;">
				<caption>통계메타 상세정보</caption>
				<colgroup>
					<col width="150" />
					<col width="" />
					<col width="150" />
					<col width="" />
				</colgroup>
				<tr>
					<th>통계구분 <span>*</span></th>
					<td colspan="3">
						<select id="sttsCd" name="sttsCd" style="width : 180px">
						</select>
					</td>
				</tr>
				<tr>
					<th>통계메타 ID <span>*</span></th>
					<td colspan="3">
						<input type="text" id="statId" name="statId" size="30" readonly="readonly" class="readonly"  placeholder="ID 자동생성" />
						<button type="button" class="btn01G" id="statMeta_pop" name="statMeta_pop" style="float: right; display: none;">통계설명(팝업)</button>
					</td>
				</tr>
				<tr>
					<th>통계메타 명 <span>*</span></th>
					<td colspan="3">
						<input type="text" id="statNm" name="statNm" size="40" placeholder="(한글)입력하세요." />
						<input type="text" id="engStatNm" name="engStatNm" size="40" placeholder="(영문)입력하세요." />
					</td>
				</tr>
				<tr>
					<th>사용여부</th>
					<td colspan="3">
						<input type="hidden" id="openStateCnt" name="openStateCnt" value=""/>
						<input type="radio" id="useYnY" name="useYn" size="30" value="Y" checked="checked" /><label for="useYnY">사용</label>&nbsp;&nbsp;
						<input type="radio" id="useYnN" name="useYn" size="30" value="N"/><label for="useYnN">미사용</label>
					</td>
				</tr>
			</table>
			
			<div name="metatyTb-sect">
			</div>
			
			<!-- ibsheet 영역 -->
			<div name="usrSheet-sect" style="width: 100%; float: left; display: none;">
				<div class="ibsheet-header">
					<h3 class="text-title2">담당자정보</h3>
					<button type="button" class="btn01" name="usrAdd" style="float: right">추가</button>
				</div>
				<div style="clear: both;"></div>
				<div class="ibsheet_area_both">
					<div name="statUsrSheet" class="sheet"></div>
				</div>
			</div>
			
			<div class="buttons">
				${sessionScope.button.a_reg}
				${sessionScope.button.a_modify}
				${sessionScope.button.a_del}
			</div>
		</div>
		
		</form>
	</div>

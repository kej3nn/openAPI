<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<div class="content" id="statMajorDtl" style="clear: both; display: none;">
		<form id="sttsMajor-dtl-form" name="sttsMajor-dtl-form" method="post" action="#">
		
		<div name="tab-inner-dtl-sect" class="tab-inner-sect">
			<h3 class="text-title2">주요통계지표 상세정보</h3>
			<table class="list01" style="position: relative;">
				<caption>주요통계지표 상세정보</caption>
				<colgroup>
					<col width="150" />
					<col width="" />
					<col width="150" />
					<col width="" />
				</colgroup>
				<tr>
					<th>주요통계 ID <span>*</span></th>
					<td colspan="3">
						<input type="text" id="majorId" name="majorId" size="30" readonly="readonly" class="readonly"  placeholder="ID 자동생성" />
					</td>
				</tr>
				<tr>
					<th>주요통계 명 <span>*</span></th>
					<td colspan="3">
						<input type="text" id="majorNm" name="majorNm" size="50" placeholder="(한글)입력하세요." />
						<input type="text" id="engMajorNm" name="engMajorNm" size="50" placeholder="(영문)입력하세요." />
					</td>
				</tr>
				<tr>
					<th>주요통계그룹 <span>*</span></th>
					<td colspan="3">
						<select id="majorStatCd" name="majorStatCd" style="width : 180px">
						</select>
					</td>
				</tr>
				<tr>
					<th>통계표 <span>*</span></th>
					<td colspan="3">
						<input type="text" id="statblId" name="statblId" size="20" readonly="readonly" />
						<input type="text" id="statblNm" name="statblNm" size="30" placeholder="선택하세요." readonly="readonly" />
						<button type="button" class="btn01" id="statbl_pop" name="statbl_pop">검색</button>&nbsp;
						<button type="button" class="btn01G" id="statPreview_pop" name="statPreview_pop">▤통계표(팝업)▤</button>
					</td>
				</tr>
				<tr>
					<th>통계값(직접입력)</th>
					<td colspan="3">
						<input type="text" id="dtaVal" name="dtaVal" size="30" placeholder="(한글)입력하세요." />
						<input type="text" id="engDtaVal" name="engDtaVal" size="30" placeholder="(영문)입력하세요." />
						- 직접입력 값이 없으면 아래 해당 통계값이 노출됩니다.
					</td>
				</tr>
				<tr>
					<th>통계값 <span>*</span></th>
					<td colspan="3">
						<select id="" name="dtacycleCd" style="width : 180px">
						</select>
						<select id="grpDatano" name="grpDatano" style="width : 200px">
						</select>
						<select id="clsDatano" name="clsDatano" style="width : 200px">
						</select>
						<select id="itmDatano" name="itmDatano" style="width : 200px">
						</select>
						<select id="dtadvsCd" name="dtadvsCd" style="width : 180px">
						</select>
						<!-- <input type="hidden" id="preGrpCd" name="preGrpCd" readonly="readonly" class="readonly" />
						<input type="hidden" id="preInputMaxCd" name="preInputMaxCd" readonly="readonly" class="readonly" /> -->
					</td>
				</tr>
				<tr>
					<th>원자료 이미지</th>
					<td colspan="3">
						<input type="file" id="viewFileNm" name="viewFileNm" accept="image/*" >
					</td>
				</tr>
				<tr>
					<th>증감 이미지</th>
					<td colspan="3">
						<input type="file" id="view1FileNm" name="view1FileNm" accept="image/*" >
					</td>
				</tr>
				<tr>
					<th>증감률 이미지</th>
					<td colspan="3">
						<input type="file" id="view2FileNm" name="view2FileNm" accept="image/*" >
					</td>
				</tr>
				<tr>
					<th>사용여부</th>
					<td colspan="3">
						<input type="radio" id="useYnY" name="useYn" size="30" value="Y" checked="checked"/><label for="useYnY">사용</label>&nbsp;&nbsp;
						<input type="radio" id="useYnN" name="useYn" size="30" value="N"/><label for="useYnN">미사용</label>
					</td>
				</tr>
			</table>
			
			<div class="buttons">
				${sessionScope.button.a_reg}
				${sessionScope.button.a_modify}
				${sessionScope.button.a_del}
			</div>
		</div>
		
		</form>
	</div>

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<div class="content" id="statInputDtl" style="clear: both; display: none;">
		<form id="stddUi-dtl-form" name="stddUi-dtl-form" method="post" action="#">
		
		<div name="tab-inner-dtl-sect" class="tab-inner-sect">
			<h3 class="text-title2">표준단위 상세정보</h3>
			<table class="list01" style="position: relative;">
				<caption>표준단위 상세정보</caption>
				<colgroup>
					<col width="150" />
					<col width="" />
					<col width="150" />
					<col width="" />
				</colgroup>
				<tr>
					<th>단위ID <span>*</span></th>
					<td colspan="2">
						<input type="text" id="uiId" name="uiId" size="30" readonly="readonly" class="readonly" />
						<input type="hidden" id="dupChk" name="dupChk" value="N"/>
						<button type="button" class="btn01" id="ui_dup" name="ui_dup">중복확인</button>
					</td>
					<td>※ 영문, 숫자 10자리 이내로 입력하세요</td>
				</tr>
				<tr>
					<th>단위명 <span>*</span></th>
					<td colspan="2">
						<input type="text" id="uiNm" name="uiNm" size="30" placeholder="(한글) 입력하세요" />&nbsp;
						<input type="text" id="engUiNm" name="engUiNm" size="30" placeholder="(영문) 입력하세요" />
					</td>
					<td>※ 20자 이내로 입력하세요</td>
				</tr>
				<tr>
					<th>단위그룹 <span>*</span></th>
					<td colspan="2">
						<input type="hidden" id="grpUiId" name="grpUiId" size="8" value="" readonly="readonly" />
						<input type="text" id="grpUiNm" name="grpUiNm" size="25" value=""  placeholder="학제구분 (선택하세요)" readonly="readonly" />
						<button type="button" class="btn01" id="ui_pop" name="ui_pop">검색</button>
						<button type="button" class="btn01" id="ui_init" name="ui_init">초기화</button>
					</td>
					<td>※ 단위그룹을 지정하지 않으면 단위그룹으로 저장됩니다.</td>
				</tr>
				<tr>
					<th>단위유형 <span>*</span></th>
					<td>
						<select id="uityCd" name="uityCd" style="width : 180px">
						</select>
					</td>
					<th>단위변환값 <span>*</span></th>
					<td>
						<input type="text" id="uiCvsnVal" name="uiCvsnVal" size="20" placeholder="변환값 입력하세요(숫자)" />&nbsp;
						<input type="checkbox" id="uiCvsnYn" name="uiCvsnYn" value="Y"/><label for="uiCvsnYn">단위변환</label>
						&nbsp;&nbsp;&nbsp;※ 숫자를 입력하세요
					</td>
				</tr>
				<tr>
					<th>설명</th>
					<td colspan="3">
						<textarea id="uiExp" name="uiExp" style="width: 90%;" rows="3" placeholder="200자 이내로 입력하세요"></textarea>
					</td>
				</tr>
				<tr>
					<th>출력순서</th>
					<td colspan="3">
						<input type="text" id="vOrder" name="vOrder" size="20" maxlength="4" placeholder="숫자를 입력하세요" />
					</td>
				</tr>
				<tr>
					<th>사용여부</th>

					<td colspan="2">
						<input type="radio" id="useYnY" name="useYn" size="30" value="Y" checked="checked"/><label for="useYnY">사용</label>&nbsp;&nbsp;
						<input type="radio" id="useYnN" name="useYn" size="30" value="N"/><label for="useYnN">미사용</label>
					</td>
					<td>※ 단위그룹일 경우 세부 단위가 함께 처리 됩니다.</td>
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

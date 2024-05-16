<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<div class="content" id="statInputDtl" style="clear: both; display: none;">
		<form id="stddItm-dtl-form" name="stddItm-dtl-form" method="post" action="#">
		
		<div name="tab-inner-dtl-sect" class="tab-inner-sect">
			<h3 class="text-title2">표준항목분류 상세정보</h3>
			<table class="list01" style="position: relative;">
				<caption>표준항목분류 상세정보</caption>
				<colgroup>
					<col width="150" />
					<col width="" />
					<col width="150" />
					<col width="" />
				</colgroup>
				<tr>
					<th>항목분류ID</th>
					<td colspan="3">
						<input type="text" id="itmId" name="itmId" size="30" readonly="readonly" class="readonly" placeholder="자동생성" />
					</td>
				</tr>
				<tr>
					<th>항목분류명 <span>*</span></th>
					<td colspan="2">
						<input type="text" id="itmNm" name="itmNm" size="30" placeholder="(한글) 입력하세요" />
						<input type="text" id="engItmNm" name="engItmNm" size="30" placeholder="(영문) 입력하세요" />
					</td>
					<td>※ 시트에서 항목분류명을 선택하시면 수정 및 삭제가 가능합니다.</td>
				</tr>
				<tr>
					<th>상위 항목구분 <span>*</span></th>
					<td colspan="2">
						<input type="hidden" id="parItmId" name="parItmId" size="8" value="" readonly="readonly" />
						<input type="text" id="parItmNm" name="parItmNm" size="25" value=""  placeholder="선택하세요.." readonly="readonly" />
						<button type="button" class="btn01" id="itm_pop" name="itm_pop">검색</button>
						<button type="button" class="btn01" id="itm_init" name="itm_init">초기화</button>
					</td>
					<td>※ 상위 항목분류를 지정하지 않으면 최상위 항목분류로 저장됩니다.</td>
				</tr>
				<tr>
					<th>설명</th>
					<td colspan="3">
						<div style="padding: 3px 0"><textarea id=""itmExp name="itmExp" style="width: 90%;" rows="2" placeholder="(한글)1,000자 이내로 입력하세요"></textarea></div>
						<div style="padding: 3px 0 3px 0"><textarea id="engItmExp" name="engItmExp" style="width: 90%;" rows="2" placeholder="(영문)1,000자 이내로 입력하세요"></textarea></div>
					</td>
				</tr>
				<tr>
					<th>표준위치코드</th>
					<td colspan="3">
						<input type="text" id="geoCd" name="geoCd" size="50" placeholder="표준위치코드를 입력하세요(숫자, 영문)" />
					</td>
				</tr>
				<tr>
					<th>출력순서</th>
					<td colspan="3">
						<input type="text" id="vOrder" name="vOrder" size="20" placeholder="숫자를 입력하세요" />
					</td>
				</tr>
				<tr>
					<th>사용여부</th>

					<td colspan="2">
						<input type="radio" id="useYnY" name="useYn" size="30" value="Y" checked="checked"/><label for="useYnY">사용</label>&nbsp;&nbsp;
						<input type="radio" id="useYnN" name="useYn" size="30" value="N"/><label for="useYnN">미사용</label>
					</td>
					<td>※ 상위 항목분류일 경우 하위 항목분류 모두 함께 처리 됩니다.</td>
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

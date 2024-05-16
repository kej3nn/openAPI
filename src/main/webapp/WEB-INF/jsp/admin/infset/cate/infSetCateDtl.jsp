<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<div class="content" id="infSetInputDtl" style="clear: both; display: none;">
		<form id="infSetCate-dtl-form" name="infSetCate-dtl-form" method="post" action="#">
		
		<div name="tab-inner-dtl-sect" class="tab-inner-sect">
			<h3 class="text-title2">분류 상세정보</h3>
			<table class="list01" style="position: relative;">
				<caption>분류 상세정보</caption>
				<colgroup>
					<col width="150" />
					<col width="" />
					<col width="150" />
					<col width="" />
				</colgroup>
				<tr>
					<th>분류ID <span>*</span></th>
					<td colspan="2">
						<input type="text" id="cateId" name="cateId" size="30" readonly="readonly" class="readonly"/>
						<input type="hidden" id="dupChk" name="dupChk" value="N"/>
						<button type="button" class="btn01" id="infSetCate_dup" name="infSetCate_dup">중복확인</button>
					</td>
					<td>※ 영문, 숫자 10자리 이내</td>
				</tr>
				<tr>
					<th>분류명 <span>*</span></th>
					<td colspan="3">
						<input type="text" id="cateNm" name="cateNm" size="30" placeholder="(한글) 입력하세요." />&nbsp;&nbsp;
						<input type="text" id="engCateNm" name="engCateNm" size="30" placeholder="(영문) 입력하세요." />
					</td>
				</tr>
				<tr>
					<th>상위그룹</th>
					<td colspan="2">
						<input type="hidden" id="topCateId" name="topCateId" size="8" readonly="readonly" />
						<input type="text" id="parCateId" name="parCateId" size="8" readonly="readonly" />
						<input type="text" id="parCateNm" name="parCateNm" size="25" value=""  placeholder="선택하세요." readonly="readonly" />
						<button type="button" class="btn01" id="infSetCate_pop" name="infSetCate_pop">검색</button>
						<button type="button" class="btn01" id="infSetCate_init" name="infSetCate_init">상위 초기화</button>
					</td>
					<td>※ 상위분류를 선택하지 않으면 최상위 분류로 선택됩니다</td>
				</tr>
				<tr>
					<th rowspan="2">이미지</th> 
					<td colspan="2">
						<input type="file" id="cateFile" name="cateFile" accept="image/*" >
					</td>
					<td rowspan="2">
						<img id="cateImg" alt="" src="" width="100" height="100" />
					</td>
				</tr>
				<tr>
					<td colspan="2">size : 100 * 100px</td>
				</tr>
				<tr>
					<th>사용여부</th>
					<td colspan="2">
						<input type="radio" id="useYnY" name="useYn" size="30" value="Y" checked="checked"/><label for="useYnY">사용</label>&nbsp;&nbsp;
						<input type="radio" id="useYnN" name="useYn" size="30" value="N"/><label for="useYnN">미사용</label>
					</td>
					<td>※ 상위 분류일 경우 하위분류 까지 모두 함께 처리 됩니다.</td>
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

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<div class="content" id="siteMenuInputDtl" style="clear: both; display: none;">
		<form id="siteMenu-dtl-form" name="siteMenu-dtl-form" method="post" action="#">
		
		<div name="tab-inner-dtl-sect" class="tab-inner-sect">
			<h3 class="text-title2">메뉴 상세정보</h3>
			<table class="list01" style="position: relative;">
				<caption>메뉴 상세정보</caption>
				<colgroup>
					<col width="150" />
					<col width="" />
					<col width="150" />
					<col width="" />
				</colgroup>
				<!-- <tr>
					<th>분류ID <span>*</span></th>
					<td colspan="2">
						<input type="text" id="cateId" name="cateId" size="30" readonly="readonly" class="readonly"/>
						<input type="hidden" id="dupChk" name="dupChk" value="N"/>
						<button type="button" class="btn01" id="infSetCate_dup" name="infSetCate_dup">중복확인</button>
					</td>
					<td>※ 영문, 숫자 10자리 이내</td>
				</tr> -->
				<tr>
					<th>메뉴명 <span>*</span></th>
					<td colspan="3">
						<input type="text" id="menuId" name="menuId" size="30" placeholder="자동입력됩니다." readonly="readonly" class="readonly"/>
						<input type="text" id="menuNm" name="menuNm" size="30" placeholder="입력하세요." />&nbsp;&nbsp;
					</td>
				</tr>
				<tr>
					<th>상단메뉴명 <span>*</span></th>
					<td colspan="3">
						<input type="text" id="topMenuNm" name="topMenuNm" size="30" placeholder="입력하세요." />&nbsp;&nbsp;
					</td>
				</tr>
				<tr>
					<th>메뉴경로 <span>*</span></th>
					<td colspan="3">
						<input type="text" id="menuPath" name="menuPath" size="30" placeholder="입력하세요." />&nbsp;&nbsp;
					</td>
				</tr>
				<tr>
					<th>메뉴경로 <span>*</span></th>
					<td colspan="3">
						<input type="text" id="menuUrl" name="menuUrl" size="30" placeholder="입력하세요." />&nbsp;&nbsp;
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

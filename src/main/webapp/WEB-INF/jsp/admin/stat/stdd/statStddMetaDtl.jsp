<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<div class="content" id="statInputDtl" style="clear: both; display: none;">
		<form id="stddUi-dtl-form" name="stddMeta-dtl-form" method="post" action="#">
		
		<div name="tab-inner-dtl-sect" class="tab-inner-sect">
			<h3 class="text-title2">표준메타 상세정보</h3>
			<table class="list01" style="position: relative;">
				<caption>표준메타 상세정보</caption>
				<colgroup>
					<col width="150" />
					<col width="" />
					<col width="150" />
					<col width="" />
				</colgroup>
				<input type="hidden" id="metaId" name="metaId" size="30" readonly="readonly" class="readonly" />
				<tr>
					<th>통계구분 <span>*</span></th>
					<td colspan="3">
						<select id="sttsCd" name="sttsCd" style="width : 180px">
						</select>
					</td>
				</tr>
				<tr>
					<th>메타항목명 <span>*</span></th>
					<td colspan="3">
						<input type="text" id="metaNm" name="metaNm" size="30" placeholder="(한글) 입력하세요." />&nbsp;
						<input type="text" id="engMetaNm" name="engMetaNm" size="30" placeholder="(영문) 입력하세요." />
					</td>
				</tr>
				<tr>
					<th>메타구분 <span>*</span></th>
					<td>
						<select id="metaCd" name="metaCd" style="width : 180px">
						</select>
					</td>
					<th>공개여부 <span>*</span></th>
					<td>
						<input type="radio" value="Y" name="openYn" id="openYnY" checked="checked"><label for="openYnY">예</label></input>&nbsp;&nbsp;
						<input type="radio" value="N" name="openYn" id="openYnYN"><label for="openYnYN">아니오(내부관리용)</label></input>
					</td>
				</tr>
				<tr>
					<th>입력유형 <span>*</span></th>
					<td colspan="3">
						<select id="metatyCd" name="metatyCd" style="width : 180px">
						</select>
						<select id="inputMaxCd" name="inputMaxCd" style="width : 180px">
						</select>
						<select id="grpCd" name="grpCd" style="width : 200px">
						</select>
						<input type="hidden" id="preGrpCd" name="preGrpCd" readonly="readonly" class="readonly" />
						<input type="hidden" id="preInputMaxCd" name="preInputMaxCd" readonly="readonly" class="readonly" />
						&nbsp;&nbsp;
						<input type="checkbox" value="Y" name="inputNeedYn" id="inputNeedYn"></input><label for="inputNeedYn">필수 입력</label>
					</td>
				</tr>
				
				<tr>
					<th>설명</th>
					<td colspan="3">
						<textarea id="metaExp" name="metaExp" style="width: 90%;" rows="3" placeholder="1,000자 이내로 입력하세요"></textarea>
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

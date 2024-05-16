<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="content" id="dtl-area">                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
	<h3 class="text-title2">상세정보</h3>

	<form name="adminOpenDsDtl"  method="post" action="#">
	<input type="hidden" name="sheetNm"/>
	<input type="hidden" name="tempRegValue" value="0"/>
	<table class="list01">
		<caption>데이터셋관리</caption>
		<colgroup>
			<col width="150"/>
			<col width=""/>
			<col width="150"/>
			<col width=""/>
		</colgroup>
		<tr id="initTR" style="display: none;">
			<th>초기설정방식</th>
			<td colspan="3">
				<input type="radio" name="initSet" id="initSetLoad" value="L" checked="checked"><label for="initSetLoad"> 불러오기</label></input>&nbsp;&nbsp;
				<input type="radio" name="initSet" id="initSetNew" value="C"><label for="initSetNew"> 신규생성</label></input>
			</td>
		</tr>
		<tr>
			<th><spring:message code="labal.dsId"/><span> *</span></th>
			<td colspan="3">
				<!-- <input type="hidden" name="ownerCd" /> -->
				<!-- <input type="text" name="ownerCode" class="input" readonly  style="width:90px"/> -->
				<select name="ownerCd">
					<option value="">선택</option>
					<c:forEach var="code" items="${codeMap.ownerCd}" varStatus="status">
						<option value="${code.ditcCd}">${code.ditcNm}</option>                 
					</c:forEach>  
				</select>
				<strong style="font-size:16pt;vertical-align:middle;">.</strong>
				<input type="text" name="dsId" class="input" readonly="readonly" class="readonly" style="width:220px"/>
				<input type="text" id="dupChk" name="dupChk" value="" style="display: none;" />
				<button type="button" class="btn01" name="dsSearch" style="display: none;">검색</button>
				<button type="button" class="btn01" name="btn_dsDup" style="display: none;">중복확인</button>
			</td>
		</tr>
		<tr>
			<th><spring:message code="labal.dsNm"/><span> *</span></th>
			<td colspan="3">
				<input type="text" name="dsNm"  style="width:345px" maxlength="160"/>
			</td>
		</tr>
		<tr>
			<th><spring:message code="labal.dtNm"/><span> *</span></th>
			<td colspan="3">
				<input type="hidden" name="dtId" />
				<input type="text" name="dtNm"  value="" style="width:373px" readonly class="readonly"/>
				<button type="button" class="btn01" name="dtSearch">검색</button>
			</td>
		</tr>
		<tr>
			<th>국가중점DB</th>
			<td>
				<input type="radio" name="keyDbYn" id="keyDbYnY" value="Y" class="input" ><label for="keyDbYnY"> 예</label></input>&nbsp;&nbsp;
				<input type="radio" name="keyDbYn" id="keyDbYnN" value="N" class="input" checked="checked"><label for="keyDbYnN"> 아니요</label></input>
				
			</td>
			<th>행자부표준</th>
				<td>
				<input type="radio" name="stddDsYn" id="stddDsYnY" value="Y" class="input"><label for="stddDsYnY"> 예</label></input>&nbsp;&nbsp;
				<input type="radio" name="stddDsYn" id="stddDsYnN" value="N" class="input" checked="checked"><label for="stddDsYnN"> 아니요</label></input>
			</td>
		</tr>
		<tr>
			<th>연계방식 <span>*</span></th>
			<td>
				<select name="conntyCd">
					<option value="">선택</option>         
					<c:forEach var="code" items="${codeMap.conntyCd}" varStatus="status">
						<option value="${code.ditcCd}">${code.ditcNm}</option>                 
					</c:forEach>  
				</select>&nbsp;&nbsp;
				<span id="autoAccYnSpan" style="color: #515151; vertical-align: baseline; display: none;">
					<input type="checkbox" name="autoAccYn" id="autoAccYn" value="Y" checked="checked"><label for="autoAccYn"> 데이터 자동승인</label></input>
				</span>
				&nbsp;&nbsp;&nbsp;
				<select name="lddataCd" style="display: none;">
					<option value="">선택</option>
					<c:forEach var="code" items="${codeMap.lddataCd}" varStatus="status">
						<option value="${code.ditcCd}">${code.ditcNm}</option>                 
					</c:forEach>  
				</select>
			</td>
			<th>적재주기 <span>*</span></th>
			<td>
				<select name="loadCd">
					<option value="">선택</option>         
					<c:forEach var="code" items="${codeMap.loadCd}" varStatus="status">
						<option value="${code.ditcCd}">${code.ditcNm}</option>                 
					</c:forEach>  
				</select>
			</td>
		</tr>
		<tr name="bcpTblTR">
			<th>백업테이블</th>
			<td colspan="3">
				<!-- <input type="hidden" name="backOwnerCd" /> -->
				<!-- <input type="text" name="backOwnerCode" class="input" readonly  /> -->
				<select name="bcpOwnerCd">
					<option value="">선택</option>
					<c:forEach var="code" items="${codeMap.ownerCd}" varStatus="status">
						<option value="${code.ditcCd}">${code.ditcNm}</option>                 
					</c:forEach>  
				</select>
				<strong style="font-size:16pt;vertical-align:middle;">.</strong>
				<input type="text" name="bcpDsId" class="input" readonly class="readonly" style="width:220px"/>
				<button type="button" class="btn01" name="btSearch">검색</button>&nbsp;&nbsp;
				<label>※ 백업은 별도의 정책으로 실행됩니다.</label>
			</td>
		</tr>
		<tr>
			<th>사용여부</th>
			<td colspan="3">
				<input type="radio" name="useYn" value="Y" class="input" checked="checked"/><label for="use"> 사용</label></input>&nbsp;&nbsp;
				<input type="radio" name="useYn" value="N" class="input"><label for="unuse"> 미사용</label></input>
				
			</td>
		</tr>
	</table>
	
	<!-- ibsheet 영역 -->
	<div class="ibsheet-header">				
		<h3 class="text-title2">항목정보</h3>
		<div class="header-right-btn">
			<label id="ibHeadDsColLabel">※ 컬럼유형, 길이, 고유키는 수정 할 수 없습니다.</label>
			<button type="button" class="btn01" name="dsColAdd" style="float: right" style="display: none;">컬럼추가</button>
			<button type="button" class="btn01L" name="btn_import" style="float: right">컬럼불러오기</button>&nbsp;
		</div>
	</div>
	<div style="clear: both;"></div>
	<div class="ibsheet_area_both">
		<!-- <script type="text/javascript">createIBSheet("dsColSheet", "100%", "300px");</script> -->
		<div id="dsColSheet" class="sheet"></div>
	</div>
	
	<div class="ibsheet-header">				
		<h3 class="text-title2">담당자정보</h3>
		<div class="header-right-btn">
			<button type="button" class="btn01" name="usrAdd" style="float: right">담당자 추가</button>
		</div>
	</div>
	<div style="clear: both;"></div>
	<div class="ibsheet_area_both">
		<div id="usrSheet" class="sheet"></div>
	</div>
	
	<div class="buttons" style="display: none;">
		<%-- ${sessionScope.button.a_import} --%>
		${sessionScope.button.a_init}
		${sessionScope.button.a_reg}
		${sessionScope.button.a_up}
		${sessionScope.button.a_down}
		${sessionScope.button.a_modify}
		${sessionScope.button.a_del}
		<%-- ${sessionScope.button.a_dataSample} --%>
		<%-- ${sessionScope.button.a_modify} --%>
	</div>
	</form>	
</div>
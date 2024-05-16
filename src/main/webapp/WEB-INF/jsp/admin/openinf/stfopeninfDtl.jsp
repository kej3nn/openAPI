<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<div class="content" id="naDataSiteMapDtl" style="clear: both; display: none;">
		<form id="stfopeninf-dtl-form" name="stfopeninf-dtl-form" method="post" action="#">
		
		<div name="tab-inner-dtl-sect" class="tab-inner-sect">
			<h3 class="text-title2">공공데이터 메타관리</h3>
			<table class="list01" style="position: relative;">
				<caption>공공데이터 메타관리</caption>
				<colgroup>
					<col width="150" />
					<col width="" />
					<col width="150" />
					<col width="" />
				</colgroup>
				<tr>
					<th>공공데이터명<span>*</span></th>
					<td colspan="3">
						<input type="hidden" name="infId" />
						<input type="text" name="infNm" size="60" placeholder="입력하세요"/>
						<span name=len1>
						<input type="text" name="len1" id="len1"style="width:50px; text-align:right;border: none;" value="0" readonly="">/300Byte
						</span>
						<button type="button" class="btn01G" id="statPreview_pop" name="statPreview_pop">바로가기(팝업)</button>
					</td>
					
				</tr>
				<tr>
					<th>분류체계</th>
					<td>
						<input type="text" id="cateFulLNm" name="cateFulLNm" size="25" value=""  readonly="readonly" class="readonly" />
					</td>
					<th>공개일자</th>
					<td>
						<input type="text" id="openDttm" name="openDttm" size="25" value=""  readonly="readonly" class="readonly" />
					</td>
				</tr>
				<tr>
					<th>제공기관</th>
					<td>
						<input type="text" id="orgNm" name="orgNm" size="25" value=""  readonly="readonly" class="readonly" />
					</td>
					<th>최종 수정일자</th>
					<td>
						<input type="text" id="updDttm" name="updDttm" size="25" value=""  readonly="readonly" class="readonly" />
					</td>
				</tr>
				<tr>
					<th>원본시스템</th>
					<td>
						<input type="text" id="srcExp" name="srcExp" size="25" value=""  readonly="readonly" class="readonly" />
					</td>
					<th rowspan="2">이용허락조건</th>
					<td name="changeImg" rowspan="2"></td>
				</tr>
				<tr>
					<th>공개주기</th>
					<td>
						<input type="text" id="loadNm" name="loadNm" size="25" value="" readonly="readonly" class="readonly" />
					</td>
				</tr>
				<tr>
					<th>공개시기</th>
					<td>
						<input type="text" id="dataCondDttm" name="dataCondDttm" size="25" value=""   />
						<span name=len2>
						<input type="text" name="len2" id="len2"style="width:50px; text-align:right;border: none;" value="0" readonly="">/100Byte
						</span>
					</td>
					
					<th>이용허락조건</th>
					<td><select name="cclCd">
									<option value=""><spring:message code="labal.whole" /></option>
									<c:forEach var="code" items="${codeMap.cclCd}"
										varStatus="status">
										<option value="${code.ditcCd}">${code.ditcNm}</option>
									</c:forEach>
							</select>
							<!-- <input type="hidden" name="useDeptNm"
								style="width: 30%" maxlength="160" /> <select name="aprvProcYn"
								style="width: 180px; display: none;">
									<option value="">선택</option>
									<option value="Y">승인이 필요한 자료</option>
									<option value="N">승인이 필요없는 자료</option>
							</select> -->
					</td>
				</tr>
				<tr>
					<th>검색태그</th>
					<td colspan="3">
						<input type="text" name="infTag"
								style="width: 60%;" placeholder="검색태그는 콤마(,)로 구분합니다."
								maxlength="160" />
					<span name=len3>
						<input type="text" name="len3" id="len3"style="width:50px; text-align:right;border: none;" value="0" readonly="">/1000Byte
						</span>
								<br/>
						※ 공백없이 콤마(,)로 구분하여 한글 및 숫자만 입력하세요(1000Byte 이내 최대 10건)<br/>
						※ 입력 예) 의원,정당,지역구,위원회,재선
					</td>
				</tr>
				<tr>
					<th>설   명</th> 
					<td colspan="3">
						<textarea name="infExp" style="width: 45%;" rows="5"></textarea>
						<span name="len4">
						<input type="text" name="len4" id="len4"style="width:50px; text-align:right;border: none;" value="0" readonly=""> /400Byte
						</span>
					</td>
				</tr>
			</table>
			
			<div class="buttons">
				${sessionScope.button.a_modify}
			</div>
		</div>
		
		</form>
	</div>

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<div class="content" id="statInputDtl" style="clear: both; display: none;">
		<form id="openApiLink-dtl-form" name="openApiLink-dtl-form" method="post" action="#">
		
		<div name="tab-inner-dtl-sect" class="tab-inner-sect">
			<h3 class="text-title2">API연계 상세정보</h3>
			<table class="list01" style="position: relative;">
				<caption>표준메타 상세정보</caption>
				<colgroup>
					<col width="150" />
					<col width="" />
					<col width="150" />
					<col width="" />
				</colgroup>
				<input type="hidden" id="apiSeq" name="apiSeq" size="30" readonly="readonly" class="readonly" />
				<tr>
					<th>API연계명 <span>*</span></th>
					<td colspan="3">
						<input type="text" id="apiNm" name="apiNm" size="80" placeholder="입력하세요." /> 	
					</td>
				</tr>
				<tr>
					<th>호출URL<span>*</span></th>
					<td colspan="3">
						<input type="text" id="apiUrl" name="apiUrl" size="80" placeholder="입력하세요." /> 	
					</td>
				</tr>
				<tr>
					<th>호출방식 <span>*</span></th>
					<td>
						<input type="radio" value="GET" name="transMode" id="transModeG" checked="checked"><label for="transModeG">GET</label></input>&nbsp;&nbsp;
						<input type="radio" value="POST" name="transMode" id="transModeP"><label for="transModeP">POST</label></input>
					</td>
					<th>호출인자방식</th>
					<td>
						<input type="radio" value="QSTR" name="paramMode" id="paramModeQ" checked="checked"><label for="paramModeQ">QueryString</label></input>&nbsp;&nbsp;
						<input type="radio" value="REST" name="paramMode" id="paramModeR"><label for="paramModeR">REST</label></input>
					</td>
				</tr>
				
				<tr>
					<th>호출문서유형 <span>*</span></th>
					<td>
						<input type="radio" value="XML" name="dsType" id="dsTypeX" checked="checked"><label for="dsTypeX">XML</label></input>&nbsp;&nbsp;
						<input type="radio" value="JSON" name="dsType" id="dsTypeJ"><label for="dsTypeJ">JSON</label></input>
					</td>
					<th>자료ID <span>*</span></th>
					<td>
						<input type="text" name="dataid" size="30" placeholder="DATAID" /> &nbsp;※ 사이트(API)고유ID
					</td>
				</tr>
				
			</table>
			
			<table class="list01" style="position: relative;">
				<caption>표준메타 상세정보</caption>
				<colgroup>
					<col width="150" />
					<col width="" />
					<col width="150" />
					<col width="" />
				</colgroup>
				<tr>
					<th>인증키 (명) <span>*</span></th>
					<td colspan="3">
						<input type="text" id="authKeyNm" name="authKeyNm" size="40" placeholder="authKey" /> &nbsp; = &nbsp;
						<input type="text" id="authKey" name="authKey" size="40" placeholder="입력하세요." />	
					</td>
				</tr>
				
				<tr>
					<th>페이지색인</th>
					<td colspan="3">
						<select id="pageidxTag" name="pageidxTag" style="width : 180px">
						</select>
						<input type="text" id="pageidxNm" name="pageidxNm" size="40" placeholder="pageIndex명" />
						<input type="text" id="pageidx2Nm" name="pageidx2Nm" size="40" placeholder="pageIndex명2" />
					</td>
				</tr>
				
				<tr>
					<th>페이지사이즈</th>
					<td colspan="3">
						<input type="text" id="pagesizeNm" name="pagesizeNm" size="40" placeholder="호출변수명" /> &nbsp; = &nbsp;
						<input type="text" id="pagesize" name="pagesize" size="40" placeholder="10000이하 숫자만 입력하세요." />	
					</td>
				</tr>
				<tr>
					<th>호출변수1</th>
					<td colspan="3">
						<input type="text" id="var1Nm" name="var1Nm" size="40" placeholder="페이지사이즈명" /> &nbsp; = &nbsp;
						<input type="text" id="var1Val" name="var1Val" size="40" placeholder="호출변수값" />	
					</td>
				</tr>
				<tr>
					<th>호출변수2</th>
					<td colspan="3">
						<input type="text" id="var2Nm" name="var2Nm" size="40" placeholder="페이지사이즈명" /> &nbsp; = &nbsp;
						<input type="text" id="var2Val" name="var2Val" size="40" placeholder="호출변수값" />	
					</td>
				</tr>
				<tr>
					<th>호출변수3</th>
					<td colspan="3">
						<input type="text" id="var3Nm" name="var3Nm" size="40" placeholder="페이지사이즈명" /> &nbsp; = &nbsp;
						<input type="text" id="var3Val" name="var3Val" size="40" placeholder="호출변수값" />	
					</td>
				</tr>
				<tr>
					<th>기타호출변수</th>
					<td colspan="3">
						<input type="text" id="etcVarNm" name="etcVarNm" size="80" placeholder="&로 연결하여 입력하세요." /> 	
					</td>
				</tr>
			</table>
			
			<table class="list01" style="position: relative;">
				<caption>표준메타 상세정보</caption>
				<colgroup>
					<col width="150" />
					<col width="" />
					<col width="150" />
					<col width="" />
				</colgroup>
				<tr>
					<th>출력문자집합 <span>*</span></th>
					<td colspan="3">
						<input type="text" id="charSet" name="charSet" size="40" placeholder="UTF-8" />
					</td>
				</tr>
				<tr>
					<th>출력컬럼서비스명</th>
					<td>
						<input type="text" id="oServiceNm" name="oServiceNm" size="40" placeholder="입력하세요." />
					</td>
					<th>출력컬럼개수명</th>
					<td>
						<input type="text" id="oTotNm" name="oTotNm" size="40" placeholder="입력하세요." />
					</td>
				</tr>
				<tr>
					<th>출력컬럼메세지명</th>
					<td>
						<input type="text" id="oTotMsg" name="oTotMsg" size="40" placeholder="입력하세요." />
					</td>
					<th>출력컬럼ROW명</th>
					<td>
						<input type="text" id="oRowNm" name="oRowNm" size="40" placeholder="입력하세요." />
					</td>
				</tr>
			</table>
			
			<table class="list01" style="position: relative;">
				<caption>표준메타 상세정보</caption>
				<colgroup>
					<col width="150" />
					<col width="" />
					<col width="150" />
					<col width="" />
				</colgroup>
				<tr>
					<th>대상객체구분 <span>*</span></th>
					<td>
						<input type="radio" value="O" name="objTagCd" id="objTagCdO" checked="checked"><label for="objTagCdO">공공데이터</label></input>&nbsp;&nbsp;
						<input type="radio" value="S" name="objTagCd" id="objTagCdS"><label for="objTagCdS">통계데이터</label></input>
					</td>
					<th>저장방식 <span>*</span></th>
					<td>
						<select id="dsMode" name="dsMode" style="width :180px">
						</select>
					</td>
				</tr>
				
				<tr>
					<th>저장데이터셋 <span>*</span></th>
					<td>
						<select id="ownerCd" name="ownerCd" style="width :180px">
						</select>&nbsp;.
						<input type="text" name="dsId" id="dsId" size="30" placeholder="TABLE_NAME" readonly="readonly" />
						<button type="button" class="btn01" name="dsIdSearch">검색</button>
					</td>
					<th>저장조건 </th>
					<td>
						<input type="text" name="dsPk" id="dsPk" size="60" placeholder="입력하세요." />&nbsp;※ Update 시 필수
						
					</td>
				</tr>
				
				<tr>
					<th>CallBack명</th>
					<td colspan="3">
						<input type="text" id="callbackSp" name="callbackSp" size="80" placeholder="입력하세요." />&nbsp;※ 입력 시 대상객체 필수
					</td>
				</tr>
			
				<tr name="oData" style="display:none;">
					<th>대상객체</th>
					<td colspan="3">
						<input type="text" name="owner" id="owner" size="10" readonly="readonly"/></span>&nbsp;.&nbsp;<input type="text" name="objIdO" id="objIdO" size="30" placeholder="TABLE_NAME" readonly="readonly" />
						<button type="button" class="btn01" name="objIdSearch">검색</button>
					</td>
				</tr>
				
				
				<tr name="sData" style="display:none;">
					<th>대상객체</th>
					<td>
						<input type="text" name="objIdS" id="objIdS" size="30" readonly="readonly"/>
						<button type="button" class="btn01" name="statblIdSearch">검색</button>
					</td>
					<th>소숫점자리수 </th>
					<td>
						<select id="dmpointCnt" name="dmpointCnt" style="width :180px">
							<option value="">선택</option>
						</select>&nbsp;※ 선택하지 않으면 원본 유지
					</td>
				</tr>
				
				<tr name="sData" style="display:none;">
					<th>작성주기</th>
					<td>
						<input type="text" name="wrttimeId" id="wrttimeId" size="15" placeholder=""/>&nbsp;※ 원본의 주기 명칭
					</td>
					<th>기준시계열컬럼</th>
					<td>
						<input type="text" name="wrttimeColId" id="wrttimeColId" size="15" placeholder=""/>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;기본값
						<input type="text" name="wrttimeDefVal" id="wrttimeDefVal" size="15" placeholder=""/>
					</td>
				</tr>
				
			</table>
			
			<table class="list01" style="position: relative;display:block;">
				<caption>표준메타 상세정보</caption>
				<colgroup>
					<col width="150" />
					<col width="" />
					<col width="150" />
					<col width="" />
				</colgroup>
				<tr>
					<th>실행모드 <span>*</span></th>
					<td colspan="3">
						<input type="radio" value="Y" name="runMode" id="runModeY" checked="checked"><label for="runModeY">실행</label></input>&nbsp;&nbsp;
						<input type="radio" value="P" name="runMode" id="runModeP"><label for="runModeP">일시중지</label></input>&nbsp;&nbsp;
						<input type="radio" value="N" name="runMode" id="runModeN"><label for="runModeN">사용안함</label></input>
					</td>
				</tr>
				<tr name="execTable" >
					<th>실행</th>
					<td colspan="3">
						<input type="text" id="execNm" name="execNm" size="60" placeholder="입력하세요." />
						<span name="apiSeq">연계번호</span>
						<input type="text" id="param1" name="param1" size="30" placeholder="PARAM1" />
						<input type="text" id="param2" name="param2" size="30" placeholder="PARAM2" />	
						<button type="button" class="btn02" name="btnExec">실행</button>
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

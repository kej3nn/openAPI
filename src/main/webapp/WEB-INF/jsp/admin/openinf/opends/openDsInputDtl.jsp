<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<div class="content" id="openInputDtl" style="clear: both; display: none;">
		<form id="openInput-dtl-form" name="openInput-dtl-form" method="post" action="#">
		
		<div name="tab-inner-dtl-sect" class="tab-inner-sect">
			<input type="hidden" name="inputSheetNm"/>
			<h3 class="text-title2">공공데이터 정보</h3>
			<table class="list01" style="position: relative;">
				<caption>공공데이터 기본정보</caption>
				<colgroup>
					<col width="150" />
					<col width="" />
					<col width="150" />
					<col width="" />
				</colgroup>
				<input type="hidden" name="ldlistSeq" id="ldlistSeq" />
				<input type="hidden" name="ldstateCd" id="ldstateCd" />
				<input type="hidden" name="loadCd" id="loadCd" />
				<input type="hidden" name="autoAccYn" id="autoAccYn" />
				<input type="hidden" name="prssAccCd" id="prssAccCd" />
				<tr>
					<th><label>데이터셋</label></th>
					<td>
						<input type="hidden" name="dsId" id="dsId" />
						<input type="text" name="dsNm" id="dsNm" value="" class="readonly" size="40"  readonly="readonly" />
						<input type="text" name="autoAccYnDesc" id="autoAccYnDesc" value="" readonly="readonly" class="readonly" size="30" />
					</td>
					<th>보유데이터</th>
					<td>
						<input type="text" name="dtNm" id="dtNm" value="" class="readonly" size="70" />
					</td>
				</tr>
				<tr>
					<th>담당부서</th>
					<td colspan="3">
						<input type="text" id="orgUsrNm" name="orgUsrNm" value="" readonly class="readonly" />
					</td>
				</tr>
				<tr>
					<th>입력주기</th>
					<td>
						<input type="text" id="loadNm" name="loadNm" size="30" value="" readonly class="readonly"  />
					</td>
					<th>입력마감일</th>
					<td>
						<input type="text" id="loadPlanYmd" name="loadPlanYmd" value="" size="30" readonly="readonly" class="readonly"/>
						<input type="text" id="loadDttmDesc" name="loadDttmDesc" value="" size="30" readonly="readonly" class="readonly"/>
					</td>
				</tr>
				<tr>
					<th>입력상태<span>*</span></th>
					<td colspan="3">
						<input type="text" id="ldstateNm" name="ldstateNm" size="5" value="" readonly class="readonly"  />
						<input type="text" id="loadDttm" name="loadDttm" size="20" value="" readonly="readonly" class="readonly"  />
						<input type="text" id="accDttm" name="accDttm" size="20" value="" readonly="readonly" class="readonly"  />
					</td>
				</tr>
				<tr>
					<th>파일선택<span>*</span></th>
					<td colspan="3">
						<input type="file" id="uploadExcel" name="uploadExcelFile" size="15" value="" />
						<a href='javascript:;' class='btn02' title="업로드 및 검증" name="a_verifyExcelSave" style="display: none;">업로드 및 검증</a>
						<button type="button" class="btn01L" id="formDownBtn" name="formDownBtn">양식 다운로드</button>&nbsp;
					</td>
				</tr>
			</table>
			
			<!-- ibsheet 영역 -->
			<div style="width: 100%; float: left;">
				<div class="ibsheet-header">
					<h3 class="text-title2">공공데이터</h3>
					<span style="display: none; float: right; font-weight: bold;" name="verifyYnTxt">※ 오류 ( <label name="verifyErrCnt" style="color: red;"></label>건의 오류가 있습니다)</span>
				</div>
				<div style="clear: both;"></div>
				<div class="ibsheet_area_both">
					<div name="inputSheet" class="sheet"></div>
				</div>
			</div>
			
			<button type="button" class="btn01L" id="excelDownBtn" name="excelDownBtn" style="float: right; margin-bottom: 5px;">엑셀 다운로드</button>
			<table class="list01" style="position: relative;">
				<caption>공공데이터 입력 상세정보</caption>
				<colgroup>
					<col width="150" />
					<col width="" />
				</colgroup>
				<tr>
					<th>데이터기준일</th>
					<td>
						<input type="text" id="dataDttmCont" name="dataDttmCont" value="" style="width: 70%" placeholder="최종 수정 데이터의 기준정보를 별도로 표시할 경우 입력하세요"/>
					</td>
				</tr>
				<tr>
					<th>저장구분<span> *</span></th>
					<td>
						<input type="radio" id="loadTypeT" name="loadType" value="T"><label id="loadTypeT"> 삭제 후 저장</label></input>&nbsp;&nbsp;
						<input type="radio" id="loadTypeT" name="loadType" value="P" checked="checked"><label id="loadTypeT"> 추가 저장</label></input>
					</td>
				</tr>
				<tr>
					<th>지연사유</th>
					<td>
						<input type="text" id="delayCont" name="delayCont" value="" style="width: 75%" placeholder="입력 지연 시 사유를 입력하세요"/>
					</td>
				</tr>
				<tr>
					<th>메세지</th>
					<td>
						<input type="text" id="prssMsgCont" name="prssMsgCont" value="" style="width: 75%" placeholder="처리 메시지를 입력하세요"/>
					</td>
				</tr>
			</table>
			<div class="buttons">
				<a href='javascript:;' class='btn02' title="검증 및 저장" name="a_verifySave" style="display: none;">검증 및 저장</a>
				<a href='javascript:;' class='btn02' title="승인요청" name="a_reqAprov" style="display: none;">승인요청</a>
				<a href="javascript:;" class="btn03" title="승인" name="a_aprov" style="display: none;">승인</a>
				<a href="javascript:;" class="btn03" title="반려" name="a_return" style="display: none;">반려</a>
			</div>
		</div>
		
		</form>
	</div>

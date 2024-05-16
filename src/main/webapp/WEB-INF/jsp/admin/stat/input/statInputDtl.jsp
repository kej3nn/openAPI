<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<div class="content" id="statInputDtl" style="clear: both; display: none;">
		<form id="statInput-dtl-form" name="statInput-dtl-form" method="post" action="#">
		
		<div name="tab-inner-dtl-sect" class="tab-inner-sect">
			<input type="hidden" name="inputSheetNm"/>
			<input type="hidden" name="cmmtSheetNm"/>
			<h3 class="text-title2">통계표 정보</h3>
			<table class="list01" style="position: relative;">
				<caption>통계표 기본정보</caption>
				<colgroup>
					<col width="150" />
					<col width="" />
					<col width="150" />
					<col width="" />
				</colgroup>
				<input type="hidden" name="wrtSeq" id="wrtSeq" />
				<input type="hidden" name="wrtStateCd" id="wrtStateCd" />
				<input type="hidden" name="dtacycleCd" id="dtacycleCd" />
				<input type="hidden" name="wrtOrgCd" id="wrtOrgCd" />
				<!-- <input type="hidden" name="wrtOrgNm" id="wrtOrgNm" /> -->
				<input type="hidden" name="wrtUsrCd" id="wrtUsrCd" />
				<!-- <input type="hidden" name="wrtUsrNm" id="wrtUsrNm" /> -->
				<input type="hidden" name="batchYn" id="batchYn" />
				<tr>
					<th><label>통계표</label><span>*</span></th>
					<td colspan="3">
						<input type="text" name="statblNm" id="statblNm" value="" readonly class="readonly" size="70" />
						<input type="hidden" name="statblId" id="statblId" />
						<input type="text" name="statblIdDesc" id="statblIdDesc" value="" readonly class="readonly" size="30" />
						<button type="button" class="btn01L" id="statMeta_pop" name="statMeta_pop" style="float: right;">통계설명(팝업)</button>
						<button type="button" class="btn01L" id="statPreview_pop" name="statPreview_pop" style="float: right;">통계표(팝업)</button>&nbsp;
					</td>
				</tr>
				<tr>
					<th><label>분류</label></th>
					<td>
						<input type="text" name="cateFullNm" id="cateFullNm" value="" readonly class="readonly" size="70" />
					</td>
					<th><label>담당부서</label></th>
					<td>
						<input type="text" id="wrtOrgNm" name="wrtOrgNm" value="" readonly class="readonly" />
					</td>
				</tr>
				<tr>
					<th><label>자료시점(기간)</label></th>
					<td colspan="3">
						<input type="text" id="wrttimeDesc" name="wrttimeDesc" size="80" value="" readonly class="readonly"  />
						<input type="text" id="wrttimeBetw" name="wrttimeBetw" size="35" value="" readonly class="readonly" />
						<input type="hidden" id="wrttimeIdtfrId" name="wrttimeIdtfrId" size="35" value="" readonly class="readonly" />
					</td>
				</tr>
				<tr id="tblMetaInput">
					<th>입력상태<span>*</span></th>
					<td>
						<input type="text" id="wrtstateNm" name="wrtstateNm" size="5" value="" readonly class="readonly"  />
						<input type="text" id="wrtDttm" name="wrtDttm" size="20" value="" readonly class="readonly"  />
						<input type="text" id="accDttm" name="accDttm" size="20" value="" readonly class="readonly"  />
					</td>
					<th><label>입력기간</label></th>
					<td>
						<input type="text" id="wrtBetweenYmd" name="wrtBetweenYmd" value="" size="30" readonly class="readonly"/>
					</td>
				</tr>
				<tr>
					<th>파일선택<span>*</span></th>
					<td colspan="3">
						<input type="file" id="uploadExcel" name="uploadExcelFile" size="15" value="" />
						<a href='javascript:;' class='btn02' title="업로드 및 검증" name="a_verifyExcelSave" style="display: none;">업로드 및 검증</a>
						<button type="button" class="btn01L" id="formDownBtn" name="formDownBtn" style="margin-top: -4px;">양식 다운로드</button>&nbsp;
						<button type="button" class="btn01L" id="tableDownBtn" name="tableDownBtn" style="margin-top: -4px;">표 다운로드</button>
					</td>
				</tr>
			</table>
			
			<!-- ibsheet 영역 -->
			<div style="width: 100%; float: left;">
				<div class="ibsheet-header">
					<h3 class="text-title2">통계데이터</h3>
					<div class="header-right-btn">
						<div>※ 노랑색의 셀은 주석이 있는 셀 입니다.</div>
						<div name="verifyYnTxt"></div>
					</div>
				</div>
				<div style="clear: both;"></div>
				<div class="ibsheet_area_both">
					<div name="inputSheet" class="sheet"></div>
				</div>
			</div>
			
			<!-- <h3 class="text-title2" style="float: left">주석</h3> -->
			<div class="buttons" style="margin-bottom: 20px;">
				<button type="button" class="btn01L" id="statMeta_pop" name="statMark_pop">통계기호</button>
				<button type="button" class="btn01L" id="statCmmt_pop" name="statCmmt_pop">통계값 주석</button>
				<button type="button" class="btn01L" id="statDif_pop" name="statDif_pop">자료시점 주석</button>
			</div>
			<table class="list01" style="position: relative;">
				<caption>주석</caption>
				<colgroup>
					<col width="150" />
					<col width="" />
				</colgroup>
				<!-- 
				<tr>
					<th>통계표 주석</th>
					<td>
						<div style="padding: 3px 0 0 0"><label>통계표 주석 식별자 : </label><input type="text" id="sttsCmmtIdtfr" name="sttsCmmtIdtfr" size="10" value="" /></div>
						<div style="padding: 3px 0 0 0"><textarea id="sttsCmmtCont" name="sttsCmmtCont" style="width: 75%;" rows="3" placeholder="(한글)통계표 주석을 입력하세요"></textarea></textarea></div>
						<div style="padding: 3px 0 3px 0"><textarea id="engSttsCmmtCont" name="engSttsCmmtCont" style="width: 75%;" rows="3" placeholder="(영문)통계표 주석을 입력하세요"></textarea></div>
					</td>
				</tr> -->
				<tr>
					<th>메세지</th>
					<td><input type="text" id="wrtMsgCont" name="wrtMsgCont" size="60" value=""  /></td>
				</tr>
				<!-- 
				<tr>
					<th>통계값 주석</th>
					<td>
						<input type="hidden" name="cmmtCls">
						<input type="hidden" name="cmmtItm">
						<input type="hidden" name="cmmtDta">
						<div style="padding: 3px 0 0 0"><label>통계값 주석 식별자 : </label><input type="text" id="cmmtIdtfr" name="cmmtIdtfr" size="10" value="" /></div>
						<div style="padding: 3px 0 0 0"><textarea id="cmmtCont" name="cmmtCont" style="width: 75%;" rows="2" placeholder="(한글)통계값 주석을 입력하세요"></textarea></div>
						<div style="padding: 3px 0 3px 0">
							<textarea id="engCmmtCont" name="engCmmtCont" style="width: 75%;" rows="2" placeholder="(영문)통계값 주석을 입력하세요"></textarea>
							<span style="float: right;">
								<button type="button" class="btn01" name="cmmtApplyBtn">주석 반영</button>
								<button type="button" class="btn01" name="cmmtDelBtn" >주석 삭제</button> 
							</span>
						</div>
						<div name="cmmtSheet" class="sheet"></div>
					</td> 
				</tr> -->
			</table>
			
			<!-- ibsheet 영역 -->
			<!-- 
			<div style="width: 100%; float: left; ">
				<div class="ibsheet_area" style="clear: both;">
					<div name="cmmtSheet" class="sheet"></div>
				</div>
			</div> -->
			
			<div class="buttons">
				<a href='javascript:;' class='btn02' title="검증 및 저장" name="a_verifySave" style="display: none;">검증 및 저장</a>
				<a href='javascript:;' class='btn02' title="승인요청" name="a_reqAprov" style="display: none;">승인요청</a>
				<a href="javascript:;" class="btn03" title="취소요청" name="a_reqCancel" style="display: none;">취소요청</a> 
				<a href="javascript:;" class="btn03" title="승인" name="a_aprov" style="display: none;">승인</a>
				<a href="javascript:;" class="btn03" title="반려" name="a_return" style="display: none;">반려</a>
				<a href="javascript:;" class="btn03" title="취소승인" name="a_cancelAprov" style="display: none;">취소승인</a>
				<a href="javascript:;" class="btn03" title="취소반려" name="a_cancelReturn" style="display: none;">취소반려</a>
				<a href="javascript:;" class="btn03" title="입력제한" name="a_inputLimit" style="display: none;">입력제한</a>
				<a href="javascript:;" class="btn03" title="입력대기" name="a_inputWait" style="display: none;">입력대기</a>
				<button type="button" class="btn01L" id="wrtLog_pop" name="wrtLog_pop" style="margin-top: -5px;">요청기록</button>
			</div>
		</div>
		
		</form>
	</div>

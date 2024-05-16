<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<div class="content" id="statInputDtl" style="clear: both; display: none;">

		<div name="opnzHist" style="display:none;">
				<h3 class="text-title2">처리상태이력</h3>
				<table class="list01" style="position: relative;">
					<caption>처리상태이력</caption>
					<colgroup>
						<col width="150px;" />
						<col width="200px;" />
						<col width="250px;" />
						<col width="200px;" />
						<col width="" />
						
					</colgroup>
					<thead>
						<th scope="col" style="text-align:center;">번호</th>
						<th scope="col" style="text-align:center;">처리상태</th>
						<th scope="col" style="text-align:center;">처리일시</th>
						<th scope="col" style="text-align:center;">담당자ID</th>
						<th scope="col" style="text-align:center;">비고</th>
					</thead>
					<tbody id="opnzHistList">
					</tbody>
					
				</table>
			</div>
				
	<h3 class="text-title2">이의신청 접수</h3>

		<form name="detail-form" method="post" enctype="multipart/form-data">

		<input type="hidden" name="aplNo"/> 
		<input type="hidden" name="apl_no"/> 
		<input type="hidden" name="objtnSno"/> 
		<input type="hidden" name="usrId" />
		<input type="hidden" name="rcpDtm" />
		<input type="hidden" name="objtnStatCd"/>
		<input type="hidden" name="objtnDealRslt"/>
		<input type="hidden" name="objtnRgDiv"/>
		<input type="hidden" name="ins"/>
		<input type="hidden" name="dcsNtcRcvmth"/>
		<input type="hidden" name="aplEmail"/>
		<input type="hidden" name="aplDealInstcd"/>
		<input type="hidden" name="aplMblPno"/>
		<input type="hidden" name="aplPn"/>
		<input type="hidden" name="objtnDR"/>
		<input type="hidden" name="rcp_dts_no"/>		
		<input type="hidden" name="fee_rdtn_cd"/>
		<input type="hidden" name="dcsProdEtYn"/><!-- 결정기간연장여부 -->
		<input type="hidden" name="actionTy"/><!-- 처리구분 전달 -->
		<input type="hidden" name="rcpNo"/>
		<input type="hidden" name="objtnDt"/>
		<input type="hidden" name="objtnDealRsltNm"/>
		<input type="hidden" name="callVersion" />
		
		<!-- 결재권자 설정 용 디비 Select -->
		<input type="hidden" name="inst_pno"/>
		<input type="hidden" name="inst_fax_no"/>
		<input type="hidden" name="inst_chrg_dept_nm"/>
		<input type="hidden" name="inst_chrg_cent_cgp_1_nm"/>
		<input type="hidden" name="inst_chrg_cent_cgp_2_nm"/>
		<input type="hidden" name="inst_chrg_cent_cgp_3_nm"/>
		
		<div name="tab-inner-dtl-sect" class="tab-inner-sect">
				
			<div class="text-title">신청인 정보</div>
			<table class="list01" style="position: relative;">
				<caption>신청인 정보</caption>
				<colgroup>
					<col width="150" />
					<col width="" />
					<col width="150" />
					<col width="" />
				</colgroup>
				
				<tr name="comTr01" style="display:none;">
					<th scope="row">접수번호 </th>
					<td>
						
						<input maxlength="9" type="text" name="rcpDtsNo"/>
					</td>
					<th scope="row">신청일자 </th>
					<td><label name="objDt"></label></td>
				</tr>
				
				<tr name="comTr02" style="display:none;">
					<th scope="row" rowspan="2">접수번호 </th>
					<td rowspan="2"><label name="rcpDtsNo"></label></td>
					<th scope="row">신청일자 </th>
					<td><label name="objDt"></label></td>
				</tr>	
				<tr name="comTr02" style="display:none;">
					<th scope="row">접수일자 </th>
					<td><label name="rcpDt"></label></td>
				</tr>	

				<tr name="comTr03" style="display:none;">
					<th scope="row">접수번호 </th>
					<td><label name="rcpDtsNo"></label></td>
					<th scope="row">신청일자 </th>
					<td><label name="objDt"></label></td>
				</tr>	
				
				<tr>
					<th scope="row">이름 </th>
					<td>
						<label name="aplPn"></label>
					</td>
					<!-- <th scope="row">주민등록번호<br/><span class="text_s">여권,외국인등록번호</span> </th> -->
					<th scope="row">생년월일</th>
					<td>
						<label name="aplRno1"></label>
					</td>
				</tr>
				<tr>
					<th scope="row">법인명 등 대표자 </th>
					<td>
						<label name="aplCorpNm"></label>
					</td>
					<th scope="row">사업자등록번호</th>
					<td>
						<label name="aplBno"></label>
					</td>
				</tr>
				<tr>
					<th scope="row" rowspan="2">주소 </th>
					<td rowspan="2">
						<label name="aplZpno"></label><br/>
						<label name="aplAddr1"></label>&nbsp;<label name="aplAddr2">
					</td>
					<th scope="row">전화번호</th>
					<td>
						<label name="aplPno"></label>
					</td>
				</tr>
				<tr>
					<th scope="row">모사전송번호</th>
					<td>
						<label name="aplFaxNo"></label>
					</td>
				</tr>
				<tr>
					<th scope="row">전자우편 </th>
					<td>
						<label name="aplEmail"></label>
					</td>
					<th scope="row">휴대전화번호</th>
					<td>
						<label name="aplMblPno"></label>
					</td>
				</tr>				
			</table>
			
			<div class="text-title">신청내역</div>
			<div id="board"  style="border-top: 1px solid #7da9d9">
			<table class="list01" style="position: relative;">
				<caption>이의신청 접수내역</caption>
				<colgroup>
				<col style="width:70px;">
				<col style="width:80px;">
				</colgroup>
				
				<tr>
					<th colspan="2">이의신청 대상</th>
					<td colspan="3">
						<label name="clsdRmk"></label>
					</td>
				</tr>
				<tr>
					<th colspan="2">이의신청의 <br>취지 및 이유</th>
					<td colspan="3">
						<label name="objtnRson"></label>
					</td>
				</tr>
				<tr>
					<th colspan="2">통지서 수령유무</th>
					<td colspan="3">
						<label name="objtnNtcs"></label>
					</td>
				</tr>
				<tr>
					<th scope="row" colspan="2">첨부문서</th>
					<td colspan="3">
						<div name="fileArea"></div>
					</td>
				</tr>
				
				<tr>
					<th colspan="2">처리기관</th>
					<td colspan="3">
						<label name="aplDealInstNm"></label>
					</td>
				</tr>
				
				<tr name="comTr01" style="display:none;">
					<th rowspan="3">수수료</th>
					<th>감면여부</th>
					<td colspan="3">
						<label name="feeRdtnCdNm"></label>
					</td>
				</tr>
				<tr name="comTr01" style="display:none;">
					<th>감면사유</th>
					<td colspan="3">
						<label name="feeRdtnRson"></label>
					</td>
				</tr>
				<tr name="comTr01" style="display:none;">
					<th>첨부문서</th>
					<td colspan="3">
						<div name="feeFileArea"></div>
						<input type="hidden" name="fee_rdtn_attch_flnm" value=""/>
						<input type="hidden" name="fee_rdtn_attch_flph" value=""/>
					</td>
				</tr>
				
				
			</table>
			</div>

			<div class="text-title" name="comDiv24" style="display:none;">처리결과</div>
			<div style="border-top: 1px solid #7da9d9; display:none;" name="comDiv24">
			<table class="list01" style="position: relative;">
				<caption>이의신청 처리결과</caption>
				<colgroup>
				<col style="width:70px;">
				<col style="width:80px;">
				</colgroup>
				<tr name="comTr04" style="display:none;">
					<th rowspan="3">연장</th>
					<th>연장사유</th>
					<td colspan="3"><label name="dcsProdEtRson"></label></td>
				</tr>
				<tr name="comTr04" style="display:none;">
					<th>연장결정기한</th>
					<td colspan="3"><label name="dcsProdEtDt"></label></td>
				</tr>
				<tr name="comTr04" style="display:none;">
					<th>그 밖의 <br/>안내사항</th>
					<td colspan="3"><label name="dcsProdEtc"></label></td>
				</tr>
				<tr>
					<th colspan="2">이의결정 문서번호</th>
					<td colspan="3"><input type="text" name="dcs_objtn_doc_no" value="국회민원지원-"/></td>
				</tr>	
				<tr>
					<th colspan="2">이의신청 결정</th>
					<td colspan="3">
						<div name="objtnDealRsltArea"></div>
					</td>
				</tr>
				<tr>
					<th colspan="2">이의신청 내용</th>
					<td colspan="3">
						<textarea name="objtn_mod_rson" rows="10" cols="80"></textarea><br>
						<span class="byte_r"><input type="text" name="len1" style="width:30px; text-align:right;border: none;" value="0" readonly>/1000 Byte</span>
					</td>
				</tr>						
				<tr>
					<th colspan="2">결정내용</th>
					<td colspan="3">
						<textarea name="objtnAplRslt" rows="10" cols="80"></textarea><br>
						<span class="byte_r"><input type="text" name="len2" style="width:30px; text-align:right;border: none;" value="0" readonly>/4000 Byte</span>
					</td>
				</tr>
				<tr>
					<th colspan="2">결정내용 첨부파일</th>
					<td colspan="3" >
						<input type="file" name="attchfile" style="width:500px;" onkeypress="return false;" />
						<button type="button" class="btn01" name="pathDelete1" onclick="javascript:fn_pathDelete1('attchfile');">지우기</button><br>
						<div name="attchfileArea"></div>
					</td>
				</tr>				
				<tr name="dcsObjtnDocNo34" style="display:none;">
					<th rowspan="2" class="line">공개방법</th>
					<th>공개형태</th>
					<td colspan="3">						
						<div name="opbFomArea"></div>
					</td>
				</tr>
				<tr name="dcsObjtnDocNo34" style="display:none;">
					<th>교부방법</th>
					<td colspan="3">
						<div name="giveMthArea"></div>					
					</td>
				</tr>
				<tr name="dcsObjtnDocNo34" style="display:none;">
					<th colspan="2">공개일자</th>
					<td>
						<input type="text" name="opb_dtm" value="" placeholder="공개일자" size="13" /> 까지
					</td>
					<th>공개장소</th>
					<td>
						<input type="text" name="opb_plc_nm" size="30"/>
					</td>
				</tr>
				<tr name="dcsObjtnDocNo34" style="display:none;">
					<th colspan="2">수수료(A)</th>
					<td>
						<input type="text" name="fee" maxlength="6" style="width:110px" value=""/>
					</td>
					<th>우송료(B)</th>
					<td>
						<input type="text" name="zip_far" maxlength="6" style="width:110px" value="" />
					</td>
				</tr>
				<tr name="dcsObjtnDocNo34" style="display:none;">
					<th colspan="2">수수료 감면액(C)</th>
					<td>						
						<input type="text" maxlength="6" name="fee_rdtn_amt" style="width:110px"/>
						<input type="hidden" name="fee_pay_yn" size="10" value="" /> <!-- 수수료납부여부 -->
					</td>
					<th>계(A+B-C)</th>
					<td>
						<input type="text" name="fee_sum" style="width:110px"   value="" readonly/>
					</td>
				</tr>
				<tr name="dcsObjtnDocNo34" style="display:none;">
					<th colspan="2">수수료 산정 내역</th>
					<td>
						<input type="text" name="fee_est_cn" style="width:110px" value="" />
					</td>
					<th>수수료납입계좌</th>
					<td>
						<div name="feeArea"></div>
						<input type="hidden" name="fee_paid_acc_no" size="10" value="" />
					</td>
				</tr>				
			</table>
			</div>


			<div style="border-top: 1px solid #7da9d9; display:none;" name="comDiv03">
			<table class="list01" style="position: relative;">
				<caption>이의신청 처리결과</caption>
				<colgroup>
				<col style="width:70px;">
				<col style="width:80px;">
				</colgroup>
				<tr name="comTr04" style="display:none;">
					<th rowspan="3">연장</th>
					<th>연장사유</th>
					<td colspan="3"><label name="dcsProdEtRson"></label></td>
				</tr>
				<tr name="comTr04" style="display:none;">
					<th>연장결정기한</th>
					<td colspan="3"><label name="dcsProdEtDt"></label></td>
				</tr>
				<tr name="comTr04" style="display:none;">
					<th>그 밖의 <br/>안내사항</th>
					<td colspan="3"><label name="dcsProdEtc"></label></td>
				</tr>
				<tr>
					<th colspan="2">이의결정 문서번호</th>
					<td colspan="3"><label name="dcsObjtnDocNo"></label></td>
				</tr>	
				<tr>
					<th colspan="2">이의신청 결정</th>
					<td colspan="3"><label name="objtnDealRsltNm"></label></td>
				</tr>
				<tr>
					<th colspan="2">이의신청 내용</th>
					<td colspan="3"><label name="objtnModRson"></label></td>
				</tr>						
				<tr>
					<th colspan="2">결정내용</th>
					<td colspan="3"><label name="objtnAplRsltCn"></label></td>
				</tr>
				<tr>
					<th colspan="2">결정내용 첨부파일</th>
					<td colspan="3" ><div name="attchfileArea"></div></td>
				</tr>
				<tr>
					<th rowspan="2" class="line">공개방법</th>
					<th>공개형태</th>
					<td colspan="3"><label name="opbFomValNm"></label><label name="opbFomEtc"></label></td>
				</tr>
				<tr>
					<th>교부방법</th>
					<td colspan="3"><label name=giveMthNm></label><label name="giveMthEtc"></label></td>
				</tr>
				<tr>
					<th colspan="2">공개일자</th>
					<td><label name="opbDtm"></label> 까지
					</td>
					<th>공개장소</th>
					<td><label name="opbPlcNm"></label></td>
				</tr>
				<tr>
					<th colspan="2">수수료(A)</th>
					<td><label name="fee"></label></td>
					<th>우송료(B)</th>
					<td><label name="zipFar"></label></td>
				</tr>
				<tr>
					<th colspan="2">수수료 감면액(C)</th>
					<td><label name="feeRdtnAmt"></label></td>
					<th>계(A+B-C)</th>
					<td><label name=feeSum></label></td>
				</tr>
				<tr>
					<th colspan="2">수수료 산정 내역</th>
					<td><label name="feeEstCn"></label></td>
					<th>수수료납입계좌</th>
					<td>
						<div name="feeArea"></div>
					</td>
				</tr>
				<tr>
					<th colspan="2">공개결정 첨부파일</th>
					<td colspan="3">
						<label name="opbFlNm"></label>
					</td>
				</tr>
				<tr>
					<th colspan="2">특이사항</th>
					<td colspan="3"><label name="opbPsbj"></label></td>
				</tr>
			</table>
			</div>

			<div style="border-top: 1px solid #7da9d9; display:none;" name="comDiv05">
			<table class="list01" style="position: relative;">
				<caption>수수료 납부완료</caption>
				<colgroup>
				<col style="width:70px;">
				<col style="width:80px;">
				</colgroup>
				<tr>
					<th colspan="2">수수료 납부완료</th>
					<td colspan="3"><input type="checkbox" name="fee_yn" onclick="fn_FeeCheck();" class="border_none"/></td>
				</tr>
				<tr name="comTr05" style="display:none;">
					<th colspan="2"  rowspan = "2">공개결정 파일등록</th>
					<td colspan="3">
						<span class="text_require">* </span>40mb이하의 파일만 등록이 가능합니다.<br/>
						<span class="text_require">* </span>등록가능 파일(txt, hwp, doc, docx, xls, xlsx, ppt, pptx, pdf, zip, rar)<br>
						<input type="file" name="file1" onkeypress="return false;" style="width: 450px;"/>
						<button type="button" class="btn01" name="pathDelete1" onclick="javascript:fn_pathDelete1('file1');">지우기</button><br>
						<input type="file" name="file2" onkeypress="return false;" style="width: 450px;"/>
						<button type="button" class="btn01" name="pathDelete1" onclick="javascript:fn_pathDelete1('file2');">지우기</button><br>
						<input type="file" name="file3" onkeypress="return false;" style="width: 450px;"/>
						<button type="button" class="btn01" name="pathDelete1" onclick="javascript:fn_pathDelete1('file3');">지우기</button><br>
					</td>
				</tr>
				<tr name="comTr05" style="display:none;">
					<td><input type="checkbox" name="fileYn" class="border_none"/> 공개실시에 사용될 파일 없음.</td>
					<th>특이사항</th>
					<td><input type="text" name="opb_psbj" style="width:98%;"  value="" /></td>
				</tr>
			</table>
			</div>
			
			<div class="buttons">
				
				<a href="javascript:;" class="btn02" title="접수" name="btnReceipt" style="display:none;">접수</a>
				<a href="javascript:;" class="btn02" title="이의취하" name="btnCancle" style="display:none;">이의취하</a>				
				<a href="javascript:;" class="btn02" title="결정기간연장" name="btnObjtnProd" style="display:none;">결정기간연장</a>				
				<a href="javascript:;" class="btn02" title="공개실시" name="btnOpen" style="display:none;">공개실시</a>
				<a href="javascript:;" class="btn02" title="수정" name="btnSwitch" style="display:none;">수정</a>						
				<a href="javascript:;" class="btn02" title="신청서출력" name="btnObjtn">신청서출력</a>				
				<a href="javascript:;" class="btn02" title="연장통지서출력" name="btnObjtnExt" style="display:none;">연장통지서출력</a>
				<a href="javascript:;" class="btn02" title="결정통지서출력" name="btnObjtnDcs" style="display:none;">결정통지서출력</a>				
				<a href="javascript:;" class="btn02" title="저장" name="btnSave" style="display:none;">저장</a>				
				<a href="javascript:;" class="btn02" title="청구서바로가기" name="btnApplyDetail">청구서바로가기</a>				
				
			</div>
		</div>
		<iframe id="download-frame" name="download-frame"  title="다운로드 처리" height="0" style="width:100%; display:none;"></iframe>
		<textarea name="printObjtnRson" title="이의신청의 취지 및 이유(출력용)"  style="display:none;"></textarea>
		</form>
		<form name="dForm" method="post">
			<input type="hidden" name="fileName" />
			<input type="hidden" name="filePath" />
			<input type="hidden" name="apl_no" value="${opnDcsDo.apl_no }" />
		</form>		
	</div>

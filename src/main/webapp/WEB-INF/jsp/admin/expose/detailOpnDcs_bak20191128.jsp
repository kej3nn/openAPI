<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<div class="content" id="statInputDtl" style="clear: both; display: none;">

		<form name="detail-form" method="post" enctype="multipart/form-data">
		<input type="hidden" name="apl_no" value=""/>
		<input type="hidden" name="rcp_dt" value=""/>
		<input type="hidden" name="rcp_no" value=""/>
		<input type="hidden" name="apl_deal_instcd" value=""/>
		<input type="hidden" name="prgStatCd" value=""/>
		
		<!-- 결재권자 설정 용 디비 Select -->
		<input type="hidden" name="inst_pno"  value=""/>
		<input type="hidden" name="inst_fax_no" value=""/>
		<input type="hidden" name="inst_chrg_dept_nm" value=""/>
		<input type="hidden" name="inst_chrg_cent_cgp_1_nm" value=""/>
		<input type="hidden" name="inst_chrg_cent_cgp_2_nm" value=""/>
		<input type="hidden" name="inst_chrg_cent_cgp_3_nm" value=""/>

		<div name="tab-inner-dtl-sect" class="tab-inner-sect">

			<table class="list01" style="position: relative;">
				<caption>공개결정 내용등록</caption>
				<colgroup>
					<col width="150" />
					<col width="150" />
					<col width="" />
					<col width="150" />
					<col width="" />
				</colgroup>
				<tr>
					<th colspan="2" scope="row" style="background:#FFFFCC;">문서번호 </th>
					<td colspan="3">
						<div name="comWrite">
							<input type="text" style="width:300px;" name="dcs_ntcs_doc_no" value="" maxlength="25" />
						</div>
						<div name="comDetail">
							<label name="dcsNtcsDocNo"></label>
						</div>
					</td>
				</tr>
				<tr>
					<th colspan="2" scope="row">정보공개 결정 </th>
					<td colspan="3">
						<div name="comWrite">
							<input type="radio" name="opb_yn" value="0" class="border_none" onclick="fn_clsdDiv('0');" checked="checked"/>공개
							<input type="radio" name="opb_yn" value="1" class="border_none" onclick="fn_clsdDiv('1');"/>부분공개 
							<input type="radio" name="opb_yn" value="2" class="border_none" onclick="fn_clsdDiv('2');"/>비공개
							<input type="radio" name="opb_yn" value="3" class="border_none" onclick="fn_clsdDiv('3');"/>부존재 등
						</div>
						<div name="comDetail">
							<label name="opbYnNm"></label>
						</div>
					</td>
				</tr>
				<tr>
					<th colspan="2" scope="row">청구내용</th>
					<td colspan="3">
						<textarea name="apl_dts_cn" rows="10" cols="80"></textarea><br />
						<span class="byte_r"><input type="text" name="len1" style="width:30px; text-align:right;border: none;" value="0" readonly>/500 Byte</span>
					</td>
				</tr>
				<tr name="clsdDiv3">
					<th colspan="2" scope="row" name="clsdTd5"><span class="text_require">* </span>공개내용</th>
					<td colspan="3" name="clsdTd6">
						<div name="comWrite">
							<textarea name="opb_cn" rows="10" cols="80"></textarea><br />
							<span class="byte_r"><input type="text" name="len2" style="width:30px; text-align:right;border: none;" value="0" readonly>/500 Byte</span>
						</div>
						<div name="comDetail">
							<label name="opbCn"></label>
						</div>
					</td>
				</tr>
				<tr name="clsdDiv28">
					<th colspan="2" scope="row" name="clsdTd281">즉시처리 첨부</th>
					<td colspan="3" name="clsdTd282">
						<div name="comWrite">
							<span class="text_require">* </span>40mb이하의 파일만 등록이 가능합니다.<br>
							<span class="text_require">* </span>2개 이상의 파일을 등록하실경우 zip 또는 rar파일로 압축해서 등록하시기 바랍니다.<br>
							<span class="text_require">* </span>등록가능 파일(txt, hwp, doc, docx, xls, xlsx, ppt, pptx, pdf, zip, rar)<br />
							<input type="file" name="imd_file" size="50" onkeypress="return false;" />
							<button type="button" class="btn01" name="pathDelete" onclick="javascript:fn_pathDelete1('imd_file');">지우기</button><br>
							<div name="imdFileArea"></div>
						</div>
						<div name="comDetail">
							<label name="imdflNm"></label>
						</div>
					</td>
				</tr>
				<tr name="clsdDiv6">
					<th colspan="2" scope="row" name="clsdTd61"><span class="text_require">* </span>정보 부존재 등<br>정보공개청구에<br>따를 수 없는 사유</th>
					<td colspan="3" name="clsdTd62">
						<div name="comWrite">
							<textarea name="non_ext" rows="10" cols="80"></textarea><br />
							<span class="byte_r"><input type="text" name="len3" style="width:30px; text-align:right;border: none;" value="0" readonly>/500 Byte</span>
							<br>
							<input type="file" name="non_file" size="50" onkeypress="return false;" />
							<button type="button" class="btn01" name="pathDelete" onclick="javascript:fn_pathDelete1('non_file');">지우기</button><br>
							<div name="nonFileArea"></div>
						</div>
						<div name="comDetail">
							<label name="nonExt"></label><br>
							<label name="nonFlNm"></label>
						</div>
					</td>
				</tr>
				<tr name="clsdDiv1" style="display: none;">
					<th colspan="2" scope="row" name="clsdTd1" style="display: none;"><span class="text_require">* </span>비공개 (전부 또는 일부)<br> 내용 및 사유</th>
					<td colspan="3" name="clsdTd2" style="display: none;">
						<div name="comWrite">
							<input type="hidden" id="clsdCnt" name="clsdCnt" value="1"/>
							<div name="clsdArea">
								<label name="clsd1">
									비공개내용 : <input type="text" style="width:300px;" name="clsd_content" value="" maxlength="500" /> 
									비공개사유 : <input type="text" style="width:300px;" name="clsd_reason" value="" maxlength="500" />
									<button type="button" class="btn02" name="clsdAdd" onclick="javascript:fn_clsdAdd();">추가</button><br/>
								</label>
							</div>
							<br />
							<textarea name="clsd_rmk" rows="10" cols="80"></textarea><br />
							<span class="byte_r"><input type="text" name="len4" style="width:30px; text-align:right;border: none;" value="0" readonly>/500 Byte</span>
							<br />
							<input type="file" name="clsdFile" size="50" onkeypress="return false;" />
							<button type="button" class="btn01" name="pathDelete" onclick="javascript:fn_pathDelete1('clsdFile');">지우기</button><br>
							<div name="clsdFileArea"></div>
						</div>
						<div name="comDetail">
							<label name="clsdRmk"></label><br>
							<label name="clsdAttchFlNm"></label>
						</div>
					</td>
				</tr>
				<tr name="clsdDiv2" style="display: none;">
					<th colspan="2" scope="row" name="clsdTd3" style="display: none;"><span class="text_require">* </span>비공개 사유</th>
					<td colspan="3" name="clsdTd4" style="display: none;">
						<div name="comWrite">
							<select name="clsd_rson_cd">
								<option value="">비공개사유를 선택하세요</option>
							</select>
						</div>
						<div name="comDetail">
							<label name="clsdRsonNm"></label>
						</div>
					</td>
				</tr>
				<tr name="clsdDiv4">
					<th rowspan="2" scope="row" name="clsdTd7">공개방법</th>
					<th name="clsdTd8">공개형태</th>
					<td colspan="3" name="clsdTd9">
						<div name="comWrite">
							<div name="opbFomArea"></div>
						</div>
						<div name="comDetail">
							<label name="opbFomNm"></label>
						</div>
					</td>
				</tr>
				<tr name="clsdDiv5">
					<th name="clsdTd10">교부방법</th>
					<td colspan="3" name="clsdTd11">
						<div name="comWrite">
							<div name="giveMthArea"></div>
						</div>
						<div name="comDetail">
							<label name="giveMthNm"></label>
						</div>
					</td>
				</tr>
				<tr name="clsdDiv21">
					<th colspan="2" scope="row" name="clsdTd211">공개일자</th>
					<td name="clsdTd212">
						<div name="comWrite">
							<input name="opb_dtm" type="text" style="width:90px"/>
						</div>
						<div name="comDetail">
							<label name="opbDtm"></label>
						</div>						
					</td>
					<th scope="row" name="clsdTd213">공개장소</th>
					<td name="clsdTd214">
						<div name="comWrite">
							<input type="text" name="opb_plc" size="30" value=""/> 
						</div>
						<div name="comDetail">
							<label name="opbPlc"></label>
						</div>
					</td>
				</tr>
				<tr name="clsdDiv22">
					<th colspan="2" scope="row" name="clsdTd221">수수료(A)</th>
					<td name="clsdTd222">
						<div name="comWrite">
							<input type="text" name="fee" maxlength="6" style="width:110px" value=""/>
						</div>
						<div name="comDetail">
							<label name="feeVal"></label>
						</div>
					</td>
					<th scope="row" name="clsdTd223">우송료(B)</th>
					<td name="clsdTd224">
						<div name="comWrite">
							<input type="text" name="zip_far" maxlength="6" style="width:110px" value="" />
						</div>
						<div name="comDetail">
							<label name="zipFarVal"></label>
						</div>						
					</td>
				</tr>
				
				<tr name="clsdDiv23">
					<th colspan="2" scope="row" name="clsdTd231">수수료 감면액(C)</th>
					<td name="clsdTd232">
						<div name="comWrite">
							<input type="text" maxlength="6" name="fee_rdtn_amt" style="width:110px" value=""/>
							<input type="hidden" name="fee_rdtn_yn" size="10" value="" /> 
						</div>
						<div name="comDetail">
							<label name="feeRdtnAmtVal"></label>
						</div>
					</td>
					<th scope="row" name="clsdTd233">계(A+B-C)</th>
					<td name="clsdTd234">
						<div name="comWrite">
							<input type="text" name="fee_sum" style="width:110px"   value="" readonly/>
						</div>
						<div name="comDetail">
							<label name="feeSumVal"></label>
						</div>						
					</td>
				</tr>
				<tr name="clsdDiv24">
					<th colspan="2" scope="row" name="clsdTd241">수수료 산정 내역</th>
					<td name="clsdTd242">
						<div name="comWrite">
							<input type="text" name="fee_est_cn" style="width:110px" value="" /> 
						</div>
						<div name="comDetail">
							<label name="feeEstCnVal"></label>
						</div>
					</td>
					<th scope="row" name="clsdTd243">수수료납입계좌</th>
					<td name="clsdTd244">
						<div name="comWrite">
							<div name="feeArea"></div>
							<input type="hidden" name="fee_paid_acc" size="10" value="" />
						</div>
						<div name="comDetail">
							<label name="feeAreaVal"></label>
						</div>
					</td>
				</tr>
			</table>
			
			<div id="board"  style="border-top: 1px solid #7da9d9">
			<table class="list01" style="position: relative;">
				<caption>공개결정 내용등록</caption>
				<colgroup>
					<col style="width:25%;">
				</colgroup>
				
				<tr name="clsdDiv25">
					<th name="clsdTd251">제3자 의견 등록 첨부</th>
					<td name="clsdTd252">
						<div name="comWrite">
							<span class="text_require">* </span>10mb이하의 파일만 등록이 가능합니다.<br>
							<span class="text_require">* </span>2개 이상의 파일을 등록하실경우 zip 또는 rar파일로 압축해서 등록하시기 바랍니다.<br>
							<span class="text_require">* </span>등록가능 파일(txt, hwp, doc, docx, xls, xlsx, ppt, pptx, pdf, zip, rar)<br />
							<input type="file" name="file" size="50" onkeypress="return false;" />
							<button type="button" class="btn01" name="pathDelete" onclick="javascript:fn_pathDelete1('file');">지우기</button><br>
							<div name="fileArea"></div>
						</div>
						<div name="comDetail">
							<label name="thirdOpnFlnm"></label>
						</div>
					</td>
				</tr>
				<tr name="clsdDiv26">
					<th name="clsdTd261">심의회 관리 첨부</th>
					<td name="clsdTd262">
						<div name="comWrite">
							<span class="text_require">* </span>10mb이하의 파일만 등록이 가능합니다.<br>
							<span class="text_require">* </span>2개 이상의 파일을 등록하실경우 zip 또는 rar파일로 압축해서 등록하시기 바랍니다.<br>
							<span class="text_require">* </span>등록가능 파일(txt, hwp, doc, docx, xls, xlsx, ppt, pptx, pdf, zip, rar)<br />
							<input type="file" name="file1" size="50" onkeypress="return false;" />
							<button type="button" class="btn01" name="pathDelete" onclick="javascript:fn_pathDelete1('file1');">지우기</button><br>
							<div name="file1Area"></div>
						</div>
						<div name="comDetail">
							<label name="dbrtInstFlnm"></label>
						</div>
					</td>
				</tr>
				<tr name="clsdDiv27">
					<th name="clsdTd271">즉시처리</th>
					<td name="clsdTd272">
						<div name="comWrite">
							<input type="checkbox" name="imd_deal_div" value="1"/>
						</div>
						<div name="comDetail">
							<label name="imdDealDiv"></label>
						</div>
					</td>
				</tr>
				<tr name="feeYnDetail" style="display: none;"><!-- 상세화면, 즉시처리가 아닐 경우에만 노출 -->
					<th>수수료 납부완료</th>
					<td>
						<input type="checkbox" name="fee_yn" onclick="fn_FeeCheck();" class="border_none"/>
					</td>
				</tr>
			</table>
			</div>

			<div name="feeChkDetail"  style="border-top: 1px solid #7da9d9">
			<table class="list01" style="position: relative;">
				<caption>공개결정</caption>
				<colgroup>
					<col style="width:25%;">
					<col width="" />
					<col style="width:25%;">
					<col width="" />					
				</colgroup>
				
				<tr name="trFileDiv" style="display: none;">
					<th rowspan="2">공개결정 파일등록</th>
					<td colspan="3">
						<span class="text_require">* </span>40mb이하의 파일만 등록이 가능합니다.<br>
						<span class="text_require">* </span>등록가능 파일(txt, hwp, doc, docx, xls, xlsx, ppt, pptx, pdf, zip, rar)<br />
						<input type="file" name="resultFile1" onkeypress="return false;" style="width: 450px;"/>
						<button type="button" class="btn01" name="pathDelete" onclick="javascript:fn_pathDelete1('resultFile1');">지우기</button><br>
						<%-- 20140819 결정통지 파일 여러개 업로드 --%>
						<input type="file" name="resultFile2" onkeypress="return false;" style="width: 450px;"/>
						<button type="button" class="btn01" name="pathDelete" onclick="javascript:fn_pathDelete1('resultFile2');">지우기</button><br>
						<input type="file" name="resultFile3" onkeypress="return false;" style="width: 450px;"/>
						<button type="button" class="btn01" name="pathDelete" onclick="javascript:fn_pathDelete1('resultFile3');">지우기</button><br>
					</td>
				</tr>
				<tr name="trFileDiv2" style="display: none;">
					<td>
						<input type="checkbox" name="fileYn" class="border_none"/> 공개실시에 사용될 파일 없음.
					</td>
					<th>특이사항</th>
					<td>
						<input type="text" name="opb_psbj" id="opb_psbj" style="width:98%;"  maxlength="36" value="" />
					</td>
				</tr>
				
				<tr name="prgStatCd08" style="display: none;">
					<th>결정통지 첨부파일</th>
					<td colspan="3">
						<label name="opbFlNm"></label>
						
					</td>
				</tr>				
				<tr name="prgStatCd08" style="display: none;">
					<th>특이사항</th>
					<td colspan="3">
						<label name="opbPsbj"></label>
					</td>
				</tr>	
					
			</table>
			</div>
			
			<div class="buttons">
				<div name="comWrite">
					<a href="javascript:;" class="btn02" title="등록" name="btnInsert">등록</a>
					<a href="javascript:;" class="btn02" title="결정내용수정" name="btnUpdate" style="display:none;">수정</a>
				</div>
				<div name="comDetail">
					<a href="javascript:;" class="btn02" title="공개실시" name="btnOpen" style="display:none;">공개실시</a>
					<a href="javascript:;" class="btn02" title="수정" name="btnSwitch" style="display:none;">수정</a>
					<a href="javascript:;" class="btn02" title="결정통지서" name="btndcsPrint" style="display:none;">결정통지서출력</a>
					<a href="javascript:;" class="btn02" title="부존재 등 통지서" name="btnNonPrint" style="display:none;">부존재 등 통지서 출력</a>
					<a href="javascript:;" class="btn02" title="결정통지취소" name="btnCancelDcs" style="display:none;">결정통지취소</a>
					<a href="javascript:;" class="btn02" title="통지완료취소" name="btnCancelEnd" style="display:none;">통지완료취소</a>
					<a href="javascript:;" class="btn02" title="청구상세" name="btnApplyDetail">청구상세</a>
				</div>
			</div>
		</div>
		<iframe id="download-frame" name="download-frame"  title="다운로드 처리" height="0" style="width:100%; display:none;"></iframe>
		</form>
	</div>

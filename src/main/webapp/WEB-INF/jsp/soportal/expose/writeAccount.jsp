<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)writeAccount.jsp 1.0 2019/08/12                                   --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 	--%>
<%-- 정보공개 > 청구서 작성                      													--%>
<%--                                                                        	--%>
<%-- @author SoftOn                                                         	--%>
<%-- @version 1.0 2019/07/22                                                	--%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 	--%>
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- head include -->
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<style type="text/css">
/* basic */
.layer {
    position: fixed;
    width: 50%;
    left: 50%;
    margin-left: -25%;
    height: 400px;
    top: 50%;
    margin-top: -200px;    
    border: 1px solid #000;
    background-color: #ffffff;
    box-sizing: border-box;
}
@media (max-width: 600px) {
    .layer {
        width: 80%;
        margin-left: -40%;
    }
}
.hidden {
    display: none;
}

</style>
</head>
<body>

<!-- header html -->
<%@ include file="/WEB-INF/jsp/portal/sect/header.jsp" %>
<div class="container" id="container">
<!-- leftmenu -->
<%@ include file="/WEB-INF/jsp/portal/sect/lnb.jsp" %>
<!-- //leftmenu -->

<!-- contents -->
	<div class="contents" id="contents">
		<div class="contents-title-wrapper">
			<h3>청구서 작성<span class="arrow"></span></h3>
        </div>


<div class="layout_flex">
    <!-- content -->
    <div class="layout_flex_100">
		<h2 class="hide">청구서 작성</h2>
		<div class="area_h3 area_h3_AB deco_h3_3">
			<h3 class="ty_A"><strong>청구서 작성</strong></h3>
			<p>각 항목중 <span style="color:#d10000;">*</span> 표시는 <strong class="point-color02" style="vertical-align: top;">필수 입력사항</strong>입니다 정보공개 청구를 위한 청구인의 정보를 입력해 주세요.</p>
		</div>
		
		<c:set var="opnAplDo" value="${requestScope.opnAplDo}"/>
        <form id="form" name="form" method="post" enctype="multipart/form-data">
        <input type="hidden" id="portalUserCd" value="${sessionScope.portalUserCd}" title="회원CD">
		<input type="hidden" name="apl_no" value="${opnAplDo.aplNo }" title="청구번호">
		<input type="hidden" name="apl_dt" value="${opnAplDo.aplDt }" title="청구날짜">
		<input type="hidden" name="apl_deal_instcd"  value="${opnAplDo.aplDealInstCd }" title="처리기관">
			
        <fieldset>
        <legend><c:out value="${requestScope.menu.lvl2MenuPath}" /> 청구인정보</legend>
        <section>
            <h4 class="ty_A mgTm10_mq_mobile">청구인정보</h4>
            <table class="table_datail_CC w_1 bt2x width_A">
            <caption><c:out value="${requestScope.menu.lvl2MenuPath}" /> 청구인정보 : 이름,생년월일,휴대전화번호,전화번호,모사전송번호,정보통신망,주소</caption>
            <tbody>
            <tr>
                <th scope="row"><label for="name"><span class="text_require">* </span>이름</label></th>
                <td class="mh42x">
                	<em><c:out value="${requestScope.loginName }" /></em>
                </td>
                <th scope="row"><label for="regiNum"><span class="text_require">* </span>생년월일</label></th>
                <td class="mh64x">
                	<em class="mh37x"><c:out value="${requestScope.loginRno1 }" /></em>
					<input type="hidden" name="apl_ntfr_div" value="${requestScope.loginDiv }" title="로그인여부" >
                </td>
            </tr>
            <tr>
                <th scope="row"><label for="title"><span class="text_require">* </span>휴대전화번호</label></th>
                <td>
					<select name="apl_mbl_pno1" id="apl_mbl_pno1" title="휴대전화 앞자리" class="w60x" onchange="fn_numReset(this, '1');">
						<option value="010">010</option>
						<option value="011">011</option>
						<option value="016">016</option>
						<option value="017">017</option>
						<option value="018">018</option>
						<option value="019">019</option>
						<option value="000">없음</option>
					</select>
					<input type="hidden" name="p_apl_mbl_pno1" id="p_apl_mbl_pno1" value="${requestScope.mPhone1 }" title="전화번호" >
					<input type="text" id="apl_mbl_pno2" name="apl_mbl_pno2" value="${requestScope.mPhone2 }" title="휴대전화 중간자리"   maxlength="4" class="w60x" onkeydown="fn_onlyNumberChk(this)" /> - 
					<input type="text" id="apl_mbl_pno3"  name="apl_mbl_pno3" value="${requestScope.mPhone3 }" title="휴대전화 끝자리"   maxlength="4" class="w60x" onkeydown="fn_onlyNumberChk(this)" />
                </td>
                <th scope="row"><label for="title"><span class="text_require">* </span>전화번호</label></th>
                <td>
					<select name="apl_pno1" id="apl_pno1" title="전화번호 지역번호" class="w60x" onchange="fn_numReset(this, '2');">
						<option value="02">02</option>
						<option value="031">031</option>
						<option value="032">032</option>
						<option value="033">033</option>
						<option value="041">041</option>
						<option value="042">042</option>
						<option value="043">043</option>
						<option value="051">051</option>
						<option value="052">052</option>
						<option value="053">053</option>
						<option value="054">054</option>
						<option value="055">055</option>
						<option value="061">061</option>
						<option value="062">062</option>
						<option value="063">063</option>
						<option value="064">064</option>
						<option value="070">070</option>
						<option value="000">없음</option>
					</select>
					<input type="hidden" name="p_apl_pno1" id="p_apl_pno1" value="${requestScope.phone1 }" title="전화번호">
					<input type="text" id="apl_pno2" name="apl_pno2" value="${requestScope.phone2 }" title="전화번호 중간자리" class="w60x" maxlength="4" onkeydown="fn_onlyNumberChk(this)" /> - 
					<input type="text" id="apl_pno3"  name="apl_pno3" value="${requestScope.phone3 }" title="전화번호 끝자리" class="w60x" maxlength="4" onkeydown="fn_onlyNumberChk(this)" />
                </td>
            </tr>
            <tr>
                <th scope="row"><label for="title">모사전송번호</label></th>
                <td colspan="3">
					<select name="apl_fax_no1" id="apl_fax_no1" title="모사전송번호 지역번호" class="w60x" onchange="fn_numReset(this, '3');">
						<option value="02">02</option>
						<option value="031">031</option>
						<option value="032">032</option>
						<option value="033">033</option>
						<option value="041">041</option>
						<option value="042">042</option>
						<option value="043">043</option>
						<option value="051">051</option>
						<option value="052">052</option>
						<option value="053">053</option>
						<option value="054">054</option>
						<option value="055">055</option>
						<option value="061">061</option>
						<option value="062">062</option>
						<option value="063">063</option>
						<option value="064">064</option>
						<option value="070">070</option>
						<option value="000">없음</option>
					</select>
					<input type="hidden" name="p_apl_fax_no1" id="p_apl_fax_no1" value="${requestScope.fax1 }" title="모사전송번호" >
					<input type="text" id="apl_fax_no2" name="apl_fax_no2" value="${requestScope.fax2 }" title="모사전송번호 중간자리" maxlength="4" class="w60x" onkeydown="fn_onlyNumberChk(this)" /> - 
					<input type="text" id="apl_fax_no3"  name="apl_fax_no3" value="${requestScope.fax3 }" title="모사전송번호 끝자리" maxlength="4" class="w60x" onkeydown="fn_onlyNumberChk(this)" />
                </td>
            </tr>
            <tr>
                <th scope="row"><label for="title">정보통신망</label></th>
                <td colspan="3">
					<input type="text" class="mw40p" name="apl_email1" id="apl_email1" value="${requestScope.email1 }" title="정보통신망 아이디 입력" style="ime-mode:inactive;" maxlength="15"  onkeydown="fn_noSChar('apl_email1');"/>@
					<input type="text" class="mw40p" name="apl_email2" id="apl_email2" value="${requestScope.email2 }" title="정보통신망도메인 입력" style="ime-mode:inactive;"  maxlength="15" onkeydown="fn_noSChar('apl_email2');" readonly="readonly"/>
					<select name="email" id="email" onchange="fn_selectEmail(this);" title="정보통신망 도메인 선택">
						<option value="" selected>선택하세요</option>
						<option value="naver.com">naver.com</option>
						<option value="daum.net">daum.net</option>
						<option value="gmail.com">gmail.com</option>
						<option value="nate.com">nate.com</option>
						<option value="korea.com">korea.com</option>
						<option value="hotmail.com">hotmail.com</option>
						<option value="chol.com">chol.com</option>
						<option value="yahoo.co.kr">yahoo.co.kr</option>
						<option value="assembly.go.kr">assembly.go.kr</option>
						<option value="1">직접입력</option>
					</select>
					<input type="hidden" name="p_email" id="p_email" value="<c:out value="${requestScope.email2 }"/>"  onkeydown="fn_noSChar('p_email');" title="정보통신망주소">
                </td>
            </tr>
            <tr>
                <th scope="row">
                	<label for="title"><span class="text_require">* </span>주소</label>
                </th>
                <td colspan="3">
					<input type="text" class="mw70x" name="apl_zpno" id="apl_zpno" value="${requestScope.post }" title="우편번호" class="input_readonly" readonly="readonly"/>
					<a title="새창열림_우편번호찾기" href="#none" class="btn_C" onclick="fn_zipcode();">우편번호찾기</a><br />
					<input type="text" name="apl_addr1" id="apl_addr1" value="${opnAplDo.apl1Addr }" class="input_readonly input_zip w100p" title="동까지 주소" readonly="readonly"/><br />
					<input type="text" name="apl_addr2" id="apl_addr2" value="${opnAplDo.apl2Addr }" title="나머지 주소" class="w100p" style="ime-mode:active;" maxlength="30"  />
                </td>
            </tr>
            </tbody>
            </table>
        </section>
        </fieldset>
            
        <fieldset>
        <legend><c:out value="${requestScope.menu.lvl2MenuPath}" /> 청구내역</legend>
        <section>
            <h4 class="ty_A mgTm10_mq_mobile">청구내역</h4>
            <table class="table_datail_CC w_2 bt2x">
            <caption><c:out value="${requestScope.menu.lvl2MenuPath}" /> 청구내역 : 청구대상기관,청구제목,청구내용,첨부문서,공개형태,수령방법,수수료 감면여부,결정통지 안내수신</caption>
            <tbody>
				<tr>
					<th><span class="text_require">* </span><label for="organ">청구대상기관</label></th>
					<td class="ty_AB">
						<c:set var="instCodeList" value="${requestScope.instCodeList}"/>
						<c:forEach var="instCodeDo" items="${instCodeList}">
							<c:choose>
							<c:when test="${opnAplDo.transCnt > 0 }">
								<input type="radio" name="apl_instcd" value="<c:out value="${instCodeDo.instCd }"/>" class="border_none" disabled="disabled" title="<c:out value="${instCodeDo.instNm }"/> " ><c:out value="${instCodeDo.instNm }" escapeXml="true"/>
							</c:when>
							<c:otherwise>
								<input type="radio" name="apl_instcd" value="<c:out value="${instCodeDo.instCd }"/>" class="border_none" title="<c:out value="${instCodeDo.instNm }"/> " ><c:out value="${instCodeDo.instNm }" escapeXml="true"/>
							</c:otherwise>
						</c:choose>
						</c:forEach>
						<input type="hidden" name="p_instCd" id="p_instCd" value="<c:out value="${opnAplDo.aplInstCd }"/>" title="기관코드">
						<button type="button" class="instInfo-open open-button">기관선택 지정 안내</button>
						<div class="instInfo-layer layer hidden">
							<h2>기관선택 지정 안내</h2>
							<a href="javascript:;" class="close" name="instInfoClose" title="닫기">닫기</a>
							<div tabindex="0">
								<span>국회 소속기관은 업무에 따라 다음과 같이 구분됩니다.</span>
								<p>
									<strong>국회사무처</strong>
									<span>국회의 회의지원, 법률안ㆍ예결산 심사 지원, 법률안 입안ㆍ제공 및 의회외교활동 지원 등 국회의원의 의정활동을 지원하고 이에 부수되는 <br/>행정사무를 처리</span>
								</p>
								<p>
									<strong>국회도서관</strong>
									<span>의정활동 및 국정심의에 필요한 정보를 수집·정리하여 국회의 입법 활동을 지원하고, 일반 국민에게 지식정보 제공</span>
								</p>
								<p>
									<strong>국회예산정책처</strong>
									<span>국가의 예산결산 · 기금 및 재정운용과 관련된 사항에 관하여 연구분석 · 평가하고 의정활동 지원</span>
								</p>
								<p>
									<strong>국회입법조사처</strong>
									<span>국회의 위원회 또는 국회의원이 요구하는 입법 및 정책관련 사항을 조사·분석하여 회답하고 관련정보 및 자료를 제공</span>
								</p>
							</div>
						 </div>
					</td>
				</tr>
				<tr>
					<th><span class="text_require">* </span><label for="apl_sj_bfmod">청구제목</label></th>
					<td class="ty_AB">
						<input type="text" name="apl_sj_bfmod" id="apl_sj_bfmod" value="<c:out value='${opnAplDo.aplSj }' escapeXml='true'/>" title="청구제목" maxlength="50" style="ime-mode:active;" class="w100p" />
					</td>
				</tr>
				<tr>
					<th><span class="text_require">* </span><label for="apl_dtscn_bfmod">청구내용</label></th>
					<td class="ty_AB">
						<textarea name="apl_dtscn_bfmod" id="apl_dtscn_bfmod" title="청구내용" onkeyup="fn_textareaLengthChk(this, 'len1', 2000)" class="w100p" style="height:200px;">${opnAplDo.aplDtsCn }</textarea><br />
						<span class="byte_r">
							<input type="text" name="len1" id="len1" style="text-align:right;" value="0" readonly="readonly" title="글자수">
							<em>/2,000 Byte</em>
						</span>
					</td>
				</tr>
				<tr>
					<th><label for="file">첨부문서</label></th>
					<td class="ty_AB">
						<ul class="ty_AB_list">
							<li>30MB이하의 파일만 등록이 가능합니다.</li>
							<li>2개 이상의 파일을 등록하실경우 zip 또는 rar파일로 압축해서 등록하시기 바랍니다.</li>
							<li>등록가능 파일(txt, hwp, doc, docx, xls, xlsx, ppt, pptx, pdf, zip, rar)</li>
						</ul>
						<input type="file" class="mw70p" name="file" id="file" title="첨부문서" onkeypress="return false;" />
						<a href="#none" class="btn_C" onclick="fn_pathDelete1('file');">지우기</a>
						<input type="hidden" name="aplLength" title="길이">
						<input type="hidden" name="apl_attch_flnm" value="<c:out value="${opnAplDo.attchFlNm }"/>" title="파일명">
						<input type="hidden" name="apl_attch_flph" value="<c:out value="${opnAplDo.attchFlPhNm }"/>" title="파일경로">
						<c:if test="${!empty opnAplDo.attchFlNm}">
						<div class="attach_file">
							<span>등록된 파일 :</span>
							<a href="javascript:;" onclick="javascript:fn_fileDown('1');">
							<c:out value="${opnAplDo.attchFlNm }" escapeXml="true"/></a>
							<div>
								<input type="checkbox" id="attachF" name="apl_attch_delete" value="Y"/>
								<label for="attachF">첨부파일삭제</label>
							</div>
						</div>
						</c:if>
					</td>
				</tr>
				<tr>
					<th><span class="text_require">* </span><label for="opentype">공개형태</label></th>
					<td class="ty_AB">
						<c:set var="commonCodeList" value="${requestScope.lclsCodeList}"/>
						<c:forEach var="commonCodeDo" items="${commonCodeList}">
							<input type="radio" name="opb_fom" value="<c:out value="${commonCodeDo.baseCd }"/>" onclick="fn_opbFomDiv();" class="border_none" title="<c:out value="${commonCodeDo.baseNm }"/>"><c:out value="${commonCodeDo.baseNm }" escapeXml="true"/>
						</c:forEach><br>
						<input type="hidden" name="p_opb_fom" id="p_opb_fom" value="<c:out value="${opnAplDo.opbFomVal }"/>" title="공개형태">
					<span id="opbFomDiv" style="display: none;">
						<input type="text" name="opb_fom_etc" maxlength="50" value="<c:out value="${opnAplDo.opbFomEtc }"/>" style="width:97%;" title="공개형태 기타 입력" >
					</span>
					</td>
				</tr>
				<tr>
					<th><span class="text_require">* </span><label for="receipt">수령방법</label></th>
					<td class="ty_AB">
						<c:set var="commonCodeList" value="${requestScope.apitCodeList}"/>
						<c:forEach var="commonCodeDo" items="${commonCodeList}">
							<input type="radio" name="apl_tak_mth" value="<c:out value="${commonCodeDo.baseCd }"/>" onclick="fn_aplTakDiv();" class="border_none" title="<c:out value="${commonCodeDo.baseNm }"/>" ><c:out value="${commonCodeDo.baseNm }" escapeXml="true"/>
						</c:forEach><br />
						<input type="hidden" name="p_apl_tak_mth" id="p_apl_tak_mth" value="<c:out value="${opnAplDo.aplTakMth }"/>" title="수령방법">
						<span id="aplTakDiv" style="display: none;">
							<input type="text" name="apl_takmth_etc" maxlength="50" value="<c:out value="${opnAplDo.aplTakMthEtc }"/>" style="width:97%;" title="수령방법 기타">
						</span>
					</td>
				</tr>
				<tr>
					<th id="feeRdtnTh" class="line"><label for="fee">수수료 감면여부</label></th>
					<td class="ty_AB">
						<c:set var="commonCodeList" value="${requestScope.feerCodeList}"/>
								<c:forEach var="commonCodeDo" items="${commonCodeList}">
										<input type="radio" name="fee_rdtn_yn" value="<c:out value="${commonCodeDo.baseCd }"/>" onclick="fn_feeRdtnDisplay('${commonCodeDo.ditcCd }');" class="border_none" title="<c:out value="${commonCodeDo.baseNm }"/>">${commonCodeDo.baseNm }
								</c:forEach>
						<input type="hidden" name="p_fee_rdtn_yn" id="p_fee_rdtn_yn" value="<c:out value="${opnAplDo.feeRdtnCd }"/>" title="수수료 감면여부 ">
						<div class="writeAcc_table" id="feeRdtnTr1" style="display:none;">
							<div>
								<strong><label for="fee_rdtn_rson">감면사유</label></strong>
								<span>
									<textarea name="fee_rdtn_rson" class="w100p" id="fee_rdtn_rson" title="수수료 감면사유" onkeyup="fn_textareaLengthChk(this, 'len2', 100)" style="height:60px;" ><c:out value="${opnAplDo.feeRdtnRson }"/></textarea><br />
									<span class="byte_r"><input type="text" name="len2" id="len2" value="0" style="text-align:right;" readonly="readonly" title="텍스트길이" ><em>/100 Byte</em></span>
									<span>공공기관의 정보공개에 관한 법률시행령 제17조 제3항 규정에 의하 여 수수료 감면대상에 해당하는 경우 기재하며, 감면사유를 증명할 수 있는 서류를 첨부하시기 바랍니다.</span>
								</span>
							</div>
							<div>
								<strong><label for="file1">첨부문서</label></strong>
								<span>
									<ul class="ty_AB_list">
										<li>10mb이하의 파일만 등록이 가능합니다.</li>
										<li>2개 이상의 파일을 등록하실경우 zip 또는 rar파일로 압축해서 등록하시기 바랍니다.</li>
										<li>등록가능 파일(txt, hwp, doc, docx, xls, xlsx, ppt, pptx, pdf, zip, rar)</li>
									</ul>
									<input type="file" name="file1" id="file1" title="수수료관련 첨부문서" onkeypress="return false;" />
									<a href="#none" class="btn_C" onclick="fn_pathDelete1('file1');">지우기</a>
									<input type="hidden" name="feeLength" title="길이">
									<input type="hidden" name="fee_rdtn_attch_flnm" value="<c:out value="${opnAplDo.feeAttchFlNm }"/>" title="파일명">
									<input type="hidden" name="fee_rdtn_attch_flph" value="<c:out value="${opnAplDo.feeAttchFlPh }"/>" title="파일경로">
									<c:if test="${!empty opnAplDo.feeAttchFlNm}">
										<div class="attach_file">
											<span>등록된 파일 :</span>
											<a href="javascript:;" onclick="javascript:fn_fileDown('2');">
											${opnAplDo.feeAttchFlNm }</a>
											<div>
												<input type="checkbox" id="attachG" name="fee_rdtn_attch_delete" value="Y"/>
												<label for="attachG">첨부파일삭제</label>
											</div>
										</div>
									</c:if>
								</span>
							</div>
						</div>
					</td>
				</tr>

				<tr>
					<th><label for="dcs_ntc_rcvmth">결정통지 안내수신</label></th>
					<td class="ty_AB mh64x">
						<div>
						<c:choose>
						<c:when test="${!empty opnAplDo.aplNo}">
							<input type="checkbox" id="dcs_ntc_rcvmth_mail" name="dcs_ntc_rcvmth_mail" value="Y" <c:if test="${empty opnAplDo.aplNo || opnAplDo.dcsNtcRcvMthMail eq 'Y'}">checked</c:if> title="결정통지 안내수신(이메일)"/>
							<label for="dcs_ntc_rcvmth_mail">이메일</label>&nbsp;&nbsp;&nbsp;
							<input type="checkbox" id="dcs_ntc_rcvmth_sms" name="dcs_ntc_rcvmth_sms" value="Y" <c:if test="${empty opnAplDo.aplNo || opnAplDo.dcsNtcRcvMthSms eq 'Y'}">checked</c:if> title="결정통지 안내수신(SMS)"/>
							<label for="dcs_ntc_rcvmth_sms">SMS</label>&nbsp;&nbsp;&nbsp;
							<input type="checkbox" id="dcs_ntc_rcvmth_talk" name="dcs_ntc_rcvmth_talk" value="Y" <c:if test="${empty opnAplDo.aplNo || opnAplDo.dcsNtcRcvMthTalk eq 'Y'}">checked</c:if> title="결정통지 안내수신(카카오알림톡)"/>
							<label for="dcs_ntc_rcvmth_talk">카카오알림톡</label>
						</c:when>
						<c:otherwise>
							<input type="checkbox" id="dcs_ntc_rcvmth_mail" name="dcs_ntc_rcvmth_mail" value="Y" title="결정통지 안내수신(이메일)"/>
							<label for="dcs_ntc_rcvmth_mail">이메일</label>&nbsp;&nbsp;&nbsp;
							<input type="checkbox" id="dcs_ntc_rcvmth_sms" name="dcs_ntc_rcvmth_sms" value="Y" title="결정통지 안내수신(SMS)"/>
							<label for="dcs_ntc_rcvmth_sms">SMS</label>&nbsp;&nbsp;&nbsp;
							<input type="checkbox" id="dcs_ntc_rcvmth_talk" name="dcs_ntc_rcvmth_talk" value="Y" title="결정통지 안내수신(카카오알림톡)"/>
							<label for="dcs_ntc_rcvmth_talk">카카오알림톡</label>
						</c:otherwise>
						</c:choose>
						</div>
					</td>
				</tr>
				
            </tbody>
            </table>
        </section>
        </fieldset>
        <div class="area_btn_A">
			<c:choose>
				<c:when test="${empty opnAplDo.aplNo}">
					
					<!-- <input type="checkbox" id="aplSaveYn" name="aplSaveYn" value="Y" > -->
				    <div>
				    	<span>※ 청구인 기본정보를 저장하시면, 다음번 청구시에 개인정보를 입력하지 않으셔도 됩니다.</span> 
					</div><br>	
						<a id="insert-button" href="#none" onclick="javascript:fn_infoInsert('I');" class="btn_A" style="background:#1961b6;">등록</a>
						<a name="aplSave" href="javascript:;"  class="btn_A">기본정보 저장</a>
				</c:when>
				<c:otherwise>
					<c:choose>
					<c:when test="${opnAplDo.transCnt > 0 }">
						<a id="insert-button" href="#none" onclick="javascript:alert('이송중인 청구건은 수정할 수 없습니다.');return false;" class="btn_A">수정</a>
					</c:when>
					<c:otherwise>
						<a id="insert-button" href="#none" onclick="javascript:fn_infoInsert('U');" class="btn_A">수정</a>
					</c:otherwise>
					</c:choose>
					<a id="insert-button" href="#none" onclick="javascript:fn_infoCancle('0');" class="btn_A">청구취하</a>
				</c:otherwise>
			</c:choose>        
            <a id="search-button" href="#none" onclick="javascript:location.href='/portal/expose/searchAccountPage.do';" class="btn_A">목록</a>
        </div>
        </form>
		<form name="dForm" method="post">
			<input type="hidden" name="fileName" title="파일명">
			<input type="hidden" name="filePath" title="파일경로">
		</form>
		<form name="uForm" method="post">
			<input type="hidden" name="apl_no" value="${opnAplDo.aplNo}" title="청구번호">
			<input type="hidden" name="apl_dt" value="${opnAplDo.aplDt}" title="청구날짜">
			<input type="hidden" name="apl_pn" value="${opnAplDo.aplPn}" title="청구제목">
			<input type="hidden" name="apl_cancle" title="취소여부">
			<input type="hidden" name="apl_deal_instcd"  value="${opnAplDo.aplInstCd }" title="이송기관">
		</form>
	</div>
	<!-- // content -->
</div>
<!-- // layout_flex #################### -->

</div></div>
<div id="loading" style="position:fixed; top:0px; left:0px; width:100%; height: 100%; z-index:9999999999; display:none;">
	<div style="position:relative; top:50%; left:50%; margin: -107px 0 0 -157px;z-index:10;"><img src="/images/dataLoading.gif" alt="loading"></div>
	<div class="bgshadow"></div>
</div>
<!-- footer -->
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
<script type="text/javascript" src="<c:url value="/js/soportal/expose/nasCommon.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/soportal/expose/writeAccount.js" />"></script>
<!-- jquery tree plugin [Dynatree] -->
<link rel="stylesheet" href="<c:url value="/js/soportal/tree/skin/ui.dynatree.css" />" type="text/css">
<script type="text/javascript" src="<c:url value="/js/soportal/tree/jquery.dynatree.js" />"></script> 
</body>
</html>
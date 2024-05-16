<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)writeObjection.jsp 1.0 2019/08/12                                   --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 	--%>
<%-- 정보공개 > 이의신청서 작성                  																												   	--%>
<%--                                                                        																						--%>
<%-- @author SoftOn                                                         								 												--%>
<%-- @version 1.0 2019/07/22                                                																			--%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 	--%>
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- head include -->
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
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
			<h3>이의신청서 작성<span class="arrow"></span></h3>
        </div>


<div class="layout_flex">
    <!-- content -->
    <div id="content" class="content">
		<h2 class="hide">이의신청서 작성</h2>
		<div class="area_h3 area_h3_AB deco_h3_3">
		<c:if test="${empty requestScope.menu.lvl3MenuPath}">
			<h3 class="ty_A"><strong>이의신청서 작성</strong></h3>
		</c:if>
		<c:if test="${!empty requestScope.menu.lvl3MenuPath}">
			<h3 class="ty_A"><strong><c:out value="${requestScope.menu.lvl3MenuPath}" /></strong></h3>
		</c:if>
			<p>각 항목중 * 표시는 <strong class="point-color02" style="vertical-align: top;">필수 입력사항</strong>입니다 이의신청을 하기 위한 신청자의 정보를 입력해 주세요.</p>
		</div>
		
        <form id="form" name="form" method="post" enctype="multipart/form-data">
		<c:set var="opnObjtnDo" value="${requestScope.opnObjtnDo }"/>
		<input type="hidden" id="dcsNtcRcvmth" name="dcsNtcRcvmth" value="${opnObjtnDo.dcsNtcRcvMthCd }"/>
		<input type="hidden" id="dcsNtcRcvmthSms" name="dcsNtcRcvmthSms" value="${opnObjtnDo.dcsNtcRcvmthSms }"/>
		<input type="hidden" id="dcsNtcRcvmthMail" name="dcsNtcRcvmthMail" value="${opnObjtnDo.dcsNtcRcvmthMail }"/>
		<input type="hidden" id="dcsNtcRcvmthTalk" name="dcsNtcRcvmthTalk" value="${opnObjtnDo.dcsNtcRcvmthTalk }"/>
		<input type="hidden" name="aplNo" id="aplNo" value="${opnObjtnDo.aplNo }"/>
		<input type="hidden" name="aplPn" id="aplPn" value="${opnObjtnDo.aplPn }"/>
		<input type="hidden" name="aplMblPno" id="aplMblPno" value="${opnObjtnDo.aplMblPno }"/>
		<input type="hidden" name="aplEmail" id="aplEmail" value="${opnObjtnDo.aplEmailAddr }">
		<input type="hidden" name="dcs_ntc_dt" id="dcs_ntc_dt" value="${opnObjtnDo.dcsNtcDt }">
		<input type="hidden" name="first_dcs_dt" id="first_dcs_dt" value="${opnObjtnDo.firstDcsDt }">
		<input type="hidden" name="apl_instcd" id="apl_instcd" value="${opnObjtnDo.aplDealInstCd }">
		<input type="hidden" name="objtnSno" id="objtnSno" value="${opnObjtnDo.objtnSno }">
			
        <fieldset>
        <legend><c:out value="${requestScope.menu.lvl2MenuPath}" /> 이의신청인 정보</legend>
        <section>
            <h4 class="ty_A mgTm10_mq_mobile">이의신청인 정보</h4>
            <table class="table_datail_AB w_1 bt2x">
            <caption><c:out value="${requestScope.menu.lvl2MenuPath}" /> 이의신청인 정보</caption>
            <tbody>
            <tr>
                <th scope="row"><label for="name">이름</label></th>
                <td><c:out value="${opnObjtnDo.aplPn }" escapeXml="true"></c:out></td>
                <th scope="row"><label for="regiNum">생년월일</label></th>
                <td><c:out value="${opnObjtnDo.aplRno1 }" escapeXml="true"></c:out></td>
            </tr>
            
            <tr>
                <th scope="row" rowspan="2"><label for="postSearch">주소</label></th>
                <td rowspan="2">
					(${opnObjtnDo.aplZpno }) <br/>
					&nbsp;<c:out value="${opnObjtnDo.apl1Addr }" escapeXml="true"></c:out>&nbsp;<c:out value="${opnObjtnDo.apl2Addr }" escapeXml="true"></c:out>
                </td>
                <th scope="row"><label for="phoneNum">전화번호</label></th>
                <td><c:out value="${opnObjtnDo.aplPno }" escapeXml="true"></c:out></td>
            </tr>
            <tr>
                <th scope="row"><label for="fax">모사전송번호</label></th>
                <td><c:out value="${opnObjtnDo.aplFaxNo }" escapeXml="true"></c:out></td>
            </tr>
            
            <tr>
                <th scope="row"><label for="mail">전자우편</label></th>
                <td><c:out value="${opnObjtnDo.aplEmailAddr }" escapeXml="true"></c:out></td>
                <th scope="row"><label for="title">휴대전화번호</label></th>
                <td><c:out value="${opnObjtnDo.aplMblPno }" escapeXml="true"></c:out></td>
            </tr>
            </tbody>
            </table>
        </section>
        </fieldset>
            
            
        <fieldset>
        <legend><c:out value="${requestScope.menu.lvl2MenuPath}" /> 이의신청 대상</legend>
        <section>
            <h4 class="ty_A mgTm10_mq_mobile">이의신청 대상</h4>
            <table class="table_datail_AB w_1 bt2x tpl0">
            <caption><c:out value="${requestScope.menu.lvl2MenuPath}" /> 이의신청 대상</caption>
            <colgroup>
            <col style="width:5%;">
            <col style="width:30%;">
            <col style="width:51%;">
            <col style="width:14%;">
            </colgroup>
            <tbody>
            <tr>
                <th scope="row" class="center"><label for="clsdNo">선택</label></th>
                <th scope="row" class="center"><label for="clsdRmk">비공개 내용</label></th>
                <th scope="row" class="center"><label for="clsdRsonCdTxt">비공개 사유</label></th>
                <th scope="row" class="center"><label for="objtnTxt">이의신청여부</label></th>
            </tr>
			<c:set var="clsdUseCnt" value="${fn:length(requestScope.clsdList)}"/>
			<c:set var="clsdList" value="${requestScope.clsdList}"/>
			<c:set var="clsdChkCnt" value="${fn:length(requestScope.clsdChkList)}"/>
			<c:set var="clsdChkList" value="${requestScope.clsdChkList}"/>
			<c:forEach var="clsdList" items="${clsdList}">
				<c:set var="clsdRsonCdTxt" value="" />
				<c:set var="objtnTxt" value="-" />
				<c:choose>
				<c:when test="${clsdList.clsdRsonCd == '01'}">
				<c:set var="clsdRsonCdTxt" value="1호 법령상의 비밀, 비공개" />
				</c:when>
				<c:when test="${clsdList.clsdRsonCd == '02'}">
				<c:set var="clsdRsonCdTxt" value="2호 국방등 국익침해" />
				</c:when>
				<c:when test="${clsdList.clsdRsonCd == '03'}">
				<c:set var="clsdRsonCdTxt" value="3호 국민의 생명등 공익침해" />
				</c:when>
				<c:when test="${clsdList.clsdRsonCd == '04'}">
				<c:set var="clsdRsonCdTxt" value="4호 재판관련 정보등" />
				</c:when>
				<c:when test="${clsdList.clsdRsonCd == '05'}">
				<c:set var="clsdRsonCdTxt" value="5호 공정한 업무수행 지장 등" />
				</c:when>
				<c:when test="${clsdList.clsdRsonCd == '06'}">
				<c:set var="clsdRsonCdTxt" value="6호 개인사생활 침해" />
				</c:when>
				<c:when test="${clsdList.clsdRsonCd == '07'}">
				<c:set var="clsdRsonCdTxt" value="7호 법인 등 영업상 비밀침해" />
				</c:when>
				<c:when test="${clsdList.clsdRsonCd == '08'}">
				<c:set var="clsdRsonCdTxt" value="8호 특정인의 이익,불이익" />
				</c:when>
				<c:otherwise>
				<c:set var="clsdRsonCdTxt" value="기타(부존재등) : ${clsdList.clsdRson}" />
				</c:otherwise>
				</c:choose>
				
				<tr>
				<c:choose>
					<c:when test="${clsdChkCnt == '0'}">
						<c:choose>
							<c:when test="${clsdList.objtnYn eq 'Y'}">
								<fmt:formatDate var="objtnTxt" value="${clsdList.objtnRegDttm}" pattern="yyyy-MM-dd"/>
								<c:set var="objtnTxt" value="${objtnTxt} 이의신청" />
								<c:set var="clsdUseCnt" value="${clsdUseCnt-1}" />
									<td></td>
							</c:when>
							<c:otherwise>
								<td class="center"><input type="checkbox" name="clsdChk" value="${clsdList.clsdNo}"></td>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<c:set var="chkYn" value="N" />
						<c:forEach var="clsdChkList" items="${clsdChkList}">
							<c:if test="${clsdList.clsdNo eq clsdChkList.clsdNo}">
								<c:set var="chkYn" value="Y" />
							</c:if>
						</c:forEach>
						<c:choose>
							<c:when test="${chkYn eq 'N'}">
								<c:choose>
									<c:when test="${clsdList.objtnYn eq 'Y'}">
										<fmt:formatDate var="objtnTxt" value="${clsdList.objtnRegDttm}" pattern="yyyy-MM-dd"/>
										<c:set var="objtnTxt" value="${objtnTxt} 이의신청" />
										<c:set var="clsdUseCnt" value="${clsdUseCnt-1}" />
											<td></td>
									</c:when>
									<c:otherwise>
										<td><input type="checkbox" name="clsdChk" value="${clsdList.clsdNo}"></td>
									</c:otherwise>
								</c:choose>							
							</c:when>
							<c:otherwise>
								<td><input type="checkbox" name="clsdChk" value="${clsdList.clsdNo}" checked></td>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
	                <td><label for="clsdRmk">${clsdList.clsdRmk}</label></td>
	                <td><label for="clsdRsonCdTxt">${clsdRsonCdTxt}</label></td>
	                <td class="center">${objtnTxt}</label></td>
	            </tr>
			</c:forEach>
            </tbody>
            </table>
        </section>
        </fieldset>
		<script>clsdData = "${requestScope.clsdList}";</script>
		<div style="display:table;width:100%;height:50px;background:#f1f3f6;border-radius:10px;margin-top:10px;">
			<div class="objec">※「공공기관의 정보공개에 관한 법률」 제18조에 따라 청구인은 공공기관의 비공개 또는 부분공개(청구내용 중 비공개 부분) 결정에 대하여 이의신청을 할 수 있으며,<br> 공개 또는 부존재 결정에 대하여는 같은 법 제19조에 따라 행정심판을 청구할 수 있습니다.</div>
		</div>
			
        <fieldset>
        <legend><c:out value="${requestScope.menu.lvl2MenuPath}" /> 이의신청 내역</legend>
        <section>
            <h4 class="ty_A mgTm10_mq_mobile">이의신청 내역</h4>
            <table class="table_datail_AB w_1 bt2x">
            <caption><c:out value="${requestScope.menu.lvl2MenuPath}" /> 이의신청 내역</caption>
            <tbody>
				<tr>
					<th><span class="text_require">* </span><label for="content1">이의신청 대상</label></th>
					<td class="ty_AB">
						<div name="clsdArea">
							<c:choose>
							<c:when test="${clsdUseCnt == '0'}">
								<font color='red'>이의신청 대상이 없습니다.(이미 비공개 목록에 대한 이의신청이 완료)</font>
							</c:when>
							<c:otherwise>
								<c:choose>
								<c:when test="${clsdChkCnt != '0'}">
									<label for="selInfo" style="display:none;">이의신청 대상을 선택하세요.</label>
								</c:when>
								<c:otherwise>
									<label for="selInfo" >이의신청 대상을 선택하세요.</label>
								</c:otherwise>
								</c:choose>

								<c:forEach var="clsdList" items="${clsdList}">
									<c:set var="clsdRsonCdTxt" value="" />
									<c:choose>
									<c:when test="${clsdList.clsdRsonCd == '01'}">
									<c:set var="clsdRsonCdTxt" value="1호 법령상의 비밀, 비공개" />
									</c:when>
									<c:when test="${clsdList.clsdRsonCd == '02'}">
									<c:set var="clsdRsonCdTxt" value="2호 국방등 국익침해" />
									</c:when>
									<c:when test="${clsdList.clsdRsonCd == '03'}">
									<c:set var="clsdRsonCdTxt" value="3호 국민의 생명등 공익침해" />
									</c:when>
									<c:when test="${clsdList.clsdRsonCd == '04'}">
									<c:set var="clsdRsonCdTxt" value="4호 재판관련 정보등" />
									</c:when>
									<c:when test="${clsdList.clsdRsonCd == '05'}">
									<c:set var="clsdRsonCdTxt" value="5호 공정한 업무수행 지장 등" />
									</c:when>
									<c:when test="${clsdList.clsdRsonCd == '06'}">
									<c:set var="clsdRsonCdTxt" value="6호 개인사생활 침해" />
									</c:when>
									<c:when test="${clsdList.clsdRsonCd == '07'}">
									<c:set var="clsdRsonCdTxt" value="7호 법인 등 영업상 비밀침해" />
									</c:when>
									<c:when test="${clsdList.clsdRsonCd == '08'}">
									<c:set var="clsdRsonCdTxt" value="8호 특정인의 이익,불이익" />
									</c:when>
									<c:otherwise>
									<c:set var="clsdRsonCdTxt" value="기타(부존재등) : ${clsdList.clsdRson}" />
									</c:otherwise>
									</c:choose>
									
									<c:set var="chkYn" value="N" />
									<c:choose>
										<c:when test="${clsdChkCnt == '0'}">	
										<div name="clsd${clsdList.clsdNo}" style="display:none;">
										</c:when>
										<c:otherwise>
											<c:forEach var="clsdChkList" items="${clsdChkList}">
												<c:if test="${clsdList.clsdNo eq clsdChkList.clsdNo}">
													<c:set var="chkYn" value="Y" />
												</c:if>
											</c:forEach>
											<c:choose>
												<c:when test="${chkYn eq 'N'}">
													<div name="clsd${clsdList.clsdNo}" style="display:none;">
												</c:when>
												<c:otherwise>
													<div name="clsd${clsdList.clsdNo}">
												</c:otherwise>
											</c:choose>
										</c:otherwise>
									</c:choose>
											<input type="hidden" name="clsd_no" value="${clsdList.clsdNo}">
								            <table class="table_datail_AB w_1 nondis">
								            <colgroup>
								            <col style="width:25%;">
								            <col style="width:75%;">
								            </colgroup>
								            <tbody>
								            <tr>
								                <th scope="row"><label for="clsd_rmk">비공개 내용</label></th>
								                <td><input type="text" name="clsd_rmk" value="${clsdList.clsdRmk}" class="readonly w100p" readonly=readonly/></td>
								            </tr>      
								            <tr>
								                <th scope="row"><label for="clsd_rson">비공개 사유</label></th>
								                <td><input type="text" name="clsd_rson" value="${clsdRsonCdTxt}" class="readonly w100p" readonly=readonly/></td>
								            </tr>
								            <tr>
								                <th scope="row"><label for="objtn_rson">이의신청의<br/>취지 및 이유</label></th>
								                <td>
								                	<textarea name="objtn_rson" rows="3" cols="10" class="w100p" style="height:70px;"><c:if test="${clsdChkCnt != '0' && chkYn eq 'Y'}"><c:out value="${clsdList.objtnRson }" escapeXml='true'></c:out></c:if></textarea><br />
								                	<span class="byte_r">
								                		<input type="text" name="len2" style="width:30px; text-align:right;" value="0" readonly>
								                		<em>/500 Byte</em>
								                	</span>
								                </td>
								            </tr>
								            </tbody>
								            </table>
										</div>
												
								</c:forEach>
							</c:otherwise>
							</c:choose>
						</div>
					</td>
				</tr>
				<%-- <tr>
					<th><span class="text_require">* </span><label for="content1">비공개 내용</label></th>
					<td class="ty_AB">
						<textarea title="이의신청의 취지 및 이유" style="height:80px;" name="opb_clsd_cn" id="opb_clsd_cn" onkeyup="fn_textareaLengthChk(this, 'len2', 500)" style="height:150px;"><c:out value="${opnObjtnDo.opbClsdCn }" escapeXml='true'></c:out></textarea>
						<span class="byte_r"><input type="text" name="len2" id="len2" style="text-align:right;" value="0" readonly>/500 Byte</span>
					</td>
				</tr> --%>
				<tr>
					<th><span class="text_require">* </span><label for="organ">통지서 수령유무</label></th>
					<td class="ty_AB">
						<input type="radio" name="ntcs_yn" value="0" class="border_none" onclick="fn_dateSet(); " <c:if test="${ opnObjtnDo.dcsNtcYn eq '0' }">checked</c:if>/>
						<label for="receipt1">정보공개(공개,부분공개,비공개) 결정통지서를 </label>
						
						<input name="dcsNtcDt" type="text" id="dcsNtcDt" size="10" value="${opnObjtnDo.dcsNtcDt }"/>
						에 받았음.	<br/>
						<input type="radio" name="ntcs_yn" value="1" class="border_none2" onclick="fn_dateSet()" <c:if test="${ opnObjtnDo.dcsNtcYn eq '1' }">checked</c:if>/>
						<label for="receipt2">정보공개(공개,부분공개,비공개) 결정통지서를 받지 못했음</label>
						&nbsp;&nbsp;<p>(법 제11조제5항의 규정에 의하여 비공개 결정이 있는것으로 보는날은 
						
						<input name="firstDcsDt" type="text" id="firstDcsDt" size="10" value="${opnObjtnDo.firstDcsDt }"/>
						임
					</td>
				</tr>
				<%-- <tr>
					<th><span class="text_require">* </span><label for="content2">이의신청의 <br />취지 및 이유</label></th>
					<td class="ty_AB">
						<label for="objtnNoti" style="color:#0000CC;">※「공공기관의 정보공개에 관한 법률」 제18조에 따라 청구인은 공공기관의 비공개 또는 부분공개<br/>(청구내용 중 비공개 부분) 결정에 대하여 이의신청을 할 수 있으며, 공개 또는 부존재 결정에 대하여는<br/>같은 법 제19조에 따라 행정심판을 청구할 수 있습니다.</label>
						<textarea title="이의신청의 취지 및 이유" style="height:80px;" name="objtn_rson" id="objtn_rson" onkeyup="fn_textareaLengthChk(this, 'len1', 500)" style="height:150px;"><c:out value="${opnObjtnDo.objtnRson }" escapeXml='true'></c:out></textarea>
						<span class="byte_r"><input type="text" name="len1" id="len1" style="text-align:right;" value="0" readonly>/500 Byte</span>
					</td>
				</tr> --%>
				<tr>
					<th><label for="file">첨부문서</label></th>
					<td class="ty_AB">
						<ul class="ty_AB_list">
							<li>30MB이하의 파일만 등록이 가능합니다.</li>
							<li>2개 이상의 파일을 등록하실경우 zip 또는 rar파일로 압축해서 등록하시기 바랍니다.</li>
							<li>등록가능 파일(txt, hwp, doc, docx, xls, xlsx, ppt, pptx, pdf, zip, rar)</li>
						</ul>
					<input type="file" name="file" id="file" size="30" title="첨부문서" style="width:80%;" onkeypress="return false;"/> 
					<a href="#none" class="btn_C" onclick="javascript:fn_pathDelete1('file');">지우기</a>
					
					<input type="hidden" name="objtnLength"/>
					<input type="hidden" name="objtn_apl_flnm" value="<c:out value='${opnObjtnDo.objtnAplFlNm }' escapeXml='true'></c:out>"/>
					<input type="hidden" name="objtn_apl_flph" value="<c:out value='${opnObjtnDo.objtnAplFlPh }' escapeXml='true'></c:out>"/>
					
					
					<c:if test="${!empty opnObjtnDo.objtnAplFlNm }">
					<div class="attach_file">
						<span>등록된 파일 :</span>
						<a href="javascript:;" onclick="javascript:fn_fileDown('3');">
						<c:out value="${opnObjtnDo.objtnAplFlNm }" escapeXml="true"/></a>
						<div>
							<input type="checkbox" id="attachF" name="objtn_attch_delete" value="Y"/>
							<label for="attachF">첨부파일삭제</label>
						</div>
					</div>
					</c:if>
					<input type="hidden" name="dcsprod_et_yn" id="dcsprod_et_yn" value="<c:out value='${opnObjtnDo.dcsproEtYn }' escapeXml='true'></c:out>"/>
					<input type="hidden" name="dcsprod_et_rson" id="dcsprod_et_rson" value="<c:out value='${opnObjtnDo.dcsprodEtRson }' escapeXml='true'></c:out>"/>
					<input type="hidden" name="dcsprod_et_prod" id="dcsprod_et_prod" value="<c:out value='${opnObjtnDo.dcsprodEtProd }' escapeXml='true'></c:out>"/>
					<input type="hidden" name="dcsprod_et_etc" id="dcsprod_et_etc" value="<c:out value='${opnObjtnDo.dcsprodEtEtc }' escapeXml='true'></c:out>"/>
					<input type="hidden" name="aplDealInstcd" id="aplDealInstcd" value="<c:out value='${opnObjtnDo.aplDealInstcd }' escapeXml='true'></c:out>"/>
					
					
					</td>
				</tr>

				
            </tbody>
            </table>
        </section>
        </fieldset>
        <div class="area_btn_A">
			<c:choose>
				<c:when test="${empty opnObjtnDo.objtnSno}">
					<a id="insert-button" href="#none" onclick="javascript:fn_submitForm('I');" class="btn_A">등록</a>
					<a id="insert-button" href="#none" onclick="javascript:location.href='/portal/expose/targetObjectionPage.do';" class="btn_A">취소</a>
				</c:when>
				<c:otherwise>
					<a id="insert-button" href="#none" onclick="javascript:fn_submitForm('U');" class="btn_A">수정</a>
					<a id="insert-button" href="#none" onclick="javascript:history.back();" class="btn_A">취소</a>
				</c:otherwise>
			</c:choose>
        </div>
        </form>
		<form name="dForm" id="dForm" method="post">
			<input type="hidden" name="fileName" id="fileName"  value=""/>
			<input type="hidden" name="filePath" id="filePath" value="" />
		</form>
	</div>
	<!-- // content -->
</div>
<!-- // layout_flex #################### -->

</div></div>

<!-- footer -->
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
<script type="text/javascript" src="<c:url value="/js/soportal/expose/nasCommon.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/soportal/expose/writeObjection.js" />"></script>
<!-- jquery tree plugin [Dynatree] -->
<link rel="stylesheet" href="<c:url value="/js/soportal/tree/skin/ui.dynatree.css" />" type="text/css">
<script type="text/javascript" src="<c:url value="/js/soportal/tree/jquery.dynatree.js" />"></script> 
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)selectObjection.jsp 1.0 2019/08/12                                   --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%pageContext.setAttribute("CR", "\r");%>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 	--%>
<%-- 정보공개 > 이의신청서 처리현황 상세      												--%>
<%--                                                                        	--%>
<%-- @author SoftOn                                                         	--%>
<%-- @version 1.0 2019/07/22                                                	--%>
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
			<h3>이의신청서 처리현황<span class="arrow"></span></h3>
        </div>


<div class="layout_flex">
    <!-- content -->
    <div id="content" class="content">
		<h2 class="hide">이의신청서 처리현황</h2>
		<div class="area_h3 area_h3_AB deco_h3_3">
			<h3 class="ty_A"><strong>이의신청서 처리현황</strong></h3>
			<p>해당 신청건에 대한 수정은 접수중일 경우에만 가능하고, 통지완료가 되기 전에는 해당 신청건에 대한 <strong class="point-color02" style="vertical-align: top;">이의취하</strong>가 가능합니다.</p>
		</div>
        <form id="objtnForm" name="objtnForm" method="post" enctype="multipart/form-data">
			<c:set var="opnObjtnDo" value="${requestScope.opnObjtnDo }" />
			<c:set var="opnObjtnHist" value="${requestScope.opnObjtnHist }" />
			<input type="hidden" name="apl_no" id="apl_no" value="${opnObjtnDo.aplNo }"/>
			<input type="hidden" name="aplNo" id="aplNo" value="${opnObjtnDo.aplNo }" />
			<input type="hidden" name="apl_dt" id="apl_dt" value="${opnObjtnDo.aplDt }" />
			<input type="hidden" name="objtnSno" id="objtnSno" value="${opnObjtnDo.objtnSno }" /> 
			<input type="hidden" name="mrdParam" id="mrdParam"/>
			<input type="hidden" name="rcp_no" id="rcp_no" value="${opnObjtnDo.rcpNo }" /> 
			<input type="hidden" name="objtn_stat_cd" id="objtn_stat_cd " value="${opnObjtnDo.objtnStatCd }" />
			<input type="hidden" name="aplPn" id="aplPn" value="${opnObjtnDo.aplPn	}" />
			<input type="hidden" name="aplDealInstcd" id="aplDealInstcd" value="${opnObjtnDo.aplDealInstCd }"/>
			<input type="hidden" name="dcsNtcRcvmth" id="dcsNtcRcvmth" value="${opnObjtnDo.dcsNtcRcvmth }"/>
			<input type="hidden" name="aplMblPno" id="aplMblPno" value="${opnObjtnDo.aplMblPno }"/>
			<input type="hidden" name="aplEmail" id="aplEmail" value="${opnObjtnDo.aplEmail }"/>
			
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
                <th scope="row" rowspan="2"><label for="postSearch">주소(소재지)</label></th>
                <td rowspan="2">
					(<c:out value="${opnObjtnDo.aplZpno }" escapeXml="true"></c:out>)<br />
								<c:out value="${opnObjtnDo.apl1Addr }" escapeXml="true"></c:out>&nbsp;&nbsp;<c:out value="${opnObjtnDo.apl2Addr }" escapeXml="true"></c:out>
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
        <legend><c:out value="${requestScope.menu.lvl2MenuPath}" /> 이의신청 내역</legend>
        <section>
            <h4 class="ty_A mgTm10_mq_mobile">이의신청 내역</h4>
            <table class="table_datail_AB w_1 bt2x">
            <caption><c:out value="${requestScope.menu.lvl2MenuPath}" /> 이의신청 내역</caption>
            <tbody>
				<tr>
					<th><label for="content1">이의신청 대상</label></th>
					<td class="ty_AB">
						<c:choose>
							<c:when test="${opnObjtnDo.callVersion eq 'V1' }">
								${fn:replace(opnObjtnDo.clsdRmk, CR, "<br>")}
							</c:when>
							<c:otherwise>
								${fn:replace(opnObjtnDo.newClsdRmk, CR, "<br>")}
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th><label for="content1">이의신청의 취지 및 이유</label></th>
					<td class="ty_AB">
						<c:choose>
							<c:when test="${opnObjtnDo.callVersion eq 'V1' }">
								${fn:replace(opnObjtnDo.objtnRson, CR, "<br>")}
							</c:when>
							<c:otherwise>
								${fn:replace(opnObjtnDo.newObjtnRson, CR, "<br>")}
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th><label for="organ">통지서 수령유무</label></th>
					<td class="ty_AB">
						<c:choose>
							<c:when test="${opnObjtnDo.objtnNtcsYn eq '0'}">
								정보(공개,부분공개,비공개) 결정통지서를 ${opnObjtnDo.dcsNtcDt }에 받았음
							</c:when>
							<c:otherwise>
								정보(공개,부분공개,비공개) 결정통지서를 받지못했음 <br/>
							 	(법 제11조제5항의 규정에 의하여 비공개 결정이 있는 것으로 보는날은 ${opnObjtnDo.dcsNtcDt } 임.
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th><label for="file">첨부문서</label></th>
					<td class="ty_AB">
						<c:if test="${!empty opnObjtnDo.objtnAplFlNm }">
							<a href="#" onclick="javascript:fn_objFileDownload('objtn_apl_flnm')"><img src="../../images/soportal/expose/icon/icon_file.gif"><c:out value="${opnObjtnDo.objtnAplFlNm }" escapeXml="true"></c:out></a>
							<input type="hidden" name="objtn_apl_flnm" id="objtn_apl_flnm" value="<c:out value='${opnObjtnDo.objtnAplFlNm }' escapeXml='true'></c:out>"/>
							<input type="hidden" name="objtn_apl_flph" id="objtn_apl_flph" value="<c:out value='${opnObjtnDo.objtnAplFlPh }' escapeXml='true'></c:out>"/>
						</c:if> 
					</td>
				</tr>
            </tbody>
            </table>
        </section>
        </fieldset>

		<!-- 결정통지 / 통지완료 / 기간연장여부-->
		<c:if test="${opnObjtnDo.objtnStatCd eq '03' || opnObjtnDo.objtnStatCd eq '05' || opnObjtnDo.dcsprodEtYn eq '0'}">	
        <fieldset>
        <legend><c:out value="${requestScope.menu.lvl2MenuPath}" /> 처리결과</legend>
        <section>
            <h4 class="ty_A mgTm10_mq_mobile">처리결과</h4>
            <table class="table_datail_AB w_1 bt2x">
            <caption><c:out value="${requestScope.menu.lvl2MenuPath}" /> 처리결과</caption>
            <tbody>
				<tr>
					<th rowspan="3">연장</th>
					<th class="td_left_border">연장사유</th>
					<td class="ty_AB" colspan="3"><c:out value="${opnObjtnDo.dcsProdEtRson }"/></td>
				</tr>
				<tr>
					<th class="td_left_border">연장결정기한</th>
					<td class="ty_AB" colspan="3"><c:out value="${opnObjtnDo.dcsProdEtDt }"/></td>
				</tr>
				<tr>
					<th class="td_left_border">그 밖의 <br/>안내사항</th>
					<td class="ty_AB" colspan="3"><c:out value="${opnObjtnDo.dcsProdEtc }"/></td>
				</tr>
				
				<!-- 결정통지 / 통지완료 -->
				<c:if test="${opnObjtnDo.objtnStatCd eq '03' || opnObjtnDo.objtnStatCd eq '05'}">
				<tr>
					<th colspan="2">이의신청 결정</th>
					<td class="ty_AB" colspan="3"><c:out value="${opnObjtnDo.objtnDealRsltNm }"/></td>
				</tr>
				<tr>
					<th colspan="2">결정내용</th>
					<td class="ty_AB" colspan="3">${fn:replace(opnObjtnDo.objtnAplRsltCn, CR, "<br>")}</td>
				</tr>
				<tr>
					<th colspan="2">결정내용 첨부문서</th>
					<td class="ty_AB" colspan="3">
						<c:if test="${!empty opnObjtnDo.attchFlNm }">
							<a href="#" onclick="javascript:fn_objFileDownload('attch_fl_nm')"><img src="../../images/soportal/expose/icon/icon_file.gif"><c:out value="${opnObjtnDo.attchFlNm }" escapeXml="true"></c:out></a>
							<input type="hidden" id="attch_fl_nm" name="attch_fl_nm" value="<c:out value='${opnObjtnDo.attchFlNm }' escapeXml='true'/>"/>
							<input type="hidden" id="attch_fl_ph_nm" name="attch_fl_ph_nm" value="<c:out value='${opnObjtnDo.attchFlPhNm }' escapeXml='true'/>"/>							
						</c:if>
					</td>
				</tr>
				<tr id="clsdDiv01">
					<th colspan="2">공개형태</th>
					<td class="ty_AB" colspan="3">
						<c:choose>
							<c:when test="${opnObjtnDo.objtnDealRsltCd eq '04' || opnObjtnDo.objtnDealRsltCd eq '05' }">
								<c:choose>
									<c:when test="${opnObjtnDo.callVersion eq 'V1' }">
										${opnObjtnDo.opbFomValNm }
									</c:when>
									<c:otherwise>
										<c:set var="opbFomNm" value="${opnObjtnDo.opbFomNm1}"/>
										<c:if test="${!empty opnObjtnDo.opbFomNm2 and !empty opbFomNm}"><c:set var="opbFomNm" value="${opbFomNm}, ${opnObjtnDo.opbFomNm2}"/></c:if>
										<c:if test="${!empty opnObjtnDo.opbFomNm2 and empty opbFomNm}"><c:set var="opbFomNm" value="${opnObjtnDo.opbFomNm2}"/></c:if>
										<c:if test="${!empty opnObjtnDo.opbFomNm3 and !empty opbFomNm}"><c:set var="opbFomNm" value="${opbFomNm}, ${opnObjtnDo.opbFomNm3}"/></c:if>
										<c:if test="${!empty opnObjtnDo.opbFomNm3 and empty opbFomNm}"><c:set var="opbFomNm" value="${opnObjtnDo.opbFomNm3}"/></c:if>
										<c:if test="${!empty opnObjtnDo.opbFomNm4 and !empty opbFomNm}"><c:set var="opbFomNm" value="${opbFomNm}, ${opnObjtnDo.opbFomNm4}"/></c:if>
										<c:if test="${!empty opnObjtnDo.opbFomNm4 and empty opbFomNm}"><c:set var="opbFomNm" value="${opnObjtnDo.opbFomNm4}"/></c:if>
										<c:if test="${!empty opnObjtnDo.opbFomNm5 and !empty opbFomNm}"><c:set var="opbFomNm" value="${opbFomNm}, ${opnObjtnDo.opbFomNm5}"/></c:if>
										<c:if test="${!empty opnObjtnDo.opbFomNm5 and empty opbFomNm}"><c:set var="opbFomNm" value="${opnObjtnDo.opbFomNm5}"/></c:if>
										${opbFomNm}
									</c:otherwise>
								</c:choose>
									<c:if test="${!empty opnObjtnDo.opbFomNm5 and !empty opnObjtnDo.opbFomEtc}">
			                           (${opnObjtnDo.opbFomEtc})
			                        </c:if>
							</c:when>
							<c:otherwise>
								해당없음
							</c:otherwise>
						</c:choose>	
					</td>
				</tr>
				<tr id="clsdDiv02">
					<th colspan="2">수령방법</th>
					<td class="ty_AB" colspan="3">
						<c:choose>
							<c:when test="${opnObjtnDo.objtnDealRsltCd eq '04' || opnObjtnDo.objtnDealRsltCd eq '05' }">
								<c:choose>
									<c:when test="${opnObjtnDo.callVersion eq 'V1' }">
										${opnObjtnDo.giveMthNm }
									</c:when>
									<c:otherwise>
										<c:set var="giveMthNm" value="${opnObjtnDo.giveMthNm1}"/>
										<c:if test="${!empty opnObjtnDo.giveMthNm2 and !empty giveMthNm}"><c:set var="giveMthNm" value="${giveMthNm}, ${opnObjtnDo.giveMthNm2}"/></c:if>
										<c:if test="${!empty opnObjtnDo.giveMthNm2 and empty giveMthNm}"><c:set var="giveMthNm" value="${opnObjtnDo.giveMthNm2}"/></c:if>
										<c:if test="${!empty opnObjtnDo.giveMthNm3 and !empty giveMthNm}"><c:set var="giveMthNm" value="${giveMthNm}, ${opnObjtnDo.giveMthNm3}"/></c:if>
										<c:if test="${!empty opnObjtnDo.giveMthNm3 and empty giveMthNm}"><c:set var="giveMthNm" value="${opnObjtnDo.giveMthNm3}"/></c:if>
										<c:if test="${!empty opnObjtnDo.giveMthNm4 and !empty giveMthNm}"><c:set var="giveMthNm" value="${giveMthNm}, ${opnObjtnDo.giveMthNm4}"/></c:if>
										<c:if test="${!empty opnObjtnDo.giveMthNm4 and empty giveMthNm}"><c:set var="giveMthNm" value="${opnObjtnDo.giveMthNm4}"/></c:if>
										<c:if test="${!empty opnObjtnDo.giveMthNm5 and !empty giveMthNm}"><c:set var="giveMthNm" value="${giveMthNm}, ${opnObjtnDo.giveMthNm5}"/></c:if>
										<c:if test="${!empty opnObjtnDo.giveMthNm5 and empty giveMthNm}"><c:set var="giveMthNm" value="${opnObjtnDo.giveMthNm5}"/></c:if>
										${giveMthNm}
									</c:otherwise>
								</c:choose>
									<c:if test="${!empty opnObjtnDo.giveMthNm5 and !empty opnObjtnDo.giveMthEtc}">
			                           (${opnObjtnDo.giveMthEtc})
			                        </c:if>
							</c:when>
							<c:otherwise>
								해당없음
							</c:otherwise>
						</c:choose>	
					</td>
				</tr>
				</tr>
				<tr id="clsdDiv03">
					<th id="clsdTd31" rowspan="3">수수료</th>
					<th id="clsdTd32" class="td_left_border">감면여부</th>
					<td id="clsdTd33" class="ty_AB" colspan="3">
						<c:choose>
							<c:when test="${opnObjtnDo.objtnDealRsltCd eq '04' || opnObjtnDo.objtnDealRsltCd eq '05' }">
								<c:out value="${opnObjtnDo.feeRdtnCdNm }" />
							</c:when>
							<c:otherwise>
								해당없음
							</c:otherwise>
						</c:choose>	
					</td>
				</tr>
				<tr id="clsdDiv04">
					<th id="clsdTd32" class="td_left_border">감면사유</th>
					<td id="clsdTd33" class="ty_AB" colspan="3">
						<c:choose>
							<c:when test="${opnObjtnDo.objtnDealRsltCd eq '04' || opnObjtnDo.objtnDealRsltCd eq '05' }">
								<c:if test="${empty opnAplDo.feeRdtnRson}">
									해당없음
								</c:if>
								<c:out value="${opnObjtnDo.feeRdtnRson }" escapeXml="true"/>
							</c:when>
							<c:otherwise>
								해당없음
							</c:otherwise>
						</c:choose>	
					</td>
				</tr>
				<tr id="clsdDiv05">
					<th id="clsdTd32" class="td_left_border">첨부문서</th>
					<td id="clsdTd33" class="ty_AB" colspan="3">
						<a href="#" onclick="javascript:fn_objFileDownload('fee_attch_fl_nm');">
							<c:if test="${!empty opnObjtnDo.feeAttchFlNm }">
								<img src="../../images/soportal/expose/icon/icon_file.gif">
							</c:if>
							${opnObjtnDo.feeAttchFlNm }
						</a>
						<input type="hidden" name="fee_attch_fl_nm" value="${opnObjtnDo.feeAttchFlNm }" />
						<input type="hidden" name="fee_attch_fl_ph" value="${opnObjtnDo.feeAttchFlPh }" />
						<c:if test="${empty opnObjtnDo.feeAttchFlNm}">
							해당없음
						</c:if>
					</td>
				</tr>
				<tr>
					<th colspan="2">공개결정 첨부파일</th>
					<td class="ty_AB" colspan="3">
						<c:if test="${!empty opnObjtnDo.opbFlNm1 }">
						
							<a href="#" onclick="javascript:fn_objFileDownload('opb_fl_nm1');">
								<c:if test="${!empty opnObjtnDo.opbFlNm1}">
									<img src="../../images/soportal/expose/icon/icon_file.gif">
								</c:if>
								${opnObjtnDo.opbFlNm1 } 
							</a>
							<c:if test="${!empty opnObjtnDo.opbFlNm2 }">
							<br/>
							<a href="#" onclick="javascript:fn_objFileDownload('opb_fl_nm2');">
								<c:if test="${!empty opnObjtnDo.opbFlNm2 }">
									<img src="../../images/soportal/expose/icon/icon_file.gif">
								</c:if>
								${opnObjtnDo.opbFlNm2 }
							</a>
							</c:if>
							<c:if test="${!empty opnObjtnDo.opbFlNm3 }">
							<br/>
							<a href="#" onclick="javascript:fn_objFileDownload('opb_fl_nm3');">
								<c:if test="${!empty opnObjtnDo.opbFlNm3 }">
									<img src="../../images/soportal/expose/icon/icon_file.gif">
								</c:if>
								${opnObjtnDo.opbFlNm3 } 
							</a>
							</c:if>
							<c:if test="${!empty opnObjtnDo.opbFlNm1 or !empty opnObjtnDo.opbFlNm2 or !emptyopnObjtnDoo.opbFlNm3 }">
								<br/><br/>
								<p style="padding:5px 10px 0 0px; color:red; font-size:0.9em;  line-height:1.5em; text-align:justify;">
									▶ 공개된 첨부문서의 진본성(작성시점  및  위,변조여부)확인을 위하여 <br/>&nbsp;&nbsp;&nbsp;&nbsp;아래의 프로그램을 설치하여 주십시요. 
									(<a href="#none" style="text-decoration:none;" onclick="javascript:fn_utilFileDownload('4');">
										<img src="/images/admin/icon_file.png" style="padding-right:4px;" alt="첨부파일"> 
										<span style="color:#666;">설치매뉴얼</span>
									</a>)
								</p>
								<a href="#none" style="text-decoration:none;" onclick="javascript:fn_utilFileDownload('1');">
									<img src="/images/admin/icon_file.png" style="padding-right:4px;" alt="첨부파일"> 
									<span style="color:#666;">AdbeRdr1010_mui_Std.zip</span>
								</a>
								(PDF리더기)<br>
								<a href="#none" style="text-decoration:none;" onclick="javascript:fn_utilFileDownload('2');">
									<img src="/images/admin/icon_file.png" style="padding-right:4px;" alt="첨부파일">
									<span style="color:#666;">e-timing for AdobeReader 9,X,XI,DC(v4.6.6).exe<span style="color:#666;">
								</a>
								(진본확인 검증 프로그램1)<br>
								<a href="#none" style="text-decoration:none;" onclick="javascript:fn_utilFileDownload('3');">
									<img src="/images/admin/icon_file.png" style="padding-right:4px;" alt="첨부파일"> 
									<span style="color:#666;">vcredist_x86.exe</span>
								</a>
								(진본확인 검증 프로그램2)<br>
							</c:if>
							<input type="hidden" name="opb_fl_nm1" value="${opnObjtnDo.opbFlNm1 }" />
							<input type="hidden" name="opb_fl_ph1" value="${opnObjtnDo.opbFlPh1 }" />
							<input type="hidden" name="opb_fl_nm2" value="${opnObjtnDo.opbFlNm2 }" />
							<input type="hidden" name="opb_fl_ph2" value="${opnObjtnDo.opbFlPh2 }" />
							<input type="hidden" name="opb_fl_nm3" value="${opnObjtnDo.opbFlNm3 }" />
							<input type="hidden" name="opb_fl_ph3" value="${opnObjtnDo.opbFlPh3 }" />
						</c:if>	
					</td>
				</tr>
				<c:if test="${opnObjtnDo.objtnStatCd eq '03' }">
				<tr>
					<th colspan="2">특이사항</th>
					<td class="ty_AB" colspan="3">
						<c:choose>
							<c:when test="${empty opnObjtnDo.opbPsbj }">
								해당없음
							</c:when>
							<c:otherwise>
								${opnObjtnDo.opbPsbj }
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				</c:if>
				</c:if>
            </tbody>
            </table>
        </section>
        </fieldset>
		</c:if>
        <div class="area_btn_A">
			<c:if test="${opnObjtnDo.objtnStatCd eq '01' }">
				<a href="#none" onclick="javascript:fn_goAction('M');" class="btn_A">수정</a>
				<a href="#none" onclick="javascript:fn_goAction('C');" class="btn_A">이의취하</a>
			</c:if>  
			<c:if test="${opnObjtnDo.objtnStatCd eq '02' }">
				<a href="#none" onclick="javascript:fn_print('objtn', '${opnObjtnDo.callVersion}');" class="btn_A">신청서출력</a>
				<a href="#none" onclick="javascript:fn_goAction('C');" class="btn_A">이의취하</a>
			</c:if> 
			<c:if test="${opnObjtnDo.objtnStatCd eq '03' }">
				<a href="#none" onclick="javascript:fn_print('objtn', '${opnObjtnDo.callVersion}');" class="btn_A">신청서출력</a>
			</c:if> 
			<c:if test="${opnObjtnDo.objtnStatCd eq '04'}">
				<a href="#none" onclick="javascript:fn_print('objtn', '${opnObjtnDo.callVersion}');" class="btn_A">신청서출력</a>
				<a href="#none" onclick="javascript:fn_goAction('C');" class="btn_A">이의취하</a>
				<a href="#none" onclick="javascript:fn_print('objtnExt', '${opnObjtnDo.callVersion}');" class="btn_A">연장통지서출력</a>
			</c:if>
			<c:if test="${opnObjtnDo.objtnStatCd eq '03' }">
				<a href="#none" onclick="javascript:fn_print('objtnDcs', '${opnObjtnDo.callVersion}');" class="btn_A">결정통지서출력</a>
			</c:if>	
				<a href="#none" onclick="javascript:fn_go_opnApl();" class="btn_A">청구서</a>
				<a href="#none" onclick="javascript:fn_goAction();" class="btn_A">목록</a>
        </div>
		<textarea name="printObjtnRson" title="이의신청의 취지 및 이유(출력용)" style="display:none;">${opnObjtnDo.newObjtnRson}</textarea>
        </form>
		<form name="printForm" method="post">
			<input type="hidden" name="mrdParam" />
			<input type="hidden" name="width" />
			<input type="hidden" name="height" />
			<input type="hidden" name="title" />
			<input type="hidden" name="aplNo" />
			<input type="hidden" name="objtnSno" />
		</form>
		<form name="downloadForm" id="downloadForm" method="post">
			<input type="hidden" name="fileName" id="fileName" value="" /> 
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
<script type="text/javascript" src="<c:url value="/js/soportal/expose/selectObjection.js" />"></script>
<!-- jquery tree plugin [Dynatree] -->
<link rel="stylesheet" href="<c:url value="/js/soportal/tree/skin/ui.dynatree.css" />" type="text/css">
<script type="text/javascript" src="<c:url value="/js/soportal/tree/jquery.dynatree.js" />"></script> 
</body>
</html>
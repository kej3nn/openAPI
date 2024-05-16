<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)selectAccount.jsp 1.0 2019/08/12                                   --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%pageContext.setAttribute("CR", "\r");%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 정보공개 > 청구서 작성 내용                 																												   	--%>
<%--                                                                        																						--%>
<%-- @author SoftOn                                                         								 												--%>
<%-- @version 1.0 2019/07/22                                                																			--%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
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
			<h3>청구서 처리현황<span class="arrow"></span></h3>
        </div>


<!-- layout_flex -->
<div class="layout_flex">
    <!-- content -->
    <div id="content" class="content">
        <h2 class="hide"><c:out value="${requestScope.menu.lvl1MenuPath}" /></h2>
        <div class="area_h3 area_h3_AB deco_h3_2">
			<h3 class="ty_A"><strong>청구서보기</strong></h3>
        </div>

		<form name="form" method="post">
		<c:set var="opnAplDo" value="${requestScope.opnAplDo}"/>
		<input type="hidden" name="apl_no" value="${opnAplDo.aplNo }" />
		<input type="hidden" name="fileName" />
		<input type="hidden" name="filePath" />
		<input type="hidden" name="apl_cancle">
		<!--청구서 진행상태:STR-->
		<table class="cheong_process">
		<tr>
		<c:choose>
			<c:when test="${opnAplDo.aplPrgStatCd eq '01' }">
			<td><img src="../../images/soportal/expose/visual/now01_on.gif" alt="접수중"   title="접수증"   /></td>
			<td><img src="../../images/soportal/expose/visual/now_arrow.gif" alt="화살표" class="arrow"  /></td>
			<td><img src="../../images/soportal/expose/visual/now02.gif"     alt="처리중"   title="처리중"   /></td>
			<td><img src="../../images/soportal/expose/visual/now_arrow.gif" alt="화살표" class="arrow"  /></td>
			<td><img src="../../images/soportal/expose/visual/now03.gif"     alt="결정통지"   title="결정통지"   /></td>
			<td><img src="../../images/soportal/expose/visual/now_arrow.gif" alt="화살표" class="arrow"  /></td>
			<td><img src="../../images/soportal/expose/visual/now04.gif"      alt="통지완료"   title="통지완료"   /></td>
			</c:when>
			<c:when test="${opnAplDo.rcpPrgStatCd eq '03' or opnAplDo.rcpPrgStatCd eq '05'}">
			<td><img src="../../images/soportal/expose/visual/now01.gif"  	   alt="접수중"   title="접수증"   /></td>
			<td><img src="../../images/soportal/expose/visual/now_arrow.gif" alt="화살표" class="arrow"  /></td>
			<td><img src="../../images/soportal/expose/visual/now02_on.gif" alt="처리중"   title="처리중"   /></td>
			<td><img src="../../images/soportal/expose/visual/now_arrow.gif" alt="화살표" class="arrow"  /></td>
			<td><img src="../../images/soportal/expose/visual/now03.gif"     alt="결정통지"   title="결정통지"   /></td>
			<td><img src="../../images/soportal/expose/visual/now_arrow.gif" alt="화살표" class="arrow"  /></td>
			<td><img src="../../images/soportal/expose/visual/now04.gif"      alt="통지완료"   title="통지완료"   /></td>
			</c:when>
			<c:when test="${opnAplDo.rcpPrgStatCd eq '04' }">
			<td><img src="../../images/soportal/expose/visual/now01.gif"  	   alt="접수중"   title="접수증"   /></td>
			<td><img src="../../images/soportal/expose/visual/now_arrow.gif" alt="화살표" class="arrow"  /></td>
			<td><img src="../../images/soportal/expose/visual/now02.gif" 	   alt="처리중"   title="처리중"   /></td>
			<td><img src="../../images/soportal/expose/visual/now_arrow.gif" alt="화살표" class="arrow"  /></td>
			<td><img src="../../images/soportal/expose/visual/now03_on.gif" alt="결정통지"   title="결정통지"   /></td>
			<td><img src="../../images/soportal/expose/visual/now_arrow.gif" alt="화살표" class="arrow"  /></td>
			<td><img src="../../images/soportal/expose/visual/now04.gif"      alt="통지완료"   title="통지완료"   /></td>
			</c:when>
			<c:when test="${opnAplDo.rcpPrgStatCd eq '08' }">
			<td><img src="../../images/soportal/expose/visual/now01.gif"  	   alt="접수중"   title="접수증"   /></td>
			<td><img src="../../images/soportal/expose/visual/now_arrow.gif" alt="화살표" class="arrow"  /></td>
			<td><img src="../../images/soportal/expose/visual/now02.gif" 	   alt="처리중"   title="처리중"   /></td>
			<td><img src="../../images/soportal/expose/visual/now_arrow.gif" alt="화살표" class="arrow"  /></td>
			<td><img src="../../images/soportal/expose/visual/now03.gif" 	   alt="결정통지"   title="결정통지"   /></td>
			<td><img src="../../images/soportal/expose/visual/now_arrow.gif" alt="화살표" class="arrow"  /></td>
			<td><img src="../../images/soportal/expose/visual/now04_on.gif" alt="통지완료"   title="통지완료"   /></td>
			</c:when>
			<c:when test="${opnAplDo.rcpPrgStatCd eq '11' }">
			<td><img src="../../images/soportal/expose/visual/now01.gif"  	   alt="접수중"   title="접수증"   /></td>
			<td><img src="../../images/soportal/expose/visual/now_arrow.gif" alt="화살표" class="arrow"  /></td>
			<td><img src="../../images/soportal/expose/visual/now02.gif" 	   alt="처리중"   title="처리중"   /></td>
			<td><img src="../../images/soportal/expose/visual/now_arrow.gif" alt="화살표" class="arrow"  /></td>
			<td><img src="../../images/soportal/expose/visual/now05_on.gif" alt="이송통지"   title="이송통지"   /></td>
			</c:when>
			<c:otherwise>
			<td><img src="../../images/soportal/expose/visual/now01.gif"  	   alt="접수중"   title="접수증"   /></td>
			<td><img src="../../images/soportal/expose/visual/now_arrow.gif" alt="화살표" class="arrow"  /></td>
			<td><img src="../../images/soportal/expose/visual/now02.gif" 	   alt="처리중"   title="처리중"   /></td>
			<td><img src="../../images/soportal/expose/visual/now_arrow.gif" alt="화살표" class="arrow"  /></td>
			<td><img src="../../images/soportal/expose/visual/now03.gif" 	   alt="결정통지"   title="결정통지"   /></td>
			<td><img src="../../images/soportal/expose/visual/now_arrow.gif" alt="화살표" class="arrow"  /></td>
			<td><img src="../../images/soportal/expose/visual/now04.gif" 	   alt="통지완료"   title="통지완료"   /></td>
			</c:otherwise>
			</c:choose>			
		</tr>
		<tr style="height: 20px;"></tr>
		</table>
		<!--청구서 진행상태:END-->

        <fieldset>
        <legend><c:out value="${requestScope.menu.lvl2MenuPath}" /> 청구인정보</legend>
        <section>
        <table class="table_datail_AB w_1">
        <caption><c:out value="${requestScope.menu.lvl2MenuPath}" /> 청구인정보</caption>
            <tbody>
            <tr>
                <th scope="row"><label for="title">이름</label></th>
                <td>
					<c:out value="${opnAplDo.aplPn }" escapeXml="true"/>
					<input type="hidden" name="apl_pn" id="apl_pn" value="${opnAplDo.aplPn }"/>
                </td>
                <th scope="row"><label for="title">생년월일</label></th>
                <td>
                	${opnAplDo.aplRno1 }
                </td>
            </tr>
            <tr>
                <th scope="row"><label for="title">휴대전화번호</label></th>
                <td>
                	${opnAplDo.aplMblPno }
                </td>
                <th scope="row"><label for="title">전화번호</label></th>
                <td>
                	${opnAplDo.aplPno }
                </td>
            </tr>
            <tr>
                <th scope="row"><label for="title">모사전송번호</label></th>
                <td>
                	${opnAplDo.aplFaxNo }
                </td>
                <th scope="row"><label for="title">전자우편</label></th>
                <td>
                	<c:out value="${opnAplDo.aplEmailAddr }" escapeXml="true"/>
                </td>
            </tr>
            <tr>
                <th scope="row"><label for="title">주소</label></th>
                <td colspan="3">
                		${opnAplDo.aplZpno } 
						${opnAplDo.apl1Addr } &nbsp; <c:out value="${opnAplDo.apl2Addr }" escapeXml="true"/>
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
            <table class="table_datail_AB w_1">
            <caption><c:out value="${requestScope.menu.lvl2MenuPath}" /> 청구내역</caption>
            <tbody>
				<tr>
					<th colspan="2"><label for="organ">청구대상기관</label></th>
					<td class="ty_AB">
						${opnAplDo.aplInstNm }
					</td>
				</tr>
				<tr>
					<th colspan="2"><label for="organ">청구처리기관</label></th>
					<td class="ty_AB">
						${opnAplDo.aplDealInstNm }
						<input type="hidden" name="apl_deal_instcd" id="apl_deal_instcd" value="${opnAplDo.aplDealInstCd }">
						<input type="hidden" name="apl_dt" id="apl_dt" value="${opnAplDo.aplDt }">
					</td>
				</tr>
				<tr>
					<th colspan="2"><label for="apl_sj_bfmod">청구제목</label></th>
					<td class="ty_AB">
						${opnAplDo.aplSj }
					</td>
				</tr>
				<tr>
					<th colspan="2"><label for="apl_dtscn_bfmod">청구내용</label></th>
					<td class="ty_AB">
						<c:out value='${fn:replace(opnAplDo.aplDtsCn, CR, "<br>")}' escapeXml="false"/>
					</td>
				</tr>
				<tr>
					<th colspan="2" ><label for="file">첨부문서</label></th>
					<td class="ty_AB">
						<a href="#" onclick="javascript:fn_fileDown('1');">
							<c:if test="${!empty opnAplDo.attchFlNm }">
								<img src="../../images/soportal/expose/icon/icon_file.gif">
							</c:if>
							${opnAplDo.attchFlNm }
						</a>
						<input type="hidden" name="apl_attch_flnm" value="${opnAplDo.attchFlNm }" />
						<input type="hidden" name="apl_attch_flph" value="${opnAplDo.attchFlPhNm }" />
						<c:if test="${opnAplDo.rcpPrgStatCd eq '08' and empty opnAplDo.attchFlNm}">
							해당없음
						</c:if>
					</td>
				</tr>
				<tr>
					<th colspan="2"><label for="opentype">공개형태</label></th>
					<td class="ty_AB">
						<c:choose>
							<c:when test="${opnAplDo.callVersion eq 'V1' }">
								${opnAplDo.opbFomNm }
							</c:when>
							<c:otherwise>
								<c:set var="opbFomNm" value="${opnAplDo.opbFomNm1}"/>
								<c:if test="${!empty opnAplDo.opbFomNm2 and !empty opbFomNm}"><c:set var="opbFomNm" value="${opbFomNm}, ${opnAplDo.opbFomNm2}"/></c:if>
								<c:if test="${!empty opnAplDo.opbFomNm2 and empty opbFomNm}"><c:set var="opbFomNm" value="${opnAplDo.opbFomNm2}"/></c:if>
								<c:if test="${!empty opnAplDo.opbFomNm3 and !empty opbFomNm}"><c:set var="opbFomNm" value="${opbFomNm}, ${opnAplDo.opbFomNm3}"/></c:if>
								<c:if test="${!empty opnAplDo.opbFomNm3 and empty opbFomNm}"><c:set var="opbFomNm" value="${opnAplDo.opbFomNm3}"/></c:if>
								<c:if test="${!empty opnAplDo.opbFomNm4 and !empty opbFomNm}"><c:set var="opbFomNm" value="${opbFomNm}, ${opnAplDo.opbFomNm4}"/></c:if>
								<c:if test="${!empty opnAplDo.opbFomNm4 and empty opbFomNm}"><c:set var="opbFomNm" value="${opnAplDo.opbFomNm4}"/></c:if>
								<c:if test="${!empty opnAplDo.opbFomNm5 and !empty opbFomNm}"><c:set var="opbFomNm" value="${opbFomNm}, ${opnAplDo.opbFomNm5}"/></c:if>
								<c:if test="${!empty opnAplDo.opbFomNm5 and empty opbFomNm}"><c:set var="opbFomNm" value="${opnAplDo.opbFomNm5}"/></c:if>
								${opbFomNm}
							</c:otherwise>
						</c:choose>
							<c:if test="${!empty opnAplDo.opbFomNm5 and !empty opnAplDo.opbFomEtc}">
	                           (${opnAplDo.opbFomEtc})
	                        </c:if>
					</td>
				</tr>
				<tr>
					<th colspan="2"><label for="receipt">수령방법</label></th>
					<td class="ty_AB">
						<c:choose>
							<c:when test="${opnAplDo.callVersion eq 'V1' }">
								${opnAplDo.aplTakMthNm }
							</c:when>
							<c:otherwise>
								<c:set var="giveMthNm" value="${opnAplDo.giveMthNm1}"/>
								<c:if test="${!empty opnAplDo.giveMthNm2 and !empty giveMthNm}"><c:set var="giveMthNm" value="${giveMthNm}, ${opnAplDo.giveMthNm2}"/></c:if>
								<c:if test="${!empty opnAplDo.giveMthNm2 and empty giveMthNm}"><c:set var="giveMthNm" value="${opnAplDo.giveMthNm2}"/></c:if>
								<c:if test="${!empty opnAplDo.giveMthNm3 and !empty giveMthNm}"><c:set var="giveMthNm" value="${giveMthNm}, ${opnAplDo.giveMthNm3}"/></c:if>
								<c:if test="${!empty opnAplDo.giveMthNm3 and empty giveMthNm}"><c:set var="giveMthNm" value="${opnAplDo.giveMthNm3}"/></c:if>
								<c:if test="${!empty opnAplDo.giveMthNm4 and !empty giveMthNm}"><c:set var="giveMthNm" value="${giveMthNm}, ${opnAplDo.giveMthNm4}"/></c:if>
								<c:if test="${!empty opnAplDo.giveMthNm4 and empty giveMthNm}"><c:set var="giveMthNm" value="${opnAplDo.giveMthNm4}"/></c:if>
								<c:if test="${!empty opnAplDo.giveMthNm5 and !empty giveMthNm}"><c:set var="giveMthNm" value="${giveMthNm}, ${opnAplDo.giveMthNm5}"/></c:if>
								<c:if test="${!empty opnAplDo.giveMthNm5 and empty giveMthNm}"><c:set var="giveMthNm" value="${opnAplDo.giveMthNm5}"/></c:if>
								${giveMthNm}
							</c:otherwise>
						</c:choose>
							<c:if test="${!empty opnAplDo.giveMthNm5 and !empty opnAplDo.aplTakMthEtc}">
	                           (${opnAplDo.aplTakMthEtc})
	                        </c:if>
					</td>
				</tr>
				<tr>
					<th id="feeRdtnTh" class="line" rowspan="3">수수료</th>
					<th class="td_left_border"><label for="fee">감면여부</label></th>
					<td class="ty_AB">
						${opnAplDo.feeRdtnCdNm }
					</td>
				</tr>
				<tr>
					<th class="td_left_border"><label for="fee">감면사유</label></th>
					<td class="ty_AB">
						<c:out value="${opnAplDo.feeRdtnRson }" escapeXml="true"/>
						<c:if test="${opnAplDo.rcpPrgStatCd eq '08' and empty opnAplDo.feeRdtnRson}">
							해당없음
						</c:if>
					</td>
				</tr>
				<tr>
					<th class="td_left_border"><label for="fee">첨부문서</label></th>
					<td class="ty_AB">
						<a href="#" onclick="javascript:fn_fileDown('2');">
							<c:if test="${!empty opnAplDo.feeAttchFlNm }">
								<img src="../../images/soportal/expose/icon/icon_file.gif">
							</c:if>
							${opnAplDo.feeAttchFlNm }
						</a>
						<input type="hidden" name="fee_rdtn_attch_flnm" value="${opnAplDo.feeAttchFlNm }" />
						<input type="hidden" name="fee_rdtn_attch_flph" value="${opnAplDo.feeAttchFlPh }" />
						<c:if test="${opnAplDo.rcpPrgStatCd eq '08' and empty opnAplDo.feeAttchFlNm}">
							해당없음
						</c:if>
					</td>
				</tr>
				<tr>
					<th colspan="2"><label for="receipt">공개여부</label></th>
					<td class="ty_AB">
						<c:out value="${opnAplDo.opbYn }" escapeXml="true"/>
					</td>
				</tr>
				<tr id="clsdTr10">
					<th colspan="2"><label for="receipt">비공개내용</label></th>
					<td class="ty_AB">
						<c:choose>
							<c:when test="${opnAplDo.callVersion eq 'V1' }">
								<c:out value='${fn:replace(opnAplDo.clsdRmk, CR, "<br>")}' escapeXml="false"/>
								<c:if test="${opnAplDo.rcpPrgStatCd eq '08' and empty opnAplDo.clsdRmk}">
								해당없음
								</c:if>
							</c:when>
							<c:otherwise>
								<c:out value='${fn:replace(opnAplDo.newClsdRmk, CR, "<br>")}' escapeXml="false"/>
								<c:if test="${opnAplDo.rcpPrgStatCd eq '08' and empty opnAplDo.newClsdRmk}">
								해당없음
								</c:if>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr id="clsdTr11">
					<th colspan="2" id="clsdTd111"><label for="receipt">비공개 첨부파일</label></th>
					<td class="ty_AB" id="clsdTd112">
						<c:choose>
							<c:when test="${!empty opnAplDo.clsdAttchFlNm }">
								<img src="../../images/soportal/expose/icon/icon_file.gif">&nbsp;
								<a href="#" onclick="javascript:fn_fileDown('0');">
									${opnAplDo.clsdAttchFlNm }
								</a>
							</c:when>
							<c:otherwise>
								해당없음
							</c:otherwise>
						</c:choose>
						<input type="hidden" name="clsd_attch_fl_nm" value="${opnAplDo.clsdAttchFlNm }"/>
						<input type="hidden" name="clsd_attch_fl_ph_nm" value="${opnAplDo.clsdAttchFlPhNm }"/>
					</td>
				</tr>
				<tr id="clsdTrNon1">
					<th colspan="2" id="clsdTdNon1"><label for="receipt">정보 부존재 등<br /> 정보공개청구에<br />따를수 없는 사유</label></th>
					<td class="ty_AB" id="clsdTdNon2">
						<c:if test="${opnAplDo.opbYn eq '부존재 등' }">	
						   ${opnAplDo.nonExt }<br />
                        </c:if>

						<c:if test="${opnAplDo.opbYn ne '부존재 등' }">해당없음</c:if>	
					</td>
				</tr>
				<tr id="clsdTrNon2">
					<th colspan="2" id="clsdTdNon21">부존재 첨부파일</th>
					<td class="ty_AB" id="clsdTdNon22">
						<c:choose>
							<c:when test="${!empty opnAplDo.nonFlNm }">
								<img src="../../images/soportal/expose/icon/icon_file.gif">&nbsp;
								<a href="#" onclick="javascript:fn_fileDown('8');">
									${opnAplDo.nonFlNm }
								</a>
								<br /><br>
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
								<p style="padding:5px 10px 0 10px; color:red; font-size:0.9em;  line-height:1.5em; text-align:justify;">
									▶공개된 첨부문서의 진본성(작성시점 및 위, 변조여부)확인을 위하여 <br/>&nbsp;&nbsp;&nbsp;AdobeReader 9.x ~ 10.x 를 설치 하신후 위의 검증 프로그램을 설치해 주십시요. 
									(<a href="#none" style="text-decoration:none;" onclick="javascript:fn_utilFileDownload('4');">
										<img src="/images/admin/icon_file.png" style="padding-right:4px;" alt="첨부파일"> 
										<span style="color:#666;">설치매뉴얼</span>
									</a>)
								</p>
							</c:when>
							<c:otherwise>
								해당없음
							</c:otherwise>
						</c:choose>
						<input type="hidden" name="non_fl_nm" value="${opnAplDo.nonFlNm }"/>
						<input type="hidden" name="non_fl_ph" value="${opnAplDo.nonFlPh }"/>
					</td>
				</tr>
				<tr id="clsdTr12">
					<th colspan="2" id="clsdTd121"><label for="receipt">결정통지안내수신</label></th>
					<td class="ty_AB" id="clsdTd122">
						${opnAplDo.dcsNtcRcvMthNm }
					</td>
				</tr>
				<tr id="clsdTr13">
					<th colspan="2" id="clsdTd131"><label for="receipt">결정통지 첨부파일</label></th>
					<td class="ty_AB" id="clsdTd132">
						<c:if test="${!empty opnAplDo.opbFlNm }">
							<a href="#" onclick="javascript:fn_fileDown('3');">
									<img src="../../images/soportal/expose/icon/icon_file.gif">
								${opnAplDo.opbFlNm }
							</a>	
							<br/>
						</c:if>
						<c:if test="${!empty opnAplDo.opbFlNm2 }">
							<a href="#" onclick="javascript:fn_fileDown('4');">
									<img src="../../images/soportal/expose/icon/icon_file.gif">
								${opnAplDo.opbFlNm2 }
							</a>		
							<br/>
						</c:if>
						<c:if test="${!empty opnAplDo.opbFlNm3 }">
							<a href="#" onclick="javascript:fn_fileDown('5');">
									<img src="../../images/soportal/expose/icon/icon_file.gif">					
								${opnAplDo.opbFlNm3 }
							</a>
							<br/>
						</c:if>	
						<c:if test="${!empty opnAplDo.imdFlNm }">
							<a href="#" onclick="javascript:fn_fileDown('7');">
									<img src="../../images/soportal/expose/icon/icon_file.gif">					
								${opnAplDo.imdFlNm }
							</a>
							<br/>
						</c:if>													
						<input type="hidden" name="opb_flnm"  value="${opnAplDo.opbFlNm }" />
						<input type="hidden" name="opb_flph"  value="${opnAplDo.opbFlPh }" />
						<input type="hidden" name="opb_flnm2" value="${opnAplDo.opbFlNm2 }"/>
						<input type="hidden" name="opb_flph2" value="${opnAplDo.opbFlPh2 }"/>
						<input type="hidden" name="opb_flnm3" value="${opnAplDo.opbFlNm3 }"/>
						<input type="hidden" name="opb_flph3" value="${opnAplDo.opbFlPh3 }"/>
						<input type="hidden" name="imd_fl_nm" value="${opnAplDo.imdFlNm }"/>
						<input type="hidden" name="imd_fl_ph" value="${opnAplDo.imdFlPh }"/>
						<c:if test="${opnAplDo.rcpPrgStatCd eq '08' and empty opnAplDo.opbFlNm}">
							해당없음
						</c:if>
						<c:if test="${!empty opnAplDo.imdFlNm or !empty opnAplDo.imdFlNm}">
							<br />
							<c:if test="${fn:substring(opnAplDo.opbFlNm, (fn:length(opnAplDo.opbFlNm)-3), fn:length(opnAplDo.opbFlNm)) eq 'pdf' 
							           or fn:substring(opnAplDo.imdFlNm, (fn:length(opnAplDo.imdFlNm)-3), fn:length(opnAplDo.imdFlNm)) eq 'pdf' }">
							<br>
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
							<p style="padding:5px 10px 0 10px; color:red; font-size:0.9em;  line-height:1.5em; text-align:justify;">
								▶공개된 첨부문서의 진본성(작성시점 및 위, 변조여부)확인을 위하여 <br/>&nbsp;&nbsp;&nbsp;AdobeReader 9.x ~ 10.x 를 설치 하신후 위의 검증 프로그램을 설치해 주십시요. 
								(<a href="#none" style="text-decoration:none;" onclick="javascript:fn_utilFileDownload('4');">
									<img src="/images/admin/icon_file.png" style="padding-right:4px;" alt="첨부파일"> 
									<span style="color:#666;">설치매뉴얼</span>
								</a>)
							</p>
							</c:if>
						</c:if>
					</td>
				</tr>
				<tr id="clsdTr14">
					<th colspan="2" id="clsdTd141"><label for="receipt">타기관이송</label></th>
					<td class="ty_AB" id="clsdTd142">
						${opnAplDo.trsfInstNm }
						<c:if test="${opnAplDo.rcpPrgStatCd eq '08' and empty opnAplDo.trsfInstNm}">
							해당없음
						</c:if>
					</td>
				</tr>
				<tr id="clsdTr143">
					<th colspan="2" id="clsdTd1431"><label for="receipt">이송통지 첨부파일</label></th>
					<td class="ty_AB" id="clsdTd1432">
						<c:if test="${!empty opnAplDo.trsfFlNm }">
							<a href="#" onclick="javascript:fn_fileDown('6');">
									<img src="../../images/soportal/expose/icon/icon_file.gif">
								${opnAplDo.trsfFlNm }
							</a>
						</c:if>													
						<input type="hidden" name="trsf_fl_nm" value="${opnAplDo.trsfFlNm }"/>
						<input type="hidden" name="trsf_fl_ph" value="${opnAplDo.trsfFlPh }"/>
						<c:if test="${!empty opnAplDo.trsfFlNm}">
							<c:if test="${fn:substring(opnAplDo.trsfFlNm, (fn:length(opnAplDo.trsfFlNm)-3), fn:length(opnAplDo.trsfFlNm)) eq 'pdf' }">
							<br />							
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
							<p style="padding:5px 10px 0 10px; color:red; font-size:0.9em;  line-height:1.5em; text-align:justify;">
								▶공개된 첨부문서의 진본성(작성시점 및 위, 변조여부)확인을 위하여 <br/>&nbsp;&nbsp;&nbsp;AdobeReader 9.x ~ 10.x 를 설치 하신후 위의 검증 프로그램을 설치해 주십시요. 
								(<a href="#none" style="text-decoration:none;" onclick="javascript:fn_utilFileDownload('4');">
									<img src="/images/admin/icon_file.png" style="padding-right:4px;" alt="첨부파일"> 
									<span style="color:#666;">설치매뉴얼</span>
								</a>)
							</p>
							</c:if>
						</c:if>
					</td>
				</tr>
				<tr id="clsdTr15">
					<th colspan="2" id="clsdTd151"><label for="receipt">특이사항</label></th>
					<td class="ty_AB" id="clsdTd152">
						<c:choose>
							<c:when test="${!empty opnAplDo.opbPsbj }">
								${opnAplDo.opbPsbj }
							</c:when> 
							<c:otherwise>
								해당없음.
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr id="clsdTr16">
					<th colspan="2" id="clsdTd161"><label for="receipt">종결사유</label></th>
					<td class="ty_AB" id="clsdTd162">
						<c:choose>
							<c:when test="${!empty opnAplDo.endCn }">
								${opnAplDo.endCn }
							</c:when> 
							<c:otherwise>
								해당없음.
							</c:otherwise>
						</c:choose>
					</td>
				</tr>

            </tbody>
        </table>
        </section>
        </fieldset>
        <div class="area_btn_A">

			<c:if test="${opnAplDo.aplPrgStatCd ne '99'}">
				<a href="#none" onclick="javascript:fn_infoPrint('rcp', '${opnAplDo.callVersion}');" class="btn_A">접수증출력</a>
				<a href="#none" onclick="javascript:fn_infoPrint('apl', '${opnAplDo.callVersion}');" class="btn_A">청구서출력</a>
			</c:if>
			<c:if test="${opnAplDo.aplPrgStatCd eq '03' }">
				<a href="#none" onclick="javascript:fn_infoCancle('1');" class="btn_A">청구취하</a>
			</c:if>
			<c:if test="${opnAplDo.dcsProdEtyn eq '0'}">
				<a href="#none" onclick="javascript:fn_infoPrint('ext', '${opnAplDo.callVersion}')" class="btn_A">결정기한연장통지서</a>
			</c:if>
			<c:if test="${!empty opnAplDo.opbYn }">
				<c:if test="${opnAplDo.opb_yn eq '부존재 등'}">					
					<a href="#none" onclick="javascript:fn_infoPrint('non', '${opnAplDo.callVersion}');" class="btn_A">부존재 등 통지서 출력</a>
				</c:if>
				<c:if test="${opnAplDo.opbYn ne '부존재 등'}">				
					<a href="#none" onclick="javascript:fn_infoPrint('dcs', '${opnAplDo.callVersion}');" class="btn_A">결정통지서</a>
				</c:if>
			</c:if>
			<c:if test="${opnAplDo.aplPrgStatCd eq '11'}">			
				<a href="#none" onclick="javascript:fn_infoPrint('trsf', '${opnAplDo.callVersion}');" class="btn_A">이송통지서</a>
			</c:if>
			
            <a href="#none" onclick="location.href='/portal/expose/searchAccountPage.do';" class="btn_A">목록</a>
        </div>
		<textarea name="printAplDtsCn" title="청구내용(출력용)" style="display:none;">${opnAplDo.aplDtsCn}</textarea>
		<textarea name="printClsdRmk" title="비공개사유(출력용)"  style="display:none;">${opnAplDo.newClsdRmk}</textarea>
	</form>
	<form name="printForm" method="post">
		<input type="hidden" name="mrdParam"/>
		<input type="hidden" name="width"/>
		<input type="hidden" name="height"/>
		<input type="hidden" name="title"/>
		<input type="hidden" name="apl_pn" value='<c:out value="${opnAplDo.aplPn}"/>' />
		<input type="hidden" name="rcp_dts_no" value='' />
	</form>
	<form name="dForm" id="dForm" method="post">
		<input type="hidden" name="fileName"/>
		<input type="hidden" name="filePath"/>
	</form>
    </div>
    <!-- // content -->
</div>
<!-- // layout_flex -->

</div></div>
<!-- footer -->
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
<script type="text/javascript" src="<c:url value="/js/soportal/expose/nasCommon.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/soportal/expose/selectAccount.js" />"></script>
<!-- jquery tree plugin [Dynatree] -->
<link rel="stylesheet" href="<c:url value="/js/soportal/tree/skin/ui.dynatree.css" />" type="text/css">
<script type="text/javascript" src="<c:url value="/js/soportal/tree/jquery.dynatree.js" />"></script> 
</body>
</html>
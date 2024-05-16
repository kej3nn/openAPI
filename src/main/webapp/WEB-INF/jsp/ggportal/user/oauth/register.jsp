<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)register.jsp 1.0 2015/06/15                                        --%>
<%--                                                                        --%>
<%-- COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.            --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 사용자를 등록하는 화면이다.                                            --%>
<%--                                                                        --%>
<%-- @author 김은삼                                                         --%>
<%-- @version 1.0 2015/06/15                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/ggportal/sect/head.jsp" %>
<script type="text/javascript" src="<c:url value="/js/ggportal/user/oauth/register.js" />"></script>
</head>
<body>
<!-- layout_A -->
<div class="layout_A">
<%@ include file="/WEB-INF/jsp/ggportal/sect/header.jsp" %>
<!-- wrap_layout_flex -->
<div class="wrap_layout_flex"><div class="layout_flex_100">
<%@ include file="/WEB-INF/jsp/ggportal/sect/gnb.jsp" %>
<!-- layout_flex -->
<div class="layout_flex">
    <!-- content -->
    <div id="content" class="content_B">
        <%@ include file="/WEB-INF/jsp/ggportal/sect/navigation.jsp" %>
        <h2 class="hide"><c:out value="${requestScope.menu.lvl1MenuPath}" /></h2>
        <div class="area_h3 area_h3_AB deco_h3_4">
            <h3 class="ty_A"><strong><c:out value="${requestScope.menu.lvl1MenuPath}" /></strong></h3>
            <p>복잡한 홈페이지 회원가입 절차없이 <abbr title="Social Network Service">SNS</abbr> 계정으로 회원가입 및 로그인하여<br />Open API 등의 서비스를 편리하게 이용하실 수 있습니다.</p>
        </div>
        <div class="content_C">
        <form id="oauth-insert-form" name="oauth-insert-form" method="post">
        <input type="hidden" name="providerName" value="<c:out value="${sessionScope.portalProviderName}" />" />
        <input type="hidden" name="contSiteCd" value="<c:out value="${sessionScope.portalContSiteCd}" />" />
        <input type="hidden" name="userId" value="<c:out value="${sessionScope.portalUserId}" />" />
        <fieldset>
        <legend>개인정보 이용약관</legend>
        <section class="section_agreement"> 
            <h4 class="ty_A  mgTm10_mq_mobile">개인정보 이용약관</h4>
            <div class="box_B area_service_agreement area_agreement"><div class="service_agreement">
            <p class="ty_A">국회 국회나눔데이터 이용에 대해 감사드리며, 국회나눔데이터의 개인정보처리방침에 대하여 설명을 드리겠습니다. 국회가 취급하는 모든 개인정보는 관련법령에 근거하거나 정보주체의 동의에 의하여 수집·보유 및 처리되고 있습니다.</p>
            <ol>
            <li>
            「개인정보보호법」, 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」은 이러한 개인정보의 취급에 대한 일반적 규범을 제시하고 있으며, 국회는 이러한 법령의 규정에 따라 수집·보유 및 처리하는 개인정보를 공공업무의 적절한 수행과 국민의 권익을 보호하기 위해 적법하고 적정하게 취급할 것입니다.
            </li>
            <li>
                <strong class="tit">제 1조 [개인정보의 처리 목적]</strong>
                <ol>
                <li>① 국회는 다음의 목적을 위하여 개인정보를 처리합니다. 처리하고 있는 개인정보는 다음의 목적 이외의 용도로는 이용되지 않으며, 이용 목적이 변경되는 경우에는 개인정보 보호법 제 18조에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.
                    <ul class="ty_A">
                    <li>Open API 인증키 발급, 각종 게시판 관리, 각종 고지&#183;통지, 고충처리 등을 목적으로 개인정보를 처리합니다.</li>
                    </ul>
                </li>
                <li>② 국회가 개인정보 보호법 제 32조에 따라 등록&#183;공개하는 개인정보파일의 처리목적은 다음과 같습니다.
                    <ol>
                    <li>
                        <ul class="ty_B">
                        <li>닉네임</li>
                        </ul>
                    </li>
                    </ol>
                </li>
                </ol>
            </li>
            <li>
                <strong class="tit">제 2조 [개인정보의 처리 및 보유기간]</strong>
                <ol>
                <li>① 국회는 법령에 따른 개인정보 보유&#183;이용기간 또는 정보주체로부터 개인정보를 수집 시에 동의 받은 개인정보 보유&#183;이용기간 내에서 개인정보를 처리&#183;보유합니다.</li>
                <li>② 개인정보 처리 및 보유기간은 다음과 같습니다.
                    <ul class="ty_A">
                    <li>회원가입 및 관리 : 회원 탈퇴시까지 다만, 다음의 사유에 해당하는 경우에는 해당 사유 종료시까지
                        <ul class="ty_B">
                        <li>관계 법령 위반에 따른 수사&#183;조사 등이 진행중인 경우에는 해당 수사&#183;조사 종료시까지</li>
                        </ul>
                    </li>
                    </ul>
                </li>
                </ol>
            </li>
            <li>
                <strong class="tit">제 3조 [정보주체의 권리&#183;의무 및 행사방법]</strong>
                <ol>
                <li>① 정보주체는 국회에 대해 언제든지 다음 각 호의 개인정보 보호 관련 권리를 행사할 수 있습니다.
                    <ul class="ty_B">
                    <li>개인정보 열람 요구</li>
                    <li>오류 등이 있을 경우 정정 요구</li>
                    <li>삭제 요구</li>
                    <li>처리정지 요구</li>
                    </ul>
                </li>
                <li>② 제 1항에 따른 권리 행사는 국회에 대해 서면, 전화, 전자우편, 모사전송(FAX) 등을 통하여 하실 수 있으며 국회는 이에 대해 지체 없이 조치하겠습니다.</li>
                <li>③ 정보주체가 개인정보의 오류 등에 대한 정정 또는 삭제를 요구한 경우 국회는 정정 또는 삭제를 완료할 때까지 당해 개인정보를 이용하거나 제공하지 않습니다.</li>
                <li>④ 제 1항에 따른 권리행사는 정보주체의 법정대리인이나 위임을 받은 자 등 대리인을 통하여 하실 수 있습니다. 이 경우 개인정보 보호법 시행규칙 별지 제 11호 서식에 따른 위임장을 제출하셔야 합니다.</li>
                <li>⑤ 정보주체는 개인정보 보호법 등 관계법령을 위반하여 국회가 처리하고 있는 정보주체 본인이나 타인의 개인정보 및 사생활을 침해하여서는 안됩니다.</li>
                </ol>
            </li>
            <li>
                <strong class="tit">제 4조 [처리하는 개인정보 항목]</strong>
                <p>국회는 다음의 개인정보 항목을 처리하고 있습니다.</p>
                <ul class="ty_A">
                <li>회원가입 및 관리
                    <ul class="ty_B">
                    <li>필수항목 : 닉네임</li>
                    </ul>
                </li>
                <li>인터넷 서비스 이용과정에서 아래 개인정보 항목이 자동으로 생성되어 수집될 수 있습니다.
                    <ul class="ty_B">
                    <li>IP주소, 쿠키, MAC주소, 서비스 이용기록, 방문기록, 불량 이용기록 등</li>
                    </ul>
                </li>
                </ul>
            </li>
            <li>
                <strong class="tit">제 5조 [개인정보의 파기]</strong>
                <ol>
                    <li>① 국회는 개인정보 보유기간의 경과, 처리목적 달성 등 개인정보가 불필요하게 되었을 때에는 지체 없이 해당 개인정보를 파기합니다.</li>
                    <li>② 정보주체로부터 동의 받은 개인정보 보유기간이 경과하거나 처리목적이 달성되었음에도 불구하고 다른 법령에 따라 개인정보를 계속 보존하여야 하는 경우에는, 해당 개인정보(또는 개인정보파일)을 별도의 데이터베이스(DB)로 옮기거나 보관장소를 달리하여 보존합니다.</li>
                    <li>③ 개인정보 파기의 절차 및 방법은 다음과 같습니다.
                        <ul class="ty_B">
                        <li>파기절차
                            <p>국회는 파기하여야 하는 개인정보(또는 개인정보파일)에 대해 개인정보 파기계획을 수립하여 파기합니다. 국회는 파기 사유가 발생한 개인정보(또는 개인정보파일)를 선정하고, 개인정보 보호책임자의 승인을 받아 개인정보(또는 개인정보파일)를 파기합니다.</p>
                        </li>
                        </ul>
                    </li>
                    <li>
                        <ul class="ty_B">
                        <li>파기방법
                            <p>국회는 전자적 파일 형태로 기록&#183;저장된 개인정보는 기록을 재생할 수 없는 방법을 이용하여 파기하며, 종이 문서에 기록&#183;저장된 개인정보는 분쇄기로 분쇄하거나 소각하여 파기합니다.</p>
                        </li>
                        </ul>
                    </li>
                </ol>
            </li>
            <li>
                <strong class="tit">제 6조 [개인정보의 안전성 확보조치]</strong>
                <ol>
                <li>① 국회는 개인정보의 안전성 확보를 위해 다음과 같은 조치를 취하고 있습니다.
                    <ul class="ty_B">
                    <li>관리적 조치 : 내부관리계획 수립&#183;시행, 정기적 직원 교육 등</li>
                    <li>기술적 조치 : 개인정보처리시스템 등의 접근권한 관리, 접근통제시스템 설치, 보안프로그램 설치</li>
                    <li>물리적 조치 : 자료가 저장된 공간(전산실) 등의 접근통제</li>
                    </ul>
                </li>
                </ol>
            </li>
            <li>
                <strong class="tit">제 7조 [개인정보보호 책임자]</strong>
                <ol>
                <li>① 국회는 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와 관련한 정보주체의 불만처리 및 피해구제 등을 위하여 아래와 같이 개인정보 보호책임자를 지정하고 있습니다.
                    <ul class="ty_A">
                    <li>개인정보보호 책임자
                        <ul class="ty_B">
                        <li>성명 : 최동석</li>
                        <li>담당부서 : 시민안전국</li>
                        <li>연락처 : 02-2680-2033</li>
                        <li>팩스 : 02-2680-6958</li>
                        <li>이메일 : cds1038@korea.kr</li>
                        </ul>
                        <p>※ 개인정보 보호 담당부서로 연결됩니다.</p>
                    </li>
                    <li>개인정보보호 담당자
                        <ul class="ty_B">
                        <li>담당부서 : 정보통신과</li>
                        <li>담당자 : 송지형</li>
                        <li>연락처 : 02-2680-2305</li>
                        <li>팩스 : 02-2680-6145</li>
                        <li>이메일 : cds1038@korea.kr</li>
                        </ul>
                    </li>
                    </ul>
                </li>
                </ol>
            </li>
            <li>
                <strong class="tit">제 8조 [개인정보 처리방침의 변경]</strong>
                <p>이 개인정보처리방침은 시행일로부터 적용되며, 법령 및 방침에 따른 변경내용의 추가, 삭제 및 정정이 있는 경우에는 변경사항의 시행 7일 전부터 공지사항을 통하여 고지할 것입니다.</p>
            </li>
            <li>
                <strong class="tit">제 9조 [권익침해 구제방법]</strong>
                <p>개인정보주체는 개인정보침해로 인한 구제를 받기 위하여 개인정보분쟁조정위원회, 한국인터넷진흥원 개인정보침해신고센터 등에 분쟁해결이나 상담 등을 신청할 수 있습니다. 이밖에 기타 개인정보침해의 신고 및 상담에 대하여는 아래의 기관에 문의하시기를 바랍니다.</p>
                <ol>
                <li>1. 개인정보보호 종합지원 포털(행정자치부 운영)
                    <ul class="ty_C">
                    <li>소관업무 : 개인정보 침해사실 신고, 상담신청, 자료제공</li>
                    <li>홈페이지 : www.privacy.go.kr</li>
                    <li>전화 : (국번없이) 118</li>
                    </ul>
                </li>
                <li>2. 개인정보 침해신고센터(한국인터넷진흥원 운영)
                    <ul class="ty_C">
                    <li>소관업무 : 개인정보 침해사실 신고, 상담신청</li>
                    <li>홈페이지 : privacy.kisa.or.kr</li>
                    <li>전화 : (국번없이) 118</li>
                    <li>주소 : (138-950) 서울시 송파구 중대로 135 한국인터넷진흥원 개인정보침해신고센터</li>
                    </ul>
                </li>
                <li>3. 개인정보 분쟁조정위원회(한국인터넷진흥원 운영)
                    <ul class="ty_C">
                    <li>소관업무 : 개인정보 분쟁조정신청, 집단분쟁조정(민사적 해결)</li>
                    <li>홈페이지 : privacy.kisa.or.kr</li>
                    <li>전화 : (국번없이) 118</li>
                    <li>주소 : (138-950) 서울시 송파구 중대로 135 한국인터넷진흥원 개인정보침해신고센터</li>
                    </ul>
                </li>
                <li>4. 경찰청 사이버테러대응센터
                    <ul class="ty_C">
                    <li>소관업무 : 개인정보 침해 관련 형사사건 문의 및 신고</li>
                    <li>홈페이지 : www.netan.go.kr</li>
                    <li>전화 : (국번없이) 182</li>
                    </ul>
                </li>
                </ol>
            </li>
            </ol>
            </div></div>
            <p class="chk personalInformation_agree"><input type="checkbox" id="personalInformation_agree" name="agree1Yn" value="Y" class="chk" /> <label for="personalInformation_agree">개인정보 이용약관에 동의합니다.</label></p>
        </section>
        </fieldset>
        <fieldset>
        <legend>서비스 이용약관</legend>
        <section class="section_agreement"> 
            <h4 class="ty_A">서비스 이용약관</h4>
            <div class="box_B area_service_agreement area_agreement"><div class="service_agreement">
            <ol>
	        <li>
	            <strong class="tit">제 1조 [목적]</strong>
	            <p>이용약관(이하 '약관'이라 합니다)은 국회(본청, 직속기관 및 사업소, 동주민센터 이하 ‘국회’))가 국회 공공데이터 개방 서비스의 이용에 관한 제반 사항과 기타 필요한 사항을 규정함을 목적으로 합니다.</p>
	        </li>
	        <li>
	            <strong class="tit">제 2조 [용어의 정의]</strong>
	            <ol>
	            <li>① 이 약관에서 사용하는 용어의 정의는 다음 각호와 같습니다.
	                <ol>
	                <li>가. 국회 공공데이터 개방 서비스라 함은 시민이 자발적인 참여를 통해 자유롭게 정보를 공유하고 창조적인 서비스를 생산할 수 있도록 하기 위하여 국회가 제공&#183;운영하는 Open API 서비스, 파일변환저장, 다운로드 등의 서비스를 말합니다.</li>
	                <li>나. 데이터 제공기관이라 함은 국회 공공데이터 개방 서비스를 위해 보유한 데이터를 제공하는 국회를 말합니다.</li>
	                <li>다. API라 함은 Application Programming Interface의 약자로서 국회 공공데이터 개방 서비스를 시민이 자신이 구축한 사이트에서 자유롭게 사용할 수 있도록 국회가 제공하는 등록 값의 집합을 말합니다.</li>
	                <li>라. Open API 서비스라 함은 국회가 운영하는 API(Application Programming Interface)를 시민에게 개방하거나 제공하는 등의 서비스를 말합니다.</li>
	                <li>마. 인증Key라 함은 API 서비스 이용허가를 받은 사람임을 식별할 수 있도록 국회가 공공데이터 개방 서비스 회원에게 개별적으로 할당하는 고유한 값을 말합니다.</li>
	                <li>바. 파일변환저장이라 함은 국회가 데이터베이스 정보를 데이터파일로 변환 저장하는 기능을 제공하는 것을 말합니다.</li>
	                <li>사. 다운로드라 함은 국회가 데이터파일을 저장할 수 있는 기능을 제공하는 것을 말합니다.</li>
	                </ol>
	            </li>
	            <li>② 이 약관에서 명시되지 않은 사항에 대해서는 공공데이터의 제공 및 이용 활성화에 관한 법률(법률 제 12844호) 등 관계법령 및 공공데이터의 제공 및 이용 활성화에 관한 법률 시행령(대통령령 제 25751호), 공공데이터의 제공 및 이용 활성화에 관한 법률 시행규칙(행정자치부령 제 1호)에 따르며, 그 외에는 일반 관례에 따릅니다.</li>
	            </ol>
	        </li>
	        <li>
	            <strong class="tit">제 3조 [적용 범위]</strong>
	            <ol>
	                <li>① 본 약관은 국회 공공데이터 개방 서비스 회원에 가입한 후, 본 약관에 동의한 자(이하 “회원”이라 합니다)에 대하여 적용합니다. 회원으로 가입하시면 국회 공공데이터 개방 서비스를 제한 없이 자유롭게 활용하실 수 있습니다.</li>
	                <li>② 본 약관은 회원 또는 비회원에 대한 국회 공공데이터 개방 서비스 제공행위 및 회원 또는 비회원의 국회 공공데이터 개방 서비스 이용행위에 대하여 우선적으로 적용됩니다.</li>
	                <li>③ 본 약관에서 규정하지 않은 인증Key 발급 등 회원 관리에 관한 제반 사항은 국회 통합회원 관리정책을 준용합니다.</li>
	            </ol>
	        </li>
	        <li>
	            <strong class="tit">제 4조 [이용약관의 효력 및 변경]</strong>
	            <ol>
	            <li>① 본 이용약관은 서비스의 이용을 위하여 회원 또는 비회원이 동의를 함으로써 효력이 발생합니다.</li>
	            <li>② 국회는 합리적인 사유가 발생할 경우 본 약관을 변경할 수 있으며, 이 경우 일정한 기간을 정하여 적용일자 및 변경사유를 명시한 사항을 회원 또는 비회원에게 공지 또는 통지합니다.</li>
	            <li>③ 제 2항에 따른 약관의 변경은 회원 또는 비회원이 동의함으로써 그 효력이 발생됩니다. 다만, 제 2항에 따른 통지를 하면서 회원 또는 비회원에게 일정한 기간 내에 의사표시를 하지 않으면 의사표시가 표명된 것으로 본다는 뜻을 명확히 전달하였음에도 회원 또는 비회원이 명시적으로 거부의 의사표시를 하지 아니한 경우에는 회원 또는 비회원이 개정약관에 동의한 것으로 봅니다.</li>
	            <li>④ 회원 또는 비회원은 국회 공공데이터 개방 서비스를 이용할 시 주기적으로 공지사항을 확인하여야 할 의무가 있습니다.</li>
	            <li>⑤ 약관의 변경 사실 및 내역을 확인하지 못하여 발생한 모든 손해에 대한 책임은 회원 또는 비회원에게 귀속됩니다.</li>
	            </ol>
	        </li>
	        <li>
	            <strong class="tit">제 5조 [국회 공공데이터 개방 서비스의 이용]</strong>
	            <ol>
	            <li>① 공공데이터 개방 서비스의 모든 서비스는 본 약관에 동의한 회원 또는 비회원에 한하여 제공합니다. 다만, 활용갤러리 및 Open API 서비스는 회원에 한하여 제공하며 회원이 Open API 서비스를 이용하고자 하는 경우에는 회원가입 이외에 별도로 Open API 서비스 페이지를 통해 인증Key를 발급 받아야 합니다.</li>
	            <li>② 활용갤러리 및 Open API 서비스 이외의 국회 공공데이터 개방 서비스의 경우에는 별도의 회원자격을 요구하지 않으며, 본 약관에 동의한 경우 제한 없이 이용이 가능합니다.</li>
	            </ol>
	        </li>
	        <li>
	            <strong class="tit">제 6조 [Open API 서비스의 제한]</strong>
	            <ol>
	            <li>① 국회는 특정 Open API 서비스의 범위를 제한하거나 별도의 이용가능 시간 또는 이용가능 횟수를 지정할 수 있으며, 관련 법률 개정으로 인해 Open API 서비스 제공 대상이 변경되어 더 이상 활용을 할 수 없을 경우, 서비스 활용으로 인해 제공기관의 업무에 지장을 초래하거나 인프라 성능 등의 이유로 서비스 제공 상의 성능 문제가 발생한 경우 활용을 제한할 수 있습니다. 이 경우 이를 회원에게 사전에 고지하여야 합니다.</li>
	            <li>② 국회는 회원이 Open API 서비스를 이용함에 있어 법령을 위반하거나 약관 또는 서비스 이용기준 등을 위반한 경우, 제공된 정보를 임의로 위조&#183;변조하여 저작권을 위반하는 경우에는 제 1항의 규정에도 불구하고 즉시 인증Key의 이용을 정지하는 등의 조치를 취할 수 있습니다.</li>
	            <li>③ 국회는 회원이 Open API 서비스에 대한 불법적인 해킹 시도, 비정상적인 방식을 통한 오남용 시도, 네트워크 사용 초과 등의 시도를 하는 경우 제 1항의 규정에도 불구하고 즉시 인증Key의 사용을 정지시킬 수 있습니다.</li>
	            <li>④ 국회는 회원이 Open API 서비스를 활용함에 있어, 일정량 이상의 트래픽을 유발하는 경우, Open API 활용사례 등록을 강제할 수 있습니다. 이러한 규정에도 불구하고, 활용사례를 등록하지 않을 경우 해당 인증Key의 사용을 제한할 수 있습니다.</li>
	            </ol>
	        </li>
	        <li>
	            <strong class="tit">제 7조 [인증Key의 이용 및 관리]</strong>
	            <ol>
	            <li>① 회원은 발급 받은 인증Key를 타인에게 제공&#183;공개하거나 공유할 수 없으며, 발급 받은 회원 본인에 한하여 이를 사용할 수 있습니다.</li>
	            <li>② 국회는 인증Key를 발급함에 있어 이용기간을 지정할 수 있으며, 이용기간을 변경하고자 하는 경우에는 사전에 이를 고지하여야 합니다.</li>
	            </ol>
	        </li>
	        <li>
	            <strong class="tit">제 8조 [국회 공공데이터 개방 서비스 이용시의 주의사항]</strong>
	            <ol>
	            <li>① 국회는 관계법령의 제&#183;개정 및 기타 정책적 사유 등에 따라 국회 공공데이터 개방 서비스를 변경하거나 중단할 수 있습니다.</li>
	            <li>② 국회는 경국회 공공데이터 개방 서비스를 운영함에 있어 데이터의 특정 범위를 분할하거나 또는 전체에 대하여 별도의 이용가능 시간 또는 이용가능 횟수를 지정할 수 있으며 이를 사전에 고지하여야 합니다.</li>
	            <li>③ 회원 또는 비회원은 국회 공공데이터 개방 서비스를 이용한 검색결과를 노출함에 있어 선정적, 폭력적, 혐오적인 내용을 포함하여 반사회적, 비도덕적, 불법적인 내용과 결합 또는 연계하거나 인접하도록 구성할 수 없으며, 검색결과의 공공성을 준수하여야 합니다.</li>
	            <li>④ 국회는 국회 공공데이터 개방 서비스를 이용한 검색결과와 함께 광고를 게재할 권리를 가집니다. 다만 광고를 게재하고자 할 경우 사전에 회원 또는 비회원에게 이를 공지 또는 통지합니다.</li>
	            <li>⑤ 국회는 개인정보 보호정책을 공시하고 준수합니다.</li>
	            </ol>
	        </li>
	        <li>
	            <strong class="tit">제 9조 [회원 또는 비회원의 의무]</strong>
	            <ol>
	            <li>① 회원 또는 비회원은 국회 공공데이터 개방 서비스를 이용함에 있어서 본 약관에서 규정하는 사항과 기타 국회가 정한 제반 규정, 공지사항 및 관계법령을 준수하여야 하며, 국회의 업무에 방해가 되는 행위 또는 국회의 명예를 손상시키는 행위를 해서는 안됩니다.</li>
	            <li>② 국회 공공데이터 개방 서비스를 이용함에 있어서 회원 또는 비회원의 행위에 대한 모든 책임은 당사자가 부담하며, 회원은 국회를 대리하는 것으로 오해가 될 수 있는 행위를 해서는 안됩니다.</li>
	            </ol>
	        </li>
	        <li>
	            <strong class="tit">제 10조 [국회 공공데이터 개방 서비스 저작권]</strong>
	            <ol>
	            <li>① 회원 또는 비회원은 국회 공공데이터 개방 서비스 이용 시 국회 및 제 3자의 지적재산권을 침해해서는 안됩니다.</li>
	            <li>② 국회가 제공하는 API 및 데이터파일, 검색결과 등에 대한 저작권은 국회 혹은 제 3자에 있고, 국회의 이용허락으로 인해 회원 또는 비회원이 당해 API 및 데이터파일, 검색결과 등에 대한 저작권을 취득하는 것은 아닙니다. 다만, 회원이 제작한 프로그램에 대한 저작권은 회원 또는 비회원에게 귀속됩니다.</li>
	            <li>③ 회원 또는 비회원은 국회 공공데이터 개방 서비스를 이용하여 검색결과를 노출할 경우, 해당 페이지에 "국회 공공데이터"를 사용한 결과임을 명시해야 합니다. 다만, 국회가 별도의 표시방식을 정한 경우에는 그에 따라야 합니다.</li>
	            </ol>
	        </li>
	        <li>
	            <strong class="tit">제 11조 [API 및 데이터파일 이용허락 조건]</strong>
	            <p>국회는 국회 공공데이터 개방 서비스에서 제공하는 데이터에 대하여 저작자 및 출처 표시 조건으로 자유이용을 허락함을 원칙으로 합니다.
	            단, 국회 이외에 제 3자에게 저작권이 귀속된 개별 API 및 데이터파일에 대하여는 해당 저작권자의 이용허락 조건에 따릅니다.</p>
	        </li>
	        <li>
	            <strong class="tit">제 12조 [책임의 제한]</strong>
	            <ol>
	            <li>① 공공데이터 개방 서비스에서 제공하는 서비스 및 데이터에 대한 책임은 데이터를 보유한 제공기관에게 귀속됩니다. 국회는 국회 공공데이터 개방 서비스에 관하여 약관, 서비스별 안내, 기타 국회가 정한 이용기준 및 관계법령을 준수하지 않은 이용으로 인한 결과에 대하여 책임을 지지 않습니다.</li>
	            <li>② 국회는 국회 공공데이터 개방 서비스의 사용불능으로 인하여 회원 또는 비회원에게 발생한 손해에 대하여 책임을 지지 않습니다.</li>
	            <li>③ 국회는 회원 또는 비회원이 국회 공공데이터 개방 서비스를 이용하여 기대하는 수익을 얻지 못하거나 상실한 것에 대하여 책임을 지지 않습니다.</li>
	            <li>④ 국회는 회원&#183;비회원&#183;제 3자 상호 간에 국회 공공데이터 개방 서비스를 매개로 발생한 분쟁에 대해 개입할 의무가 없으며, 이로 인한 손해를 배상할 책임도 없습니다.</li>
	            </ol>
	        </li>
	        <li>
	            <strong class="tit">제 13조 [이용자격 박탈 및 손해배상]</strong>
	            <ol>
	            <li>① 국회는 회원 또는 비회원이 본 이용약관을 준수하지 않는 경우 서비스 사용 중지 및 이용자격을 박탈할 수 있습니다.</li>
	            <li>② 국회 공공데이터 개방 서비스 이용상 회원 또는 비회원의 귀책사유로 인하여 국회에 손해가 발생한 경우 국회는 본 약관에 따른 계약의 해지와는 별도로 손해배상을 청구할 수 있습니다.</li>
	            <li>③ 국회 공공데이터 개방 서비스의 이용으로 국회와 회원 또는 비회원간에 발생한 분쟁에 관하여 소송이 제기되는 경우 각 당사자는 자신의 주소지를 관할하는 법원에 소송을 제기할 수 있습니다.</li>
	            </ol>
	        </li>
	        <li>
	            <strong class="tit">&lt;부칙&gt; 제 1조 [시행일]</strong> 
	            <p>본 약관은 2018년 3월 15일부터 적용됩니다.</p>
	        </li>
	        </ol>
            </div></div>
            <p class="chk personalInformation_agree"><input type="checkbox" id="service_agree" name="agree2Yn" value="Y" class="chk" /> <label for="service_agree">서비스 이용약관에 동의합니다.</label></p>
        </section>
        </fieldset>
        <fieldset>
        <legend>개인정보 입력</legend>
        <section>
            <h4 class="ty_A">개인정보 입력</h4>
            <div class="area_desc_AB">
                <p class="p_tyC"><img src="<c:url value="/img/ggportal/desktop/common/bul_requisite.png" />" class="valM" alt="" title="필수입력 항목 아이콘" /> 필수입력 항목입니다.</p>
            </div>
            <table class="table_datail_AB w_1">
            <caption>개인정보 입력</caption>
            <tbody>
            <tr>
                <th scope="row"><label for="name"><strong>닉네임<span>필수입력</span></strong></label></th>
                <%--
                <c:choose>
                <c:when test="${!empty sessionScope.PortalLoginVO.userNm}">
                <td class="ty_AB ty_B"><input type="text" id="name" name="userNm" value="<c:out value="${sessionScope.PortalLoginVO.userNm}" />" autocomplete="on" class="f_110px" style="ime-mode:active;" readonly="readonly" /></td>
                </c:when>
                <c:otherwise>
                <td class="ty_AB ty_B"><input type="text" id="name" name="userNm" value="<c:out value="${sessionScope.PortalLoginVO.userNm}" />" autocomplete="on" class="f_110px" style="ime-mode:active;" /></td>
                </c:otherwise>
                </c:choose>
                --%>
                <td class="ty_AB ty_B"><input type="text" id="name" name="userNm" value="<c:out value="${sessionScope.PortalLoginVO.userNm}" />" autocomplete="on" class="f_110px" style="ime-mode:active;" /></td>
            </tr>
            <%--
            <tr>
                <th scope="row"><label for="telephone">연락처</label></th>
                <td class="ty_AB ty_B">
            --%>
                    <%--
                    <select id="telephone" name="userTel1" style="width:50px;" title="전화번호 앞번호 선택"></select> -
                    --%>
            <%--
                    <input type="tel" id="telephone"   name="userTel1" value="<c:out value="${sessionScope.PortalLoginVO.userTelSplit1}" />" pattern="[0-9]{3}" autocomplete="on" style="width:50px; ime-mode:disabled;" /> -
                    <input type="tel" id="telephone_2" name="userTel2" value="<c:out value="${sessionScope.PortalLoginVO.userTelSplit2}" />" pattern="[0-9]{4}" autocomplete="on" style="width:49px; ime-mode:disabled;" /> -
                    <input type="tel" id="telephone_3" name="userTel3" value="<c:out value="${sessionScope.PortalLoginVO.userTelSplit3}" />" pattern="[0-9]{4}" autocomplete="on" style="width:49px; ime-mode:disabled;" />
                </td>
            </tr>
            <tr>
                <th scope="row"><label for="eMail"><strong><abbr title="electronic mail">E-mail</abbr><span>필수입력</span></strong></label></th>
                <td class="ty_AB ty_B">
                    <div class="area_form">
                        <c:choose>
                        <c:when test="${!empty sessionScope.PortalLoginVO.userEmailSplit1 && !empty sessionScope.PortalLoginVO.userEmailSplit2}">
                        <input type="email" id="eMail" name="userEmail1" value="<c:out value="${sessionScope.PortalLoginVO.userEmailSplit1}" />" class="flL f_170px f_46per" title="E-mail ID" placeholder="E-mail ID" autocomplete="on" style="ime-mode:disabled;" readonly="readonly" />
                        <span class="txt talC f_8per_mq_mobile">@</span>
                        <input type="email" id="eMail_2" name="userEmail2" value="<c:out value="${sessionScope.PortalLoginVO.userEmailSplit2}" />" class="flL f_110px f_46per" title="E-mail 주소" placeholder="E-mail address" autocomplete="on" style="ime-mode:disabled;" readonly="readonly" />
                        <span class="f_mgT3_mq_mobile f_100per_mq_mobile">
                            <span class="divi_select paL0_mq_mobile f_46per_mq_mobile">
                                <select id="eMail_3" name="userEmail3" class="f_100per_mq_mobile" disabled="disabled" title="이메일 주소 번지 선택"></select>
                            </span>
                            <span class="chk divi_form divi_form_AC f_46per_mq_mobile"><input type="checkbox" id="emailAgree" name="emailYn" value="Y" /><label for="emailAgree">수신동의</label></span>
                        </span>
                        </c:when>
                        <c:otherwise>
                        <input type="email" id="eMail" name="userEmail1" value="<c:out value="${sessionScope.PortalLoginVO.userEmailSplit1}" />" class="flL f_170px f_46per" title="E-mail ID" placeholder="E-mail ID" autocomplete="on" style="ime-mode:disabled;" />
                        <span class="txt talC f_8per_mq_mobile">@</span>
                        <input type="email" id="eMail_2" name="userEmail2" value="<c:out value="${sessionScope.PortalLoginVO.userEmailSplit2}" />" class="flL f_110px f_46per" title="E-mail 주소" placeholder="E-mail address" autocomplete="on" style="ime-mode:disabled;" />
                        <span class="f_mgT3_mq_mobile f_100per_mq_mobile">
                            <span class="divi_select paL0_mq_mobile f_46per_mq_mobile">
                                <select id="eMail_3" name="userEmail3" class="f_100per_mq_mobile" title="이메일 주소 번지 선택"></select>
                            </span>
                            <span class="chk divi_form divi_form_AC f_46per_mq_mobile"><input type="checkbox" id="emailAgree" name="emailYn" value="Y" /><label for="emailAgree">수신동의</label></span>
                        </span>
                        </c:otherwise>
                        </c:choose>
                    </div>
                </td>
            </tr>
            --%>
            </tbody>
            </table>
        </section>
        </fieldset>
        <div class="area_btn_E">
            <a id="oauth-insert-button" href="#" class="btn_E">저장하기</a>
            <a id="oauth-cancel-button" href="#" class="btn_EB">취소하기</a>
        </div>
        </form>
        </div>
    </div>
    <!-- // content -->
</div>
<!-- // layout_flex -->
</div></div>
<!-- // wrap_layout_flex -->
<%@ include file="/WEB-INF/jsp/ggportal/sect/footer.jsp" %>
</div>
<!-- // layout_A -->
</body>
</html>
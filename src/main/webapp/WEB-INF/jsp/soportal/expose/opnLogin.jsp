<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="com.nprotect.pluginfree.PluginFree" %>
<%@page import="com.nprotect.pluginfree.PluginFreeException" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)opnLogin.jsp 1.0 2019/08/12                                        --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 정보공개 > 본인확인                      	                                --%>
<%--                                                                        --%>
<%-- @author SoftOn                                                         --%>
<%-- @version 1.0 2021/06/09                                                --%>
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
            <h3>사용자인증<span class="arrow"></span></h3>
        </div>
        <div class="layout_flex">
            <!-- content -->
            <div class="layout_flex_100">
                <h2 class="hide">본인확인</h2>
                <div class="area_h3 area_h3_AB deco_h3_3">
                    <h3 class="ty_A"><strong>본인확인</strong></h3>
                    <p>본인인증 방식 <strong class="point-color02" style="vertical-align: top;">3가지 중 한가지 방식을 선택</strong>하여 진행
                        하셔야 합니다.</p>
                </div>
                <br>
                <div style="border:1px solid; padding:20px;">
                    <p>
                        [정보공개 청구 관련 변경사항 안내]<br>
                        <br>
                        「공공기관의 정보공개에 관한 법률」 개정에 따라 정보공개 청구 시 변경된 사항을 다음과 같이 안내해드립니다(2021년 6월 23일부터 시행).<br>
                        <span style="margin-left :15px;">○ 정보공개 청구서 작성 시 : 주민등록번호 대신 생년월일 기재</span><br>
                        <span style="margin-left :15px;">○ 주민등록번호를 통한 실명인증 → 휴대폰이나 공동인증서(구 공인인증서) 또는 아이핀 등을 통한 본인인증</span><br>
                        <br>
                        ※ 2021년 6월 23일 이전 정보공개 청구 건에 대한 이의신청 방법<br>
                        <span style="margin-left :15px;">○ 열린국회정보포털 회원가입 → 마이페이지 → 청구기본정보수정 → 청구서 불러오기(확인 후 저장)  → 이의신청</span><br>
                        <br>
                        문의사항: 국회민원지원센터(T.02-6788-2064)
                    </p>
                </div>
                <form name="form" method="post" class="form-horizontal" action="/portal/expose/openLogin.do">
                    <input type="hidden" name="url" value="${requestScope.URL }"/>
                    <input type="hidden" id="portalUserCd" value="${sessionScope.portalUserCd}" title="회원 코드">
                </form>
                <fieldset>
                    <legend>실명인증</legend>
                    <section>
                        <div class="join_step02">
                            <dl id="layoutContents">
                                <dt>
                                    <h4><img src="/img/icon_acc01.png" alt=""><span>아이핀 인증</span></h4>
                                    <span>아이핀(I-PIN) 으로<br>본인인증을 하실 수 있습니다.</span>
                                    <p><a href="javascript:void(0);" id="btnIpin" title="새창-아이핀 인증">아이핀 인증</a></p>
                                    <!-- 아이핀 팝업을 호출하기 위한 form 입니다. -->
                                    <form id="form_ipin" name="form_ipin" method="post"
                                          action="https://ipin.ok-name.co.kr/CommonSvl" target="popupIPIN">
                                        <!-- 필수 데이터로 누락하시면 안됩니다. -->
                                        <input type="hidden" name="cpCd" value="">
                                        <input type="hidden" name="mdlTkn" value="">
                                        <input type="hidden" name="tc" value="kcb.tis.ti.cmd.LoginRPCert3Cmd"/>
                                    </form>
                                </dt>
                                <%--
                                    <dt>
                                        <h4><img src="/img/icon_acc02.png" alt="휴대전화 인증"><span>휴대전화 본인인증</span></h4>
                                        <span>본인확인 서비스로<br>본인인증을 하실 수 있습니다</span>
                                        <p><a href="javascript:void(0);" id="btnKcb" title="새창-휴대전화 인증">휴대전화 인증</a></p>
                                        <!-- 본인인증 서비스 팝업을 호출하기 위해서는 다음과 같은 form이 필요합니다. -->
                                        <form id="form_chk" name="form_chk" method="post" action="https://safe.ok-name.co.kr/CommonSvl" target="popupChk">
                                            <input type="hidden" name="cp_cd" value="">
                                            <input type="hidden" name="mdl_tkn" value="">
                                            <input type="hidden" name="tc" value="kcb.oknm.online.safehscert.popup.cmd.P931_CertChoiceCmd">
                                        </form>
                                    </dt>
                                --%>
                                <%-- 국회사무처 휴대폰 인증 모듈이 KMC로 변경됨에 따라 수정 --%>
                                <%-- Edited by giinie on 2021-10-28 --%>
                                <dt>
                                    <h4><img src="/img/icon_acc02.png" alt="">
                                        <span>휴대전화 본인인증</span>
                                    </h4>
                                    <span>본인확인 서비스로<br>본인인증을 하실 수 있습니다</span>
                                    <p><a href="javascript:void(0);" id="btnKmc" title="새창-휴대전화 인증">휴대전화 인증</a></p>
                                    <!-- 본인인증 서비스 팝업을 호출하기 위해서는 다음과 같은 form이 필요합니다. -->
                                    <form id="form_chk" name="form_chk"
                                          method="post"
                                          action="https://www.kmcert.com/kmcis/web/kmcisReq.jsp"
                                          target="popupChk">
                                        <!-- 인증 요청 정보 -->
                                        <!--// 필수 항목 -->
                                        <!-- 전송 데이터 -->
                                        <input type="hidden" name="tr_cert" value=""/>
                                        <!-- 결과 수신 URL -->
                                        <input type="hidden" name="tr_url" value=""/>
                                        <!-- Iframe 사용여부 -->
                                        <input type="hidden" name="tr_add" value=""/>
                                        <!-- 필수 항목 //-->
                                    </form>
                                </dt>
                                <dt>
                                    <h4><img src="/img/icon_acc03.png" alt="">
                                        <span>공동인증서 본인인증</span>
                                    </h4>
                                    <span>본인확인 서비스로<br>본인인증을 하실 수 있습니다</span>
                                    <p><a href="javascript:void(0);" id="btnNice" title="새창-공동인증서 본인인증">공동인증서</a></p>
                                    <%-- NICE 본인인증(공동인증서) --%>
                                    <form id="form_nice" name="form_nice" method="post"
                                          action="https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb" target="popupChk">
                                        <!--// 필수 항목 -->
                                        <!-- 전송 데이터 -->
                                        <input type="hidden" title="m" name="m" value="checkplusSerivce"/>
                                        <!-- 암호화한 업체 정보 -->
                                        <input type="hidden" title="EncodeData" name="EncodeData" value=""/>
                                        <!-- 필수 항목 //-->
                                    </form>
                                </dt>
                            </dl>
                        </div>

                        <div class="exp_acc_desc">
                            ※ 개정된 공공기관의 정보공개에 관한 법률에 의하여 주민등록번호를 통한 실명인증 대신 본인 명의의 휴대폰 인증으로 본인 확인이 가능합니다.<br>
                            ※ 휴대폰 인증이 어려운 사용자는 공동인증서(구 공인인증서)로 본인확인을 하시거나 혹은 아이핀 인증을 통해 본인확인을 하시기 바랍니다.<br>
                            ※ 로그인하시면, 청구인 정보를 마이페이지에 저장하실 수 있습니다.
                        </div>

                    </section>
                </fieldset>
            </div>
            <!-- // content -->
        </div>
        <!-- // layout_flex #################### -->
    </div>
</div>

<!-- footer -->
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
<script type="text/javascript" src="<c:url value="/js/soportal/expose/nasCommon.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/soportal/expose/opnLogin.js" />"></script>
</body>
</html>
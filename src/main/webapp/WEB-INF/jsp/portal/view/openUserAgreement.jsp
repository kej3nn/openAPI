<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)userAgreement.jsp 1.0 2015/06/15                                   --%>
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
<%-- 서비스이용약관을 조회하는 화면이다.
<%-- 
<%-- @author jhkim
<%-- @version 1.0 2019/11/25
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
</head>
<body>
<!-- layout_A -->
<div class="wrapper" id="wrapper">
<%@ include file="/WEB-INF/jsp/portal/sect/headerOpen.jsp" %>

<section>
	<div class="container" id="container">
	<!-- leftmenu -->
	<%@ include file="/WEB-INF/jsp/portal/sect/lnb.jsp" %>
	<!-- //leftmenu -->
    <article>
		<div class="contents" id="contents">
			<div class="contents-title-wrapper">
				<h3>Open API 이용약관<span class="arrow"></span></h3>
        	</div>
        
	        <div class="layout_flex_100">
			<!-- CMS 시작 -->
			
				<div class="terms_txt">
					<strong>제1장 총칙</strong>
					
					<div>
						<strong>제1조(목적)</strong>
						<span>
							열린국회정보 Open API 이용약관(이하 “본 약관”이라 한다)은 열린국회정보 Open API 서비스(이하 “서비스”라 한다) 이용과 관련하여 국회와 이용자의 권리·의무·책임사항과 기타 필요한 사항을 규정함을 목적으로 합니다.
						</span>
					</div>
					
					<div>
						<strong>제2조(정의)</strong>
						<span>
							본 약관에서 사용하는 용어의 정의는 다음과 같습니다.
						</span>
						<ol>
							<li>“통합회원”이란 국회홈페이지 가입 신청 절차에 따라 회원 등록을 한 자로서 열린국회정보 등 국회에서 제공하는 여러 홈페이지(국회홈페이지, 위원회홈페이지, 입법예고시스템, 방문자센터홈페이지, 문화행사홈페이지, 전자청원시스템 등)의 서비스를 이용할 수 있는 자를 말합니다.</li>
							<li>“이용자”란 열린국회정보에 접속하여 이 약관에 따라 열린국회정보가 제공하는 서비스를 받는 회원 및 비회원을 말합니다.</li>
							<li>“Open API 서비스”란 국회가 운영하는 API(Application Programming Interface)를 국민에게 개방하거나 제공하는 등의 서비스를 말합니다.</li>
							<li>“Open API 인증키”란 Open API 서비스 이용허가를 받은 사람임을 식별할 수 있도록 국회가 열린국회정보 회원에게 개별적으로 할당하는 고유한 값을 말합니다.</li>
						</ol>
					</div>
					
					<strong>제2장 이용방법, 조건 및 절차</strong>
					
					<div>
						<strong>제3조(제공방법)</strong>
						<ul>
							<li>① Open API서비스 이용을 희망하는 자는 국회 홈페이지 통합회원 가입 및 Open API 서비스 인증키를 신청하여야 합니다.</li>
							<li>② 국회는 Open API 서비스 신청자에게 인증키를 부여하며, 이용자는 선량한 관리자의 주의의무를 다하여 인증키를 관리하여야 합니다.</li>
							<li>③ Open API 서비스는 연중무휴, 1일 24시간 운영을 원칙으로 합니다.</li>							
						</ul>
					</div>
					
					<div>
						<strong>제4조(정보의 상업적 이용)</strong>
						<ul>
							<li>① 국회는 이용자가 열린국회정보에서 제공하는 서비스를 이용하여 영업활동을 하는 경우, 그 결과에 대해 일체의 책임을 지지 않습니다.</li>
						</ul>
					</div>
					
					<div>
						<strong>제5조(금지사항)</strong>
						<span>
							이용자는 다음 각 호의 행위를 하지 않아야 합니다.
						</span>						
						<ol>
							<li>속임에 의한 이용자 사칭</li>
							<li>바이러스ㆍ웜 등 악성코드의 전파</li>
							<li>저작권 위반이나 『정보통신망 이용촉진 및 정보보호 등에 관한 법률』의 불법정보 등과 결합 또는 연계 이용</li>
							<li>Open API 연결방식의 위ㆍ변조</li>
							<li>Open API 인증키의 양도, 증여 및 담보 목적물 사용</li>
							<li>접근이 허용된 범위가 아님에도 권한 없이 접근을 시도하는 행위</li>
						</ol>
					</div>
					
					<div>
						<strong>제6조(서비스의 중단)</strong>
						<ul>
							<li>
								① 국회는 다음 각 호의 어느 하나에 해당하는 경우 국회 공개정보의 제공을 일시적으로 중단할 수 있습니다. 
								<ol>
									<li>정보시스템, 서버, 정보기기, 네트워크의 점검·교체 및 장애발생</li>
									<li>Open API 서비스 제공에 있어서의 기술적 결함이 발견되는 경우</li>
									<li>신규 Open API 서비스를 추가하는 경우</li>
								</ol>
							</li>
							<li>② 제5조의 금지사항이 발생하거나 이용자가 본 약관의 내용을 위반하는 경우 국회는 Open API 서비스 제공을 중단할 수 있으며, 법적 조치를 포함하여 필요한 조치를 취할 수 있습니다.</li>
							<li>③ 제1항에 의한 서비스 중단의 경우에는 국회는 제4항에서 정한 방법으로 이용자에게 통지합니다. 다만, 국회가 통제할 수 없는 사유로 인한 서비스의 중단(시스템 관리자의 고의·과실이 없는 정보시스템, 서버, 정보기기, 네트워크의 장애발생 등)으로 인하여 사전 통지가 불가능한 경우에는 그러하지 아니합니다.</li>
							<li>④ 서비스 중단의 경우에는 국회 공개정보 포털 게시판 및 서비스 화면에 게시함으로써 개별 통지에 갈음할 수 있습니다.</li>
						</ul>
					</div>
					
					<div>
						<strong>제7조(출처표시 의무)</strong>
						<span>이용자는 국회 공개정보를 이용함에 있어 열린국회정보에서 제공된 정보임을 표시하여야 합니다.</span>
						<span>
							※ 출처표시의 예<br>
						    <strong>- 출처 : 열린국회정보, 서비스 메뉴명, 2019.00.00.</strong>
						</span>
					</div>
					
					<div>
						<strong>제8조(이용변경 및 해지)</strong>
						<ul>
							<li>① 이용자는 성명, 연락처(전자우편 주소 포함)가 변경된 경우에는 이를 국회에 즉시 통보하여야 하며, 변경내용을 통보하지 않아 발생하는 손해에 대하여 국회는 일체의 책임을 지지 않습니다.</li>
							<li>② 이용자는 Open API 서비스의 이용을 원하지 않는 경우 이용관계를 해지할 수 있으며, 해지의사를 국회에 통보하여야 합니다.</li>
							<li>③ 국회는 이용자가 관련 법령 또는 본 약관을 위반한 경우에는 이용관계를 해지할 수 있습니다.</li>
						</ul>
					</div>
					
					<strong>제3장 기타</strong>
					
					<div>
						<strong>제9조(면책)</strong>
						<ul>
							<li>① 국회는 이용자가 본 약관의 내용을 준수하지 않아 발생한 손해에 대하여 일체의 책임을 지지 않습니다. </li>
							<li>② 국회 공개정보는 열린국회정보 포털 수록내용대로 제공하며, 국회는 국회 공개정보에 포함된 오류나 누락, Open API 서비스 장애 등으로 인한 손해에 대한 책임을 지지 않습니다. </li>
							<li>③ 국회는 이용자와 제3자간에 Open API 서비스를 매개로 발생한 분쟁에 대해 개입할 의무가 없으며, 이로 인한 손해배상책임도 없습니다.</li>							
							<li>④ 국회는 관련 법령에서 정하는 사항 외에 국회 공개정보와 관련된 진술, 보증, 의무, 책임을 부담하지 않습니다. </li>							
							<li>⑤ 국회는 국회 공개정보의 계속적 제공 또는 추가되는 국회 공개정보의 지속적 제공을 보장하지 않습니다.</li>							
						</ul>
					</div>
					
					<div>
						<strong>제10조(개인정보의 처리 및 보유기간)</strong>
						<ul>
							<li>
								① 국회는 법령에 따른 개인정보 보유·이용기간 또는 정보주체로부터 개인정보를 수집 시에 동의 받은 개인정보 보유·이용기간 내에서 개인정보를 처리·보유합니다.
								<ol>
									<li>필수 항목: 아이디, 비밀번호, 이름, 생년월일, 이메일</li>
									<li>선택항목: 휴대폰번호, 전화번호, 주소, 학교</li>
								</ol>
							</li>							
						</ul>
					</div>
					
					<div>
						<strong>제11조(개인정보의 파기)</strong>
						<ul>
							<li>① 국회는 개인정보 보유기간의 경과, 처리목적 달성 등 개인정보가 불필요하게 되었을 때에는 지체없이 해당 개인정보를 파기합니다. 다만, 다른 법률에 따라 보존하여야 하는 경우에는 그러하지 않습니다.</li>							
							<li>② 국회는 열린국회정보 개인정보 처리책임자의 책임 하에 전자적 파일 형태로 기록·저장된 개인정보는 기록을 재생할 수 없도록 파기하며, 종이 문서에 기록·저장된 개인정보는 분쇄기로 분쇄하거나 소각하여 파기합니다.</li>							
						</ul>
					</div>
					
					<div>
						<strong>제11조(재판관할)</strong>
						<ul>
							<li>① 서비스 이용과 관련하여 국회와 이용자 사이에 분쟁이 발생한 경우, 국회와 이용자는 발생한 분쟁을 원만하게 해결하기 위하여 필요한 모든 노력을 하여야 합니다.</li>							
							<li>② 제1항의 규정에도 불구하고 서비스 이용으로 발생한 분쟁에 대하여 소송이 제기될 경우 국회 소재지를 관할하는 법원을 관할법원으로 합니다.</li>							
						</ul>
					</div>
					
					<div>
						<strong>제12조(규정의 준용)</strong>
						<span>
							본 약관에 명시되지 않은 사항에 대해서는 「전기통신사업법」, 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」, 「개인정보 보호법」,「공공기관의 정보공개에 관한 법률」, 「공공데이터의 제공 및 이용 활성화에 관한 법률」등 관련 법령의 규정에 따릅니다.
						</span>
						<span>
							<br>이 약관은 (2020년 2월 17일)부터 시행합니다. <br><br>
						</span>
						<span>
							* 본 약관에 대한 저작권은 대한민국 국회에 귀속하며 무단 복제·배포·전송·기타 저작권 침해행위를 엄금합니다.
						</span>
					</div>
					
				</div>
			
			<!-- //CMS 끝 -->
			</div>
		</div>
	</article>
	
	</div>

</section>

</div></div>        
<!-- // wrap_layout_flex -->
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
</div>
<!-- // layout_A -->
</body>
</html>
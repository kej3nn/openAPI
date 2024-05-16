<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)privatePolicy.jsp 1.0 2015/06/15                                   --%>
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
<%-- 개인정보처리방침을 조회하는 화면이다.                                  --%>
<%--                                                                        --%>
<%-- @author 김춘삼                                                         --%>
<%-- @version 1.0 2015/06/15                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
</head>
<body>
<!-- layout_A -->
<div class="layout_A">
<%@ include file="/WEB-INF/jsp/portal/sect/header.jsp" %>


<section>
	<div class="container hide-pc-lnb" id="container">
	<article>
		<div class="contents" id="contents">
			<div class="contents-title-wrapper">
				<h3>개인정보 처리방침<span class="arrow"></span></h3>
       		</div>
			<div class="layout_flex_100">
				<div class="terms_txt">
				
					<div class="terms_desc">
						국회는 「개인정보 보호법」제30조에 따라 정보주체의 개인정보를 보호하고 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보 처리지침을 수립·공개합니다.
					</div>
					
					<div>
						<strong>제1조(개인정보의 처리 목적)</strong>
						<ul>
							<li>
								① 국회는 다음의 목적을 위하여 개인정보를 처리합니다. 처리하고 있는 개인정보는 다음의 목적 이외의 용도로는 이용되지 않으며, 이용 목적이 변경되는 경우에는 「개인정보 보호법」제18조에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.
								<ol>
									<li>
										국회 홈페이지 통합회원 가입 및 관리<br>
										회원 가입의사 확인, 회원제 서비스 제공에 따른 본인 식별·인증, 회원자격 유지·관리, 제한적 본인확인제 시행에 따른 본인확인, 서비스 부정이용 방지, 만 14세 미만 아동의 개인정보 처리 시 법정대리인의 동의여부 확인, 각종 고지·통지 등을 목적으로 개인정보를 처리합니다.
									</li>
									<li>
										정보공개 청구 업무 처리<br>
										정보공개 청구의 접수, 정보공개여부 결정통지서 작성ㆍ통보 등 정보공개 청구 처리의 목적에 필요한 범위에서 최소한의 개인정보를 처리하고 있습니다. 만약, 이용 목적이 변경될 시에는 정보주체에게 알리고 사전 동의를 받아 처리하겠습니다.
									</li>
									<li>
										서비스 제공<br>
										열린국회정보 데이터 제공 및 정보공개 청구, 맞춤서비스 제공, Open API 서비스 제공, 접속 빈도 파악 및 서비스 이용에 대한 통계분석 등을 목적으로 개인정보를 처리합니다.
									</li>
								</ol>
							</li>
						</ul>
					</div>
					
					<div>
						<strong>제2조(개인정보의 처리 및 보유기간)</strong>
						<ul>
							<li>
								① 국회는 법령에 따른 개인정보 보유·이용기간 또는 정보주체로부터 개인정보를 수집 시에 동의 받은 개인정보 보유·이용기간 내에서 개인정보를 처리·보유합니다.
							</li>
							<li>
								② 각각의 개인정보 처리 및 보유 기간은 다음과 같습니다.
								<ol>
									<li>
										국회 홈페이지 통합회원 정보 : 국회 홈페이지 개인정보지침에 따름.<br>
										- 국회 홈페이지 개인정보지침 : 회원 탈퇴 시 까지
									</li>
									<li>
										열린국회정보 청구인 정보<br>
										- 보유기간 : 10년<br>
										- 수집근거 : 「공공기관의 정보공개에 관한 법률」 및 동 법  시행령
									</li>
									<li>
										예외사항<br>
										- 국회 홈페이지 탈퇴 및 보유 기간 이후 개인정보를 제외한 자료는 통계 등의 목적을 위하여 활용할 수 있음.
									</li>
								</ol>
							</li>
						</ul>
					</div>
					
					<div>
						<strong>제3조(개인정보의 제3자 제공)</strong>
						<ul>
							<li>
								① 국회는 정보주체의 동의, 법률의 특별한 규정 등 「개인정보 보호법」제17조 및 제18조에 해당하는 경우에만 개인정보를 제3자에게 제공합니다.
							</li>
							<li>
								② 국회는 다음과 같이 개인정보를 제3자에게 제공하고 있습니다.
								<ul class="list_dash">
									<li>개인정보를 제공받는 자 : 구글 애널리틱스(GA․Google Analytics) 및 네이버 애널리틱스</li>
									<li>제공받는 자의 개인정보 이용 목적 : 통계 작성 및 학술 연구 등</li>
									<li>제공하는 개인정보 항목 : 지역, 접속 이력, 콘텐츠 이용 내역 등</li>
									<li>제공받는 자의 보유·이용기간 : 18개월</li>
								</ul>
							</li>
						</ul>
					</div>
					
					<div>
						<strong>제4조(개인정보처리의 위탁)</strong>
						<ul>
							<li>
								① 국회는 원활한 개인정보 업무처리를 위하여 다음과 같이 개인정보 처리업무를 위탁하고 있습니다.
								<ol>
									<li>
										국회 정보시스템 유지관리 등<br>
										- 수탁자 : 대신정보통신 주식회사<br>
										- 수탁내용 : 국회 정보시스템 유지관리
									</li>
									<li>
										알림톡<br>
										- 수탁자 : 다우기술(주)
									</li>
								</ol>
							</li>

						</ul>
					</div>
					
					<div>
						<strong>제5조(정보주체와 법정대리인의 권리·의무 및 행사방법)</strong>
						<ul>
							<li>
								① 정보주체는 국회에 대해 언제든지 개인정보 열람·정정·삭제·처리정리 요구 등의 권리를 행사할 수 있습니다.
							</li>
							<li>② 제1항에 따른 권리 행사는 국회에 대해 「개인정보 보호법 시행령」제41조제1항에 따라 서면, 전자우편, 모사전송(FAX) 등을 민원지원센터를 통하여 하실 수 있으며, 국회는 이에 대해 지체 없이 조치하겠습니다.</li>
							<li>③ 제1항에 따른 권리 행사는 정보주체의 법정대리인이나 위임을 받은 자 등 대리인을 통하여 하실 수 있습니다. 이 경우 「개인정보 보호법 시행 규칙」별지 제11호 서식에 따른 위임장을 제출하셔야 합니다.</li>
							<li>④ 개인정보 열람 및 처리정지 요구는 「개인정보 보호법」 제37조제2항 및 관련 법령에 의하여 정보주체의 권리가 제한될 수 있습니다.</li>
							<li>⑤ 개인정보의 정정 및 삭제 요구는 제2조 및 다른 법령에서 그 개인정보가 수집 대상으로 명시되어 있는 경우에는 그 삭제를 요구할 수 없습니다.</li>
							<li>⑥ 국회는 정보주체 권리에 따른 열람의 요구, 정정·삭제의 요구, 처리정지의 요구 시 열람 등 요구를 한 자가 본인이거나 정당한 대리인인지를 확인합니다.</li>
						</ul>
					</div>
					
					<div>
						<strong>제6조(처리하는 개인정보 항목)</strong>
						<span>국회는 다음의 개인정보 항목을 처리하고 있습니다.</span>
						<ol>
							<li>
								국회 홈페이지 회원 가입 및 관리
								<ul class="list_dash">
									<li>필수항목 : 성명, 생년월일, 아이디, 비밀번호, 성별, 이메일, 본인인증기관으로부터의 인증결과 값</li>
									<li>선택항목 : 주소, 휴대폰 번호</li>
								</ul>
							</li>
							<li>
								정보공개 청구
								<ul class="list_dash">
									<li>필수항목 : 이름, 주민등록번호, 주소</li>
									<li>선택항목 : 휴대폰번호, 전화번호, 이메일주소, FAX번호</li>
								</ul>
							</li>
						</ol>
					</div>
					
					<div>
						<strong>제7조(개인정보의 파기)</strong>
						<ul>
							<li>① 국회는 개인정보 보유기간의 경과, 처리목적 달성 등 개인정보가 불필요하게 되었을 때에는 지체없이 해당 개인정보를 파기합니다. 다만, 다른 법률에 따라 보존하여야 하는 경우에는 그러하지 않습니다.</li>
							<li>② 국회는 열린국회정보 개인정보 처리책임자의 책임 하에 전자적 파일 형태로 기록·저장된 개인정보는 기록을 재생할 수 없도록 파기하며, 종이 문서에 기록·저장된 개인정보는 분쇄기로 분쇄하거나 소각하여 파기합니다. </li>
						</ul>
					</div>
					
					<div>
						<strong>제8조(개인정보의 안정성 확보조치)</strong>
						<ul>
							<li>
								① 국회는 개인정보의 안전성 확보를 위해 다음과 같은 조치를 취하고 있습니다.
								<ul class="list_dash">
									<li>관리적 조치 : 내부관리계획 수립·시행</li>
									<li>물리적 조치 : 개인정보시스템의 물리적 보관 장소에 대한 비인가자 출입 통제</li>
									<li>기술적 조치 : 개인정보에 대한 접근 제한, 중요정보에 대한 암호화, 보안프로그램 설치</li>
								</ul>
							</li>
						</ul>
					</div>
					
					<div>
						<strong>제9조(개인정보 자동 수집 장치의 설치·운영 및 거부에 관한 사항)</strong>
						<ul>
							<li>① 국회는 이용자에게 개별적인 맞춤서비스를 제공하기 위해 이용정보를 저장하고 수시로 불러오는 쿠키(cookie)를 사용합니다.</li>
							<li>
								② 쿠키(cookie)는 웹사이트를 운영하는데 이용되는 서버(https)가 이용자의 컴퓨터 브라우저에게 보내는 소량의 정보이며 이용자의 PC 컴퓨터 내의 하드디스크에 저장되기도 합니다.
								<ul class="list_dash">
									<li>쿠키(cookie)의 사용목적 : 이용자가 방문한 각 서비스와 웹 사이트들에 대한 방문 및 이용형태, 인기 검색어, 보안접속 여부 등을 파악하여 이용자에게 최적화된 정보 제공을 위해 사용됩니다.</li>
									<li>쿠키(cookie)의 설치·운영 및 거부 : 웹브라우저 상단의 도구>인터넷 옵션>개인정보 메뉴의 옵션 설정을 통해 쿠키(cookie) 저장을 거부할 수 있습니다.</li>
									<li>쿠키(cookie) 저장을 거부할 경우 맞춤형 서비스 이용에 어려움이 발생 할 수 있습니다.</li>
									<li>통계 작성 및 학술 연구 등의 목적을 위하여 구글 애널리틱스(GA․Google Analytics), 네이버 애널리틱스에서 사용될 수 있습니다.</li>
								</ul>
							</li>
						</ul>
					</div>
					
					<div>
						<strong>제10조(열린국회정보 및 정보공개청구 개인정보 처리책임자)</strong>
						<ul>
							<li>① 국회는 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와 관련한 정보주체의 불만처리 및 피해구제 등을 위하여 아래와 같이 개인정보 처리책임자를 지정하고 있습니다.</li>
						</ul>
						<table>
						<caption>처리 책임자, 처리 담당부서, 국회 홈페이지 통합회원 가입, 정보공개청구</caption>
						<thead>
							<tr>
								<th scope="row">&nbsp;</th>
								<th scope="row">국회 홈페이지 통합회원 가입</th>
								<th scope="row">정보공개청구</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th scope="row">처리책임자</th>
								<td>기획조정실장</td>
								<td>국회민원지원센터장</td>
							</tr>
							<tr>
								<th scope="row">처리담당부서</th>
								<td>디지털운영담당관</td>
								<td>국회민원지원센터</td>
							</tr>
						</tbody>
						</table>
					</div>
					
					<div>
						<strong>제11조(권익침해 구제방법)</strong>
						<span>
						정보주체는 아래의 기관에 대해 개인정보 침해에 대한 피해구제, 상담 등을 문의하실 수 있습니다.
						</span>
						<span>
						&lt;아래의 기관은 국회와는 별개의 기관으로서, 국회의 자체적인 개인정보 불만처리, 피해구제 결과에 만족하지 못하시거나 보다 자세한 도움이 필요하시면 문의하여 주시기 바랍니다.&gt;
						</span>
						<ul>
							<li>
								▶ 개인정보 침해신고센터 (한국인터넷진흥원 운영)
								<ul class="list_dash">
									<li>소관업무 : 개인정보 침해사실 신고, 상담 신청</li>
									<li>홈페이지 : <a href="https://privacy.kisa.or.kr" target="new" title="새창열림_한국인터넷진흥원">privacy.kisa.or.kr</a></li>
									<li>전    화 : (국번없이) 118</li>
									<li>주    소 : (58324) 전라남도 나주시 진흥길 9 (빛가람동 301-2) 3층 개인정보침해 신고센터</li>
								</ul>
							</li>
							<li>
								▶ 개인정보 분쟁조정위원회
								<ul class="list_dash">
									<li>소관업무 : 개인정보 분쟁조정신청, 집단분쟁조정(민사적 해결)</li>
									<li>홈페이지 : <a href="https://www.kopico.go.kr" target="new" title="새창열림_개인정보 분쟁조정위원회">www.kopico.go.kr</a></li>
									<li>전    화 : (국번없이) 1833-6972</li>
									<li>주   소 : (03171) 서울특별시 종로구 세종대로 209 정부서울청사 4층</li>
								</ul>
							</li>
							<li>
								▶ 대검찰청 사이버범죄수사단
								<ul class="list_dash">
									<li>홈페이지 : <a href="https://www.spo.go.kr" target="new" title="새창열림_대검찰청 사이버범죄수사단">www.spo.go.kr</a></li>
									<li>전    화 : (국번없이) 1301</li>
								</ul>
							</li>
							<li>
								▶ 경찰청 사이버안전국
								<ul class="list_dash">
									<li>홈페이지 : <a href="https://cyberbureau.police.go.kr" target="new" title="새창열림_경찰청 사이버안전국">cyberbureau.police.go.kr</a></li>
									<li>전    화 : (국번없이) 182</li>
								</ul>
							</li>
						</ul>
					</div>
					<div>
						<strong>제12조(개인정보 처리방침)</strong>
						<ul>
							<li>① 이 개인정보 처리방침은 (2020년 2월 17일)부터 적용됩니다.</li>
						</ul>
					</div>
		
					
				</div>
			</div>
       	</div>	
	</article>
</section>
      
<!-- // wrap_layout_flex -->
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
</div>
<!-- // layout_A -->
</body>
</html>
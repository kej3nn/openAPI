<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)guideOpnInfo.jsp 1.0 2019/08/12                                   --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 	--%>
<%-- 정보공개 > 정보공개안내                      												--%>
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
			<h3>정보공개청구 안내<span class="arrow"></span></h3>
        </div>

<div class="layout_flex">
    <div class="layout_flex_100">
        <fieldset>
        	<section>
        	
				<div id="tab_B">
			        <ul id="tabs" class="tabmenu-type02">
						<li class="on"><a href="javascript:;">제도안내 및<em>처리절차</em></a></li>
					    <li><a href="javascript:;">청구방법</a></li>
					    <li><a href="javascript:;">비공개정보 및<em>구제절차</em></a></li>
				    </ul>
			    </div>
			    
			    <!-- 제도안내 및 처리절차 -->
			    <div id="contents_01">
			        <h4 class="title0402">제도안내 및 처리절차</h4>
					<div class="contents-box">
						<h5 class="title0401">정보공개제도의 의의</h5>
						<p class="word-type02">
							공공기관이 직무상 작성 또는 취득하여 관리하고 있는 정보를 국민에게 공개함으로써 알권리 보장 및 국정운영의 투명성 확보
						</p>
					</div>
					<div class="contents-box">
						<h5 class="title0401">관계법규</h5>
						<ul class="clink_list">
							<li><a href="http://likms.assembly.go.kr/law/lawsLawtInqyDetl1010.do?mappingId=%2FlawsLawtInqyDetl1010.do&genActiontypeCd=2ACT1010&genDoctreattypeCd=DOCT2004&contId=1996123100000006&contSid=0013&cachePreid=ALL&genMenuId=menu_serv_nlaw_lawt_1010&viewGb=PROM" target="_blank" title="새창열림_국회법률정보시스템">「공공기관의 정보공개에 관한 법률」</a></li>
							<li><a href="http://likms.assembly.go.kr/law/lawsLawtInqyDetl1010.do?mappingId=%2FlawsLawtInqyDetl1010.do&genActiontypeCd=2ACT1010&genDoctreattypeCd=DOCT2004&contId=1997111700000002&contSid=0007&cachePreid=ALL&genMenuId=menu_serv_nlaw_lawt_1010&viewGb=PROM" target="_blank" title="새창열림_국회법률정보시스템">「국회정보공개규칙」</a></li>
							<li id="provPop"><a href="javascript:;" title="새창열림_국회정보공개규정">「국회정보공개규정」</a></li>
						</ul>
					</div>
					<div class="contents-box">
						<h5 class="title0401">정보공개 청구권자</h5>
						<ul class="clink_list">
							<li>모든 국민(법인 및 단체 포함)</li>
							<li>국내에 일정한 주소를 두고 거주하거나 학술ㆍ연구를 위하여 일시적으로 체류하는 외국인 등</li>
						</ul>
					</div>
					<div class="contents-box">
						<h5 class="title0401">정보공개청구 대상정보</h5>
						<p class="word-type02">
							공공기관이 직무상 작성 또는 취득하여 관리하고 있는 문서(전자문서 포함)ㆍ도면ㆍ사진ㆍ필름ㆍ테이프ㆍ슬라이드 및 그 밖에 이에 준하는 매체 등에 기록된 사항
						</p>
					</div>
					<div class="contents-box">
						<h5 class="title0401">정보공개 처리절차</h5>
						<div class="images-box2">
							<img src="/images/flowmap.gif" alt="정보공개청구(청구인) -> 청구서 접수 및 송부(정보공개 담당부서) -> 공개여부 결정(소관부서) -> 공개여부 결정통지 및 공개 실시(정보공개 담당부서)">
							<ul class="blind">
								<li>
									<strong>정보공개청구(청구인)</strong>
									<ul>
										<li>
											<strong>해당기관에 정보공개 청구</strong>
											<ol>
												<li>청구방법 : 정보공개청구서를 작성하여 해당기관에 제출</li>
												<li>청구서 기재사항 : 인적사항, 청구정보의 내용, 공개형태 및 수령방법</li>
											</ol>
										</li>
									</ul>
								</li>
								<li>
									<strong>청구서 접수 및 송부(정보공개 담당부서)</strong>
									<ul>
										<li>
											<strong>정보공개청구서 접수</strong>
										</li>
										<li>
											<strong>소관부서(정보 보유ㆍ관리부서)로 청구서 송부</strong>
										</li>
										<li>
											<strong>타기관 보유ㆍ관리 정보는 해당기관으로 이송</strong>
										</li>
									</ul>
								</li>
								<li>
									<strong>공개여부 결정(소관부서)</strong>
									<ul>
										<li>
											<strong>청구된 정보의 자료조사 및 공개여부 결정(10일 이내)</strong>
											<ol>
												<li>공개대상 정보가 제3자와 관련 있는 경우 청구사실 통지 및 의견청취</li>
												<li>정보생산기관에 대한 의견청취</li>
												<li>부득이한 사유로 기간내에 공개여부를 결정할 수 없는 때에는 공개여부결정 만료일 익일부터 10일 범위내 결정기간 연장</li>
												<li>공개여부 결정 곤란시 정보공개심의회 개최 요청</li>
											</ol>
										</li>
									</ul>
								</li>
								<li>
									<strong>공개여부 결정통지 및 공개 실시(정보공개 담당부서)</strong>
									<ul>
										<li>
											<strong>정보공개 여부 결정통지</strong>
											<ol>
												<li>비공개결정시 비공개사유 및 불복절차 명시</li>
											</ol>
										</li>
										<li>수수료 징수</li>
										<li>공개 결정된 정보의 공개(공개 결정일부터 10일 이내)</li>
									</ul>
								</li>
							</ul>
						</div>
					</div>
				</div>
				<!-- //제도안내 및 처리절차 -->
				
				<!-- 청구방법 -->
				<div id="contents_02" style="display:none;">
			        <h4 class="title0402">청구방법</h4>
					<div class="contents-box">
						<h5 class="title0401">정보공개 청구방법</h5>
						<p class="word-type02">
							열린국회정보포털, 직접방문, 우편, 모사전송(FAX) 등을 이용하여 국회 소속기관 정보공개 담당부서로 정보공개 청구
						</p>
						<div class="word-downbtn">
							<a href="javascript:fn_fileDownload('1');">정보공개 청구서 양식</a>
							<a href="javascript:fn_fileDownload('2');">이의신청서 양식</a>
						</div>
						<dl class="word-type-list">
							<dt>정보공개 담당부서</dt>
							<dd><strong>국회사무처</strong> : 국회민원지원센터 (TEL:02-6788-2064, FAX:02-6788-3169)</dd>
							<dd><strong>국회도서관</strong> : 기록정책과 (TEL:02-6788-4234, FAX:02-6788-4059)</dd>
							<dd><strong>국회예산정책처</strong> : 총무담당관 (TEL:02-6788-4612, FAX:02-6788-3784)</dd>
							<dd><strong>국회입법조사처</strong> : 총무담당관 (TEL:02-6788-4512, FAX:02-6788-4519)</dd>
							<dd>※국회 주소 : 우편번호 07233 서울특별시 영등포구 의사당대로 1</dd>		
						</dl>
					</div>
					<div class="contents-box">
						<h5 class="title0401">정보공개청구서 작성방법</h5>
						<dl class="word-type-list">
							<dd><strong>청구인의 인적사항</strong> : 이름ㆍ주소ㆍ생년월일ㆍ전화번호(직접통화 가능 연락처)</dd>
							<dd><strong>청구내용</strong> : 알고자 하는 정보를 구체적으로 기재</dd>		
							<dd>
								<strong>공개형태</strong>
								<ul class="word-type-list2">
									<li>정보를 직접 보고자 할 때 : 열람ㆍ시청</li>
									<li>우편으로 정보를 받고자 할 때 : 사본ㆍ출력물, 복제ㆍ인화물</li>
									<li>정보통신망(정보공개시스템)으로 정보를 받고자 할 때 : 전자파일</li>
								</ul>
							</dd>		
						</dl>
					</div>
					<div class="contents-box">
						<h5 class="title0401">정보공개 수수료</h5>
						<p class="word-type02">
							정보공개에 소요되는 비용은 수익자부담원칙에 따라 청구인이 부담(수입인지로 징수) 다음에 해당하는 경우에는 수수료를 감면할 수 있음
						</p>
						<dl class="word-type-list bullet-circle-dd">
							<dd>비영리의 학술ㆍ공익단체 또는 법인이 학술이나 연구목적 또는 행정감시를 위하여 필요한 정보를 청구한 경우</dd>
							<dd>교수, 교사 또는 학생이 교육자료나 연구목적으로 필요한 정보를 해당기관의 장의 확인을 받아 청구한 경우</dd>		
							<dd>소속기관의 장이 공공복리의 유지ㆍ증진을 위하여 감면이 필요하다고 인정한 경우</dd>		
						</dl>
						<div class="word-downbtn">
							<a href="javascript:fn_fileDownload('3');">수수료 안내</a>
						</div>
					</div>
				</div>
				<!-- //청구방법 -->
				
				<!-- 비공개정보 및 구제절차 -->
				<div id="contents_03" style="display:none;">
			        <h4 class="title0402">비공개정보 및 구제절차</h4>
					<div class="contents-box">
						<h5 class="title0401">비공개대상정보(법 제9조 제1항)</h5>
						<div class="word-number-list">
							<div>
								<strong>1</strong>
								<span>다른 법률 또는 법률이 위임한 명령(국회규칙ㆍ대법원규칙ㆍ헌법재판소규칙ㆍ중앙선거관리위원회규칙ㆍ대통령령 및 조례에 한한다)에 의하여 비밀 또는 비공개 사항으로 규정된 정보</span>
							</div>
							<div>
								<strong>2</strong>
								<span>국가안전보장ㆍ국방ㆍ통일ㆍ외교관계 등에 관한 사항으로서 공개될 경우 국가의 중대한 이익을 현저히 해할 우려가 있다고 인정되는 정보</span>
							</div>
							<div>
								<strong>3</strong>
								<span>공개될 경우 국민의 생명ㆍ신체 및 재산의 보호에 현저한 지장을 초래할 우려가 있다고 인정되는 정보</span>
							</div>
							<div>
								<strong>4</strong>
								<span>진행 중인 재판에 관련된 정보와 범죄의 예방, 수사, 공소의 제기 및 유지, 형의 집행, 교정, 보안처분에 관한 사항으로서 공개될 경우 그 직무수행을 현저히 곤란하게 하거나 형사피고인의 공정한 재판을 받을 권리를 침해한다고 인정할 만한 상당한 이유가 있는 정보</span>
							</div>
							<div>
								<strong>5</strong>
								<span>감사ㆍ감독ㆍ검사ㆍ시험ㆍ규제ㆍ입찰계약ㆍ기술개발ㆍ인사관리ㆍ의사결정과정 또는 내부검토과정에 있는 사항 등으로서 공개될 경우 업무의 공정한 수행이나 연구ㆍ개발에 현저한 지장을 초래한다고 인정할 만한 상당한 이유가 있는 정보</span>
							</div>
							<div>
								<strong>6</strong>
								<span>당해 정보에 포함되어 있는 이름ㆍ주민등록번호 등 개인에 관한 사항으로서 공개될 경우 개인의 사생활의 비밀 또는 자유를 침해할 우려가 있다고 인정되는 정보. 다만, 다음에 열거한 개인에 관한 정보는 제외</span>
								<ul class="clink_list">
									<li>법령이 정하는 바에 따라 열람할 수 있는 정보</li>
									<li>공공기관이 공표를 목적으로 작성하거나 취득한 정보로서 개인의 사생활의 비밀과 자유를 부당하게 침해하지 않는 정보</li>
									<li>공공기관이 작성하거나 취득한 정보로서 공개하는 것이 공익 또는 개인의 권리구제를 위하여 필요하다고 인정되는 정보</li>
									<li>직무를 수행한 공무원의 성명ㆍ직위</li>
									<li>공개하는 것이 공익을 위하여 필요한 경우로써 법령에 의하여 국가 또는 지방자치단체가 업무의 일부를 위탁 또는 위촉한 개인의 성명ㆍ직업</li>
								</ul>
							</div>
							<div>
								<strong>7</strong>
								<span>법인ㆍ단체 또는 개인(이하 "법인 등"이라 한다)의 경영ㆍ영업상 비밀에 관한 사항으로서 공개될 경우 법인 등의 정당한 이익을 현저히 해할 우려가 있다고 인정되는 정보. 다만, 다음에 열거한 정보는 제외</span>
								<ul class="clink_list">
									<li>사업활동에 의하여 발생하는 위해로부터 사람의 생명ㆍ신체 또는 건강을 보호하기 위하여 공개할 필요가 있는 정보</li>
									<li>위법ㆍ부당한 사업활동으로부터 국민의 재산 또는 생활을 보호하기 위하여 공개할 필요가 있는 정보</li>
								</ul>
							</div>
							<div>
								<strong>8</strong>
								<span>공개될 경우 부동산 투기ㆍ매점매석 등으로 특정인에게 이익 또는 불이익을 줄 우려가 있다고 인정되는 정보</span>
							</div>
						</div>
					</div>
					<div class="contents-box">
						<h5 class="title0401">불복구제절차(법 제18조 ~ 제20조)</h5>
						<dl class="word-type-list">
							<dt>이의신청</dt>
							<dd><strong>이의신청권자</strong> : 정보공개와 관련한 공공기관의 비공개 또는 부분공개 결정에 대하여 불복이 있는 청구인</dd>
							<dd><strong>이의신청기간</strong> : 정보공개여부의 결정통지를 받은 날 또는 비공개의 결정이 있는 것으로 보는 날부터 30일 이내</dd>
							<dd>
								<strong>이의신청방법</strong>
								<ul class="word-type-list2">
									<li>이의신청서를 작성하여 국회사무처 국회민원지원센터 등 정보공개 담당부서에 제출</li>
									<li>신청인의 인적사항, 이의신청의 대상이 되는 정보공개여부 결정의 내용, 이의신청의 취지 및 이유 등을 기재</li>
								</ul>
							</dd>
							<dd>
								<strong>이의신청결정 결과통지</strong>
								<ul class="word-type-list2">
									<li>공공기관은 이의신청을 받은 날부터 7일 이내에 그 이의신청에 대하여 결정을 하고 청구인에게 문서로 통지 (부득이한 경우 7일 이내의 범위에서 연장 가능)</li>
									<li>이의신청을 각하 또는 기각하는 경우에는 결정이유ㆍ불복방법 및 불복절차를 구체적으로 명시</li>
								</ul>
							</dd>
							<dt>행정심판 및 행정소송</dt>
							<dd class="bullet-circle">정보공개와 관련한 공공기관의 결정에 대하여 불복이 있는 청구인은 일정기간 이내에 행정심판 또는 행정소송을 제기할 수 있음</dd>
						</dl>
					</div>
				</div>
				<!-- //비공개정보 및 구제절차 -->
				
       	 	</section>
        </fieldset>
        <form name="dForm" method="post">
			<input type="hidden" name="fileName" />
			<input type="hidden" name="filePath" />
		</form>
	</div>
	<!-- // content -->
</div>
<!-- // layout_flex #################### -->
</div></div>

<!-- footer -->
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
<script type="text/javascript" src="<c:url value="/js/soportal/expose/nasCommon.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/soportal/expose/guideOpnInfo.js" />"></script>
<!-- jquery tree plugin [Dynatree] -->
<link rel="stylesheet" href="<c:url value="/js/soportal/tree/skin/ui.dynatree.css" />" type="text/css">
<script type="text/javascript" src="<c:url value="/js/soportal/tree/jquery.dynatree.js" />"></script> 
</body>
</html>
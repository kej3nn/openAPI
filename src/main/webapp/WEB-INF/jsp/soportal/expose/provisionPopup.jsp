<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code='wiseopen.title' /></title>
<%@ include file="/WEB-INF/jsp/ggportal/sect/head.jsp" %>

<style>
#pop_wrapper{position:relative;}
#pop_wrapper h2{font-size:19px; font-weight:600; color:#fff; background:#2e78bf url('../../images/soportal/expose/bg_popup_title.jpg') no-repeat right top; height:37px; border:1px solid #2c6499; padding:6px 0 0 30px;}
#pop_wrapper h2 em{font-size:13px; font-style:normal; letter-spacing:-1px;}
#pop_wrapper .close{position:absolute; top:12px; right:12px;}
.pop_content{font-size:12px; padding:30px; color:#555555;}
.pop_content.cult{height:497px; overflow:auto;}
.pop_content p strong{color:#444;}
.pop_tab{height:30px; position:relative; top:1px;}
.pop_tab li{float:left; border:1px solid #e2e8ef; margin:0 1px 0 0;}
.pop_tab li+li+li{margin:0;}
.pop_tab li a{color:#586373; font-size:13px; font-weight:600; display:block; background:#f2f5f8; width:144px; height:24px; text-align:center; padding:4px 0 0 0;}
.pop_tab li.on{border-bottom:1px solid #fff;}
.pop_tab li.on a, .pop_tab li a:hover{color:#004f9c; background:#fff;}
.post_search{border:1px solid #e2e8ef; margin:0; text-align:center; padding:30px 0 30px;}
.post_search dt,.post_search dd{display:inline-block; zoom:1; *display:inline; vertical-align:middle;}
.post_search dt.aw{width:auto;}
.post_search dd{width:110px; text-align:left; margin:0 10px 0 0;}
.post_search dd.aw{width:auto;}
.post_search dl{padding:0 0 9px;}
.post_search dl.tal{padding-left:157px; text-align:left;}
.post_search dd select{width:110px;}
.post_search dd input{width:102px;}
.post_search p{color:#444; font-size:13px;  margin:10px 0 16px;}
.post_search .btntxt01{margin:0 auto; width:39px;}
</style>
<script type="text/javascript">
$(function(){
	//팝업창 닫기
	$("#btn_close").bind("click", function(event) {
		window.close();
	});
});
</script> 
</head> 
	<body>
    	<!-- pop_wrapper -->
		<div id="pop_wrapper">
			<h2>국회정보공개규정</h2>
        	<a class="close" href="#" id="btn_close"><img src="/images/btn_close_layerPopup_A.png" alt="닫기" /></a>
            
            <!-- pop_content -->
            <div class="pop_content"> 
				<div id="page" class="paper">
						<h4 class="ptitle4" style="line-height: 1.2em;">국회정보공개규정 <br> <span class="font12" style="color:#3366CC;">[일부개정 2018.4.12  국회규정 제825호]</span></h4>
						<div class="ptext">
							<div class="text_strong fl mg5">제1조(목적) </div>
							<div class="textindent10 fc">
							이 규정은 <a href="#" title="새창열림_국회법률정보시스템" onclick="window.open('http://likms.assembly.go.kr/law/jsp/law/Law.jsp?WORK_TYPE=LAW_BON&amp;LAW_ID=A1219','preview','width=950,height=600,scrollbars=yes');return false;" style="text-decoration:underline;">「공공기관의 정보공개에 관한 법률」</a> 및 <a title="새창열림_국회법률정보시스템" href="#" onclick="window.open('http://likms.assembly.go.kr/law/jsp/law/Law.jsp?WORK_TYPE=LAW_BON&amp;LAW_ID=B4112','preview','width=950,height=600,scrollbars=yes');return false;" style="text-decoration:underline;">「국회정보공개규칙」</a>에서 위임된 사항과 그 시행에 관하여 필요한 사항을 규정함을 목적으로 한다.
							</div>
						</div>
						<div class="ptext">
							<div class="text_strong fl mg5">제1조의2(의사결정 과정 등 종료 통지의 서식)</div>
							<div class="textindent10 fc">
							 <a href="#" title="새창열림_국회법률정보시스템" onclick="window.open('http://likms.assembly.go.kr/law/jsp/law/Law.jsp?WORK_TYPE=LAW_BON&amp;LAW_ID=A1219','preview','width=950,height=600,scrollbars=yes');return false;" style="text-decoration:underline;">「공공기관의 정보공개에 관한 법률」</a>(이하 “법”이라 한다) 제9조제1항제5호 단서에 따른 의사결정 과정 및 내부검토 과정 종료의 통지는 별지 제1호서식에 따른다.<br>
							<span style="color:#3366CC;">[본조신설 2015.5.22]</span>
							</div>
						</div>
						<div class="ptext">
							<div class="text_strong">제2조(정보공개청구서의 서식) </div>
							<div class="textindent10">
							① 법 제10조제1항 및 <a href="#" title="새창열림_국회법률정보시스템" onclick="window.open('http://likms.assembly.go.kr/law/jsp/law/Law.jsp?WORK_TYPE=LAW_BON&amp;LAW_ID=B4112','preview','width=950,height=600,scrollbars=yes');return false;" style="text-decoration:underline;">「국회정보공개규칙」</a>(이하 “규칙”이라 한다) 제5조제1항의 규정에 따른 정보공개청구서는 별지 제1호의2서식에 따른다.&lt;개정 2015.5.22&gt;<br>
							② 법 제10조제1항 및 제2항의 규정에 따라 구술로 정보공개청구를 하는 경우에는 별지 제2호서식에 따른다.
							</div>
						</div>
						<div class="ptext">
							<div class="text_strong">제3조(정보공개처리 관련서식)</div>
							<div class="textindent10">
							① 법 제11조제2항에 따른 공개 여부 결정기간 연장의 통지는 별지 제3호서식에 따르고, 같은 조 제4항에 따른 정보공개 청구 이송의 통지는 별지 제3호의2서식에 따른다.&lt;개정 2017.10.11&gt;<br>
							② 규칙 제5조제2항 및 제15조의 규정에 따른 정보공개처리대장은 별지 제4호서식에 따른다.
							</div>
						</div>
						<div class="ptext">
							<div class="text_strong"> 제4조(제3자의 의견청취 관련서식)</div>
							<div class="textindent10">
							① 법 제11조제3항에 따라 제3자에게 통지하는 정보공개 청구사실 통지는 별지 제4호의2서식에 따르고, 정보공개가 청구된 사실을 통지받은 제3자의 의견제출 또는 법 제21조제1항의 규정에 따른 비공개요청은 별지 제5호서식에 따른다.&lt;개정 2015.5.22&gt;<br>
							② 법 제11조제3항 및 규칙 제7조의 규정에 따라 구술로 제3자의 의견청취를 하는 경우에는 별지 제6호서식에 따른다.
							</div>
						</div>
						<div class="ptext">
							<div class="text_strong fl mg5">제5조(정보공개 여부 결정통지의 서식)</div>
							<div class="textindent10 fc">
							법 제13조제1항 및 제4항의 규정에 따른 정보공개 여부 결정에 대한 통지는 별지 제7호서식에 따른다.
							</div>
						</div>
						<div class="ptext">
							<div class="text_strong fl mg5">제6조(정보공개방법)</div>
							<div class="textindent10 fc">
							공개대상 문서내용 중 이름·주민등록번호·주소 등 특정 개인의 신상에 관한 정보, 그 밖의 비공개대상정보가 포함되어 있는 경우에는 그 부분을 삭제하고 사본 등을 교부하여야 한다.
							</div>
						</div>
						<div class="ptext">
							<div class="text_strong">제6조의2(비공개대상정보의 세부기준)</div>
							<div class="textindent10">
							① 법 제9조제3항에 따른 비공개대상정보의 세부기준은 별표 2와 같다. <br>
							② 국회사무처·국회도서관·국회예산정책처 또는 국회입법조사처(이하 “소속기관”이라 한다)가 관리하고 있는 정보는 공개를 원칙으로 하되, 별표 2의 기준에 해당하는 정보에 대해서는 이를 공개하지 아니할 수 있다. <br>
							③ 소속기관의 장은 별표 2의 기준을 적용함에 있어 해당 정보를 공개함으로써 얻게 되는 국민의 알권리 보장과 비공개함으로써 보호되는 다른 법익과의 조화가 이루어질 수 있도록 공정하게 공개여부를 판단하여야 한다. <br>
							<span style="color:#3366CC;">[본조신설 2009.5.26]</span>
							</div>
						</div>
						<div class="ptext">
							<div class="text_strong">제6조의3(정보부존재 등의 처리)</div>
							<div class="textindent10">
							① 소속기관은 청구받은 정보가 다음 각 호의 어느 하나에 해당하는 경우에는 별지 제7호의2서식에 따라 정보공개 청구에 따를 수 없는 사유를 구체적으로 기재하여 청구인에게 통지하여야 한다. <br>
							1. 공개 청구된 정보가 소속기관이 보유·관리하지 아니하는 정보(이하 “정보부존재”라 한다)인 경우<br>
							2. 진정·질의 등 공개 청구의 내용이 법, 규칙 및 이 규정에 따른 정보공개 청구로 볼 수 없는 경우<br>
							② 제1항제1호에 따른 정보부존재의 사유는 다음 각 호의 어느 하나에 해당하는 사유로 한다. <br>
							1. 소속기관이 공개 청구된 정보를 생산·접수하지 아니한 경우<br>
							2. 정보를 취합·가공해야 하는 경우<br>
							3. 공개 청구된 정보가 「공공기관의 기록물관리에 관한 법률」에 따른 보존기간 경과로 폐기된 경우<br>
							4. 정보를 특정하지 아니하고 포괄적으로 청구한 경우<br>
							<span style="color:#3366CC;">[본조신설 2016.11.14]</span>
							</div>
						</div>
						<div class="ptext">
							<div class="text_strong fl mg5">제7조(정보공개 위임장 서식)</div>
							<div class="textindent10 fc">규칙 제14조제2항제3호의 규정에 따른 위임장은 별지 제8호서식에 따른다.</div>
						</div>
						<div class="ptext">
							<div class="text_strong">제8조(수수료의 금액)</div>
							<div class="textindent10">	
							① 규칙 제16조제1항의 규정에 따른 수수료의 금액은 다른 법령에 특별한 규정이 있는 경우를 제외하고는 별표 1과 같다.&lt;개정 2015.5.22&gt; <br>
							② 법 제17조제2항 및 규칙 제16조제3항에 따른 수수료의 감면비율은 총 수수료의 50%를 적용한다.&lt;신설 2015.5.22&gt; 
							</div>		
							
						</div>
						<br>
						<div class="ptext">
							<div class="text_strong">제9조(이의신청처리 관련서식)</div>
							<div class="textindent10">			
							① 법 제18조제1항 및 제21조제2항과 규칙 제17조제1항의 규정에 따른 이의신청은 별지 제9호서식에 따른다.<br>
							② 법 제18조제3항 및 제4항에 따른 이의신청 결정 통지와 법 제21조제2항에 따른 이의신청에 대한 결정의 통지는 별지 제9호의2서식에 따른다.&lt;신설 2015.5.22&gt;  <br>
							③ 법 제18조제3항 단서 및 규칙 제17조제2항의 규정에 따른 이의신청 결정기간 연장의 통지는 별지 제10호서식에 따른다.&lt;개정 2015.5.22&gt;  <br>
							④ 규칙 제17조제4항에 따른 이의신청처리대장은 별지 제11호서식에 따른다.
							</div>
						</div>
						<div class="ptext">
							<div class="text_strong fl mg5"> 제9조의2(제3자에 대한 정보공개 결정 통지의 서식)</div>
							<div class="textindent10"> 법 제21조제2항에 따라 제3자에게 하는 정보공개 결정 통지는 별지 제11호의2서식에 따른다.<br>
							<span style="color:#3366CC;">[본조신설 2015.5.22] </span>
							</div>
						</div>
						<br>
						<div class="ptext">
							<div class="text_strong fl mg5">제10조(자료제출)</div>
							<div class="textindent10 fc">
							규칙 제18조의 규정에 따른 정보공개운영실태의 제출은 별지 제12호서식에 따른다.
							</div>
						</div>
						<h4 class="ptitle4">부칙 <span class="font12">&lt;제593호, 2006.9.26&gt;</span> </h4>
						<div class="ptext">
							① (시행일) 이 규정은 결재한 날부터 시행한다.<br>
							② (적용례) 이 규정은 이 규정 시행 후 최초로 접수되는 정보공개청구 분부터 적용한다.
						</div>
						<h4 class="ptitle4">부칙 <span class="font12">&lt;제642호, 2009.5.26&gt;</span> </h4>
						<div class="ptext"> 이 규정은 결재한 날부터 시행한다. 
						</div>
						<h4 class="ptitle4">부칙 <span class="font12">&lt;제770호, 2015.5.22&gt;</span> </h4>
						<div class="ptext"> 이 규정은 결재한 날부터 시행한다.
						</div>
						<h4 class="ptitle4">부칙 <span class="font12">&lt;제793호, 2016.11.14&gt;</span> </h4>
						<div class="ptext"> 이 규정은 결재한 날부터 시행한다.
						</div>
						<h4 class="ptitle4">부칙 <span class="font12">&lt;제815호,2017.10.11&gt;</span> </h4>
						<div class="ptext"> 이 규정은 결재한 날부터 시행한다.
						</div>
						<h4 class="ptitle4">부칙 <span class="font12">&lt;제825호,2018.4.12&gt;</span> </h4>
						<div class="ptext"> 이 규정은 결재한 날부터 시행한다.
						</div>
				
				 <div class="ptext">
					<span class="text_strong">[별표 1] 수 수 료(제8조관련) &lt;개정 2018.4.12&gt;</span>
					<a href="https://open.assembly.go.kr:442/download/laws/open_fee_20180412.hwp" style="text-decoration:underline;">[hwp]</a>
				 </div>
				 <div class="ptext">
					<span class="text_strong">[별지 제1호서식] 의사결정 과정 및 내부검토 과정 종료 사실 통지서 </span>
					<a href="https://open.assembly.go.kr:442/download/laws/201505220077000108002_byl.hwp" style="text-decoration:underline;">[hwp]</a>
				 </div>
				 <div class="ptext">
					<span class="text_strong">[별지 제1호의2서식] 정보공개 청구서 </span>
					<a href="https://open.assembly.go.kr:442/download/laws/201505220077000108003_byl.hwp" style="text-decoration:underline;">[hwp]</a>
				</div>
				 <div class="ptext">
					<span class="text_strong">[별지 제2호서식] 정보공개 구술 청구서</span>
					<a href="https://open.assembly.go.kr:442/download/laws/201505220077000108004_byl.hwp" style="text-decoration:underline;">[hwp]</a>
				</div>
				 <div class="ptext">
					<span class="text_strong">[별지 제3호서식] 공개 여부 결정기간 연장통지서 </span>
					<a href="https://open.assembly.go.kr:442/download/laws/201505220077000108005_byl.hwp" style="text-decoration:underline;">[hwp]</a>
				</div>
				<div class="ptext">
					<span class="text_strong">[별지 제3호의2서식] 정보공개 청구서 기관이송 통지서 &lt;신설 2017.10.11&gt;</span>
					<a href="https://open.assembly.go.kr:442/download/laws/open_transfer_notice.hwp" style="text-decoration:underline;">[hwp]</a>
				</div>
				 <div class="ptext">
					<span class="text_strong">[별지 제4호서식] 정 보 공 개 처 리 대 장 </span>
					<a href="https://open.assembly.go.kr:442/download/laws/201505220077000108006_byl.hwp" style="text-decoration:underline;">[hwp]</a>
				</div>
				 <div class="ptext">
					<span class="text_strong">[별지 제4호의2서식] 정보공개 청구사실 통지서</span>
					<a href="https://open.assembly.go.kr:442/download/laws/201505220077000108007_byl.hwp" style="text-decoration:underline;">[hwp]</a>
				</div>
				 <div class="ptext">
					<span class="text_strong">[별지 제5호서식] 제3자 의견서(비공개요청서)</span>
					<a href="https://open.assembly.go.kr:442/download/laws/201505220077000108008_byl.hwp" style="text-decoration:underline;">[hwp]</a>
				</div>
				 <div class="ptext">
					<span class="text_strong">[별지 제6호서식] 제3자 의견 청취서</span>
					<a href="https://open.assembly.go.kr:442/download/laws/201505220077000108009_byl.hwp" style="text-decoration:underline;">[hwp]</a>
				</div>
				 <div class="ptext">
					<span class="text_strong">[별지 제7호서식] 정보(□공개 □부분공개 □비공개) 결정통지서</span>
					<a href="https://open.assembly.go.kr:442/download/laws/201505220077000108010_byl.hwp" style="text-decoration:underline;">[hwp]</a>
				</div>
				 <div class="ptext">
					<span class="text_strong">[별지 제7호의2서식] &lt;신설&gt; 정보부존재 등 통지서 </span>
					<a href="https://open.assembly.go.kr:442/download/laws/201611140079300108011_byl.hwp" style="text-decoration:underline;">[hwp]</a>
				</div>
				 <div class="ptext">
					<span class="text_strong">[별지 제8호서식] 정 보 공 개 위 임 장 </span>
					<a href="https://open.assembly.go.kr:442/download/laws/201505220077000108011_byl.hwp" style="text-decoration:underline;">[hwp]</a>
				</div>
				 <div class="ptext">
					<span class="text_strong">[별지 제9호서식] 정보(□공개 □부분공개 □비공개) 결정 이의신청서</span>
					<a href="https://open.assembly.go.kr:442/download/laws/201505220077000108012_byl.hwp" style="text-decoration:underline;">[hwp]</a>
				</div>
				 <div class="ptext">
					<span class="text_strong">[별지 제9호의2서식] 이의신청 (□인용 □부분인용 □기각 □각하) 결정 통지서</span>
					<a href="https://open.assembly.go.kr:442/download/laws/201505220077000108013_byl.hwp" style="text-decoration:underline;">[hwp]</a>
				</div>
				 <div class="ptext">
					<span class="text_strong">[별지 제10호서식] 이의신청 결정기간 연장통지서</span>
					<a href="https://open.assembly.go.kr:442/download/laws/201505220077000108014_byl.hwp" style="text-decoration:underline;">[hwp]</a>
				</div>
				 <div class="ptext">
					<span class="text_strong">[별지 제11호서식] 이 의 신 청 처 리 대 장</span>
					<a href="https://open.assembly.go.kr:442/download/laws/201505220077000108015_byl.hwp" style="text-decoration:underline;">[hwp]</a>
				</div>
				 <div class="ptext">
					<span class="text_strong">[별지 제11호의2서식] 제3자에 대한 정보공개 결정 통지서</span>
					<a href="https://open.assembly.go.kr:442/download/laws/201505220077000108016_byl.hwp" style="text-decoration:underline;">[hwp]</a>
				</div>
				 <div class="ptext">
					<span class="text_strong">[별지 제12호서식] 정보공개 운영실태</span>
					<a href="https://open.assembly.go.kr:442/download/laws/201505220077000108017_byl.hwp" style="text-decoration:underline;">[hwp]</a>
				</div>
				 <div class="ptext">
					<span class="text_strong">[별표 2] 비공개대상정보의 세부기준(제6조의2 관련)</span>
					<a href="https://open.assembly.go.kr:442/download/laws/201505220077000108018_byl.hwp" style="text-decoration:underline;">[hwp]</a>
				</div>
				
				</div>                
				
            </div>
            <!-- //pop_content -->
        </div>
        <!-- //pop_wrapper -->
	</body>
</html>
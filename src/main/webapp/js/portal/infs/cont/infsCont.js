/**
 * @(#)infsCont.js 1.0 2019/08/12
 * 
 * 사전정보공개 컨텐츠 스크립트 파일이다.
 * 
 * @author JHKIM
 * @version 1.0 2019/08/12
 */
////////////////////////////////////////////////////////////////////////////////
// GLOBAL VARIABLE
////////////////////////////////////////////////////////////////////////////////
var template = {
	exp: {
		title: "<a href=\"javascript:;\" title=\"\"></a>",
		cont: 
			"<div class=\"expCont\" style=\"display: none;\">" +
			"	<strong class=\"text_subheader\"></strong>" +
	   	 	"	<div class=\"infsDtlCont\"></div>" +
		 	"</div>"
	},
	list: {
		none: "<tr><td colspan=\"5\">조회된 데이터가 없습니다.</td></tr>",
		row:
			"<tr>" +
			"	<td class=\"m_none\">" +
			"		<div class=\"bunyaB\">" +
			"			<img src=\"/images/icon_bunyab01.png\">" +
			"			<span></span>" +
			"		</div>" +
			"	</td>" +
			"	<td class=\"tsubject_txt\">" +
			"		<div class=\"bunya_list\">" +
			"			<div class=\"bunyaT-m\">" +
			"				<span class=\"m_cate\">분야별 공개</span>" +
			"				<span class=\"ot01 infsTag\"></span>" +
			"			</div>" +
			"			<div class=\"bunyaT\">" +
			"				<strong class=\"infaNm\" title=\"새창열림\"></strong>" +
			"				<span class=\"infaExp m_none\"></span>" +
			"			</div>" +
			"			<span class=\"openYmd pc_none\"></span>" +
			"		</div>" +
			"	</td>" +
			"	<td class=\"m_none\"><span class=\"ot01 infsTag\"></span></td>" +
			"	<td class=\"openSrv m_none\"></td>" +
			"	<td class=\"openYmd m_none\"></td>" +
			"</tr>",
		srv: {
			V: "<a href=\"javascript:;\" title=\"시각화_새창열림\"><span class=\"sv01\" title=\"시각화\">시각화</span></a>",
			S: "<a href=\"javascript:;\" title=\"표_새창열림\"><span class=\"sv02\" title=\"표\">표</span></a>",
			C: "<a href=\"javascript:;\" title=\"차트_새창열림\"><span class=\"sv03\" title=\"차트\">차트</span></a>",
			M: "<a href=\"javascript:;\" title=\"지도_새창열림\"><span class=\"sv04\" title=\"지도\">지도</span></a>",
			A: "<a href=\"javascript:;\" title=\"API_새창열림\"><span class=\"sv05\" title=\"API\">API</span></a>",
			F: "<a href=\"javascript:;\" title=\"파일_새창열림\"><span class=\"sv06\" title=\"파일\">파일</span></a>",
			L: "<a href=\"javascript:;\" title=\"링크_새창열림\"><span class=\"sv07\" title=\"링크\">링크</span></a>"
		}
			
	},
	mobile: {
		none:
			"<a href=\"javascript:;\">" +
			"	<strong class=\"infsNm\">조회된 데이터가 없습니다.</strong>" +
			"</a>",
		list: 
			"<a href=\"javascript:;\">" +
			"	<strong class=\"infsNm\"></strong>" +
			"	<span><em class=\"topCateNm\"></em></span>" +
			"</a>"
	},
	search: {
		item: "<li><a href=\"javascript:;\" name=\"\"><strong class=\"tit\"></strong></a></li>"
	}
};

var GC_BUNYA_IMG = {
	NA10000: "bunyab01",
	NA20000: "bunyab02",
	NA30000: "bunyab03",
	NA40000: "bunyab04",
	NA50000: "bunyab05"
}

// 정보셋 데이터 팝업 객체(창이 떠있는지 확인하고 FOCUS 주기 위함)
var GC_ITEM_POPUP = null;

// 서비스유형 팝업 객체(창이 떠있는지 확인하고 FOCUS 주기 위함)
var GC_SRV_POPUP = null;

// 트리가 처음 열리는 경우
var GC_IS_FIRST_TREE = true;

var GC_IS_INFSPOP = "isInfsPop=Y";

////////////////////////////////////////////////////////////////////////////////
// SCRIPT INIT
////////////////////////////////////////////////////////////////////////////////
$(function() {
	// 컴포넌트 초기화
	initComp();
	
});

////////////////////////////////////////////////////////////////////////////////
// 초기화 함수
////////////////////////////////////////////////////////////////////////////////
function initComp() {
	// 트리 초기화
	initTree();
	
	// 모바일 분류 조회(최상위)
	selectInfoCateChild('T');
	
	// 모바일 목록 조회
	selectInfsCont();
	
	// 초기 트리 사이즈 조절
	changeTreeAreaHeight();
}

/**
 * 트리를 초기화 한다.
 */
function initTree() {
	// 파라미터가 지원조직으로 넘어올경우 탭 변경
	var cateId = $("#paramCateId").val();
	if ( GC_IS_FIRST_TREE && cateId.indexOf("NA3") > -1 ) {
		$(".content_menu li a").removeClass("on");
		var sorg = $(".content_menu li [data-gubun=sorg]");
		sorg.addClass("on");
		
		$("input[name=cateDataGubun]").val("sorg");
	}
	
	GC_IS_FIRST_TREE = false;
	
	var initTreeSuccess = function() {
		var deferred = $.Deferred();
		try {
			loadTree();	// 트리 로드
			deferred.resolve(true);
		} catch (err) {
			deferred.reject(false);
		}
		return deferred.promise();
	}
	
	initTreeSuccess().done(function(message) {
	}).always(function() {
		setTimeout(function() {
			activeInfsTreeNode();
		}, 100);
	});
}

/**
 * 키값(정보셋ID, 분류ID)에 따라 트리 노드 바로가기
 */
function activeInfsTreeNode() {
	
	var infsId = $("#paramInfsId").val();
	var cateId = $("#paramCateId").val();
	
	// 정보셋, 분류ID가 모두 넘어온경우
	if ( !com.wise.util.isBlank(infsId) && !com.wise.util.isBlank(cateId) ) {

		$("#treeObj").dynatree("getRoot").visit(function(node){
            if ( node.data.parInfsId == cateId && node.data.key == infsId ) {
            	if ( infsLinkPageMove(infsId, false) ) {
        			return false;
        		}
            	else {
            		loadInfs({
            			id: infsId,
            			parCateId: cateId
            		});
            		node.focus();
            	}
            }
        });
	}
	// 정보셋 ID만 넘어온경우
	else if ( !com.wise.util.isBlank(infsId) ) {

		if ( infsLinkPageMove(infsId, true) ) {
			return false;
		}
		else {
			$("#treeObj").dynatree("getTree").getNodeByKey(infsId).focus();
		}
	}
	// 분류ID만 넘어온 경우
	else if ( !com.wise.util.isBlank(cateId) ) {
		
		// 분류체계에 속해있는 특정 정보셋은 해당 화면으로 바로 이동
		if ( infsTreeTopLevelSelect(cateId) ) {
			return false;
		}

		// 그 이외에..
		var nodeKey = $("#treeObj").dynatree("getTree").getNodeByKey(cateId);
		if ( nodeKey != null ) {
			// 넘어온 분류ID의 자식들
			var childrens = nodeKey.data.children;
			
			var findInfSet = _.find(childrens, {'gubunTag': 'T'});		// 자식들 중 정보셋이 있을경우 첫번째 객체
			var findCateSet = _.find(childrens, {'gubunTag': 'C'});		// 자식들 중 정보분류가 있을경우 첫번째 객체
			
			if ( _.isEmpty(findInfSet) ) {
				// 자식들중 2레벨에 정보셋이 없을경우(3레벨에 정보셋이 있는지 찾는다)
				var findCateSetChildrenInfSet = _.find(findCateSet.children, {'gubunTag': 'T'});
				
				if ( _.isEmpty(findCateSetChildrenInfSet) ) {
					// 3레벨에도 정보셋이 없는경우 패스
					$("#treeObj").dynatree("getTree").getNodeByKey(cateId).focus();
				}
				else {
					
					// 해당 ID 포커스 처리(문서ID가 여러 분류체계로 들어갈 수 있음)
					$("#treeObj").dynatree("getRoot").visit(function(node){
						if ( node.data.parInfsId == findCateSetChildrenInfSet.parInfsId && node.data.key == findCateSetChildrenInfSet.key ) {
							// 데이터 로드
							loadInfs({
								id: findCateSetChildrenInfSet.key,
								parCateId: findCateSetChildrenInfSet.parInfsId
							});

							// focus 처리
							node.activate();
							setTimeout(function() {
								node.focus();
							}, 100);
						}
					});
				}
			}
			else {
				// 자식들중 2레벨에 정보셋이 있을경우
				
				var key = findInfSet.key;	// 문서 ID
				
				// 해당 ID 포커스 처리(문서ID가 여러 분류체계로 들어갈 수 있음)
				$("#treeObj").dynatree("getRoot").visit(function(node){
					if ( node.data.parInfsId == cateId && node.data.key == key ) {
						// 데이터 로드
						loadInfs({
							id: key,
							parCateId: cateId
						});

						// focus 처리
						node.activate();
						setTimeout(function() {
							node.focus();
						}, 100);
					}
				});
			}
		}
	}
}

/**
 * 분류체계 최상위(1) 레벨을 선택가였을경우 이미지를 보여준다
 * @param cateId	분류 ID
 * @returns
 */
function infsTreeTopLevelSelect(cateId) {
	var sect = $("#main-img-sect"),
		arrTopLevelInfSetCate = [
			{id: "NA10000", img: "<img src=\"/images/content_main01.png\" usemap=\"#main01\" alt=\"국회의원 안내 -국회의원검색:의원현황을 의원명,정당,소속위원회,지역,성별,선수 등 다양한 기준으로 검색해보실 수 있습니다. 의원별 인적사항,발의법률안,표결현황,발언내용,정책자료&보고서 발간,의사일정 등을 공개합니다. -정당 및 교섭단체 현황 정보 : 정당별 의석수 및 교섭단체 구성현황을 한 눈에 보실 수 있습니다. -국회의원 현황 정보 : 현역 국회의원의 인적사항,의정활동,정책개발활동, 의원실 채용 정보 등을 데이터 형태로 제공합니다. < 왼쪽 트리 메뉴에서 찾으시는 정보명을 클릭하시기 바랍니다. -역대 국회 정보 : 역대 국회 구성, 역대 국회의장단, 역대 국회의원, 역대 주요 원내 정당 관련 정보를 제공합니다.< 왼쪽 트리 메뉴에서 찾으시는 정보명을 클릭하시기 바랍니다.\"><map name=\"main01\" id=\"main01\"><area shape=\"rect\" coords=\"676,273,802,315\" href=\"/portal/assm/assmPartyNegotiationPage.do\" title=\"정당 및 교섭단체 현황 정보 바로가기\"><area shape=\"rect\" coords=\"676,130,802,172\" href=\"/portal/assm/search/memberSchPage.do\" title=\"국회의원검색 바로가기\"></map>"},			// 국회의원
			{id: "NA40000", img: "<img alt=\"의정활동별 공개 안내 - 의정활동 통합현황 : 본회의 안건처리 현황, 위원회 구성 현황, 위원회 계류 의안 현황, 위원회 일정, 날짜별 의정활동 현황, 인사청문회 실시 현장, 청원 처리현황 등의 정보를 한 곳에서 제공합니다. - 본회의 정보 : 본회의 일정, 의안 종류별 안건처리 현황, 회의록 등을 데이터 형태로 제공합니다. < 왼쪽 트리 메뉴에서 찾으시는 정보명을 클릭하시기 바랍니다. -위원회 정보 : 위원회 구성 현황, 위원 명단, 일정, 계류의안, 회의록 등을 데이터 형태로 제공합니다. < 왼쪽 트리 메뉴에서 찾으시는 정보명을 클릭하시기 바랍니다. -날짜별 의정활동 : 날짜별 의정활동 정보를 데이터 형태로 제공합니다. < 왼쪽 트리 메뉴에서 찾으시는 정보명을 클릭하시기 바랍니다. -인사청문회 : 인사청문회 실시 현황을 데이터 형태로 제공합니다. < 왼쪽 트리 메뉴에서 찾으시는 정보명을 클릭하시기 바랍니다. -청원 : 청원 접수 및 처리현황을 데이터 형태로 제공합니다.< 왼쪽 트리 메뉴에서 찾으시는 정보명을 클릭하시기 바랍니다.\" src=\"/images/content_main02.png\" usemap=\"#main02\"><map name=\"main02\" id=\"main02\"><area shape=\"rect\" coords=\"665,141,791,183\" href=\"/portal/bpm/prc/prcMstPage.do\" title=\"의정활동 통합현황 바로가기\"></map>"},	// 의정활동별 공개
			{id: "NA20000", img: "<img alt=\"주제별 공개 안내 -왼쪽 트리 메뉴를 클릭하시기 바랍니다.-정책 : 국회의원 입법 및 정책개발/국회의원 연구단체/입법예고/법안 심사 및 처리/본회의표결현황/국회의장 자문기구 현황/법제관련 발간자료/법제사례연구발표/행정입법 분석ㆍ연구/보고서ㆍ발간물 -국회의원 연구용역 결과물,국회의원 연구단체 활동, 지역현안 입법지원 토론회 등 국회의원의 입법 및 정책개발 활동 내역 공개-입법예고,법안 심사 및 처리, 본회의 표결현황 등 법안 처리과정 관련 정보 공개-국회의장 자문기구 현황 공개-법제관련 발간자료,법제사례 연구발표 자료,행정입법 분석ㆍ연구결과물 등 공개 -의회외교 : 의회외교/국회의원 직무상 국외활동 -의회외교활동자문위원회 관련 현황 공개 -의회외교 관련 단체 현황 공개 -의회외교 실시 내역 및 결과보고서 공개 -국회의원의 직무상 국외활동 신고내역 공개 -재정 : 국회 예산현황/국회의원 수당 및 지원예산 -국회 기관별ㆍ사업별ㆍ성질별 예산 규모 공개 -국회 예산집행 내역,업무추진비 사용내역,계약현황,국회 보유 자산 현황 등 공개-국회의원 수당 지급기준 공개-의원실 지원경비 등 국회의원 지원예산 공개 -행정 : 기획ㆍ조정/법무/인사/감사/청사관리 -국회 입법지원 조직의 연간 업무추진계획 보고서,연차보고서,조직도 등 공개 -국회관계법규,국회소관 법인,소송ㆍ행정심판 관련 현황 공개-국회인력통계,국회 채용정보 공개-정기 감사 결과보고서,국회의원 및 공직자 재산신고 내역 및 주식ㆍ백지신탁 신고 공개-퇴직공무원 취업이력 및 취업심사 결과 공개-국회의원의 겸직 결정 내역 공개-국회 회의실 사용현황,공공요금,입법보조원 출입증 발급 현황 등 청사관리 정보 공개 -국민참여 : 국회 시설물 안내/국회 투어/국회 의정연수 참여/국회 문화 행사/국회 방송 편성표/국회 민원/정보공개제도 -국회 시설물 안내-국회 투어 정보 제공-지방의회 연수 교육일정 및 시민의정연수 일정 정보 제공-국회 방송 편성표 제공-국민동의청원, 진정 등 국회민원 처리 현황 공개-정보공개제도 운영현황 공개 -언론ㆍ미디어ㆍ일정 : 보도자료/국회뉴스ON/NATV뉴스/출입기자안내정보/국회 각종 일정 -국회 보도자료,국회뉴스ON,NATV뉴스 등 보도 현황 제공-출입기자 안내 정보 제공-의사일정,주요정치일정,의장단 일정 정보 제공-위원회별 전체회의ㆍ소위원회ㆍ공청회ㆍ간담회 일정 정보 제공-국회문화극장 영화ㆍ공연 및 국회개방행사일정 정보 제공\" src=\"/images/content_main03.png\">"},		// 분야별 공개
			{id: "NA30000", img: "<img alt=\"지원조직별 공개 안내 < 왼쪽 트리 메뉴를 클릭하시기 바랍니다. 국회사무처 -국회의원의 의정활동을 지원하고 국회의 행정사무를 처리 -법률안,청원 등의 접수ㆍ처리에서부터 국회의 회의, 법안 및 예산결산심사,국정감ㆍ조사 지원, 국회의원의 의회외교활동지원,국회방송(NATV) 및 국회 홍보에 이르기까지 입법 및 의정활동의 핵심적인 지원 업무를 수행-국회의원이 요구하는 법률안을 기초하고 각종 심사안건에 대하여 전문적인 검토의견을 보고하는 등 의원들에게 다양한 입법정보 제공 국회도서관 -도서ㆍ논문ㆍ멀티미디어자료 등 각종 자료를 수집ㆍ정리ㆍ가공하여 국회의원에게는 입법정보를, 국민들에게는 지식과 정보를 제공-조사ㆍ번역,정책연혁정보 서비스, 인터넷자원 DB구축 등을 통해 입법활동이 보다 손쉽게 되도록 지원하고, 야간자료예약제도를 통해 야간에도 제한 없이 자료열람 가능 -국회도서관 홈페이지 전자정보교류협력 코너의 협의회관에서는 방문과 동일하게 원문데이터베이스 열람,출력 가능 -18세 이상인 자와 대학생이라면 누구나 이용 가능 국회예산정책처 -국회의 국가 예ㆍ결산 심의를 지원하고, 국회의 재정통제권을 강화하기 위해 비당파적이고 중립적으로 전문적인 연구ㆍ분석을 수행 -예산안ㆍ결산 및 기금 분석, 국가 재정운용 및 거시경제동향 분석ㆍ전망,세제분석 및 세수추계, 국가 주요 사업 및 정책에 대한 분석ㆍ평가 등을 통해 국회의 재정통계 기능 강화에 기여 -위원회 및 국회의원의 조사ㆍ분석요구와 법안비용추계 요구를 처리하고 있으며, 대외협력을 통해 최신 정보를 수집하고 분석기법을 개발 국회입법조사처 -입법부의 독자적이고 전문적인 지식ㆍ정보체계를 구축하고 의원 입법 활성화에 따른 입법정보 수요증가에 대응하기 위해 출범 -입법 및 정책에 대한 조사ㆍ분석, 국회의원 및 위원회의 조사ㆍ분석요구에 대한 회답,행정부의 위법 또는 제도 개선사항 발굴, 국회의원연구단체에 대한 정보제공, 외국의 입법동향 분석 및 정보제공 등의 업무를 수행\" src=\"/images/content_main04.png\">"},	// 지원조직별 공개
			{id: "NA50000", img: "<img src=\"/images/content_main05.png\" usemap=\"#main05\" alt=\"보고서ㆍ발간물 안내 -국회 전체 : 국회의 각 입법지원조직에서 발간하는 보고서와 발간물 전체 내역을 표지 이미지와 함께 제공합니다. -국회사무처 : 국회보,국회사,국회경과보고서,국회홍보자료,법제관련 발간자료 등 <왼쪽 트리 메뉴에서 찾으시는 정보명을 클릭하시기 바랍니다. -국회도서관 : 국회도서관 안내,월간국회도서관,최신외국 입법정보 등 <왼쪽 트리 메뉴에서 찾으시는 정보명을 클릭하시기 바랍니다. -국회예산정책처 : 예산안ㆍ결산분석시리즈,경제동향&이슈,산업동향&이휴,추계세제&이슈 등 <왼쪽 트리 메뉴에서 찾으시는 정보명을 클릭하시기 바랍니다. -국회입법조사처 : NARS현안분석,입법영향분석보고서,이슈와 논점,연구보고서 등 <왼쪽 트리 메뉴에서 찾으시는 정보명을 클릭하시기 바랍니다. -국회미래연구원 : 연구보고서,국가미래전략 Insight,국제전략 Foresight 등 <왼쪽 트리 메뉴에서 찾으시는 정보명을 클릭하시기 바랍니다.\"><map name=\"main05\" id=\"main05\"><area shape=\"rect\" coords=\"665,141,791,183\" href=\"/portal/nadata/catalog/naDataCommPage.do\" title=\"보고서ㆍ발간물(전체) 바로가기\"></map>"},	// 보고서 및 발간물
		];
	
	var topLevelInfo = _.find(arrTopLevelInfSetCate, {id: cateId});
	
	// 정보값이 있을경우
	if ( !(_.isEmpty(topLevelInfo)) ) {
		// 클래스명 변경(이미지 표시)
		sect.empty().append($(topLevelInfo.img)).show();
		
		//보고서 및 발간물 소개 페이지일 경우 높이 변경
		if(topLevelInfo.id == "NA50000") {
			$(".content_text").css("height","807px");
		}
		
		$("#main-text-sect").hide();	// 정보셋 내용 숨김
		
		setTimeout(function() {
			// 해당 위치로 포커스
			var node = $("#treeObj").dynatree("getTree").getNodeByKey(topLevelInfo.id);
			/*if ( !node.bExpanded ) {
				node.toggleExpand();
			}*/
			
			node.focus();
			
			// 네비게이션 로케이션 설정 - 2020.01.09
			var sp = node.data["fullPath"].split('>');
			if ( sp.length > 0 ) {
				$(".contents-navigation").empty().append("<span class=\"icon-home\">Home</span>");
				
				for ( var i in sp ) {
					$(".contents-navigation").append("<span class=\"icon-gt\">&gt;</span>");
					$(".contents-navigation").append("<span class=\"location\">"+ sp[i] +"</span>");
					$("title").text(sp[i] + " | 열린국회정보");
				}
			}
			
			changeTreeAreaHeight();
		}, 100);
		
		return true;
	}
	else {
		return false;
	}
}

/**
 * 분류체계에 속해있는 특정 정보셋은 해당 화면으로 바로 이동한다.
 * 
 * IO5002171I676947 : 국회의원 검색
 * IPJ0021727H49526 : 정당 및 교섭단체 현황 정보
 * IAO002173HS30233 : 의정활동 통합현황
 * IWA0021747D35167 : 분야별 공개 개요
 * IQ60021753Q12716 : 지원조직별 공개 개요
 * IJZ002176F347112 : 보고서 및 발간물 전체
 * IU4002194MU71141 : 역대 국회의원 통합현황 --> 운영반영시 아이디 변경
 */
function infsLinkPageMove(infsId, isPopup) {
	// 국회의원 검색, 정당 및 교섭단체 현황정보
	var arrInfsetLinkId = [
		{ id: "IO5002171I676947", cateId: "", url: "/portal/assm/search/memberSchPage.do" }, 
		{ id: "IPJ0021727H49526", cateId: "", url: "/portal/assm/assmPartyNegotiationPage.do" },
		{ id: "IAO002173HS30233", cateId: "", url: "/portal/bpm/prc/prcMstPage.do" },
		{ id: "IWA0021747D35167", cateId: "NA20000", url: ""},
		{ id: "IQ60021753Q12716", cateId: "NA30000", url: ""},
		{ id: "IJZ002176F347112", cateId: "", url: "/portal/nadata/catalog/naDataCommPage.do" } ,
		//{ id: "IU4002194MU71141", cateId: "", url: "/portal/assm/search/memberHistSchPage.do" }	//로컬
		{ id: "I490021960653826", cateId: "", url: "/portal/assm/search/memberHistSchPage.do" }	//운영
	];
	
	var data = _.find(arrInfsetLinkId, {id: infsId});
	
	// 파라미터로 위의 INFS_ID가 전달될경우
	if ( !(_.isEmpty(data)) ) {
		if ( !(_.isEmpty(data.url)) ) {
			if ( isPopup ) {
				window.open(data.url, "infsLinkPagePop");
			}
			else {
				location.href = data.url;
			}
			return true;
			
		}
		else if ( !(_.isEmpty(data.cateId)) ) {
			// URL 바로가기 안하고 분류체계가 선택된 상태
			infsTreeTopLevelSelect(data.cateId);
			setTimeout(function() {
				$("#treeObj").dynatree("getTree").getNodeByKey(infsId).focus();
			}, 100);
			return true;
		}
		else {
			$("#treeObj").dynatree("getTree").getNodeByKey(infsId).focus();
		}
		
		return true;
	}
	else {
		return false;
	}
}

/**
 * 트리 로드
 */
function loadTree() {
	doAjax({
		url: "/portal/infs/cont/selectInfoCateTree.do",
		params: "cateDataGubun=" + $("input[name=cateDataGubun]").val(),
		callback: function(res) {
			var data = res.data;
			$("#treeObj").dynatree({
		        selectMode: 3,
		        children: data,
		        onClick: function (node, event) {
		        	if(!node.data.isFolder)  {
	        			setTimeout(function() {
	        				if ( infsLinkPageMove(node.data.key, true) ) {
	        					return false;
	        				}
	        				else {
	        					treeInfsClick(node.data.key, node.data.parInfsId);
	        				}
	        			}, 0);
		        	}
		        	else if ( node.data.Level == 1 ) {
		        		infsTreeTopLevelSelect(node.data.infsId);
		        	}
		        }
		    });
			
			$("#treeObj").dynatree("getTree").reload();
		}
	});
	
	function treeInfsClick(id, parCateId) {
		
		// 로딩중...
		gfn_showLoading();
		
		setTimeout(function() {
			// id 선택시 처리 정보셋 상세조회
			loadInfs({
				id: id,
				parCateId: parCateId
			});
		}, 10);
	}
}

/**
 * 정보셋 조회
 * @param data.id			정보셋 ID
 * @param data.parCateId	상위 카테고리 ID
 * @param mobile			모바일 리스트에서 클릭하여 접근 하였는지 여부
 * @returns
 */
function loadInfs(data) {
	data.id 			= data.id || "";
	data.parCateId 		= data.parCateId || "";
	data.mobile 		= data.mobile || false;
	
	// 초기 기본이미지 화면 숨김
	if ( $("#main-img-sect").css("display") == 'block' ) {
		$("#main-img-sect").hide();		// 기본이미지 숨기고
		$("#main-text-sect").show();	// 내용 표시
	}
	$("#shareInfsId").val(data.id);
	$("#shareCateId").val(data.parCateId);
	var loadSuccess = function() {
		var deferred = $.Deferred();
		try {
			selectInfsDtl(data.id, data.parCateId);	// 정보셋 상세조회
			selectInfsExp(data.id);					// 정보셋 설명 조회
			selectInfsRel(data.id);					// 정보셋에 연결된 데이터들 조회(문서, 공개, 통계)
			deferred.resolve(true);
		} catch (err) {
			deferred.reject(false);
		}
		return deferred.promise();
	};
	
	loadSuccess().done(function(message) {
	}).always(function() {
		setTimeout(function() {
			// 트리 높이 컨텐츠 사이즈와 동일하도록 변경
			changeTreeAreaHeight();
			
			if ( data.mobile ) {
				$(".content_text").show();
				$(".mobile_content_all").hide();
				$("#main-text-sect").show();
			}
			
			gfn_hideLoading();
		}, 100);
	});
}


/**
 * 정보셋 상세조회
 * @param id	정보셋 ID
 * @returns
 */
function selectInfsDtl(id, parCateId) {
	doAjax({
		url: "/portal/infs/cont/selectInfsDtl.do",
		params: "infsId="+id + "&parCateId="+parCateId,
		callback: function(res) {
			var data = res.data;
			if ( data != null ) {
				Object.keys(data).map(function(key, idx) {
					if ( key == "cateFullnm" ) {	// 메뉴 LOCATION
						var sp = data[key].split('>');
						// 컨텐츠 내의 분류체계 수정
						$(".content_location").empty();
						for ( var i in sp ) {
							$(".content_location").append("<span>"+ sp[i] +"</span>");
						}
						
						// 네비게이션 로케이션 설정 - 2020.01.09
						$(".contents-navigation").empty().append("<span class=\"icon-home\">Home</span>");
						for ( var i in sp ) {
							if ( i == 2 )	break;	// 2레벨 까지만 표시
							$(".contents-navigation").append("<span class=\"icon-gt\">&gt;</span>");
							$(".contents-navigation").append("<span class=\"location\">"+ sp[i] +"</span>");
						}
						
						if ( sp.length == 1 ) {
							$(".content_location").append("<span>"+ $("#dtlTxt_infsNm").text() +"</span>");
							
							$(".contents-navigation").append("<span class=\"icon-gt\">&gt;</span>");
							$(".contents-navigation").append("<span class=\"location\">"+ $("#dtlTxt_infsNm").text() +"</span>");
						}
					}
					else if ( $("#dtlTxt_" + key).length > 0 ) {
						$("#dtlTxt_" + key).text(data[key]);
					}
					else if ( $("#dtlVal_" + key).length > 0 ) {
						$("#dtlVal_" + key).val(data[key]);
					}
				});
				
				//웹접근성 조치 20/11/09 
				var title = $(".contents-navigation > span:last").text();
				$("title").text(title + " | 정보공개 콘텐츠 | 열린국회정보");

				//보고서 발간물 하위 메뉴 클릭 시 높이 고정 해제
				$(".content_text").css("height","");

			}
			
		}
	});
}

/**
 * 정보셋 설명 조회
 * @param id	정보셋 ID
 * @returns
 */
function selectInfsExp(id) {
	var title = "", cont = "";
	
	doAjax({
		url: "/portal/infs/cont/selectInfsExp.do",
		params: "infsId="+id,
		callback: function(res) {
			var datas = res.data;
			var expTabSect = $("#exp-tab-sect");
			var expMbTabSect = $("#exp-mbTab-sect");	// 모바일 탭
			var expContHeaderSect = $("#exp-cont-sect-header");
			var expContSect = $("#exp-cont-sect");
			expTabSect.empty().show();
			expMbTabSect.empty().show();
			expContHeaderSect.empty().show();
			expContSect.empty().show();

			if ( datas.length > 0 ) {
				for ( var i in datas ) {
					var data = datas[i];
					
					// 타이틀
					title = $(template.exp.title);
					//웹접근성 조치 23.11.06
					title.attr("title", i == 0 ? data.infsExpTit + " 선택됨" : data.infsExpTit);	// 툴팁
					title.text(data.infsExpTit).addClass(i == 0 ? "on" : "")
						.bind("click", {idx: i}, function(event) {
							bindExpTabSelect(event.data.idx);
						}).bind("keydown", {idx: i}, function(event) {
							if (event.which == 13) {
								bindExpTabSelect(event.data.idx);
							}
						});
					
					expTabSect.append(title);
					
					// 모바일 select
					expMbTabSect.append("<option>"+ data.infsExpTit +"</option>");

					// 탭과 내용 사이 블록에 헤딩 제공
					// 첫 탭만 구성, 나머지 탭은 탭 선택 이벤트에서 처리
					if (i == 0) {
						expContHeaderSect.html(data.infsExpTit).show();
					}

					// 내용
					cont = $(template.exp.cont);
					cont.css("display", (i == 0 ? "block" : "none"));
					cont.find("strong").text(data.infsExpTit);
					cont.find(".infsDtlCont").html(data.infsDtlCont);
					expContSect.append(cont);
				}
			}
			else {
				expTabSect.hide();
				expMbTabSect.hide();
				expContHeaderSect.hide();
				expContSect.hide()
			}
		}
	});
}

/**
 * 정보셋에 연결된 데이터들 조회(문서, 공개, 통계)
 * @param id	정보셋 ID
 * @returns
 */
function selectInfsRel(id) {
	doAjax({
		url: "/portal/infs/cont/selectInfsRel.do",
		params: "infsId="+id,
		callback: function(res) {
			var data = res.data;
			afterInfsRelDoc(data.docList);
			afterInfsRelOpenNStts(data);
		}
	});
}

/**
 * 정보셋에 연결된 데이터 화면에 렌더링한다.(문서)
 * @param datas
 * @returns
 */
function afterInfsRelDoc(datas) {
	var tbody = $("#relDoc-sect");
	
	tbody.empty();
	
	if ( datas.length > 0 ) {
		$("div[id^=relDoc-sect]").show();
		
		for ( var i in datas ) {
			var row = $(template.list.row);
			var data = datas[i];
			row.find(".infaNm").text(data.infaNm)
				.bind("click", { infaId: data.infaId}, function(event) {
					if ( !GC_ITEM_POPUP || GC_ITEM_POPUP.closed ) {
						GC_ITEM_POPUP = window.open(com.wise.help.url("/portal/doc/docInfPage.do/" + event.data.infaId + "?" + GC_IS_INFSPOP), 'infsPop');
						GC_ITEM_POPUP.focus();
						return;
					}
					else {
						if ( GC_ITEM_POPUP )	GC_ITEM_POPUP.window.close();
						GC_ITEM_POPUP = window.open(com.wise.help.url("/portal/doc/docInfPage.do/" + event.data.infaId + "?" + GC_IS_INFSPOP), 'infsPop');
						GC_ITEM_POPUP.focus();
					}
				
				}).bind("keydown", { infaId: data.infaId}, function(event) {
					if (event.which == 13) {
						if ( !GC_ITEM_POPUP || GC_ITEM_POPUP.closed ) {
							GC_ITEM_POPUP = window.open(com.wise.help.url("/portal/doc/docInfPage.do/" + event.data.infaId + "?" + GC_IS_INFSPOP), 'infsPop');
							GC_ITEM_POPUP.focus();
							return;
						}
						else {
							if ( GC_ITEM_POPUP )	GC_ITEM_POPUP.window.close();
							GC_ITEM_POPUP = window.open(com.wise.help.url("/portal/doc/docInfPage.do/" + event.data.infaId + "?" + GC_IS_INFSPOP), 'infsPop');
							GC_ITEM_POPUP.focus();
						}
					}
				});
			row.find(".bunyaB span").text(data.cateNm);
			row.find(".bunyaB img").attr("src", "/images/icon_"+ (GC_BUNYA_IMG[data.cateId]) +".png");
			row.find(".bunyaB img").attr("alt", ""); 
			row.find(".infaExp").text(com.wise.util.ellipsis(data.infaExp, 60, "..."));
			row.find(".infsTag").text(data.opentyTagNm);
			row.find(".openYmd").text(data.openYmd);

			// 서비스 아이콘
			viewOpenSrv(row.find(".openSrv"), {
					infaId: data.infaId,
					opentyTag: "D",
					openSrv: data.openSrv
				});	
			tbody.append(row);
		}
	}
	else {
		$("div[id^=relDoc-sect]").hide();
	}
}

/**
 * 정보셋에 연결된 데이터 화면에 렌더링한다.(공공/통계)
 * @param data
 * @returns
 */
function afterInfsRelOpenNStts(data) {
	var openList = data.openList;
	var sttsList = data.sttsList;
	var tbody = $("#relOpenNStts-sect");
	
	tbody.empty()
	
	
	if ( openList.length == 0 && sttsList.length == 0 ) {
		$("div[id^=relOpenNStts-sect]").hide();
		return false;
	}
	
	if ( openList.length > 0 ) {
		$("div[id^=relOpenNStts-sect]").show();
		
		for ( var i in openList ) {
			var row = $(template.list.row);
			var data = openList[i];
			var arrSrvCd = parseSrvCd(data.openSrv);
			var srvSeq = arrSrvCd.seq[0];
			
			row.find(".infaNm").text(data.infaNm)
				.bind("click", { 
					infaId: data.infaId,
					srvSeq: srvSeq
				}
				, function(event) {
					if ( !GC_ITEM_POPUP || GC_ITEM_POPUP.closed ) {
						GC_ITEM_POPUP = window.open(com.wise.help.url("/portal/data/service/selectServicePage.do?infId=" + event.data.infaId + "&infSeq=" + srvSeq + "&" + GC_IS_INFSPOP), 'infsPop');
						GC_ITEM_POPUP.focus();
						return;
					}
					else {
						if ( GC_ITEM_POPUP )	GC_ITEM_POPUP.window.close();
						GC_ITEM_POPUP = window.open(com.wise.help.url("/portal/data/service/selectServicePage.do?infId=" + event.data.infaId + "&infSeq=" + srvSeq + "&" + GC_IS_INFSPOP), 'infsPop');
						GC_ITEM_POPUP.focus();
					}
				}).bind("keydown", { 
					infaId: data.infaId,
					srvSeq: srvSeq
				}, function(event) {
					if (event.which == 13) {
						if ( !GC_ITEM_POPUP || GC_ITEM_POPUP.closed ) {
							GC_ITEM_POPUP = window.open(com.wise.help.url("/portal/data/service/selectServicePage.do?infId=" + event.data.infaId + "&infSeq=" + srvSeq + "&" + GC_IS_INFSPOP), 'infsPop');
							GC_ITEM_POPUP.focus();
							return;
						}
						else {
							if ( GC_ITEM_POPUP )	GC_ITEM_POPUP.window.close();
							GC_ITEM_POPUP = window.open(com.wise.help.url("/portal/data/service/selectServicePage.do?infId=" + event.data.infaId + "&infSeq=" + srvSeq + "&" + GC_IS_INFSPOP), 'infsPop');
							GC_ITEM_POPUP.focus();
						}
					}
				});
			row.find(".bunyaB span").text(data.cateNm);
			row.find(".bunyaB img").attr("src", "/images/icon_"+ (GC_BUNYA_IMG[data.cateId]) +".png");
			row.find(".bunyaB img").attr("alt", "");
			row.find(".infaExp").text(com.wise.util.ellipsis(data.infaExp, 60, "..."));
			row.find(".infsTag").text(data.opentyTagNm);
			row.find(".openYmd").text(data.openYmd);
			
			// 서비스 아이콘
			viewOpenSrv(row.find(".openSrv"), {
					infaId: data.infaId,
					opentyTag: "O",
					openSrv: data.openSrv
				});	
			tbody.append(row);
		}
	}
	
	if ( sttsList.length > 0 ) {
		$("div[id^=relOpenNStts-sect]").show();
		
		for ( var i in sttsList ) {
			var row = $(template.list.row);
			var data = sttsList[i];
			row.find(".infaNm").text(data.infaNm)
				.bind("click", { infaId: data.infaId}, function(event) {
					if ( !GC_ITEM_POPUP || GC_ITEM_POPUP.closed ) {
						GC_ITEM_POPUP = window.open(com.wise.help.url("/portal/stat/selectServicePage.do/" + event.data.infaId + "?" + GC_IS_INFSPOP), 'infsPop');
						GC_ITEM_POPUP.focus();
						return;
					}
					else {
						if ( GC_ITEM_POPUP )	GC_ITEM_POPUP.window.close();
						GC_ITEM_POPUP = window.open(com.wise.help.url("/portal/stat/selectServicePage.do/" + event.data.infaId + "?" + GC_IS_INFSPOP), 'infsPop');
						GC_ITEM_POPUP.focus();
					}
				}).bind("keydown", { infaId: data.infaId}, function(event) {
					if (event.which == 13) {
						if ( !GC_ITEM_POPUP || GC_ITEM_POPUP.closed ) {
							GC_ITEM_POPUP = window.open(com.wise.help.url("/portal/stat/selectServicePage.do/" + event.data.infaId + "?" + GC_IS_INFSPOP), 'infsPop');
							GC_ITEM_POPUP.focus();
							return;
						}
						else {
							if ( GC_ITEM_POPUP )	GC_ITEM_POPUP.window.close();
							GC_ITEM_POPUP = window.open(com.wise.help.url("/portal/stat/selectServicePage.do/" + event.data.infaId + "?" + GC_IS_INFSPOP), 'infsPop');
							GC_ITEM_POPUP.focus();
						}					}
				});
			row.find(".bunyaB span").text(data.cateNm);
			row.find(".bunyaB img").attr("src", "/images/icon_"+ (GC_BUNYA_IMG[data.cateId]) +".png");
			row.find(".bunyaB img").attr("alt", data.cateNm + " 아이콘"); 
			row.find(".infaExp").text(com.wise.util.ellipsis(data.infaExp, 60, "..."));
			row.find(".infsTag").text(data.opentyTagNm);
			row.find(".openYmd").text(data.openYmd);

			// 서비스 아이콘
			viewOpenSrv(row.find(".openSrv"), {
					infaId: data.infaId,
					opentyTag: "S",
					openSrv: data.openSrv
				});	
			tbody.append(row);
		}
	}
}

/**
 * 정보공개 콘텐츠 모바일 목록을 조회한다.
 * @param page	페이지
 * @returns
 */
function selectInfsCont(page) {
	page = page || 1;
	doSearch({
		url : "/portal/infs/cont/selectInfsContPaging.do",
		page : page,
		before : beforeSelectInfsCont,
		after : afterSelectInfsCont,
		pager : "result-pages-sect"
	});
	
	if ( $("#modelMbCate").css("display") == 'block' ) {
		$("#modelMbCate").hide();
	}
}

/**
 * 정보공개 콘텐츠 모바일 목록 조회 전처리
 */
function beforeSelectInfsCont(options) {
	var form = $("#form");
	var data = {};
	

	com.wise.util.isEmpty(options.page) ? form.find("[name=page]").val("1") : form.find("[name=page]").val(options.page);
	com.wise.util.isEmpty(options.rows) ? form.find("[name=rows]").val("10") : form.find("[name=rows]").val(options.rows);
	
	// 모바일에서 분류 선택한후 검색할경우 
	if ( com.wise.util.isEmpty(form.find("#mobileParamCateId").val()) ) {
		// 마지막으로 선택한 분류를 찾음(대, 중분류까지 선택했으면 중분류 ID를 가져온다)
		var selMbCateId = "";
		$("[id^=selMbCate]").each(function() {
			if ( $(this).find("option").length > 1 && $(this).val() != "" ) {
				selMbCateId = $(this).attr("id");
			}
		});
		
		form.find("input[name=cateId]").remove();
		if ( !com.wise.util.isBlank(selMbCateId) ) {
			var selMbCateIdVal = $("#"+selMbCateId).val();
			// HIDDEN 생성
			form.append("<input type=\"hidden\" name=\"cateId\" value=\""+ selMbCateIdVal +"\">");
		}
	}
	// 파라미터로 바로 분류검색하고 들어온경우
	else {
		var mobileParamCateId = form.find("#mobileParamCateId").val();
		form.append("<input type=\"hidden\" name=\"cateId\" value=\""+ form.find("#mobileParamCateId").val() +"\">");	// 히든으로 추가한 뒤 삭제
		form.find("#mobileParamCateId").remove();
		
		// 모바일 콤보박스 세팅
		doAjax({
			url: "/portal/infs/cont/selectInfoCateFullPathCateId.do",
			params: "cateId=" + mobileParamCateId,
			callback: function(res) {
				var pathCateId = res.data.pathCateId;
				if ( !com.wise.util.isEmpty(pathCateId) ) {
					var sp = pathCateId.split(',');
					for ( var i in sp ) {
						if ( sp[i] != mobileParamCateId ) {	// 현재 선택된 분류는 조회안함
							selectInfoCateChild(sp[i]);	// 콤보박스 로딩
						}
						
						// 해당 분류 선택처리
						if ( i == 0 ) elementId = "selMbCate1";
						if ( i == 1 ) elementId = "selMbCate2";
//						if ( i == 2 ) elementId = "selMbCate3";
//						if ( i == 3 ) elementId = "selMbCate4";
						$("select[id=" + elementId + "]").val(sp[i]);
					}
					
					// 분류선택 TEXT 창에 FULLPATH 표시
					var arrMbCate = [];
					$("select[id^=selMbCate]").each(function() {
						if ( !com.wise.util.isBlank($(this).val()) ) {
							arrMbCate.push($(this).find(":selected").text());
						}
					});
					$("#txtMbCate").val(arrMbCate.join(">"));
				}
			}
		})
	}
	
	$.each(form.serializeArray(), function(index, element) {
        switch (element.name) {
            case "page":
            case "rows":
            case "txtMbSearchVal":
            case "cateId":	
                data[element.name] = element.value;
                break;
        }
    });
	
	data["isMobile"] = GC_ISMOBILE;
	
	return data;
}

/**
 * 정보공개 콘텐츠 모바일 목록 조회 후처리
 * @param datas
 * @returns
 */
function afterSelectInfsCont(datas) {
	var item = "",
		data = null,
		list = $("#result-list-sect");
	
	list.empty();
	if ( datas.length > 0 ) {
		for ( var i in datas ) {
			data = datas[i];
			
			item = $(template.mobile.list);
			item.find(".infsNm").text(data.infsNm)
				.bind("click", { 
						id: data.infsId,
						parCateId: data.cateId,
						infsNm: data.infsNm,
						mobile: true
					}, function(event) {
						loadInfs(event.data);
						if(event.data.infsNm != null) $("#dtlTxt_infsNm").text(event.data.infsNm);
						return false;
				}).bind("keydown", { 
						id: data.infsId,
						parCateId: data.cateId,
						infsNm: data.infsNm,
						mobile: true
					}, function(event) {
						if (event.which == 13) {
							loadInfs(event.data);
							if(event.data.infsNm != null) $("#dtlTxt_infsNm").text(event.data.infsNm);
							return false;
						}
				});
			
			item.find(".topCateNm").text(data.topCateNm);
			list.append(item);
		}
	}
	else {
		list.append($(template.mobile.none));
	}
}

/**
 * 정보셋 검색
 */
function searchInfs() {
	doSearch({
		url : "/portal/infs/cont/searchInfsCont.do",
		before : beforeSearchInfs,
		after : afterSearchInfs,
	});
}

/**
 * 정보셋 검색 전처리
 * @param options
 * @returns
 */
function beforeSearchInfs(options) {
	var data = {};
	
	data["searchVal"] = htmlTagFilter($("#txtSearchVal").val());
	data["orderBy"] = $("#paramOrderBy").val();
	data["cateDataGubun"] = $("input[name=cateDataGubun]").val();
	data["isMobile"] = GC_ISMOBILE;
	
	if ( com.wise.util.isBlank(data.searchVal) ) {
		alert("검색어를 입력하세요.");
		return null;
	}
	
	$("#paramOrderBy").val("");
	return data;
}

/**
 * 정보셋 검색 후처리
 * @param datas	검색 데이터
 * @returns
 */
function afterSearchInfs(datas) {
	var item = "", highlight = "", infsNm = "", data = null, regex = null,
		searchSect = $("#result-search-sect"),
		searchVal = htmlTagFilter($("#txtSearchVal").val()),
		searchValSplit = searchVal.split(" ");
	
	$(".searchResult").show();
	searchSect.empty();
	
	if ( datas.length > 0 ) {
		for ( var i in datas ) {
			data = datas[i];
			item = $(template.search.item);
			item.find(".tit").text(data.infsNm)
				.bind("click", { 
					id: data.infsId,
					parCateId: data.cateId,
					infsNm: data.infsNm
				},  function(event) {
					// 로딩중...
					gfn_showLoading();
					
					loadInfs(event.data);
					if(event.data.infsNm != null) $("#dtlTxt_infsNm").text(event.data.infsNm);
					return false;
				}).bind("keydown", { 
						id: data.infsId,
						parCateId: data.cateId,
						infsNm: data.infsNm
					}, function(event) {
						if (event.which == 13) {
							// 로딩중...
							gfn_showLoading();
							
							loadInfs(event.data);
							if(event.data.infsNm != null) $("#dtlTxt_infsNm").text(event.data.infsNm);
							return false;
						}
				});
			searchSect.append(item);
		}
		
		// 검색어 강조 처리
		$("#result-search-sect li a strong").each(function () {
	    	for( var i in searchValSplit ) {
	    		if ( !com.wise.util.isBlank(searchValSplit[i]) ) {
		    		regex = new RegExp(searchValSplit[i],'gi');
		    		infsNm = $(this).text();
		    		infsNm = (infsNm.toUpperCase()).match(searchValSplit[i].toUpperCase());
		    		$(this).html( $(this).html().replace(regex, "<span class='text-red'>"+infsNm+"</span>") );
	    		}
	    	}
	    });
	}
	else {
		item = $(template.search.item);
		item.find(".tit").text("조회된 데이터가 없습니다.");
		searchSect.append(item);
	}
}

/**
 * 서비스 아이콘을 표시한다
 * @param item
 * @param openSrv
 * @param infsId
 * @returns
 */
function viewOpenSrv(item, options) {
	options = options || {};
	var srv = "", otData = {}, elmtSrv = null,
		arrSrv = parseSrvCd(options.openSrv);
	
	for ( var i in arrSrv.cd ) {
		srv = arrSrv.cd[i];
		seq = arrSrv.seq[i];
		// 규정(지침) 강제로 파일을 링크로 표시
		if ( options.opentyTag == "D" ) {
			//srv = "L";
		}
		elmtSrv = $(template.list.srv[srv]);
		elmtSrv.bind("click", {
					infaId: options.infaId,
					seq: seq,
					srv: srv
				}, function(event) {
					otData = getOpentyTagData(options, event.data);

					if ( !GC_SRV_POPUP || GC_SRV_POPUP.closed ) {
						GC_SRV_POPUP = window.open(com.wise.help.url(otData.url), 'infsSrvPop');
						GC_SRV_POPUP.focus();
						return;
					}
					else {
						if ( GC_SRV_POPUP )	GC_SRV_POPUP.window.close();
						GC_SRV_POPUP = window.open(com.wise.help.url(otData.url), 'infsSrvPop');
						GC_SRV_POPUP.focus();
					}
			}).bind("keydown", {
					infaId: options.infaId,
					seq: seq
				}, function(event) {
					if (event.which == 13) {
						otData = getOpentyTagData(options, event.data);
						
						if ( !GC_SRV_POPUP || GC_SRV_POPUP.closed ) {
							GC_SRV_POPUP = window.open(com.wise.help.url(otData.url), 'infsSrvPop');
							GC_SRV_POPUP.focus();
							return;
						}
						else {
							if ( GC_SRV_POPUP )	GC_SRV_POPUP.window.close();
							GC_SRV_POPUP = window.open(com.wise.help.url(otData.url), 'infsSrvPop');
							GC_SRV_POPUP.focus();
						}
					}
				});
		
		item.append(elmtSrv);
	}
}

/**
 * 서비스 코드를 파싱한다
 * @param openSrv	DB에서 조회되는 서비스코드
 */
function parseSrvCd(openSrv) {
	openSrv = openSrv || "";
	
	var rtn = { cd: [], seq: [] },
		srv = null,
		arrSrv = openSrv.split(",");
	
	for ( var i in arrSrv ) {
		srv = arrSrv[i].split('-');
		cd = srv[0];
		seq = srv[1];
		
		if ( !com.wise.util.isEmpty(srv[0]) ) {
			rtn.cd.push(srv[0]);
			rtn.seq.push(srv[1]);
		}
	}
	return rtn;
}

/**
 * 정보셋 구분 데이터 정보를 조회한다.
 */
function getOpentyTagData(data, srvData) {
	var obj = {};
	
	switch ( data.opentyTag ) {
	case "D":
		obj.url = "/portal/doc/docInfPage.do/" + data.infaId;
		obj.id = "docId";
		obj.gubun = "seq";
		break;
	case "O":
		obj.url = "/portal/data/service/selectServicePage.do";// + data.infaId;
		obj.id = "infId";
		obj.gubun = "infSeq";
		break;
	case "S":
		obj.url = "/portal/stat/selectServicePage.do/" + data.infaId + ( srvData.srv == "C" ? "C" : "" );
		obj.id = "statblId";
		obj.gubun = "";
		break;
	}
	
	// URL에 파라미터 붙임
	var params = "?" + obj.id + "=" + data.infaId;
	params += !com.wise.util.isBlank(obj.gubun) ? "&" + obj.gubun + "=" + srvData.seq : "";
	params += "&" + GC_IS_INFSPOP;	// 정보목록 컨텐츠 접근여부
	
	obj.url = obj.url + params;
	
	return obj;
}

/**
 * 모바일 정보셋 분류 조회
 * @param parCateId	선택한 분류ID
 * @param changeId	선택한 콤보ID
 * @returns
 */
function selectInfoCateChild(parCateId, changeId) {
	var mobileParamCateId = $("#mobileParamCateId").val();
	
	// 선택한 콤보박스의 하위항목 초기화
	if ( !com.wise.util.isEmpty(changeId) )	{
		initSelectMobileCate(changeId);
	}

	// 현재 마지막으로 선택한 분류의 레벨(위치)을 구한다.
	var selMbCateId = "";
	$("[id^=selMbCate]").each(function() {
		if ( $(this).find("option").length > 1 && $(this).val() != "" ) {
			selMbCateId = $(this).attr("id");
		}
	});
	
	var selMbCateIdIdx = Number(selMbCateId.replace("selMbCate", ""));
	var changeIdIdx = !com.wise.util.isEmpty(changeId) ? Number(changeId.replace("selMbCate", "")) : 0; 
	
	// 소분류까지 선택했을경우 중분류 초기화시켰을때 대분류는 유지함.
	if ( changeIdIdx <= selMbCateIdIdx ) {
		searchInfoCateChild(parCateId, mobileParamCateId);
		
		if ( parCateId === "T" ) {
			searchInfoCateChild(mobileParamCateId, "");
		}
	}
	
	setTextMobileCateFullPath();
}

/**
 * 분류 목록을 조회한다.
 * @param parCateId	부모 분류ID
 * @param mobileParamCateId	파라미터 인자로 넘어온 분류ID
 * @returns
 */
function searchInfoCateChild(parCateId, mobileParamCateId) {
	var elementId = "";
	doAjax({
		url: "/portal/infs/cont/selectInfoCateChild.do",
		params: "parCateId=" + parCateId,
		callback: function(res) {
			if ( res.data.length > 0 ) {
				
				if 		( res.data[0].cateLvl == 1 ) {	elementId = "selMbCate1";	}
				else if ( res.data[0].cateLvl == 2 ) {	elementId = "selMbCate2";	} 
//				else if ( res.data[0].cateLvl == 3 ) {	elementId = "selMbCate3";	}
//				else if ( res.data[0].cateLvl == 4 ) {	elementId = "selMbCate4";	}
				
				appendSelectMobileCate(elementId, mobileParamCateId, res.data);
			}
		}
	});
}

/**
 * 모바일 정보셋 분류 조회 후처리
 * @param elementId
 * @param data
 * @returns
 */
function appendSelectMobileCate(elementId, mobileParamCateId, data) {
	var separateId = "NA30000";		// 지원조직별 공개
	
	if ( com.wise.util.isBlank(elementId) && data.length == 0 )	return false;
	
	for ( var i in data ) {
		
		if ( mobileParamCateId === separateId ) {
			if ( data[i].cateId != separateId ) continue;	// 지원조직별만 표시
		}
		else {
			if ( data[i].cateId == separateId ) continue;	// 지원조직별 공개 표시안함
		}
		
		if ( i == 0 ) {
			$("#"+elementId).empty();
			$("#"+elementId).append("<option value=\"\">선택</option>");
			$("#"+elementId).append("<option value=\""+data[i].cateId+"\">"+ data[i].cateNm +"</option>");
		}
		else {
			$("#"+elementId).append("<option value=\""+data[i].cateId+"\">"+ data[i].cateNm +"</option>");
		}
	}
}

/**
 * 분류선택 TEXT 창에 FULLPATH 표시
 * @returns
 */
function setTextMobileCateFullPath() {
	var arrMbCate = [];
	$("select[id^=selMbCate]").each(function() {
		if ( !com.wise.util.isBlank($(this).val()) ) {
			arrMbCate.push($(this).find(":selected").text());
		}
	});
	$("#txtMbCate").val(arrMbCate.join(">"));
}

/**
 * 모바일 정보셋 분류 콤보박스 초기화(하위 포함)
 * @param elementId
 * @returns
 */
function initSelectMobileCate(elementId) {
	// 하위 콤보 초기화(대분류 변경시 하위 중,소,세 분류 초기화)
	var idx = Number(elementId.replace("selMbCate", "")) + 1;
	for ( var i=idx; i <= 4; i++ ) {
		$("#selMbCate" + String(i) + " option").remove();
		$("#selMbCate" + String(i)).append("<option value=\"\">선택</option>");
	}
}

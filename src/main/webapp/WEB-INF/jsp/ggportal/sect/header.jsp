<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)header.jsp 1.0 2015/06/15                                          --%>
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
<%-- 상단 섹션 화면이다.                                                    --%>
<%--                                                                        --%>
<%-- @author 김은삼                                                         --%>
<%-- @version 1.0 2015/06/15                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<div id="skipNavi">
    <ul>
    	<li><a href="#content">본문 바로가기</a></li>
        <li><a href="javascript:;">주 메뉴 바로가기</a></li> 
    </ul>
</div>

<!-- header --> 
<div class="headerWrap">
	<header id="header">
	
	<div class="area_navi">
	<c:choose>
		<c:when test="${requestScope.systemAppType eq 'clb'}">
		<h1><a href="<c:url value="/" />" title="국회 내부협엽시스템 메인페이지 이동"><img src="<c:url value="/img/ggportal/desktop/common/h1_${requestScope.systemAppType}.png" />" class="mq_tablet" alt="국회 내부협업시스템" /><img src="<c:url value="/img/ggportal/mobile/common/h1_${requestScope.systemAppType}.png" />" class="mq_mobile" alt="국회 내부협업시스템" /></a></h1>
		</c:when>
		<c:otherwise>
		<h1><a href="<c:url value="/" />" title="국회나눔데이터 메인페이지 이동"><img src="<c:url value="/img/ggportal/desktop/common/h1.png" />" class="mq_tablet" alt="국회나눔데이터" /><img src="<c:url value="/img/ggportal/mobile/common/h1.png" />" class="mq_mobile" alt="국회나눔데이터" /></a></h1>
		</c:otherwise>
	</c:choose>
	    <span id="view_totalSearch" class="search mq_tablet">
    		<label for="search" class="hide"></label>
			<input type="search" id="search" autocomplete="on" placeholder="검색어를 입력하세요" title="검색" style="ime-mode:active;" /><a id="global-search-button" href="#global-search-button" class="btn_search"><span>검색</span></a>
		</span>
	    <form id="global-search-form" name="global-search-form" method="post">
	        <input type="hidden" name="searchWord" />
	    </form>
	    <script type="text/javascript">
		    /**
		     * 메인 1레벨 메뉴 over 했을경우 메뉴에 맞는 text를 변경한다.
		     * @param idx	메뉴 순서
		     */
		    function setGnbSubText(idx) {
		    	var systemAppType = '${requestScope.systemAppType}';
		    	var menuNm = "";
		    	var menuDesc = "";
		    	if ( systemAppType == "clb" ) {
		    		switch(idx) {
				    	case 0 :
		    				menuNm = "내부협업데이터";
			    			menuDesc = "내부데이터를 부서간에 공유하여<br/> 데이터 활용촉진을 도모합니다. ";
			    			break;
			    		case 1 :
			    			menuNm = "통계데이터";
			    			menuDesc = "국회 통계연보를 기반으로<br/>다양한 통계데이터를 제공합니다. ";
			    			break;
			    		case 2 :
			    			menuNm = "참여소통";
			    			menuDesc = "여러분의 많은 참여와 <br/>의견을 제시해 주세요.";
			    			break;	
			    		case 3 :
			    			menuNm = "소개";
			    			menuDesc = "협업 및 공유가 필요한 데이터를<br/>유관 부서와 공유하는 시스템입니다.";			    				
			    			break;
		    		}
		    	} else {
		    		switch(idx) {
			    		case 0 :
			    			menuNm = "공공데이터";
			    			menuDesc = "공공데이터를 시민과 공유하고 <br/> 민간의 활용촉진을 도모합니다. ";
			    			break;
			    		case 1 :
			    			menuNm = "통계데이터";
			    			menuDesc = "국회 통계연보를 기반으로<br/>다양한 통계데이터를 제공합니다. ";
			    			break;
			    		case 2 :
			    			menuNm = "활용";
			    			menuDesc = "공공데이터를 이용하여 제작한<br/>앱이나 홈페이지를 공유해 주세요. ";
			    			break;	
			    		case 3 :
			    			menuNm = "참여소통";
			    			menuDesc = "여러분의 많은 참여와 <br/>의견을 제시해 주세요.";
			    			break;
			    		case 4 :
			    			menuNm = "소개";
			    			menuDesc = "시민과 공유하고 민간의 활용을<br/> 위한 개방 포털 서비스입니다.";
			    			break;	
		    		}
		    	}
		    	
		    	$(".gnbSubNew strong").text(menuNm);
		    	$(".gnbSubNew span").html(menuDesc);
		    	
		    }
	        $(function() {
	            $("#navi").find("a").each(function(index, element) {
	                if ($(this).text() == "<c:out value="${requestScope.menu.lvl1MenuPath}" />") {
	                    $(this).addClass("on");
	                    return false;
	                }
	            });
	            
	            // 통합 검색 검색어 필드에 키다운 이벤트를 바인딩한다.
	            $("#search").bind("keydown", function(event) {
	                if (event.which == 13) {
	                    // 통합 검색을 처리한다.
	                    search();
	                    return false;
	                }
	            });
	            
	            // 통합 검색 버튼에 클릭 이벤트를 바인딩한다.
	            $("#global-search-button").bind("click", function(event) {
	                // 통합 검색을 처리한다.
	                search();
	                return false;
	            });
	            
	            // 통합 검색 버튼에 키다운 이벤트를 바인딩한다.
	            $("#global-search-button").bind("keydown", function(event) {
	                if (event.which == 13) {
	                    // 통합 검색을 처리한다.
	                    search();
	                    return false;
	                }
	            });
	        });
	        
	        /**
	         * 통합 검색을 처리한다.
	         */
			function search() {
	        	
	            var searchWord = $("#search").val();
	          
	            var filtArr = ["~","!","@","#","$",
	                           "%","^","&","*","(",
	                           ")","-","+","{","}",
	                           "?","[","]","<",">","/",
	                           "\\","\"",".","'"];
	              var isCheck = false;
	               for(var i=0; i<filtArr.length; i++){
	                  if(searchWord.indexOf(filtArr[i])> -1){
	                     isCheck = true;
	                  }
	               }   
	               if(isCheck){
	            	  alert("특수문자는 사용하실 수 없습니다.");
	            	  $("#search").val("");
	                  return false;
	               }
	             searchWord = searchWord.replace(/&/gi,"&amp;").replace(/\\/gi,"&quot;").replace(/</gi,"&lt;").replace(/>/gi,"&gt;");
	          
	             if (com.wise.util.isBlank(searchWord)) {
	                alert("검색어를 입력하여 주십시오.");
	                $("#search").focus();
	            }
	            else {
	            	
	                // 데이터를 검색하는 화면으로 이동한다.
	                goSearch({
	                    url:"/portal/searchPage.do",
	                    form:"global-search-form",
	                    data:[{
	                        name:"searchWord",
	                        value:searchWord
	                    }]
	                }); 
	            }
	            
	        }

	
	        $(function(){
				//$('.navMenu').on('mouseenter', function(){
				//	$('.gnbSub').stop().slideDown();
				//});
				$('.navMenu').on('mouseleave', function(){
					$('.gnbSub').stop().slideUp();
				});
			});

	    </script>
	</div>
	<div class="subMenu mq_tablet">
	    <a href="<c:url value="/" />" class="logo"><span>국회 공공데이터</span></a>
	    
	    
	<c:choose>
		<c:when test="${requestScope.systemAppType ne 'clb'}">
			<c:choose>
		    <c:when test="${!empty sessionScope.portalUserCd}">
		    <a href="<c:url value="/portal/user/oauth/logout.do" />">로그아웃</a>
		    </c:when>
		    <c:otherwise>
		    <a href="<c:url value="/portal/user/oauth/authorizePage.do" />">로그인</a>
		    </c:otherwise>
		    </c:choose>
		    <a href="<c:url value="/portal/myPage/myPage.do"/>">마이페이지</a>			
		</c:when>
		<c:otherwise>
		<!-- 내부협업 사용안함 -->
		</c:otherwise>
	</c:choose>	    
	</div>
	<a href="javascript:btn_view_allMenu('allMenu');" onclick="javascript:btn_view_allMenu('allMenu');" onkeypress="javascript:btn_view_allMenu('allMenu');" class="btn_view_allMenu" title="전체메뉴 보기"><span>전체메뉴 보기</span></a>
	<a href="#toggle_totalSearch" id="toggle_totalSearch" class="toggle_totalSearch" title="통합검색 열기"><span>통합검색 열기</span></a>
	</header>
	</div>
	
	
<c:choose>
	<c:when test="${requestScope.systemAppType eq 'clb'}">
	<div class="gnbArea">
		<nav class="nav">
			<div class="navMenu">
            <div class="gnbNew">
                <strong>『국회가 먼저 공개합니다』</strong>
                <ul class="gnbMenu">
                    <li class="menu1"><a>내부협업데이터</a></li>
                    <li class="menu1"><a>통계데이터</a></li>
                    <li class="menu3"><a>참여소통</a></li>
                    <li class="menu4"><a>소개</a></li>
                </ul>
            </div>
			<div class="gnbSub">
            	<div class="gnbSubWid">
                    <div class="gnbSubNew gnbBg01">
                        <strong>공공데이터</strong>
                        <span>국회에서 제공하는<br>공공데이터를 열람하실 수 있습니다.</span>
                    </div>
                    <div class="inner">
                        <div class="sub menu1 ">
                            <strong id="gnbMenu1">내부협업데이터</strong>
                            <ul>
                                <li><a href="<c:url value="/portal/data/dataset/searchDatasetPage.do" />">데이터셋</a></li>
                            </ul>
                        </div>
                        <div class="sub menu2">
                            <strong id="gnbMenu2">통계데이터</strong>
                            <ul>
								<li><a href="<c:url value="/portal/stat/easyStatPage.do" />">간편통계</a></li>
								<li><a href="<c:url value="/portal/stat/multiStatSch.do" />">복수통계</a></li>
                            </ul>  
                        </div>
                        <div class="sub menu4">
                            <strong id="gnbMenu4">참여소통</strong>
                            <ul>
                                <li><a href="<c:url value="/portal/bbs/notice/searchBulletinPage.do" />">공지사항</a></li>
								<li><a href="<c:url value="/portal/bbs/qna01/searchBulletinPage.do" />">Q&A</a></li>
								<li><a href="<c:url value="/portal/bbs/faq01/searchBulletinPage.do" />">FAQ</a></li>
                            </ul>
                        </div>
                        <div class="sub menu5">
                            <strong id="gnbMenu5">소개</strong>
                            <ul>
                                <li><a href="<c:url value="/portal/intro/intro/selectIntroPage.do" />">사이트 소개</a></li>
				                <li><a href="<c:url value="/portal/intro/apply/selectApplyPage.do" />">내부협업데이터<br/>&nbsp;&nbsp;제공 신청</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
			</div>
			</div>
		</nav>
	</div>
	</c:when>
	<c:otherwise>
	<div class="gnbArea">
		<nav class="nav">
			<div class="navMenu">
            <div class="gnbNew">
                <strong>『국회가 먼저 공개합니다』</strong>
                <ul class="gnbMenu">
                    <li class="menu1"><a>공공데이터</a></li>
                    <li class="menu1"><a>통계데이터</a></li>
                    <li class="menu2"><a>활용</a></li>
                    <li class="menu3"><a>참여소통</a></li>
                    <li class="menu4"><a>소개</a></li>
                </ul>
            </div>
			<div class="gnbSub">
            	<div class="gnbSubWid">
                    <div class="gnbSubNew gnbBg01">
                        <strong>공공데이터</strong>
                        <span>국회에서 제공하는<br>공공데이터를 열람하실 수 있습니다.</span>
                    </div>
                    <div class="inner">
                        <div class="sub menu1 ">
                            <strong id="gnbMenu1">공공데이터</strong>
                            <ul>
                                <li><a href="<c:url value="/portal/data/dataset/searchDatasetPage.do" />">데이터셋</a></li>
		                		<li><a href="<c:url value="/portal/adjust/map/mapSearchPage.do" />">위치기반 데이터 찾기</a></li>
                                <li><a href="<c:url value="/portal/expose/writeAccountPage.do" />">청구서 작성</a></li>
                                <li><a href="<c:url value="/portal/expose/searchAccountPage.do" />">청구서 처리현황</a></li>
                                <li><a href="<c:url value="/portal/expose/targetObjectionPage.do" />">이의신청서 작성</a></li>
                                <li><a href="<c:url value="/portal/expose/searchObjectionPage.do" />">이의신청서 처리현황</a></li>
                            </ul>
                        </div>
                        <div class="sub menu2">
                            <strong id="gnbMenu2">통계데이터</strong>
                            <ul>
								<li><a href="<c:url value="/portal/stat/easyStatPage.do" />">간편통계</a></li>
								<li><a href="<c:url value="/portal/stat/multiStatSch.do" />">복수통계</a></li>
                            </ul>  
                        </div>  
                        <div class="sub menu3">
                            <strong id="gnbMenu3">활용</strong>
                            <ul>
                                <li><a href="<c:url value="/portal/bbs/gallery/searchBulletinPage.do" />">활용갤러리</a></li>
								<li><a href="<c:url value="/portal/intro/intro/selectSitePage.do" />">관련사이트</a></li>
                            </ul>
                        </div>
                        <div class="sub menu4">
                            <strong id="gnbMenu4">참여소통</strong>
                            <ul>
                                <li><a href="<c:url value="/portal/bbs/notice/searchBulletinPage.do" />">공지사항</a></li>
								<li><a href="<c:url value="/portal/bbs/qna01/searchBulletinPage.do" />">Q&A</a></li>
								<li><a href="<c:url value="/portal/bbs/faq01/searchBulletinPage.do" />">FAQ</a></li>
								<li><a href="<c:url value="/portal/bbs/idea/searchBulletinPage.do" />">아이디어 제안</a></li>
                            </ul>
                        </div>
                        <div class="sub menu5">
                            <strong id="gnbMenu5">소개</strong>
                            <ul>
                                <li><a href="<c:url value="/portal/intro/intro/selectIntroPage.do" />">사이트 소개</a></li>
				                <li><a href="<c:url value="/portal/bbs/develop/searchBulletinPage.do" />">Open API 소개</a></li>
				                <li><a href="<c:url value="/portal/bbs/stats/selectStatsPage.do" />">개방 통계</a></li>
				                <li><a href="<c:url value="/portal/intro/apply/selectApplyPage.do" />">공공데이터 제공신청</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
			</div>
			</div>
		</nav>
	</div>		
	</c:otherwise>
</c:choose>
	
	

<!-- // header -->
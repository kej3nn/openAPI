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
<%@ include file="/WEB-INF/jsp/ggportal/sect/head.jsp" %>
<script type="text/javascript" src="<c:url value="/js/soportal/expose/common.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/soportal/expose/address.js" />"></script>
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
@media only all and (max-width: 400px) {
	.pop_tab li a{width:100px;}
}
</style>
<script type="text/javascript">
$(function(){
	$('#btn_searh').click(function(){
		searchJibunAddress(1);
		return false;
	});
	
	$('#btn_close').click(function(){
		window.close();
	});

	$('a[id=roadSearchAddrPage]').bind("click", function(event) {
		location.href = com.wise.help.url("/portal/expose/roadSearchAddrPage.do");
	});
	
});
</script> 
</head> 
	<body>
    	<!-- pop_wrapper -->
		<div id="pop_wrapper">
			<h2>우편번호 찾기</h2>
        	<a class="close" href="#" id="btn_close"><img src="/images/btn_close_layerPopup_A.png" alt="닫기" /></a>
            
            <!-- pop_content -->
            <div class="pop_content"> 
            	<form id="doro_form" runat="server">
            	<input type="hidden" name="searchType" id="searchType"  value="GIBUN">
				<input type="hidden" name="currentPage" id="currentPage" />
                <fieldset>
                <legend>우편번호찾기 도로명주소</legend>
                <!-- pop_tab -->
                <ul class="pop_tab">
                	<li><a href="#none" id="roadSearchAddrPage">도로명주소</a></li>
                    <li class="on"><a href="#none">지번주소</a></li>
                </ul>
                <!-- //pop_tab -->
                <div class="post_search">
                    <dl>
                        <dt><label for="city">시도</label></dt>
                        <dd>
                            <select name="city" id="city" title="시도를 선택하세요.">
                              <option value="">선택</option>
									<option value="11" title="서울특별시" >서울특별시</option>
									<option value="42" title="강원도" >강원도</option>
									<option value="41" title="경기도">경기도</option>
									<option value="48" title="경상남도" >경상남도</option>
									<option value="47" title="경상북도" >경상북도</option>
									<option value="46" title="전라남도" >전라남도</option>
									<option value="45" title="전라북도" >전라북도</option>
									<option value="44" title="충청남도" >충청남도</option>
									<option value="43" title="충청북도" >충청북도</option>
									<option value="29" title="광주광역시" >광주광역시</option>
									<option value="27" title="대구광역시" >대구광역시</option>
									<option value="30" title="대전광역시" >대전광역시</option>
									<option value="26" title="부산광역시" >부산광역시</option>
									<option value="31" title="울산광역시" >울산광역시</option>
									<option value="28" title="인천광역시" >인천광역시</option>
									<option value="36" title="세종특별자치시" >세종특별자치시</option>
									<option value="50" title="제주특별자치도" >제주특별자치도</option>
                            </select>
                        </dd>
                        <dt><label for="county">시군구</label></dt>
                        <dd>
                            <select name="county" id="county"  title="시군구를 선택하세요.">
                              <option value="">선택</option>
                            </select>
                        </dd>
                  </dl>
                	<p style="margin-top:0;">거주하시는 지역의 이름을 입력해 주세요. 예) 삼성동, 오산리</p>
                    <dl>
                        <dt class="aw"><label for="engineEmdNm">지역명(동.읍.면.리)</label></dt>
                        <dd class="aw">
                            <input name="engineEmdNm" id="engineEmdNm" type="text" style="width:162px;" value="" title="지역명 입력" />
                        </dd>
                  	</dl>
					<dl class="tal">
                        <dt class="aw"><label for="engineBdMaSn">번지</label></dt>
                        <dd class="aw">
                            <input name="engineBdMaSn" id="engineBdMaSn" type="text" style="width:70px;" value="" title="번지수 앞자리" /> - 
							<input name="engineBdSbSn" id="engineBdSbSn" type="text" style="width:70px;" value="" title="번지수 뒷자리"  />
                        </dd>
                  	</dl>
                    <a href="#" id="btn_searh" class="btn_A">검색</a>
                </div>
                </fieldset>
                </form>
                <div class="post_list h2" id="result_data_list" style="display: none;">
                </div>
                <div class="post_page">
					<div id="result_data_page" style="display:none;">
	                </div>
                </div>
            </div>
            <!-- //pop_content -->
        </div>
        <!-- //pop_wrapper -->
	</body>
</html>
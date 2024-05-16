<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 국회의원 개인신상정보
<%--              
<%-- @author JHKIM
<%-- @version 1.0 2019/10/21
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<div class="assemblyman_content_head">
	<h3>국회의원 ${meta.hgNm }</h3>
	<span>${meta.polyNm }</span>
	<a href="javascript:;" class="toggle_assemInfo">
		<strong>기본정보 닫기</strong>
		<img src="/img/ggportal/desktop/common/toggle_open_metaInfo.png" alt="닫기">
	</a>
</div>

<div class="assemblyman_menu_mobile">
	<!-- <h4>인적사항 <span class="arrow"></span></h4> -->
	<c:choose>
		<c:when test="${leftMemberInfo eq 'Y' }"><h4>인적사항 <span class="arrow"></span></h4></c:when>
		<c:when test="${leftCombLawm eq 'Y' }"><h4>의정활동 <span class="arrow"></span></h4></c:when>
		<c:when test="${leftCombPdta eq 'Y' }"><h4>정책자료&보고서 <span class="arrow"></span></h4></c:when>
		<c:when test="${leftCombSchd eq 'Y' }"><h4>의원 일정 <span class="arrow"></span></h4></c:when>
		<c:when test="${leftCombNoti eq 'Y' }"><h4>의원실 알림 <span class="arrow"></span></h4></c:when>
		<c:otherwise></c:otherwise>
	</c:choose>

	<div class="lnbs">
		<ul>
			<li><a href="/portal/assm/memberInfoPage.do?monaCd=${monaCd }">인적사항</a></li>
			<li><a href="/portal/assm/comb/combLawmPage.do?monaCd=${monaCd }">의원활동</a></li>
			<li><a href="/portal/assm/comb/combPdtaPage.do?monaCd=${monaCd }">정책자료&보고서</a></li>
			<li><a href="/portal/assm/comb/combSchdPage.do?monaCd=${monaCd }">의원 일정</a></li>
			<li><a href="/portal/assm/comb/combNotiPage.do?monaCd=${monaCd }">의원실 알림</a></li>
		</ul>
	</div>
</div>

<div class="assemblyman_content_middle">
	<div class="assc_person">
		<div class="assemblyman_pic">
			<img src="${meta.deptImgUrl }" alt="${meta.hgNm } 국회의원 사진">
		</div>
		<div class="assemblyman_name">
			<c:choose>
			<c:when test="${meta.hgNm eq '심상정'}"><strong>${meta.hgNm }(沈相奵)</strong></c:when>
			<c:when test="${meta.hgNm eq '고용진'}"><strong>${meta.hgNm }(高榕禛)</strong></c:when>
			<c:when test="${meta.hgNm eq '민병두'}"><strong>${meta.hgNm }(閔丙䄈)</strong></c:when>
			<c:otherwise><strong>${meta.hgNm }(${meta.hjNm })</strong></c:otherwise>
			</c:choose>
			<span>${meta.engNm }</span>
			<em>${meta.bthDate }</em>
			<%-- 역대국회의원 조회가 아닌경우 표시 --%>
			<c:if test="${isHistMemberSch != null && isHistMemberSch eq 'N' }">
			<ul class="sns_link">
				<c:if test="${ !empty meta.fUrl and meta.fUrl ne '' }">
					<li><a href="${meta.fUrl }" id="shareFB" class="sns_facebook" target="_blank" title="새창열림_페이스북">페이스북</a></li>
				</c:if>
				<c:if test="${ !empty meta.tUrl and meta.tUrl ne '' }">
					<li><a href="${meta.tUrl }" id="shareTW" class="sns_twitter" target="_blank" title="새창열림_트위터">트위터</a></li>
				</c:if>
				<c:if test="${ !empty meta.bUrl and meta.bUrl ne '' }">
					<li><a href="${meta.bUrl }" id="shareTW" class="sns_blog" target="_blank" title="새창열림_블로그">블로그</a></li>
				</c:if>
				<c:if test="${ !empty meta.iUrl and meta.iUrl ne '' }">
					<li><a href="${meta.iUrl }" id="shareTW" class="sns_insta" target="_blank" title="새창열림_인스타그램">인스타그램</a></li>
				</c:if>
				<c:if test="${ !empty meta.yUrl and meta.yUrl ne '' }">
					<li><a href="${meta.yUrl }" id="shareTW" class="sns_youtube" target="_blank" title="새창열림_유튜브">유튜브</a></li>
				</c:if>
			</ul>
			</c:if>
		</div>
	</div>
	<div class="assc_desc">
		<ul>
			<li>
				<strong>정당</strong>
				<span>${meta.polyNm }</span>
			</li>
			<li>
				<strong>선거구</strong>
				<span>${meta.origNm }</span>
			</li>
			<%-- 역대국회의원 조회가 아닌경우 표시 --%>
			<c:if test="${isHistMemberSch != null && isHistMemberSch eq 'N' }">
			<li>
				<strong id="metaCmitsText">소속위원회</strong>
				<span>${meta.cmits }</span>
			</li>
			</c:if>
			<li>
				<strong>당선횟수</strong>
				<span>${meta.reeleGbnNm }(${meta.units })</span>
			</li>
			<%-- 역대국회의원 조회가 아닌경우 표시 --%>
			<c:if test="${isHistMemberSch != null && isHistMemberSch eq 'N' }">
			<li>
				<strong>사무실 전화</strong>
				<span>${meta.telNo }</span>
			</li>
			<li>
				<strong>사무실 호실</strong>
				<span>${meta.assemAddr }</span>
			</li>
			<li>
				<strong>홈페이지</strong>
				<span>
					<c:if test="${ !empty meta.homepage and meta.homepage ne '' }">
						<a href="${meta.homepage }" target="_blank" title="새창열림_홈페이지">${meta.homepage }</a>
					</c:if>	
				</span>
			</li>
			<li>
				<strong>이메일</strong>
				<span>${meta.eMail }</span>
			</li>
			<li>
				<strong>보좌관</strong>
				<span>${meta.staff }</span>
			</li>
			<li>
				<strong>선임비서관</strong>
				<span>${meta.secretary }</span>
			</li>
			<li>
				<strong>비서관</strong>
				<span>${meta.secretary2 }</span>
			</li>
			</c:if>
		</ul>
	</div>
</div>
<script type="text/javascript">
//기본정보 토글
$(".toggle_assemInfo").bind("click", function() {
	var open = $(".toggle_assemInfo strong").text() == "기본정보 열기" ? true : false;
	$(this).find("strong").text(open ? "기본정보 닫기" : "기본정보 열기");
	$(this).find("img").attr("src", ( open ? com.wise.help.url("/img/ggportal/desktop/common/toggle_open_metaInfo.png") : com.wise.help.url("/img/ggportal/desktop/common/toggle_colse_metaInfo.png") ));
	$(this).find("img").attr("alt", ( open ? "닫기" : "열기"));
	$(".assemblyman_content_middle").slideToggle();
	$(".assemblyman_content").toggleClass("toggle_margin");
})
</script>
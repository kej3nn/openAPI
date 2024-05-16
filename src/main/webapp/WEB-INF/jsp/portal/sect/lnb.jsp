<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)lnb.jsp 1.0 2018/02/01                                             --%>
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
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="egovframework.common.base.model.Record" %>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="egovframework.com.cmm.EgovWebUtil"%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 좌측 메뉴 섹션 화면이다.                                               		--%>
<%--                                                                        --%>
<%-- @author SoftOn                                                  		--%>
<%-- @version 1.0 2018/02/01                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%
	try {
		// 현재 페이지 URL
		String currentUri = StringUtils.defaultIfEmpty(String.valueOf(request.getAttribute("uri")), "");
		
		// XML 메뉴리스트
		List<Record> list = (List<Record>) request.getAttribute("menuLst");
		
		Record lnbTop = new Record();
		Record current = new Record();
		
		String id = "";
		
		// 메뉴에서 현재 페이지 URL을 찾는다.
		for ( Record record : list ) {
			if ( StringUtils.equals(currentUri, record.getString("url")) ) {
				current = record;
				id = record.getString("id");
				break;
			}
		}
		
		// TOP ID 기준으로 LEFT MENU 리스트 생성
		List<Record> lnbMenus = new ArrayList<Record>();
		for ( Record record : list ) {
			if ( StringUtils.equals(current.getString("topId"), record.getString("id")) ) {
				lnbTop = record;
			}
			
			if ( StringUtils.equals(current.getString("topId"), record.getString("topId")) && StringUtils.equals("Y", record.getString("viewYn", "Y")) ) {
				lnbMenus.add(record);
			} 
			else if ( StringUtils.equals("N", record.getString("viewYn", "Y")) && StringUtils.equals(current.getString("id"), record.getString("id")) ) {
				// 화면에는 보여주지 않지만 메뉴가 선택되게 할 경우(EX. 공지사항상세는 공지사항목록에 포함)
				id = record.getString("viewId");
			}
		}
		
		request.setAttribute("currentMenuId", 	id);
		request.setAttribute("lnbTop", 			lnbTop);
		request.setAttribute("lnbMenus", 		lnbMenus);
		
	} catch (IndexOutOfBoundsException  e) {
		EgovWebUtil.exLogging(e);
	} catch (Exception e) {
		EgovWebUtil.exLogging(e);
	}
%>
    <!-- lnb -->
	<nav>
	<div class="lnb">
		<h2><c:out value="${lnbTop.title}" /></h2> 
		<ul>
		<c:choose>
		
		<c:when test="${fn:indexOf(requestScope.uri, '/portal/myPage/') >= 0}">
			<c:forEach var="i" items="${requestScope.lnbMenus}" varStatus="iStat">
				<c:if test="${i.parId eq lnbTop.id }">
					<li>
						<c:choose>
						<c:when test="${i.id eq 'NO65000' or i.id eq 'NO66000' }">
							<span><a href="${i.url }" class="${i.id == currentMenuId ? 'on' : '' }" target="_blank" onclick="javascript: alert('국회통합회원으로 회원관련 정보는 \n국회 홈페이지에서 변경 해주시기 바랍니다.');">${i.title }</a></span>
						</c:when>
						<c:otherwise>
							<span><a href="${i.url }" class="${i.id == currentMenuId ? 'on' : '' }">${i.title }</a></span>
						</c:otherwise>
						</c:choose>
						
						<c:set var="jIdx" value="0"></c:set>
						<c:forEach var="j" items="${requestScope.lnbMenus}" varStatus="jStat">
						<c:choose>
							<c:when test="${i.id eq j.parId }">
								<c:set var="jIdx" value="${jIdx+1 }"></c:set>
								<c:if test="${jIdx == 1 }"><ul></c:if>
								<c:choose>
								<c:when test="${j.id eq 'NO65000' }">
									<li><span><a href="${j.url }" class="${j.id == currentMenuId ? 'on' : '' }" target="_blank">${j.title }</a></span></li>
								</c:when>
								<c:otherwise>
									<li><span><a href="${j.url }" class="${j.id == currentMenuId ? 'on' : '' }">${j.title }</a></span></li>
								</c:otherwise>
								</c:choose>
								<c:if test="${jStat.last }"></ul></c:if>	
							</c:when>
							<c:otherwise>
								<c:if test="${jIdx > 0 && jStat.last }"></ul></c:if>
							</c:otherwise>	
						</c:choose>
						</c:forEach>
					</li>
				</c:if>
			</c:forEach>
		</c:when>
		
		
		<c:otherwise>
			<c:forEach var="i" items="${requestScope.lnbMenus}" varStatus="iStat">
				<c:if test="${i.parId eq lnbTop.id }">
					<li>
						<span><a href="${i.url }" class="${i.id == currentMenuId ? 'on' : '' }">${i.title }</a></span>
						
						<c:set var="jIdx" value="0"></c:set>
						
						<c:forEach var="j" items="${requestScope.lnbMenus}" varStatus="jStat">
						<c:choose>
							<c:when test="${i.id eq j.parId }">
								<c:set var="jIdx" value="${jIdx+1 }"></c:set>
								<c:if test="${jIdx == 1 }"><ul></c:if>
								<li><span><a href="${j.url }" class="${j.id == currentMenuId ? 'on' : '' }">${j.title }</a></span></li>
								<c:if test="${jStat.last }"></ul></c:if>	
							</c:when>
							<c:otherwise>
								<c:if test="${jIdx > 0 && jStat.last }"></ul></c:if>
							</c:otherwise>	
						</c:choose>
						</c:forEach>
					</li>
				</c:if>
			</c:forEach>
		</c:otherwise>
		</c:choose>
		
		</ul>
	</div>
	</nav>
	<!-- //lnb -->
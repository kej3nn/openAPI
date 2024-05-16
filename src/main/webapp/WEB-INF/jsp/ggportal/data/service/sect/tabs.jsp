<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)tabs.jsp 1.0 2015/06/15                                            --%>
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
<%-- 탭 섹션 화면이다.                                                      --%>
<%--                                                                        --%>
<%-- @author 김은삼                                                         --%>
<%-- @version 1.0 2015/06/15                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
        <!-- tab_A -->
        <div class="tab_A">
            <c:if test="${!empty data.scolInfSeq}">
            <c:choose>
            <c:when test="${data.srvCd == 'S'}">
            <a href="#<c:out value="${data.scolInfSeq}" />" class="service-select-tab on">표</a>
            </c:when>
            <c:otherwise>
            <a href="#<c:out value="${data.scolInfSeq}" />" class="service-select-tab">표</a>
            </c:otherwise>
            </c:choose>
            </c:if>
            <c:if test="${!empty data.ccolInfSeq}">
            <c:choose>
            <c:when test="${data.srvCd == 'C'}">
            <a href="#<c:out value="${data.ccolInfSeq}" />" class="service-select-tab on">차트</a>
            </c:when>
            <c:otherwise>
            <a href="#<c:out value="${data.ccolInfSeq}" />" class="service-select-tab">차트</a>
            </c:otherwise>
            </c:choose>
            </c:if>
            <c:if test="${!empty data.mcolInfSeq}">
            <c:choose>
            <c:when test="${data.srvCd == 'M'}">
            <a href="#<c:out value="${data.mcolInfSeq}" />" class="service-select-tab on">지도</a>
            </c:when>
            <c:otherwise>
            <a href="#<c:out value="${data.mcolInfSeq}" />" class="service-select-tab">지도</a>
            </c:otherwise>
            </c:choose>
            </c:if>
            <c:if test="${!empty data.fileInfSeq}">
            <c:choose>
            <c:when test="${data.srvCd == 'F'}">
            <a href="#<c:out value="${data.fileInfSeq}" />" class="service-select-tab on">파일</a>
            </c:when>
            <c:otherwise>
            <a href="#<c:out value="${data.fileInfSeq}" />" class="service-select-tab">파일</a>
            </c:otherwise>
            </c:choose>
            </c:if>
            <c:if test="${!empty data.acolInfSeq}">
            <c:choose>
            <c:when test="${data.srvCd == 'A'}">
            <a href="#<c:out value="${data.acolInfSeq}" />" class="service-select-tab on">API</a>
            </c:when>
            <c:otherwise>
            <a href="#<c:out value="${data.acolInfSeq}" />" class="service-select-tab">API</a>
            </c:otherwise>
            </c:choose>
            </c:if>
            <c:if test="${!empty data.linkInfSeq}">
            <c:choose>
            <c:when test="${data.srvCd == 'L'}">
            <a href="#<c:out value="${data.linkInfSeq}" />" class="service-select-tab on">링크</a>
            </c:when>
            <c:otherwise>
            <a href="#<c:out value="${data.linkInfSeq}" />" class="service-select-tab">링크</a>
            </c:otherwise>
            </c:choose>
            </c:if>
            <c:if test="${!empty data.vislInfSeq}">
            <c:choose>
            <c:when test="${data.srvCd == 'V'}">
            <a href="#<c:out value="${data.vislInfSeq}" />" class="service-select-tab on">시각화</a>
            </c:when>
            <c:otherwise>
            <a href="#<c:out value="${data.vislInfSeq}" />" class="service-select-tab">시각화</a>
            </c:otherwise>
            </c:choose>
            </c:if>
        </div>
        <script type="text/javascript">
            $(function() {
                $(".service-select-tab").each(function(index, element) {
                    if (!$(this).hasClass("on")) {
                        // 공공데이터 서비스 탭에 클릭 이벤트를 바인딩한다.
                        $(this).bind("click", {
                            infSeq:$(this).attr("href").substring(1)
                        },function(event) {
                            // 공공데이터 서비스를 조회한다.
                            selectService(event.data);
                            return false;
                        });
                        
                        // 공공데이터 서비스 탭에 키다운 이벤트를 바인딩한다.
                        $(this).bind("keydown", {
                            infSeq:$(this).attr("href").substring(1)
                        }, function(event) {
                            if (event.which == 13) {
                                // 공공데이터 서비스를 조회한다.
                                selectService(event.data);
                                return false;
                            }
                        });
                    }
                });
            });
            
            /**
             * 공공데이터 서비스를 조회한다.
             * 
             * @param data {Object} 데이터
             */
            function selectService(data) {
                if (com.wise.util.isBlank(data.infId)) {
                    data.infId = $("#dataset-search-form [name=infId]").val() || $("#searchForm [name=infId]").val();
                }
                
                // 데이터를 조회하는 화면으로 이동한다.
                /* 
                goSelect({
                    url:"/portal/data/service/selectServicePage.do",
                    form:"dataset-search-form",
                    data:[{
                        name:"infId",
                        value:data.infId
                    }, {
                        name:"infSeq",
                        value:data.infSeq
                    }]
                }); */
                
                goSearch({
            		url:"/portal/data/service/selectServicePage.do",
            		form:"searchForm",
            		method: "post",
            		data:[{
                        name:"infId",
                        value:data.infId
                    }, {
                        name:"infSeq",
                        value:data.infSeq
                    }]
            	});
            }
        </script>
        <!-- // tab_A -->
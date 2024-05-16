<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)meta.jsp 1.0 2015/06/15                                            --%>
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
<script type="text/javascript" src="<c:url value="/js/common/bootstrap/dist/bootstrap.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/ggportal/kakao.min.js" />"></script>
<style>
    .btn-primary {
        background-color: #1961B6; /* 기본 배경 색상 */
        color: white; /* 텍스트 색상 */
    }
    
    .btn-outline-primary:hover {
    	background-color: #2788D5;
    	color: white;
    }
</style>


<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 메타 섹션 화면이다.                                                    --%>
<%--                                                                        --%>
<%-- @author 김은삼                                                         --%>
<%-- @version 1.0 2015/06/15                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
        <!-- 상세 요약 -->
        <div class="detail_summary">
            <figure class="thumbnail">
                <c:choose>
                <c:when test="${!empty data.metaImagFileNm || !empty data.cateSaveFileNm}">
                <%--
                <img src="<c:url value="/portal/data/dataset/selectThumbnail.do" />?infId=<c:out value="${data.infId}" />"  alt="" />
                --%>
                <img src="<c:url value="/portal/data/dataset/selectThumbnail.do" />?seq=<c:out value="${data.infId}" />&metaImagFileNm=<c:out value="${data.metaImagFileNm}" />&cateSaveFileNm=<c:out value="${data.cateSaveFileNm}" />"  alt="" />
                </c:when>
                <c:otherwise>
                <img src="<c:url value="/img/ggportal/desktop/thumbnail/@thumbnail_100.jpg" />"  alt="" />
                </c:otherwise>
                </c:choose>
                <figcaption>${data.topCateNm }</figcaption>
            </figure>
            <div class="summary">
                <strong class="tit" style="font-weight: normal;"><c:out value="${data.infNm}" /></strong>
	            <span class="opentyTagNm ot01">데이터</span>
			<div style="display:flex; justify-content:space-between;">
			    <div>${data.infExp }</div>
			    <div>
				<c:choose>
				    <c:when test="${apiMenu eq 'openAPIDetail'}">
				        <c:forEach var="oInfId" items="${oInfIds}" varStatus="g">
				            <c:choose>
				                <c:when test="${oInfId eq data.infId}">
				                    <button class="btn btn-primary active" style="font-size:13px; height:21px; padding: 0 10px 0 10px; border-radius: 0 !important;">
				                        버전 ${g.count} (${oOpenDttms[g.count-1]})
				                    </button>
				                </c:when>
				                <c:otherwise>
				                    <a href="/portal/data/service/selectAPIServicePage.do/${oInfId}?${pageContext.request.queryString}" style="text-decoration:none;">
				                        <button class="btn btn-outline-primary" style="font-size:13px; height:21px; padding: 0 10px 0 10px; border-radius: 0 !important;">
				                            버전 ${g.count} (${oOpenDttms[g.count-1]})
				                        </button>
				                    </a>
				                </c:otherwise>
				            </c:choose>
				        </c:forEach>
				    </c:when>
				    <c:otherwise>
				        <c:forEach var="oInfId" items="${oInfIds}" varStatus="g">
				            <c:choose>
				                <c:when test="${oInfId eq data.infId}">
				                    <button class="btn btn-primary active" style="font-size:13px; height:21px; padding: 0 10px 0 10px; border-radius: 0 !important;">
				                        버전 ${g.count} (${oOpenDttms[g.count-1]})
				                    </button>
				                </c:when>
				                <c:otherwise>
				                    <a href="/portal/data/service/selectServicePage.do/${oInfId}?${pageContext.request.queryString}" style="text-decoration:none;">
				                        <button class="btn btn-outline-primary" style="font-size:13px; height:21px; padding: 0 10px 0 10px; border-radius: 0 !important;">
				                            버전 ${g.count} (${oOpenDttms[g.count-1]})
				                        </button>
				                    </a>
				                </c:otherwise>
				            </c:choose>
				        </c:forEach>
				    </c:otherwise>
				</c:choose>
			    </div>
			</div>
            <div class="sortArea">
                <c:choose>
                <c:when test="${data.topCateId == 'GG01'}">
                <span class="sort sort_1"><span><c:out value="${data.topCateNm}" /></span></span>
                </c:when>
                <c:when test="${data.topCateId == 'GG05'}">
                <span class="sort sort_2"><span><c:out value="${data.topCateNm}" /></span></span>
                </c:when>
                <c:when test="${data.topCateId == 'GG09'}">
                <span class="sort sort_3"><span><c:out value="${data.topCateNm}" /></span></span>
                </c:when>
                <c:when test="${data.topCateId == 'GG13'}">
                <span class="sort sort_4"><span><c:out value="${data.topCateNm}" /></span></span>
                </c:when>
                <c:when test="${data.topCateId == 'GG16'}">
                <span class="sort sort_5"><span><c:out value="${data.topCateNm}" /></span></span>
                </c:when>
                <c:when test="${data.topCateId == 'GG20'}">
                <span class="sort sort_6"><span><c:out value="${data.topCateNm}" /></span></span>
                </c:when>
                <c:when test="${data.topCateId == 'GG23'}">
                <span class="sort sort_7"><span><c:out value="${data.topCateNm}" /></span></span>
                </c:when>
                <c:when test="${data.topCateId == 'GG26'}">
                <span class="sort sort_8"><span><c:out value="${data.topCateNm}" /></span></span>
                </c:when>
                <c:when test="${data.topCateId == 'GG29'}">
                <span class="sort sort_9"><span><c:out value="${data.topCateNm}" /></span></span>
                </c:when>
                </c:choose>
                <c:choose>
                <c:when test="${data.topCateId2 == 'GG01'}">
                <span class="sort sort_1"><span><c:out value="${data.topCateNm2}" /></span></span>
                </c:when>
                <c:when test="${data.topCateId2 == 'GG05'}">
                <span class="sort sort_2"><span><c:out value="${data.topCateNm2}" /></span></span>
                </c:when>
                <c:when test="${data.topCateId2 == 'GG09'}">
                <span class="sort sort_3"><span><c:out value="${data.topCateNm2}" /></span></span>
                </c:when>
                <c:when test="${data.topCateId2 == 'GG13'}">
                <span class="sort sort_4"><span><c:out value="${data.topCateNm2}" /></span></span>
                </c:when>
                <c:when test="${data.topCateId2 == 'GG16'}">
                <span class="sort sort_5"><span><c:out value="${data.topCateNm2}" /></span></span>
                </c:when>
                <c:when test="${data.topCateId2 == 'GG20'}">
                <span class="sort sort_6"><span><c:out value="${data.topCateNm2}" /></span></span>
                </c:when>
                <c:when test="${data.topCateId2 == 'GG23'}">
                <span class="sort sort_7"><span><c:out value="${data.topCateNm2}" /></span></span>
                </c:when>
                <c:when test="${data.topCateId2 == 'GG26'}">
                <span class="sort sort_8"><span><c:out value="${data.topCateNm2}" /></span></span>
                </c:when>
                <c:when test="${data.topCateId2 == 'GG29'}">
                <span class="sort sort_9"><span><c:out value="${data.topCateNm2}" /></span></span>
                </c:when>
                </c:choose>
             </div>
                <div class="area_grade clfix">
                    <div class="flL">   
                        <strong class="tit_totalGrade">총평점</strong>
                        <c:choose>
                        <c:when test="${data.apprVal == 0.0}">
                        <img src="/img/ggportal/desktop/common/grade_0.png" class="icon_grade service-grade-image" alt="총점 5점 중 평점 0점 아주 나쁨" />
                        </c:when>
                        <c:when test="${data.apprVal > 0.0 && data.apprVal <= 0.5}">
                        <img src="/img/ggportal/desktop/common/grade_1.png" class="icon_grade service-grade-image" alt="총점 5점 중 평점 0.5점 아주 나쁨" />
                        </c:when>
                        <c:when test="${data.apprVal > 0.5 && data.apprVal <= 1.0}">
                        <img src="/img/ggportal/desktop/common/grade_2.png" class="icon_grade service-grade-image" alt="총점 5점 중 평점 1점 아주 나쁨" />
                        </c:when>
                        <c:when test="${data.apprVal > 1.0 && data.apprVal <= 1.5}">
                        <img src="/img/ggportal/desktop/common/grade_3.png" class="icon_grade service-grade-image" alt="총점 5점 중 평점 1.5점 아주 나쁨" />
                        </c:when>
                        <c:when test="${data.apprVal > 1.5 && data.apprVal <= 2.0}">
                        <img src="/img/ggportal/desktop/common/grade_4.png" class="icon_grade service-grade-image" alt="총점 5점 중 평점 2점 나쁨" />
                        </c:when>
                        <c:when test="${data.apprVal > 2.0 && data.apprVal <= 2.5}">
                        <img src="/img/ggportal/desktop/common/grade_5.png" class="icon_grade service-grade-image" alt="총점 5점 중 평점 2.5점 나쁨" />
                        </c:when>
                        <c:when test="${data.apprVal > 2.5 && data.apprVal <= 3.0}">
                        <img src="/img/ggportal/desktop/common/grade_6.png" class="icon_grade service-grade-image" alt="총점 5점 중 평점 3점 보통" />
                        </c:when>
                        <c:when test="${data.apprVal > 3.0 && data.apprVal <= 3.5}">
                        <img src="/img/ggportal/desktop/common/grade_7.png" class="icon_grade service-grade-image" alt="총점 5점 중 평점 3.5점 보통" />
                        </c:when>
                        <c:when test="${data.apprVal > 3.5 && data.apprVal <= 4.0}">
                        <img src="/img/ggportal/desktop/common/grade_8.png" class="icon_grade service-grade-image" alt="총점 5점 중 평점 4점 좋음" />
                        </c:when>
                        <c:when test="${data.apprVal > 4.0 && data.apprVal <= 4.5}">
                        <img src="/img/ggportal/desktop/common/grade_9.png" class="icon_grade service-grade-image" alt="총점 5점 중 평점 4.5점 좋음" />
                        </c:when>
                        <c:when test="${data.apprVal > 4.5}">
                        <img src="/img/ggportal/desktop/common/grade_10.png" class="icon_grade service-grade-image" alt="총점 5점 중 평점 5점 아주 좋음" />
                        </c:when>
                        <c:otherwise>
                        <img src="<c:url value="/img/ggportal/desktop/common/grade_0.png" />" class="icon_grade service-grade-image" alt="총점 5점 중 평점 0점 아주 나쁨" />
                        </c:otherwise>
                        </c:choose>
                        <div class="make_grade">
                            <a href="#none" class="toggle_grade service-grade-combo">
                                <img src="<c:url value="/img/ggportal/desktop/common/grade_s_1.png" />" alt="총점 5점 중 평점 1점 아주 나쁨" />
                                <img src="<c:url value="/img/ggportal/desktop/common/toggle_open_grade.png" />" id="toggle_grade" alt="" />
                            </a>
                            <ul id="view_grade" class="view_grade" style="display:none;">
                            <li><a href="#" class="service-grade-option"><img src="<c:url value="/img/ggportal/desktop/common/grade_s_1.png" />" alt="총점 5점 중 평점 1점 아주 나쁨" /></a></li>
                            <li><a href="#" class="service-grade-option"><img src="<c:url value="/img/ggportal/desktop/common/grade_s_2.png" />" alt="총점 5점 중 평점 2점 나쁨" /></a></li>
                            <li><a href="#" class="service-grade-option"><img src="<c:url value="/img/ggportal/desktop/common/grade_s_3.png" />" alt="총점 5점 중 평점 3점 보통" /></a></li>
                            <li><a href="#" class="service-grade-option"><img src="<c:url value="/img/ggportal/desktop/common/grade_s_4.png" />" alt="총점 5점 중 평점 4점 좋음" /></a></li>
                            <li><a href="#" class="service-grade-option"><img src="<c:url value="/img/ggportal/desktop/common/grade_s_5.png" />" alt="총점 5점 중 평점 5점 아주 좋음" /></a></li>
                            </ul>
                        </div>
                        <a href="#" class="btn_make_grade service-grade-button">OK</a>
                    </div>
                    <a href="#none" class="toggle_metaInfo">
                        <strong>메타 정보 열기</strong><img src="<c:url value="/img/ggportal/desktop/common/toggle_open_metaInfo.png" />" alt="" />
                    </a>
                    <div class="btn_sns">
	                    <a id="shareFB" href="#" title="새창열림_페이스북" class="btn_facebook">페이스북 공유</a>
	                    <a id="shareTW" href="#" title="새창열림_트위터" class="btn_twitter">트위터 공유</a>
						<a id="shareBG" href="#" title="새창열림_네이버블로그" class="sns_blog">네이버블로그</a>
						<a id="shareKS" href="#" title="새창열림_카카오스토리" class="sns_kakaostory">카카오스토리</a>
						<a id="shareKT" href="#" title="새창열림_카카오톡" class="sns_kakaotalk">카카오톡</a>
                    </div>
                </div>
            </div>
        </div>
        <!-- // 상세 요약 -->
        <!-- 메타 정보 -->
        <section id="metaInfo" class="metaInfo">
        <h4 class="hide">메타 정보</h4>
        <table class="table_datail_A width_A">
        <caption>메타 정보 상세</caption>
        <tbody>
        <tr>
            <th scope="row">분류 체계</th>
            <td>${data.cateFullnm}</td>
            <th scope="row">공개일자</th>
            <td>${data.openDttm}</td>
        </tr>
        <tr>
            <th scope="row">제공기관</th>
            <td>${data.orgNm}</td>
            <th scope="row">최종 수정일자</th>
            <td>${data.loadDttm}</td>
        </tr>
        <tr>
            <th scope="row">원본시스템</th>
            <td>
            	<c:if test="${data.srcYn eq 'Y' and data.srcUrl ne null}">
			        <a href="${data.srcUrl}" target="_blank">${data.srcExp }</a>
			    </c:if>
			    <c:if test="${data.srcYn eq 'Y' and data.srcUrl eq null}">
			        ${data.srcExp }
			    </c:if>
            </td> 
            <th scope="row" rowspan="3">이용허락조건</th>
			<td rowspan="3"><img src="/images/${data.cclFileNm }" alt="공공누리 - 공공저작물 자유이용허락 : 출처표시"></td>
        </tr>
		<tr>
			<th scope="row">공개주기</th>
			<td>${data.loadNm }</td>	
		</tr>
		<tr>
			<th scope="row">공개시기</th>
			<td>${data.dataDttmCont }</td>			
		</tr>
		<tr>
		    <th scope="row">검색태그</th>
		    <td colspan="3">${data.infTag }</td>
		</tr>
		<tr>
		    <th scope="row">설명</th>
		    <td colspan="3">${data.infExp }</td>
		</tr>
        </tbody>
        </table>
        </section>
        <!-- // 메타 정보 -->
        <script type="text/javascript">
            $(function() {
            	// 페이지당 한번 호출 위해 넣어줌
            	<%--Kakao.init("<spring:message code='Oauth2.Provider.Kakao.ClientId'/>");--%>
            	
            	
                $(".service-grade-option").each(function(index, element) {             	
                	
                	
                    var image = $(this).find("img");
                    
                    // 공공데이터 서비스 평가점수 옵션에 클릭 이벤트를 바인딩한다.
                    $(this).bind("click", {
                        src:image.attr("src"),
                        alt:image.attr("alt")
                    }, function(event) {
                        // 공공데이터 서비스 평가점수를 변경한다.
                        changeAppraisal(event.data);
                        return false;
                    });
                    
                    // 공공데이터 서비스 평가점수 옵션에 키다운 이벤트를 바인딩한다.
                    $(this).bind("keydown", {
                        src:image.attr("src"),
                        alt:image.attr("alt")
                    }, function(event) {
                        if (event.which == 13) {
                            // 공공데이터 서비스 평가점수를 변경한다.
                            changeAppraisal(event.data);
                            return false;
                        }
                    });
                });
                
                // 공공데이터 서비스 평가점수 등록 버튼에 클릭 이벤트를 바인딩한다.
                $(".service-grade-button").bind("click", function(event) {
                    // 공공데이터 서비스 평가점수를 등록한다.
                    insertAppraisal();
                    return false;
                });
                
                // 공공데이터 서비스 평가점수 등록 버튼에 키다운 이벤트를 바인딩한다.
                $(".service-grade-button").bind("keydown", function(event) {
                    if (event.which == 13) {
                        // 공공데이터 서비스 평가점수를 등록한다.
                        insertAppraisal();
                        return false;
                    }
                });
                
                //페이스북 공유
                $("#shareFB").bind("click", function(event) {
                	var fullUrl = location.href;
            		var url = fullUrl;
                	shareFace(url);
                });
                
                //트위터 공유
				$("#shareTW").bind("click", function(event) {
					var fullUrl = location.href;
            		var url = fullUrl;
					shareTwitter(url, $(".detail_summary .tit").text());
                });
                
                //네이버 블로그 공유
				$("#shareBG").bind("click", function(event) {
					var fullUrl = location.href;
            		var url = fullUrl;
					shareNaver(url, $(".detail_summary .tit").text());
                });
				// 카카오스토리 공유
				$("#shareKS").bind("click", function(event) {
					var fullUrl = location.href;
            		var url = fullUrl;
					shareStory(url, $(".detail_summary .tit").text());
				}); 
				 //카카오톡 공유
				$("#shareKT").bind("click", function(event) {
					var fullUrl = location.href;
            		var url = fullUrl;
					shareKT(url, $(".detail_summary .tit").text());
                }); 
				
            });
          
            /**
             * 공공데이터 서비스 평가점수를 변경한다.
             * 
             * @param data {Object} 데이터
             */
            function changeAppraisal(data) {
                var image = $(".service-grade-combo img:eq(0)");
                
                image.attr("src", data.src);
                image.attr("alt", data.alt);
                
                $(".service-grade-combo").click();
            }
            
            /**
             * 공공데이터 서비스 평가점수를 등록한다.
             */
            function insertAppraisal() {
                // 데이터를 처리한다.
                doPost({
                    url:"/portal/data/service/insertAppraisal.do",
                    before:beforeInsertAppraisal,
                    after:afterInsertAppraisal
                });
            }
            
            /**
             * 공공데이터 서비스 평가점수 등록 전처리를 실행한다.
             * 
             * @param options {Object} 옵션
             */
            function beforeInsertAppraisal(options) {
            	 
                var data = {
                    infId:$("#dataset-search-form [name=infId]").val(),
                    apprVal:$(".service-grade-combo img:eq(0)").attr("alt").match(/\d/)[0]
                };
                
                if (com.wise.util.isBlank(data.infId)) {
                    return null;
                }
                
                return data;
            }
            
            /**
             * 공공데이터 서비스 평가점수 등록 후처리를 실행한다.
             * 
             * @param data {Object} 데이터
             */
            function afterInsertAppraisal(data) {
                alert("평가해 주셔서 감사합니다.");
                
                var image = $(".service-grade-image");
                
                if (data.apprVal == 0.0) {
                    image.attr("src", com.wise.help.url("/img/ggportal/desktop/common/grade_0.png")).attr("alt", "총점 5점 중 평점 0점 아주 나쁨");
                }
                else if (data.apprVal > 0.0 && data.apprVal <= 0.5) {
                    image.attr("src", com.wise.help.url("/img/ggportal/desktop/common/grade_1.png")).attr("alt", "총점 5점 중 평점 0.5점 아주 나쁨");
                }
                else if (data.apprVal > 0.5 && data.apprVal <= 1.0) {
                    image.attr("src", com.wise.help.url("/img/ggportal/desktop/common/grade_2.png")).attr("alt", "총점 5점 중 평점 1점 아주 나쁨");
                }
                else if (data.apprVal > 1.0 && data.apprVal <= 1.5) {
                    image.attr("src", com.wise.help.url("/img/ggportal/desktop/common/grade_3.png")).attr("alt", "총점 5점 중 평점 1.5점 아주 나쁨");
                }
                else if (data.apprVal > 1.5 && data.apprVal <= 2.0) {
                    image.attr("src", com.wise.help.url("/img/ggportal/desktop/common/grade_4.png")).attr("alt", "총점 5점 중 평점 2점 나쁨");
                }
                else if (data.apprVal > 2.0 && data.apprVal <= 2.5) {
                    image.attr("src", com.wise.help.url("/img/ggportal/desktop/common/grade_5.png")).attr("alt", "총점 5점 중 평점 2.5점 나쁨");
                }
                else if (data.apprVal > 2.5 && data.apprVal <= 3.0) {
                    image.attr("src", com.wise.help.url("/img/ggportal/desktop/common/grade_6.png")).attr("alt", "총점 5점 중 평점 3점 보통");
                }
                else if (data.apprVal > 3.0 && data.apprVal <= 3.5) {
                    image.attr("src", com.wise.help.url("/img/ggportal/desktop/common/grade_7.png")).attr("alt", "총점 5점 중 평점 3.5점 보통");
                }
                else if (data.apprVal > 3.5 && data.apprVal <= 4.0) {
                    image.attr("src", com.wise.help.url("/img/ggportal/desktop/common/grade_8.png")).attr("alt", "총점 5점 중 평점 4점 좋음");
                }
                else if (data.apprVal > 4.0 && data.apprVal <= 4.5) {
                    image.attr("src", com.wise.help.url("/img/ggportal/desktop/common/grade_9.png")).attr("alt", "총점 5점 중 평점 4.5점 좋음");
                }
                else if (data.apprVal > 4.5) {
                    image.attr("src", com.wise.help.url("/img/ggportal/desktop/common/grade_10.png")).attr("alt", "총점 5점 중 평점 5점 아주 좋음");
                }
            }
        </script>
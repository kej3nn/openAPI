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

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 메타 섹션 화면이다.                                                    --%>
<%--                                                                        --%>
<%-- @author 김은삼                                                         --%>
<%-- @version 1.0 2015/06/15                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
		<div class="area_btn_map">
			<span class="logo_region"><img src="<c:url value="/img/ggportal/desktop/thumbnail/logo_region/logo_region_img_${param.sigunFlag}.png"/>" alt="logo"/></span>
			<span class="btn_map">
				<a style="cursor:pointer;" id="btn_E_map" class="btn_E_map btn_view_layerPopup btn_view_layerPopup_map mq_tablet"><span>다른지역선택</span></a>
				<a style="cursor:pointer;" class="btn_E_map_B btn_view_layerPopup btn_view_layerPopup_map mq_mobile"><span>다른지역선택</span></a>
				<a style="cursor:pointer;" class="btn_EB_reset_map" id="offAreaBtn"><span>지역해제</span></a>
			</span>
		</div>
        <!-- 상세 요약 -->
        <div class="detail_summary detail_summary_AB">
            <figure class="thumbnail">
                <figcaption>해당 서비스에 대한 thumbnail</figcaption>
                <c:choose>
                <c:when test="${!empty data.metaImagFileNm || !empty data.cateSaveFileNm}">
                <%--
                <img src="<c:url value="/portal/data/dataset/selectThumbnail.do" />?infId=<c:out value="${data.infId}" />"  alt="" />
                --%>
                <img src="<c:url value="/portal/data/dataset/selectThumbnail.do" />?seq=<c:out value="${data.seq}" />&metaImagFileNm=<c:out value="${data.metaImagFileNm}" />&cateSaveFileNm=<c:out value="${data.cateSaveFileNm}" />"  alt="" />
                </c:when>
                <c:otherwise>
                <img src="<c:url value="/img/ggportal/desktop/thumbnail/@thumbnail_100.jpg" />"  alt="" />
                </c:otherwise>
                </c:choose>
            </figure>
            <div class="summary">
                <strong class="tit"><c:out value="${data.infNm}" /></strong>
                <c:choose>
                <c:when test="${fn:length(data.infExp) > 175}">
                <span class="cont"><c:out value="${fn:substring(data.infExp, 0, 175)}" />...</span>
                </c:when>
                <c:otherwise>
                <span class="cont"><c:out value="${data.infExp}" /></span>
                </c:otherwise>
                </c:choose>
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
            <td><c:out value="${data.topCateNm}" /> &gt; <c:out value="${data.cateNm}" />
             <c:if test="${data.topCateNm2 ne null}">
             <c:out value=", ${data.topCateNm2} >" /><c:out value=" ${data.CateNm2}" />
         	</c:if>
            </td>
            <th scope="row">DATA 개방일</th>
            <td><c:out value="${data.openDttm}" /></td>
        </tr>
        <tr>
            <th scope="row">태그</th>
            <td><c:out value="${data.infTag}" /></td>
            <th scope="row">최종수정일</th>
            <td>
<%--                 <c:out value="${data.updDttm}" /> --%>
<%--                 <c:if test="${!empty data.dataCondDttm}"> --%>
<%-- <%--                 (기준일자 : <c:out value="${data.dataCondDttm}" />) --%>
<%--                 </c:if> --%>
				<c:out value="${data.loadDttm}" />
                <c:if test="${empty data.loadDttm}">
                	<c:out value="${data.loadNm}" />
                </c:if>
            </td>
        </tr>
        <tr>
            <th scope="row">제공 기관</th>
             <td><c:out value="${data.orgNm}" /></td> 
<%--             <c:choose> --%>
<%--             <c:when test="${data.useOrgCnt > 1}"> --%>
<%--             <td><c:out value="${data.orgNm}" /> 외 <c:out value="${data.useOrgCnt - 1}" /></td> --%>
<%--             </c:when> --%>
<%--             <c:otherwise> --%>
<%--             <td><c:out value="${data.orgNm}" /></td> --%>
<%--             </c:otherwise> --%>
<%--             </c:choose> --%>
            <th scope="row">갱신 주기</th>
            <td><c:out value="${data.loadNm}" /></td>
        </tr>
        <tr>
            <%--
            <th scope="row">담당자 / 연락처</th>
            <c:choose>
            <c:when test="${data.useUsrCnt > 1}">
            <td><c:out value="${data.usrNm}" /> / <c:out value="${data.usrTel}" /> 외 <c:out value="${data.useUsrCnt - 1}" /></td>
            </c:when>
            <c:otherwise>
            <td><c:out value="${data.usrNm}" /> / <c:out value="${data.usrTel}" /></td>
            </c:otherwise>
            </c:choose>
            --%>
            <th scope="row">제공 부서</th>
            <td><c:out value="${data.useDeptNm}" /></td>
            <th scope="row">원본 시스템</th>
            <td><c:out value="${data.srcExp}" /></td>
        </tr>
        <tr>
            <th scope="row">이용 허락 조건</th>
            <%--
            <td colspan="3" class="ty_AB">
            --%>
            <td colspan="3">
                <%--
                <c:choose>
                <c:when test="${data.cclCd == '1000'}">
                <img src="<c:url value="/img/icon_by04.gif" />" class="icon_origin" alt="OPEN" title="<c:out value="${data.cclNm}" />" />
                </c:when>
                <c:when test="${data.cclCd == '1010'}">
                <img src="<c:url value="/img/icon_by02.gif" />" class="icon_origin" alt="OPEN" title="<c:out value="${data.cclNm}" />" />
                </c:when>
                <c:when test="${data.cclCd == '1100'}">
                <img src="<c:url value="/img/icon_by03.gif" />" class="icon_origin" alt="OPEN" title="<c:out value="${data.cclNm}" />" />
                </c:when>
                <c:when test="${data.cclCd == '1110'}">
                <img src="<c:url value="/img/icon_by01.gif" />" class="icon_origin" alt="OPEN" title="<c:out value="${data.cclNm}" />" />
                </c:when>
                </c:choose>
                --%>
                <%--
                <img src="<c:url value="/img/ggportal/desktop/common/icon_ccl_d1008_${data.cclCd}.png" />" class="icon_origin" alt="<c:out value="${data.cclNm}" />" title="<c:out value="${data.cclNm}" />" />
                --%>
                <%--
                <span class="origin"><strong class="mq_tablet"><c:out value="${data.cclNm}" /></strong> <c:out value="${data.cclExp}" /></span>
                --%>
                <c:out value="${data.cclNm}" />
            </td>
        </tr>
        <tr>
            <th scope="row">내용</th>
            <td colspan="3"><pre><c:out value="${data.infExp}" /></pre></td>
        </tr>
        <!-- 데이터기준일자추가 -->
<!--         <tr name="dataCondDttm"> -->
<!--             <th scope="row">데이터 기준일자</th> -->
<%--             <td colspan="3"><pre><c:out value="${data.dataCondDttm}" /></pre></td> --%>
<!--         </tr> -->
        </tbody>
        </table>
        </section>
        <!-- // 메타 정보 -->
        <script type="text/javascript">
            $(function() {
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
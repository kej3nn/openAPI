<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


		<section class="ysearch_section">
                    <div class="ysearch_result_tit">
                        <div class="ysearch_result_tit_txt">${iopen.colDisplayName}(<span><fmt:formatNumber value="${iopen.totalCount}" pattern="#,###"/>건</span>)</div>
                       <fmt:parseNumber var="cnt" type="number" value="${iopen.totalCount }"  />
                       <c:if test="${fn:contains(vo.collection, 'ALL') &&  cnt >3  }">
                        <a href="javascript:doCollection('${iopen.colIndexName}' , 'iopenT')">더보기 <span>+</span></a>
                       </c:if>
                    </div>
                    <div class="ysearch_result_desc">국회정보공개 상세데이터와 일치하는 검색결과를 조회하실 수 있습니다.</div>
                     <c:forEach var="data" items="${iopen.srchList }">
                    <article>
                        <div class="ysearch_result_01"> ${fn:replace( fn:replace( data.INF_PATH, HS , HS_VAL) , HE , HE_VAL)}</div>
                        <div class="ysearch_result_02">
                            <a href="${ data.INF_URL}" target="_blank">${fn:replace( fn:replace( data.INF_TIT, HS , HS_VAL) , HE , HE_VAL)}</a>
                            <c:if test="${not empty data.LOAD_DTTM}"> <span class="ysearch_result_02_date"> (${data.LOAD_DTTM })</span></c:if>
                        </div>
                        
                        <a href="${ data.INF_URL}"   target="_blank" class="ysearch_result_03">
                       	 ${fn:replace( fn:replace(data.INF_CONT , HS , HS_VAL) , HE , HE_VAL)}
                       	 </br>
                       	 ${fn:replace(fn:replace( fn:replace(data.REL_DATA , HS , HS_VAL) , HE , HE_VAL), "||" , "&nbsp;&nbsp;" )}
                        </a>
                       <%-- <c:if test="${data.FILE_TITLE !='' }">
                        <div class="ysearch_result_04">
                            <ul>
                            <c:set var="fileContent" value="${ fn:split(data.FILE_TITLE,'||') }"/>
                            <c:set var="fileUrl" value="${ fn:split(data.FILE_URL,'||') }"/>
                            <c:forEach var="file" items="${ fileContent}" varStatus="idx">
                                <li><a href=" ${ fileUrl[idx.index]}">${file}</a></li>
                                <li><a href="${ fileUrl[idx.index]}">${file}</a>
                                <a href="javascript:previewFile('https://open.assembly.go.kr${ fileUrl[idx.index]}', 'nm', '${file}')" class="ic_preview">미리보기</a>
                           		</li>
                            </c:forEach> 
                            </ul>
                        </div>
                        </c:if>  --%>
                    </article>
          		 </c:forEach>
         </section>

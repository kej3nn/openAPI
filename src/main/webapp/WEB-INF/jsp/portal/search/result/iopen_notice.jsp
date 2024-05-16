<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


		<section class="ysearch_section">
                    <div class="ysearch_result_tit">
                        <div class="ysearch_result_tit_txt">${iopen_notice.colDisplayName}(<span><fmt:formatNumber value="${iopen_notice.totalCount}" pattern="#,###"/>건</span>)</div>
                       <fmt:parseNumber var="cnt" type="number" value="${iopen_notice.totalCount }"  />
                       <c:if test="${fn:contains(vo.collection, 'ALL') &&  cnt >3  }">
                        <a href="javascript:doCollection('${iopen_notice.colIndexName}' , 'iopenT')">더보기 <span>+</span></a>
                       </c:if>
                    </div>
                     <c:forEach var="data" items="${iopen_notice.srchList }">
                    <article>
                      <%--   <div class="ysearch_result_01"> ${fn:replace( data.INF_PATH, HS , HS_VAL)}</div> --%>
                        <div class="ysearch_result_02">
                            <a href="${ data.URL}" target="_blank">[${data.BBS_NM}] ${fn:replace( fn:replace( data.BBS_TIT, HS , HS_VAL) , HE , HE_VAL)}</a>
                           	<span class="ysearch_result_02_date"> (${data.REG_DTTM })</span>
                        </div>
                        
                        <a href="${ data.URL}"   target="_blank" class="ysearch_result_03">
                       	 ${fn:replace( fn:replace(data.BBS_CONT , HS , HS_VAL) , HE , HE_VAL)}
                        </a>
                       <c:if test="${data.FILE_TITLE !='' }">
                        <div class="ysearch_result_04">
                            <ul>
                             <c:set var="fileContent" value="${ fn:split(data.FILE_TITLE,'||') }"/>
                            <c:set var="fileUrl" value="${ fn:split(data.FILE_URL,'||') }"/>
                            <c:forEach var="file" items="${ fileContent}" varStatus="idx">
                                <li><a href="${ fileUrl[idx.index]}">${file}</a><a href="javascript:previewFile('https://open.assembly.go.kr${ fileUrl[idx.index]}', 'nm', '${file}')" class="ic_preview">미리보기</a></li>
                            </c:forEach> 
                            </ul>
                        </div>
                        </c:if> 
                    </article>
          		 </c:forEach>
         </section>

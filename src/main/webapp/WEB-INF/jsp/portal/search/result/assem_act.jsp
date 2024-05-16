<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>


		<section class="ysearch_section">
                    <div class="ysearch_result_tit">
                        <div class="ysearch_result_tit_txt">${assem_act.colDisplayName}(<span><fmt:formatNumber value="${assem_act.totalCount}" pattern="#,###"/>건</span>)</div>
                        <fmt:parseNumber value="${assem_act.totalCount }" var="cnt" />
                       <c:if test="${fn:contains(vo.collection, 'ALLA')  && cnt >3}">   
                        <a href="javascript:doCollection('${assem_act.colIndexName}' , 'assemT')">더보기 <span>+</span></a>
                       </c:if>
                    </div>
                     <c:forEach var="data" items="${assem_act.srchList }">
                    <article>
                        <div class="ysearch_result_01">${fn:replace( fn:replace( data.MENU_PATH, HS , HS_VAL) , HE , HE_VAL)}</div>
                        <div class="ysearch_result_02">
                            <a href="${ data.URL}" target="_blank">${fn:replace( fn:replace( data.STITLE, HS , HS_VAL) , HE , HE_VAL)}</a>
                           	<span class="ysearch_result_02_date"> (${data.DREDATE })</span>
                        </div>
                        
                        <a href="${ data.URL}"   target="_blank" class="ysearch_result_03">
                       	 ${fn:replace( fn:replace(data.CONTENT , HS , HS_VAL) , HE , HE_VAL)}
                       	 </br>
                       	 ${fn:replace( fn:replace(data.FILE_CONTENT , HS , HS_VAL) , HE , HE_VAL)}
                        </a>
                      <%--   <div class="ysearch_result_04">
                            <ul>
                             <c:set var="fileContent" value="${ fn:split(data.FILE_TITLE,'||') }"/>
                            <c:set var="fileUrl" value="${ fn:split(data.FILE_URL,'||') }"/>
                            <c:forEach var="file" items="${ fileContent}" varStatus="idx">
                                <li><a href=" ${ fileUrl[idx.index]}">${file}</a></li>
                            </c:forEach> 
                            </ul>
                        </div> --%>
                    </article>
          		 </c:forEach>
         </section>

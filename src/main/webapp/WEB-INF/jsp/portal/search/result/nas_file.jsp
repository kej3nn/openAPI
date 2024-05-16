<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

		<section class="ysearch_section">
                    <div class="ysearch_result_tit">
                        <div class="ysearch_result_tit_txt">${nas_file.colDisplayName}(<span><fmt:formatNumber value="${nas_file.totalCount}" pattern="#,###"/>건</span>)</div>
                      <%--  <c:if test="${fn:contains(vo.collection, 'ALL') }">   
                        <a href="javascript:doCollection('${nas_file.colIndexName}' , 'nasT')">더보기 <span>+</span></a>
                       </c:if> --%>
                    </div>
                     <c:forEach var="data" items="${nas_file.srchList }">
                    <article>
                        <div class="ysearch_result_01"> ${fn:replace( data.V_SITE_MENU_NAV, HS , HS_VAL)}</div>
                        <div class="ysearch_result_02">
                            <a href="https://nas.na.go.kr${ data.V_URL}" target="_blank">${fn:replace( fn:replace( data.STITLE, HS , HS_VAL) , HE , HE_VAL)}</a>
                           	<span class="ysearch_result_02_date"> (${data.DREDATE })</span>
                        </div>
                        
                        <a href="https://nas.na.go.kr${fn:replace( data.V_URL,'mode=download'  , 'mode=view')}"   target="_blank" class="ysearch_result_03">
                       	 ${fn:replace( fn:replace(data.FILE_CONTENT , HS , HS_VAL) , HE , HE_VAL)}
                        </a>
                        <div class="ysearch_result_04">
                            <ul>
                                <li><a href="https://nas.na.go.kr${ data.V_URL}">${data.FILE_NM}</a>
                                
                                <a href="javascript:previewFile('https://nas.na.go.kr${ data.V_URL}', 'nm', '${data.FILE_NM}')" class="ic_preview">미리보기</a>
                                
                                </li>
                            </ul>
                        </div>
                    </article>
          		 </c:forEach>
         </section>

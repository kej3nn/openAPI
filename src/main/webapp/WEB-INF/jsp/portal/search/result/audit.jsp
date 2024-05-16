<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
		<section class="ysearch_section">
                    <div class="ysearch_result_tit">
                        <div class="ysearch_result_tit_txt">${audit.colDisplayName}(<span><fmt:formatNumber value="${audit.totalCount}" pattern="#,###"/>건</span>)</div>
                    </div>
                     <c:forEach var="data" items="${audit.srchList }">
                    <article>
                       <%--  <div class="ysearch_result_01"> ${fn:replace( data.STITLE, HS , HS_VAL)}</div> --%>
                        <div class="ysearch_result_02">
                            <a href="http://likms.assembly.go.kr${  data.PDF_NM}" target="_blank">${fn:replace( fn:replace( data.STITLE, HS , HS_VAL) , HE , HE_VAL)}</a>
                           	<span class="ysearch_result_02_date"> (${data.RDATE })</span>
                        </div>
                        <a href="http://likms.assembly.go.kr${  data.PDF_NM}" target="_blank"  class="ysearch_result_03">
                        ${fn:replace( fn:replace( data.DP_CONTENT01, HS , HS_VAL) , HE , HE_VAL)}
                       	 ${fn:replace( fn:replace(data.DP_CONTENT02 , HS , HS_VAL) , HE , HE_VAL)}
                       	 </br>
                       	 ${fn:replace( fn:replace(data.CONTENT , HS , HS_VAL) , HE , HE_VAL)}
                      	</a>
                        <div class="ysearch_result_04">
                            <ul>
                             <c:if test="${data.PDF_NM !='' }">
                                <li><a href="https://likms.assembly.go.kr${  data.PDF_NM}">PDF</a>
                                <a href="javascript:previewFile('https://likms.assembly.go.kr${  data.PDF_NM}', 'pdf', '${data.STITLE}')" class="ic_preview">미리보기</a>
                                </li>
                              </c:if> 
                              <c:if test="${data.HWP_NM !='' }">
                                <li><a href=" https://likms.assembly.go.kr${  data.HWP_NM}">HWP</a>
                                <a href="javascript:previewFile('https://likms.assembly.go.kr${  data.PDF_NM}', 'pdf', '${data.STITLE}')" class="ic_preview">미리보기</a>
                                </li>
                               </c:if>
                            </ul>
                        </div>
                        
                    </article>
          		 </c:forEach>
         </section>

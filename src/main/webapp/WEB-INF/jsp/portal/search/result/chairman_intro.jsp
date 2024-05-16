<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


		<section class="ysearch_section">
                    <div class="ysearch_result_tit">
                        <div class="ysearch_result_tit_txt">${chairman_intro.colDisplayName}(<span><fmt:formatNumber value="${chairman_intro.totalCount}" pattern="#,###"/>
건</span>)</div>
                       <fmt:parseNumber var="cnt" type="number" value="${chairman_intro.totalCount }"  />
                       <c:if test="${fn:contains(vo.collection, 'ALLA') &&  cnt >3  }">  
                   			<a href="javascript:doCollection('${chairman_intro.colIndexName}' , 'assemT')">더보기 <span>+</span></a>
                       </c:if>
                    </div>
                     <c:forEach var="data" items="${chairman_intro.srchList }">
                    <article>
                        <div class="ysearch_result_02">
                        	 <a href="${ data.ASSEM_HOMEP}" target="_blank">
                        	${ data.IF_HG_NM} / ${data.IF_ENG_NM } / ${ data.DTL_NM}</br>
                         </a>
                           / ${ data.UNIT_LIST}
                        </div>
                        <a href="${ data.ASSEM_HOMEP}"   target="_blank" class="ysearch_result_03">
                        ${data.DEPT_NM } / ${data.COMMITE_NAME }
                       </br> ${ data.ASSEM_EMAIL} 
                        </a>
                      
                    </article>
          		 </c:forEach>
         </section>

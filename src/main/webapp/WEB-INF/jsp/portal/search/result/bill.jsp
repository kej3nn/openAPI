<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
		<section class="ysearch_section">
                    <div class="ysearch_result_tit">
                        <div class="ysearch_result_tit_txt">${bill.colDisplayName}(<span><fmt:formatNumber value="${bill.totalCount}" pattern="#,###"/>건</span>)</div>
                       <c:if test="${fn:contains(vo.collection, 'ALL') }">   
                        <a href="javascript:doCollection('${bill.colIndexName}' , 'billT')">더보기 <span>+</span></a>
                       </c:if>
                    </div>
                     <c:forEach var="data" items="${bill.srchList }">
                    <article>
                       <%--  <div class="ysearch_result_01"> ${fn:replace( data.INF_PATH, HS , HS_VAL)}</div> --%>
                        <div class="ysearch_result_02">
                            <a href="http://likms.assembly.go.kr/bill/jsp/BillDetail.jsp?bill_id=${ data.DOCID}" target="_blank">${fn:replace( fn:replace( data.BILLNAME, HS , HS_VAL) , HE , HE_VAL)}</a>
                           	
                           	<c:if test="${data.RDATE !='' }"><span class="ysearch_result_02_date"> (${data.RDATE })</span></c:if>
                           
                        </div>
                        
                        <a href="http://likms.assembly.go.kr/bill/jsp/BillDetail.jsp?bill_id=${ data.DOCID}"   target="_blank" class="ysearch_result_03">
                       	 ${fn:replace( fn:replace(data.SUMMARY , HS , HS_VAL) , HE , HE_VAL)}
                       	 </br>
                        </a>
                    </article>
          		 </c:forEach>
         </section>

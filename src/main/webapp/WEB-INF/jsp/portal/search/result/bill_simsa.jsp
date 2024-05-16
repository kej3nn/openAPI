<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

		<section class="ysearch_section">
                    <div class="ysearch_result_tit">
                        <div class="ysearch_result_tit_txt">${bill_simsa.colDisplayName}(<span><fmt:formatNumber value="${bill_simsa.totalCount}" pattern="#,###"/>건</span>)</div>
                      <%--  <c:if test="${fn:contains(vo.collection, 'ALL') }">   
                        <a href="javascript:doCollection('${bill_simsa.colIndexName}' , 'billT')">더보기 <span>+</span></a>
                       </c:if> --%>
                    </div>
                     <c:forEach var="data" items="${bill_simsa.srchList }">
                    <article>
                       <%--  <div class="ysearch_result_01"> ${fn:replace( data.INF_PATH, HS , HS_VAL)}</div> --%>
                        <div class="ysearch_result_02">
                            <a href="https://likms.assembly.go.kr/bill/jsp/BillDetail.jsp?bill_id=${ data.BILL_ID}" target="_blank">${fn:replace( fn:replace( data.STITLE, HS , HS_VAL) , HE , HE_VAL)}</a>
                           	<c:if test="${data.PROPOSE_DT !='' }"><span class="ysearch_result_02_date"> (${data.PROPOSE_DT })</span></c:if>
                        </div>
                        <a href="http://likms.assembly.go.kr/bill/jsp/BillDetail.jsp?bill_id=${ data.BILL_ID}"   target="_blank" class="ysearch_result_03">
                       	 ${fn:replace( fn:replace(data.CONTENT , HS , HS_VAL) , HE , HE_VAL)}
                       	 </br>
                        </a>
                        <div class="ysearch_result_04">
                            <ul>
                                <li><a href="https://likms.assembly.go.kr/filegate/servlet/FileGate?bookId=${data.DOCID}&type=1">심사보고서.pdf</a>
                                <c:if test="${sessionScope.portalUserId eq 'nasys'}">
                                <a href="javascript:previewFile('https://likms.assembly.go.kr/filegate/servlet/FileGate?bookId=${data.DOCID}&type=1', 'pdf', '심사보고서')" class="ic_preview">미리보기s</a>
								<a href="javascript:previewFile('http://likms.assembly.go.kr/filegate/servlet/FileGate?bookId=${data.DOCID}&type=1', 'pdf', '심사보고서')" class="ic_preview">미리보기</a>
                                </c:if>
                                </li>
                            </ul>
                        </div> 
                    </article>
          		 </c:forEach>
         </section>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

		<section class="ysearch_section">
                    <div class="ysearch_result_tit">
                        <div class="ysearch_result_tit_txt">${record1.colDisplayName}(<span><fmt:formatNumber value="${record1.totalCount}" pattern="#,###"/>건</span>)</div>
                       <c:if test="${fn:contains(vo.collection, 'ALL') }">   
                        <a href="javascript:doCollection('${record1.colIndexName}' , 'recordTab')">더보기 <span>+</span></a>
                       </c:if>
                    </div>
                     <c:forEach var="data" items="${record1.srchList }">
                    <article>
                       <!-- <div class="ysearch_result_01">사전정보공개 &gt; 국회의원 &gt; 역대 국회의원</div> --> 
                        <div class="ysearch_result_02">
                            <a href="https://likms.assembly.go.kr/record/mhs-10-050.do?conferNum=${data.CONFER_NUM }&pdfFileId=${data.PDF_ID}&subSpage=P" target="_blank">${fn:replace( fn:replace(data.TAG , HS , HS_VAL) , HE , HE_VAL)}</a>
                            <span class="ysearch_result_02_date"> (${data.RDATE })</span>
                        </div>
                        
                         <a href="https://likms.assembly.go.kr/record/mhs-10-050.do?conferNum=${data.CONFER_NUM }&pdfFileId=${data.PDF_ID}&subSpage=P" target="_blank" class="ysearch_result_03">
                       	
						${fn:replace( fn:replace(data.STITLE , HS , HS_VAL) , HE , HE_VAL)} <br/>
                       	 ${fn:replace( fn:replace(data.CONTENT , HS , HS_VAL) , HE , HE_VAL)}
                        </a>
                        
                        <div class="ysearch_result_04">
                            <ul>
                                <li><a href="https://likms.assembly.go.kr/record/mhs-10-040-0040.do?conferNum=${data.CONFER_NUM }&fileId=${data.HWP_ID}&deviceGubun=P&imsiYn=H">${data.HWP}.hwp</a>
                                <a href="javascript:previewFile('https://likms.assembly.go.kr/record/mhs-10-040-0040.do?conferNum=${data.CONFER_NUM }&fileId=${data.HWP_ID}&deviceGubun=P&imsiYn=H', 'hwp', '${data.HWP}')" class="ic_preview">미리보기</a>
                                </li>
                                <li><a href="https://likms.assembly.go.kr/record/mhs-10-040-0040.do?conferNum=${data.CONFER_NUM }&fileId=${data.PDF_ID}">${data.PDF}.pdf</a>
                                <a href="javascript:previewFile('https://likms.assembly.go.kr/record/mhs-10-040-0040.do?conferNum=${data.CONFER_NUM }&fileId=${data.PDF_ID}', 'pdf', '${data.PDF}')" class="ic_preview">미리보기</a>
                                </li>
                            </ul>
                        </div>
                    </article>
          		 </c:forEach>
         </section>

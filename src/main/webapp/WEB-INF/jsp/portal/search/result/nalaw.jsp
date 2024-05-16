<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
		<section class="ysearch_section">
                    <div class="ysearch_result_tit">
                        <div class="ysearch_result_tit_txt">${nalaw.colDisplayName}(<span><fmt:formatNumber value="${nalaw.totalCount}" pattern="#,###"/>건</span>)</div>
                    </div>
                     <c:forEach var="data" items="${nalaw.srchList }">
                    <article>
                       <!-- <div class="ysearch_result_01">사전정보공개 &gt; 국회의원 &gt; 역대 국회의원</div> --> 
                        <div class="ysearch_result_02">
                            <a href="http://likms.assembly.go.kr/law/lawsLawtInqyDetl1010.do?mappingId=%2FlawsLawtInqyDetl1010.do&genActiontypeCd=2ACT1010&cachePreid=ALL&viewGbObj=viewGb_EXE&contId=${ data.CONT_ID}&contSid=${ data.CONT_SID}" target="_blank">${fn:replace( fn:replace(data.STITLE , HS , HS_VAL) , HE , HE_VAL)}</a>
                           
                            <span class="ysearch_result_02_date"> (${data.RDATE })</span>
                        </div>
                        
                        <a href="http://likms.assembly.go.kr/law/lawsLawtInqyDetl1010.do?mappingId=%2FlawsLawtInqyDetl1010.do&genActiontypeCd=2ACT1010&cachePreid=ALL&viewGbObj=viewGb_EXE&contId=${ data.CONT_ID}&contSid=${ data.CONT_SID}" target="_blank" class="ysearch_result_03">
                       	 ${fn:replace( fn:replace(data.CONTENT , HS , HS_VAL) , HE , HE_VAL)}
                        </a>
                    </article>
          		 </c:forEach>
         </section>

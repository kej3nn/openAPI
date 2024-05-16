<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

		<section class="ysearch_section">
                    <div class="ysearch_result_tit">
                        <div class="ysearch_result_tit_txt">${iopen_file.colDisplayName}(<span><fmt:formatNumber value="${iopen_file.totalCount}" pattern="#,###"/>건</span>)</div>
                       <fmt:parseNumber var="cnt" type="number" value="${iopen_file.totalCount }"  />
                       <c:if test="${fn:contains(vo.collection, 'ALL') &&  cnt >3  }">
                        <a href="javascript:doCollection('${iopen_file.colIndexName}' , 'iopenT')">더보기 <span>+</span></a>
                       </c:if>
                    </div>
                    <div class="ysearch_result_desc">국회정보공개 첨부파일과 일치하는 검색결과를 조회하실 수 있습니다.</div>
                     <c:forEach var="data" items="${iopen_file.srchList }">
                    <article>
                         <div class="ysearch_result_01"> ${fn:replace( fn:replace( data.INF_PATH, HS , HS_VAL) , HE , HE_VAL)}</div>
                        <div class="ysearch_result_02">
                            <a href="https://open.assembly.go.kr${ data.FILE_URL}" target="_blank" class="attach_icon">${fn:replace( fn:replace( data.FILE_TITLE, HS , HS_VAL) , HE , HE_VAL)}.${data.EXT }</a>
                           	<span class="ysearch_result_02_date"> (${data.RDATE })</span>
							<c:if test="${data.EXT != 'zip' }">
                       		<a href="javascript:previewFile('https://open.assembly.go.kr${data.FILE_URL}', 'nm', '${data.FILE_TITLE}.${data.EXT }')" class="ic_preview">미리보기</a>
							</c:if>
                        </div>
                        <a href="https://open.assembly.go.kr${ data.FILE_URL}"   target="_blank" class="ysearch_result_03">
                       	 ${fn:replace( fn:replace(data.FILE_CONTENT , HS , HS_VAL) , HE , HE_VAL)}
                        </a>
                    </article>
          		 </c:forEach>
         </section>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

			<%-- <article>
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
                    </article> --%>

                        <c:if test="${ fn:contains(data.LINK_URL, 'http') }">
                        	<c:set var="homepage_root"  value=""  />
                        </c:if>
		<section class="ysearch_section">
                    <div class="ysearch_result_tit">
                        <div class="ysearch_result_tit_txt">${home_file.colDisplayName}(<span><fmt:formatNumber value="${home_file.totalCount}" pattern="#,###"/>건</span>)</div>
                        <fmt:parseNumber value="${home_file.totalCount }" var="cnt" />
                       <c:if test="${fn:contains(vo.collection, 'ALLA')  && cnt >3}">   
                        <a href="javascript:doCollection('${home_file.colIndexName}' , 'assemT')">더보기 <span>+</span></a>
                       </c:if>
                    </div>
                     <c:forEach var="data" items="${home_file.srchList }">
                    <article>
                        <div class="ysearch_result_01">홈페이지 첨부파일>${fn:replace( fn:replace(data.MENU_PATH , HS , HS_VAL) , HE , HE_VAL)}</div>
                        <div class="ysearch_result_02">
                            <a href="${homepage_root}${ data.LINK_URL}" target="_blank">${fn:replace( fn:replace( data.STITLE, HS , HS_VAL) , HE , HE_VAL)}</a>
                           	<span class="ysearch_result_02_date"> (${data.RDATE })</span>
                        </div>
                        
                        <a href="${homepage_root}${ data.LINK_URL}"   target="_blank" class="ysearch_result_03">
                       	 ${fn:replace( fn:replace(data.CONTENT , HS , HS_VAL) , HE , HE_VAL)}
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

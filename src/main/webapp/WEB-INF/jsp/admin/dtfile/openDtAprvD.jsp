<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<script type="text/javascript">
var dsId = "${data.dsId}";
var metaCol = ${data.metaCol };
</script>
<script type="text/javascript" src="<c:url value="/js/admin/dtfile/openDtAprvD.js" />" charset="utf-8"></script>
        <form id="search-form2" name="search-form2" method="post">
            <table style="width:100%;">
                <caption>데이터 파일 업로드 검색</caption>
                <tr>
                    <td align="right">
                    	<select id="allControl">
                    		<option value="Y">전체승인</option>
                    		<option value="C">전체반려</option>
                    	</select>
                    	<button type="button" class="btn01" title="확인" name="btn_all">확인</button>
                    </td>
                </tr>
            </table>
        </form>
    	<c:if test="${data.indvdlYn == 'Y' }">
    	<span>개인정보 비 식별 오류가 검출 된 자료입니다. 세밀한 확인 바랍니다.</span>
    	</c:if>
        <div id="dtfile-sheet-section2" class="ibsheet_area"></div>
        <div class="buttons">
        	<a class="btn02" title="저장" id="aprv-save">저장</a>
        </div>

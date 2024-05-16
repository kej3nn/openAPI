<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 국회의원 대수 Combobox
<%--              
<%-- @author JHKIM
<%-- @version 1.0 2020/09/11
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<select id="selUnitCd" name="unitCd" title="대수">
<option value="">전체</option>
<c:forEach var="code" items="${assmHistUnitCodeList }">
	<option value="${code.unitCd }">${code.unitNm }</option>
</c:forEach>
</select>
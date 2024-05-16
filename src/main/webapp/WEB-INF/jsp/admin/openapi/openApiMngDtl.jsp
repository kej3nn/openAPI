<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<div class="content" id="naDataSiteMapDtl" style="clear: both; display: none;">
		<form id="openApi-dtl-form" name="openApi-dtl-form" method="post" action="#">
		<input type="hidden" name="apiSeq" id="apiSeq">
		<div name="tab-inner-dtl-sect" class="tab-inner-sect">
			<h3 class="text-title2">제공 오픈 API 관리 상세정보</h3>
			<table class="list01" style="position: relative;">
				<caption>제공 오픈 API 관리 상세정보</caption>
				<colgroup>
					<col width="150" />
					<col width="" />
				</colgroup>
				<tr>
					<th>제공기관<span>*</span></th>
					<td>
						<select name="orgCd">
							<c:forEach items="${orgList}" var="org">
								<option value="${org.orgCd }">${org.orgNm }</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th>API명</th>
					<td>
						<input type="text" id="apiNm" name="apiNm" size="93" placeholder="입력하세요"/>
					</td>
				</tr>
				<tr>
					<th>구분<span>*</span></th>
					<td>
						<select name="apiTagCd">
							<option value="" selected="selected">선택하세요</option>
							<c:forEach items="${apiGubunList}" var="apiGubunList">
								<option value="${apiGubunList.code }">${apiGubunList.name }</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th>URL<span>*</span></th>
					<td>
						<input type="text" id="apiUrl" name="apiUrl" size="80" value="http://" placeholder="입력하세요"/>
						http:// 포함
					</td>
				</tr>
				<tr>
					<th>비고</th> 
					<td>
						<textarea name="apiSmryExp" rows="3" cols="100"></textarea>
					</td>
				</tr>
			</table>
			
			<div class="buttons">
				${sessionScope.button.a_reg}
				${sessionScope.button.a_modify}
				${sessionScope.button.a_del}
			</div>
		</div>
		</form>
	</div>

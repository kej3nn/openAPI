<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<!-- 상세 -->
	<div class="content" id="dtl-area" style="clear: both; display: none;">
	<form id="dtlForm" name="dtlForm" method="post" enctype="multipart/form-data">
		<input type="hidden" name="fileSheetNm"/>
		<input type="hidden" name="dsId" value="${dsId }">
		<input type="hidden" name="dataSeqceNo" value="">
		<h3 class="text-title2">데이터 등록</h3>
		<table class="list01" id="dtl-info-sect">
			<caption>데이터 등록</caption>
			<colgroup>
				<col width="200"/>
				<col width=""/>
			</colgroup>
			
			<c:forEach items="${colList }" var="list">
			<tr>
				<th><label>${list.colNm }</label>	<c:if test="${list.needYn eq 'Y' }"><span>*</span></c:if></th>
				<td>
					<c:choose>
						<c:when test="${list.needYn eq 'Y' }">
							<c:set var="needYn" value="data-required='Y'" />	
						</c:when>
						<c:otherwise>
							<c:set var="needYn" value="" />
						</c:otherwise>
					</c:choose>
					
					
					<c:choose>
						<c:when test="${not empty list.colRefCd }">
							<select name="${list.srcColId }" style="width: 200px;" ${needYn }>
							<option value="">선택</option>
							<c:forEach items="${colRefMap[list.colRefCd] }" var="code">
								<option value="${code.code }">${code.name }</option>
							</c:forEach>
							</select>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${list.srcColType eq 'DATE' }">
									<c:set var="readonly" value="readonly='readonly'" />
									<c:set var="colLenTxt" value=""/>	
								</c:when>
								<c:when test="${list.srcColType eq 'NUMBER' }">
									<c:set var="readonly" value="" />
									<c:set var="colLenTxt" value="${list.srcColSize }Byte 이내의 숫자만 입력하세요"/>
								</c:when>
								<c:otherwise>
									<c:set var="readonly" value="" />
									<c:if test="${isUTF8 eq 'Y' }">
										<c:set var="colLenTxt" value="${list.srcColSize }Byte 이내로 입력하세요 (한글1자 : 3Byte)"/>
									</c:if>
									<c:if test="${isUTF8 eq 'N' }">
										<c:set var="colLenTxt" value="${list.srcColSize }Byte 이내로 입력하세요 (한글1자 : 2Byte)"/>
									</c:if>
								</c:otherwise>
							</c:choose>
							
							<c:choose>
							<c:when test="${list.srcColSize <= 50 }">
								<c:set var="fieldSize" value="style='width: 200px'" />
							</c:when>
							<c:otherwise>
								<c:set var="fieldSize" value="style='width: 70%'" />
							</c:otherwise>
							</c:choose>
							
							<c:choose>
							<c:when test="${list.srcColSize >= 500 }">
								<textarea name="${list.srcColId }" ${fieldSize } rows="5" data-col-size="${list.srcColSize }" data-col-type="${list.srcColType }"  ${needYn }></textarea>
							</c:when>
							<c:otherwise>
								<input type="text" name="${list.srcColId }" ${fieldSize } data-col-size="${list.srcColSize }" data-col-type="${list.srcColType }" ${needYn } ${readonly} />
							</c:otherwise>
							</c:choose>
							
							<span>${colLenTxt }</span>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			</c:forEach>
		</table>
		
		<div class="ibsheet-header">				
			<h3 class="text-title2">첨부파일</h3>
		</div>
		<div>
			<span>※ 파일을 삭제하려면 파일시트의 삭제 체크박스를 체크후 저장해 주세요</span>
		</div>
		
		<div style="clear: both;"></div>
		<div class="ibsheet_area_both">
			<div id="fileSheet" name="fileSheet" class="sheet"></div> 
		</div>
		
		<c:if test="${sessionScope.menuAcc > 10 }">
		<div class="buttons" style="margin: 15px 0 15px;">
			<a href='javascript:;' class='btn02'  title="위로이동" name="a_up">위로이동</a>
			<a href='javascript:;' class='btn02'  title="아래로이동" name="a_down">아래로이동</a>
			<a href='javascript:;' class='btn02'  title="순서저장" name="a_order">순서저장</a>
			${sessionScope.button.a_reg}
			${sessionScope.button.a_save}
			<%-- <a href="javascript:;" class="btn03" title="파일삭제" name="a_file_del" style="display: inline-block;">파일삭제</a> --%>
			${sessionScope.button.a_del}
		</div>
		</c:if>
		
		<table class="list01">
			<caption>첨부파일 상세</caption>
			<colgroup>
				<col width="200"/>
				<col width=""/>
			</colgroup>
			<tr>
				<th><label>파일선택</label> <span>*</span></th>
				<td>
					<input type="file" name="atchFile"/>
				</td>
			</tr>
			<tr>
				<th><label>출력파일명</label> <span>*</span></th>
				<td>
					<input type="text" name="viewFileNm" size="50"/>
					<c:if test="${sessionScope.menuAcc > 10 }">
						<button type="button" class="btn01" name="fileAdd" margin-top: 30px;">파일추가</button>
					</c:if>
				</td>
			</tr>
		</table>
	
	</form>
	</div>
	<!-- //상세 -->
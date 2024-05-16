<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<!-- 상세 -->
	<div class="content" id="dtl-area" style="clear: both; display: none;">
	<form id="dtlForm" name="dtlForm" method="post" enctype="multipart/form-data">
		<input type="hidden" name="fileSheetNm"/>
		<input type="hidden" name="infId"/>
		<input type="hidden" name="seq"/>
		<input type="hidden" name="infSeq"/>
		
		<h3 class="text-title2">통계표 정보</h3>
		<table class="list01" style="position: relative;">
			<caption>메타정보</caption>
			<colgroup>
				<col width="200" />
				<col width="" />
			</colgroup>
			<tr>
				<th>공공데이터명</th>            
				<td>
					<input type="text" name="infNm" value="" style="width:500px" readonly="" class="readonly">
					${sessionScope.button.btn_metaDtl}
				</td>         
			</tr>
		</table>
		
		
		<div class="ibsheet-header">				
			<h3 class="text-title2">첨부파일</h3>
		</div>
		
		<div style="clear: both;"></div>
		<div class="ibsheet_area_both">
			<div id="fileSheet" name="fileSheet" class="sheet"></div> 
		</div>
		
		<div class="buttons" style="margin: 15px 0 15px;">
			<a href='javascript:;' class='btn02'  title="위로이동" name="a_exp_up">위로이동</a>
			<a href='javascript:;' class='btn02'  title="아래로이동" name="a_exp_down">아래로이동</a>
			<a href='javascript:;' class='btn02'  title="순서저장" name="a_exp_order">순서저장</a>
		</div>
		
		<table class="list01">
			<caption>첨부파일 상세</caption>
			<colgroup>
				<col width="200"/>
				<col width=""/>
				<col width="200"/>
				<col width=""/>
			</colgroup>
			<tr>
				<th><label>파일선택</label> <span>*</span></th>
				<td colspan="3">
					<input type="hidden" name="fileSeq">
					<input type="file" name="atchFile"/>
					<span><a href="javascript:;" id="btnFileDown"></a></span>
				</td>
			</tr>
			<tr>
				<th><label>출력파일명</label> <span>*</span></th>
				<td colspan="3">
					<input type="text" name="viewFileNm" size="70"/>&nbsp;(확장자 제외)
				</td>
				
			</tr>
			<tr>
				<th><label>사용여부</label> <span>*</span></th>
				<td>
					<select name="useYn">
						<option value="Y">사용</option>
						<option value="N">미사용</option>
					</select>
				</td>
				<th><label>작성자</label></th>
				<td>
					<input type="text" name="wrtNm" size="50"/>
				</td>
			</tr>
			<tr>   
				<th>최초생성일 <span>*</span></th>                             
				<td>                                                  
					<input type="text" name="ftCrDttm" value="" readonly="readonly" style="width:120px"/>
				</td>
				<th>최종수정일 <span>*</span></th>                                               
				<td>                      
					<input type="text" name="ltCrDttm" value="" readonly="readonly" style="width:120px"/>                 
				</td>
			</tr>
		</table>
		
		<c:if test="${sessionScope.menuAcc > 10 }">
		<div class="buttons">
			<button type="button" class="btn01" name="fileInit" style="margin-bottom: 4px;">신규등록</button>
			${sessionScope.button.a_reg}
			${sessionScope.button.a_modify}
			${sessionScope.button.a_del}
		</div>
		</c:if>
	</form>
	</div>
	<!-- //상세 -->
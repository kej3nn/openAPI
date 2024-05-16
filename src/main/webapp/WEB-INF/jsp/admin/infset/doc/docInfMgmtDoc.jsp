<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div name="tab-inner-doc-sect" class="tab-inner-sect" style="display: none;">
	<table class="list01" style="position: relative;">
		<colgroup>
			<col width="100%" />
		</colgroup>
		<tr>
			<td style="vertical-align:top;">
				<!-- 설명정보 ibsheet 영역 -->
				<div style="width: 100%; float: left;">
					<div class="ibsheet-header">
						<h3 class="text-title2">문서</h3>
						<button type="button" class="btn01" name="expAdd" style="float: right; margin-top: 30px;">추가</button>
					</div>
					
					<div style="clear: both;"></div>
					<div class="ibsheet_area_both">
						<div name="docSheet" class="sheet"></div>
					</div>
					
					<!-- <div class="ibsheet_area" style="clear: both;"> -->
						<table class="list01" style="position: relative;">
						<caption>문서정보</caption>
						<colgroup>
							<col width="150" />
							<col width=""/>
						</colgroup>
							<tr>
								<th><label>제목</label> <span>*</span></th>
								<td>
									<input type="text" name="docCd" id="docCd" value="" size="60" />
									<button type="button" class="btn01" id="docInit" name="docInit">초기화</button>
									<button type="button" class="btn02" id="docAdd" name="docAdd">추가</button>
								</td>
							</tr>
							<tr>
								<th><label>설명</label></th>
								<td>
									<textarea rows="5" cols="50" id="docExp1" name="docExp1" style="width:100%; height:200px;"></textarea>
								</td>
							</tr>
						</table>
					<!-- </div> -->
				</div>		
			</td>
		</tr>
	</table>
	<div class="buttons">
		<a href='javascript:;' class='btn02'  title="위로이동" name="a_exp_up">위로이동</a>
		<a href='javascript:;' class='btn02'  title="아래로이동" name="a_exp_down">아래로이동</a>
		${sessionScope.button.a_save}
	</div>
</div>
	
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div name="tab-inner-open-sect" class="tab-inner-sect" style="display: none;">
	<table class="list01" style="position: relative;">
		<colgroup>
			<col width="100%" />
		</colgroup>
		<tr>
			<td style="vertical-align:top;">
				<!-- ibsheet 영역 -->
				<div style="width: 100%; float: left;">
					<div class="ibsheet-header">
						<h3 class="text-title2">공공데이터</h3>
						<div class="header-right-btn">
							<button type="button" class="btn01" name="openAdd" >추가</button>
						</div>
					</div>
					
					<div style="clear: both;"></div>
					<div class="ibsheet_area_both">
						<div name="openSheet" class="sheet"></div>
					</div>
				</div>					
			</td>
		</tr>
	</table>
	<div class="buttons">
		<a href='javascript:;' class='btn02'  title="위로이동" name="a_open_up">위로이동</a>
		<a href='javascript:;' class='btn02'  title="아래로이동" name="a_open_down">아래로이동</a>
		${sessionScope.button.a_save}
	</div>
</div>
	
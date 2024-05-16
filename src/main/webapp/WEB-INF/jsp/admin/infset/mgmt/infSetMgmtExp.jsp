<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div name="tab-inner-exp-sect" class="tab-inner-sect" style="display: none;">
	<table class="list01" style="position: relative;">
		<colgroup>
			<col width="100%" />
		</colgroup>
		<tr>
			<td style="vertical-align:top;">
				<!-- 설명정보 ibsheet 영역 -->
				<div style="width: 100%; float: left;">
					<div class="ibsheet-header">
						<h3 class="text-title2">설명</h3>
						<button type="button" class="btn01" name="expInit" style="float: right; margin-top: 30px;">초기화</button>
					</div>
					
					<div style="clear: both;"></div>
					<div class="ibsheet_area_both">
						<div name="expSheet" class="sheet"></div>
					</div>
					
					<!-- <div class="ibsheet_area" style="clear: both;"> -->
						<table class="list01" style="position: relative;">
						<caption>설명정보</caption>
						<colgroup>
							<col width="150" />
							<col width=""/>
						</colgroup>
							<tr>
								<th><label>제목</label> <span>*</span></th>
								<td>
									<input type="hidden" id="seqceNo" name="seqceNo" />
									<input type="text" name="infsExpTit" id="infsExpTit" value="" size="60" />
								</td>
							</tr>
							<tr>
								<th><label>설명</label></th>
								<td>
									<textarea rows="5" cols="50" id="infsDtlCont" name="infsDtlCont" style="width:100%; height:200px;"></textarea>
								</td>
							</tr>
							<tr>
								<th>사용여부 <span>*</span></th>
								<td>
									<input type="radio" name="expUseYn" value="Y" checked="checked"><label>사용</label></input>&nbsp;&nbsp;
									<input type="radio" name="expUseYn" value="N"><label>사용안함</label></input>
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
		<a href='javascript:;' class='btn02'  title="순서저장" name="a_exp_order">순서저장</a>
		${sessionScope.button.a_del}
		${sessionScope.button.a_save}
	</div>
</div>
	
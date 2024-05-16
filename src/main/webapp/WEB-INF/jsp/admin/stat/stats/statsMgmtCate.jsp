<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

		<div name="tab-inner-cate-sect" class="tab-inner-sect" style="display: none;">
			<table class="list01" style="position: relative;">
				<colgroup>
					<col width="60%" />
					<col width="40%" />
				</colgroup>
				<tr>
					<td style="vertical-align:top;">
						<!-- ibsheet 영역 -->
						<div style="width: 100%; float: left;">
							<input type="hidden" name="cateJson"></input>
							<div class="ibsheet-header">
								<h3 class="text-title2">분류 구성</h3>
								<div class="header-right-btn">
									<button type="button" class="btn01" name="cateTreeOpen" style="margin-right: -4px;">펼치기</button>
									<button type="button" class="btn01" name="cateTreeClose">접기</button>
									<button type="button" class="btn01" name="stddCate_pop" >추가</button>
								</div>
							</div>
							<div style="clear: both;"></div>
							<div class="ibsheet_area_both">
								<div name="statCateSheet" class="sheet"></div>
							</div>
						</div>					
					</td>
					<td>
						<!-- 분류 상세영역 -->
						<!-- <h3 class="text-title2">분류 상세정보</h3> -->
						<table class="list01" style="position: relative;">
							<caption>분류 상세정보</caption>
							<colgroup>
								<col width="150" />
								<col width="" />
							</colgroup>
							<input type="hidden" name="selcateRow" />
							<tr>
								<th><label>표준항목분류</label></th>
								<td><label name="stddcateNm"></label></td>
							</tr>
							<tr>
								<th><label>자료번호</label><span>*</span></th>
								<td>
									<input type="text" name="cateDatano" value="" placeholder="ID 자동생성" readonly class="readonly" size="20" />
								</td>
							</tr>
							<tr>
								<th><label>부모 자료번호</label></th>
								<td>
									<input type="text" name="cateParDatano" value="" readonly class="readonly" size="20" />&nbsp;
									<button type="button" class="btn01" name="statsParCate_pop" id="statsParCate_pop">검색</button>
								</td>
							</tr>
							<tr>
								<th><label>시트분류명</label><span>*</span></th>
								<td>
									<input type="text" name="cateViewItmNm" value="" placeholder="(한글)시트분류명" width="40%" />
									<input type="text" name="cateEngViewItmNm" value="" placeholder="(영문)시트분류명" width="40%" />
								</td>
							</tr>
							<tr>
								<th><label>차트분류명</label></th>
								<td>
									<input type="text" name="cateChartItmNm" value="" placeholder="(한글)차트분류명" width="40%" />
									<input type="text" name="cateEngChartItmNm" value="" placeholder="(영문)차트분류명" width="40%" />
								</td>
							</tr>
							<tr>
								<th><label>주석</label></th>
								<td>
									<div style="padding: 3px 0"><label>식별번호</label>&nbsp;<input type="text" name="cateCmmtIdtfr" value="" size="10" /></div>
									<div style="padding: 3px 0"><textarea id="" name="cateCmmtCont" style="width: 90%;" rows="2" placeholder="(한글)1,000자 이내로 입력하세요"></textarea></div>
									<div style="padding: 3px 0 3px 0"><textarea id="" name="cateEngCmmtCont" style="width: 90%;" rows="2" placeholder="(영문)1,000자 이내로 입력하세요"></textarea></div>
								</td>
							</tr>
							<tr>
								<th><label>기본선택여부</label></th>
								<td>
									<input type="checkbox" name="cateDefSelYn" value="Y" /><label>Sheet</label></label>&nbsp;&nbsp;
									<input type="checkbox" name="cateCDefSelYn" value="Y" /><label>Chart</label></label>
								</td>
							</tr>
							<tr>
								<th><label>DUMMY</label></th>
								<td>
									<input type="checkbox" name="cateDummyYn" value="Y" /><label>입/출력 안함</label>
								</td>
							</tr>
							<tr>
								<th><label>차트출력여부</label></th>
								<td>
									<input type="checkbox" name="cateSumavgYn" value="Y" /><label>출력 제외</label>
								</td>
							</tr>
							<tr>
								<th><label>유효기간</label></th>
								<td>
									<input type="text" name="cateStartYm" value="" size="20" />
										~
									<input type="text" name="cateEndYm" value="" size="20" />
								</td>
							</tr>
							<tr>
								<th><label>맵핑코드</label></th>
								<td>
									<input type="text" name="cateRefCd" value="" placeholder="" width="40%" />
									<label>  ※ 다른 기관 통계코드</label>
								</td>
							</tr>
							<tr>
								<th><label>사용여부</label><span>*</span></th>
								<td>
									<input type="radio" name="cateUseYn" value="Y" /><label>사용</label>
									<input type="radio" name="cateUseYn" value="N" /><label>사용안함</label>
								</td>
							</tr>
						</table>	
						<button type="button" class="btn01" name="cateConfirmBtn" style="float: right; margin-bottom: 3px;">반영</button>				
					</td>
				</tr>
			</table>
			<div class="buttons">
				<a href='javascript:;' class='btn02'  title="위로이동" name="a_cate_up">위로이동</a>
				<a href='javascript:;' class='btn02'  title="아래로이동" name="a_cate_down">아래로이동</a>
				<!-- <a href="javascript:;" class="btn03" title="저장" name="a_cate_orderSave">순서저장</a> --> 
				<!-- <a href="javascript:;" class="btn03" title="저장" name="a_cate_save">저장</a>  -->
				${sessionScope.button.a_vOrderSave}
				${sessionScope.button.a_save}
			</div>
		</div>
	
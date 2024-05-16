<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

		<div name="tab-inner-itm-sect" class="tab-inner-sect" style="display: none;">
			<table class="list01" style="position: relative;">
				<colgroup>
					<col width="60%" />
					<col width="40%" />
				</colgroup>
				<tr>
					<td style="vertical-align:top;">
						<!-- ibsheet 영역 -->
						<div style="width: 100%; height : 100%; float: left;">
							<input type="hidden" name="itmJson"></input>
							<div class="ibsheet-header">
								<h3 class="text-title2">항목 구성(필수)</h3>
								<!-- <button type="button" class="btn01" name="stddItm_pop" style="float: right">추가</button> -->
								<div class="header-right-btn">
									<button type="button" class="btn01" name="itmTreeOpen" style="margin-right: -4px;">펼치기</button>
									<button type="button" class="btn01" name="itmTreeClose">접기</button>
									<button type="button" class="btn01" name="stddItm_pop" >추가</button>
								</div>
								<!-- <button type="button" class="btn01" name="stddItm_search" style="float: right">조회</button> -->
							</div>
							
							<div style="clear: both;"></div>
							<div class="ibsheet_area_both">
								<div name="statItmSheet" class="sheet"></div>
							</div>
						</div>					
					</td>
					<td>
						<!-- 항목 상세영역 -->
						<!-- <h3 class="text-title2">항목 상세정보</h3> -->
						<table class="list01" style="position: relative;">
							<caption>항목 상세정보</caption>
							<colgroup>
								<col width="150" />
								<col width="" />
							</colgroup>
							<input type="hidden" name="selitmRow" />
							<tr>
								<th><label>표준항목분류</label></th>
								<td><label name="stdditmNm"></label></td>
							</tr>
							<tr>
								<th><label>자료번호</label><span>*</span></th>
								<td>
									<input type="text" name="itmDatano" value="" placeholder="ID 자동생성" readonly class="readonly" size="20" />
								</td>
							</tr>
							<tr>
								<th><label>부모 자료번호</label></th>
								<td>
									<input type="text" name="itmParDatano" value="" readonly class="readonly" size="20" />&nbsp;
									<button type="button" class="btn01" name="statsParItm_pop" id="statsParItm_pop">검색</button>
								</td>
							</tr>
							<tr>
								<th><label>시트항목명</label><span>*</span></th>
								<td>
									<input type="text" name="itmViewItmNm" value="" placeholder="(한글)시트항목명" width="40%" />
									<input type="text" name="itmEngViewItmNm" value="" placeholder="(영문)시트항목명" width="40%" />
								</td>
							</tr>
							<tr>
								<th><label>차트항목명</label></th>
								<td>
									<input type="text" name="itmChartItmNm" value="" placeholder="(한글)차트항목명" width="40%" />
									<input type="text" name="itmEngChartItmNm" value="" placeholder="(영문)차트항목명" width="40%" />
								</td>
							</tr>
							<tr>
								<th><label>항목 단위</label><span>*</span></th>
								<td>
									<input type="hidden" name="itmUiId" value="" placeholder="" readonly="readonly" size="20" />
									<div style="padding: 3px 0">
										<input type="text" name="itmUiNm" value="" placeholder="" readonly="readonly" size="20" />
										<button type="button" class="btn01" name="stddItmUi_pop" id="stddUi_pop">검색</button>
									<div style="padding: 3px 0 3px">
										<input type="checkbox" id="itmUiAllChk" name="itmUiAllChk" value="Y" /><label>선택 항목 동일 단위 적용</label>
									</div>
								</td>
							</tr>	
							<tr>
								<th><label>보기 소수점</label></th>
								<td>
									<select name="itmDmpointCd" id="itmDmpointCd"  style="width : 100px">
									</select>
								</td>
							</tr>
							<tr>
								<th><label>유효기간</label></th>
								<td>
									<input type="text" name="itmStartYm" value="" size="20" />
										~
									<input type="text" name="itmEndYm" value="" size="20" />
								</td>
							</tr>
							<tr>
								<th><label>주석</label></th>
								<td>
									<div style="padding: 3px 0"><label>식별번호</label>&nbsp;<input type="text" name="itmCmmtIdtfr" value="" size="10" /></div>
									<div style="padding: 3px 0"><textarea id="" name="itmCmmtCont" style="width: 90%;" rows="2" placeholder="(한글)1,000자 이내로 입력하세요"></textarea></div>
									<div style="padding: 3px 0 3px 0"><textarea id="" name="itmEngCmmtCont" style="width: 90%;" rows="2" placeholder="(영문)1,000자 이내로 입력하세요"></textarea></div>
								</td>
							</tr>
							<tr>
								<th><label>필수입력</label></th>
								<td>
									<input type="checkbox" name="itmInputNeedYn" value="Y" /><label>통계 값 필수 작성</label>
								</td>
							</tr>
							<tr>
								<th><label>기본선택</label></th>
								<td>
									<input type="checkbox" name="itmDefSelYn" value="Y" /><label>Sheet</label>&nbsp;&nbsp;
									<input type="checkbox" name="itmCDefSelYn" value="Y" /><label>Chart</label>
								</td>
							</tr>
							<tr>
								<th><label>DUMMY</label></th>
								<td>
									<input type="checkbox" name="itmDummyYn" value="Y" /><label>입/출력 안함</label>
								</td>
							</tr>
							<tr>
								<th><label>차트시리즈</label></th>
								<td>
									<div style="padding: 3px 0">
										<select name="itmSeriesCd" id="itmSeriesCd"  style="width : 100px">
										</select>
									<div style="padding: 3px 0 3px">
										<input type="checkbox" id="itmSeriesAllChk" name="itmSeriesAllChk" value="Y" /><label>선택 항목 동일 단위 적용</label>
									</div>
								</td>
							</tr>
							<tr>
								<th><label>검증기준</label></th>
								<td>
									<select name="itmChckCd" id="itmChckCd"  style="width : 100px">
									</select>
								</td>
							</tr>
							<tr>
								<th><label>차트출력여부</label></th>
								<td>
									<input type="checkbox" name="itmSumavgYn" value="Y" />출력 제외</label>
								</td>
							</tr>
							<tr>
								<th><label>맵핑코드</label></th>
								<td>
									<input type="text" name="itmRefCd" value="" placeholder="" width="40%" />
									<label>  ※ 다른 기관 통계코드</label>
								</td>
							</tr>
							<tr>
								<th><label>사용여부</label></th>
								<td>
									<input type="radio" name="itmUseYn" value="Y" /><label>사용</label>
									<input type="radio" name="itmUseYn" value="N" /><label>사용안함</label>
								</td>
							</tr>
						</table>	
						<button type="button" class="btn01" name="itmConfirmBtn" style="float: right; margin-bottom: 3px;">반영</button>				
					</td>
				</tr>
			</table>
			<div class="buttons">
				<a href='javascript:;' class='btn02' title="위로이동" name="a_itm_up">위로이동</a>
				<a href='javascript:;' class='btn02' title="아래로이동" name="a_itm_down">아래로이동</a>
				<!-- <a href="javascript:;" class="btn03" title="순서저장" name="a_itm_orderSave">순서저장</a> --> 
				<!-- <a href="javascript:;" class="btn03" title="저장" name="a_itm_save">저장</a> --> 
				${sessionScope.button.a_vOrderSave}
				${sessionScope.button.a_save}
			</div>
			
		</div>
		
	
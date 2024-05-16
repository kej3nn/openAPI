<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<div class="content" id="statsMst" style="clear: both; display: none;">
		<form id="statsMgmt-mst-form" name="statsMgmt-mst-form" method="post" action="#">
		<ul class="tab-inner" name="tab-inner">   
			<li name="tab-inner-mst" class="tab-inner-li"><a href="#" class="service on">기본정보</a></li>
			<li name="tab-inner-group" class="tab-inner-li"><a href="#" class="service" >그룹구성</a></li>
			<li name="tab-inner-itm" class="tab-inner-li"><a href="#" class="service" >항목구성(필수)</a></li>
			<li name="tab-inner-cate" class="tab-inner-li"><a href="#" class="service" >분류구성</a></li>
		</ul>
		
		<div name="tab-inner-mst-sect" class="tab-inner-sect">
			<input type="hidden" name="tblSheetNm"/>
			<input type="hidden" name="usrSheetNm"/>
			<input type="hidden" name="itmSheetNm"/>
			<input type="hidden" name="cateSheetNm"/>
			<input type="hidden" name="cateInfoSheetNm"/>
			<input type="hidden" name="groupSheetNm"/>
			<h3 class="text-title2">기본정보</h3>
			<table class="list01" style="position: relative;">
				<caption>통계표 기본정보</caption>
				<colgroup>
					<col width="150" />
					<col width="" />
					<col width="150" />
					<col width="" />
				</colgroup>
				<tr>
					<th><label>통계표 ID</label> <span>*</span></th>
					<td colspan="3">
						<input type="text" name="statblId" id="statblId" value="" placeholder="ID 자동생성" readonly class="readonly" size="20" />&nbsp;&nbsp;
						<input type="checkbox" name="fvtDataYn" id="fvtDataYn"><label for="fvtDataYn">추천(홈페이지 노출)</label></input>
						<select id="fvtDataOrder" name="fvtDataOrder" style="width : 180px; display: none;">
						</select>
						<a href="javascript:;" class="btn02" title="통계표 복사" name="a_tblCopy" style="float: right;">통계표 복사</a>
					</td>
				</tr>
				<tr>
					<th><label>통계표명</label> <span>*</span></th>
					<td colspan="3">
						<input type="text" name="statblNm" id="statblNm" value="" placeholder="(한글) 통계표명" size="50" />
						<input type="text" name="engStatblNm" id="engStatblNm" value="" placeholder="(영문) 통계표명" size="50" />&nbsp;
					</td>
				</tr>
				<tr>
					<th><label>통계메타명</label> <span>*</span></th>
					<td colspan="3">
						<input type="text" name="statId" id="statId" value="" readonly="readonly" placeholder="통계메타ID"  size="20"/>
						<input type="text" name="statNm" id="statNm" value="" readonly="readonly" placeholder="통계메타명" size="70" />
						<button type="button" class="btn01" id="statblNm_pop" name="statblNm_pop">검색</button>&nbsp;&nbsp;
						<button type="button" class="btn01G" id="statMeta_pop" name="statMeta_pop">통계설명(팝업)</button>
					</td>
				</tr>
				<tr>
					<th><label>연계정보</label> <span>*</span></th>
					<td>
						<select id="dscnId" name="dscnId" style="width : 180px">
						</select>
					</td>
					<th><label>통계관리번호</label></th>
					<td>
						<input type="text" name="srcStatblId" size="30" value=""/>
					</td>
				</tr>
				<tr>
					<th><label>분류</label> <span>*</span></th>
					<td>
						※ 하단의 분류정보에서 확인할 수 있습니다.
					</td>
					<th><label>이용허락조건</label> <span>*</span></th>
					<td>
						<select id="cclCd" name="cclCd" style="width : 180px">
						</select>
					</td>
				</tr>
				<tr>
					<th><label>통계자료 작성기간</label><span>*</span></th>
					<td>
						<select id="wrtStartYmd" name="wrtStartYmd" style="width : 100px">
						</select>
						~
						<select id="wrtEndYmd" name="wrtEndYmd" style="width : 100px">
						</select>
						<input type="checkbox" name="wrtChk" id="wrtChk" value="Y"><label>종료 제한없음</label></input>
					</td>
					<th><label>대표단위</label></th>
					<td>
						<input type="text" name="rpstuiNm" size="20" value="" placeholder="한글 대표단위"/>
						<input type="text" name="engRpstuiNm" size="20" value="" placeholder="영문 대표단위"/>
					</td>
				</tr>
				<tr>
					<th>작성기준 <span>*</span></th>
					<td colspan="3">
						<table border="0" width="100%" id="dtacycleWrtTable">
							<colgroup>
								<col width="20%" />
								<col width="80%" />
							</colgroup>
							<tr>
								<td>＊자료시점기준</td>	
								<td>
									<select id="wrtstddCd" name="wrtstddCd" style="width : 280px">
		   							</select>
								</td>
							</tr>
							<tr>
								<td>＊작성주기</td>	
								<td id="dtaCycleTD">
									<span id="dtaCycle-sect" style="color: #515151; vertical-align: baseline;"></span>
									&nbsp;&nbsp;
									<label>※ 작성주기를 선택한 후 주기에 대한 기간을 입력하세요</label>
								</td>
							</tr>
							<tr class="wrtTR" name="wrtYYTR" style="display: none;">
								<td>＊년</td>	
								<td>
									<input type="text" name="wrtstartMdYY" value="" placeholder="(년)자료작성시작" size="15" />
									~
									<input type="text" name="wrtendMdYY" value="" placeholder="(년)자료작성종료" size="15" />
								</td>
							</tr>
							<tr class="wrtTR" name="wrtHYTR" style="display: none;">
								<td>＊반기</td>	
								<td>
									<div style="padding: 3px 0 0 0">
										상반기 : 
										<input type="text" name="wrtstartMdHY01" value="" placeholder="(상반기)자료작성시작" size="20" />
										~
										<input type="text" name="wrtendMdHY01" value="" placeholder="(상반기)자료작성종료" size="20" />
									</div>
									<div style="padding: 3px 0 3px 0">
										하반기 : 
										<input type="text" name="wrtstartMdHY02" value="" placeholder="(하반기)자료작성시작" size="20" />
										~
										<input type="text" name="wrtendMdHY02" value="" placeholder="(하반기)자료작성종료" size="20" />
									</div>
								</td>
							</tr>
							<tr class="wrtTR" name="wrtQYTR" style="display: none;">
								<td>＊분기</td>	
								<td>
									<div style="padding: 3px 0 0 0">
										1분기 : 
										<input type="text" name="wrtstartMdQY01" value="" placeholder="(1분기)자료작성시작" size="20" />
										~
										<input type="text" name="wrtendMdQY01" value="" placeholder="(1분기)자료작성종료" size="20" />
									</div>
									<div style="padding: 3px 0 0 0">
										2분기 : 
										<input type="text" name="wrtstartMdQY02" value="" placeholder="(3분기)자료작성시작" size="20" />
										~
										<input type="text" name="wrtendMdQY02" value="" placeholder="(3분기)자료작성종료" size="20" />
									</div>
									<div style="padding: 3px 0 0 0">
										3분기 : 
										<input type="text" name="wrtstartMdQY03" value="" placeholder="(3분기)자료작성시작" size="20" />
										~
										<input type="text" name="wrtendMdQY03" value="" placeholder="(3분기)자료작성종료" size="20" />
									</div>
									<div style="padding: 3px 0 3px 0">
										4분기 : 
										<input type="text" name="wrtstartMdQY04" value="" placeholder="(4분기)자료작성시작" size="20" />
										~
										<input type="text" name="wrtendMdQY04" value="" placeholder="(4분기)자료작성종료" size="20" />
									</div>
								</td>
							</tr>
							<tr class="wrtTR" name="wrtMMTR" style="display: none;">
								<td>＊월</td>	
								<td>
									<select id="wrtstartMdMM" name="wrtstartMdMM" style="width : 80px">
		   							</select>
		   							~
		   							<select id="wrtendMdMM" name="wrtendMdMM" style="width : 80px">
		   							</select>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<th>통계분석 <span>*</span></th>
					<td colspan="3">
						<div id="statsDataType-sect"></div>
					</td>
				</tr>
				<tr>
					<th>주석</th>
					<td colspan="3">
						<div style="padding: 3px 0 0 0"><label>주석 식별자 : </label><input type="text" id="cmmtIdtfr" name="cmmtIdtfr" size="10" value="" /></div>
						<div style="padding: 3px 0 0 0"><textarea id="statblCmmt" name="statblCmmt" style="width: 75%;" rows="2" placeholder="(한글) 1,000자 이내로 입력하세요"></textarea></textarea></div>
						<div style="padding: 3px 0 3px 0"><textarea id="engStatblCmmt" name="engStatblCmmt" style="width: 75%;" rows="2" placeholder="(영문) 1,000자 이내로 입력하세요"></textarea></div>
					</td>
				</tr>
				<tr>
					<th>키워드</th>
					<td colspan="3">
						<div style="padding: 3px 0 0 0"><label>※ 한글, 영문, 숫자만 입력하세요(키워드는 쉼표(,)로 구분하세요)</label></div>
						<div style="padding: 3px 0 0 0"><input type="text" name="schwTagCont" value="" placeholder="(한글) 입력하세요" style="width:70%" /></div>
						<div style="padding: 3px 0 3px 0"><input type="text" name="engSchwTagCont" value="" placeholder="(영문) 입력하세요" style="width:70%" /></div>
					</td>
				</tr>
				<tr>
					<th>시스템</th>
					<td>
						<div id="statSystem-sect"></div>
					</td>
					<th>주기별 이력생성여부</th>
					<td>
						<input type="radio" name="hisCycleYn" value="Y"><label>사용</label></input>&nbsp;&nbsp;
						<input type="radio" name="hisCycleYn" value="N" checked="checked"><label>사용안함</label></input>
					</td>
				</tr>
				<tr>
					<th><label>MAP서비스</label></th>
					<td>
						<select id="mapSrvCd" name="mapSrvCd" style="width : 180px">
						</select>
					</td>
					<th><label>Contents서비스</label></th>
					<td>
						<select id="ctsSrvCd" name="ctsSrvCd" style="width : 180px">
						</select>
					</td>
				</tr>
				<tr>
					<th>사용여부 <span>*</span></th>
					<td>
						<input type="radio" name="useYn" value="Y" checked="checked"><label>사용</label></input>&nbsp;&nbsp;
						<input type="radio" name="useYn" value="N"><label>사용안함</label></input>
					</td>
					<th>데이터 기준일 </th>
					<td>
						<input type="text" name="dataDttmCont" placeholder="최종 데이터의 기준정보를 표시할 경우 입력하세요." size="50">
					</td>
				</tr>	
				<!-- 
				<tr>
					<th><label>공개여부</label><span>*</span></th>
					<td>
						<select id="openState" name="openState" style="width : 100px">
							<option value="Y">공개</option>
							<option value="N">비공개</option>
						</select>
						＊공개일자
					</td>
				</tr> -->
			</table>
			
			<h3 class="text-title2">보기옵션</h3>
			<table class="list01" style="position: relative;">
				<caption>기본검색옵션</caption>
				<colgroup>
					<col width="150" />
					<col width="" />
					<col width="150" />
					<col width="" />
				</colgroup>
				<tr>
					<th><label>검색자료주기</label></th>
					<td>
						<div id="optDC-sect"></div>
					</td>
					<th><label>항목 단위출력</label></th>
					<td>
						<div id="optIU-sect"></div>
					</td>
				</tr>
				<tr>
					<th>검색 시계열 수</th>
					<td colspan="3">
						＊Sheet&nbsp; 
						<select id="optTN" name="optTN" style="width : 180px">
						</select>&nbsp;&nbsp;&nbsp;
						* Chart&nbsp;
						<select id="optTC" name="optTC" style="width : 180px">
						</select>
					</td>
				</tr>
				<tr>
					<th><label>시계열 정렬</label></th>
					<td>
						<div id="optTO-sect"></div>
					</td>
					<th><label>시계열 합계출력</label></th>
					<td>
						<div id="optTL-sect"></div>
					</td>
				</tr>
				<tr>
					<th>통계분석</th>
					<td colspan="3">
						<div id="statsDvsView-sect"></div>
					</td>
				</tr>
				<tr>
					<th><label>표두/표측 설정</label> <span>*</span></th>
					<td colspan="3">
						＊시계열 
						[
						<span id="optST-sect" style="color: #515151; vertical-align: baseline;"></span>
						]&nbsp;&nbsp;
						＊그룹 
						[
						<span id="optSG-sect" style="color: #515151; vertical-align: baseline;"></span>
						]&nbsp;&nbsp;
						＊항목
						[
						<span id="optSI-sect" style="color: #515151; vertical-align: baseline;"></span>
						]&nbsp;&nbsp;
						＊분류 
						[
						<span id="optSC-sect" style="color: #515151; vertical-align: baseline;"></span>
						]
						
					</td>
				</tr>
			</table>
			
			<h3 class="text-title2" name="tblOpenH3">통계표 공개</h3>
			<table class="list01" style="position: relative;" name="tblOpenTable">
				<caption>통계표 공개</caption>
				<colgroup>
					<col width="150" />
					<col width="" />
					<col width="150" />
					<col width="" />
				</colgroup>
				<tr>
					<th><label>통계표</label></th>
					<td colspan="3">
						<button type="button" class="btn01G" id="statPreview_pop" name="statPreview_pop">▤통계표(팝업)▤</button>
					</td>
				</tr>
				<tr>				
					<th><label>공개일</label></th>
					<td colspan="3">
						<input type="hidden" name="openState" value="" />
						<input type="text" name="openDttm" value="" readonly="readonly" placeholder="공개일자" size="30" />
						<button type="button" class="btn01" id="openDttmInit" name="openDttmInit">초기화</button>
						<span style="float: right">
							<!-- 
							<a href='javascript:;' class='btn02' title="공개" name="btnOpenStateY" style="display: none;">공개</a>
							<a href='javascript:;' class='btn02' title="공개취소" name="btnOpenStateC" style="display: none;">공개취소</a> -->
							${sessionScope.button.a_openState}
							${sessionScope.button.a_openStateCancel}
						</span>
					</td>
				</tr>
			</table>
			
			<!-- 연관 통계표 ibsheet 영역 -->
			<div style="width: 100%; float: left;">
				<div class="ibsheet-header">
					<h3 class="text-title2">연관 통계표</h3>
					<button type="button" class="btn01" name="tblAdd" style="float: right; margin-top: 30px;">추가</button>
				</div>
				<div style="clear: both;"></div>
				<div class="ibsheet_area_both">
					<div name="statTblSheet" class="sheet"></div>
				</div>
			</div>
			
			<!-- 분류정보 ibsheet 영역 -->
			<div style="width: 100%; float: left;">
				<div class="ibsheet-header">
					<h3 class="text-title2">분류정보</h3>
					<button type="button" class="btn01" name="cateInfoAdd" style="float: right; margin-top: 30px;">추가</button>
				</div>
				
				<div style="clear: both;"></div>
				<div class="ibsheet_area_both">
					<div name="statCateInfoSheet" class="sheet"></div>
				</div>
			</div>
			
			<!-- 담당자정보 ibsheet 영역 -->
			<div style="width: 100%; float: left;">
				<div class="ibsheet-header">
					<h3 class="text-title2">담당자정보</h3>
					<button type="button" class="btn01" name="usrAdd" style="float: right; margin-top: 30px;">추가</button>
				</div>
				
				<div style="clear: both;"></div>
				<div class="ibsheet_area_both">
					<div name="statUsrSheet" class="sheet"></div>
				</div>
			</div>
			
			<div class="buttons">
				${sessionScope.button.a_modify} ${sessionScope.button.a_del} ${sessionScope.button.a_reg}
			</div>
		</div>
		
		<c:import  url="statsMgmtGroup.jsp"/>
		<c:import  url="statsMgmtItm.jsp"/>
		<c:import  url="statsMgmtCate.jsp"/>
		</form>
	</div>

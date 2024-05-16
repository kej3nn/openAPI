<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<div class="content" id="statInputDtl" style="clear: both; display: none;">
		
		<form id="writeAccount-dtl-form" name="writeAccount-dtl-form" method="post" action="#" enctype="multipart/form-data">
			
			<input type="hidden" name="aplCancel" />
			<input type="hidden" name="rowId" />
			<input type="hidden" name="objtnSno" />
			<input type="hidden" name="callVersion" />
			
			<div name="tab-inner-dtl-sect" class="tab-inner-sect">
				<div name="opnzHist" style="display:none;">
					<h3 class="text-title2">처리상태이력</h3>
					<table class="list01" style="position: relative;">
						<caption>처리상태이력</caption>
						<colgroup>
							<col width="150px;" />
							<col width="200px;" />
							<col width="250px;" />
							<col width="200px;" />
							<col width="" />
							
						</colgroup>
						<thead>
							<th scope="col" style="text-align:center;">번호</th>
							<th scope="col" style="text-align:center;">처리상태</th>
							<th scope="col" style="text-align:center;">처리일시</th>
							<th scope="col" style="text-align:center;">담당자ID</th>
							<th scope="col" style="text-align:center;">비고</th>
						</thead>
						<tbody id="opnzHistList">
						</tbody>
						
					</table>
				</div>
				
				<h3 class="text-title2">청구인 정보</h3>
				<table class="list01" style="position: relative;">
					<caption>청구인 정보</caption>
					<colgroup>
						<col width="150" />
						<col width="" />
						<col width="150" />
						<col width="" />
					</colgroup>
					<input type="hidden" id="aplNo" name="aplNo" size="30" readonly="readonly" class="readonly" />
					<tr id="aplNtfrDivArea">
						<th scope="row">청구인 구분 </th>
						<td colspan="3">
							<input type="radio" value="1" name="aplNtfrDiv" checked="checked" /><label for="useYnY">내국인</label>&nbsp;&nbsp;
							<input type="radio" value="0" name="aplNtfrDiv" /><label for="useYnN">외국인</label>
						</td>
					</tr>
					<tr>
						<th scope="row">이름<span>*</span></th>
						<td>
							<input type="text" name="aplPn" autocomplete="on" size="40" style="ime-mode:active;" value="" />
							<span name="aplPn"></span>
						</td>
						<!-- <th scope="row">주민등록번호<span>*</span></th> -->
						<th scope="row">생년월일<span>*</span></th>
						<td>
							<div id="aplRnoArea" >
			                    <input type="text"  name="aplRno1" autocomplete="on" maxlength="8" size="15"/>
			                    <!-- &nbsp;- <input type="text"  name="aplRno2" autocomplete="on" maxlength="7" size="15"/> -->
			                    <!-- <button type="button" class="btn01" name="isRealBtn">실명인증</button> -->
		                    </div>
		                    <span name="aplRno"></span>
		                </td>
					</tr>
					<tr id="aplCorpArea">
						<th scope="row">법인명</th>
						<td>
							<input type="text" name="aplCorpNm" autocomplete="on" size="40" style="ime-mode:active;" value="" />
							<span name="aplCorpNm"></span>
						</td>
						<th scope="row">사업자번호</th>
						<td>
							<div id="aplBnoArea">
			                    <input type="text"  name="aplBno1" autocomplete="on" size="10"  maxlength="3"/>&nbsp;-
			                    <input type="text"  name="aplBno2" autocomplete="on" size="10"  maxlength="2"/>&nbsp;-
			                    <input type="text"  name="aplBno3" autocomplete="on" size="10"  maxlength="5" />
		                    </div>
		                    <span name="aplBno"></span> 
		                </td>
					</tr>
					
					<tr>
						<th scope="row">휴대전화번호<span>*</span></th>
						<td>
							<div id="aplMblPnoArea">
								<select name="aplMblPno1"  title="휴대전화 첫번째번호" style="width:58px;" >
									<option value="010">010</option>
									<option value="011">011</option>
									<option value="016">016</option>
									<option value="017">017</option>
									<option value="018">018</option>
									<option value="019">019</option>
									<option value="000">없음</option>
								</select>
								
								<input type="text" name="aplMblPno2"  title="휴대전화 앞자리 숫자"   maxlength="4" style="width:55px;"/> - 
								<input type="text" name="aplMblPno3"  title="휴대전화 뒷자리 숫자"   maxlength="4" style="width:55px;"/>
							</div>	
							<span name="aplMblPno"></span>
		                </td>
		                <th scope="row">전화번호</th>
		                <td>
		                	<div id="aplPnoArea">
								<select name="aplPno1" title="전화번호 지역번호" style="width:58px;">
									<option value="02">02</option>
									<option value="031">031</option>
									<option value="032">032</option>
									<option value="033">033</option>
									<option value="041">041</option>
									<option value="042">042</option>
									<option value="043">043</option>
									<option value="051">051</option>
									<option value="052">052</option>
									<option value="053">053</option>
									<option value="054">054</option>
									<option value="055">055</option>
									<option value="061">061</option>
									<option value="062">062</option>
									<option value="063">063</option>
									<option value="064">064</option>
									<option value="070">070</option>
									<option value="000">없음</option>
								</select>
								<input type="text" name="aplPno2"  title="전화번호 앞자리" style="width:55px;" maxlength="4"/> - 
								<input type="text" name="aplPno3"  title="전화번호 뒷자리" style="width:55px;" maxlength="4"/>
							</div>	
							<span name="aplPno" /></span>
		                </td>
					</tr>
					<tr>
		               <th scope="row">모사전송번호</th>
		               <td>
		               <div id="aplFaxNoArea">
							<select name="aplFaxNo1"  title="모사전송번호 첫번째번호 " style="width:58px;" >
								<option value="02">02</option>
								<option value="031">031</option>
								<option value="032">032</option>
								<option value="033">033</option>
								<option value="041">041</option>
								<option value="042">042</option>
								<option value="043">043</option>
								<option value="051">051</option>
								<option value="052">052</option>
								<option value="053">053</option>
								<option value="054">054</option>
								<option value="055">055</option>
								<option value="061">061</option>
								<option value="062">062</option>
								<option value="063">063</option>
								<option value="064">064</option>
								<option value="070">070</option>
								<option value="000">없음</option>
							</select>
							<input type="text" name="aplFaxNo2"  title="모사전송번호 앞자리 숫자" maxlength="4" style="width:55px;"/> - 
							<input type="text" name="aplFaxNo3"  title="모사전송번호 뒷자리 숫자" maxlength="4" style="width:55px;" />
						</div>	
						<span name="aplFaxNo"></span>
		                </td>
		                <th scope="row">신청연계 코드<span>*</span></th>
						<!-- <td>
							<div id="aplConnCdArea" >
								<input type="text"  name="aplConnCd" maxlength="10" size="15"/>
							</div>
							<span name="aplConnCd"></span>
						</td> -->
						<td>
							<input type="text"  name="aplConnCd" maxlength="10" size="15"/>
							<button type="button" class="btn01" id="aplConnCd_save" name="aplConnCd_save">저장</button>
						</td>
		           </tr>
					
					<tr>
		                <th scope="row"><label for="title">정보통신망</label></th>
		                <td colspan="3">
		                	<div id="aplEmailAddrArea">
								<input type="text" name="aplEmailAddr1"  title="정보통신망 아이디입력" style="ime-mode:disabled; width:120px;" maxlength="15" />@
								<input type="text" name="aplEmailAddr2" title="정보통신망 아이디입력" style="ime-mode:disabled; width:120px;"  maxlength="15" readonly="readonly"/>
								<select name="email"  title="정보통신망 선택항목" style="width:105px;">
									<option value="" selected>선택하세요</option>
									<option value="naver.com">naver.com</option>
									<option value="daum.net">daum.net</option>
									<option value="gmail.com">gmail.com</option>
									<option value="nate.com">nate.com</option>
									<option value="korea.com">korea.com</option>
									<option value="hotmail.com">hotmail.com</option>
									<option value="chol.com">chol.com</option>
									<option value="yahoo.co.kr">yahoo.co.kr</option>
									<option value="1">직접입력</option>
								</select>
							</div>	
							<span name="aplEmailAddr"></span>
								
		                </td>
		            </tr>
		            <tr>
		                <th scope="row">주소<span>*</span></th>
		                <td colspan="3">
		                <div id="aplAddrArea">
							<input type="text"  name="aplZpno" title="우편번호" class="input_readonly" style="width:10%;" readonly="readonly"/>
							<button type="button" class="btn01" id="zipcode_pop" name="zipcode_pop">우편번호찾기</button><br>
							<input type="text"  name="apl1Addr"  title="동까지 주소" style="margin:2px 0 0 0; width:80%;" readonly="readonly"/><br />
							<input type="text" name="apl2Addr"  title="나머지 주소" style="ime-mode:active; margin:4px 0 0 0; width:80%;" maxlength="30" />
		                </div>
		                <span name="aplAddr"></span>
		                </td>
		            </tr>
				</table>
				
				<h3 class="text-title2">청구내역<img name="updOpnApl" src="/images/admin/icon_book.png" style="cursor: pointer;padding-left:8px;display:none;" alt="수정" ></h3>
			
				<table class="list01" style="position: relative;">
					<caption>청구내역</caption>
					<colgroup>
						<col width="70" />
						<col width="80" />
						<col width="" />
						<col width="70" />
						<col width="80" />
						<col width="" />
					</colgroup>
					
					<tr id="rcpDtsNoArea">
						<th rowspan="2">접수</th>
						<th>번호</th>
						<td>
							<input maxlength="9" name="rcpDtsNo" type="text"/>
							<span name="rcpDtsNo"></span>
							<input type="hidden" name="rcpNo" /> 
						</td>
						<th colspan="2" rowspan="2">처리기한</th>
						<td rowspan="2">
							<div id="dealDlnDtArea">
								<input type="text" name="dealDlnDt" value="" placeholder="처리기한" size="13" />
							</div>
							<span name="dealDlnDt"></span>
						</td>
					</tr>
					<tr id="rcpDtArea">
						<th>일자</th>
						<td><span name="rcpDt"></span></td>
					</tr>
					
					<tr>
						<th colspan="2" scope="row">청구대상기관 </th>
						<td colspan="4"> 
							<div id="aplInstCdArea"> 
							<c:choose>
								<c:when test="${sessionScope.loginVO.accCd eq 'SYS' or sessionScope.loginVO.accCd eq 'OPA'}">
									<c:forEach var="instCd" items="${instCodeList }" varStatus="status">
										<c:choose>
											<c:when test="${status.first }">
												<input type="radio" name="aplInstCd" id="instCd${instCd.orgCd }" value="${instCd.orgCd }" checked="checked">
													<label for="instCd${instCd.orgCd }">${instCd.orgNm }</label>
												</input>
											</c:when>
											<c:otherwise>
												<input type="radio" name="aplInstCd" id="instCd${instCd.orgCd }" value="${instCd.orgCd }">
													<label for="instCd${instCd.orgCd }">${instCd.orgNm }</label>
												</input>									
											</c:otherwise>
										</c:choose>
										&nbsp;&nbsp;
									</c:forEach>
								</c:when>
									<c:otherwise>
										<c:forEach var="instCd" items="${instCodeList }" varStatus="status">
											<c:if test="${instCd.orgCd eq sessionScope.portalOrgCode}">
												<input type="radio" name="aplInstCd" id="instCd${instCd.orgCd }" value="${instCd.orgCd }" checked="checked">
														<label for="instCd${instCd.orgCd }">${instCd.orgNm }</label>
												</input>
											</c:if>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</div>
							<span name="aplInstNm"></span>
						</td>
					</tr>
					<tr>
						<th colspan="2" scope="row">청구제목<span>*</span></th>
						<td colspan="4">
							<input type="text" name="aplSj" value="" title="청구제목" maxlength="50" style="ime-mode:active;" size="40" />
							<span name="aplSj"></span>
						</td>
					</tr>
					<tr id="aplModSjArea">
						<th colspan="2" scope="row">수정청구제목<span>*</span></th>
						<td colspan="4">
							<input type="text" name="aplModSj" value="" title="수정청구제목" maxlength="50" style="ime-mode:active;" size="40" />
							<span name="aplModSj"></span>
						</td>
					</tr>
					
					<tr>
						<th colspan="2" scope="row">청구내용<span>*</span></th>
						<td colspan="4">
						<div id="aplDtsCnArea">
							<textarea name="aplDtsCn"  title="청구내용" style="width:80%; height:200px;"></textarea><br />
							<span><input type="text" name="len1"  style="width:40px;text-align:right;border: none;margin-bottom:3px;" value="0" readonly="readonly">/2,000 Byte</span>
						</div>
						<span name="aplDtsCn"></span>
						</td>
					</tr>
					
					<tr id="aplModDtsCnArea">
						<th colspan="2" scope="row">수정청구내용</th>
						<td colspan="4">
							<textarea name="aplModDtsCn"  title="수정청구내용" style="width:80%; height:200px;"></textarea><br />
							<span name="len2"><input type="text" name="len2" style="width:40px;text-align:right;border: none;margin-bottom:3px;" value="0" readonly="readonly">/2,000 Byte</span>
							<span name="aplModDtsCn"></span>
						</td>
					</tr>
					
					<tr id="attchFlArea">
						<th colspan="2">첨부문서</th>
						<td colspan="4" >
							<div id="fileArea">
								<span class="text_require">* </span>10mb이하의 파일만 등록이 가능합니다.<br/>
								<span class="text_require">* </span>2개 이상의 파일을 등록하실경우 zip 또는 rar파일로 압축해서 등록하시기 바랍니다.<br/>
								<span class="text_require">* </span>등록가능 파일(txt, hwp, doc, docx, xls, xlsx, ppt, pptx, pdf, zip, rar)<br />
								<input type="file" name="file" id="file" title="첨부문서" size="40" onkeypress="return false;" />
								<button type="button" class="btn01" name="pathDelete">지우기</button>
							</div>
							<input type="hidden" name="attchFlNm" />
							<input type="hidden" name="attchFlPhNm" />
						</td>
					</tr>
					<tr>
						<th colspan="2">공개형태</th>
						<td colspan="4">
						<div id="opbFomVal">
							<c:forEach var="opbFomValCd" items="${lclsCodeList }" varStatus="status">
								<c:choose>
									<c:when test="${status.first }">
										<input type="radio" name="opbFomVal" id="opbFomVal${instCd.baseCd }" value="${opbFomValCd.baseCd }" checked="checked">
											<label for="opbFomVal${opbFomValCd.baseCd }">${opbFomValCd.baseNm }</label>
										</input>
									</c:when>
									<c:otherwise>
										<input type="radio" name="opbFomVal" id="opbFomVal${opbFomValCd.baseCd }" value="${opbFomValCd.baseCd }">
											<label for="opbFomValCd${opbFomValCd.baseCd }">${opbFomValCd.baseNm }</label>
										</input>									
									</c:otherwise>
								</c:choose>
								&nbsp;&nbsp;
							</c:forEach>
						</div>	
							<span name="opbFomEtc" style="display:none;">
								<input type="text" name="opbFomEtc" maxlength="50"  size="50"/>
							</span>
						</td>
					</tr>
					<tr>
						<th colspan="2">수령방법</th>
						<td colspan="4">
							<div id="aplTakMth">
							<c:forEach var="aplTakMthCd" items="${apitCodeList }" varStatus="status">
								<c:choose>
									<c:when test="${status.first }">
										<input type="radio" name="aplTakMth" id="aplTakMth${instCd.baseCd }" value="${aplTakMthCd.baseCd }" checked="checked">
											<label for="aplTakMth${aplTakMthCd.baseCd }">${aplTakMthCd.baseNm }</label>
										</input>
									</c:when>
									<c:otherwise>
										<input type="radio" name="aplTakMth" id="aplTakMth${aplTakMthCd.baseCd }" value="${aplTakMthCd.baseCd }">
											<label for="aplTakMthCd${aplTakMthCd.baseCd }">${aplTakMthCd.baseNm }</label>
										</input>									
									</c:otherwise>
								</c:choose>
								&nbsp;&nbsp;
							</c:forEach>
							</div>
							<span name="aplTakMthEtc" style="display:none;">
								<input type="text" name="aplTakMthEtc" maxlength="50"  size="50"/>
							</span>
						</td>
					</tr>
					
					<tr id="feeRdtnArea">
						<th>수수료</th>
						<th>감면여부</th>
						<td colspan="4">
							<c:forEach var="feeRdtnCd" items="${feerCodeList }" varStatus="status">
								<c:choose>
									<c:when test="${status.last }">
										<input type="radio" name="feeRdtnCd" id="feeRdtnCd${instCd.baseCd }" value="${feeRdtnCd.baseCd }" checked="checked">
											<label for="feeRdtnCd${feeRdtnCd.baseCd }">${feeRdtnCd.baseNm }</label>
										</input>
									</c:when>
									<c:otherwise>
										<input type="radio" name="feeRdtnCd" id="feeRdtnCd${feeRdtnCd.baseCd }" value="${feeRdtnCd.baseCd }">
											<label for="feeRdtnCd${feeRdtnCd.baseCd }">${feeRdtnCd.baseNm }</label>
										</input>									
									</c:otherwise>
								</c:choose>
								&nbsp;&nbsp;
							</c:forEach>
							<table name="feeRdtnTr" style="display:none;">
								
								<tr>
									<th style="width:120px;text-align:center;">감면사유</th>
									<td>
										<textarea name="feeRdtnRson" title="수수료 감면사유"  style="width:98%; height:60px;" ><c:out value="${opnAplDo.fee_rdtn_rson }"/></textarea><br />
										<span><input type="text" name="len3" style="width:20px; text-align:right;border: none;margin-bottom:3px;" value="0" readonly="readonly">/100 Byte</span>
										<br>공공기관의 정보공개에 관한 법률시행령 제17조 제3항 규정에 의하 여 수수료 감면대상에<br> 
										해당하는 경우 기재하며, 감면사유를 증명할 수 있는 서류를 첨부하시기 바랍니다.
									</td>
								</tr>
								<tr id="feeAttchFlArea">
									<th style="width:120px;text-align:center;">첨부문서</th>
									<td>
										<div id="file1Area">
											<span class="text_require">* </span>10mb이하의 파일만 등록이 가능합니다.<br/>
											<span class="text_require">* </span>2개 이상의 파일을 등록하실경우 zip 또는 rar파일로 압축해서 등록하시기 바랍니다.<br/>
											<span class="text_require">* </span>등록가능 파일(txt, hwp, doc, docx, xls, xlsx, ppt, pptx, pdf, zip, rar)<br />
											<input type="file" name="file1" id="file1" title="수수료관련 첨부문서" size="40" onkeypress="return false;" />
											<button type="button" class="btn01" name="pathDelete1">지우기</button>
										</div>
									</td>
									
								</tr>
							</table>
						</td>
					</tr>
					<tr id="dcsNtcRcvMthArea">
						<th colspan="2">결정통지 안내수신</th>
						<td colspan="4">
							<div>
								<input type="checkbox" id="dcs_ntc_rcvmth_sms" name="dcsNtcRcvMthSms" value="Y" 
								<c:if test="${opnAplDo.dcsNtcRcvMthSms != null && opnAplDo.dcsNtcRcvMthSms eq 'Y'}">checked</c:if>/>
								<label for="dcs_ntc_rcvmth_sms">SMS</label>&nbsp;&nbsp;&nbsp;
								<input type="checkbox" id="dcs_ntc_rcvmth_mail" name="dcsNtcRcvMthMail" value="Y" 
								<c:if test="${opnAplDo.dcsNtcRcvMthMail != null && opnAplDo.dcsNtcRcvMthMail eq 'Y'}">checked</c:if>/>
								<label for="dcs_ntc_rcvmth_mail">메일</label>&nbsp;&nbsp;&nbsp;
								<input type="checkbox" id="dcs_ntc_rcvmth_talk" name="dcsNtcRcvMthTalk" value="Y" 
								<c:if test="${opnAplDo.dcsNtcRcvMthTalk != null && opnAplDo.dcsNtcRcvMthTalk eq 'Y'}">checked</c:if>/>
								<label for="dcs_ntc_rcvmth_talk">카카오알림톡</label>
							</div>
						</td>
					</tr>
				</table>
				<div id="opnzDcs">
				    <table class="list01" style="position: relative;">
				        <caption>청구신청정보</caption>
				        <colgroup>
				            <col style="width:70px;">
				            <col style="width:80px;">
				            <col style="width:">
				            <col style="width:;">
				            <col>
				        </colgroup>
				        <tbody>
				            <tr>
				                <th rowspan="3">수수료</th>
				                <th>감면여부</th>
				                <td colspan="4">
				                    <span name="feeRdtnNm"></span>
				                </td>
				            </tr>
				            <tr>
				                <th>감면사유</th>
				                <td colspan="4">
				                    <span name="feeRdtnRson"></span>
				                </td>
				            </tr>
				            <tr>
				                <th>첨부문서</th>
				                 <td colspan="4" name="feeAttchFile">
									<input type="hidden" name="feeAttchFlNm" />
									<input type="hidden" name="feeAttchFlPh" />
									<span name="feeAttchFlNm"></span>
				                </td>
				            </tr>
				            <tbody id="opnzDcsArea" style="display:none;">
				                <tr>
				                    <th colspan="2">공개여부</th>
				                    <td colspan="4">
				                        <span name="opbYn"></span>
				                    </td>
				                </tr>
				                <tr>
				                    <th colspan="2">비공개사유</th>
				                    <td colspan="4">	
				                        <span name="clsdRmk"></span>
				                    </td>
				                </tr>
				                <tr id="clsdAttchFlArea" style="display:none;">
				                    <th colspan="2">비공개 첨부파일</th>
				                    <td colspan="4">
				
				                    </td>
				                </tr>
					            <tr>
					                <th colspan="2">정보 부존재 등<br /> 정보공개청구에<br />따를수 없는 사유 </th>
					                <td colspan="4">
					                	<span name="nonExt"></span><br>
										<span name="nonFlNm"></span>
					                </td>
					            </tr>
				            </tbody>
				            <tr>
				                <th colspan="2">결정통지 안내수신</th>
				                <td colspan="4">
				                    <span name="dcsNtcRcvMthArea"></span>
				                </td>
				            </tr>
				            <tbody id="opbFlnmArea" style="display:none;">
					            <tr>
					                <th colspan="2">
					                   	 결정통지 첨부파일
					                </th>
					                <td colspan="4">
					                	<div name="opbFlNm"></div><br>
					                	<div id="attchEtcFile" style="display:none;">
											<p style="padding:5px 10px 0 0px; color:red; font-size:0.9em;  line-height:1.5em; text-align:justify;">
												▶ 공개된 첨부문서의 진본성(작성시점  및  위,변조여부)확인을 위하여 <br/>&nbsp;&nbsp;&nbsp;AdobeReader 9.x ~ 10.x 를 설치 하신후 아래의 검증 프로그램을 설치해 주십시요. 
												(<a href="#none" style="text-decoration:none;" onclick="javascript:fn_utilFileDownload('4');">
													<img src="/images/admin/icon_file.png" style="padding-right:4px;" alt="첨부파일"> 
													<span style="color:#666;">설치매뉴얼</span>
												</a>
												)
											</p>
											<br>
											<a href="#none" style="text-decoration:none;" onclick="javascript:fn_utilFileDownload('1');">
												<img src="/images/admin/icon_file.png" style="padding-right:4px;" alt="첨부파일"> 
												<span style="color:#666;">AdbeRdr1010_mui_Std.zip</span>
											</a>
											(PDF리더기)<br>
											<a href="#none" style="text-decoration:none;" onclick="javascript:fn_utilFileDownload('2');">
												<img src="/images/admin/icon_file.png" style="padding-right:4px;" alt="첨부파일">
												<span style="color:#666;">e-timing for AdobeReader 9,X,XI,DC(v4.6.6).exe<span style="color:#666;">
											</a>
											(진본확인 검증 프로그램1)<br>
											<a href="#none" style="text-decoration:none;" onclick="javascript:fn_utilFileDownload('3');">
												<img src="/images/admin/icon_file.png" style="padding-right:4px;" alt="첨부파일"> 
												<span style="color:#666;">vcredist_x86.exe</span>
											</a>
											(진본확인 검증 프로그램2)<br>
										</div>
					                </td>
					            </tr>
					            <tr id="opbPsbjArea">
					                <th colspan="2">특이사항</th>
					                <td colspan="4">
					                    <span name="opbPsbj"></span>
					                </td>
					            </tr>
				            </tbody>
				            <tr id="aplDealInstArea" style="display:none;">
								<th colspan="2">이송</th>
								<td colspan="4">
								<c:choose>
									<c:when test="${sessionScope.loginVO.accCd eq 'DM'}">
										<span id="accDM_aplDeptNm"></span>
									</c:when>
									<c:otherwise>
										<c:forEach var="instCd" items="${instCodeList}" varStatus="status">
											<input type="checkbox" name="aplDealInstCd" id="aplDealInstCd${instCd.orgCd }" value="${instCd.orgCd }"><label for="aplDealInstCd${instCd.orgCd }"> ${instCd.orgNm}</label></input>&nbsp;&nbsp;
										</c:forEach>
									</c:otherwise>
								</c:choose>
									<input type="hidden" name="relAplInstCd" />
									<input type="hidden" name="aplDealInstCdArr" />
								</td>
							</tr>
				
				            <tr id="endCnArea" style="display:none;">
				                <th colspan="2">종결사유</th>
				                <td colspan="4">
				                    <span name="endCn"></span>
				                </td>
				            </tr>
				        </tbody>
				    </table>
				</div>
				
				<div name="opnzTrsf" style="display:none;">
					<h3 class="text-title2">이송통지 내역 </h3>
					<table class="list01" style="position: relative;">
						<caption>이송통지</caption>
							 <colgroup>
								<col style="width:70px;">
								<col style="width:80px;">
								<col style="width:">
								<col style="width:">
								<col>
							</colgroup>
						<tbody>
							<tr>
								<th colspan="2">이송기관명</th>
								<td colspan="4">
									<span name="trsfInstNm"></span>
								</td>
							</tr>
							<tr>
								<th colspan="2">이송일자</th>
								<td colspan="4">
									<span name="trsfDt"></span>
								</td>
							</tr>
							<tr>
								<th colspan="2">문서번호</th>
								<td colspan="4">
									<span name="trsfDocNo"></span> 
								</td>
							</tr>
							<tr>
								<th colspan="2">이송사유</th>
								<td colspan="4">
									<span name="trsfCn"></span>
								</td>
							</tr>
							<tr id="trsfEtcCnArea">
								<th colspan="2">그밖의 안내사항</th>
								<td colspan="4">
									<span name="trsfEtcCn"></span>
								</td>
							</tr>
							<tr id="trsfFlArea">
								<th colspan="2">이송첨부파일</th>
								<td colspan="4">
									<div id="trsfFlNmArea"></div><br>
									<p style="padding:5px 10px 0 0px; color:red; font-size:0.9em;  line-height:1.5em; text-align:justify;">
										▶ 공개된 첨부문서의 진본성(작성시점  및  위,변조여부)확인을 위하여 <br/>&nbsp;&nbsp;&nbsp;AdobeReader 9.x ~ 10.x 를 설치 하신후 아래의 검증 프로그램을 설치해 주십시요. 
										(<a href="#none" style="text-decoration:none;" onclick="javascript:fn_fileDownload('4');">
											<img src="/images/admin/icon_file.png" style="padding-right:4px;" alt="첨부파일"> 
											<span style="color:#666;">설치매뉴얼</span>
										</a>
										)
									</p>
									<br>
									<a href="#none" style="text-decoration:none;" onclick="javascript:fn_fileDownload('1');">
										<img src="/images/admin/icon_file.png" style="padding-right:4px;" alt="첨부파일"> 
										<span style="color:#666;">AdbeRdr1010_mui_Std.zip</span>
									</a>
									(PDF리더기)<br>
									<a href="#none" style="text-decoration:none;" onclick="javascript:fn_fileDownload('2');">
										<img src="/images/admin/icon_file.png" style="padding-right:4px;" alt="첨부파일">
										<span style="color:#666;">e-timing for AdobeReader 9,X,XI,DC(v4.6.6).exe<span style="color:#666;">
									</a>
									(진본확인 검증 프로그램1)<br>
									<a href="#none" style="text-decoration:none;" onclick="javascript:fn_fileDownload('3');">
										<img src="/images/admin/icon_file.png" style="padding-right:4px;" alt="첨부파일"> 
										<span style="color:#666;">vcredist_x86.exe</span>
									</a>
									(진본확인 검증 프로그램2)<br>
								</td>
								<input type="hidden"  name="fileName" />
								<input type="hidden"  name="filePath" />
							</tr>
						</tbody>
					</table>
				</div>

				<div name="fromTrsfArea" style="position:relative;display:none;">
					<h3 class="text-title2">이송 받은 정보</h3>
					<table class="list01" style="position: relative;border-color:#9C9C00;">
						<caption>이송 받은 정보</caption>
							 <colgroup>
								<col style="width:150px;">
								<col style="width:">
							</colgroup>
							<tbody>
								<tr>
									<th>이송 기관</th>
									<td><span name="fromTrsfInstNm"></span></td>
								</tr>
								<tr>
									<th>이송 받은 기관<br />및 이송사유</th>
									<td>
										<table class="list02" style="width:100%;">
											<colgroup>
												<col style="width:150px;">
												<col>
											</colgroup>
											<tbody name="fromTrsfInfo">
											</tbody>
										</table>
									</td>
								</tr>
							</tbody>
					</table>
				</div>
				
				<div name="toTrsfArea" style="position:relative;display:none;">
					<h3 class="text-title2">이송 보낸 정보</h3>
					<table class="list01" style="position: relative;border-color:#FF639C;">
						<caption>이송 보낸 정보</caption>
							 <colgroup>
								<col style="width:150px;">
								<col style="width:">
							</colgroup>
						<tbody>
							<tr>
								<th>이송 보낸 기관<br />및 이송사유</th>
								<td>
									<table class="list02" style="width:100%;">
											<colgroup>
												<col style="width:150px;">
												<col>
											</colgroup>
											<tbody name="toTrsfInfo">
											</tbody>
									</table>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				
				<div id="aplDeptArea" style="position:relative;">
					<h3 class="text-title2">담당기관 정보</h3>

					<input type="hidden" name="aInstCd" value=""/>
					<input type="hidden" name="aplDeptNm" value=""/>
					<input type="hidden" name="aplDeptCds" value=""/>
					<input type="hidden" name="aplDeptCd" value=""/>
					<c:if test="${sessionScope.loginVO.accCd ne 'DM'}">
					<div class="buttons" style="position:absolute;top:-10px;right:0;margin:0;">
						<button type="button" class="btn01" name="btn_orgSearch" >담당기관 정보 조회</button>
					</div>
					</c:if>
					<div id="deptTable" style="display:none;">
						<table class="list01" style="position: relative;">
							<caption>담당부서 정보</caption>
							<colgroup>
								<col width="150px;" />
								<col width="" />
								
							</colgroup>
							<thead>
								<th scope="col" style="text-align:center;">번호</th>
								<th scope="col" style="text-align:center;">부서</th>
								
							</thead>
							<tbody id="opnzDeptList">
							</tbody>
							
						</table>
					</div>
				</div>
				<c:if test="${sessionScope.loginVO.accCd ne 'DM'}">
				
				<div class="buttons">
					${sessionScope.button.a_reg}
					<a href="javascript:;" style="display:none;" class="btn02" title="청구서출력" name="printAplBtnA">청구서출력</a>
					<a href="javascript:;" style="display:none;" class="btn02" title="접수" name="infoRcpBtnA">접수</a>
					<a href="javascript:;" style="display:none;" class="btn02" title="접수증출력" name="printRcpBtnA">접수증출력</a>
					<a href="javascript:;" style="display:none;" class="btn02" title="이송" name="infoTrsfBtnA">이송</a>
					<a href="javascript:;" style="display:none;" class="btn02" title="결정기한연장" name="dcsProdBtnA">결정기한연장</a>
					<a href="javascript:;" style="display:none;" class="btn02" title="결정기한연장통지서" name="printExtBtnA">결정기한연장통지서</a>
					<a href="javascript:;" style="display:none;" class="btn02" title="결정통지" name="dcsWriteBtnA">결정통지</a>
					<a href="javascript:;" style="display:none;" class="btn02" title="결정통지취소" name="btnCancelDcs">결정통지취소</a>
					<a href="javascript:;" style="display:none;" class="btn02" title="통지완료취소" name="btnCancelEnd">통지완료취소</a>
					<a href="javascript:;" style="display:none;" class="btn02" title="부존재 등 통지서 출력" name="printNonBtnA">부존재 등 통지서 출력</a>
					<a href="javascript:;" style="display:none;" class="btn02" title="결정통지서" name="printDcsBtnA">결정통지서출력</a>
					<a href="javascript:;" style="display:none;" class="btn02" title="결정내역" name="dcsDetailBtnA">결정내역</a>
					<!-- <a href="javascript:;" style="display:none;" class="btn02" title="이의신청내역" name="objTnBtnA">이의신청내역</a> -->
					<a href="javascript:;" style="display:none;" class="btn02" title="이송통지" name="trnWriteBtnA">이송통지</a>
					<a href="javascript:;" style="display:none;" class="btn02" title="청구취하" name="infoCancelfBtnA">청구취하</a>
					<a href="javascript:;" style="display:none;" class="btn02" title="이송통지서" name="printTrsfBtnA">이송통지서출력</a>
					<a href="javascript:;" style="display:none;" class="btn02" title="종결" name="endInfoBtnA">종결</a>
					<a href="javascript:;" style="display:none;" class="btn02" title="종결취소" name="cancelEndBtnA">종결취소</a>
				</div>
				
				</c:if>
				<c:if test="${sessionScope.loginVO.accCd eq 'DM'}">
				<div class="buttons">
					<a href="javascript:;" style="display:none;" class="btn02" title="청구서출력" name="printAplBtnA">청구서출력</a>
					<a href="javascript:;" style="display:none;" class="btn02" title="접수증출력" name="printRcpBtnA">접수증출력</a>
					<a href="javascript:;" style="display:none;" class="btn02" title="결정기한연장통지서" name="printExtBtnA">결정기한연장통지서</a>
					<a href="javascript:;" style="display:none;" class="btn02" title="부존재 등 통지서 출력" name="printNonBtnA">부존재 등 통지서 출력</a>
					<a href="javascript:;" style="display:none;" class="btn02" title="결정통지서" name="printDcsBtnA">결정통지서출력</a>
					<a href="javascript:;" style="display:none;" class="btn02" title="이송통지서" name="printTrsfBtnA">이송통지서출력</a>
				</div>
				</c:if>
				
			</div>
			<iframe id="download-frame" name="download-frame"  title="다운로드 처리" height="0" style="width:100%; display:none;"></iframe>
			<textarea name="printAplModDtsCn" title="청구내용(출력용)" style="display:none;"></textarea>
			<textarea name="printClsdRmk" title="비공개사유(출력용)"  style="display:none;"></textarea>
		</form>
	</div>

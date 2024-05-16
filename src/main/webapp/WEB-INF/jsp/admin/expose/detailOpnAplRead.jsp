<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<div class="content" id="statInputDtl" style="clear: both; display: none;">
		
		<form id="writeAccount-dtl-form" name="writeAccount-dtl-form" method="post" action="#" enctype="multipart/form-data">
		<input type="hidden" name="aplCancel" />
		<input type= "hidden" name="rowId" />
		<div name="tab-inner-dtl-sect" class="tab-inner-sect">
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
						<span name="rcpDtsNo"></span>
					</td>
					<th colspan="2" rowspan="2">처리기한</th>
					<td rowspan="2">
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
						<span name="aplInstNm"></span>
					</td>
				</tr>
				<tr>
					<th colspan="2" scope="row">청구제목</th>
					<td colspan="4">
						<span name="aplSj"></span>
					</td>
				</tr>
				<tr id="aplModSjArea">
					<th colspan="2" scope="row">수정청구제목</th>
					<td colspan="4">
						<span name="aplModSj"></span>
					</td>
				</tr>
				
				<tr>
					<th colspan="2" scope="row">청구내용</th>
					<td colspan="4">
					<pre name="aplDtsCn"></pre>
					</td>
				</tr>
				
				<tr id="aplModDtsCnArea">
					<th colspan="2" scope="row">수정청구내용</th>
					<td colspan="4">
						<pre name="aplModDtsCn"></pre>
					</td>
				</tr>
				
				<tr id="attchFlArea">
					<th colspan="2">첨부문서</th>
					<td colspan="4" >
					</td>
				</tr>
				<tr>
					<th colspan="2">공개형태</th>
					<td colspan="4">
						<span name="opbFomEtc"></span>
					</td>
				</tr>
				<tr>
					<th colspan="2">수령방법</th>
					<td colspan="4">
						<span name="aplTakMthEtc"></span>
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
				                	<span name="nonExt"></span>
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
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			
			<div class="buttons">
			</div>
		</div>
		<iframe id="download-frame" name="download-frame"  title="다운로드 처리" height="0" style="width:100%; display:none;"></iframe>
		</form>
	</div>

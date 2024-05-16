<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<div class="content" id="statInputDtl" style="clear: both; display: none;">

		<form name="detail-form" method="post" enctype="multipart/form-data">
		<input type="hidden" name="aplNo" value=""/>
		<input type="hidden" name="usrId" value=""/>
		<input type="hidden" name="tget" />
		<input type="hidden" name="objtnSno" value=""/>
		<input type="hidden" name="dcsNtcRcvmth" value=""/>
		<input type="hidden" name="aplEmail" value=""/>
		<input type="hidden" name="aplDealInstcd" value=""/>
		<input type="hidden" name="aplMblPno" value=""/>
		<input type="hidden" name="aplPn" value=""/>

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
			
			<div class="text-title">신청인 정보</div>
			<table class="list01" style="position: relative;">
				<caption>신청인 정보</caption>
				<colgroup>
					<col width="150" />
					<col width="" />
					<col width="150" />
					<col width="" />
				</colgroup>
				<tr>
					<th scope="row">이름 </th>
					<td>
						<label name="aplPn"></label>
					</td>
					<!-- <th scope="row">주민등록번호<br/><span class="text_s">여권,외국인등록번호</span> </th> -->
					<th scope="row">생년월일</th>
					<td>
						<label name="aplRno1"></label>
					</td>
				</tr>
				<tr>
					<th scope="row">법인명 등 대표자 </th>
					<td>
						<label name="aplCorpNm"></label>
					</td>
					<th scope="row">사업자등록번호</th>
					<td>
						<label name="aplBno"></label>
					</td>
				</tr>
				<tr>
					<th scope="row" rowspan="2">주소 </th>
					<td rowspan="2">
						<label name="aplZpno"></label><br/>
						<label name="aplAddr1"></label>&nbsp;<label name="aplAddr2">
					</td>
					<th scope="row">전화번호</th>
					<td>
						<label name="aplPno"></label>
					</td>
				</tr>
				<tr>
					<th scope="row">모사전송번호</th>
					<td>
						<label name="aplFaxNo"></label>
					</td>
				</tr>
				<tr>
					<th scope="row">전자우편 </th>
					<td>
						<label name="aplEmail"></label>
					</td>
					<th scope="row">휴대전화번호</th>
					<td>
						<label name="aplMblPno"></label>
					</td>
				</tr>				
			</table>
			
			<div class="text-title">이의신청 대상</div>
			<div id="board"  style="border-top: 1px solid #7da9d9">
			<table name="clsdList" class="list02" style="position: relative;width:100%;">
				<tr>
					<th style="width:100px;text-align:center;">선택</th>
					<th style="text-align:center;">비공개 내용</th>
					<th style="text-align:center;">비공개 사유</th>
					<th style="width:150px;text-align:center;">이의신청여부</th>
				</tr>
			</table>
			</div>

			<div style="display:table;width:100%;height:50px;background:#f1f3f6;border-radius: 10px;">
				<div style="display:table-cell;vertical-align:middle;color:#0000CC;">&nbsp; ※「공공기관의 정보공개에 관한 법률」 제18조에 따라 청구인은 공공기관의 비공개 또는 부분공개(청구내용 중 비공개 부분) 결정에 대하여 이의신청을 할 수 있으며, 공개 또는 부존재 결정에 대하여는 같은 법 제19조에 따라 행정심판을 청구할 수 있습니다.</div>
			</div>
			
			<div class="text-title" style="margin-top:10px;">이의신청 내역</div>
			<div id="board"  style="border-top: 1px solid #7da9d9">
			<table class="list01" style="position: relative;">
				<caption>이의신청내역</caption>
				<colgroup>
					<col style="width:150px;">
				</colgroup>
				<tr>
					<th>이의신청 대상</th>
					<td>
						<div name="clsdArea">이의신청 대상을 선택하세요.</div>
					</td>
				</tr>
				
				<!-- <tr>
					<th>비공개 사유</th>
					<td>
						<label name="clsdRmk"><pre></pre></label>
					</td>
				</tr>
				<tr>
					<th>비공개 내용</th>
					<td>
						<textarea name="opb_clsd_cn" rows="10" cols="80"></textarea><br />
						<span class="byte_r"><input type="text" name="len1" style="width:30px; text-align:right;border: none;" value="0" readonly>/500 Byte</span>
					</td>
				</tr> -->
				<tr>
					<th>통지서 수령유무</th>
					<td>
							<input type="radio" name="objtnNtcsYn" class="border_none" value="0" style="margin-top:-1px;margin-right:5px;" checked/>정보공개(공개,부분공개,비공개) 결정통지서를 
							<font color="red">결정통지서 받은날짜</font>
							<input type="text" name="dcsNtcDt" value="" placeholder="결정통지서 받은날짜" size="13" />	에 받았음.<br/>

							<input type="radio" name="objtnNtcsYn" class="border_none2" value="1" style="margin-top:-1px;margin-right:5px;"/>정보공개(공개,부분공개,비공개) 결정통지서를 받지 못했음<br/>
							<p>(법 제11조제5항의 규정에 의하여 비공개 결정이 있는것으로 보는날은 
							<input type="text" name="firstDcsDt" value="" placeholder="비공개 결정일" size="13" />임)</p>

					</td>
				</tr>
				<!-- <tr>
					<th>이의신청의 <br />취지 및 이유</th>
					<td>
						<label for="objtnNoti" style="color:#0000CC">
						<div>
							※「공공기관의 정보공개에 관한 법률」 제18조에 따라 청구인은 공공기관의 비공개 또는 부분공개<br/>(청구내용 중 비공개 부분) 결정에 대하여 이의신청을 할 수 있으며, 공개 또는 부존재 결정에 대하여는<br/>같은 법 제19조에 따라 행정심판을 청구할 수 있습니다.
						</div>	
						</label>
						<textarea name="objtn_rson" rows="10" cols="80"></textarea><br />
						<span class="byte_r"><input type="text" name="len2" style="width:30px; text-align:right;border: none;" value="0" readonly>/500 Byte</span>
					</td>
				</tr> -->
				<tr>
					<th scope="row">첨부문서</th>
					<td>
						<span class="text_require">* </span>10mb이하의 파일만 등록이 가능합니다.<br/>
						<span class="text_require">* </span>2개 이상의 파일을 등록하실경우 zip 또는 rar파일로 압축해서 등록하시기 바랍니다.<br/>
						<span class="text_require">* </span>등록가능 파일(txt, hwp, doc, docx, xls, xlsx, ppt, pptx, pdf, zip, rar)<br />
						<input type="file" name="file" size="50" onkeypress="return false;" />
						<button type="button" class="btn01" name="pathDelete" onclick="javascript:fn_pathDelete1('file');">지우기</button>
						<!-- <a href="#none" onclick="javascript:fn_pathDelete1('file');">지우기</a><br/> -->
						<div id="fileArea"></div>
						<input type="hidden" name="objtn_apl_flnm" value=""/>
						<input type="hidden" name="objtn_apl_flph" value=""/>
						<input type="hidden" name="objtnLength"/>
					</td>
				</tr>
			</table>
			</div>
			
			<div class="buttons">
				<a href="javascript:;" class="btn02" title="등록" name="btnInsert">등록</a>
				<a href="javascript:;" class="btn02" title="수정" name="btnUpdate" style="display:none;">수정</a>

			</div>
		</div>
		<iframe id="download-frame" name="download-frame"  title="다운로드 처리" height="0" style="width:100%; display:none;"></iframe>
		</form>
		<form name="dForm" method="post">
			<input type="hidden" name="fileName" />
			<input type="hidden" name="filePath" />
			<input type="hidden" name="apl_no" value="${opnDcsDo.apl_no }" />
		</form>		
	</div>

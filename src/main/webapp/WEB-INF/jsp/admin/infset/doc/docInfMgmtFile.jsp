<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div name="tab-inner-file-sect" class="tab-inner-sect" style="display: none;">
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
						<button type="button" class="btn01" name="fileInit" style="float: right; margin-top: 30px;">초기화</button>
					</div>
					
					<div style="clear: both;"></div>
					<div class="ibsheet_area_both">
						<div name="fileSheet" class="sheet"></div>
					</div>
					
					<!-- <div class="ibsheet_area" style="clear: both;"> -->
						<table class="list01" style="position: relative;">
							<caption>문서정보</caption>
							<colgroup>
								<col width="150" />
								<col width="" />
								<col width="150" />
								<col width="" />
							</colgroup>
							<tr>
								<th><label>문서파일</label> <span>*</span></th>
								<td>
									<input type="hidden" name="fileSeq" id="fileSeq"/>
									<input type="file" name="docFile" size="35" value=""/>
									&nbsp;&nbsp;&nbsp;※  모든 문서파일 및 이미지 파일만 선택하세요.
								</td>
								<th><label>출력파일명</label> <span>*</span></th>
								<td>
									<input type="text" name="viewFileNm" id="viewFileNm" value="" placeholder="출력문서명" size="50" />
									<input type="hidden" name="fileExt" id="fileExt" value=""/>
									&nbsp;&nbsp;&nbsp;※ 확장자는 제외
								</td>
							</tr>
								<th><label>이미지</label></th>
								<td colspan="3">
									<input type="hidden" id="tmnlImgFile"/>
									<input type="file" name="imgFile" size="35" value=""/>
									<button type="button" class="btn01" name="btnImgThumbnail">미리보기</button>
									&nbsp;&nbsp;&nbsp;※ 이미지 파일(gif/jpg/png)만 선택하세요.
								</td>
							<tr>
							</tr>
								<th><label>생산일</label> <span>*</span></th>
								<td>
									<input type="text" name="prdcYmd" value="" readonly="readonly" placeholder="생산일" size="30" />
								</td>
								<th><label>문서보존기한</label> <span>*</span></th>
								<td>
									<select id="docKpDdayCd" name="docKpDdayCd"></select>
								</td>
							<tr>
								<th><label>기준문서</label></th>
								<td>
									<select id="srcFileSeq" name="srcFileSeq"></select>
								</td>
								<th><label>원본관리번호</label></th>
								<td>
									<input type="text" name="srcFileDocId" id="srcFileDocId" value="" placeholder="입력하세요.." size="50" />
								</td>
							</tr>
							<tr>
								<th>파일 내용</th>
								<td colspan="3">
									<textarea rows="5" cols="50" id="fileDtlCont" name="fileDtlCont" style="width:100%; height:150px;"></textarea>
								</td>
							</tr>
							<tr>
								<th>사용여부 <span>*</span></th>
								<td colspan="3">
									<input type="radio" name="fileUseYn" value="Y" checked="checked"><label>사용</label></input>&nbsp;&nbsp;
									<input type="radio" name="fileUseYn" value="N"><label>사용안함</label></input>
								</td>
							</tr>	
						</table>
					<!-- </div> -->
				</div>		
			</td>
		</tr>
	</table>
	<div class="buttons">
		<a href='javascript:;' class='btn02'  title="위로이동" name="a_file_up">위로이동</a>
		<a href='javascript:;' class='btn02'  title="아래로이동" name="a_file_down">아래로이동</a>
		<a href='javascript:;' class='btn02'  title="순서저장" name="a_file_order">순서저장</a>
		${sessionScope.button.a_del}
		<a href='javascript:;' class='btn03'  title='등록' name='a_file_reg'>등록</a>
		${sessionScope.button.a_save}
	</div>
</div>
	
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<div class="content" id="naDataSiteMapDtl" style="clear: both; display: none;">
		<form id="naDataSiteMap-dtl-form" name="naDataSiteMap-dtl-form" method="post" action="#">
		
		<div name="tab-inner-dtl-sect" class="tab-inner-sect">
			<h3 class="text-title2">정보서비스맵 상세정보</h3>
			<table class="list01" style="position: relative;">
				<caption>정보서비스맵 상세정보</caption>
				<colgroup>
					<col width="150" />
					<col width="" />
					<col width="150" />
					<col width="" />
				</colgroup>
				<tr>
					<th>서비스맵ID <span>*</span></th>
					<td colspan="2">
						<input type="text" id="srvmId" name="srvmId" size="30" readonly="readonly" class="readonly"/>
						<input type="hidden" id="dupChk" name="dupChk" value="N"/>
						<button type="button" class="btn01" id="siteMapSrvm_dup" name="siteMapSrvm_dup">중복확인</button>
					</td>
					<td>※ 영문, 숫자 10자리 이내</td>
				</tr>
				<tr>
					<th>서비스맵명<span>*</span></th>
					<td>
						<input type="text" id="srvmNm" name="srvmNm" size="15" placeholder="입력하세요"/>
					</td>
					
				</tr>
				<tr>
					<th>분류<span>*</span></th>
					<td colspan="3">
						<input type="text" id="cateId" name="cateId" size="8" readonly="readonly" />
						<input type="text" id="cateNm" name="cateNm" size="25" value=""  placeholder="선택하세요." readonly="readonly" />
						<button type="button" class="btn01" id="naSetCate_pop" name="naSetCate_pop">검색</button>
					</td>
				</tr>
				<tr>
					<th>관련기관<span>*</span></th>
					<td colspan="3">
						<select id="orgCd" name="orgCd">
							<option value="" selected="selected">선택하세요</option>
							<c:forEach items="${orgList}" var="org">
								<option value="${org.orgCd }">${org.orgNm }</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th>주요서비스</th>
					<td>
						<textarea name="infoSmryExp" rows="2" cols="60" placeholder="입력하세요"></textarea>
					</td>
				</tr>
				<tr>
					<th>바로가기<span>*</span></th>
					<td colspan="2">
						<input type="text" id="srcUrl" name="srcUrl" size="60" value="http://" placeholder="입력하세요"/>
					</td>
					<td>http:// 포함</td>
				</tr>
				<tr>
					<th>미리보기</th> 
					<td colspan="2">
						<input type="file" id="tmnlImgFile" name="tmnlImgFile" accept="image/*" >
					</td>
					<td>
						<img id="tmnlImgFileImg" alt="" src="" width="100" height="100" />
					</td>
				</tr>
				<tr>
					<th>사이트맵</th> 
					<td colspan="2">
						<input type="file" id="tmnl2ImgFile" name="tmnl2ImgFile" accept="image/*" >
					</td>
					<td>
						<img id="tmnl2ImgFileImg" alt="" src="" width="100" height="100" />
					</td>
				</tr>
				<tr>
					<th>정상서비스여부</th>
					<td colspan="3">
						<input type="radio" id="viewYnY" name="viewYn" size="30" value="Y" checked="checked"/><label for="viewYnY">정상</label>&nbsp;&nbsp;
						<input type="radio" id="viewYnN" name="viewYn" size="30" value="N"/><label for="viewYnN">비정상</label>
						<span name="linkChkDttm">링크확인일자 :</span>
						<input type="text" id="linkChkDttm" name="linkChkDttm" readonly="readonly" class="readonly">
					</td>
				</tr>
				<tr>
					<th>사용여부</th>
					<td colspan="3">
						<input type="radio" id="useYnY" name="useYn" size="30" value="Y" checked="checked"/><label for="useYnY">사용</label>&nbsp;&nbsp;
						<input type="radio" id="useYnN" name="useYn" size="30" value="N"/><label for="useYnN">미사용</label>
					</td>
				</tr>
				<!-- <tr>
					<td colspan="2">
						<img id="tmnlImgFileImg" alt="" src="" width="100" height="100" />
					</td>
					<td colspan="2">
						<img id="tmnl2ImgFileImg" alt="" src="" width="100" height="100" />
					</td>
				</tr> -->
			</table>
			
			<div class="buttons">
				${sessionScope.button.a_reg}
				${sessionScope.button.a_modify}
				${sessionScope.button.a_del}
			</div>
		</div>
		
		</form>
	</div>

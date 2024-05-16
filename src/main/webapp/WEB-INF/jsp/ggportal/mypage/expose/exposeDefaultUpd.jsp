<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 	--%>
<%-- 마이페이지 > 청구기본정보수정 
<%-- @author csb
<%-- @version 1.0 2021/06/15
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 	--%>
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- head include -->
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
</head>
<body>
<!-- header html -->
<%@ include file="/WEB-INF/jsp/portal/sect/header.jsp" %>
    <div class="container" id="container">
        <!-- leftmenu -->
        <%@ include file="/WEB-INF/jsp/portal/sect/lnb.jsp" %>
        <!-- //leftmenu -->
        <div class="contents" id="contents">
            <div class="contents-title-wrapper">
                <h3>청구기본정보수정<span class="arrow"></span></h3>
            </div>
            <form id="form" name="form" method="post">
                <input type="hidden" name="aplPn" value="<c:out value="${sessionScope.portalUserNm}" />"/>
                <input type="hidden" name="aplRno1" value="<c:out value="${sessionScope.loginRno1}" />"/>
                <input type="hidden" name="page" value="<c:out value="${param.page}" default="1" />" title="page">
        		<input type="hidden" name="rows" value="<c:out value="${param.rows}" default="10" />" title="rows">
                <div class="layout_flex">
                    <div class="layout_flex_100">
                        <fieldset>
                            <section>
                                <table class="table_datail_CC w_1 bt2x width_A">
                                    <caption>
                                        <c:out value="${requestScope.menu.lvl2MenuPath}" /> 청구인정보 : 이름,생년월일,휴대전화번호,전화번호,모사전송번호,전자우편,주소
                                    </caption>
                                    <tbody>
                                        <tr>
                                            <th scope="row"><span class="text_require">* </span>이름</th>
                                            <td class="mh42x">
                                                <em><c:out value="${sessionScope.portalUserNm}" /></em>
                                            </td>
                                            <th scope="row"><span class="text_require">*</span>생년월일</th>
                                            <td>
                                                <div id="isReal-sect">
                                                    <div>
                                                        <c:out value="${sessionScope.loginRno1 }" />
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th scope="row"><span class="text_require">*</span>휴대전화번호</th>
                                            <td>
                                                <select name="userHp" id="userHp" title="휴대폰 서비스 번호 선택" class="w60x">
                                                    <option value="010">010</option>
                                                    <option value="011">011</option>
                                                    <option value="016">016</option>
                                                    <option value="017">017</option>
                                                    <option value="018">018</option>
                                                    <option value="019">019</option>
                                                    <option value="000">없음</option>
                                                </select>
                                                <input type="text" id="userHp2" name=userHp2 value="" title="휴대폰 가운데 자리" maxlength="4" class="w60x" pattern="[0-9]{4}" autocomplete="on" ime-mode:disabled;"> -
                                                <input type="text" id="userHp3" name="userHp3" value="" title="휴대폰 마지막 자리" maxlength="4" class="w60x" pattern="[0-9]{4}" autocomplete="on" ime-mode:disabled;">
                                            </td>
                                            <th scope="row"><span class="text_require">* </span>전화번호</th>
                                            <td>
                                                <select name="userTel" id="userTel" title="전화번호 지역번호 선택" class="w60x">
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
                                                <input type="text" id="userTel2" name="userTel2" value="" title="전화번호 가운데 자리" class="w60x" maxlength="4" pattern="[0-9]{4}" autocomplete="on" ime-mode:disabled;"> -
                                                <input type="text" id="userTel3" name="userTel3" value="" title="전화번호 마지막 자리" class="w60x" maxlength="4" autocomplete="on" ime-mode:disabled;">
                                            </td>
                                        </tr>
                                        <tr>
                                            <th scope="row">모사전송번호</th>
                                            <td colspan="3">
                                                <select name="userFaxTel" id="userFaxTel" title="모사전송번호 지역번호 선택" class="w60x">
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
                                                <input type="text" id="userFaxTel2" name="userFaxTel2" title="모사전송번호 가운데 자리" maxlength="4" class="w60x" autocomplete="on" ime-mode:disabled;"> -
                                                <input type="text" id="userFaxTel3" name="userFaxTel3" title="모사전송번호 마지막 자리" maxlength="4" class="w60x" autocomplete="on" ime-mode:disabled;">
                                            </td>
                                        </tr>
                                        <tr>
                                            <th scope="row">전자우편</th>
                                            <td colspan="3">
                                                <input type="text" class="mw40p" id="eMail" name="userEmail1" title="전자우편 아이디 입력" style="ime-mode:inactive;" maxlength="15">@
                                                <input type="text" class="mw40p" id="eMail_2" name="userEmail2" title="전자우편 도메인 입력" style="ime-mode:inactive;" maxlength="15" readonly="readonly">
                                                <select id="eMail_3" name="userEmail3" title="전자우편 선택">
                                                    <option value="" selected>선택하세요</option>
                                                    <option value="naver.com">naver.com</option>
                                                    <option value="daum.net">daum.net</option>
                                                    <option value="gmail.com">gmail.com</option>
                                                    <option value="nate.com">nate.com</option>
                                                    <option value="korea.com">korea.com</option>
                                                    <option value="hotmail.com">hotmail.com</option>
                                                    <option value="chol.com">chol.com</option>
                                                    <option value="yahoo.co.kr">yahoo.co.kr</option>
                                                    <option value="assembly.go.kr">assembly.go.kr</option>
                                                    <option value="na">직접입력</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th scope="row"><span class="text_require">* </span>주소</th>
                                            <td colspan="3">
                                                <input type="text" class="mw70x" name="userZip" id="apl_zpno" title="우편번호" class="input_readonly" readonly="readonly">
                                                <a title="새창열림_우편번호찾기" href="javascript:;" class="btn_C" id="findAddrBtn">우편번호찾기</a><br>
                                                <input type="text" name="user1Addr" id="apl_addr1" class="input_readonly input_zip w100p" title="동까지 주소" readonly="readonly"><br>
                                                <input type="text" name="user2Saddr" id="apl_addr2" title="나머지 주소" class="w100p" style="ime-mode:active;" maxlength="30" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th scope="row">청구처리통지</th>
                                            <td colspan="3">
                                                <input type="checkbox" title="이메일" class="ml10" id="emailYn" name="emailYn" value="Y">
                                                <label>이메일</label>
                                                <input type="checkbox" title="SMS" id="hpYn" name="hpYn" value="Y">
                                                <label>SMS</label>
                                                <input type="checkbox" title="카카오알림톡" class="ml10" id="kakaoYn" name="kakaoYn" value="Y">
                                                <label>카카오알림톡</label>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <div class="area_btn_A">
                                	<a href="javascript:;" class="btn_filedown" id="popOpnzAplBtn">청구서 불러오기</a>
                                    <a href="javascript:;" class="btn_inquiries" id="updateBtn">저장</a>
                                </div>
                            </section>
                        </fieldset>
                    </div>
                </div>
                <!-- 기존청구서 불러오기 레이어 팝업 -->
				<div class="mask"></div>
				<div class="layerpopup-wrapper">
					<div class="layerpopup-area">
						<h2>기존 청구서 불러오기</h2>
						<div class="layerpopup-box">
							<div class="cheonggu_desc">
							※&nbsp;공공기관의 정보공개에 관한 법률」 개정에 따라 2021년 6월 23일부터 정보공개 청구 시 주민등록번호를 기재하지 않고 있습니다(현재는 생년월일로 대체).
							따라서 이전 정보공개 청구 건 확인을 위해서는 한 차례 주민등록번호 인증이 필요합니다.
							<div class="cheonggu_choice">
								<p>
									<input type="radio" name="searchType" value="aplRno2" checked="checked"><label for="" class="ml05">주민등록번호 뒷자리</label>
									<input type="password" name="aplRno2" value="" maxlength="7" class="ml05">
								</p>
								<p>
									<input type="radio" name="searchType" value="aplConnCd"><label for="" class="ml05">신청연계코드</label>
									<input type="text" name="aplConnCd" value="" maxlength="10" readonly="readonly" class="ml05">
								</p>
							</div>
							
							<div class="cheonggu_btn">
								<a href="javascript:;" class="btn_checkchart" id="loadOpnzAplBtn">불러오기</a>
								<a href="javascript:;" class="btn_inquiries" id="saveOpnzAplBtn">청구서저장</a>
							</div>

							<div class="table-type03 line01 mnone">
								<ul class="search search_AB">
						            <li class="ty_BB">
						                <ul class="ty_A mq_tablet">
						                    <li>전체 <strong id="count-sect" class="totalNum">0</strong>건<!-- , <span id="pages-sect" class="pageNum"></span> --></li>
						                </ul>
						            </li>
					            </ul>
								<table id="data-table" class="cheonggu_mobile_table">
									<caption>
										
									</caption>
									<colgroup>
										<col style="width: 8%" />
										<col style="width: 20%" />
										<col style="" />
										<col style="width: 20%" />
									</colgroup>
									<thead>
										<tr>
											<th scope="col">번호</th>
							                <th scope="col">청구일자</th>
							                <th scope="col">제목</th>
							                <th scope="col">청구기관명</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td colspan="4" class="noData">청구서 자료가 없습니다.</td>
										</tr>
									</tbody>
								</table>
							</div>
							
							<!-- mobile용 -->
							<div class="mobile_expo">
								<ul class="search search_AB">
						            <li class="ty_BB">
						                <ul class="ty_A mq_tablet">
						                    <li>전체 <strong id="count-sect-mb" class="totalNum">0</strong>건</li>
						                </ul>
						            </li>
					            </ul>
					            <div id="mbList">
					            	<div class="expo_nodata">청구서 자료가 없습니다.</div>
					            </div>	
							</div>
							<!-- //mobile용 -->
							<!-- page -->
				            <div id="pager-sect" class="page"></div>
				            <!-- // page -->
						</div>
						<button type="button" class="btn-layerpopup-close" style="width:auto;">
							<img src="<c:url value="/images/soportal/btn/btn_close02@2x.gif" />" alt="닫기버튼" />
						</button>
					</div>
				</div>
				<!-- //기존청구서 불러오기 레이어 팝업 -->
            </form>
            <c:import  url="/WEB-INF/jsp/inc/iframepopup.jsp"/>
        </div>
    </div>
    <!-- footer -->
    <%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
	<script type="text/javascript" src="<c:url value="/js/ggportal/myPage/expose/exposeDefaultUpd.js" />"></script>
</body>

</html>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)password.jsp 1.0 2015/06/15                                        --%>
<%--                                                                        --%>
<%-- COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.            --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<script type="text/javascript" src="<c:url value="/js/ggportal/sha.js" />"></script>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 비밀번호 입력 화면이다.                                                --%>
<%--                                                                        --%>
<%-- @author 김은삼                                                         --%>
<%-- @version 1.0 2015/06/15                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
        <!-- layerPopup 비밀번호 확인 -->
        <div id="global-pwd-layer" class="layout_layerPopup_A layout_layerPopup_A_password">
            <div class="transparent"></div>
            <div id="layerPopup_password" class="layerPopup_A">
                <h4 class="pop h4_pop_password">비밀번호 확인</h4>
                <!-- 내용 -->
                <div class="cont">
                    <div class="password_pop">
                        <p id="global-password-retry" class="p_tyA_pop point_A hide">비밀번호가 일치하지 않습니다. 다시 입력 해 주시기 바랍니다.</p>
                        <p id="global-password-input" class="p_tyA_pop">작성시 입력한 비밀번호를 입력 해 주세요.</p>
                        <table class="table_datail_AB_pop w_1">
                        <caption>비밀번호 확인</caption>
                        <tbody>
                        <tr>
                            <th scope="row"><label for="global-pwd-field">비밀번호</label></th>
                            <td class="ty_AB ty_B">
                                <input type="password" id="global-pwd-field" autocomplete="off" class="pwd f_150px" title="비밀번호입력"/>
                                <a id="global-password-button" href="#" class="btn_A">확인</a>
                            </td>
                        </tr>
                        </tbody>
                        </table>
                    </div>
                </div>
                <!-- //내용 -->
                <a href="javascript:;" onclick="hidePasswordLayer();" class="btn_close"><span>레이어 팝업 닫기</span></a>
            </div>
        </div>
        <!-- layerPopup 비밀번호 확인 -->
        <script type="text/javascript">
        	function hidePasswordLayer() {
        		$("#global-pwd-layer").removeClass("view");
        		return false;
        	}
	        /**
	         * 작성자를 확인한다.
	         * 
	         * @param tag {String} 태그
	         * @param uid {String} 아이디
	         * @param callback {Function} 콜백
	         * @param data {Object} 데이터
	         */
	        function verifyWriter(tag, uid, callback, data) {
	            switch (tag) {
	                case "Y":
	                    return false;
	                case "U":
	                    alert("게시물 작성자만 조회할 수 있습니다.");
	                    return false;
	                case "P":
	                    if (com.wise.util.isBlank(data.userPw)) {
	                        $("#global-password-button").remove();
	                        
	                        var button = $("<a id=\"global-password-button\" href=\"#\" class=\"btn_A\">확인</a>");
	                        
	                        button.bind("click", {
	                            uid:uid,
	                            callback:callback,
	                            data:data
	                        }, function(event) {
	                            // 비밀번호를 확인한다.
	                            verifyPassword(event.data.uid, event.data.callback, event.data.data);
	                            return false;
	                        });
	                        
	                        button.bind("keydown", {
	                            uid:uid,
	                            callback:callback,
	                            data:data
	                        }, function(event) {
	                            if (event.which == 13) {
	                                // 비밀번호를 확인한다.
	                                verifyPassword(event.data.uid, event.data.callback, event.data.data);
	                                return false;
	                            }
	                        });
	                        
                            $("#global-pwd-field").val("").after(button);
	                        
	                        if (!$("#global-password-retry").hasClass("hide")) {
	                            $("#global-password-retry").addClass("hide");
	                        }
	                        
                            if ($("#global-password-input").hasClass("hide")) {
                                $("#global-password-input").removeClass("hide");
                            }
	                        
	                        if (!$("#global-pwd-layer").hasClass("view")) {
	                            $("#global-pwd-layer").addClass("view");
	                        }
	                        
	                        $("#global-pwd-field").focus();
	                        
	                        return false;
	                    }
	                    else {
	                        return true;
	                    }
	                case "N":
	                    return true;
	            }
	        }
	
	        /**
	         * 비밀번호를 확인한다.
	         * 
	         * @param uid {String} 아이디
	         * @param callback {Function} 콜백
	         * @param data {Object} 데이터
	         */
	        function verifyPassword(uid, callback, data) {
	            var password = $("#global-pwd-field");
	            
	            if (com.wise.util.isBlank(password.val())) {
                    alert("비밀번호를 입력하여 주십시오.");
                    password.focus();
                    return;
                }
                
                var form = $("#" + uid);
                
                var url = "";
	            
	            if (form.find("[name=bbsCd]").length > 0) {
	                url = "/portal/bbs/" + form.find("[name=bbsCd]").val().toLowerCase() + "/verifyPassword.do";
	            }
	            
	            if (url) {
                    // 데이터를 조회한다.
                    doSelect({
                        url:url,
                        before:beforeVerifyPassword(uid, data),
                        after:afterVerifyPassword(uid, callback, data)
                    });
	            }
	            else {
	                // 비밀번호를 확인 후처리를 실행한다.
	                (afterVerifyPassword(uid, callback, data))({
	                    matched:true
	                });
	            }
	        }
	        
	        /**
	         * 비밀번호 확인 전처리를 실행한다.
	         * 
             * @param uid {String} 아이디
             * @param data {Object} 데이터
	         */
	        function beforeVerifyPassword(uid, data) {
	            var form = $("#" + uid);
	            
	            var password = $("#global-pwd-field");

	            return function(options) {
	                return {
	                    bbsCd:data.bbsCd ? data.bbsCd : form.find("[name=bbsCd]").val(),
	                    seq:data.seq ? data.seq : form.find("[name=seq]").val(),
//	                    userPw:password.val()
						bulletIdInfo:encryptByDES(password.val(), bulletIdInfoKey)
	                };
	            };
	        }
	        
            /**
             * 비밀번호를 확인 후처리를 실행한다.
             * 
             * @param uid {String} 아이디
             * @param callback {Function} 콜백
             * @param data {Object} 데이터
             */
	        function afterVerifyPassword(uid, callback, data) {
                var form = $("#" + uid);
                
                var password = $("#global-pwd-field");
                
	            return function(message) {
	                if (message.matched == "true") {
                        if (form.find("userPw").length > 0) {
                            form.find("userPw").val(password.val());
                        }
                        else {
                            var hidden = $("<input type=\"hidden\" name=\"userPw\" />");
                            
                            hidden.val(password.val());
                            
                            form.append(hidden);
                        }
                        
                        var copy = {
                            // Nothing to do.
                        };
                        
                        for (var key in data) {
                            copy[key] = data[key];
                        }
                        
                        copy.userPw = password.val();
                        
                        if ($("#global-pwd-layer").hasClass("view")) {
                            $("#global-pwd-layer").removeClass("view");
                        }
                        
                        password.val("");
                        
                        callback(copy);
	                }
	                else {
                        if (!$("#global-password-input").hasClass("hide")) {
                            $("#global-password-input").addClass("hide");
                        }
                        
                        if ($("#global-password-retry").hasClass("hide")) {
                            $("#global-password-retry").removeClass("hide");
                        }
	                }
	            };
	        }
        </script>
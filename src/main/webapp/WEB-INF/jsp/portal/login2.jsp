<%@page import="egovframework.com.cmm.service.EgovProperties"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="egovframework.common.helper.SSOHelper"%>
<%@page import="egovframework.com.cmm.util.EgovUserDetailsHelper"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- 
/* ================================================================== 
 * @FileTitle    포털 로그인 SSO 처리
 * @ModifyDate   2022.03.04
 * @Version      1.0
 * @Modifier     jhKim
 * @ChangeNote   최초작성
 * =================================================================*/
--%>

<%

System.out.println("NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN");
String mainPage = "/portal/mainPage.do";

boolean isLogin = EgovUserDetailsHelper.isAuthenticatedPortal();
boolean isVerify = false;

//토큰값
String tken = "";

//SSO 쿠키값 획득
Cookie[] ckies = request.getCookies();
if (ckies != null) {
	for (int i = 0; i < ckies.length; i++) {
    	String name = ckies[i].getName();
     	if (name != null && name.equals("ssotoken")) {
        	tken = ckies[i].getValue();
     	}
 	}
}

//쿠키값에 값이 있는경우 토큰 검증
if ( !(tken.equals("")) ) {
	isVerify = SSOHelper.isVerify(tken, request.getRemoteAddr());
}

System.out.println("NNN TOKEN VALUE = " + tken);
System.out.println("NNN SSO VERIFY  = " + isVerify);
System.out.println("NNN IS LOGIN    = " + isLogin);
System.out.println("NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN");

// 토큰값 정상
if ( isVerify ) {
    if ( isLogin ) {
        System.out.println("NNN main.do");
        response.sendRedirect(mainPage);
    }
    else {
    	// 토큰값이 정상인데 로그인이 안되어있는경우 로그인 처리
        System.out.println("NNN checkLogin.do");
    	
        StringBuffer sbUrl = new StringBuffer("/portal/user/loginSSOProc.do");
        
     	// add referer url
        sbUrl.append(getRefererUrlParam(request, "?"));

        response.sendRedirect(sbUrl.toString());
    }
}
else {
    if ( isLogin ) {
		// 토큰이 비정상인데 로그인 되어있는경우 로그아웃 처리
        System.out.println("NNN member logout");
        response.sendRedirect("/portal/user/logout.do");
    }
    else {
    	// 토큰이 비정상인데 로그아웃 되어있는경우 로그인 페이지로 이동
        System.out.println("NNN member login");
        
		/*         
        StringBuffer sbUrl = new StringBuffer("http://member1.assembly.go.kr:8081/login/loginPage.do");
        sbUrl.append("?procUrl=");
        sbUrl.append("http://open2.assembly.go.kr:8882/portal/user/loginSSOProc.do"); 
        */
        StringBuffer sbUrl = new StringBuffer(EgovProperties.getProperty("url.member.main"));
        sbUrl.append("/login/loginPage.do");
        sbUrl.append("?procUrl=");
        sbUrl.append(EgovProperties.getProperty("url.open.main"));
        sbUrl.append("/portal/user/loginSSOProc.do");
        
     	// add referer url
        sbUrl.append(getRefererUrlParam(request, "&"));
     
        response.sendRedirect(sbUrl.toString());
    }
}

%>
<%!
public String getRefererUrlParam(HttpServletRequest request, String prefix) {
	
	StringBuffer sb = new StringBuffer();
	String referUrl = request.getHeader("referer");
	
	if ( StringUtils.isNotEmpty(referUrl) ) {
		sb.append(prefix);
		sb.append("returnUrl=");
		sb.append(referUrl);
    }
	
	System.out.println("#######getRefererUrlParam=" + sb.toString());
	return sb.toString();
}

%>
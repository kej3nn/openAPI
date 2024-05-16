<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="egovframework.common.helper.SSOHelper"%>
<%@page import="egovframework.com.cmm.util.EgovUserDetailsHelper"%>
<%-- 
/* ================================================================== 
 * @FileName  : checkSSO.jsp
 * @FileTitle : 열린국회 SSO 체크
 * @ModifyDate  2022.04.22
 * @Version     1.0
 * @Modifier    jhKim
 * @ChangeNote  최초작성
 * =================================================================*/
--%>
<%

System.out.println("########### SSO CHECKER ############");
//토큰값
String tken = "";

Cookie[] ckies = request.getCookies();
if (ckies != null) {
  for (int i = 0; i < ckies.length; i++) {
      String name = ckies[i].getName();
      if (name != null && name.equals("ssotoken")) {
          tken = ckies[i].getValue();
      }
  }
}

//로그인 여부
Boolean isLogin = EgovUserDetailsHelper.isAuthenticatedPortal();

//SSO 토큰세션 검증여부
Boolean isVerify = false;

System.out.println("# TOKEN = " + tken);
System.out.println("# LOGIN = " + isLogin);

if ( tken.equals("") ) {
	if ( isLogin ) {
		response.sendRedirect("/portal/user/logout.do");
	}
}
else {
	isVerify = SSOHelper.isVerify(tken, request.getRemoteAddr());
	System.out.println("# VRFY = " + isVerify);
	
	if ( isVerify ) {
		if ( !isLogin ) {
			response.sendRedirect("/portal/user/loginSSOProc.do");
		}
	}
	else {
		response.sendRedirect("/portal/user/logout.do");
	}
}
%>
package egovframework.common.util;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

/**
 * FileName    	CookieUtil.java
 * FileTitle    쿠키를 관리하는 유틸
 * ModifyDate	2022.01.03
 * Version		1.0
 * Modifier		JHKIM
 * ChangeNote	최초작성
 */

public class CookieUtil {

    /**
     * 쿠키값을 저장한다.
     */
    public static void setCookie(HttpServletResponse response, String sName, String sValue) {
        Cookie c = new Cookie(sName, sValue);
        c.setPath("/");
//		c.setSecure(true);
//		c.setHttpOnly(true);
        response.addCookie(c);
    }

    /**
     * 쿠키값을 도메인설정하여 저장한다.
     */
    public static void setDomainCookie(HttpServletResponse response, String sName, String sValue, String sDomain) {
        Cookie c = new Cookie(sName, sValue);
        c.setPath("/");
//		c.setSecure(true);
//		c.setHttpOnly(true);
        c.setDomain(sDomain);
        response.addCookie(c);
    }

    /**
     * sName 에 해당되는 쿠키 값을 얻는다.
     */
    public static String getCookie(HttpServletRequest request, String sName) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                String name = cookie.getName();
                if (StringUtils.isNotEmpty(name) && StringUtils.equals(name, sName)) {
                    return cookie.getValue();
                }
            }
        }
        return null;
    }

}

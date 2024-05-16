package egovframework.common.helper;

import java.util.ArrayList;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import WiseAccess.SSO;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.common.util.CookieUtil;

/**
 * FileName    	SSOHelper.java
 * FileTitle    SSO를 지원하는 헬퍼 클래스
 * ModifyDate	2022.03.03
 * Version		1.0
 * Modifier		jhKim
 * ChangeNote	최초작성
 */

@Component
public class SSOHelper {

    /* SSO 관련 환경변수 */
	/*
	public static String TOKEN_NAME = "ssotoken";				// SSO 토큰명
	public static String IP 		= "192.168.90.150";       	// SSO 엔진 IP
	public static int PORT 			= 7000;        				// SSO 엔진 포트
	public static String CHARSET	= "euc-kr";  				// 캐릭터셋
	public static String APIKEY 	= "368B184727E89AB69FAF";   // 엔진이 설치되어있는서버 인증키
	public static String DOMAIN 	= "assembly.go.kr";    		// 쿠키값 설정 도메인 주소
	*/
    public static String TOKEN_NAME = EgovProperties.getProperty("sso.tokenName");    // SSO 토큰명
    public static String IP = EgovProperties.getProperty("sso.ip");        // SSO 엔진 IP
    public static String PORT = EgovProperties.getProperty("sso.port");       // SSO 엔진 포트
    public static String CHARSET = EgovProperties.getProperty("sso.charset");    // 캐릭터셋
    public static String APIKEY = EgovProperties.getProperty("sso.apikey");    // 엔진이 설치되어있는서버 인증키
    public static String DOMAIN = EgovProperties.getProperty("sso.domain");    // 쿠키값 설정 도메인 주소

    /**
     * SSO를 초기화한다.
     */
    public static SSO initSSO() {
        SSO sso = new SSO(APIKEY);
        sso.setHostName(IP);
        sso.setPortNumber(Integer.parseInt(PORT));
        sso.setCharacterSet(CHARSET);
        return sso;
    }

    /**
     * SSO 세션을 생성한다.
     */
    public static int newSession(String uid, String remoteIp, boolean isOverwrite) {
        SSO sso = initSSO();
        int result = -1;
        result = sso.regUserSession(uid, remoteIp, isOverwrite);
        return result;
    }

    /**
     * SSO를 초기화후 세션을 생성한다.
     */
    public static int newSession(SSO sso, String uid, String remoteIp, boolean isOverwrite) {
        int result = -1;
        result = sso.regUserSession(uid, remoteIp, isOverwrite);
        return result;
    }

    /**
     * 정상적인 토큰인지 확인한다.
     */
    public static boolean isVerify(SSO sso, String token, String remoteIp) {
        int result = -1;
        result = sso.verifyToken(token, remoteIp);
        return result >= 0 ? true : false;
    }

    public static boolean isVerify(String token, String remoteIp) {
        SSO sso = SSOHelper.initSSO();
        return isVerify(sso, token, remoteIp);
    }

    /**
     * 쿠키에 들어있는 토큰값을 가져온다.
     */
    public static String getSSOToken(HttpServletRequest request) {
        return StringUtils.defaultString(CookieUtil.getCookie(request, TOKEN_NAME), "");
    }

    /**
     * SSO 쿠키를 등록한다.
     */
    public static void addSSOCookie(HttpServletResponse response, String token) {
        if (StringUtils.isNotBlank(token)) {
            CookieUtil.setDomainCookie(response, TOKEN_NAME, token, DOMAIN);
        }
    }

    /**
     * SSO 세션을 삭제한다
     */
    public static void removeSession(HttpServletResponse response, String token) {
        SSO sso = initSSO();
        sso.unregUserSession(token);
        removeSSOCookie(response);
    }

    /**
     * SSO 쿠키를 삭제한다.
     */
    public static void removeSSOCookie(HttpServletResponse response) {
        CookieUtil.setDomainCookie(response, TOKEN_NAME, "", DOMAIN);
    }

}

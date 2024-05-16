/*
 * @(#)PortalOauthService.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.user.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import egovframework.common.base.model.OauthProvider;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Result;

/**
 * 사용자 인증을 처리하는 서비스 인터페이스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
public interface PortalOauthService {
    /**
     * 제공자를 반환한다.
     * 
     * @param params 파라메터
     * @return 제공자
     */
    public List<OauthProvider> providers(Params params);
    
    /**
     * 인증을 요청한다.
     * 
     * @param params 파라메터
     * @return 요청결과
     */
    public Result authorize(Params params);
    
    /**
     * 리다이렉트를 처리한다.
     * 
     * @param params 파라메터
     * @return 처리결과
     */
    public Result redirectCUD(HttpServletRequest request, Params params);
    
    /**
     * 사용자를 등록한다.
     * 
     * @param params 파라메터
     * @return 처리결과 
     */
    public Result registerCUD(HttpServletRequest request, Params params);
    
    /**
     * 로그아웃을 처리한다.
     * 
     * @param params 파라메터
     * @return 처리결과
     */
    public Result logout(Params params);
}
/*
 * @(#)PortalUserService.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.user.service;

import javax.servlet.http.HttpServletRequest;

import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;

/**
 * 사용자 정보를 관리하는 서비스 인터페이스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
public interface PortalUserService {
	
//	public Result redirectCUD(Params params);
	
//	public boolean redirectSSOCUD(Params params);
	
	public int checkUserLoginProcCUD(HttpServletRequest request, Params params);
	
	public int checkUserSSOLoginProcCUD(HttpServletRequest request, Params params);
	
	public int checkSSOUserLoginProcCUD(Params params);
}
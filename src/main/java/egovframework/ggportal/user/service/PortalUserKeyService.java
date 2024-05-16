/*
 * @(#)PortalUserKeyService.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.user.service;

import java.util.List;

import egovframework.common.base.model.Params;
import egovframework.common.base.model.Result;

/**
 * 사용자 인증키를 관리하는 서비스 인터페이스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
public interface PortalUserKeyService {
	
	/**
	 * 인증키 생성
	 * @param params
	 * @return
	 */
	public Result insertActKeyCUD(Params params);
	
	/**
	 * 인증키 폐기
	 * @param params
	 * @return
	 */
	public Result deleteActKey(Params params);
	
	/**
	 * 인증키 목록 조회
	 * @param params
	 * @return
	 */
	public List<?> searchActKey(Params params);
}
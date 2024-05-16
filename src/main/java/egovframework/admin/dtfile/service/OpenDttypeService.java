/*
 * @(#)OpenDttypeService.java 1.0 2015/06/01
 *
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.admin.dtfile.service;

import java.util.List;

import egovframework.common.base.model.Params;
import egovframework.common.base.model.Result;

/**
 * 데이터 유형을 관리하는 서비스 인터페이스이다.
 *
 * @author 김은삼
 * @version 1.0 2015/06/01
 */
public interface OpenDttypeService {
    /**
     * 데이터 유형을 검색한다.
     *
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenDttype(Params params);

    /**
     * 데이터 유형 옵션을 검색한다.
     *
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenDttypeOpt(Params params);


    /**
     * 데이터 유형을 저장한다.
     *
     * @param params 파라메터
     * @return 저장결과
     */
    public Result saveOpenDttype(Params params);
}
/*
 * @(#)OpenDttypeDao.java 1.0 2015/06/01
 *
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.admin.dtfile.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Params;

/**
 * 데이터 유형을 관리하는 DAO 클래스이다.
 *
 * @author 김은삼
 * @version 1.0 2015/06/01
 */
@Repository("openDttypeDao")
public class OpenDttypeDao extends BaseDao {
    /**
     * 데이터 유형을 검색한다.
     *
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenDttype(Params params) {
        // 데이터 유형을 검색한다.
        return search("OpenDttypeDao.searchOpenDttype", params);
    }

    /**
     * 데이터 유형 옵션을 검색한다.
     *
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenDttypeOpt(Params params) {
        // 데이터 유형 옵션을 검색한다.
        return search("OpenDttypeDao.searchOpenDttypeOpt", params);
    }

    /**
     * 데이터 유형을 등록한다.
     *
     * @param params 파라메터
     */
    public void insertOpenDttype(Params params) {
        // 데이터 유형을 등록한다.
        insert("OpenDttypeDao.insertOpenDttype", params);
    }

    /**
     * 데이터 유형을 수정한다.
     *
     * @param params 파라메터
     */
    public void updateOpenDttype(Params params) {
        // 데이터 유형을 수정한다.
        update("OpenDttypeDao.updateOpenDttype", params);
    }

    /**
     * 데이터 유형을 삭제한다.
     *
     * @param params 파라메터
     */
    public void deleteOpenDttype(Params params) {
        // 데이터 유형을 삭제한다.
        delete("OpenDttypeDao.deleteOpenDttype", params);
    }
}
/*
 * @(#)PortalLogUserDao.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.user.service.impl;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Params;

/**
 * 사용자 로그인 이력을 관리하는 DAO 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Repository("ggportalLogUserDao")
public class PortalLogUserDao extends BaseDao {
    /**
     * 사용자 로그인 이력을 등록한다.
     * 
     * @param params 파라메터
     * @return 등록결과
     */
    public Object insertLogUser(Params params) {
        // 사용자 로그인 이력을 등록한다.
        return insert("PortalLogUserDao.insertLogUser", params);
    }
}
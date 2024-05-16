/*
 * @(#)PortalUserKeyDao.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.user.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 사용자 인증키를 관리하는 DAO 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Repository("ggportalUserKeyDao")
public class PortalUserKeyDao extends BaseDao {
	/**
	 * 정상 상태의 인증키 수 
	 * @param params
	 * @return
	 */
	public Record selectActKeyCnt(Params params) {
		return (Record) select("PortalUserKeyDao.selectActKeyCnt", params);
	}
	
	public Object insertActKey(Params params) {
		return insert("PortalUserKeyDao.insertActKey", params);
	}
	
	public Object deleteActKey(Params params) {
		return insert("PortalUserKeyDao.deleteActKey", params);
	}
	
	public List<?> searchActKey(Params params) {
		return search("PortalUserKeyDao.searchActKey", params);
	}
}
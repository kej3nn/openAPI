/*
 * @(#)PortalOpenInfSrvDao.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.data.service.impl;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 공공데이터 서비스를 관리하는 DAO 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Repository("ggportalOpenInfSrvDao")
public class PortalOpenInfSrvDao extends BaseDao {
    /**
     * 공공데이터 서비스 메타정보를 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectOpenInfSrvMeta(Params params) {
        // 공공데이터 서비스 메타정보를 조회한다.
        return (Record) select("PortalOpenInfSrvDao.selectOpenInfSrvMeta", params);
    }
    
    /**
     * 공공데이터 서비스 조회이력을 등록한다.
     * 
     * @param params 파라메터
     * @return 등록결과
     */
    public Object insertOpenInfSrvHist(Params params) {
        // 공공데이터 서비스 조회이력을 등록한다.
        return insert("PortalOpenInfSrvDao.insertOpenInfSrvHist", params);
    }
    
    /**
     * 공공데이터 서비스 조회수를 수정한다.
     * 
     * @param params 파라메터
     * @return 수정결과
     */
    public int updateOpenInfSrvHits(Params params) {
        // 공공데이터 서비스 조회수를 수정한다.
        return update("PortalOpenInfSrvDao.updateOpenInfSrvHits", params);
    }
    
    /**
     * 공공데이터 서비스 저장이력을 등록한다.
     * 
     * @param params 파라메터
     * @return 등록결과
     */
    public Object insertOpenInfSavHist(Params params) {
        // 공공데이터 서비스 저장이력을 등록한다.
        return insert("PortalOpenInfSrvDao.insertOpenInfSavHist", params);
    }
    
    /**
     * 공공데이터 서비스 평가점수를 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectOpenInfSrvAppr(Params params) {
        // 공공데이터 서비스 평가점수를 조회한다.
        return (Record) select("PortalOpenInfSrvDao.selectOpenInfSrvAppr", params);
    }
    
    /**
     * 공공데이터 서비스 평가점수를 등록한다.
     * 
     * @param params 파라메터
     * @return 등록결과
     */
    public Object insertOpenInfSrvAppr(Params params) {
        // 공공데이터 서비스 평가점수를 등록한다.
        return insert("PortalOpenInfSrvDao.insertOpenInfSrvAppr", params);
    }
    
    /**
     * 공공데이터 서비스 최소 번호를 조회한다.(infSeq가 인자로 넘어오지 않았을경우)
     * @param params
     * @return
     */
	public int selectOpenInfSrvMinInfSeq(Params params) {
		return (Integer)getSqlMapClientTemplate().queryForObject("PortalOpenInfSrvDao.selectOpenInfSrvMinInfSeq", params);
    }
	
	/**
	 * 공공데이터 서비스 API 서비스 번호 조회
	 * @param params
	 * @return
	 */
	public int selectOpenInfSrvApiInfSeq(Params params) {
		return (Integer)getSqlMapClientTemplate().queryForObject("PortalOpenInfSrvDao.selectOpenInfSrvApiInfSeq",params);
	}
}
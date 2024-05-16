package egovframework.portal.doc.service.impl;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 문서관리 서비스를 관리하는 DB 접근 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2018/08/20
 */
@Repository(value="portalDocInfDao")
public class PortalDocInfDao extends BaseDao {

	/**
	 * 문서관리 메타정보 조회
	 */
	public Record selectDocInfMeta(Params params) {
		return (Record) select("portalDocInfDao.selectDocInfMeta", params);
	}
	
	/**
	 * 평가점수 등록
	 */
	public Object insertDocInfAppr(Params params) {
		return insert("portalDocInfDao.insertDocInfAppr", params);
	}
	
	/**
	 * 평가점수 조회
	 */
	public Record selectDocInfAppr(Params params) {
		return (Record) select("portalDocInfDao.selectDocInfAppr", params);
	}
	
	/**
	 * 문서관리 조회 기록 로그생성
	 */
	public Object insertLogDocInf(Params params) {
		return insert("portalDocInfDao.insertLogDocInf", params);
	}

}

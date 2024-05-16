package egovframework.portal.doc.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 문서관리 파일서비스를 관리하는 DB 접근 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2018/08/21
 */
@Repository(value="portalDocInfFileDao")
public class PortalDocInfFileDao extends BaseDao {

	/**
	 * 문서관리 파일 서비스 정보 조회
	 */
	@SuppressWarnings("unchecked")
	public List<Record> searchDocInfFile(Params params) {
		return (List<Record>) list("portalDocInfFileDao.searchDocInfFile", params);
	}
	
	/**
	 * 문서관리 파일 서비스 정보 조회(단건)
	 */
	public Record selectDocInfFile(Params params) {
		return (Record) select("portalDocInfFileDao.selectDocInfFile", params);
	}

	/**
	 * 문서관리 파일서비스 조회 로그 등록
	 */
	public Object insertLogDocInfFile(Params params) {
		return insert("portalDocInfFileDao.insertLogDocInfFile", params);
	}
	
	/**
	 * 문서관리 파일 서비스 조회수 증가
	 */
	public Object updateDocInfFileViewCnt(Params params) {
		return update("portalDocInfFileDao.updateDocInfFileViewCnt", params);
	}
}

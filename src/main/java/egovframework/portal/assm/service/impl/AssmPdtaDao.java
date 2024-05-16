package egovframework.portal.assm.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 국회의원 정책자료&보고서 Dao 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/10/22
 */
@Repository(value="AssmPdtaDao")
public class AssmPdtaDao extends BaseDao {

	/**
	 * 정책자료&보고서 조회 - 페이징
	 */
	Paging searchAssmPdta(Params params, int page, int rows) {
		return search("assmPdtaDao.searchAssmPdta", params, page, rows, PAGING_MANUAL) ;
	}
	
	/**
	 * 정책자료&보고서 조회
	 */
	List<Record> selectAssmPdta(Params params) {
		return (List<Record>) list("assmPdtaDao.searchAssmPdta", params);
	}
	
	/**
	 * 정책자료 조회 - 페이징
	 */
	Paging searchPlcyList(Params params, int page, int rows) {
		return search("assmPdtaDao.searchPlcyList", params, page, rows, PAGING_MANUAL) ;
	}
}

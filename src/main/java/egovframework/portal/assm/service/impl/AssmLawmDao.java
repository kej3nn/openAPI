package egovframework.portal.assm.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 국회의원 입법활동 Dao 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/10/16
 */
@Repository(value="AssmLawmDao")
public class AssmLawmDao extends BaseDao {

	/*
	 * 입법활동 공통코드 조회
	 */
	List<Record> searchAssmLawmCommCd(Params params) {
		return (List<Record>) list("assmLawmDao.searchAssmLawmCommCd", params);
	}
	
	/**
	 * 발의 법률안 조회(대표/공동) - 페이징
	 */
	Paging searchLawmMotnLgsb(Params params, int page, int rows) {
		return search("assmLawmDao.searchLawmMotnLgsb", params, page, rows, PAGING_MANUAL);
	}
	
	/**
	 * 발의 법률안 조회(대표/공동) - 목록
	 */
	List<Record> selectLawmMotnLgsb(Params params) {
		return (List<Record>) list("assmLawmDao.searchLawmMotnLgsb", params);
	}
	
	/**
	 * 표결현황 조회 - 페이징 
	 */
	Paging searchLawmVoteCond(Params params, int page, int rows) {
		return search("assmLawmDao.searchLawmVoteCond", params, page, rows, PAGING_MANUAL);
	}
	
	/**
	 * 표결현황 조회 
	 */
	List<Record> selectLawmVoteCond(Params params) {
		return (List<Record>) list("assmLawmDao.searchLawmVoteCond", params);
	}
	
	/**
	 * 표결현황 결과 카운트
	 */
	Record selectLawmVoteCondResultCnt(Params params) {
		return (Record) select("assmLawmDao.selectLawmVoteCondResultCnt", params);
	}
	
	/**
	 * TreeMap Chart 데이터 조회
	 * @param params
	 * @return
	 */
	public List<Map<String, Object>> searchDegtMotnLgsbTreeMap(Params params) {
		return (List<Map<String, Object>>) list("assmLawmDao.searchDegtMotnLgsbTreeMap", params);
	}
	
	/**
	 * Column Chart 데이터 조회(발의법률안)
	 * @param params
	 * @return
	 */
	public List<Map<String, Object>> searchDegtMotnLgsbColumn(Params params) {
		return (List<Map<String, Object>>) list("assmLawmDao.searchDegtMotnLgsbColumn", params);
	}
	
	/**
	 * 상임위 활동 조회 - 페이징
	 */
	Paging searchLawmSdcmAct(Params params, int page, int rows) {
		return search("assmLawmDao.searchLawmSdcmAct", params, page, rows, PAGING_MANUAL);
	}
	/**
	 * 상임위 활동 조회 
	 */
	List<Record> searchLawmSdcmAct(Params params) {
		return (List<Record>) list("assmLawmDao.searchLawmSdcmAct", params);
	}
	
	
	/**
	 * 연구단체 조회 - 페이징
	 */
	Paging searchLawmRschOrg(Params params, int page, int rows) {
		return search("assmLawmDao.searchLawmRschOrg", params, page, rows, PAGING_MANUAL);
	}
	/**
	 * 연구단체 조회 
	 */
	List<Record> searchLawmRschOrg(Params params) {
		return (List<Record>) list("assmLawmDao.searchLawmRschOrg", params);
	}
	
	/**
	 * 청원 조회 - 페이징
	 */
	Paging searchCombLawmPttnReport(Params params, int page, int rows) {
		return search("assmLawmDao.searchCombLawmPttnReport", params, page, rows, PAGING_MANUAL);
	}
	
	List<Record> searchCombLawmPttnReport(Params params) {
		return (List<Record>) list("assmLawmDao.searchCombLawmPttnReport", params);
	}
	
	/**
	 * 영상회의록 조회 - 페이징
	 */
	Paging searchCombLawmVideoMnts(Params params, int page, int rows) {
		return search("assmLawmDao.searchCombLawmVideoMnts", params, page, rows, PAGING_MANUAL);
	}
	List<Record> selectCombLawmVideoMnts(Params params) {
		return (List<Record>) list("assmLawmDao.searchCombLawmVideoMnts", params);
	}
	
}

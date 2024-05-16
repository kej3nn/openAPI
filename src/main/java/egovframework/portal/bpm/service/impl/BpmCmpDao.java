package egovframework.portal.bpm.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 의정활동 통합현황 - 위원회 구성/계류법안 Dao 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/11/05
 */
@Repository(value="bpmCmpDao")
public class BpmCmpDao extends BaseDao {

	/**
	 * 위원회 종류 조회(코드)
	 */
	List<Record> selectCmpDivCdList(Params params) {
		return (List<Record>) list("bpmCmpDao.selectCmpDivCdList", params);
	}
	
	/**
	 * 위원회명 조회(코드)
	 */
	List<Record> selectCommitteeCdList(Params params) {
		return (List<Record>) list("bpmCmpDao.selectCommitteeCdList", params);
	}
	
	/**
	 * 당명 리스트 조회(교섭단체, 비교섭단체 구분)
	 */
	List<Record> selectPolyGroupList(Params params) {
		return (List<Record>) list("bpmCmpDao.selectPolyGroupList", params);
	}
	
	/**
	 * 위원회 현황 조회 페이징
	 */
	Paging searchCmpCond(Params params, int page, int rows) {
		return search("bpmCmpDao.searchCmpCond", params, page, rows, PAGING_MANUAL);
	}
	/**
	 * 위원회 현황 조회 페이징
	 */
	List<Record> searchCmpCond(Params params) {
		return (List<Record>) list("bpmCmpDao.searchCmpCond", params);
	}
	
	/**
	 * 위원회 명단 조회
	 */
	List<Record> selectCmpList(Params params) {
		return (List<Record>) list("bpmCmpDao.searchCmpList", params);
	}
	/**
	 * 위원회 명단 조회 - 페이징
	 */
	Paging searchCmpList(Params params, int page, int rows) {
		return search("bpmCmpDao.searchCmpList", params, page, rows, PAGING_MANUAL);
	}
	
	/**
	 * 위원회 일정 조회 - 페이징
	 */
	Paging searchCmpDate(Params params, int page, int rows) {
		return search("bpmCmpDao.searchCmpDate", params, page, rows, PAGING_MANUAL);
	}
	
	/**
	 * 위원회 일정 조회 
	 */
	List<Record> searchCmpDate(Params params) {
		return (List<Record>) list("bpmCmpDao.searchCmpDate", params);
	}
	
	/**
	 * 계류의안 조회 페이징
	 */
	Paging searchCmpMoob(Params params, int page, int rows) {
		return search("bpmCmpDao.searchCmpMoob", params, page, rows, PAGING_MANUAL);
	}
	
	/**
	 * 계류의안 조회
	 */
	List<Record> searchCmpMoob(Params params) {
		return (List<Record>) list("bpmCmpDao.searchCmpMoob", params);
	}
	
	/**
	 *  공통코드 조회(의안구분)
	 */
	public List<Record> searchCmpMoobCommCd(Params params) {
		return (List<Record>) list("bpmCmpDao.searchCmpMoobCommCd", params);
	}
	
	/**
	 * 위원회 자료실 조회 페이징
	 */
	Paging searchCmpRefR(Params params, int page, int rows) {
		return search("bpmCmpDao.searchCmpRefR", params, page, rows, PAGING_MANUAL);
	}
	
	/**
	 * 위원회 자료실 조회
	 */
	List<Record> searchCmpRefR(Params params) {
		return (List<Record>) list("bpmCmpDao.searchCmpRefR", params);
	}
	
	/**
	 * 위원회 회의록 조회 페이징
	 */
	Paging searchCmpReport(Params params, int page, int rows) {
		return search("bpmCmpDao.searchCmpReport", params, page, rows, PAGING_MANUAL);
	}
	
	/**
	 * 위원회 회의록 조회
	 */
	List<Record> searchCmpReport(Params params) {
		return (List<Record>) list("bpmCmpDao.searchCmpReport", params);
	}
}

package egovframework.portal.bpm.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 의정활동 통합현황 - 본회의 안건처리 입법활동 Dao 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/11/05
 */
@Repository(value="bpmPrcDao")
public class BpmPrcDao extends BaseDao {

	/**
	 * 본회의 일정 조회 페이징
	 */
	Paging searchPrcDate(Params params, int page, int rows) {
		return search("bpmPrcDao.searchPrcDate", params, page, rows, PAGING_MANUAL);
	}
	
	/**
	 * 본회의 일정 조회
	 */
	List<Record> searchPrcDate(Params params) {
		return (List<Record>) list("bpmPrcDao.searchPrcDate", params);
	}
	
	
	
	/**
	 * 본회의 안건처리 - 법률안, 기타 데이터 조회 페이징
	 */
	Paging searchPrcItmPrcLaw(Params params, int page, int rows) {
		return search("bpmPrcDao.searchPrcItmPrcLaw", params, page, rows, PAGING_MANUAL);
	}
	
	/**
	 * 본회의 안건처리 - 법률안, 기타 데이터 조회
	 */
	List<Record> searchPrcItmPrcLaw(Params params) {
		return (List<Record>) list("bpmPrcDao.searchPrcItmPrcLaw", params);
	}
	
	/**
	 * 본회의 안건처리 - 예산안, 결산 데이터 조회 페이징
	 */
	Paging searchPrcItmPrcBdg(Params params, int page, int rows) {
		return search("bpmPrcDao.searchPrcItmPrcBdg", params, page, rows, PAGING_MANUAL);
	}
	
	/**
	 * 본회의 안건처리 - 예산안, 결산 데이터 조회
	 */
	List<Record> searchPrcItmPrcBdg(Params params) {
		return (List<Record>) list("bpmPrcDao.searchPrcItmPrcBdg", params);
	}
	
	
	
	/**
	 * 본회의 회의록 조회 페이징
	 */
	Paging searchPrcPrcd(Params params, int page, int rows) {
		return search("bpmPrcDao.searchPrcPrcd", params, page, rows, PAGING_MANUAL);
	}
	
	/**
	 * 본회의 회의록 조회
	 */
	List<Record> searchPrcPrcd(Params params) {
		return (List<Record>) list("bpmPrcDao.searchPrcPrcd", params);
	}
}

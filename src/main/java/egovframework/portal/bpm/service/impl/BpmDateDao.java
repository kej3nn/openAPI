package egovframework.portal.bpm.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 의정활동 통합현황 - 날짜별 의정활동공개 Dao 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/11/05
 */
@Repository(value="bpmDateDao")
public class BpmDateDao extends BaseDao {

	/**
	 * 날짜별 의정활동 조회 페이징
	 */
	Paging searchDate(Params params, int page, int rows) {
		return search("bpmDateDao.searchBpmDate", params, page, rows, PAGING_MANUAL);
	}
	
	/**
	 * 날짜별 의정활동 조회
	 */
	List<Record> searchDate(Params params) {
		return (List<Record>) list("bpmDateDao.searchBpmDate", params);
	}
	
	/**
	 * 캘린더 데이터 조회(월단위로)
	 */
	List<Record> searchDateCalendar(Params params) {
		return (List<Record>) list("bpmDateDao.searchDateCalendar", params);
	}
}

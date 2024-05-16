package egovframework.portal.bpm.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 의정활동 통합현황 - 인사청문회 Dao 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/11/05
 */
@Repository(value="bpmCohDao")
public class BpmCohDao extends BaseDao {

	/**
	 * 인사청문회 조회(페이징)
	 */
	Paging searchCoh(Params params, int page, int rows) {
		return search("bpmCohDao.searchCoh", params, page, rows, PAGING_MANUAL);
	}
	
	/**
	 * 인사청문회 조회(목록전체)
	 */
	public List<Record> searchCoh(Params params) {
		return (List<Record>) list("bpmCohDao.searchCoh", params);
	}
}

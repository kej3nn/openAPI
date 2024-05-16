package egovframework.portal.assm.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 국회의원 일정 Dao 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/10/22
 */
@Repository(value="AssmSchdDao")
public class AssmSchdDao extends BaseDao {

	/**
	 * 의원일정 조회 - 페이징
	 */
	Paging searchAssmSchd(Params params, int page, int rows) {
		return search("assmSchdDao.searchAssmSchd", params, page, rows, PAGING_MANUAL);
	}
	
	/**
	 * 의원일정 조회
	 */
	List<Record> selectAssmSchd(Params params) {
		return (List<Record>) list("assmSchdDao.searchAssmSchd", params);
	}
	
}

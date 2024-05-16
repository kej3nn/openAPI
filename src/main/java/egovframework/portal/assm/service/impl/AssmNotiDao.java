package egovframework.portal.assm.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 국회의원 알림 Dao 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/10/22
 */
@Repository(value="AssmNotiDao")
public class AssmNotiDao extends BaseDao {

	/**
	 * 의원실 알림 조회 - 페이징
	 */
	Paging searchAssmNoti(Params params, int page, int rows) {
		return search("assmNotiDao.searchAssmNoti", params, page, rows, PAGING_MANUAL);
	}
	
	/**
	 * 의원실 알림 조회
	 */
	List<Record> selectAssmNoti(Params params) {
		return (List<Record>) list("assmNotiDao.searchAssmNoti", params);
	}
}

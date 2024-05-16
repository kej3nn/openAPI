package egovframework.ggportal.data.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 데이터 시각화 DAO
 * @author hsJang
 *
 */
@Repository("ggportalOpenVisualDao")
public class PortalOpenVisualDao extends BaseDao {

	/**
	 * 데이터시각화 목록
	 * @param params
	 * @param page
	 * @param rows
	 * @return
	 */
	public Paging searchListVisual(Params params, int page, int rows) {
		return search("PortalVisualDao.searchListVisual", params, page, rows, PAGING_MANUAL);
	}
	
	// 2015.09.13 김은삼 [1] 메타정보 조회 SQL 추가 BEGIN
	/**
	 * 데이터 시각화 메타정보를 조회한다.
	 * 
	 * @param params 파라메터
	 * @return 조회결과
	 */
	public Record selectVisualMeta(Params params) {
		// 데이터 시각화 메타정보를 조회한다.
		return (Record) select("PortalVisualDao.selectVisualMeta", params);
	}
	// 2015.09.13 김은삼 [1] 메타정보 조회 SQL 추가 END
	
	/**
	 * 데이터 시각화 상세조회
	 * @param params
	 * @return
	 */
	public Object selectVisualData(Params params) {
		insert("PortalVisualDao.insertVisualLog", params);
		update("PortalVisualDao.updateVisualViewCnt", params);
		return select("PortalVisualDao.selectVisualData", params);
	}
	
}

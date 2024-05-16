package egovframework.admin.stat.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;

@Repository(value="statUsageStateDao")
public class StatUsageStateDao extends BaseDao {

	/**
	 * 통계 활용현황 리스트 조회
	 * @param params
	 * @return
	 */
	public List<?> selectStatUsageState(Params params) {
		return list("statUsageStateDao.selectStatUsageState", params);
	}
	
	/**
	 * 메뉴별 활용현황 리스트 조회
	 * @param params
	 * @return
	 */
	public List<?> selectMenuUsageState(Params params) {
		return list("statUsageStateDao.selectMenuUsageState", params);
	}
	
	/**
	 * 분류별 활용현황 리스트 조회
	 * @param params
	 * @return
	 */
	public List<?> selectCateUsageState(Params params) {
		return list("statUsageStateDao.selectCateUsageState", params);
	}
	
	/**
	 * 통계표별 활용현황 리스트 조회
	 * @param params
	 * @return
	 */
	public List<?> selectStatblUsageState(Params params) {
		return list("statUsageStateDao.selectStatblUsageState", params);
	}
	
	/**
	 * 출처별 활용현황 리스트 조회
	 * @param params
	 * @return
	 */
	public List<?> selectOrgUsageState(Params params) {
		return list("statUsageStateDao.selectOrgUsageState", params);
	}
	
	/**
	 * 사용자별 로그 분석 리스트 조회
	 * @param params
	 * @param page
	 * @param rows
	 * @return
	 */
	public Paging selectUserUsageStateList(Params params, int page, int rows) {
		return search("statUsageStateDao.selectUserUsageStateList", params, page, rows, PAGING_SCROLL);
	}
	
	/**
	 * API 호출 현황 리스트 조회
	 * @param params
	 * @param page
	 * @param rows
	 * @return
	 */
	public Paging selectApiUsageStateList(Params params, int page, int rows) {
		return search("statUsageStateDao.selectApiUsageStateList", params, page, rows, PAGING_SCROLL);
	}
	
	
	@SuppressWarnings("unchecked")
	public List<LinkedHashMap<String,?>> userUsageStatePie(Params params) throws DataAccessException, Exception {
		return (List<LinkedHashMap<String, ?>>) list("statUsageStateDao.userUsageStatePie", params);
	}
	
	@SuppressWarnings("unchecked")
	public List<LinkedHashMap<String,?>> apiUsageStateGraph(Params params) throws DataAccessException, Exception {
		return (List<LinkedHashMap<String, ?>>) list("statUsageStateDao.apiUsageStateGraph", params);
	}
	
}

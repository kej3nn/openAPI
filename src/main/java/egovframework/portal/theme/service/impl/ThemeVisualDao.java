package egovframework.portal.theme.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

@Repository(value="ThemeVisualDao")
public class ThemeVisualDao extends BaseDao {
	
	/**
	 * TreeMap Chart 데이터 조회
	 * @param params
	 * @return
	 */
	public List<Map<String, Object>> selectTreeMapData(Params params) {
		return (List<Map<String, Object>>) list("themeVisualDao.selectTreeMapData", params);
	}
	
	/**
	 * Column Chart 데이터 조회
	 * @param params
	 * @return
	 */
	public List<Map<String, Object>> selectColumnReeleData(Params params) {
		return (List<Map<String, Object>>) list("themeVisualDao.selectColumnReeleData", params);
	}
	
	/**
	 * Pie Chart 데이터 조회
	 * @param params
	 * @return
	 */
	public List<Map<String, Object>> selectPieData(Params params) {
		return (List<Map<String, Object>>) list("themeVisualDao.selectPieData", params);
	}
	
	/**
	 * Column Chart 데이터 조회(연령)
	 * @param params
	 * @return
	 */
	public List<Map<String, Object>> selectColumnAgeData(Params params) {
		return (List<Map<String, Object>>) list("themeVisualDao.selectColumnAgeData", params);
	}
	
	/**
	 * 정당 및 교섭단체 정보 데이터 조회
	 * @param params
	 * @return
	 */
	public List<Map<String, Object>> selectHgNumSeat(Params params) {
		return (List<Map<String, Object>>) list("themeVisualDao.selectHgNumSeat", params);
	}
}

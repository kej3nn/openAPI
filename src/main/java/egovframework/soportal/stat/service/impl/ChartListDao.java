package egovframework.soportal.stat.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Params;

/**
 * 통계표를 관리하는 DAO 클래스
 * @author	소프트온
 * @version 1.0
 * @since   2017/09/22
 */

@Repository(value="chartListDao")
public class ChartListDao extends BaseDao {

	/**
	 * [간편통계/상세분석] 통계표 챠트 > 조건에 따른 항목 및 시계열정보를 조회한다.
	 * @param params 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> easyChartItm(Params params) {
		return (List<Map<String, Object>>) list("chartListDao.easyChartItm", params);
    }

	/**
	 * [간편통계/상세분석] 통계표 챠트를 위한 데이터 조회한다.
	 * @param params 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> easyChartData(Params params) {
		return (List<Map<String, Object>>) list("chartListDao.easyChartData", params);
    }
	
	/**
	 * [복수통계] 통계표 챠트 > 조건에 따른 항목 및 시계열정보를 조회한다.
	 * @param params 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> multiChartItm(Params params) {
		return (List<Map<String, Object>>) list("chartListDao.multiChartItm", params);
    }
	
	/**
	 * [복수통계] 통계표 챠트를 위한 데이터 조회한다.
	 * @param params 
	 * @return
	 */
	public List<?> multiChartJson(Params params) {
		return list("chartListDao.multiChartJson", params);
    }
	
	/**
	 * 통계표 맵를 위한 데이터 조회
	 * @param params 
	 * @return
	 */
	public List<?> statMapJson(Params params) {
		return list("chartListDao.statMapJson", params);
    }

	/**
	 * 통계표 맵를 위한 데이터 조회[통계조회/통계분석]
	 * @param params 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> statMapDataJson(Params params) {
		return (List<Map<String, Object>>) list("chartListDao.statMapDataJson", params);
    }
	
	/**
	 * 통계표 맵를 위한 데이터 조회(조건:자료시점/분류)
	 * @param params 
	 * @return
	 */
	public List<?> statMapJsonDetail(Params params) {
		return list("chartListDao.statMapJsonDetail", params);
	}

}

package egovframework.portal.assm.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 국회의원 차트 Dao 클래스
 * 
 * @author	SBCHOI
 * @version 1.0
 * @since   2019/10/24
 */
@Repository(value="AssmMemberChartDao")
public class AssmMemberChartDao extends BaseDao {
	
	/**
	 * TreeMap Chart 데이터 조회
	 * @param params
	 * @return
	 */
	public List<Map<String, Object>> selectTreeMapData(Params params) {
		return (List<Map<String, Object>>) list("assmMemberChartDao.selectTreeMapData", params);
	}
	
	/**
	 * Column Chart 데이터 조회
	 * @param params
	 * @return
	 */
	public List<Map<String, Object>> selectColumnReeleData(Params params) {
		return (List<Map<String, Object>>) list("assmMemberChartDao.selectColumnReeleData", params);
	}
	
	/**
	 * Pie Chart 데이터 조회
	 * @param params
	 * @return
	 */
	public List<Map<String, Object>> selectPieData(Params params) {
		return (List<Map<String, Object>>) list("assmMemberChartDao.selectPieData", params);
	}
	
	/**
	 * Column Chart 데이터 조회(연령)
	 * @param params
	 * @return
	 */
	public List<Map<String, Object>> selectColumnAgeData(Params params) {
		return (List<Map<String, Object>>) list("assmMemberChartDao.selectColumnAgeData", params);
	}
		
	
}
package egovframework.soportal.stat.service.impl;

import java.util.List;
import java.util.Map;

import org.jasypt.commons.CommonUtils;
import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 통계표를 관리하는 DAO 클래스
 * @author	소프트온
 * @version 1.0
 * @since   2017/09/22
 */

@Repository(value="themeListDao")
public class ThemeListDao extends BaseDao {

	/**
	 * 테마통계 한눈에보는주택금융 리스트 조회
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> statThemeLookList(Params params) {
		return (List<Map<String, Object>>) list("themeListDao.statThemeLookList", params);
    }

	/**
	 * 테마통계 한눈에보는주택금융 리스트 조회 > 데이터 포함
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> statThemeLookListAddData(Params params) {
		return (Map<String, Object>) select("themeListDao.statThemeLookListAddData", params);
    }

	
	/**
	 * 주택금융지수 - 외부자료 호출용
	 * @param params 
	 * @return
	 */
	public List<?> statExtDataJson(Params params) {
		return list("themeListDao.statExtDataJson", params);
    }
	
}

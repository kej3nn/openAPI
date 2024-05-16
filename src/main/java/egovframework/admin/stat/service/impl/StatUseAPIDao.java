package egovframework.admin.stat.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.admin.stat.service.StatUseAPI;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("StatUseAPIDao")
public class StatUseAPIDao extends EgovComAbstractDAO{
	
	/**
	 * 활용 통계 Chart형 자료에서 시리즈 목록을 조회한다.
	 * @param model
	 * @param StatUse
	 * @return List<StatUse>
	 * @throws DataAccessException, Exception
	 */
	@SuppressWarnings("unchecked")
	public List<StatUseAPI> getUseAPISeriesResult(StatUseAPI statUseAPI) throws DataAccessException, Exception {
		return (List<StatUseAPI>) list("StatUseAPIDao.getUseAPISeriesResult", statUseAPI);
	}

	/**
	 * API 성능현황 통계 Sheet형 자료를 조회한다.
	 * @param model
	 * @param StatUse
	 * @return List<StatUse>
	 * @throws DataAccessException, Exception
	 */
	@SuppressWarnings("unchecked")
	public List<StatUseAPI> getUseFBStatSheetAll(StatUseAPI statUseAPI) throws DataAccessException, Exception {
		return (List<StatUseAPI>) list("StatUseAPIDao.getUseAPIStatSheetAll",statUseAPI);
	}
	
	/**
	 * API 성능현황 통계 Chart형 자료에서 X축 데이터를 조회한다.
	 * @param model
	 * @param StatUse
	 * @return List<LinkedHashMap<String,?>>
	 * @throws DataAccessException, Exception
	 */
	@SuppressWarnings("unchecked")
	public List<LinkedHashMap<String,?>> getChartDataX(StatUseAPI statUseAPI) throws DataAccessException, Exception {
		return (List<LinkedHashMap<String, ?>>) list("StatUseAPIDao.getChartDataX", statUseAPI);
	}
	
	/**
	 * API 성능현황 통계 Chart형 자료에서 Y축 데이터를 조회한다.
	 * @param model
	 * @param StatUse
	 * @return List<LinkedHashMap<String,?>>
	 * @throws DataAccessException, Exception
	 */
	@SuppressWarnings("unchecked")
	public List<LinkedHashMap<String,?>> getChartDataY(StatUseAPI statUseAPI) throws DataAccessException, Exception {
		return (List<LinkedHashMap<String, ?>>) list("StatUseAPIDao.getChartDataY", statUseAPI);
	}

		
	
}

package egovframework.admin.stat.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.admin.stat.service.StatUseFB;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("StatUseFBDao")
public class StatUseFBDao extends EgovComAbstractDAO{
	
	/**
	 * 활용 통계 Chart형 자료에서 시리즈 목록을 조회한다.
	 * @param model
	 * @param StatUse
	 * @return List<StatUse>
	 * @throws DataAccessException, Exception
	 */
	@SuppressWarnings("unchecked")
	public List<StatUseFB> getUseFBSeriesResult(StatUseFB statUseFB) throws DataAccessException, Exception {
		return (List<StatUseFB>) list("StatUseFBDao.getUseFBSeriesResult", statUseFB);
	}

	/**
	 * 분류별 활용 통계 Sheet형 자료를 조회한다.
	 * @param model
	 * @param StatUse
	 * @return List<StatUse>
	 * @throws DataAccessException, Exception
	 */
	@SuppressWarnings("unchecked")
	public List<StatUseFB> getUseFBStatSheetAll(StatUseFB statUseFB) throws DataAccessException, Exception {
		return (List<StatUseFB>) list("StatUseFBDao.getUseFBStatSheetAll",statUseFB);
	}
	
	/**
	 * 분류별 활용 통계 Chart형 자료에서 X축 데이터를 조회한다.
	 * @param model
	 * @param StatUse
	 * @return List<LinkedHashMap<String,?>>
	 * @throws DataAccessException, Exception
	 */
	@SuppressWarnings("unchecked")
	public List<LinkedHashMap<String,?>> getChartDataX(StatUseFB statUseFB) throws DataAccessException, Exception {
		return (List<LinkedHashMap<String, ?>>) list("StatUseFBDao.getChartDataX", statUseFB);
	}
	
	/**
	 * 분류별 개방 통계 Chart형 자료에서 Y축 데이터를 조회한다.
	 * @param model
	 * @param StatUse
	 * @return List<LinkedHashMap<String,?>>
	 * @throws DataAccessException, Exception
	 */
	@SuppressWarnings("unchecked")
	public List<LinkedHashMap<String,?>> getChartDataY(StatUseFB statUseFB) throws DataAccessException, Exception {
		return (List<LinkedHashMap<String, ?>>) list("StatUseFBDao.getChartDataY", statUseFB);
	}

		
	
}

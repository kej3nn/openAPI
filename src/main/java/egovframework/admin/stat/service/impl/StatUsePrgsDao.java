package egovframework.admin.stat.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.admin.stat.service.StatUse;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("StatUsePrgsDao")
public class StatUsePrgsDao extends EgovComAbstractDAO{
	
	/**
	 * 활용 추이 통계 일,월,년 Chart형 자료에서 시리즈 목록을 조회한다.
	 * @param model
	 * @param StatOpen
	 * @return List<StatOpen>
	 * @throws DataAccessException, Exception
	 */
	@SuppressWarnings("unchecked")
	public List<StatUse> getUsePrgsSeriesResult(StatUse statUse) throws DataAccessException, Exception {
		return (List<StatUse>) list("StatUsePrgsDao.getUsePrgsSeriesResult", statUse);
	}

	/**
	 * 활용 추이 Sheet형 자료를 조회한다.
	 * @param model
	 * @param StatOpen
	 * @return List<StatOpen>
	 * @throws DataAccessException, Exception
	 */
	@SuppressWarnings("unchecked")
	public List<StatUse> getUseStatPrgsSheetAll(StatUse statUse) throws DataAccessException, Exception {
		return (List<StatUse>) list("StatUsePrgsDao.getUseStatPrgsSheetAll",statUse);
	}
	
	/**
	 * 활용 추이 Chart형 자료에서 X축 데이터를 조회한다.
	 * @param model
	 * @param StatOpen
	 * @return List<LinkedHashMap<String,?>>
	 * @throws DataAccessException, Exception
	 */
	@SuppressWarnings("unchecked")
	public List<LinkedHashMap<String,?>> getChartDataX(StatUse statUse) throws DataAccessException, Exception {
		return (List<LinkedHashMap<String, ?>>) list("StatUsePrgsDao.getChartDataX", statUse);
	}
	
	/**
	 * 활용 추이 Chart형 자료에서 Y축 데이터를 조회한다.
	 * @param model
	 * @param StatOpen
	 * @return List<LinkedHashMap<String,?>>
	 * @throws DataAccessException, Exception
	 */
	@SuppressWarnings("unchecked")
	public List<LinkedHashMap<String,?>> getChartDataY(StatUse statUse) throws DataAccessException, Exception {
		return (List<LinkedHashMap<String, ?>>) list("StatUsePrgsDao.getChartDataY", statUse);
	}
	
		
}

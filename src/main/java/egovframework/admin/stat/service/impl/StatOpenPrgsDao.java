package egovframework.admin.stat.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.admin.stat.service.StatOpen;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("StatOpenPrgsDao")
public class StatOpenPrgsDao extends EgovComAbstractDAO{
	
	/**
	 * 개방 추이 일,월,년 Chart형 자료에서 시리즈 목록을 조회한다.
	 * @param model
	 * @param StatOpen
	 * @return List<StatOpen>
	 * @throws DataAccessException, Exception
	 */
	@SuppressWarnings("unchecked")
	public List<StatOpen> getOpenPrgsSeriesResult(StatOpen statOpen) throws DataAccessException, Exception {
		return (List<StatOpen>) list("StatOpenPrgsDao.getOpenPrgsSeriesResult", statOpen);
	}

	/**
	 * 개방 추이 Sheet형 자료를 조회한다.
	 * @param model
	 * @param StatOpen
	 * @return List<StatOpen>
	 * @throws DataAccessException, Exception
	 */
	@SuppressWarnings("unchecked")
	public List<StatOpen> getOpenStatPrgsSheetAll(StatOpen statOpen) throws DataAccessException, Exception{
		return (List<StatOpen>) list("StatOpenPrgsDao.getOpenStatPrgsSheetAll",statOpen);
	}
	
	/**
	 * 개방 추이 Chart형 자료에서 X축 데이터를 조회한다.
	 * @param model
	 * @param StatOpen
	 * @return List<LinkedHashMap<String,?>>
	 * @throws DataAccessException, Exception
	 */
	@SuppressWarnings("unchecked")
	public List<LinkedHashMap<String,?>> getChartDataX(StatOpen statOpen) throws DataAccessException, Exception {
		return (List<LinkedHashMap<String, ?>>) list("StatOpenPrgsDao.getChartDataX", statOpen);
	}
	
	/**
	 * 개방 추이 Chart형 자료에서 Y축 데이터를 조회한다.
	 * @param model
	 * @param StatOpen
	 * @return List<LinkedHashMap<String,?>>
	 * @throws DataAccessException, Exception
	 */
	@SuppressWarnings("unchecked")
	public List<LinkedHashMap<String,?>> getChartDataY(StatOpen statOpen) throws DataAccessException, Exception {
		return (List<LinkedHashMap<String, ?>>) list("StatOpenPrgsDao.getChartDataY", statOpen);
	}
	
		
}

package egovframework.admin.stat.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.admin.stat.service.StatOpen;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("StatOpenDao")
public class StatOpenDao extends EgovComAbstractDAO{
	
	/**
	 * 개방 통계 Chart형 자료에서 시리즈 목록을 조회한다.
	 * @param model
	 * @param StatOpen
	 * @return List<StatOpen>
	 * @throws DataAccessException, Exception
	 */
	@SuppressWarnings("unchecked")
	public List<StatOpen> getOpenSeriesResult(StatOpen statOpen) throws DataAccessException, Exception {
		return (List<StatOpen>) list("StatOpenDao.getOpenSeriesResult", statOpen);
	}

	/**
	 * 분류별 개방 통계 Sheet형 자료를 조회한다.
	 * @param model
	 * @param StatOpen
	 * @return List<StatOpen>
	 * @throws DataAccessException, Exception
	 */
	@SuppressWarnings("unchecked")
	public List<StatOpen> getOpenStatCateSheetAll(StatOpen statOpen) throws DataAccessException, Exception {
		return (List<StatOpen>) list("StatOpenDao.getOpenStatCateSheetAll",statOpen);
	}
	
	/**
	 * 분류별 개방 통계 Chart형 자료에서 X축 데이터를 조회한다.
	 * @param model
	 * @param StatOpen
	 * @return List<LinkedHashMap<String,?>>
	 * @throws DataAccessException, Exception
	 */
	@SuppressWarnings("unchecked")
	public List<LinkedHashMap<String,?>> getCateChartDataX(StatOpen statOpen) throws DataAccessException, Exception {
		return (List<LinkedHashMap<String, ?>>) list("StatOpenDao.getCateChartDataX", statOpen);
	}
	
	/**
	 * 분류별 개방 통계 Chart형 자료에서 Y축 데이터를 조회한다.
	 * @param model
	 * @param StatOpen
	 * @return List<LinkedHashMap<String,?>>
	 * @throws DataAccessException, Exception
	 */
	@SuppressWarnings("unchecked")
	public List<LinkedHashMap<String,?>> getCateChartDataY(StatOpen statOpen) throws DataAccessException, Exception {
		return (List<LinkedHashMap<String, ?>>) list("StatOpenDao.getCateChartDataY", statOpen);
	}
	
	/**
	 * 기관별 개방 통계 Sheet형 자료를 조회한다.
	 * @param model
	 * @param StatOpen
	 * @return List<StatOpen>
	 * @throws DataAccessException, Exception
	 */
	@SuppressWarnings("unchecked")
	public List<StatOpen> getOpenStatOrgSheetAll(StatOpen statOpen) throws DataAccessException, Exception {
		return (List<StatOpen>) list("StatOpenDao.getOpenStatOrgSheetAll",statOpen);
	}
	
	/**
	 * 기관별 개방 통계 Chart형 자료에서 X축 데이터를 조회한다.
	 * @param model
	 * @param StatOpen
	 * @return List<LinkedHashMap<String,?>>
	 * @throws DataAccessException, Exception
	 */
	@SuppressWarnings("unchecked")
	public List<LinkedHashMap<String,?>> getOrgChartDataX(StatOpen statOpen) throws DataAccessException, Exception {
		return (List<LinkedHashMap<String, ?>>) list("StatOpenDao.getOrgChartDataX", statOpen);
	}
	
	/**
	 * 기관별 개방 통계 Chart형 자료에서 Y축 데이터를 조회한다.
	 * @param model
	 * @param StatOpen
	 * @return List<LinkedHashMap<String,?>>
	 * @throws DataAccessException, Exception
	 */
	@SuppressWarnings("unchecked")
	public List<LinkedHashMap<String,?>> getOrgChartDataY(StatOpen statOpen) throws DataAccessException, Exception {
		return (List<LinkedHashMap<String, ?>>) list("StatOpenDao.getOrgChartDataY", statOpen);
	}
	
	/**
	 * 보유데이터별 개방 통계 Sheet형 자료를 조회한다.
	 * @param model
	 * @param StatOpen
	 * @return List<StatOpen>
	 * @throws DataAccessException, Exception
	 */
	@SuppressWarnings("unchecked")
	public List<StatOpen> getOpenStatDtSheetAll(StatOpen statOpen) throws DataAccessException, Exception  {
		return (List<StatOpen>) list("StatOpenDao.getOpenStatDtSheetAll",statOpen);
	}
	
	/**
	 * 보유데이터별 개방 통계 Chart형 자료에서 X축 데이터를 조회한다.
	 * @param model
	 * @param StatOpen
	 * @return List<LinkedHashMap<String,?>>
	 * @throws DataAccessException, Exception
	 */
	@SuppressWarnings("unchecked")
	public List<LinkedHashMap<String,?>> getDtChartDataX(StatOpen statOpen) throws DataAccessException, Exception {
		return (List<LinkedHashMap<String, ?>>) list("StatOpenDao.getDtChartDataX", statOpen);
	}
	
	/**
	 * 보유데이터별 개방 통계 Chart형 자료에서 Y축 데이터를 조회한다.
	 * @param model
	 * @param StatOpen
	 * @return List<LinkedHashMap<String,?>>
	 * @throws DataAccessException, Exception
	 */
	@SuppressWarnings("unchecked")
	public List<LinkedHashMap<String,?>> getDtChartDataY(StatOpen statOpen) throws DataAccessException, Exception {
		return (List<LinkedHashMap<String, ?>>) list("StatOpenDao.getDtChartDataY", statOpen);
	}
	
}

package egovframework.admin.stat.service.impl;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.admin.stat.service.StatUse;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("StatUseDao")
public class StatUseDao extends EgovComAbstractDAO{
	
	/**
	 * 활용 통계 Chart형 자료에서 시리즈 목록을 조회한다.
	 * @param model
	 * @param StatUse
	 * @return List<StatUse>
	 * @throws DataAccessException, Exception
	 */
	@SuppressWarnings("unchecked")
	public List<StatUse> getUseSeriesResult(StatUse statUse) throws DataAccessException, Exception {
		return (List<StatUse>) list("StatUseDao.getUseSeriesResult", statUse);
	}

	/**
	 * 분류별 활용 통계 Sheet형 자료를 조회한다.
	 * @param model
	 * @param StatUse
	 * @return List<StatUse>
	 * @throws DataAccessException, Exception
	 */
	@SuppressWarnings("unchecked")
	public List<StatUse> getUseStatCateSheetAll(StatUse statUse) throws DataAccessException, Exception {
		return (List<StatUse>) list("StatUseDao.getUseStatCateSheetAll",statUse);
	}
	
	/**
	 * 분류별 활용 통계 Chart형 자료에서 X축 데이터를 조회한다.
	 * @param model
	 * @param StatUse
	 * @return List<LinkedHashMap<String,?>>
	 * @throws DataAccessException, Exception
	 */
	@SuppressWarnings("unchecked")
	public List<LinkedHashMap<String,?>> getCateChartDataX(StatUse statUse) throws DataAccessException, Exception {
		return (List<LinkedHashMap<String, ?>>) list("StatUseDao.getCateChartDataX", statUse);
	}
	
	/**
	 * 분류별 개방 통계 Chart형 자료에서 Y축 데이터를 조회한다.
	 * @param model
	 * @param StatUse
	 * @return List<LinkedHashMap<String,?>>
	 * @throws DataAccessException, Exception
	 */
	@SuppressWarnings("unchecked")
	public List<LinkedHashMap<String,?>> getCateChartDataY(StatUse statUse) throws DataAccessException, Exception {
		return (List<LinkedHashMap<String, ?>>) list("StatUseDao.getCateChartDataY", statUse);
	}

	/**
	 * 기관별 활용 통계 Sheet형 자료를 조회한다.
	 * @param model
	 * @param StatUse
	 * @return List<StatUse>
	 * @throws DataAccessException, Exception
	 */
	@SuppressWarnings("unchecked")
	public List<StatUse> getUseStatOrgSheetAll(StatUse statUse) throws DataAccessException, Exception {
		return (List<StatUse>) list("StatUseDao.getUseStatOrgSheetAll",statUse);
	}
	
	/**
	 * 기관별 활용 통계 Chart형 자료에서 X축 데이터를 조회한다.
	 * @param model
	 * @param StatUse
	 * @return List<LinkedHashMap<String,?>>
	 * @throws DataAccessException, Exception
	 */
	@SuppressWarnings("unchecked")
	public List<LinkedHashMap<String,?>> getOrgChartDataX(StatUse statUse) throws DataAccessException, Exception {
		return (List<LinkedHashMap<String, ?>>) list("StatUseDao.getOrgChartDataX", statUse);
	}
	
	/**
	 * 기관별 개방 통계 Chart형 자료에서 Y축 데이터를 조회한다.
	 * @param model
	 * @param StatUse
	 * @return List<LinkedHashMap<String,?>>
	 * @throws DataAccessException, Exception
	 */
	@SuppressWarnings("unchecked")
	public List<LinkedHashMap<String,?>> getOrgChartDataY(StatUse statUse) throws DataAccessException, Exception {
		return (List<LinkedHashMap<String, ?>>) list("StatUseDao.getOrgChartDataY", statUse);
	}
	
	/**
	 * 보유데이터별 활용 통계 Sheet형 자료를 조회한다.
	 * @param model
	 * @param StatUse
	 * @return List<StatUse>
	 * @throws DataAccessException, Exception
	 */
	@SuppressWarnings("unchecked")
	public List<StatUse> getUseStatDtSheetAll(StatUse statUse) throws DataAccessException, Exception {
		return (List<StatUse>) list("StatUseDao.getUseStatDtSheetAll",statUse);
	}
	
	/**
	 * 보유데이터별 활용 통계 Chart형 자료에서 X축 데이터를 조회한다.
	 * @param model
	 * @param StatUse
	 * @return List<LinkedHashMap<String,?>>
	 * @throws DataAccessException, Exception
	 */
	@SuppressWarnings("unchecked")
	public List<LinkedHashMap<String,?>> getDtChartDataX(StatUse statUse) throws DataAccessException, Exception {
		return (List<LinkedHashMap<String, ?>>) list("StatUseDao.getDtChartDataX", statUse);
	}
	
	/**
	 * 보유데이터별 개방 통계 Chart형 자료에서 Y축 데이터를 조회한다.
	 * @param model
	 * @param StatUse
	 * @return List<LinkedHashMap<String,?>>
	 * @throws DataAccessException, Exception
	 */
	@SuppressWarnings("unchecked")
	public List<LinkedHashMap<String,?>> getDtChartDataY(StatUse statUse) throws DataAccessException, Exception {
		return (List<LinkedHashMap<String, ?>>) list("StatUseDao.getDtChartDataY", statUse);
	}
	
	/**
	 * 데이터셋별 활용 현황
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getUseStatDatasetSheetAll(StatUse param) throws DataAccessException, Exception  {
		return (List<Map<String, Object>>) list("StatUseDao.getUseStatDatasetSheetAll", param);
	}
	
	/**
	 * 소분류별 조회 수
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<LinkedHashMap<String,?>> getUseStatDatasetSheetCnt(StatUse statUse) throws DataAccessException, Exception {
		return (List<LinkedHashMap<String, ?>>) list("StatUseDao.getUseStatDatasetSheetCnt", statUse);
	}
	
	/**
	 * 인증키 활용 현황
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getActKeySheetAll(StatUse param) throws DataAccessException, Exception  {
		return (List<Map<String, Object>>) list("StatUseDao.getActKeySheetAll", param);
	}
	
}

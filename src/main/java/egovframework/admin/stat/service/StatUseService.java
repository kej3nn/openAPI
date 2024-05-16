package egovframework.admin.stat.service;

import java.util.List;
import java.util.Map;

public interface StatUseService {
	/**
	 * 분류별 활용 통계 Sheet형 자료 조회한다.
	 * 
	 * @param StatUse
	 * @return List<StatUse>
	 * @throws Exception
	 */
	public List<StatUse> getUseStatCateSheetAll(StatUse statUse);
	
	/**
	 * 분류별 활용 통계 Chart형 자료 조회한다.
	 * @param model
	 * @param StatOUse
	 * @return Map<String, Object>
	 * @throws Exception
	 */
	public Map<String, Object> getUseStatCateChartAll(StatUse statUse);
	
	/**
	 * 기관별 활용 통계 Sheet형 자료 조회한디.
	 * 
	 * @param StatUse
	 * @return List<StatUse>
	 * @throws Exception
	 */
	public List<StatUse> getUseStatOrgSheetAll(StatUse statUse);
	
	/**
	 * 기관별 활용 통계 Chart형 자료 조회한다.
	 * @param model
	 * @param StatOUse
	 * @return Map<String, Object>
	 * @throws Exception
	 */
	public Map<String, Object> getUseStatOrgChartAll(StatUse statUse);
	
	/**
	 * 보유데이터별 활용 통계 Sheet형 자료 조회한디.
	 * 
	 * @param StatUse
	 * @return List<StatUse>
	 * @throws Exception
	 */
	public List<StatUse> getUseStatDtSheetAll(StatUse statUse);
	
	/**
	 * 보유데이터별 활용 통계 Chart형 자료 조회한다.
	 * @param model
	 * @param StatOUse
	 * @return Map<String, Object>
	 * @throws Exception
	 */
	public Map<String, Object> getUseStatDtChartAll(StatUse statUse);
	
	/**
	 * 데이터셋별 활용 현황
	 * @param statUse
	 * @return
	 */
	public List<Map<String, Object>> getUseStatDatasetSheetAll(StatUse param);
	
	
	/**
	 * 인증키 활용 현황
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> getActKeySheetAll(StatUse param);
}

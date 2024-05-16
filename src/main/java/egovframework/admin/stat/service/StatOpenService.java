package egovframework.admin.stat.service;

import java.util.List;
import java.util.Map;

public interface StatOpenService {
	
	/**
	 * 분류별 개방 통계 Sheet형 자료 조회한다.
	 * 
	 * @param StatOpen
	 * @return List<StatOpen>
	 * @throws Exception
	 */
	public List<StatOpen> getOpenStatCateSheetAll(StatOpen statOpen);
	
	/**
	 * 분류별 개방 통계 Chart형 자료 조회한다.
	 * @param model
	 * @param StatOpen
	 * @return Map<String, Object>
	 * @throws Exception
	 */
	public Map<String, Object> getOpenStatCateChartAll(StatOpen statOpen);
	
	/**
	 * 기관별 개방 통계 Sheet형 자료 조회한디.
	 * 
	 * @param StatOpen
	 * @return List<StatOpen>
	 * @throws Exception
	 */
	public List<StatOpen> getOpenStatOrgSheetAll(StatOpen statOpen);
	
	/**
	 * 기관별 개방 통계 Chart형 자료 조회한다.
	 * @param model
	 * @param StatOpen
	 * @return Map<String, Object>
	 * @throws Exception
	 */
	public Map<String, Object> getOpenStatOrgChartAll(StatOpen statOpen);
	
	/**
	 * 보유데이터별 개방 통계 Sheet형 자료 조회한디.
	 * 
	 * @param StatOpen
	 * @return List<StatOpen>
	 * @throws Exception
	 */
	public List<StatOpen> getOpenStatDtSheetAll(StatOpen statOpen);
	
	/**
	 * 보유데이터별 개방 통계 Chart형 자료 조회한다.
	 * @param model
	 * @param StatOpen
	 * @return Map<String, Object>
	 * @throws Exception
	 */
	public Map<String, Object> getOpenStatDtChartAll(StatOpen statOpen);
	
}

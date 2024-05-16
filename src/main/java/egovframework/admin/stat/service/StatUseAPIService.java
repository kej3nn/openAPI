package egovframework.admin.stat.service;

import java.util.List;
import java.util.Map;

public interface StatUseAPIService {
	/**
	 * API 성능현황 통계 Sheet형 자료 조회한디.
	 * 
	 * @param StatUseAPI
	 * @return List<StatUseAPI>
	 * @throws Exception
	 */
	public List<StatUseAPI> getUseAPIStatSheetAll(StatUseAPI statUseAPI);
	
	/**
	 * API 성능현황 통계 Chart형 자료 조회한다.
	 * @param model
	 * @param StatUseAPI
	 * @return Map<String, Object>
	 * @throws Exception
	 */
	public Map<String, Object> getUseAPIStatChartAll(StatUseAPI statUseAPI);
	
		
}

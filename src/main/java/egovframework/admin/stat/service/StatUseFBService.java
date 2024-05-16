package egovframework.admin.stat.service;

import java.util.List;
import java.util.Map;

public interface StatUseFBService {
	/**
	 * 분류별 활용 통계 Sheet형 자료 조회한디.
	 * 
	 * @param StatUse
	 * @return List<StatUse>
	 * @throws Exception
	 */
	public List<StatUseFB> getUseFBStatSheetAll(StatUseFB statUseFB);
	
	/**
	 * 분류별 활용 통계 Chart형 자료 조회한다.
	 * @param model
	 * @param StatOUse
	 * @return Map<String, Object>
	 * @throws Exception
	 */
	public Map<String, Object> getUseFBStatChartAll(StatUseFB statUseFB);
	
		
}

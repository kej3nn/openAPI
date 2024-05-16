package egovframework.admin.stat.service;

import java.util.List;
import java.util.Map;

public interface StatUsePrgsService {
	
	/**
	 * 활용 추이 통계 Sheet형 자료 조회한다.
	 * 
	 * @param StatOpen
	 * @return List<StatOpen>
	 * @throws Exception
	 */
	public List<StatUse> getUseStatPrgsSheetAll(StatUse statUse);
	
	/**
	 * 활용 추이 통계 Chart형 자료 조회한다.
	 * @param model
	 * @param StatOpen
	 * @return Map<String, Object>
	 * @throws Exception
	 */
	public Map<String, Object> getUseStatPrgsChartAll(StatUse statUse);
	
}

package egovframework.admin.stat.service;

import java.util.List;

public interface StatUseAppService {
	/**
	 * 활용성평가 Sheet형 자료 조회한다.
	 * 
	 * @param StatUseApp
	 * @return List<StatUseApp>
	 * @throws Exception
	 */
	public List<StatUseApp> getUseAppStatSheetAll(StatUseApp statUseApp);
	
	
}

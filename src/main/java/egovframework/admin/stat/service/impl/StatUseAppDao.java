package egovframework.admin.stat.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.admin.stat.service.StatUseApp;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("StatUseAppDao")
public class StatUseAppDao extends EgovComAbstractDAO{
	

	/**
	 * 활용성평가 Sheet형 자료 조회한다.
	 * @param model
	 * @param StatUseApp
	 * @return List<StatUseApp>
	 * @throws DataAccessException, Exception
	 */
	@SuppressWarnings("unchecked")
	public List<StatUseApp> getUseAppStatSheetAll(StatUseApp statUseApp){
		return (List<StatUseApp>) list("StatUseAppDao.getUseAppStatSheetAll",statUseApp);
	}
	
		
	
}

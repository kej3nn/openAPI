package egovframework.admin.stat.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import egovframework.admin.stat.service.StatUseApp;
import egovframework.admin.stat.service.StatUseAppService;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import lombok.NonNull;

@Service("StatUseAppService")
public class StatUseAppServiceImpl extends AbstractServiceImpl implements	StatUseAppService {

	@Resource(name = "StatUseAppDao")
	private StatUseAppDao statUseAppDao;
	
	/**
	 * 활용성평가 Sheet형 자료 조회한다.
	 * 
	 * @param statUseApp
	 * @return List<StatUseApp>
	 * @throws Exception
	 */
	@Override
	public List<StatUseApp> getUseAppStatSheetAll(@NonNull StatUseApp statUseApp) {
		statUseApp.setPubDttmFrom(StringUtils.defaultString(statUseApp.getPubDttmFrom()).replaceAll("-", ""));
		statUseApp.setPubDttmTo(StringUtils.defaultString(statUseApp.getPubDttmTo()).replaceAll("-", ""));
		return statUseAppDao.getUseAppStatSheetAll(statUseApp);
	}

		

}

package egovframework.portal.bpm.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.service.BaseService;
import egovframework.portal.bpm.service.BpmCohService;

/**
 * 의정활동 통합현황 - 인사청문회 서비스 구현 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/11/05
 */
@Service(value="bpmCohService")
public class BpmCohServiceImpl extends BaseService implements BpmCohService {

	@Resource(name="bpmCohDao")
	private BpmCohDao bpmCohDao;
	
	/**
	 * 인사청문회 조회
	 */
	@Override
	public Paging searchCoh(Params params) {
		return bpmCohDao.searchCoh(params, params.getPage(), params.getRows());
	}
}

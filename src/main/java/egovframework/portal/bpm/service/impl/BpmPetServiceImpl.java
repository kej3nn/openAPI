package egovframework.portal.bpm.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.service.BaseService;
import egovframework.portal.bpm.service.BpmPetService;

/**
 * 의정활동 통합현황 - 청원 서비스 구현 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/11/05
 */
@Service(value="bpmPetService")
public class BpmPetServiceImpl extends BaseService implements BpmPetService {

	@Resource(name="bpmPetDao")
	private BpmPetDao bpmPetDao;

	/**
	 * 국회의원 청원 조회
	 */
	@Override
	public Paging searchPetAssmMemb(Params params) {
		return bpmPetDao.searchPetAssmMemb(params, params.getPage(), params.getRows());
	}

	/**
	 * 국민동의 청원 조회
	 */
	@Override
	public Paging searchPetAprvNa(Params params) {
		return bpmPetDao.searchPetAprvNa(params, params.getPage(), params.getRows());
	}
}

package egovframework.portal.bpm.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.service.BaseService;
import egovframework.portal.bpm.service.BpmCmpService;

/**
 * 의정활동 통합현황 - 위원회 구성/계류법안 서비스 구현 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/11/05
 */
@Service(value="bpmCmpService")
public class BpmCmpServiceImpl extends BaseService implements BpmCmpService {

	@Resource(name="bpmCmpDao")
	private BpmCmpDao bpmCmpDao;

	/**
	 * 위원회 종류 조회(코드)
	 */
	@Override
	public List<Record> selectCmpDivCdList(Params params) {
		return bpmCmpDao.selectCmpDivCdList(params);
	}

	/**
	 * 위원회명 조회(코드)
	 */
	@Override
	public List<Record> selectCommitteeCdList(Params params) {
		return bpmCmpDao.selectCommitteeCdList(params);
	}
	
	/**
	 * 당명 리스트 조회(교섭단체, 비교섭단체 구분)
	 */
	@Override
	public List<Record> selectPolyGroupList(Params params) {
		return bpmCmpDao.selectPolyGroupList(params);
	}
	
	/**
	 * 위원회 현황 조회
	 */
	@Override
	public Paging searchCmpCond(Params params) {
		return bpmCmpDao.searchCmpCond(params, params.getPage(), params.getRows());
	}
	
	/**
	 * 위원회 명단 조회
	 */
	@Override
	public Paging searchCmpList(Params params) {
		return bpmCmpDao.searchCmpList(params, params.getPage(), params.getRows());
	}
	
	/**
	 * 위원회 일정 조회
	 */
	@Override
	public Paging searchCmpDate(Params params) {
		return bpmCmpDao.searchCmpDate(params, params.getPage(), params.getRows());
	}
	
	/**
	 * 계류의안 조회
	 */
	@Override
	public Paging searchCmpMoob(Params params) {
		return bpmCmpDao.searchCmpMoob(params, params.getPage(), params.getRows());
	}
	
	/**
	 *  공통코드 조회(의안구분)
	 */
	@Override
	public List<Record> searchCmpMoobCommCd(Params params) {
		return bpmCmpDao.searchCmpMoobCommCd(params); 
	}
	
	/**
	 * 위원회 자료실 조회
	 */
	@Override
	public Paging searchCmpRefR(Params params) {
		return bpmCmpDao.searchCmpRefR(params, params.getPage(), params.getRows());
	}
	
	/**
	 * 위원회 회의록 조회
	 */
	@Override
	public Paging searchCmpReport(Params params) {
		return bpmCmpDao.searchCmpReport(params, params.getPage(), params.getRows());
	}
}

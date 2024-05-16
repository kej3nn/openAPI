package egovframework.portal.bpm.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.service.BaseService;
import egovframework.portal.bpm.service.BpmPrcService;

/**
 * 의정활동 통합현황 - 본회의 안건처리 서비스 구현 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/11/05
 */
@Service(value="bpmPrcService")
public class BpmPrcServiceImpl extends BaseService implements BpmPrcService {

	@Resource(name="bpmPrcDao")
	private BpmPrcDao bpmPrcDao;

	/**
	 * 본회의 일정 페이징
	 */
	@Override
	public Paging searchPrcDate(Params params) {
		return bpmPrcDao.searchPrcDate(params, params.getPage(), params.getRows());
	}
	
	/**
	 * 본회의 일정 조회
	 */
	@Override
	public List<Record> selectPrcDate(Params params) {
		return bpmPrcDao.searchPrcDate(params);
	}
	
	
	
	/**
	 * 본회의 안건처리 - 법률안, 기타 데이터 조회 페이징
	 */
	@Override
	public Paging searchPrcItmPrcLaw(Params params) {
		return bpmPrcDao.searchPrcItmPrcLaw(params, params.getPage(), params.getRows());
	}
	
	/**
	 * 본회의 안건처리 - 법률안, 기타 데이터 조회
	 */
	@Override
	public List<Record> selectPrcItmPrcLaw(Params params) {
		return bpmPrcDao.searchPrcItmPrcLaw(params);
	}

	/**
	 * 본회의 안건처리 - 예산안, 결산 데이터 조회 페이징
	 */
	@Override
	public Paging searchPrcItmPrcBdg(Params params) {
		return bpmPrcDao.searchPrcItmPrcBdg(params, params.getPage(), params.getRows());
	}
	
	/**
	 * 본회의 안건처리 - 예산안, 결산 데이터 조회
	 */
	@Override
	public List<Record> selectPrcItmPrcBdg(Params params) {
		return bpmPrcDao.searchPrcItmPrcBdg(params);
	}
	
	
	/**
	 * 본회의 회의록 조회
	 */
	@Override
	public Paging searchPrcPrcd(Params params) {
		return bpmPrcDao.searchPrcPrcd(params, params.getPage(), params.getRows());
	}

	/**
	 * 본회의 회의록 조회
	 */
	@Override
	public List<Record> selectPrcPrcd(Params params) {
		return bpmPrcDao.searchPrcPrcd(params);
	}
	
}

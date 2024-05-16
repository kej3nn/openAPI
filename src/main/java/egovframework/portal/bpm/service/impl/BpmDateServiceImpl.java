package egovframework.portal.bpm.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.service.BaseService;
import egovframework.portal.bpm.service.BpmDateService;

/**
 * 의정활동 통합현황 - 날짜별 의정활동공개 서비스 구현 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/11/05
 */
@Service(value="bpmDateService")
public class BpmDateServiceImpl extends BaseService implements BpmDateService {

	@Resource(name="bpmDateDao")
	private BpmDateDao bpmDateDao;

	/**
	 * 날짜별 의정활동 조회
	 */
	@Override
	public Paging searchDate(Params params) {
		return bpmDateDao.searchDate(params, params.getPage(), params.getRows());
	}

	/**
	 * 캘린더 데이터 조회(월단위로)
	 */
	@Override
	public List<Record> searchDateCalendar(Params params) {
		return bpmDateDao.searchDateCalendar(params);
	}
}

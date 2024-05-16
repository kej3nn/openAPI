package egovframework.portal.assm.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.service.BaseService;
import egovframework.portal.assm.service.AssmSchdService;

/**
 * 국회의원 일정 서비스 구현 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/10/22
 */
@Service(value="AssmSchdService")
public class AssmSchdServiceImpl extends BaseService implements AssmSchdService {

	@Resource(name="AssmSchdDao")
	private AssmSchdDao assmSchdDao;

	/**
	 * 의원일정 조회 - 페이징
	 */
	@Override
	public Paging searchAssmSchd(Params params) {
		return assmSchdDao.searchAssmSchd(params, params.getPage(), params.getRows());
	}

	/**
	 * 의원일정 조회
	 */
	@Override
	public List<Record> selectAssmSchd(Params params) {
		return assmSchdDao.selectAssmSchd(params);
	}
}

package egovframework.portal.assm.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.service.BaseService;
import egovframework.portal.assm.service.AssmPdtaService;

/**
 * 국회의원 정책자료&보고서 서비스 구현 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/10/22
 */
@Service(value="AssmPdtaService")
public class AssmPdtaServiceImpl extends BaseService implements AssmPdtaService {

	@Resource(name="AssmPdtaDao")
	private AssmPdtaDao assmPdtaDao;

	/**
	 * 정책자료&보고서 조회 - 페이징
	 */
	@Override
	public Paging searchAssmPdta(Params params) {
		return assmPdtaDao.searchAssmPdta(params, params.getPage(), params.getRows());
	}

	/**
	 * 정책자료&보고서 조회
	 */
	@Override
	public List<Record> selectAssmPdta(Params params) {
		return assmPdtaDao.selectAssmPdta(params);
	}
	
}

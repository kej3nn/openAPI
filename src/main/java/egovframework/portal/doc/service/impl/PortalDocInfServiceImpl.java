package egovframework.portal.doc.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.service.BaseService;
import egovframework.portal.doc.service.PortalDocInfService;

/**
 * 문서관리 서비스를 관리하는 서비스 구현 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2018/08/20
 */
@Service(value="portalDocInfService")
public class PortalDocInfServiceImpl extends BaseService implements PortalDocInfService {

	@Resource(name="portalDocInfDao")
	protected PortalDocInfDao portalDocInfDao;

	/**
	 * 문서관리 메타정보 조회
	 */
	@Override
	public Record selectDocInfMeta(Params params) {
		Record meta = portalDocInfDao.selectDocInfMeta(params);
		
		// 이력 생성
		portalDocInfDao.insertLogDocInf(params);
		
		// 조회수 증가(트리거에서 처리)
		
		return meta;
	}

	/**
	 * 평가점수 등록
	 */
	@Override
	public Record insertDocInfAppr(Params params) {
		// 평가점수 등록
		portalDocInfDao.insertDocInfAppr(params);
		
		// 평가점수 조회
		return portalDocInfDao.selectDocInfAppr(params);
	}
}

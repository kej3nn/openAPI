package egovframework.portal.assm.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.service.BaseService;
import egovframework.portal.assm.service.AssmNotiService;
import egovframework.portal.assm.service.AssmMemberService;

/**
 * 국회의원 알림 서비스 구현 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/10/22
 */
@Service(value="AssmNotiService")
public class AssmNotiServiceImpl extends BaseService implements AssmNotiService {

	@Resource(name="AssmNotiDao")
	private AssmNotiDao assmNotiDao;

	/**
	 * 의원실 알림 조회
	 */
	@Override
	public Paging searchAssmNoti(Params params) {
		return assmNotiDao.searchAssmNoti(params, params.getPage(), params.getRows());
	}
}

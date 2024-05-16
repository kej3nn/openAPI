package egovframework.portal.assm.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.common.base.service.BaseService;
import egovframework.portal.assm.service.AssmRemkService;
import egovframework.portal.assm.service.AssmMemberService;

/**
 * 국회의원 발언 서비스 구현 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/10/16
 */
@Service(value="AssmRemkService")
public class AssmRemkServiceImpl extends BaseService implements AssmRemkService {

	@Resource(name="AssmRemkDao")
	private AssmRemkDao AssmRemkDao;
}

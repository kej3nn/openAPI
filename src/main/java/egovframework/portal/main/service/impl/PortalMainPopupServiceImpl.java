package egovframework.portal.main.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.common.base.model.Params;
import egovframework.common.base.model.Result;
import egovframework.common.base.service.BaseService;
import egovframework.portal.main.service.PortalMainPopupService;

/**
* 포털 메인팝업 화면 서비스 구현 클래스
* 
* @author CSB
* @version 1.0 2021/01/05
*/
@Service(value="portalMainPopupService")
public class PortalMainPopupServiceImpl extends BaseService implements PortalMainPopupService {
@Resource(name="portalMainPopupDao")
	private PortalMainPopupDao portalMainPopupDao;

	/**
	 * 퀴즈이벤트 내용을 등록한다.
	 * 
	 * @param params 파라메터
	 * @return 등록결과
	 */
	public Result mainQuizEventInsert(Params params) {
	    
		String userHp = params.getString("userTel1") + params.getString("userTel2") + params.getString("userTel3");
		
		params.put("userHp", userHp);
		params.put("userCd", 0);
		
	    // 퀴즈이벤트 내용을 등록한다.
		portalMainPopupDao.mainQuizEventInsert(params);
	    
	    return success(getMessage("portal.message.000003"));
	}

}

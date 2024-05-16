package egovframework.portal.main.service.impl;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Params;

/**
 * 포털 메인팝업 화면 DAO 클래스
 * 
 * @author CSB
 * @version 1.0 2021/01/05
 */
@Repository(value="portalMainPopupDao")
public class PortalMainPopupDao extends BaseDao {
	
	/**
     * 퀴즈이벤트 내용을 등록한다.
     * 
     * @param params 파라메터
     * @return 등록결과
     */
    public Object mainQuizEventInsert(Params params) {
        // 퀴즈이벤트 내용을 등록한다.
        return insert("PortalMainPopupDao.mainQuizEventInsert", params);
    }

}

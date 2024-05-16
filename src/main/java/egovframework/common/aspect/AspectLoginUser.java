
package egovframework.common.aspect;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.admin.basicinf.service.CommUsr;
import egovframework.admin.service.service.OpenInfScol;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.common.grid.CommVo;

/**
 * 세션 id 처리 class
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */
public class AspectLoginUser {

    Logger logger = LoggerFactory.getLogger(getClass());


    public void setUsrId2(Object Vo) {
        setUsrId(Vo, "");
    }

    /**
     * 사용자 id를 setter한다.
     *
     * @param Vo
     * @param status
     */
    @SuppressWarnings("unchecked")
    public void setUsrId(Object Vo, Object status) {
        if (EgovUserDetailsHelper.isAuthenticated()) {
            EgovUserDetailsHelper.getAuthenticatedUser();
            CommUsr resultVO = (CommUsr) EgovUserDetailsHelper.getAuthenticatedUser();
            logger.debug("로그인 id :" + resultVO.getUsrId());
            if (Vo instanceof ArrayList) {
                logger.debug("ArrayList");
                ((ArrayList<CommVo>) Vo).get(0).setSessionUsrId(resultVO.getUsrId());
                ((ArrayList<CommVo>) Vo).get(0).setSessionUsrCd(resultVO.getUsrCd());
                ((ArrayList<CommVo>) Vo).get(0).setSessionOrgCd(resultVO.getOrgCd());
                ((ArrayList<CommVo>) Vo).get(0).setSessionOrgNm(resultVO.getOrgNm());
            } else if (Vo instanceof List) {
                logger.debug("List");
                ((List<CommVo>) Vo).get(0).setSessionUsrId(resultVO.getUsrId());
                ((List<CommVo>) Vo).get(0).setSessionUsrCd(resultVO.getUsrCd());
                ((List<CommVo>) Vo).get(0).setSessionOrgCd(resultVO.getOrgCd());
                ((List<CommVo>) Vo).get(0).setSessionOrgNm(resultVO.getOrgNm());
            } else {
                logger.debug("CommVo");
                ((CommVo) Vo).setSessionUsrId(resultVO.getUsrId());
                ((CommVo) Vo).setSessionUsrCd(resultVO.getUsrCd());
                ((CommVo) Vo).setSessionOrgCd(resultVO.getOrgCd());
                ((CommVo) Vo).setSessionOrgNm(resultVO.getOrgNm());
            }
        } else {
            logger.debug("로그인 id 없음");
            if (Vo instanceof ArrayList) {
                logger.debug("ArrayList");
                ((ArrayList<CommVo>) Vo).get(0).setSessionUsrId("");
            } else if (Vo instanceof List) {
                logger.debug("List");
                ((List<CommVo>) Vo).get(0).setSessionUsrId("");
            } else {
                logger.debug("CommVo");
                ((CommVo) Vo).setSessionUsrId("");
            }
        }
    }

}

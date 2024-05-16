package egovframework.admin.service.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.basicinf.service.CommUsr;
import egovframework.admin.service.service.OpenInfSrv;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import lombok.NonNull;

/**
 * 메뉴를 관리를 위한 서비스 구현 클래스
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */

@Service("OpenInfSrvService")
public class OpenInfSrvServiceImpl extends AbstractServiceImpl {

    @Resource(name = "OpenInfSrvDAO")
    protected OpenInfSrvDAO openInfSrvDAO;

    private static final Logger logger = Logger.getLogger(OpenInfSrvServiceImpl.class);


    public Map<String, Object> selectOpenInfAllIbPaging(@NonNull OpenInfSrv openInfSrv) {
        if (EgovUserDetailsHelper.isAuthenticated()) {
            CommUsr loginVO = null;
            EgovUserDetailsHelper.getAuthenticatedUser();
            loginVO = (CommUsr) EgovUserDetailsHelper.getAuthenticatedUser();
            openInfSrv.setAccCd(loginVO.getAccCd());                    //로그인 된 유저 권환 획득
        }

        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenInfSrv> result = openInfSrvDAO.selectOpenInfListAll(openInfSrv);
            int cnt = openInfSrvDAO.selectOpenInfListAllCnt(openInfSrv);
            map.put("resultList", result);
            map.put("resultCnt", Integer.toString(cnt));
        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return map;
    }

    public List<OpenInfSrv> selectOpenInfSrvInfo(OpenInfSrv openInfSrv) {
        List<OpenInfSrv> result = new ArrayList<OpenInfSrv>();
        try {
            result = openInfSrvDAO.selectOpenInfSrvInfo(openInfSrv);
        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return result;
    }

    public int openInfSrvCUD(@NonNull OpenInfSrv openInfSrv) {
        int result = 0;
        try {
            result = openInfSrvDAO.mergeInto(openInfSrv);
            result = openInfSrvDAO.insertSrvConn(openInfSrv);
            if (result != 0) {
                String srvCd = StringUtils.defaultString(openInfSrv.getSrvCd());
                if (!srvCd.equals("L") && !srvCd.equals("F") && !srvCd.equals("V")) {
                    result = openInfSrvDAO.insertCol(openInfSrv);
                }
            }
        } catch (DataAccessException e) {
            EgovWebUtil.exTransactionLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
        return result;
    }

    public String selectOpenInfDsExp(OpenInfSrv openInfSrv) {
        String result = "";
        try {
            result = openInfSrvDAO.selectOpenInfDsExp(openInfSrv);
        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

}
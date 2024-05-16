package egovframework.admin.openinf.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.basicinf.service.CommUsr;
import egovframework.admin.openinf.service.OpenInf;
import egovframework.admin.openinf.service.OpenInfPrssService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.common.WiseOpenConfig;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("OpenInfPrssService")
public class OpenInfPrssServiceImpl extends AbstractServiceImpl implements OpenInfPrssService {

    @Resource(name = "OpenInfPrssDAO")
    private OpenInfPrssDAO openInfPrssDAO;

    private static final Logger logger = Logger.getLogger(OpenInfServiceImpl.class.getClass());

    public Map<String, Object> selectOpenInfPrssListAllIbPaging(OpenInf openInf) {

        CommUsr loginVO = null;

        //사용자 인증 및 사용자 권한정보 및 사용자코드 Set
        if (EgovUserDetailsHelper.isAuthenticated()) {
            EgovUserDetailsHelper.getAuthenticatedUser();
            loginVO = (CommUsr) EgovUserDetailsHelper.getAuthenticatedUser();
            openInf.setAccCd(loginVO.getAccCd());
            openInf.setSessionUsrCd(loginVO.getUsrCd());
            //openInf.setSessionUsrId();
            //openInf.setSessionAccCd(loginVO.getAccCd());
        }
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenInf> result = openInfPrssDAO.selectOpenInfPrssListAll(openInf);
            int cnt = openInfPrssDAO.selectOpenInfPrssListAllCnt(openInf);
            map.put("resultList", result);
            map.put("resultCnt", Integer.toString(cnt));

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return map;
    }

    public List<OpenInf> selectOpenInfPrssDtl(OpenInf openInf) {
        //사용자 인증 및 사용자 권한정보 및 사용자코드 Set
        if (EgovUserDetailsHelper.isAuthenticated()) {
            EgovUserDetailsHelper.getAuthenticatedUser();
            CommUsr loginVO = (CommUsr) EgovUserDetailsHelper.getAuthenticatedUser();
            openInf.setAccCd(loginVO.getAccCd());
            openInf.setSessionUsrCd(loginVO.getUsrCd());
        }
        List<OpenInf> result = new ArrayList<OpenInf>();
        try {
            result = openInfPrssDAO.selectOpenInfPrssDtl(openInf);

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;

    }

    public int openInfPrssRegCUD(OpenInf saveVO, String status) {
        int result = 0;
        try {
            if (WiseOpenConfig.STATUS_I.equals(status)) {
                result = openInfPrssDAO.insertLog(saveVO);
                if (result > 0) {
                    openInfPrssDAO.updateOpenInfPrss(saveVO);
                }
            } else {
                result = WiseOpenConfig.STATUS_ERR;
            }

        } catch (DataAccessException e) {
            EgovWebUtil.exTransactionLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }


        return result;
    }

    public Map<String, Object> selectOpenInfPrssLogIbPaging(OpenInf openInf) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenInf> result = openInfPrssDAO.selectOpenInfPrssLogList(openInf);
            int cnt = openInfPrssDAO.selectOpenInfPrssLogListCnt(openInf);
            map.put("resultList", result);
            map.put("resultCnt", Integer.toString(cnt));


        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return map;
    }

}

package egovframework.admin.openinf.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.openinf.service.OpenPubCfg;
import egovframework.admin.openinf.service.OpenPubCfgService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.WiseOpenConfig;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * 분류정보 관리를 위한 서비스 구현 클래스
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.07.16
 */

@Service("OpenPubCfgService")
public class OpenPubCfgServiceImpl extends AbstractServiceImpl implements OpenPubCfgService {

    @Resource(name = "OpenPubCfgDAO")
    protected OpenPubCfgDAO openPubCfgDAO;

    private static final Logger logger = Logger.getLogger(OpenPubCfgServiceImpl.class);


    public Map<String, Object> openPubCfgListAllIbPaging(OpenPubCfg openPubCfg) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenPubCfg> result = openPubCfgDAO.selectOpenPubCfgListAll(openPubCfg);
            int cnt = openPubCfgDAO.selectOpenPubCfgListAllCnt(openPubCfg);
            map.put("resultList", result);
            map.put("resultCnt", Integer.toString(cnt));
        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return map;
    }


    public int openPubCfgRefDsCheckDup(OpenPubCfg openPubCfg) {
        int result = 0;
        try {
            if (openPubCfgDAO.selectOpenPubCfgRefDsCheckDup(openPubCfg) > 0) {
                return -1;
            }

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    /**
     * 공표기준을 단건 조회한다.
     *
     * @param openPubCfg
     * @param model
     * @return
     * @throws Exception
     */
    public OpenPubCfg selectOpenPubCfgOne(OpenPubCfg openPubCfg) {
        OpenPubCfg result = new OpenPubCfg();
        try {
            result = openPubCfgDAO.selectOpenPubCfgOne(openPubCfg);
        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    /**
     * 공표기준 컬럼 list를 조회한다.
     *
     * @param openPubCfg
     * @param model
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectRefColId(OpenPubCfg openPubCfg) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenPubCfg> refColIdList = openPubCfgDAO.selectRefColId(openPubCfg);
            if (openPubCfg.getPubId() != null) {
                OpenPubCfg refColId = openPubCfgDAO.selectOpenPubCfgOne(openPubCfg);
                map.put("refColId", refColId);
            }
            map.put("refColIdList", refColIdList);
        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return map;
    }

    /**
     * 공표기준을 저장,삭제,변경한다.
     * 프로시져 호출때문에 return 타입을 VO객체로 선언했음
     *
     * @param OpenPubCfg
     * @return
     * @throws Exception
     */
    public OpenPubCfg saveOpenPubCfgCUD(OpenPubCfg openPubCfg, String status) {
        int result = 0;
        try {
            if ((WiseOpenConfig.STATUS_D.equals(status))) {
                result = openPubCfgDAO.deleteOpenCfg(openPubCfg);
                result = openPubCfgDAO.updateOpenDsPubN(openPubCfg);
                result = openPubCfgDAO.updateOpenDsColPubN(openPubCfg);
                openPubCfg.setRes(result);
            }

            if (WiseOpenConfig.STATUS_I.equals(status)) {
                openPubCfg.setPubId(Integer.toString(openPubCfgDAO.getOpenPubCfgMaxId(openPubCfg)));    // pub_id Max값 구하기
                if (openPubCfgDAO.selectOpenPubCfgRefDsCheckDup(openPubCfg) > 0) { //중복체크
                    openPubCfg.setRes(-1);
                    return openPubCfg;
                }
                result = openPubCfgDAO.insertOpenCfg(openPubCfg);
                OpenPubCfg openpubcfg = new OpenPubCfg();
                openpubcfg = openPubCfgDAO.callSPM(openPubCfg);
                openPubCfg = openpubcfg;
                if (openPubCfg.getRetval() == 0) {
                    openPubCfg.setRes(1);
                    openPubCfg.setRetmsg("저장에 성공하였습니다.");
                }
                openPubCfg.setRetval(-502);
            }
            if (WiseOpenConfig.STATUS_U.equals(status)) {
                result = openPubCfgDAO.updateOpenCfg(openPubCfg);
                result = openPubCfgDAO.updateOpenDsPubYn(openPubCfg);
                result = openPubCfgDAO.updateOpenDsColPubYn(openPubCfg);
                openPubCfg.setRes(result);
            }
        } catch (DataAccessException e) {
            EgovWebUtil.exTransactionLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
        return openPubCfg;
    }


}
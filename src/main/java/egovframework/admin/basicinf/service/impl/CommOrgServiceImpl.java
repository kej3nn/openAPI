package egovframework.admin.basicinf.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.basicinf.service.CommOrg;
import egovframework.admin.basicinf.service.CommOrgService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.WiseOpenConfig;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import lombok.NonNull;

/**
 * 조직정보 관리를 위한 ServiceImpl 클래스
 *
 * @author KJH
 * @since 2014.07.17
 */
@Service("CommOrgService")
public class CommOrgServiceImpl extends AbstractServiceImpl implements CommOrgService {

    @Resource(name = "CommOrgDAO")
    private CommOrgDAO CommOrgDAO;

    private static final Logger logger = Logger.getLogger(CommOrgServiceImpl.class);

    /**
     * 조직정보 팝업
     */
    public List<CommOrg> selectCommOrgAll(CommOrg commOrg) {
        List<CommOrg> result = new ArrayList<CommOrg>();
        try {
            result = CommOrgDAO.selectCommOrgListAll(commOrg);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    /**
     * 조직정보 전체조회
     */
    @Override
    public Map<String, Object> commOrgListTree(CommOrg commOrg) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<CommOrg> result = CommOrgDAO.selectCommOrgListTree(commOrg);
            map.put("resultList", result);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return map;
    }

    /**
     * 조직코드 중복체크
     */
    @Override
    public int commOrgCdDup(CommOrg commOrg) {
        int result = 0;
        try {
            if (CommOrgDAO.selectCommOrgCdDup(commOrg) > 0) {
                return -1;
            }
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    /**
     * 조직정보 CUD
     */
    @Override
    public int saveCommOrgCUD(@NonNull CommOrg commOrg, String status) {
        int result = 0;
        if ((WiseOpenConfig.STATUS_D.equals(status))) {
            try {
                result = CommOrgDAO.deleteLowCommOrg(commOrg);
            } catch (Exception e) {
                EgovWebUtil.exTransactionLogging(e);
            }

        } else if (WiseOpenConfig.STATUS_I.equals(status)) {
            try {
                if (CommOrgDAO.selectCommOrgCdDup(commOrg) > 0) { //중복체크
                    return -1;
                } else {
                    result = CommOrgDAO.insertCommOrg(commOrg);
                }
            } catch (Exception e) {
                EgovWebUtil.exTransactionLogging(e);
            }

        } else if (WiseOpenConfig.STATUS_U.equals(status)) {
            try {
                if (CommOrgDAO.updateCommOrg(commOrg) > 0) {
                    List<CommOrg> UpdOrg = CommOrgDAO.getOrgFullNmQuery(commOrg); //조직명 fullname 조회한다.
                    for (int i = 0; i < UpdOrg.size(); i++) {
                        result = CommOrgDAO.actOrgFullNmUpd(UpdOrg.get(i)); //변경된 조직명 fullname을 update한다.
                    }

                    if (commOrg.getUseYn() != null && commOrg.getUseYn().equals("N")) {
                        result = CommOrgDAO.updateLowUseYnCommOrg(commOrg);
                    } else {
                        return 1;
                    }
                } else {
                    return -1;
                }
            } catch (Exception e) {
                EgovWebUtil.exTransactionLogging(e);
            }
        }
        return result;
    }

    /**
     * 조직정보 단건 조회
     */
    //@Override
    //public CommOrg commOrgRetr(CommOrg commOrg) {
    //	return CommOrgDAO.commOrgRetr(commOrg);
    //}

    /**
     * 조직정보 단건 조회
     */
    public List<CommOrg> commOrgRetr(CommOrg commOrg) {
        List<CommOrg> result = new ArrayList<CommOrg>();
        try {
            result = CommOrgDAO.commOrgRetr(commOrg);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    /**
     * 조직정보 트리순서 수정
     */
    public int commOrgListUpdateTreeOrderCUD(ArrayList<CommOrg> list) {
        int result = 0;
        try {
            for (CommOrg commOrg : list) {
                result = CommOrgDAO.commOrgListUpdateTreeOrder(commOrg);
            }
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
        return result;
    }

}

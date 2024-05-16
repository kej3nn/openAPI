package egovframework.admin.basicinf.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.basicinf.service.CommUsr;
import egovframework.admin.basicinf.service.CommUsrAdmin;
import egovframework.admin.basicinf.service.CommUsrAdminService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.common.WiseOpenConfig;
import egovframework.common.util.UtilEncryption;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import lombok.NonNull;

/**
 * 담당자관리 ServiceImpl
 *
 * @author KJH
 * @since 2014.07.23
 */
@Service("CommUsrAdminService")
public class CommUsrAdminServiceImpl extends AbstractServiceImpl implements CommUsrAdminService {

    @Resource(name = "CommUsrAdminDAO")
    private CommUsrAdminDAO commUsrAdminDAO;

    private static final Logger logger = Logger.getLogger(CommUsrAdminServiceImpl.class);

    /**
     * 사용자 정보를 체크한다.
     */
    public CommUsrAdmin selectCommUsrAdminCheck(CommUsrAdmin commUsrAdmin) {
        CommUsrAdmin result = new CommUsrAdmin();
        try {
            result = commUsrAdminDAO.selectCommUsrAdminCheck(commUsrAdmin);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    /**
     * 사용자 전체조회
     */
    public Map<String, Object> selectCommUsrAdminAllIbPaging(@NonNull CommUsrAdmin commUsrAdmin) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            // 관리자만 목록에서 나오도록.
            if (EgovUserDetailsHelper.isAuthenticated()) {
                CommUsr loginVO = null;
                EgovUserDetailsHelper.getAuthenticatedUser();
                loginVO = (CommUsr) EgovUserDetailsHelper.getAuthenticatedUser();
                if (StringUtils.equals("SYS", loginVO.getAccCd())) {
                    commUsrAdmin.setIsAdmin("1");
                } else {
                    commUsrAdmin.setIsAdmin("0");
                }
            }

            List<CommUsrAdmin> result = commUsrAdminDAO.selectCommUsrAdminListAll(commUsrAdmin);
            int cnt = commUsrAdminDAO.selectCommUsrAdminListAllCnt(commUsrAdmin);
            map.put("resultList", result);
            map.put("resultCnt", Integer.toString(cnt));
//		map.put("resultCnt", String.valueOf(result.size()));
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
    	/*
    	for(CommUsrAdmin usr : result) {
    		UtilEncryption ue = new UtilEncryption();
    		usr.setUsrTel(ue.decrypt(usr.getUsrTel()));
    	}
    	*/

        return map;
    }

    /**
     * 사용자 팝업 조회
     */
    @Override
    public Map<String, Object> selectCommUsrAdminPopIbPaging(CommUsrAdmin commUsrAdmin) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<CommUsrAdmin> result = commUsrAdminDAO.selectCommUsrAdminPopList(commUsrAdmin);
            map.put("resultList", result);

        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return map;
    }

    /**
     * 사용자 팝업 조회(직책추가)
     */
    @Override
    public Map<String, Object> selectCommUsrAdminPosPopIbPaging(CommUsrAdmin commUsrAdmin) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<CommUsrAdmin> result = commUsrAdminDAO.selectCommUsrAdminPosPopList(commUsrAdmin);
            map.put("resultList", result);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return map;
    }

    /**
     * 직원 단건조회
     */
    public CommUsrAdmin selectCommUsrAdminDtlInfo(CommUsrAdmin commUsrAdmin) {
        CommUsrAdmin result = new CommUsrAdmin();
        try {
            result = commUsrAdminDAO.selectCommUsrAdminDtlInfo(commUsrAdmin);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        //UtilEncryption ue = new UtilEncryption();
        //result.setUsrTel(ue.decrypt(result.getUsrTel()));
        //result.setUsrHp(ue.decrypt(result.getUsrHp()));
        return result;
    }

    /**
     * 담당자정보 CUD
     */
    @Override
    public int saveCommUsrAdminCUD(@NonNull CommUsrAdmin commUsrAdmin, String status) {
        int result = 0;
        UtilEncryption ue = new UtilEncryption();

        try {
            commUsrAdmin.setUsrPw(ue.encryptSha256(StringUtils.defaultString(commUsrAdmin.getUsrPw()), StringUtils.defaultString(commUsrAdmin.getUsrPw()).getBytes()));
            if (WiseOpenConfig.STATUS_I.equals(status)) {
                result = commUsrAdminDAO.save(commUsrAdmin);
            } else if (WiseOpenConfig.STATUS_U.equals(status)) {
                result = commUsrAdminDAO.update(commUsrAdmin);
            }
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }

        return result;
    }

    /**
     * 담당자 승인
     */
    @Override
    public int commUsrAdminAppr(CommUsrAdmin commUsrAdmin, String status) {
        int result = 0;
        if (status.equals("A")) {
            try {
                result = commUsrAdminDAO.approval(commUsrAdmin);
            } catch (Exception e) {
                EgovWebUtil.exTransactionLogging(e);
            }
        } else if (status.equals("C")) {
            try {
                result = commUsrAdminDAO.approvalCancel(commUsrAdmin);
            } catch (Exception e) {
                EgovWebUtil.exTransactionLogging(e);
            }
        }
        return result;
    }

    /**
     * 담당자ID 중복체크
     */
    @Override
    public int commUsrAdminUsrIdDup(CommUsrAdmin commUsrAdmin) {
        int result = 0;
        try {
            if (commUsrAdminDAO.usrIdDup(commUsrAdmin) > 0) {
                return -1;
            }
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    /**
     * 비밀번호 초기화
     */
    @Override
    public CommUsrAdmin commUsrAdminInitialPw(@NonNull CommUsrAdmin commUsrAdmin) {
        String randomPw = null;

        try {
            randomPw = commUsrAdminDAO.randomPw();
            commUsrAdmin.setInitialPwResult(0);

            if (!randomPw.isEmpty()) {
                UtilEncryption ue = new UtilEncryption();
                commUsrAdmin.setInitialPw(ue.encryptSha256(randomPw, randomPw.getBytes()));

                if (commUsrAdminDAO.initialPw(commUsrAdmin) > 0) {
                    commUsrAdmin.setInitialPwResult(-1);
                }

                commUsrAdmin.setInitialPw(randomPw);
            }
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
        return commUsrAdmin;
    }
}

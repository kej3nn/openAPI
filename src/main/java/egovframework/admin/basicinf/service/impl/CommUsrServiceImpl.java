package egovframework.admin.basicinf.service.impl;

import java.io.UnsupportedEncodingException;
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
import egovframework.admin.basicinf.service.CommUsrService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.WiseOpenConfig;
import egovframework.common.util.UtilEncryption;
import egovframework.common.util.UtilString;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import lombok.NonNull;

/**
 * 메뉴를 관리를 위한 서비스 구현 클래스
 *
 * @author wiseopen
 * @version 1.0
 * @since 2014.04.17
 */
@Service("CommUsrService")
public class CommUsrServiceImpl extends AbstractServiceImpl implements CommUsrService {

    @Resource(name = "CommUsrDAO")
    private CommUsrDAO CommUsrDAO;

    private static final Logger logger = Logger.getLogger(CommUsrServiceImpl.class);

    public CommUsr selectCommUsrCheck(@NonNull CommUsr commUsr) {
        UtilEncryption ue = new UtilEncryption();
        CommUsr result = new CommUsr();

        try {
            String usrPw = StringUtils.defaultString(commUsr.getUsrPw());
            commUsr.setUsrPw(ue.encryptSha256(usrPw, usrPw.getBytes()));
            result = CommUsrDAO.selectCommUsrCheck(commUsr);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    public CommUsr selectCommUsrCheckSSO(CommUsr commUsr) {
        CommUsr result = new CommUsr();
        try {
            result = CommUsrDAO.selectCommUsrCheckSSO(commUsr);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    /**
     * 사용자 정보 전체조회
     */
    public Map<String, Object> selectCommUsrAllIbPaging(CommUsr commUsr) {
        Map<String, Object> map = new HashMap<String, Object>();

        try {
            List<CommUsr> result = CommUsrDAO.selectCommUsrListAll(commUsr);
            int cnt = CommUsrDAO.selectCommUsrListAllCnt(commUsr);
            map.put("resultList", result);
            map.put("resultCnt", Integer.toString(cnt));

        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
    	/*
    	for(CommUsr usr : result) {
    		UtilEncryption ue = new UtilEncryption();
    		usr.setUsrTel(ue.decrypt(usr.getUsrTel()));
    	}
    	*/
        return map;
    }

    /**
     * 사용자 정보 단건 조회
     */
    /*public CommUsr selectCommUsr(CommUsr commUsr) {
		return  CommUsrDAO.selectCommUsrList(commUsr);
    }*/

    /**
     * 사용자 정보 단건 조회
     */
    public List<CommUsr> selectCommUsr(CommUsr commUsr) {
        List<CommUsr> result = new ArrayList<CommUsr>();
        try {
            result = CommUsrDAO.selectCommUsrList(commUsr);

        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        //UtilEncryption ue = new UtilEncryption();
        //String usrTel = ue.decrypt(result.get(0).getUsrTel());
        //String usrHp = ue.decrypt(result.get(0).getFirUsrHp());

        //String usrHp = result.get(0).getFirUsrHp();
        String usrTel = UtilString.null2Blank(result.get(0).getUsrTel());
        String usrHp = UtilString.null2Blank(result.get(0).getFirUsrHp());
        String[] usrTel_sp = null;
        String[] usrHp_sp = null;

        if (!"".equals(usrTel)) {
            usrTel_sp = usrTel.split("-");
        }

        if (!"".equals(usrHp)) {
            usrHp_sp = usrHp.split("-");
        }

        if (usrTel_sp != null) {
            if (usrTel_sp.length == 3) {
                result.get(0).setFirUsrTel(usrTel_sp[0]);
                result.get(0).setMidUsrTel(usrTel_sp[1]);
                result.get(0).setLastUsrTel(usrTel_sp[2]);
            } else if (usrTel_sp.length == 2) {
                result.get(0).setFirUsrTel(usrTel_sp[0]);
                result.get(0).setMidUsrTel(usrTel_sp[1]);
            } else if (usrTel_sp.length == 1) {
                result.get(0).setFirUsrTel(usrTel_sp[0]);
            }
        }

        if (usrHp_sp != null) {
            if (usrHp_sp.length == 3) {
                result.get(0).setFirUsrHp(usrHp_sp[0]);
                result.get(0).setMidUsrHp(usrHp_sp[1]);
                result.get(0).setLastUsrHp(usrHp_sp[2]);
            } else if (usrHp_sp.length == 2) {
                result.get(0).setFirUsrHp(usrHp_sp[0]);
                result.get(0).setMidUsrHp(usrHp_sp[1]);
            } else if (usrHp_sp.length == 1) {
                result.get(0).setFirUsrHp(usrHp_sp[0]);
            }
        }

        return result;
    }

    /**
     * 사용자 정보 입력/수정/삭제
     */
    public int saveCommUsrCUD(@NonNull CommUsr commUsr, String status) {
        int result = 0;

        //UtilEncryption ue = new UtilEncryption();
        //commUsr.setUsrTel(ue.encrypt(commUsr.getFirUsrTel() + "-" + commUsr.getMidUsrTel() + "-" + commUsr.getLastUsrTel()));
        //commUsr.setFirUsrHp(ue.encrypt(commUsr.getFirUsrHp() + "-" + commUsr.getMidUsrHp() + "-" + commUsr.getLastUsrHp()));
        String usrTel = StringUtils.defaultString(commUsr.getFirUsrTel()) +
                "-" +
                StringUtils.defaultString(commUsr.getMidUsrTel()) +
                "-" +
                StringUtils.defaultString(commUsr.getLastUsrTel());
        commUsr.setUsrTel(usrTel);
        String usrHp = StringUtils.defaultString(commUsr.getFirUsrHp()) +
                "-" +
                StringUtils.defaultString(commUsr.getMidUsrHp()) +
                "=" +
                StringUtils.defaultString(commUsr.getLastUsrHp());
        commUsr.setFirUsrHp(usrHp);

        if (WiseOpenConfig.STATUS_I.equals(status)) {
            //commUsr.setUsrCd(1);
            try {
                result = CommUsrDAO.insert(commUsr);
            } catch (Exception e) {
                EgovWebUtil.exTransactionLogging(e);
            }
        } else if ((WiseOpenConfig.STATUS_U.equals(status))) {
            try {
                result = CommUsrDAO.update(commUsr);
            } catch (Exception e) {
                EgovWebUtil.exTransactionLogging(e);
            }
        } else if ((WiseOpenConfig.STATUS_D.equals(status))) {
            try {
                result = CommUsrDAO.delete(commUsr);
            } catch (Exception e) {
                EgovWebUtil.exTransactionLogging(e);
            }
        } else {

            result = WiseOpenConfig.STATUS_ERR;
        }
        return result;
    }

    /**
     * 사용자 로그인 실패 횟수 업데이트(성공이면 0, 실패면 +1)
     */
    @Override
    public int saveCommUsrFailCnt(CommUsr commUsr) {
        int result = 0;
        try {
            result = CommUsrDAO.saveCommUsrFailCnt(commUsr);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
        return result;
    }

    /**
     * 아이디 체크(회원 존재여부)
     */
    @Override
    public int selectCommUsrIdChk(CommUsr commUsr) {
        int result = 0;
        try {
            result = CommUsrDAO.selectCommUsrIdChk(commUsr);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return result;
    }

    /**
     * 로그인 실패 횟수 조회
     */
    @Override
    public int selectCommUsrFailCnt(CommUsr commUsr) {
        int result = 0;
        try {
            result = CommUsrDAO.selectCommUsrFailCnt(commUsr);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    /**
     * 패스워드 변경기간 조회(60일 이후이면 true 반환), 패스워드 변경요청도 확인
     */
    @Override
    public boolean selectCommUsrChangePwDttm(CommUsr commUsr) {

        List<HashMap<String, Object>> map = new ArrayList<HashMap<String, Object>>();
        try {
            map = CommUsrDAO.selectCommUsrChangePwDttm(commUsr);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        int pwDttm = Integer.parseInt(String.valueOf(map.get(0).get("pwDttm")));        //패스워드 변경 경과시간(기준정보 파일에 저장)
        String reqPwYn = (String) map.get(0).get("reqPwYn");                            //패스워드 변경 요청
        if (pwDttm > WiseOpenConfig.PWD_CHANGE_PERIOD | reqPwYn.equals("Y"))
            return true;
        else
            return false;
    }

    /**
     * 패스워드 변경(패스워드 변경 기간초과에 따른)
     */
    @Override
    public int saveCommUsrChangePw(CommUsr commUsr) {
        int result = 0;

        try {
            result = CommUsrDAO.saveCommUsrChangePw(commUsr);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
        return result;
    }

    /**
     * PKI 인증서 등록
     */
    @Override
    public int savePkiReg(CommUsr commusr) {
        int result = 0;

        try {
            result = CommUsrDAO.savePkiReg(commusr);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
        return result;
    }

    /**
     * PKI 인증서 등록체크
     */
    public CommUsr selectCommUsrPkiCheck(CommUsr commUsr) {
        CommUsr result = new CommUsr();
        try {
            result = CommUsrDAO.selectCommUsrPkiCheck(commUsr);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
        return result;
    }

    /**
     * Q&A 답변 요청 건수
     */
    @Override
    public int selectQNACnt() {
        int result = 0;
        try {
            result = CommUsrDAO.selectQNACnt();
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    /**
     * 활용사례 등록 요청 건수
     */
    @Override
    public int selectGalleryCnt() {
        int result = 0;

        try {
            result = CommUsrDAO.selectGalleryCnt();
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    /**
     * 관리자의 로그인 접속이력을 기록한다.
     */
    @Override
    public int insertLogCommUsr(CommUsr commUsr) {
        int result = 0;
        try {
            result = CommUsrDAO.insertLogCommUsr(commUsr);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }

        return result;
    }

    /**
     * 사용자 정보를 조회한다.
     */
    @Override
    public int selectCommUsrInfo(CommUsr commUsr) {
        int result = 0;
        try {
            result = CommUsrDAO.selectCommUsrInfo(commUsr);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    /**
     * AccCd 권한 체크하여 sys,admin 인 경우만 업무처리정보 볼수있다.
     */
    @Override
    public int selectAccCdCheck(CommUsr commUsr) {
        int result = 0;

        try {
            result = CommUsrDAO.selectAccCdCheck(commUsr);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    /**
     * 이미 등록된 pki라면 등록 못하도록 한다.
     */
    @Override
    public int selectDupPki(CommUsr commUsr) {
        int result = 0;

        try {
            result = CommUsrDAO.selectDupPki(commUsr);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return result;
    }

    /**
     * 비밀번호 변경시 기존의 비밀번호로 변경못하도록 체크한다.
     */
    @Override
    public int selectUserPwCheck(CommUsr commUsr) {
        int result = 0;

        try {
            result = CommUsrDAO.selectUserPwCheck(commUsr);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    /**
     * GPIN 관리자 중복체크
     */
    @Override
    public int gpinAdminDupCheck(CommUsr commUsr) {
        int result = 0;

        try {
            result = CommUsrDAO.gpinAdminDupCheck(commUsr);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;

    }

    @Override
    public int commUsrIdDup(CommUsr commUsr, String status) {
        return 0;
    }
}

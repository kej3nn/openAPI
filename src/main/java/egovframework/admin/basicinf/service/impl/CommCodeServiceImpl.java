package egovframework.admin.basicinf.service.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.basicinf.service.CommCode;
import egovframework.admin.basicinf.service.CommCodeService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.WiseOpenConfig;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import lombok.NonNull;

/**
 * 코드 관리를 위한 서비스 구현 클래스
 *
 * @author wiseopen
 * @version 1.0
 * @since 2014.04.17
 */
@Service("CommCodeService")
public class CommCodeServiceImpl extends AbstractServiceImpl implements CommCodeService {

    @Resource(name = "CommCodeDAO")
    private CommCodeDAO commCodeDAO;

    private static final Logger logger = Logger.getLogger(CommCodeServiceImpl.class);

    /**
     * 조건에 맞는 공통코드 목록을 조회 한다.
     *
     * @param commCode
     * @return Map<String, Object>
     */
    public Map<String, Object> commCodeListAllIbPaging(CommCode commCode) {

        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<CommCode> result = commCodeDAO.selectCommCodeAllList(commCode);
            int cnt = commCodeDAO.selectCommCodeAllListCnt(commCode);
            map.put("resultList", result);
            map.put("resultCnt", Integer.toString(cnt));

        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return map;
    }

    /**
     * 공통코드를 단건 조회한다.
     *
     * @param commCode
     * @return CommCode
     * @throws Exception
     */
    public CommCode selectCommCodeOne(CommCode commCode) {
        try {
            commCode = commCodeDAO.selectCommCodeOne(commCode);

        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return commCode;
    }

    /**
     * 공통코드를 등록,변경,삭제한다.
     *
     * @param commCode
     * @param status
     * @return Integer
     * @throws Exception
     */
    public int saveCommCodeCUD(@NonNull CommCode commCode, String status) {
        int result = 0;
        try {
            String grpIs = commCode.getGrpIs() == null ? "" : commCode.getGrpIs();
            String grpCib = commCode.getGrpCib() == null ? "" : commCode.getGrpCib();
            if ((WiseOpenConfig.STATUS_D.equals(status))) {
                if (grpIs.equals("Y") && grpCib.equals("Y")) {// 그룹코드이며 하위코드가 존재할때
                    result = commCodeDAO.deleteCommCode(commCode);
                    result = commCodeDAO.deleteSubCommCode(commCode);
                } else {
                    result = commCodeDAO.deleteCommCode(commCode);
                }
            }

            if (WiseOpenConfig.STATUS_I.equals(status)) {
                if (commCodeDAO.selectCommCodeCheckDup(commCode) > 0) //중복체크
                    return -1;
                result = commCodeDAO.insertCommCode(commCode);
            }
            if (WiseOpenConfig.STATUS_U.equals(status)) {
                if (grpIs.equals("Y") && grpCib.equals("Y")) {// 그룹코드이며 하위코드가 존재할때
                    result = commCodeDAO.updateCommCode(commCode);
                    result = commCodeDAO.updateSubCommCode(commCode);
                } else {
                    result = commCodeDAO.updateCommCode(commCode);
                }
            }

        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }

        return result;
    }

    /**
     * 공통코드 중복을 체크한다.
     *
     * @param commCode
     * @return Integer
     * @throws Exception
     */
    public int commCodeCheckDup(CommCode commCode) {
        int result = 0;

        try {
            if (commCodeDAO.selectCommCodeCheckDup(commCode) > 0) {
                result = -1;
            }

        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    /**
     * 공통코드 순서를 변경 한다.
     *
     * @param list
     * @return Integer
     * @throws Exception
     */
    public int commCodeOrderBySave(ArrayList<CommCode> list) {
        int result = 0;

        try {
            for (CommCode commCode : list) {
                result = commCodeDAO.updateOrderby(commCode);
            }

        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
        return result;
    }

    /**
     * 그룹 코드 목록을 조회 한다.(팝업)
     *
     * @param commCode
     * @return Map<CommCode>
     * @throws Exception
     */
    public Map<String, Object> commCodeGrpCdListIbPaging(CommCode commCode) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<CommCode> result = commCodeDAO.selectGrpcodeList(commCode);
            int cnt = commCodeDAO.selectGrpcodeListCnt(commCode);
            map.put("resultList", result);
            map.put("resultCnt", Integer.toString(cnt));

        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return map;
    }

    /**
     * 조건에 맞는 코드 목록을 조회 한다.(분류관리 등록시 표준맵핑 선택에 사용)
     *
     * @param commCode
     * @return Map<String, Object>
     * @throws Exception
     */
    public Map<String, Object> selectOpenCateDitcList(CommCode commCode) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<CommCode> result = commCodeDAO.selectOpenCateDitcList(commCode);
            int cnt = commCodeDAO.selectOpenCateDitcListCnt(commCode);
            map.put("resultList", result);
            map.put("resultCnt", Integer.toString(cnt));

        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return map;
    }
}

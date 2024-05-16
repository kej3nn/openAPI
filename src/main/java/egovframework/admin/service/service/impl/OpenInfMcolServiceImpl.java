package egovframework.admin.service.service.impl;

import java.util.*;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.service.service.OpenInfMcol;
import egovframework.admin.service.service.OpenInfSrv;
import egovframework.admin.service.service.OpenInfSrvService;
import egovframework.admin.service.service.OpenInfVcol;
import egovframework.admin.service.service.impl.helper.OpenInfQueryHelper;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.util.UtilString;
import lombok.NonNull;

/**
 * 메뉴를 관리를 위한 서비스 구현 클래스
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */

@Service("OpenInfMcolService")
public class OpenInfMcolServiceImpl extends OpenInfSrvServiceImpl implements OpenInfSrvService {

    private static final Logger logger = Logger.getLogger(OpenInfMcolServiceImpl.class);
    @Resource(name = "OpenInfMcolDAO")
    private OpenInfMcolDAO openInfMolDAO;

    @Autowired
    public OpenInfQueryHelper openInfQueryHelper;

    public Map<String, Object> selectOpenInfColList(OpenInfSrv openInfSrv) {
        logger.debug("map임");
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenInfMcol> result = openInfMolDAO.selectOpenInfColList(openInfSrv);
            map.put("resultList", result);
            map.put("resultCnt", result.size());

        } catch (DataAccessException dae) {
            EgovWebUtil.exLogging(dae);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return map;
    }

    public int openInfColCUD(OpenInfSrv openInfSrv, ArrayList<?> list) {
        int result = 0;
        try {
            result = openInfSrvDAO.mergeInto(openInfSrv);
            result = openInfSrvDAO.insertSrvConn(openInfSrv);
            for (int i = 0; i < list.size(); i++) {
                if (!((OpenInfMcol) list.get(i)).getStatus().equals("D")) {
                    result = openInfMolDAO.mergeIntoCol((OpenInfMcol) list.get(i));
                }
            }

        } catch (DataAccessException dae) {
            EgovWebUtil.exTransactionLogging(dae);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
        return result;
    }

    public Map<String, Object> selectOpenInfColPopInfo(OpenInfSrv openInfSrv) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            OpenInfMcol result = openInfMolDAO.selectOpenInfColInfo(openInfSrv);
            map.put("resultList", result);

        } catch (DataAccessException dae) {
            EgovWebUtil.exLogging(dae);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return map;
    }

    public int openInColOptPopupCUD(Object object) {
        int result = 0;
        try {
            result = openInfMolDAO.updateOpt((OpenInfMcol) object);

        } catch (DataAccessException dae) {
            EgovWebUtil.exTransactionLogging(dae);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
        return result;
    }

    public Map<String, Object> selectOpenInfColViewPopInfo(@NonNull OpenInfSrv openInfSrv) {

        Map<String, Object> map = new HashMap<String, Object>();
        try {
            //1. 테이블, owner 정보
            List<OpenInfSrv> info = openInfSrvDAO.selectOpenInfSrvInfo(openInfSrv);
            openInfSrv.setTableNm(openInfQueryHelper.setTableInfo(info));

            //2. select절 가져옴
            openInfSrv.setSelectQuery(openInfQueryHelper.setSelectMCol(openInfMolDAO.selectOpenInfColViewPopInfo(openInfSrv)));

            //3. 시스템변수 가져옴
            openInfSrv.setCondQuery(openInfQueryHelper.setCondMCol(openInfMolDAO.selectOpenInfColViewPopInfoCond(openInfSrv)));

            //4 공표시간
            openInfSrv.setPubDttmQuery(UtilString.null2Blank(openInfSrvDAO.selectPubDttm(openInfSrv)));

            //5 메인 쿼리
            List<LinkedHashMap<String, ?>> result = openInfMolDAO.selectMetaListAll(openInfSrv);
            map.put("mapData", result);

            //6 컬럼 이름 조회
            List<OpenInfMcol> colList = openInfMolDAO.selectOpenInfColList(openInfSrv);
            map.put("colList", colList);

            if (!UtilString.isBlank(info.get(0).getyPos()) && !UtilString.isBlank(info.get(0).getxPos())) {
                map.put("latitude", info.get(0).getyPos());
                map.put("longitude", info.get(0).getxPos());
            } else if (result.size() > 0) {
                map.put("latitude", result.get(0).get("Y_WGS84"));
                map.put("longitude", result.get(0).get("X_WGS84"));
            } else {
                map.put("latitude", 0);
                map.put("longitude", 0);
            }

            if (!UtilString.isBlank(info.get(0).getMapLevel())) {
                map.put("mapLevel", info.get(0).getMapLevel());
            } else {
                map.put("mapLevel", "6");
            }

            map.put("infoWin", "Y");
            map.put("markerVal", info.get(0).getMarkerVal());
            map.put("infNm", info.get(0).getInfNm());

        } catch (DataAccessException dae) {
            EgovWebUtil.exLogging(dae);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return map;
    }

    @Override
    public Map<String, Object> selectMetaAllIbPaging(OpenInfSrv openInfSrv) {
        return null;
    }

    @Override
    public String selectInitX(OpenInfSrv openInfSrv) {

        return null;
    }

    @Override
    public int openInfAcolApiDup(OpenInfSrv OpenInfSrv) {

        return 0;
    }

    @Override
    public Map<String, Object> selectOpenInfAcolUriList(OpenInfSrv openInfSrv) {

        return null;
    }

    @Override
    public int openInfApiSaveCUD(OpenInfSrv openInfSrv, ArrayList<?> list) {

        return 0;
    }

    @Override
    public Map<String, Object> selectTvPopupCode(OpenInfSrv openInfSrv) {

        return null;
    }

    @Override
    public Map<String, Object> selectPreviewApiTestSelectVal(
            OpenInfSrv openInfSrv) {

        return null;
    }

    @Override
    public int selectGetMstSeq(OpenInfSrv openInfSrv) {

        return 0;
    }

    @Override
    public int selectGetInfSeq(OpenInfSrv openInfSrv) {

        return 0;
    }

    @Override
    public int updateTmnlImgFile(ArrayList<?> list) {

        return 0;
    }

    @Override
    public Map<String, Object> selectOpenInfColInfo(OpenInfSrv openInfSrv,
                                                    int linkSeq) {

        return null;
    }

    @Override
    public Map<String, Object> selectOpenInfColDtlList(OpenInfVcol openInfVcol) {

        return null;
    }

    @Override
    public int openInfVcolDetailSaveCUD(OpenInfSrv openInfSrv, ArrayList<?> list) {

        return 0;
    }
}
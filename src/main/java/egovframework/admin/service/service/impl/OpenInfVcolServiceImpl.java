package egovframework.admin.service.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.service.service.OpenInfSrv;
import egovframework.admin.service.service.OpenInfSrvService;
import egovframework.admin.service.service.OpenInfVcol;
import egovframework.admin.service.service.impl.helper.OpenInfQueryHelper;
import egovframework.com.cmm.EgovWebUtil;
import lombok.NonNull;

/**
 * 메뉴를 관리를 위한 서비스 구현 클래스
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */

@Service("OpenInfVcolService")
public class OpenInfVcolServiceImpl extends OpenInfSrvServiceImpl implements OpenInfSrvService {

    private static final Logger logger = Logger.getLogger(OpenInfVcolServiceImpl.class);

    @Resource(name = "OpenInfVcolDAO")
    private OpenInfVcolDAO openInfColDAO;

    @Autowired
    public OpenInfQueryHelper openInfQueryHelper;

    /**
     * 리스트 출력
     */
    @Override
    public Map<String, Object> selectOpenInfColList(OpenInfSrv openInfSrv) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenInfVcol> result = openInfColDAO.selectOpenInfColList(openInfSrv);
            map.put("resultList", result);
            map.put("resultCnt", result.size());

        } catch (DataAccessException dae) {
            EgovWebUtil.exLogging(dae);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return map;
    }

    /**
     * 데이터 저장
     */
    @Override
    public int openInfColCUD(@NonNull OpenInfSrv openInfSrv, ArrayList<?> list) {
        int result = 0;
        try {
            // 서비스여부 변경시
            if (StringUtils.defaultString(openInfSrv.getDataModified()).equals("Y")) {
                result = openInfSrvDAO.mergeInto(openInfSrv);
                result = openInfSrvDAO.insertSrvConn(openInfSrv);
            }
            for (int i = 0; i < list.size(); i++) {
                if (!((OpenInfVcol) list.get(i)).getStatus().equals("D")) {
                    result = openInfColDAO.mergeIntoCol((OpenInfVcol) list.get(i));
                }
            }

        } catch (DataAccessException dae) {
            EgovWebUtil.exTransactionLogging(dae);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
        return result;
    }

    /**
     * 팝업 정보
     */
    @Override
    public Map<String, Object> selectOpenInfColViewPopInfo(OpenInfSrv openInfSrv) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenInfVcol> resultList = openInfColDAO.selectOpenInfColPopList(openInfSrv);
            map.put("resultList", resultList);

        } catch (DataAccessException dae) {
            EgovWebUtil.exLogging(dae);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return map;
    }


    @Override
    public Map<String, Object> selectOpenInfColPopInfo(OpenInfSrv OpenInfSrv) {

        return null;
    }


    @Override
    public int openInColOptPopupCUD(Object object) {

        return 0;
    }


    @Override
    public Map<String, Object> selectMetaAllIbPaging(OpenInfSrv OpenInfSrv) {

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
        int result = 0;
        try {
            result = openInfColDAO.selectGetMstSeq(openInfSrv);

        } catch (DataAccessException dae) {
            EgovWebUtil.exLogging(dae);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    @Override
    public int selectGetInfSeq(OpenInfSrv openInfSrv) {
        int result = 0;
        try {
            result = openInfColDAO.selectGetInfSeq(openInfSrv);
        } catch (DataAccessException dae) {
            EgovWebUtil.exLogging(dae);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    /**
     * 썸네일 이미지 정보를 수정합니다.
     *
     * @param list
     * @return
     */
    @Override
    public int updateTmnlImgFile(ArrayList<?> list) {
        int result = 0;

        for (int i = 0; i < list.size(); i++) {
            result = openInfColDAO.updateTmnlImgFile((OpenInfVcol) list.get(i));
        }
        return result;
    }

    /**
     * 썸네일 이미지 파일명을 조회한다.
     *
     * @param openInfSrv
     * @return
     */
    @Override
    public Map<String, Object> selectOpenInfColInfo(OpenInfSrv openInfSrv, int vistnSeq) {
        OpenInfVcol param = (OpenInfVcol) openInfSrv;
        param.setVistnSeq(vistnSeq);
        List<OpenInfVcol> resultList = openInfColDAO.selectOpenInfColInfo(param);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("resultImg", resultList);
        return map;
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
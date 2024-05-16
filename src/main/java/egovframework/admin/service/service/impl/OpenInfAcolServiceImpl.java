package egovframework.admin.service.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.service.service.OpenInfAcol;
import egovframework.admin.service.service.OpenInfCcol;
import egovframework.admin.service.service.OpenInfLcol;
import egovframework.admin.service.service.OpenInfScol;
import egovframework.admin.service.service.OpenInfSrv;
import egovframework.admin.service.service.OpenInfSrvService;
import egovframework.admin.service.service.OpenInfVcol;
import egovframework.admin.service.service.impl.helper.OpenInfQueryHelper;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.util.UtilString;

/**
 * 메뉴를 관리를 위한 서비스 구현 클래스
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */

@Service("OpenInfAcolService")
public class OpenInfAcolServiceImpl extends OpenInfSrvServiceImpl implements OpenInfSrvService {

    private static final Logger logger = Logger.getLogger(OpenInfAcolServiceImpl.class);

    @Resource(name = "OpenInfAcolDAO")
    private OpenInfAcolDAO openInfColDAO;

    @Autowired
    public OpenInfQueryHelper openInfQueryHelper;


    /**
     * Open API 팝업
     */
    @Override
    public Map<String, Object> selectOpenInfColPopInfo(OpenInfSrv openInfSrv) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            OpenInfAcol result = openInfColDAO.selectOpenInfColInfo(openInfSrv);
            map.put("resultList", result);
        } catch (DataAccessException dae) {
            EgovWebUtil.exLogging(dae);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return map;
    }

    /**
     * Open API 리스트
     */
    public Map<String, Object> selectOpenInfColList(OpenInfSrv openInfSrv) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenInfAcol> result = openInfColDAO.selectOpenInfColList(openInfSrv);
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
     * Open API CUD
     */
    public int openInfColCUD(OpenInfSrv openInfSrv, ArrayList<?> list) {
        int result = 0;
        try {
            result = openInfSrvDAO.mergeInto(openInfSrv);
            result = openInfSrvDAO.insertSrvConn(openInfSrv);
            for (int i = 0; i < list.size(); i++) {
                if (!((OpenInfAcol) list.get(i)).getStatus().equals("D")) {
                    result = openInfColDAO.mergeIntoCol((OpenInfAcol) list.get(i));
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
     * Open API 리스스명 중복체크
     */
    @Override
    public int openInfAcolApiDup(OpenInfSrv OpenInfSrv) {
        int result = 0;
        try {
            if (openInfColDAO.openInfAcolApiDup(OpenInfSrv) > 0) {
                return -1;
            }

        } catch (DataAccessException dae) {
            EgovWebUtil.exLogging(dae);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    /**
     * Open API URI 리스트
     */
    @Override
    public Map<String, Object> selectOpenInfAcolUriList(OpenInfSrv openInfSrv) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenInfAcol> result = openInfColDAO.selectApiUriList(openInfSrv);
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
     * Open API URI CUD
     */
    @Override
    public int openInfApiSaveCUD(OpenInfSrv openInfSrv, ArrayList<?> list) {
        int result = 0;
        //result = openInfSrvDAO.mergeInto(openInfSrv);
        try {
            for (int i = 0; i < list.size(); i++) {
                if (!((OpenInfAcol) list.get(i)).getStatus().equals("D")) {
                    result = openInfColDAO.mergeIntoApi((OpenInfAcol) list.get(i));
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
     * Open API 팝업 수정
     */
    @Override
    public int openInColOptPopupCUD(Object object) {
        int result = 0;
        try {
            result = openInfColDAO.updateOpt((OpenInfAcol) object);
        } catch (DataAccessException dae) {
            EgovWebUtil.exTransactionLogging(dae);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
        return result;
    }

    /**
     * Open API 미리보기
     */
    @Override
    public Map<String, Object> selectOpenInfColViewPopInfo(OpenInfSrv openInfSrv) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenInfAcol> printVal = openInfColDAO.selectPreviewPrintVal(openInfSrv);        //미리보기 출력값
            List<OpenInfAcol> resultMsg = openInfColDAO.selectPreviewResultMsg(openInfSrv);        //미리보기 에러메시지
            List<OpenInfAcol> sampleUri = openInfColDAO.selectApiUriList(openInfSrv);            //미리보기 URI LIST
            List<OpenInfAcol> reqVar = openInfColDAO.selectPreviewReqVar(openInfSrv);            //미리보기 요청변수
            List<OpenInfAcol> apiList = openInfColDAO.selectPreviewApiTest(openInfSrv);            //미리보기 테스트
            map.put("printVal", printVal);        //출력값
            map.put("sampleUri", sampleUri);    //샘플URI
            map.put("resultMsg", resultMsg);    //처리메세지
            map.put("reqVar", reqVar);            //검색요청인자
            map.put("apiList", apiList);        //API Test
            map.put("apiListCnt", apiList.size());    //API Test size

        } catch (DataAccessException dae) {
            EgovWebUtil.exLogging(dae);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return map;
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
    public Map<String, Object> selectTvPopupCode(OpenInfSrv openInfSrv) {

        return null;
    }

    /**
     * Open API 미리보기 URL 테스트시 컬럼 조건이 기준정보에 있으면 selectBox 설정
     */
    @Override
    public Map<String, Object> selectPreviewApiTestSelectVal(OpenInfSrv openInfSrv) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenInfAcol> filtCd = openInfColDAO.selectPreviewApiTestSelectVal(openInfSrv);
            map.put("filtCd", filtCd);

        } catch (DataAccessException dae) {
            EgovWebUtil.exLogging(dae);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return map;
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
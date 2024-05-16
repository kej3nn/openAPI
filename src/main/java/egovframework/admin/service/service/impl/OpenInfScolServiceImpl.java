package egovframework.admin.service.service.impl;

import java.util.*;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.service.service.OpenInfScol;
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

@Service("OpenInfScolService")
public class OpenInfScolServiceImpl extends OpenInfSrvServiceImpl implements OpenInfSrvService {

    private static final Logger logger = Logger.getLogger(OpenInfScolServiceImpl.class);

    @Resource(name = "OpenInfScolDAO")
    private OpenInfScolDAO openInfSolDAO;


    @Autowired
    public OpenInfQueryHelper openInfQueryHelper;

    public Map<String, Object> selectOpenInfColList(OpenInfSrv openInfSrv) {
        logger.debug("sheet임");
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenInfScol> result = openInfSolDAO.selectOpenInfColList(openInfSrv);
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
                if (!((OpenInfScol) list.get(i)).getStatus().equals("D")) {
                    result = openInfSolDAO.mergeIntoCol((OpenInfScol) list.get(i));
                }
            }
    		/*
    	for(OpenInfScol openInfScol: list){
    		if(!((OpenInfScol)openInfScol).getStatus().equals("D")){
    			result = openInfColDAO.mergeIntoCol((OpenInfScol)openInfScol);
    		}
    	}*/

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
            OpenInfScol result = openInfSolDAO.selectOpenInfColInfo(openInfSrv);
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
            String filtCd = ((OpenInfScol) object).getFiltCd();
            if (filtCd.equals("CHECK") || filtCd.equals("COMBO") || filtCd.equals("RADIO")) {
                logger.debug(((OpenInfScol) object).getFiltNeed1());
                ((OpenInfScol) object).setFiltDefault(((OpenInfScol) object).getFiltDefault1());
                ((OpenInfScol) object).setFiltNeed(((OpenInfScol) object).getFiltNeed1());
            } else if (filtCd.equals("POPUP")) {
                ((OpenInfScol) object).setFiltNeed(((OpenInfScol) object).getFiltNeed2());
                ((OpenInfScol) object).setFiltDefault(((OpenInfScol) object).getFiltDefault2());
                //팝업일때 그리고 디폴트값이 있으면 코드명을 넣는다.
                if (!UtilString.null2Blank(((OpenInfScol) object).getFiltDefault()).equals("")) {
                    ((OpenInfScol) object).setSrcColNm(UtilString.replace(((OpenInfScol) object).getSrcColId(), "_CD", "_NM"));
                    ((OpenInfScol) object).setFiltDefaultVal(((OpenInfScol) object).getFiltDefault());
                    ((OpenInfScol) object).setFiltDefaultNm(openInfSolDAO.selectOptFiltNm((OpenInfScol) object));
                }

            } else {
                ((OpenInfScol) object).setFiltDefault("");
                ((OpenInfScol) object).setFiltNeed("N");
            }
            result = openInfSolDAO.updateOpt((OpenInfScol) object);

        } catch (DataAccessException dae) {
            EgovWebUtil.exTransactionLogging(dae);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
        return result;
    }

    public Map<String, Object> selectOpenInfColViewPopInfo(OpenInfSrv openInfSrv) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenInfScol> result = openInfSolDAO.selectOpenInfColViewPopInfo(openInfSrv);
            List<OpenInfScol> result2 = openInfSolDAO.selectOpenInfColViewPopInfoFilt(openInfSrv);
            List<OpenInfScol> result3 = openInfSolDAO.selectOpenInfColViewPopInfoFiltDtl(openInfSrv);
            map.put("head", result);
            map.put("cond", result2);
            map.put("condDtl", result3);
            map.put("cols", openInfSolDAO.selectOpenInfColViewPopInfoIbs(openInfSrv));
            //map.put("fsObj", openInfSolDAO.selectOpenInfFsYn(openInfSrv));

        } catch (DataAccessException dae) {
            EgovWebUtil.exLogging(dae);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return map;
    }

    public Map<String, Object> selectMetaAllIbPaging(@NonNull OpenInfSrv openInfSrv) {

        Map<String, Object> map = new HashMap<String, Object>();
        try {
            //1. 테이블, owner 정보
            List<OpenInfSrv> info = openInfSrvDAO.selectOpenInfSrvInfo(openInfSrv);
            openInfSrv.setTableNm(openInfQueryHelper.setTableInfo(info));
            List<OpenInfScol> head = null;
            //2. select절 가져옴
            head = openInfSolDAO.selectOpenInfColViewPopInfo(openInfSrv);

            openInfSrv.setSelectQuery(openInfQueryHelper.setSelectCol(head));

            //3. 조회조건 매핑함
            List<OpenInfScol> where = openInfSolDAO.selectOpenInfColViewPopInfoFilt(openInfSrv);
            if (openInfSrv.getQueryString() != null) {
                String arrVar[] = UtilString.getSplitArray(openInfSrv.getQueryString(), "&");
                openInfSrv.setWhereQuery(openInfQueryHelper.setWhereCol(where, arrVar));
            }

            //4. 시스템변수 가져옴
            List<OpenInfScol> cond = openInfSolDAO.selectOpenInfColViewPopInfoCond(openInfSrv);
            openInfSrv.setCondQuery(openInfQueryHelper.setCondCol(cond));

            //5. 정렬
            List<OpenInfScol> orderBy = openInfSolDAO.selectOpenInfColViewPopInfoOrderBy(openInfSrv);
            openInfSrv.setOrderByQuery(openInfQueryHelper.setOrderByCol(orderBy));

            //7 공표시간
            openInfSrv.setPubDttmQuery(UtilString.null2Blank(openInfSrvDAO.selectPubDttm(openInfSrv)));
            //openInfSolDAO.selectMetaListAll2(openInfSrv);
            //8 메인 쿼리
            List<LinkedHashMap<String, ?>> result = openInfSolDAO.selectMetaListAll(openInfSrv);

            map.put("resultList", result);
            if (result != null) {
                if (result.size() > 0) {
                    map.put("resultCnt", result.get(0).get("WISEOPEN_CNT") + "");
                } else {
                    map.put("resultCnt", "0");
                }
            } else {
                map.put("resultCnt", "0");
            }

            map.put("infNm", info.get(0).getInfNm());
            map.put("head", openInfQueryHelper.setTitleCol(head));
            map.put("type", openInfSolDAO.selectOpenInfColViewPopInfoType(openInfSrv));

        } catch (DataAccessException dae) {
            EgovWebUtil.exLogging(dae);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return map;

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

    public Map<String, Object> selectTvPopupCode(OpenInfSrv openInfSrv) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            map.put("list", openInfSolDAO.selectTvPopupCode(openInfSrv));
            map.put("listCnt", openInfSolDAO.selectTvPopupCodeCnt(openInfSrv));

        } catch (DataAccessException dae) {
            EgovWebUtil.exLogging(dae);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return map;
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
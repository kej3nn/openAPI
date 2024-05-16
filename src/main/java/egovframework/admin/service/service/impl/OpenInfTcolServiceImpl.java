package egovframework.admin.service.service.impl;

import java.util.*;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.service.service.OpenInfSrv;
import egovframework.admin.service.service.OpenInfSrvService;
import egovframework.admin.service.service.OpenInfTcol;
import egovframework.admin.service.service.OpenInfVcol;
import egovframework.admin.service.service.impl.helper.OpenInfQueryHelper;
import egovframework.admin.service.service.impl.helper.OpenInfTcolHelper;
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

@Service("OpenInfTcolService")
public class OpenInfTcolServiceImpl extends OpenInfSrvServiceImpl implements OpenInfSrvService {

    private static final Logger logger = Logger.getLogger(OpenInfTcolServiceImpl.class);
    @Resource(name = "OpenInfTcolDAO")
    private OpenInfTcolDAO openInfColDAO;

    @Autowired
    public OpenInfQueryHelper openInfQueryHelper;

    @Autowired
    public OpenInfTcolHelper openInfTcolHelper;

    public Map<String, Object> selectOpenInfColList(OpenInfSrv openInfSrv) {
        logger.debug("map임");
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenInfTcol> result = openInfColDAO.selectOpenInfColList(openInfSrv);
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
                if (!((OpenInfTcol) list.get(i)).getStatus().equals("D")) {
                    result = openInfColDAO.mergeIntoCol((OpenInfTcol) list.get(i));
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
            OpenInfTcol result = openInfColDAO.selectOpenInfColInfo(openInfSrv);
            map.put("resultList", result);
            map.put("dtId", result.getDtId());

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
            result = openInfColDAO.updateOpt((OpenInfTcol) object);
        } catch (DataAccessException dae) {
            EgovWebUtil.exTransactionLogging(dae);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    public Map<String, Object> selectOpenInfColViewPopInfo(@NonNull OpenInfSrv openInfSrv) {
        Map<String, Object> map = new HashMap<String, Object>();
        List<LinkedHashMap<String, Object>> result = new ArrayList<LinkedHashMap<String, Object>>();

        try {
            /*DATA 가져오는 부분 START*/
            OpenInfSrv search = openInfColDAO.selectOpenInfColViewPopInfo(openInfSrv); //조회 조건 넣기
            map.put("treeDate", openInfColDAO.selectItemDtl(openInfSrv)); //트리가져와서 넣기


            //select 컬럼 부분 가져오기
            List<OpenInfTcol> selectObj = openInfColDAO.selectSelectCol(openInfSrv);
            search.setTselectQuery(openInfQueryHelper.setSelectTCol(selectObj, StringUtils.defaultString(openInfSrv.getViewLang())));
            //조건절 컬럼 부분 가져와서 셋팅
            search.setWhereQuery(openInfQueryHelper.setTCondCol(openInfColDAO.selectWhereCol(openInfSrv)));
            //group by절
            search.setGroupByQuery(openInfQueryHelper.setSelectGroupBy(selectObj));

            OpenInfTcol yyDate = openInfColDAO.selectMetaStartEndDateYy(search);//시작값과 종료값 가져오기
            OpenInfTcol mmDate = openInfColDAO.selectMetaStartEndDateMm(search);//시작값과 종료값 가져오기
            OpenInfTcol qqDate = openInfColDAO.selectMetaStartEndDateQq(search);//시작값과 종료값 가져오기
            /*DATA 가져오는 부분 END*/

            /*시작 종료일자 셋팅 START*/
            //int maxCnt = Integer.parseInt(search.getMaxCnt()); //최대건수
            int maxCnt = 0;
            int itemCnt = Integer.parseInt(search.getItemCnt()); //아이템건수
            String ymqTag = "Y";
            boolean first = true;
            if (StringUtils.defaultString(openInfSrv.getFirstYn()).equals("N")) { //조회조건에 따라서
                //tsDate = openInfTcolHelper.setDate(StringUtils.defaultString(openInfSrv.getYmqTag()),openInfSrv);
                first = false;
            } else {//초기 기본 셋팅
				/*
    		if(search.getYmqTagM().equals("1")){
    			ymqTag ="M";
    			tsDate = openInfTcolHelper.setDate(ymqTag,mmDate);
        	}else if(search.getYmqTagQ().equals("1")){
        		ymqTag ="Q";
        		tsDate = openInfTcolHelper.setDate(ymqTag,qqDate);
        	}else{
        		tsDate = openInfTcolHelper.setDate(ymqTag,yyDate);
        	}*/
                //openInfSrv.setYmqTag(ymqTag);
            }
            int tsDate[] = openInfTcolHelper.setDate(ymqTag, yyDate);

            /*시작 종료일자 셋팅 END*/

            /*그리드 TITLE, ID 가져옴 START*/
            Map<String, Object> headMap = openInfTcolHelper.selectYmqTagHead(openInfSrv, maxCnt, itemCnt, tsDate, first, selectObj); //
            /*그리드 TITLE, ID 가져옴 END*/

            /*그리드 컬럼 셋팅 START*/
            if (UtilString.null2Blank(openInfSrv.getViewTag()).equals("S")) {//세로
                openInfSrv.setStartPage(0);
                openInfSrv.setTsQuery(openInfQueryHelper.getTsDate(openInfSrv, search, (String) headMap.get("selectCol"), (String) headMap.get("loop")));
                List<LinkedHashMap<String, ?>> data = openInfColDAO.selectMetaListAll(openInfSrv);
                LinkedHashMap<String, Object> returnMap = openInfTcolHelper.setSeroGridCol(data, selectObj);
                result = (List<LinkedHashMap<String, Object>>) returnMap.get("result");
                headMap.put("gridColHead", (List<LinkedHashMap<String, Object>>) returnMap.get("gridColHead"));

                map.put("downColHead", returnMap.get("downColHead"));
                map.put("downColId", returnMap.get("downColId"));

            } else if (UtilString.null2Blank(openInfSrv.getViewTag()).equals("P")) {
                String gridColId[] = UtilString.getSplitArray((String) headMap.get("gridColId"), "|");
                result = openInfTcolHelper.setCaroGridCol(gridColId, itemCnt);
                map.put("downColHead", headMap.get("textGridColHead"));
                map.put("downColId", headMap.get("gridColId"));
            } else {
                String gridColId[] = UtilString.getSplitArray((String) headMap.get("gridColId"), "|");
                result = openInfTcolHelper.setCaroGridCol(gridColId, itemCnt);
                map.put("downColHead", headMap.get("textGridColHead"));
                map.put("downColId", headMap.get("gridColId"));
            }
            map.put("infNm", search.getInfNm());
            map.put("yyDate", yyDate);
            map.put("mmDate", mmDate);
            map.put("qqDate", qqDate);
            map.put("col", result);
            map.put("info", headMap);
            map.put("search", search);

            if (itemCnt == 2) {
                map.put("UNIT_CD", openInfColDAO.selectItemUnitCd2(openInfSrv));//단위가져오기
            } else {
                map.put("UNIT_CD", openInfColDAO.selectItemUnitCd(openInfSrv));//단위가져오기
            }

        } catch (DataAccessException dae) {
            EgovWebUtil.exLogging(dae);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }


        return map;
    }

    public Map<String, Object> selectMetaAllIbPaging(@NonNull OpenInfSrv openInfSrv) {
        Map<String, Object> map = new HashMap<String, Object>();
        List<LinkedHashMap<String, ?>> returnResult = new ArrayList<LinkedHashMap<String, ?>>();

        try {
            /*조회조건 가져오는 부분 START*/
            OpenInfSrv search = openInfColDAO.selectOpenInfColViewPopInfo(openInfSrv);
            //select 컬럼 부분 가져오기
            List<OpenInfTcol> selectObj = openInfColDAO.selectSelectCol(openInfSrv);
            search.setTselectQuery(openInfQueryHelper.setSelectTCol(selectObj, StringUtils.defaultString(openInfSrv.getViewLang())));
            //조건절 컬럼 부분 가져와서 셋팅
            search.setWhereQuery(openInfQueryHelper.setTCondCol(openInfColDAO.selectWhereCol(openInfSrv)));
            //group by절
            search.setGroupByQuery(openInfQueryHelper.setSelectGroupBy(selectObj));
            /*시작 종료일자 셋팅 START*/
            //int maxCnt = Integer.parseInt(search.getMaxCnt());
            int maxCnt = 0;
            int itemCnt = Integer.parseInt(search.getItemCnt());
            //int tsDate[] = openInfTcolHelper.setDate(openInfSrv.getYmqTag(),openInfSrv);
            int tsDate[] = openInfTcolHelper.setDate("Y", openInfSrv);
            Map<String, Object> headMap = openInfTcolHelper.selectYmqTagHead(openInfSrv, maxCnt, itemCnt, tsDate, false, selectObj);
            /*조회 쿼리 생성 및 실행 START*/
            openInfSrv.setTsQuery(openInfQueryHelper.getTsDate(openInfSrv, search, (String) headMap.get("selectCol"), (String) headMap.get("loop")));
            if ((UtilString.null2Blank(openInfSrv.getViewTag()).equals("S"))) {
                openInfSrv.setStartPage(0);
            }
            List<LinkedHashMap<String, ?>> caroResult = openInfColDAO.selectMetaListAll(openInfSrv);
            int cnt = openInfColDAO.selectMetaListAllCnt(openInfSrv);
            /* 가로 세로 표로보기 data 만들기 START*/
            if (UtilString.null2Blank(openInfSrv.getViewTag()).equals("S")) {
                returnResult = openInfTcolHelper.setSeroData(caroResult, UtilString.getSplitArray((String) headMap.get("gridColHeadString"), "|"), selectObj.size());
                cnt = returnResult.size();
            } else if (UtilString.null2Blank(openInfSrv.getViewTag()).equals("P")) { //표로보기
                returnResult = caroResult;
            } else if (UtilString.null2Blank(openInfSrv.getViewTag()).equals("CC")) { //챠트로기
                returnResult = openInfTcolHelper.setChartData(caroResult, UtilString.getSplitArray((String) headMap.get("gridDataHeadString"), "|"), UtilString.getSplitArray((String) headMap.get("dataYear"), "|"));
                cnt = returnResult.size();
            } else {
                returnResult = caroResult;
            }
            //공공데이터명 구하기(다운로드에서 사용)
            map.put("infNm", search.getInfNm());
            map.put("resultList", returnResult);
            map.put("resultCnt", cnt + "");

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
    public Map<String, Object> selectOpenInfAcolUriList(OpenInfSrv openInfSrv) {

        return null;
    }

    @Override
    public int openInfApiSaveCUD(OpenInfSrv openInfSrv, ArrayList<?> list) {

        return 0;
    }

    @Override
    public int openInfAcolApiDup(OpenInfSrv OpenInfSrv) {

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
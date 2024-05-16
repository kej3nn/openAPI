package egovframework.admin.service.service.impl;

import java.util.*;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.service.service.OpenInfCcol;
import egovframework.admin.service.service.OpenInfSrv;
import egovframework.admin.service.service.OpenInfSrvService;
import egovframework.admin.service.service.OpenInfVcol;
import egovframework.admin.service.service.impl.helper.OpenInfQueryHelper;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.util.UtilString;
import lombok.NonNull;

@Service("OpenInfCcolService")
public class OpenInfCcolServiceImpl extends OpenInfSrvServiceImpl implements OpenInfSrvService {

    @Resource(name = "OpenInfCcolDAO")
    private OpenInfCcolDAO openInfColDAO;

    @Resource(name = "OpenInfScolDAO")
    private OpenInfScolDAO openInfSolDAO;

    @Autowired
    public OpenInfQueryHelper openInfQueryHelper;

    private static final Logger logger = Logger.getLogger(OpenInfCcolServiceImpl.class);

    public Map<String, Object> selectOpenInfColList(OpenInfSrv openInfSrv) {
//    	logger.debug("chart임");
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenInfCcol> result = openInfColDAO.selectOpenInfColList(openInfSrv);
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
                if (!((OpenInfCcol) list.get(i)).getStatus().equals("D")) {
                    result = openInfColDAO.mergeIntoCol((OpenInfCcol) list.get(i));
                }
            }

        } catch (DataAccessException dae) {
            EgovWebUtil.exTransactionLogging(dae);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
        return result;
    }


    @Override
    public Map<String, Object> selectOpenInfColPopInfo(OpenInfSrv openInfSrv) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            OpenInfCcol result = openInfColDAO.selectOpenInfColInfo(openInfSrv);
            map.put("resultList", result);

        } catch (DataAccessException dae) {
            EgovWebUtil.exLogging(dae);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return map;
    }

    @Override
    public int openInColOptPopupCUD(Object object) {
        int result = 0;
        try {
            String filtCd = ((OpenInfCcol) object).getFiltCd();
            if (filtCd.equals("CHECK") || filtCd.equals("COMBO") || filtCd.equals("RADIO")) {
                logger.debug(((OpenInfCcol) object).getFiltNeed1());
                ((OpenInfCcol) object).setFiltDefault(((OpenInfCcol) object).getFiltDefault1());
                ((OpenInfCcol) object).setFiltNeed(((OpenInfCcol) object).getFiltNeed1());
            } else if (filtCd.equals("POPUP")) {
                logger.debug(((OpenInfCcol) object).getFiltNeed2());
                ((OpenInfCcol) object).setFiltDefault(((OpenInfCcol) object).getFiltDefault2());
                ((OpenInfCcol) object).setFiltNeed(((OpenInfCcol) object).getFiltNeed2());
                if (!UtilString.null2Blank(((OpenInfCcol) object).getFiltDefault()).equals("")) {
                    ((OpenInfCcol) object).setSrcColNm(UtilString.replace(((OpenInfCcol) object).getSrcColId(), "_CD", "_NM"));
                    ((OpenInfCcol) object).setFiltDefaultVal(((OpenInfCcol) object).getFiltDefault());
                    ((OpenInfCcol) object).setFiltDefaultNm(openInfColDAO.selectOptFiltNm((OpenInfCcol) object));
                }
            } else {
                ((OpenInfCcol) object).setFiltDefault("");
                ((OpenInfCcol) object).setFiltNeed("N");
            }
            result = openInfColDAO.updateOpt((OpenInfCcol) object);

        } catch (DataAccessException dae) {
            EgovWebUtil.exTransactionLogging(dae);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
        return result;
    }

    @Override
    public Map<String, Object> selectOpenInfColViewPopInfo(@NonNull OpenInfSrv openInfSrv) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<OpenInfCcol> result = openInfColDAO.selectOpenInfColViewPopInfo(openInfSrv);
            List<OpenInfCcol> result2 = openInfColDAO.selectOpenInfColViewPopInfoFilt(openInfSrv);
            List<OpenInfCcol> result3 = openInfColDAO.selectOpenInfColViewPopInfoFiltDtl(openInfSrv);

            List<OpenInfCcol> srvChart = openInfColDAO.selectOpenInfSrvChart(openInfSrv);
            List<OpenInfCcol> ccolChart = openInfColDAO.selectOpenInfCcolChart(openInfSrv);

            String rytitNm = srvChart.get(0).getRytitNm();
            if (rytitNm != null) {
                openInfSrv.setRyposYn("Y");
            }

            List<OpenInfCcol> yColResult = openInfColDAO.getYcol(openInfSrv);
            List<OpenInfCcol> yColResult2 = openInfColDAO.getYcol2(openInfSrv);        //오른쪽 y축이 있을 경우..
            List<OpenInfCcol> xColResult = openInfColDAO.getXcol(openInfSrv);

            List<OpenInfCcol> totSeries = openInfColDAO.getTotSeries(openInfSrv);
            List<OpenInfCcol> seriesResult = openInfColDAO.getSeriesResult(openInfSrv);
            List<OpenInfCcol> seriesResult2 = openInfColDAO.getSeriesResult2(openInfSrv);

            // 테이블 정보
            openInfSrv.setTableNm(openInfQueryHelper.setChartTableInfo(ccolChart));

            // Y축컬럼 정보
            openInfSrv.setyColQuery(openInfQueryHelper.setXYcol(yColResult));

            //오른쪽 Y축컬럼 정보
            openInfSrv.setRyColQuery(openInfQueryHelper.setXYcol(yColResult2));

            // X축컬럼 정보
            openInfSrv.setxColQuery(openInfQueryHelper.setXYcol(xColResult));

            // 데이터제한 정보
            List<OpenInfCcol> cond = openInfColDAO.selectOpenInfColViewPopInfoCond(openInfSrv);
            openInfSrv.setCondQuery(openInfQueryHelper.setCondCcol(cond));

            // 필터조건 정보
            if (openInfSrv.getQueryString() != null) {
                List<OpenInfCcol> where = openInfColDAO.selectOpenInfColViewPopInfoFilt(openInfSrv);
                String arrVar[] = UtilString.getSplitArray(openInfSrv.getQueryString(), "&");
                openInfSrv.setWhereQuery(openInfQueryHelper.setWhereCcol(where, arrVar));
            }
            //데이터 정렬
            List<OpenInfCcol> orderBy = openInfColDAO.selectOpenInfColViewPopInfoOrderBy(openInfSrv);
            openInfSrv.setOrderByQuery(openInfQueryHelper.setOrderByCcol(orderBy));


            // 차트 데이터 정보
            List<LinkedHashMap<String, ?>> chartDataX = openInfColDAO.selectChartDataX(openInfSrv);
            List<LinkedHashMap<String, ?>> chartDataY = null;
            if (!"".equals(openInfSrv.getyColQuery())) {
                chartDataY = openInfColDAO.selectChartDataY(openInfSrv);
            }
            List<LinkedHashMap<String, ?>> chartDataRY = null;
            if (!"".equals(openInfSrv.getRyColQuery())) {
                chartDataRY = openInfColDAO.selectChartDataRY(openInfSrv);
            }

            map.put("head", result);
            map.put("cond", result2);
            map.put("condDtl", result3);
            map.put("srvChart", srvChart);
            map.put("totSeries", totSeries);
            map.put("seriesResult", seriesResult);
            map.put("seriesResult2", seriesResult2);
            map.put("seriesResultCnt", seriesResult.size());
            map.put("seriesResultCnt2", seriesResult2.size());
            map.put("chartDataX", chartDataX);
            map.put("chartDataY", chartDataY);
            map.put("chartDataRY", chartDataRY);
            //map.put("fsObj", openInfColDAO.selectOpenInfFsYn(openInfSrv));

        } catch (DataAccessException dae) {
            EgovWebUtil.exLogging(dae);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return map;
    }

    public String selectInitX(OpenInfSrv openInfSrv) {
        String result = "";
        try {
            result = openInfColDAO.selectInitX(openInfSrv);

        } catch (DataAccessException dae) {
            EgovWebUtil.exLogging(dae);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }
    
/*    @Override
	public Map<String, Object> selectMetaAllIbPaging(OpenInfSrv OpenInfSrv)
			throws Exception {
		
		return null;
	}*/

    @Override
    public Map<String, Object> selectMetaAllIbPaging(@NonNull OpenInfSrv openInfSrv) {
        Map<String, Object> map = new HashMap<String, Object>();

        try {
            List<OpenInfCcol> ccolChart = openInfColDAO.selectOpenInfCcolChart(openInfSrv);
            // 테이블 정보
            openInfSrv.setTableNm(openInfQueryHelper.setChartTableInfo(ccolChart));

            // 필터조건 정보
            if (openInfSrv.getQueryString() != null) {
                List<OpenInfCcol> where = openInfColDAO.selectOpenInfColViewPopInfoFilt(openInfSrv);
                String arrVar[] = UtilString.getSplitArray(openInfSrv.getQueryString(), "&");
                openInfSrv.setWhereQuery(openInfQueryHelper.setWhereCcol(where, arrVar));
            }

            // 데이터제한 정보
            List<OpenInfCcol> cond = openInfColDAO.selectOpenInfColViewPopInfoCond(openInfSrv);
            openInfSrv.setCondQuery(openInfQueryHelper.setCondCcol(cond));

            //데이터 정렬
            List<OpenInfCcol> orderBy = openInfColDAO.selectOpenInfColViewPopInfoOrderBy(openInfSrv);
            openInfSrv.setOrderByQuery(openInfQueryHelper.setOrderByCcol(orderBy));


            //1. 테이블, owner 정보
            List<OpenInfSrv> info = openInfSrvDAO.selectOpenInfSrvInfo(openInfSrv);
//    	openInfSrv.setTableNm(openInfQueryHelper.setTableInfo(info));

            //2. select절 가져옴
            List<OpenInfCcol> head = openInfColDAO.selectOpenInfColViewPopInfo(openInfSrv);
            openInfSrv.setSelectQuery(openInfQueryHelper.setSelectCcol(head));

            //6 메인 쿼리
            List<LinkedHashMap<String, ?>> result = openInfColDAO.selectMetaListAll(openInfSrv);
//		int cnt = openInfColDAO.selectMetaListCnt(openInfSrv);

            if (result != null) {
                if (result.size() > 0) {
                    map.put("resultCnt", result.get(0).get("WISEOPEN_CNT") + "");
                } else {
                    map.put("resultCnt", "0");
                }
            } else {
                map.put("resultCnt", "0");
            }

            map.put("resultList", result);
//		map.put("resultCnt", Integer.toString(cnt));
            map.put("infNm", info.get(0).getInfNm());
            map.put("head", openInfQueryHelper.setTitleCcol(head));

        } catch (DataAccessException dae) {
            EgovWebUtil.exLogging(dae);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return map;
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

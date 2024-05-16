package egovframework.admin.service.service.impl.helper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Component;

import egovframework.admin.service.service.OpenInfSrv;
import egovframework.admin.service.service.OpenInfTcol;
import egovframework.common.util.UtilString;

/**
 * 통계에서 사용하는 메소드 class
 *
 * @author wiseopen
 * @version 1.0
 * @see cheon
 * @since 2014.04.17
 */
@Component
public class OpenInfTcolHelper {
    protected static final Log logger = LogFactory.getLog(OpenInfTcolHelper.class);
    public static final int DEFAULT_LIST_CNT = 12;

    public int[] setDate(String ymqTag, OpenInfSrv date) {
        int tsDate[] = new int[4];
        if (ymqTag.equals("M")) {
            tsDate[0] = Integer.parseInt(date.getMmStYy() == null ? "2" : date.getMmStYy());
            tsDate[1] = Integer.parseInt(date.getMmStMq() == null ? "2" : date.getMmStMq());
            tsDate[2] = Integer.parseInt(date.getMmEnYy() == null ? "1" : date.getMmEnYy());
            tsDate[3] = Integer.parseInt(date.getMmEnMq() == null ? "1" : date.getMmEnMq());
        } else if (ymqTag.equals("Q")) {
            tsDate[0] = Integer.parseInt(date.getQqStYy() == null ? "2" : date.getQqStYy());
            tsDate[1] = Integer.parseInt(date.getQqStMq() == null ? "2" : date.getQqStMq());
            tsDate[2] = Integer.parseInt(date.getQqEnYy() == null ? "1" : date.getQqEnYy());
            tsDate[3] = Integer.parseInt(date.getQqEnMq() == null ? "1" : date.getQqEnMq());
        } else {
            tsDate[0] = Integer.parseInt(date.getYyStYy() == null ? "2" : date.getYyStYy());
            tsDate[1] = 0;
            tsDate[2] = Integer.parseInt(date.getYyEnYy() == null ? "1" : date.getYyEnYy());
            tsDate[3] = 0;
        }
        return tsDate;
    }

    public List<LinkedHashMap<String, Object>> setCaroGridCol(String[] gridColId, int itemCnt) {
        List<LinkedHashMap<String, Object>> result = new ArrayList<LinkedHashMap<String, Object>>();
        LinkedHashMap<String, Object> gridHeadMap;
        for (int i = 0; i < gridColId.length; i++) {
            gridHeadMap = new LinkedHashMap<String, Object>();
            String align = "Right";
            int size = 100;
            if (gridColId[i].equals("UNIT_CD") || gridColId[i].equals("CONV_CD") || gridColId[i].equals("WEIGHT")) {
                align = "Center";
            } else if (gridColId[i].equals("ITEM_CD1") || gridColId[i].equals("ITEM_CD2") || gridColId[i].equals("ITEM_NM1") || gridColId[i].equals("ITEM_NM2")) {
                align = "Left";
            }
            if (gridColId[i].equals("ITEM_CD1") || gridColId[i].equals("ITEM_NM1")) {
                size = 150;
            } else if (gridColId[i].equals("ITEM_CD2") || gridColId[i].equals("ITEM_NM2")) {
                size = 120;
            } else if (gridColId[i].equals("UNIT_CD")) {
                size = 60;
            } else if (gridColId[i].indexOf("COL") > -1) {
                size = 130;
            }
            gridHeadMap.put("Align", align);
            gridHeadMap.put("Type", "Text");
            gridHeadMap.put("Width", size);
            gridHeadMap.put("SaveName", gridColId[i]);
            if (gridColId[i].equals("ITEM_NM1") || gridColId[i].equals("ITEM_NM2")) {
                gridHeadMap.put("ColMerge", true);
            } else {
                gridHeadMap.put("ColMerge", 1);
            }
            gridHeadMap.put("Edit", "false");
            result.add(gridHeadMap);
        }
        return result;
    }

    public LinkedHashMap<String, Object> setSeroGridCol(List<LinkedHashMap<String, ?>> data, List<OpenInfTcol> selectObj) {

        LinkedHashMap<String, Object> gridColMap = new LinkedHashMap<String, Object>();
        LinkedHashMap<String, Object> gridHeadMap;
        LinkedHashMap<String, Object> returnMap = new LinkedHashMap<String, Object>();
        List<LinkedHashMap<String, Object>> colList = new ArrayList<LinkedHashMap<String, Object>>();
        List<LinkedHashMap<String, Object>> headList = new ArrayList<LinkedHashMap<String, Object>>();
        String arrhead[] = new String[selectObj.size()];
        String downColId = "";
        String downColHead = "";

        gridColMap.put("Align", "Center");
        gridColMap.put("Type", "Text");
        gridColMap.put("Type", "Text");
        gridColMap.put("Width", 100);
        gridColMap.put("SaveName", "COL" + 0);
        gridColMap.put("ColMerge", "1");
        gridColMap.put("Edit", "false");
        colList.add(gridColMap);
        downColId += "COL" + 0;
        for (int i = 0; i < data.size(); i++) {
            gridColMap = new LinkedHashMap<String, Object>();
            gridColMap.put("Align", "Right");
            gridColMap.put("Type", "Text");
            gridColMap.put("Type", "Text");
            gridColMap.put("Width", 100);
            gridColMap.put("SaveName", "COL" + (i + 1));
            gridColMap.put("ColMerge", "1");
            gridColMap.put("Edit", "false");
            downColId += "|COL" + (i + 1);

            colList.add(gridColMap);
            int j = 0;
            for (OpenInfTcol openInfTcol : selectObj) {
                if (i > 0) {
                    arrhead[j] += "|" + data.get(i).get(UtilString.replace(openInfTcol.getSrcColId(), "ITEM_CD", "ITEM_NM"));
                } else {
                    arrhead[j] = openInfTcol.getColNm();
                    arrhead[j] += "|" + data.get(i).get(UtilString.replace(openInfTcol.getSrcColId(), "ITEM_CD", "ITEM_NM"));
                }
                j++;

            }
        }
        for (int i = 0; i < arrhead.length; i++) {
            gridHeadMap = new LinkedHashMap<String, Object>();
            gridHeadMap.put("Text", arrhead[i]);
            gridHeadMap.put("Align", "Center");
            headList.add(gridHeadMap);
            if (i == 0) {
                downColHead += arrhead[i];
            } else {
                downColHead += "''''" + arrhead[i];
            }

        }
        returnMap.put("result", colList);
        returnMap.put("gridColHead", headList);

        returnMap.put("downColHead", downColHead);
        returnMap.put("downColId", downColId);
        return returnMap;
    }

    public List<LinkedHashMap<String, ?>> setSeroData(List<LinkedHashMap<String, ?>> caroResult, String[] gridColHead, int size) {
        List<LinkedHashMap<String, ?>> seroResult = new ArrayList<LinkedHashMap<String, ?>>();
        int cnt = 0;
        int arrCnt = 0;
        LinkedHashMap<String, Object> seroMap;
        Iterator<?> iterator = caroResult.get(0).entrySet().iterator();
        while (iterator.hasNext()) {
            Entry<?, ?> entry = (Entry<?, ?>) iterator.next();
            if (((String) entry.getKey()).equals("ITEM_CD1") ||
                    ((String) entry.getKey()).equals("ITEM_CD2") ||
                    ((String) entry.getKey()).equals("V_ORDER") ||
                    ((String) entry.getKey()).equals("YYYYMQ") ||
                    ((String) entry.getKey()).equals("RN") ||
                    ((String) entry.getKey()).equals("CONV_CD_1")) {
                continue;
            }
            seroMap = new LinkedHashMap<String, Object>();
            seroMap.put("COL" + cnt++, gridColHead[arrCnt++]);
            for (int i = 0; i < caroResult.size(); i++) {// 0번째에 1번들 다 넣고 , 1번째에
                LinkedHashMap<String, ?> map2 = caroResult.get(i);
                seroMap.put("COL" + cnt++, map2.get((String) entry.getKey()));
            }
            cnt = 0;
            if (arrCnt > size) {
                seroResult.add(seroMap);
            }
        }
        return seroResult;
    }

    public List<LinkedHashMap<String, ?>> setChartData(List<LinkedHashMap<String, ?>> caroResult, String[] gridColHead, String[] dataYear) {
        List<LinkedHashMap<String, ?>> chartResult = new ArrayList<LinkedHashMap<String, ?>>();
        List<LinkedHashMap<String, ?>> chartResult2 = null;
        LinkedHashMap<String, Object> chartMap = null;
        LinkedHashMap<String, Object> chartMap2 = null;


        for (LinkedHashMap<String, ?> map : caroResult) {
            chartResult2 = new ArrayList<LinkedHashMap<String, ?>>();
            for (int i = 0; i < gridColHead.length; i++) {
                chartMap = new LinkedHashMap<String, Object>();
                chartMap.put("X", UtilString.replace(dataYear[i], "/", ""));
                chartMap.put("Y", UtilString.replace((String) map.get(gridColHead[i]), ",", ""));
                chartMap.put("Name", dataYear[i]);
                chartMap.put("Sliecd", "false");
                chartResult2.add(chartMap);
            }
            chartMap2 = new LinkedHashMap<String, Object>();
            chartMap2.put("DATA", chartResult2);
            String title = (String) map.get("ITEM_NM1");
            if (!UtilString.null2Blank(map.get("ITEM_NM2")).equals("")) {
                title = (String) map.get("ITEM_NM1") + "/" + (String) map.get("ITEM_NM2");
            }
            chartMap2.put("TITLE", title);
            chartResult.add(chartMap2);
        }
        return chartResult;
    }

    //보기옵션, 최대건수, 아이템건수, 시작년, 시작월(분기_, 종료년, 종료월(분기)
    public Map<String, Object> selectYmqTagHead(OpenInfSrv openInfSrv, int maxCnt, int itemCnt, int[] tsDate, boolean fisrt, List<OpenInfTcol> selectObj) {
        int loop = 1;
        String viewTag = UtilString.null2Blank(openInfSrv.getViewTag());
        Map<String, Object> headMap = new HashMap<String, Object>();
        //String ymqTag = UtilString.null2Blank(openInfSrv.getYmqTag());
        String ymqTag = "Y";
        String gridColHead = "";
        String gridColId = "";
        String gridDataHead = "";
        String dataYear = "";
        for (OpenInfTcol openInfTcol : selectObj) {
            gridColHead += openInfTcol.getColNm() + "|";
            gridColId += UtilString.replace(openInfTcol.getSrcColId(), "ITEM_CD", "ITEM_NM") + "|";
        }
        gridColHead = gridColHead.substring(0, gridColHead.length() - 1);
        gridColId = gridColId.substring(0, gridColId.length() - 1);

        String pTitle = "|년 / 월";
        String pId = "|YYYYMQ";
        if (viewTag.equals("P")) { //표이면 표헤더 추가
            loop = tsDate[2] - tsDate[0] + 1;
            if (ymqTag.equals("Q")) {
                pTitle = "|년 / 분기";
            }
            gridColHead += pTitle;
            gridColId += pId;
        }
        //단위계산
        String numWgCd = "1";
        if (!UtilString.null2Blank(openInfSrv.getNumWgCd()).equals("")) {
            numWgCd = openInfSrv.getNumWgCd();
        }
        String pointCd = "";
        if (!UtilString.null2Blank(openInfSrv.getPointCd()).equals("")) {
            pointCd = "." + openInfSrv.getPointCd();
        }

        String selectCol = "";
        int endDate = 0;
        int startDate = 0;
        int weight = 0;//가중치
        int year = 0;
        String mq = "";
        int cnt = 1;
        if (ymqTag.equals("M")) {//월
            weight = 12;
        } else if (ymqTag.equals("Q")) {//분기
            weight = 4;
        } else {//년
            weight = 1;
        }
        //tsDate 0:시작년, 1:시작월(분기), 2:종료년, 3: 종료월(분기)
        startDate = getStartDate(tsDate[0], tsDate[1], weight);
        endDate = getEndDate(tsDate[2], tsDate[3], weight);

        if (fisrt) { //초기엔 최근 건수
            if (maxCnt > DEFAULT_LIST_CNT) {
                maxCnt = DEFAULT_LIST_CNT; //초기엔 무조건 12건
            }
            startDate = (endDate - startDate) + 1 > maxCnt ? endDate - (maxCnt - 1) : startDate;//max 값보다 큰지 판단하여 시작날짜 생성
        } else {// 초기 이후엔 시작에 건수
            endDate = (endDate - startDate) + 1 > maxCnt ? startDate + (maxCnt - 1) : endDate;
        }
        int dataCnt = 1;
        if (UtilString.null2Blank(openInfSrv.getDataOrder()).equals("DESC")) {//정렬 바꾸기
            int tempDate = startDate;
            startDate = endDate;
            endDate = tempDate;
            dataCnt = -1;
        }

        if (viewTag.equals("P")) {
            if (UtilString.null2Blank(openInfSrv.getDataOrder()).equals("DESC")) {//정렬 바꾸기
                startDate = weight;
                endDate = 1;
                dataCnt = -1;
            } else {
                startDate = 1;
                endDate = weight;
            }
            for (int j = 0; j < loop; j++) { //루프 횟수 만큼
                year = tsDate[0] + j;
                cnt = 1;
                selectCol += "\n,'" + year + "' AS YYYYMQ";
                for (int i = startDate; dataCnt == 1 ? i < endDate + 1 : i > endDate - 1; i = i + dataCnt) {//가중치(분기,월)
                    if (j == 0) {
                        gridColId += "|" + "COL" + i;
                        gridColHead += "|" + i;
                        dataYear += i + "|";
                        gridDataHead += "COL" + cnt + "|";
                    }

                    //시작년 월(분기) 마지막에 월(분기)
                    if (j == 0) { //시작 월(분기
                        if (tsDate[1] > i) {
                            selectCol += "\n" + " ,'' AS COL" + cnt;
                        } else {
                            selectCol += "\n" + " ,NVL(RTRIM(TO_CHAR(MIN(DECODE(YMQ,'" + year + UtilString.getZeroDate(i) + "',AMT))*" + numWgCd + ",'FM9,999,999,999,99,999,999,999,999,990" + pointCd + "'),'.'),0) AS COL" + cnt;
                        }

                    } else if (j == (loop - 1)) {//마지막년 월(분기)
                        if (tsDate[3] < i) {
                            selectCol += "\n" + " ,'' AS COL" + cnt;
                        } else {
                            selectCol += "\n" + " ,NVL(RTRIM(TO_CHAR(MIN(DECODE(YMQ,'" + year + UtilString.getZeroDate(i) + "',AMT))*" + numWgCd + ",'FM9,999,999,999,99,999,999,999,999,990" + pointCd + "'),'.'),0) AS COL" + cnt;
                        }
                    } else {//중간년은 모든 월(분기)돌아야함
                        selectCol += "\n" + " ,NVL(RTRIM(TO_CHAR(MIN(DECODE(YMQ,'" + year + UtilString.getZeroDate(i) + "',AMT))*" + numWgCd + ",'FM9,999,999,999,99,999,999,999,999,990" + pointCd + "'),'.'),0) AS COL" + cnt;
                    }

                    cnt++;
                }
                selectCol += "\n," + j + " AS V_ORDER";
                selectCol += "|";
            }
        } else {
            //DESC 면 조건절 변경 3항 연산자임
            for (int i = startDate; dataCnt == 1 ? i < endDate + 1 : i > endDate - 1; i = i + dataCnt) {
                gridColId += "|" + "COL" + cnt;
                gridDataHead += "COL" + cnt + "|";
                if (UtilString.null2Blank(ymqTag).equals("Y")) {
                    gridColHead += "|" + i + "년";
                    dataYear += i + "|";
                    selectCol += "\n" + " ,NVL(RTRIM(TO_CHAR(MIN(DECODE(YMQ,'" + i + "',AMT))*" + numWgCd + ",'FM9,999,999,999,99,999,999,999,999,990" + pointCd + "'),'.'),0) AS COL" + cnt;
                } else {//분기, 월
                    // 나머지가 0이면 년도 -1을 해야함
                    year = (i % weight) == 0 ? (i / weight) - 1 : (i / weight);
                    mq = UtilString.getZeroDate(((i % weight) == 0 ? weight : (i % weight)));
                    if (UtilString.null2Blank(ymqTag).equals("M")) {
                        gridColHead += "|" + year + "년 " + mq + "월";
                    } else {
                        gridColHead += "|" + year + "년 " + mq + "분기";
                    }

                    dataYear += year + "/" + mq + "|";
                    selectCol += "\n" + " ,NVL(RTRIM(TO_CHAR(MIN(DECODE(YMQ,'" + year + mq + "',AMT))*" + numWgCd + ",'FM9,999,999,999,99,999,999,999,999,990" + pointCd + "'),'.'),0) AS COL" + cnt;
                }
                cnt++;
            }
            selectCol += "\n ,0 AS V_ORDER";
        }

        List<LinkedHashMap<String, Object>> headList = new ArrayList<LinkedHashMap<String, Object>>();
        LinkedHashMap<String, Object> gridHeadMap = new LinkedHashMap<String, Object>();
        gridHeadMap.put("Text", gridColHead);
        gridHeadMap.put("Align", "Center");
        headList.add(gridHeadMap);
        headMap.put("gridColHeadString", gridColHead);
        if (!dataYear.equals("")) {
            headMap.put("dataYear", dataYear.substring(0, dataYear.length() - 1));
        }
        if (!gridDataHead.equals("")) {
            headMap.put("gridDataHeadString", gridDataHead.substring(0, gridDataHead.length() - 1)); //그리드 컬럼 헤더
        }
        headMap.put("gridColHead", headList); //그리드 컬럼 헤더
        headMap.put("textGridColHead", gridColHead);//테스트 그리드 헤더
        headMap.put("gridColId", gridColId); //그리드 컬럼 ID
        headMap.put("selectCol", selectCol); //SELECT 컬럼 목록
        headMap.put("loop", loop + ""); //select loop횟수
        //초기값 셋팅
        if (fisrt) {
            String yyDate = (startDate % weight) == 0 ? ((startDate / weight) - 1) + "" : (startDate / weight) + "";
            String mqData = UtilString.getZeroDate(((startDate % weight) == 0 ? weight : (startDate % weight)));
            Map<String, String> dateMap = getDefaultDate(UtilString.null2Blank(ymqTag), yyDate, mqData);
            headMap.put("yyStYy", dateMap.get("yyStYy"));
            headMap.put("mmStYy", dateMap.get("mmStYy"));
            headMap.put("mmStMq", dateMap.get("mmStMq"));
            headMap.put("qqStYy", dateMap.get("qqStYy"));
            headMap.put("qqStMq", dateMap.get("qqStMq"));
        }
        return headMap;
    }

    private Map<String, String> getDefaultDate(String ymqTag, String yyDate, String mqDate) {
        Map<String, String> headMap = new HashMap<String, String>();
        String yyStYy = "0";
        String mmStYy = "0";
        String mmStMq = "0";
        String qqStYy = "0";
        String qqStMq = "0";
        if (UtilString.null2Blank(ymqTag).equals("M")) {//월
            mmStYy = yyDate;
            mmStMq = mqDate;
        } else if (UtilString.null2Blank(ymqTag).equals("Q")) {//분기
            qqStYy = yyDate;
            qqStMq = mqDate;
        } else {//년
            yyStYy = yyDate;
        }
        headMap.put("yyStYy", yyStYy);
        headMap.put("mmStYy", mmStYy);
        headMap.put("mmStMq", mmStMq);
        headMap.put("qqStYy", qqStYy);
        headMap.put("qqStMq", qqStMq);
        return headMap;
    }

    private int getStartDate(int stYy, int stMq, int weight) {
        return (stYy * weight) + stMq;
    }

    private int getEndDate(int enYy, int enMq, int weight) {
        return (enYy * weight) + enMq;
    }
}

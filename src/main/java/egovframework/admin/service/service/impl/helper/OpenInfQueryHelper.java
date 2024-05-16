package egovframework.admin.service.service.impl.helper;

import java.util.LinkedHashMap;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Component;

import egovframework.admin.service.service.OpenInfCcol;
import egovframework.admin.service.service.OpenInfScol;
import egovframework.admin.service.service.OpenInfMcol;
import egovframework.admin.service.service.OpenInfSrv;
import egovframework.admin.service.service.OpenInfTcol;
import egovframework.common.util.UtilDate;
import egovframework.common.util.UtilString;

/**
 * DB Query 형식으로 generate하는 class
 *
 * @author wiseopen
 * @version 1.0
 * @see cheon
 * @since 2014.04.17
 */
@Component
public class OpenInfQueryHelper {
    protected static final Log logger = LogFactory.getLog(OpenInfQueryHelper.class);


    public String setSelectCol(List<OpenInfScol> obj) {
        if (obj.size() == 0) {
            return "";
        }
        StringBuffer sb = new StringBuffer();
        for (OpenInfScol openInfScol : obj) {
            sb.append("\n " + openInfScol.getSrcColId() + ",");
        }
        return sb.toString().substring(0, sb.length() - 1);
    }

    public String setSelectCcol(List<OpenInfCcol> obj) {
        if (obj.size() == 0) {
            return "";
        }
        StringBuffer sb = new StringBuffer();
        for (OpenInfCcol openInfCcol : obj) {
            sb.append("\n " + openInfCcol.getSrcColId() + ",");
        }
        return sb.toString().substring(0, sb.length() - 1);
    }

    public String setSelectTCol(List<OpenInfTcol> obj, String viewLang) {
        if (obj.size() == 0) {
            return "";
        }
        StringBuffer sb = new StringBuffer();
        String unitCd = "";
        for (OpenInfTcol openInfTcol : obj) {
            if (openInfTcol.getSrcColId().equals("UNIT_CD")) {
                unitCd = "$UNIT_CD_EXISTS";
            } else if (openInfTcol.getSrcColId().equals("CONV_CD")) {
                if (UtilString.null2Blank(viewLang).equals("E")) {
                    sb.append("\n FN_GET_COMM_CODE_ENM('S1002',CONV_CD) AS CONV_CD_1,");
                } else {
                    sb.append("\n FN_GET_COMM_CODE_NM('S1002',CONV_CD) AS CONV_CD_1,");
                }
            } else {
                sb.append("\n " + UtilString.SQLInjectionFilter(openInfTcol.getSrcColId()) + ",");
            }

        }
        return sb.toString().substring(0, sb.length() - 1) + unitCd;
    }

    public String setSelectGroupBy(List<OpenInfTcol> obj) {
        if (obj.size() == 0) {
            return "";
        }
        StringBuffer sb = new StringBuffer();
        for (OpenInfTcol openInfTcol : obj) {
            if (openInfTcol.getSrcColId().equals("UNIT_CD")) {
                continue;
            }
            sb.append("\n " + openInfTcol.getSrcColId() + ",");

        }
        return sb.toString().substring(0, sb.length() - 1);
    }

    public LinkedHashMap<String, ?> setTitleCol(List<OpenInfScol> obj) {
        if (obj.size() == 0) {
            return null;
        }
        LinkedHashMap<String, String> map = new LinkedHashMap<String, String>();
        for (OpenInfScol openInfScol : obj) {
            map.put(openInfScol.getSrcColId(), openInfScol.getColNm());
        }
        return map;
    }

    public LinkedHashMap<String, ?> setTitleCcol(List<OpenInfCcol> obj) {
        if (obj.size() == 0) {
            return null;
        }
        LinkedHashMap<String, String> map = new LinkedHashMap<String, String>();
        for (OpenInfCcol openInfCcol : obj) {
            map.put(openInfCcol.getSrcColId(), openInfCcol.getColNm());
        }
        return map;
    }

    public String setCondCol(List<OpenInfScol> obj) {
        if (obj.size() == 0) {
            return "";
        }
        StringBuffer sb = new StringBuffer();
        for (OpenInfScol openInfScol : obj) {
            if (openInfScol.getCondOp().equals("IN")) {
                sb.append("\n AND " + openInfScol.getSrcColId() + " " + openInfScol.getCondOp() + " " + openInfScol.getCondVar() + " ");
            } else {
                sb.append("\n AND " + openInfScol.getSrcColId() + " " + openInfScol.getCondOp() + " " + openInfScol.getCondVar() + " ");
            }

        }
        return sb.toString();
    }

    public String setTCondCol(List<OpenInfTcol> obj) {
        if (obj.size() == 0) {
            return "";
        }
        StringBuffer sb = new StringBuffer();
        for (OpenInfTcol openInfTcol : obj) {
            if (openInfTcol.equals("UNIT_CD")) {
                continue;
            }
            if (openInfTcol.getCondOp().equals("IN")) {
                sb.append("\n AND " + openInfTcol.getSrcColId() + " " + openInfTcol.getCondOp() + " " + openInfTcol.getCondVar() + " ");
            } else {
                sb.append("\n AND " + openInfTcol.getSrcColId() + " " + openInfTcol.getCondOp() + " '" + UtilString.replace(openInfTcol.getCondVar(), "'", "") + "' ");
            }

        }
        return sb.toString();
    }

    public String setOrderByCol(List<OpenInfScol> obj) {
        if (obj.size() == 0) {
            return "";
        }
        StringBuffer sb = new StringBuffer();
        String sortTab = "";
        sb.append("\n ORDER BY ");
        for (OpenInfScol openInfScol : obj) {
            sortTab = openInfScol.getSortTag();
            if (sortTab.equals("A")) {
                sortTab = "ASC";
            } else {
                sortTab = "DESC";
            }
            sb.append("\n " + openInfScol.getSrcColId() + " " + sortTab + " ,");
        }
        return sb.toString().substring(0, sb.length() - 1);
    }

    public String setWhereCol(List<OpenInfScol> obj, String[] arrVal) {
        if (obj.size() == 0) {
            return "";
        }
        StringBuffer sb = new StringBuffer();
        String[] arr = new String[2];
        String dateTemp = "AND ${COL_NM} BETWEEN TO_DATE('${FROM}','YYYY-MM-DD')  AND TO_DATE('${TO}','YYYY-MM-DD')";
        String cDateTemp = "AND ${COL_NM} BETWEEN '${FROM}'  AND '${TO}'";
        String checkTemp = "AND ${COL_NM} IN (${COL_VALUE}${CHECK_LAST}";  // CHECK_LAST은 )로치환됨
        String wordTemp = "AND ${COL_NM} LIKE '%${COL_VALUE}%'";
        String temp = "AND ${COL_NM} = '${COL_VALUE}'";
        for (OpenInfScol openInfScol : obj) {
            int dateBit = 0;
            int checkBit = 0;
            String checkColVal = "";
            for (int i = 0; i < arrVal.length; i++) {
                arr = UtilString.getSplitArray(arrVal[i], "=");
                if (openInfScol.getSrcColId().equals(arr[0]) && (!UtilString.null2Blank(arr[1]).equals(""))) {
                    if (openInfScol.getFiltCd().equals("CHECK")) {
                        //if(arr[0].equals("FSCL_YY") && arr[1].equals("1900")){
                        if (arr[1].equals("1900")) {
                            arr[1] = UtilDate.getCurrentYear() + "";
                        }
                        if (checkBit == 0) {//제일 처음일때 템플릿 추가
                            checkColVal = "'" + arr[1] + "'";
                            sb.append("\n" + UtilString.replace(checkTemp, "${COL_NM}", arr[0]));
                        } else { //2번째 이상
                            checkColVal += ",'" + arr[1] + "'";
                        }
                        checkBit++;
                    } else if (openInfScol.getFiltCd().equals("CDATE")) { //문자형 날짜
                        if (dateBit == 0) { //제일 처음일때 컬럼과 FROM 치환
                            sb.append("\n" + UtilString.replace(UtilString.replace(cDateTemp, "${COL_NM}", arr[0]), "${FROM}", arr[1]));
                        } else {// 1일때 TO 치환
                            String string = UtilString.replace(sb.toString(), "${TO}", arr[1]);
                            sb = new StringBuffer();
                            sb.append(string);
                        }
                        dateBit++;
                    } else if (openInfScol.getFiltCd().endsWith("DATE")) {
                        if (dateBit == 0) { //제일 처음일때 컬럼과 FROM 치환
                            sb.append("\n" + UtilString.replace(UtilString.replace(dateTemp, "${COL_NM}", arr[0]), "${FROM}", arr[1]));
                        } else {// 1일때 TO 치환
                            String string = UtilString.replace(sb.toString(), "${TO}", arr[1]);
                            sb = new StringBuffer();
                            sb.append(string);
                        }
                        dateBit++;
                    } else if (openInfScol.getFiltCd().endsWith("WORDS")) {
                        sb.append("\n" + UtilString.replace(UtilString.replace(wordTemp, "${COL_NM}", arr[0]), "${COL_VALUE}", arr[1]));
                    } else {
                        if (arr[1].equals("1900")) {
                            //if(arr[0].equals("FSCL_YY") && arr[1].equals("1900")){
                            arr[1] = UtilDate.getCurrentYear() + "";
                        }
                        sb.append("\n" + UtilString.replace(UtilString.replace(temp, "${COL_NM}", arr[0]), "${COL_VALUE}", arr[1]));

                    }
                }

                //for마지막 check val 넣기
                if (i == arrVal.length - 1) {
                    String string = UtilString.replace(sb.toString(), "${COL_VALUE}", checkColVal);
                    sb = new StringBuffer();
                    sb.append(string);
                }
            }
        }
        return UtilString.replace(sb.toString(), "${CHECK_LAST}", ")");
    }

    public String setTableInfo(List<OpenInfSrv> obj) {
        if (obj.size() == 0) {
            return "";
        }
        StringBuffer sb = new StringBuffer();
        sb.append("\n " + obj.get(0).getOwnerCd() + "." + obj.get(0).getDsId());
        return sb.toString();
    }


    //차트 데이터셋ID 얻기
    public String setChartTableInfo(List<OpenInfCcol> obj) {
        if (obj.size() == 0) {
            return "";
        }
        StringBuffer sb = new StringBuffer();
        sb.append("\n " + obj.get(0).getOwnerCd() + "." + obj.get(0).getDsId());
        return sb.toString();
    }

    //차트 XYcol 얻기
    public String setXYcol(List<OpenInfCcol> obj) {
        if (obj.size() == 0) {
            return "";
        }
        StringBuffer sb = new StringBuffer();
        for (OpenInfCcol openInfCcol : obj) {
            sb.append("\n NVL(" + openInfCcol.getColId() + ", 0),");
        }
        return sb.toString().substring(0, sb.length() - 1);
    }

    //차트 데이터 제한 조건 쿼리
    public String setCondCcol(List<OpenInfCcol> obj) {
        if (obj.size() == 0) {
            return "";
        }
        StringBuffer sb = new StringBuffer();
        for (OpenInfCcol openInfCcol : obj) {
            if (openInfCcol.getCondOp().equals("IN")) {
                sb.append("\n AND " + openInfCcol.getSrcColId() + " " + openInfCcol.getCondOp() + " " + openInfCcol.getCondVar() + " ");
            } else {
                sb.append("\n AND " + openInfCcol.getSrcColId() + " " + openInfCcol.getCondOp() + " " + openInfCcol.getCondVar() + " ");
            }
        }
        return sb.toString();
    }

    //차트 정렬 조건 쿼리
    public String setOrderByCcol(List<OpenInfCcol> obj) {
        if (obj.size() == 0) {
            return "";
        }
        StringBuffer sb = new StringBuffer();
        String sortTab = "";
        sb.append("\n ORDER BY ");
        for (OpenInfCcol openInfCcol : obj) {
            sortTab = openInfCcol.getSortTag();
            if (sortTab.equals("A")) {
                sortTab = "ASC";
            } else {
                sortTab = "DESC";
            }
            sb.append("\n " + openInfCcol.getSrcColId() + " " + sortTab + " ,");
        }
        return sb.toString().substring(0, sb.length() - 1);
    }

    //차트 필터조건
    public String setWhereCcol(List<OpenInfCcol> obj, String[] arrVal) {
        if (obj.size() == 0) {
            return "";
        }
        StringBuffer sb = new StringBuffer();
        String[] arr = new String[2];
        String dateTemp = "AND ${COL_NM} BETWEEN TO_DATE('${FROM}','YYYY-MM-DD')  AND TO_DATE('${TO}','YYYY-MM-DD')";
        String cDateTemp = "AND ${COL_NM} BETWEEN '${FROM}'  AND '${TO}'";
        String checkTemp = "AND ${COL_NM} IN (${COL_VALUE}${CHECK_LAST}";  // CHECK_LAST은 )로치환됨
        String wordTemp = "AND ${COL_NM} LIKE '%${COL_VALUE}%'";
        String temp = "AND ${COL_NM} = '${COL_VALUE}'";
        for (OpenInfCcol openInfCcol : obj) {
            int dateBit = 0;
            int checkBit = 0;
            String checkColVal = "";
            for (int i = 0; i < arrVal.length; i++) {
                arr = UtilString.getSplitArray(arrVal[i], "=");
                if (openInfCcol.getSrcColId().equals(arr[0]) && (!UtilString.null2Blank(arr[1]).equals(""))) {
                    if (openInfCcol.getFiltCd().equals("CHECK")) {
                        //if(arr[0].equals("FSCL_YY") && arr[1].equals("1900")){
                        if (arr[1].equals("1900")) {
                            arr[1] = UtilDate.getCurrentYear() + "";
                        }
                        if (checkBit == 0) {//제일 처음일때 템플릿 추가
                            checkColVal = "'" + arr[1] + "'";
                            sb.append("\n" + UtilString.replace(checkTemp, "${COL_NM}", arr[0]));
                        } else { //2번째 이상
                            checkColVal += ",'" + arr[1] + "'";
                        }
                        checkBit++;
                    } else if (openInfCcol.getFiltCd().equals("CDATE")) { //문자형 날짜
                        if (dateBit == 0) { //제일 처음일때 컬럼과 FROM 치환
                            sb.append("\n" + UtilString.replace(UtilString.replace(cDateTemp, "${COL_NM}", arr[0]), "${FROM}", arr[1]));
                        } else {// 1일때 TO 치환
                            String string = UtilString.replace(sb.toString(), "${TO}", arr[1]);
                            sb = new StringBuffer();
                            sb.append(string);
                        }
                        dateBit++;
                    } else if (openInfCcol.getFiltCd().endsWith("DATE")) {
                        if (dateBit == 0) { //제일 처음일때 컬럼과 FROM 치환
                            sb.append("\n" + UtilString.replace(UtilString.replace(dateTemp, "${COL_NM}", arr[0]), "${FROM}", arr[1]));
                        } else {// 1일때 TO 치환
                            String string = UtilString.replace(sb.toString(), "${TO}", arr[1]);
                            sb = new StringBuffer();
                            sb.append(string);
                        }
                        dateBit++;
                    } else if (openInfCcol.getFiltCd().endsWith("WORDS")) {
                        sb.append("\n" + UtilString.replace(UtilString.replace(wordTemp, "${COL_NM}", arr[0]), "${COL_VALUE}", arr[1]));
                    } else if ((openInfCcol.getFiltCd().endsWith("COMBO"))) {
                        if (arr[1].equals("1900")) {
                            arr[1] = UtilDate.getCurrentYear() + "";
                        }
                        sb.append("\n" + UtilString.replace(UtilString.replace(temp, "${COL_NM}", arr[0]), "${COL_VALUE}", arr[1]));
                    } else {
                        //if(arr[0].equals("FSCL_YY") && arr[1].equals("1900")){
                        if (arr[1].equals("1900")) {
                            arr[1] = UtilDate.getCurrentYear() + "";
                        }
                        sb.append("\n" + UtilString.replace(UtilString.replace(temp, "${COL_NM}", arr[0]), "${COL_VALUE}", arr[1]));
                    }
                }

                //for마지막 check val 넣기
                if (i == arrVal.length - 1) {
                    String string = UtilString.replace(sb.toString(), "${COL_VALUE}", checkColVal);
                    sb = new StringBuffer();
                    sb.append(string);
                }
            }
        }
        return UtilString.replace(sb.toString(), "${CHECK_LAST}", ")");
    }

    public String getTsDate(OpenInfSrv openInfSrv, OpenInfSrv search, String arrCol, String loop) {
        StringBuffer sb = new StringBuffer();
        int itemCnt = Integer.parseInt(search.getItemCnt());
        String col[] = UtilString.getSplitArray(arrCol, "|");

        if (UtilString.null2Blank(openInfSrv.getViewLang()).equals("E")) {
            sb.append("\n SELECT B.ITEM_NM_ENG  AS ITEM_NM1									   ");
            for (int i = 1; i < itemCnt; i++) {
                sb.append("\n ,C" + (i + 1) + ".ITEM_NM_ENG  AS ITEM_NM" + (i + 1) + "					   ");
            }
        } else {
            sb.append("\n SELECT B.ITEM_NM  AS ITEM_NM1									   ");
            for (int i = 1; i < itemCnt; i++) {
                sb.append("\n ,C" + (i + 1) + ".ITEM_NM  AS ITEM_NM" + (i + 1) + "					   ");
            }
        }

        sb.append("\n ,CONV_CD_1 AS CONV_CD					   ");
        if (search.getTselectQuery().indexOf("$UNIT_CD_EXISTS") > -1) {
            if (!UtilString.null2Blank(openInfSrv.getNumNm()).equals("")) {
                sb.append("\n ,CASE A.CONV_CD_1 ");
                sb.append("\n WHEN '전기대비증감율' THEN '%' ");
                sb.append("\n WHEN '전년말대비증감율' THEN '%' ");
                sb.append("\n WHEN '전분기기대비증감율' THEN '%' ");
                sb.append("\n WHEN '전년대비증감율' THEN '%' ");
                sb.append("\n  ELSE  '" + openInfSrv.getNumNm() + "' END AS UNIT_CD");
            } else {
                if (UtilString.null2Blank(openInfSrv.getViewLang()).equals("E")) {
					/*sb.append("\n ,CASE A.CONV_CD_1 ");
					sb.append("\n WHEN '전기대비증감율' THEN '백분율' ");
					sb.append("\n WHEN '전년말대비증감율' THEN '백분율' ");
					sb.append("\n WHEN '전분기기대비증감율' THEN '백분율' ");
					sb.append("\n  ELSE  FN_GET_COMM_CODE_ENM(FN_GET_COMM_VALUE_CD('D1031',B.UNIT_CD),B.UNIT_SUB_CD)  END AS UNIT_CD");	*/
                    if (itemCnt == 2) {
                        sb.append("\n  ,CASE WHEN C2.UNIT_CD IS NULL THEN FN_GET_COMM_CODE_ENM(('D1031',C2.UNIT_CD)");
                        sb.append("\n  ELSE FN_GET_COMM_CODE_ENM(FN_GET_COMM_VALUE_CD('D1031',C2.UNIT_CD),C2.UNIT_SUB_CD) END AS UNIT_CD		");
                    } else {
                        sb.append("\n  ,CASE WHEN B.UNIT_CD IS NULL THEN FN_GET_COMM_CODE_ENM(('D1031',B.UNIT_CD)");
                        sb.append("\n  ELSE FN_GET_COMM_CODE_ENM(FN_GET_COMM_VALUE_CD('D1031',B.UNIT_CD),B.UNIT_SUB_CD) END AS UNIT_CD		");
                    }

                } else {
                    sb.append("\n ,CASE A.CONV_CD_1 ");
                    sb.append("\n WHEN '전기대비증감율' THEN '%' ");
                    sb.append("\n WHEN '전년말대비증감율' THEN '%' ");
                    sb.append("\n WHEN '전분기기대비증감율' THEN '%' ");
                    sb.append("\n WHEN '전년대비증감율' THEN '%' ");
                    if (itemCnt == 2) {
                        sb.append("\n  ELSE  CASE WHEN C2.UNIT_SUB_CD IS NULL THEN FN_GET_COMM_CODE_NM('D1031',C2.UNIT_CD)");
                        sb.append("\n  ELSE  FN_GET_COMM_CODE_NM(FN_GET_COMM_VALUE_CD('D1031',C2.UNIT_CD),C2.UNIT_SUB_CD)  END END AS UNIT_CD");
                    } else {
                        sb.append("\n  ELSE  CASE WHEN B.UNIT_SUB_CD IS NULL THEN FN_GET_COMM_CODE_NM('D1031',B.UNIT_CD)");
                        sb.append("\n  ELSE  FN_GET_COMM_CODE_NM(FN_GET_COMM_VALUE_CD('D1031',B.UNIT_CD),B.UNIT_SUB_CD)  END END AS UNIT_CD");
                    }

                }
            }
        }
        sb.append("\n  ,A.*                															");
        sb.append("\n FROM( 																		");

        //표일경우 년도 만큼 for
        for (int j = 0; j < Integer.parseInt(loop); j++) {
            if (j > 0) {
                sb.append("\n UNION ALL  											  				   ");
            }
            sb.append("\n SELECT    													                    ");
            sb.append(UtilString.replace(search.getTselectQuery(), "$UNIT_CD_EXISTS", ""));
            sb.append(col[j]);
            sb.append("\n FROM " + search.getTableNm() + "                                           ");
            if (!UtilString.null2Blank(openInfSrv.getConvCd()).equals("")) {
                sb.append("\n WHERE CONV_CD IN(" + openInfSrv.getConvCd() + ")                                                                                                 ");
            } else {
                sb.append("\n WHERE CONV_CD ='RAW'												 ");
            }
            sb.append(search.getWhereQuery());
            sb.append("\n GROUP BY                                        								");
            sb.append(search.getGroupByQuery());
        }
        sb.append("\n )A");
        sb.append("\n INNER JOIN TB_OPEN_INF_TCOL_ITEM B                                 ");
        sb.append("\n    ON A.ITEM_CD1 = B.ITEM_CD                                           ");
        sb.append("\n   AND B.USE_YN ='Y'                                                        ");
        if (!UtilString.null2Blank(openInfSrv.getTreeData()).equals("")) {
            sb.append("\n   AND B.ITEM_CD IN(" + openInfSrv.getTreeData() + ")                                                                                                 ");
        }
        for (int i = 1; i < itemCnt; i++) {
            sb.append("\n INNER JOIN TB_OPEN_INF_TCOL_ITEM C" + (i + 1) + "                   ");
            sb.append("\n    ON A.ITEM_CD2 = C" + (i + 1) + ".ITEM_CD                             ");
            sb.append("\n   AND C" + (i + 1) + ".USE_YN ='Y'                                           ");
            if (!UtilString.null2Blank(openInfSrv.getTreeData2()).equals("")) {
                sb.append("\n   AND C" + (i + 1) + ".ITEM_CD IN(" + openInfSrv.getTreeData2() + ")  ");
            }
        }
        sb.append("\n LEFT OUTER JOIN TB_COMM_CODE CODE								   ");
        if (UtilString.null2Blank(openInfSrv.getViewLang()).equals("E")) {
            sb.append("\n    ON A.CONV_CD_1 = CODE.DITC_NM_ENG  						   ");
        } else {
            sb.append("\n    ON A.CONV_CD_1 = CODE.DITC_NM  							        ");
        }
        sb.append("\n  AND CODE.GRP_CD='S1002'       						                    ");

        sb.append("\n ORDER BY B.V_ORDER,															");
        for (int i = 1; i < itemCnt; i++) {
            sb.append("C" + (i + 1) + ".V_ORDER,                                                            ");
        }
        sb.append("A.V_ORDER,CODE.V_ORDER                                                        	");
        logger.debug(sb.toString());
        return sb.toString();
    }


    public String setSelectMCol(List<OpenInfMcol> obj) {
        if (obj.size() == 0) {
            return "";
        }
        StringBuffer sb = new StringBuffer();
        for (OpenInfMcol openInfMcol : obj) {
            if (openInfMcol.getColCd().equals("ITEM")) {
                sb.append("\n " + openInfMcol.getSrcColId() + " AS " + openInfMcol.getSrcColId() + " ,");
            } else {
                sb.append("\n " + openInfMcol.getSrcColId() + " AS " + openInfMcol.getColCd() + " ,");
            }
        }
        return sb.toString().substring(0, sb.length() - 1);
    }

    public String setCondMCol(List<OpenInfMcol> obj) {
        if (obj.size() == 0) {
            return "";
        }
        StringBuffer sb = new StringBuffer();
        for (OpenInfMcol openInfMcol : obj) {
            if (openInfMcol.getCondOp().equals("IN")) {
                sb.append("\n AND " + openInfMcol.getSrcColId() + " " + openInfMcol.getCondOp() + " " + openInfMcol.getCondVar() + " ");
            } else {
                sb.append("\n AND " + openInfMcol.getSrcColId() + " " + openInfMcol.getCondOp() + " '" + UtilString.replace(openInfMcol.getCondVar(), "'", "") + "' ");
            }

        }
        return sb.toString();
    }
}

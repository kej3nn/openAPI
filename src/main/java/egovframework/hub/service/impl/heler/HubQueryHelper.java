package egovframework.hub.service.impl.heler;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Clob;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Component;

import egovframework.hub.service.Hub;
import egovframework.common.util.UtilString;
/**
 * DB Query 형식으로 generate하는 class
 * @author wiseopen
 * @since 2014.04.17
 * @version 1.0
 * @see cheon
 *
 */
@Component
public class HubQueryHelper {
	protected static final Log logger = LogFactory.getLog(HubQueryHelper.class);
	
	/**
	 * 조회 컬럼리스트를 DB QUERY 형식으로 generate하여 셋팅한다.
	 * @param hub
	 * @param LinkMap
	 */
	public void setSelectCol(Hub hub,List<LinkedHashMap<?,?>> LinkMap ){
		if(LinkMap.size() == 0){
			hub.setSelectColString("");
			return;
		}
    	StringBuffer sb = new StringBuffer();
    	for(LinkedHashMap<?,?> map: LinkMap){
    		sb.append("\n "+(String)map.get("COL_NM")+",");
    		
    		if(UtilString.null2Blank(hub.getDsCd()).equals("TS")){
    			if(((String)map.get("COL_NM")).indexOf("ITEM_CD1") > -1){
    				sb.append("\n B.ITEM_NM AS ITEM_NM1,");
    			}else if((((String)map.get("COL_NM")).indexOf("ITEM_CD2") > -1)){
    				sb.append("\n C.ITEM_NM AS ITEM_NM2,");
    			}else if((((String)map.get("COL_NM")).indexOf("UNIT_CD") > -1)){
    				sb.append("\n FN_GET_COMM_CODE_NM(FN_GET_COMM_VALUE_CD('D1031',B.UNIT_CD),B.UNIT_SUB_CD) AS UNIT_NM,");
    			}else if((((String)map.get("COL_NM")).indexOf("CONV_CD") > -1)){
    				sb.append("\n FN_GET_COMM_CODE_NM('S1002',CONV_CD) AS CONV_NM,");
    			}
    		}
    	}
    	hub.setSelectColString(sb.toString().substring(0,sb.length() - 1));
    }
    
	/**
	 * 시스템 변수를 DB QUERY 형식으로 generate하여 셋팅한다.
	 * @param hub
	 * @param LinkMap
	 */
	public void setSystemVar(Hub hub,List<LinkedHashMap<?,?>> LinkMap ){
		if(LinkMap.size() == 0){
			hub.setSysVarString("");
			return;
		}
    	StringBuffer sb = new StringBuffer();
    	for(HashMap<?,?> map: LinkMap){
    		sb.append("\n "+(String)map.get("SYSTEM_VAR")+(String)map.get("COND_VAR"));
    	}
    	hub.setSysVarString(sb.toString().replaceAll("''", "'"));
    }
    
	/**
	 * 사용자 변수를 DB QUERY 형식으로 generate하여 셋팅한다.
	 * @param hub
	 * @param LinkMap
	 */
	public void setUserVar(Hub hub,List<LinkedHashMap<?,?>> LinkMap ){
		if(LinkMap.size() == 0){
			hub.setUserValString("");
			return;
		}
    	StringBuffer sb = new StringBuffer();
    	for(HashMap<?,?> map: LinkMap){
    		String valData = hub.getQueryMap().get((String)map.get("COL_ID"));
    		logger.debug("=====================KOR============>"+valData);
    		if(!UtilString.null2Blank(valData).equals("")){
    			if(((String)map.get("SRC_COL_TYPE")).equalsIgnoreCase("VARCHAR") || ((String)map.get("SRC_COL_TYPE")).equalsIgnoreCase("CHAR")){ //String
    				if(((String)map.get("REQ_OP")).equalsIgnoreCase("LIKE")) {
    					valData ="'%'||'"+valData+"'||'%'";
    				} else {
    					valData ="'"+valData+"'";
    				}
    			}else if(((String)map.get("SRC_COL_TYPE")).equalsIgnoreCase("DATE")){
    				if(valData.toUpperCase().indexOf("SYSDATE") < 0){ //String
    					valData ="'"+valData+"'";
    				}
    			}
    			valData = UtilString.replace(valData, "?", valData);
    			sb.append("\n "+(String)map.get("USER_VAR")+valData);
    		}
    	}
    	hub.setUserValString(sb.toString().replaceAll("''", "'"));
    }
    
	/**
	 * 테이블명을 DB QUERY 형식으로 generate하여 셋팅한다.
	 * @param hub
	 */
	public void setTableNm(Hub hub){
    	hub.setTableString(UtilString.null2Blank(hub.getOwnerCd()).equals("") ? "\n"+hub.getDsId() :  "\n"+hub.getOwnerCd()+"."+hub.getDsId());
    }
	
	/**
	 * 정렬 순서를 DB QUERY 형식으로 generate하여 셋팅한다.
	 * @param hub
	 * @param LinkMap
	 */
	public void setOrderBy(Hub hub,List<LinkedHashMap<?,?>> LinkMap ){
		if(LinkMap.size() == 0){
			hub.setOrderByString("");
			return;
		}
    	StringBuffer sb = new StringBuffer();
    	sb.append("\n ORDER BY ");
    	for(LinkedHashMap<?,?> map: LinkMap){
    		sb.append((String)map.get("ORDER_SORT")+",");
    	}
    	hub.setOrderByString(sb.toString().substring(0,sb.length() - 1));
    }
	
	
	/**
	 * 통계 Sheet를 셋팅한다.
	 * @param hub
	 * @param LinkMap
	 */
	public void setTs(Hub hub ){
		String selectCol = hub.getSelectColString();
		String tsJoin="";
		if(selectCol.indexOf("ITEM_CD1") > -1){
			tsJoin =" LEFT OUTER JOIN TB_OPEN_INF_TCOL_ITEM B ON A.ITEM_CD1 = B.ITEM_CD "+"\n";
		}
		if(selectCol.indexOf("ITEM_CD2") > -1.){
				tsJoin +=" LEFT OUTER JOIN TB_OPEN_INF_TCOL_ITEM C ON A.ITEM_CD2 = C.ITEM_CD "+"\n";
		}
		hub.setTsJoinString(tsJoin);
    }
}

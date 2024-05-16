package egovframework.hub.service;

import java.io.Serializable;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * OPEN API HUB getting,setting class
 * @author wiseopen
 * @since 2014.04.17
 * @version 1.0
 * @see cheon
 *
 */
public class Hub extends HubLog implements Serializable{
	
	private static final long serialVersionUID = -8274004534207618049L;
	
	private String actKey;
	private String apiRes;
	private String type;
	private String pSize;
	private String pIndex;
	private String dsId;
	private String infId;
	private String dsCd;
	private int infSeq;
	private String ownerCd;
	private int totConut;
	private List<LinkedHashMap<?,?>>data;
	private HashMap<String,String> queryMap;
	private String selectColString;
	private String tableString;
	private String sysVarString;
	private String userValString;
	private String orderByString;
	
	private int startNum;
	private int endNum;
	private String callback;
	private String tsJoinString;
	private List<LinkedHashMap<?,?>>cData; 
	
	private String msgTag;
	private String msgCd;
	private String msgExp;
	
	public String getActKey() {
		return actKey;
	}

	public void setActKey(String actKey) {
		this.actKey = actKey;
	}

	public String getApiRes() {
		return apiRes;
	}

	public void setApiRes(String apiRes) {
		this.apiRes = apiRes;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	public String getpSize() {
		return pSize;
	}

	public void setpSize(String pSize) {
		this.pSize = pSize;
	}

	public String getpIndex() {
		return pIndex;
	}

	public void setpIndex(String pIndex) {
		this.pIndex = pIndex;
	}

	public HashMap<String, String> getQueryMap() {
		return queryMap;
	}

	public void setQueryMap(HashMap<String, String> queryMap) {
		this.queryMap = queryMap;
	}

	public String getDsId() {
		return dsId;
	}

	public void setDsId(String dsId) {
		this.dsId = dsId;
	}

	public String getInfId() {
		return infId;
	}

	public void setInfId(String infId) {
		this.infId = infId;
	}

	public int getInfSeq() {
		return infSeq;
	}

	public void setInfSeq(int infSeq) {
		this.infSeq = infSeq;
	}

	public String getOwnerCd() {
		return ownerCd;
	}

	public void setOwnerCd(String ownerCd) {
		this.ownerCd = ownerCd;
	}

	public int getTotConut() {
		return totConut;
	}

	public void setTotConut(int totConut) {
		this.totConut = totConut;
	}
	
	public List<LinkedHashMap<?, ?>> getData() {
		return data;
	}

	public void setData(List<LinkedHashMap<?, ?>> data) {
		this.data = data;
	}

	public String getSelectColString() {
		return selectColString;
	}

	public void setSelectColString(String selectColString) {
		this.selectColString = selectColString;
	}

	public String getTableString() {
		return tableString;
	}

	public void setTableString(String tableString) {
		this.tableString = tableString;
	}

	public String getSysVarString() {
		return sysVarString;
	}

	public void setSysVarString(String sysVarString) {
		this.sysVarString = sysVarString;
	}

	public String getUserValString() {
		return userValString;
	}

	public void setUserValString(String userValString) {
		this.userValString = userValString;
	}

	public int getStartNum() {
		return startNum;
	}

	public void setStartNum(int startNum) {
		this.startNum = startNum;
	}

	public int getEndNum() {
		return endNum;
	}

	public void setEndNum(int endNum) {
		this.endNum = endNum;
	}

	public String getOrderByString() {
		return orderByString;
	}

	public void setOrderByString(String orderByString) {
		this.orderByString = orderByString;
	}

	public String getCallback() {
		return callback;
	}

	public void setCallback(String callback) {
		this.callback = callback;
	}

	public String getTsJoinString() {
		return tsJoinString;
	}

	public void setTsJoinString(String tsJoinString) {
		this.tsJoinString = tsJoinString;
	}

	public String getDsCd() {
		return dsCd;
	}

	public void setDsCd(String dsCd) {
		this.dsCd = dsCd;
	}

	public List<LinkedHashMap<?, ?>> getcData() {
		return cData;
	}

	public void setcData(List<LinkedHashMap<?, ?>> cData) {
		this.cData = cData;
	}

	public String getMsgTag() {
		return msgTag;
	}

	public void setMsgTag(String msgTag) {
		this.msgTag = msgTag;
	}

	public String getMsgCd() {
		return msgCd;
	}

	public void setMsgCd(String msgCd) {
		this.msgCd = msgCd;
	}

	public String getMsgExp() {
		return msgExp;
	}

	public void setMsgExp(String msgExp) {
		this.msgExp = msgExp;
	}
	
}

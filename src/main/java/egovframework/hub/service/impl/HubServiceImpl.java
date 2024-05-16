package egovframework.hub.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.util.UtilHub;
import egovframework.common.util.UtilString;
import egovframework.hub.service.Hub;
import egovframework.hub.service.impl.heler.HubErrorCheckHelper;
import egovframework.hub.service.impl.heler.HubQueryHelper;

/**
 * OPEN API에서 사용하는 DB 연동하는 서비스 구현체
 * @author wiseopen
 * @since 2014.04.17
 * @version 1.0
 * @see cheon
 *
 */
@Resource(name="serviceImpl")
public class HubServiceImpl {

    @Resource(name = "HubDAO")
    public HubDAO hubDao;
    
    @Autowired
    public HubQueryHelper hubQueryHelper;
    
    @Autowired
    public HubErrorCheckHelper hubErrorCheckHelper;
    
    public static final Logger logger = Logger.getLogger(HubServiceImpl.class);
	
	public void selectApiMessageList(Hub hub)  {
		List<HashMap<?, ?>> apiMsg = new ArrayList<HashMap<?,?>>();
		try {
			 apiMsg = hubDao.selectApiMessageList(hub);
		} catch(DataAccessException dae){
			EgovWebUtil.exLogging(dae);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		if (apiMsg != null && apiMsg.size() > 0) {
			for(HashMap<?,?> map : apiMsg ){
				int msgCd  = Integer.parseInt((String)map.get("MSG_CD"));
				switch (msgCd) {
				case 000:
					hub.setInfoOk (UtilString.null2Blank(map.get("MSG_TAG")) + "-" + map.get("MSG_CD") + " : " + UtilString.null2Blank(map.get("MSG_EXP")));
					break;
				case 200:
					hub.setInfoData(UtilString.null2Blank(map.get("MSG_TAG")) + "-" + map.get("MSG_CD") + " : " + UtilString.null2Blank(map.get("MSG_EXP")));
					break;
				case 290:
					hub.setErrKey(UtilString.null2Blank(map.get("MSG_TAG")) + "-" + map.get("MSG_CD") + " : " + UtilString.null2Blank(map.get("MSG_EXP")));
					break;
				case 300:
					if(map.get("MSG_TAG").equals("INFO")){
						hub.setInfoUseKeyLimits(UtilString.null2Blank(map.get("MSG_TAG")) + "-" + map.get("MSG_CD") + " : " + UtilString.null2Blank(map.get("MSG_EXP")));
					}else{
						hub.setErrMdt(UtilString.null2Blank(map.get("MSG_TAG")) + "-" + map.get("MSG_CD") + " : " + UtilString.null2Blank(map.get("MSG_EXP")));
					}
					break;
				case 310:
					hub.setErrService(UtilString.null2Blank(map.get("MSG_TAG")) + "-" + map.get("MSG_CD") + " : " + UtilString.null2Blank(map.get("MSG_EXP")));
					break;
				case 333:
					hub.setErrCntType(UtilString.null2Blank(map.get("MSG_TAG")) + "-" + map.get("MSG_CD") + " : " + UtilString.null2Blank(map.get("MSG_EXP")));
					break;
				case 336:
					hub.setErrCntTypeKey(UtilString.null2Blank(map.get("MSG_TAG")) + "-" + map.get("MSG_CD") + " : " + UtilString.null2Blank(map.get("MSG_EXP")));
					break;
				case 500:
					hub.setErrServer(UtilString.null2Blank(map.get("MSG_TAG")) + "-" + map.get("MSG_CD") + " : " + UtilString.null2Blank(map.get("MSG_EXP")));
					break;
				case 600:
					hub.setErrDBCon(UtilString.null2Blank(map.get("MSG_TAG")) + "-" + map.get("MSG_CD") + " : " + UtilString.null2Blank(map.get("MSG_EXP")));
					break;
				case 601:
					hub.setErrSql(UtilString.null2Blank(map.get("MSG_TAG")) + "-" + map.get("MSG_CD") + " : " + UtilString.null2Blank(map.get("MSG_EXP")));
					break;
				case 980:
					hub.setErrLimit(UtilString.null2Blank(map.get("MSG_TAG")) + "-" + map.get("MSG_CD") + " : " + UtilString.null2Blank(map.get("MSG_EXP")));
					break;
				case 990:
					hub.setErrPause(UtilString.null2Blank(map.get("MSG_TAG")) + "-" + map.get("MSG_CD") + " : " + UtilString.null2Blank(map.get("MSG_EXP")));
					break;
				case 337:
					hub.setErrApiTrf(UtilString.null2Blank(map.get("MSG_TAG")) + "-" + map.get("MSG_CD") + " : " + UtilString.null2Blank(map.get("MSG_EXP")));
					break;
				default:
					logger.error("[메시지 미정의] " + UtilString.null2Blank(map.get("MSG_TAG")) + "-" + map.get("MSG_CD") + " : " + UtilString.null2Blank(map.get("MSG_EXP")));
				}
			}
		}
		
    }    
	
    public int hubErrorCheck(ModelAndView modelAndView, Hub hub)  {
    	int returnType = -1;
    	try {
    		hubErrorCheckHelper.checkService(hub);//1 서비스 가능한지 체크
    		hubErrorCheckHelper.checkUsrKey(hub);//2. key 체크 (사용중지,이용제한, key 유효성)
    		hubErrorCheckHelper.checkApiTrf(hub); //3.하루 조회 횟수 체크
    		hubErrorCheckHelper.checkDataType(hub.getpSize(),hub);//4. DataType 체크(조회사이즈)
    		hubErrorCheckHelper.checkDataType(hub.getpIndex(),hub);//5. DataType 체크(조회인덱스)
    		hubErrorCheckHelper.checkDataMax(hub.getpSize(),hub);//6.인증키 1000건 초과 호출
    		hubErrorCheckHelper.checkRegNeed(hub);//7.필수 변수 체크
			
		} catch(DataAccessException dae){
			EgovWebUtil.exLogging(dae);
		}catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
    	
    	if(!UtilString.null2Blank(hub.getMsgString()).equals("")){//에러가 있으면 에러 메시지 만드는 함수 호출
			markErrorMessage(hub,modelAndView);
			return returnType;
		}else{
			hub.setMsgString(hub.getInfoOk());
		}
    	return 0;
    }
    
    //재정의하여 사용
    public void markErrorMessage(Hub hub,ModelAndView modelAndView) {
    	logger.debug("사용하면 안되요....");
	}
    
	public int selectHubData(HttpServletRequest request, Hub hub)  {
		setPageing(hub);//페이징
		List<LinkedHashMap<?,?>> result = new ArrayList<LinkedHashMap<?,?>>();
		int totCount = 0;
		try {
			hubQueryHelper.setSelectCol(hub, hubDao.selectServiceColList(hub));//select col 셋팅
			if(UtilString.null2Blank(hub.getDsCd()).equals("TS")){
				hubQueryHelper.setTs(hub);
			}
			// CDATA 조회
			hub.setcData(hubDao.selectServiceColCdataList(hub));
			hubQueryHelper.setSystemVar(hub, hubDao.selectServiceSystemValList(hub));//시스템 변수 셋팅
			hubQueryHelper.setUserVar(hub,hubDao.selectServiceUserValList(hub));//사용자 변수 셋팅
			hubQueryHelper.setTableNm(hub);//테이블명 셋팅
			//order by 셋팅
			hubQueryHelper.setOrderBy(hub,hubDao.selectServiceOrderByList(hub));
			
			totCount = (Integer)hubDao.selectHubDataCnt(hub);
			result = hubDao.selectHubData(hub);
		} catch(DataAccessException dae){
			EgovWebUtil.exLogging(dae);
		}catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		
	    hub.setTotConut(totCount);
	    hub.setData(result);
	    hubLogInfo(request,hub); 
	    if(result.size() == 0){  
	    	hub.setMsgString(hub.getInfoData());
	    	return -1;
	    }
	    return 0;
    }
	
	public void systemErrorMsg(String msg,Hub hub) {
		logger.debug(msg);
    	if(msg.indexOf("Connection") > -1){
    		hub.setMsgString(hub.getErrDBCon());
    	}else if(msg.indexOf("JDBC") > -1){
    		hub.setMsgString(hub.getErrSql());
    	}else{
    		hub.setMsgString(hub.getErrServer());
    	}
    }
	
	private void setPageing(Hub hub){
		hub.setStartNum(UtilHub.startPageNum(Integer.parseInt(hub.getpIndex()),Integer.parseInt(hub.getpSize())));
    	hub.setEndNum(UtilHub.EndPageNum(Integer.parseInt(hub.getpIndex()),Integer.parseInt(hub.getpSize())));
	}
	private void hubLogInfo(HttpServletRequest request,Hub hub) {
    	hub.setRowCnt(hub.getData() ==null ? 0 : hub.getData().size());
    	hub.setDbSize(UtilHub.getDataSize(hub.getData()));
    	request.setAttribute("Log", hub);
    }
}

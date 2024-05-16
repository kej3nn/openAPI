package egovframework.hub.service.impl;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

import egovframework.hub.service.Hub;
import egovframework.hub.service.HubService;
import egovframework.common.util.UtilString;

/**
 * JSON 형식으로 generate한다
 * @author wiseopen
 * @since 2014.04.17
 * @version 1.0
 * @see cheon
 *
 */

@Service("JsonService")
public class JsonServiceImpl extends HubServiceImpl implements HubService {
	
	protected static final Log logger = LogFactory.getLog(JsonServiceImpl.class);
	
	@SuppressWarnings("rawtypes")
    public void makeData(ModelAndView modelAndView,HttpServletRequest request,Hub hub) {
		List<LinkedHashMap<?,?>> list = hub.getData();
    	List<LinkedHashMap<?,?>> jsonList = new ArrayList<LinkedHashMap<?,?>>();
		LinkedHashMap<String,List> row = new LinkedHashMap<String,List>();
		
		for(LinkedHashMap map:list){ //RN삭제
			map.remove("RN");
		}
		row.put("row",list);
		jsonList.add(setHead(hub));//head 
		jsonList.add(row);
		modelAndView.setViewName("jsonView");
		modelAndView.addObject(hub.getApiRes(),jsonList);
		
		hub.setOutSize(jsonList.toString().length());
		setCallBack(modelAndView,hub);
    }
    
    @Override
    public void markErrorMessage(Hub hub,ModelAndView modelAndView) {
    	logger.debug("getErr");
    	modelAndView.addObject("RESULT",setResult(hub));
    	modelAndView.setViewName("jsonView");
    	setCallBack(modelAndView,hub);
	}
    
    /**
     * Reuslt정보를 generate한다. 
     * @param hub
     * @return
     */
    private LinkedHashMap<String,String> setResult(Hub hub){
    	String[] errData = UtilString.getSplitArray(hub.getMsgString(), " : ");
    	LinkedHashMap<String,String> map = new LinkedHashMap<String,String>();
    	logger.debug("error : "+  errData[1]);
    	String code = StringUtils.defaultString(errData[0]);
    	String msgExp = StringUtils.defaultString(errData[1]);
    	map.put("CODE", code);
    	map.put("MESSAGE", msgExp);
    	// 20200716/JHKIM - 에러메시지 DB에 저장준비
    	hub.setMsgTag(code.substring(0, code.indexOf("-")));
    	hub.setMsgCd(code);
    	hub.setMsgExp(msgExp);
    	HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
    	request.setAttribute("Log", hub);
    	return map;
    }
    /**
     * Head정보를 generate한다.
     * @param hub
     * @return
     */
    @SuppressWarnings("rawtypes")
	private LinkedHashMap<String,List> setHead(Hub hub){
    	LinkedHashMap<String,List> headMap = new LinkedHashMap<String,List>();
		LinkedHashMap<String,Integer> cntMap = new LinkedHashMap<String,Integer>();
		LinkedHashMap<String,LinkedHashMap> resultMap = new LinkedHashMap<String,LinkedHashMap>();
		resultMap.put("RESULT",setResult(hub));
		cntMap.put("list_total_count", hub.getTotConut());
		List<LinkedHashMap<?,?>> headList = new ArrayList<LinkedHashMap<?,?>>();
		headList.add(cntMap);
		headList.add(resultMap);
		headMap.put("head", headList);
		return headMap;
    }
    
    private void setCallBack(ModelAndView modelAndView, Hub hub){
    	if(!UtilString.null2Blank(hub.getCallback()).equals("")){
			modelAndView.addObject("CALLBACK",hub.getCallback());
		}
    }
}

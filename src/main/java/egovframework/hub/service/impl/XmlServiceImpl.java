package egovframework.hub.service.impl;

import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

import egovframework.hub.service.Hub;
import egovframework.hub.service.HubService;
import egovframework.common.util.UtilString;

/**
 * XML 형식으로 generate한다.
 * @author wiseopen
 * @since 2014.04.17
 * @version 1.0
 *
 */

@Service("XmlService")
public class XmlServiceImpl extends HubServiceImpl implements HubService {

	public static final Logger logger = Logger.getLogger(XmlServiceImpl.class);
	
    public void makeData(ModelAndView modelAndView,HttpServletRequest request,Hub hub) {
    	
    	List<LinkedHashMap<?,?>> list = hub.getData();
    	logger.debug("xml start");
		Document doc = DocumentHelper.createDocument();
		Element root = doc.addElement(hub.getApiRes());
		Element head = root.addElement("head");
		head.addElement("list_total_count").addText(hub.getTotConut()+"");
		Element result = head.addElement("RESULT");
		String[]  msg = UtilString.getSplitArray(hub.getMsgString(), " : ");
		String code = StringUtils.defaultString(msg[0]);
    	String msgExp = StringUtils.defaultString(msg[1]);
		result.addElement("CODE").addText(code);
		result.addElement("MESSAGE").addText(msgExp);
		hub.setMsgTag(code.substring(0, code.indexOf("-")));
    	hub.setMsgCd(code);
    	hub.setMsgExp(msgExp);
    	
		List<LinkedHashMap<?,?>>cData = hub.getcData();
		Element data;
		boolean cdataFlag = false;
		String hgNm = "";
		for(HashMap<?,?> map:list){
			Iterator<?> iterator = map.entrySet().iterator();
			data = root.addElement("row");
			while(iterator.hasNext()){
				Entry<?,?> entry =(Entry<?,?>)iterator.next();
				if(((String)entry.getKey()).equals("RN")){
					continue;
				}
				
				if(((String)entry.getKey()).equals("HG_NM")) {
					hgNm = (String)entry.getValue();
				}
				
				if(!cData.isEmpty()) {
					for(HashMap<?,?> cdataMap:cData){
						if (cdataMap.get("COL_NM") != null) {
							
							logger.debug("=====> COL_NM : "+cdataMap.get("COL_NM")+", KEY : "+(String)entry.getKey()+", VALUE : "+entry.getValue()==null?"":entry.getValue());
							if(cdataMap.get("COL_NM").equals((String)entry.getKey())){
//							data.addElement((String)entry.getKey()).addCDATA(entry.getValue()+"");					데이터 null일 경우 null 표시 안되게
								data.addElement((String)entry.getKey()).addCDATA(entry.getValue()==null?"":entry.getValue()+"");

								cdataFlag = true;
							}
						}
					}
					if(!cdataFlag) {
//						data.addElement((String)entry.getKey()).addText(entry.getValue()+"");					데이터 null일 경우 null 표시 안되게
						data.addElement((String)entry.getKey()).addText(entry.getValue()==null?"":entry.getValue()+"");
					}
					
					cdataFlag = false;
				} else {
//					data.addElement((String)entry.getKey()).addText(entry.getValue()+"");					데이터 null일 경우 null 표시 안되게
					
    				if(((String)entry.getKey()).equals("HJ_NM")) {
    					
    					if(hgNm.equals("심상정")) {
    						data.addElement((String)entry.getKey()).addText(entry.getValue()==null?"":"沈相奵");
    					} else if(hgNm.equals("고용진")) {
    						data.addElement((String)entry.getKey()).addText(entry.getValue()==null?"":"高榕禛");
    					} else if(hgNm.equals("민병두")) {
    						data.addElement((String)entry.getKey()).addText(entry.getValue()==null?"":"閔丙䄈");
    					} else {
    						data.addElement((String)entry.getKey()).addText(entry.getValue()==null?"":entry.getValue()+"");
    					}
    				} else {
    					data.addElement((String)entry.getKey()).addText(entry.getValue()==null?"":entry.getValue()+"");
    				}

				}
				
			}
		}
		modelAndView.setViewName("xmlView");
		hub.setOutSize(doc.asXML().length());
		modelAndView.addObject(hub.getApiRes(),doc);
    }
    
    @Override
    public void markErrorMessage(Hub hub,ModelAndView modelAndView) {
    	String[] errData = UtilString.getSplitArray(hub.getMsgString(), " : ");
    	String code = StringUtils.defaultString(errData[0]);
    	String msgExp = StringUtils.defaultString(errData[1]);
    	
    	Document doc = DocumentHelper.createDocument();
    	Element root = doc.addElement("RESULT");
    	root.addElement("CODE").addText(code);
    	root.addElement("MESSAGE").addText(msgExp);
    	modelAndView.addObject("RESULT",doc);
    	modelAndView.setViewName("xmlView");
    	
    	// 20200716/JHKIM - 에러메시지 DB에 저장준비
    	hub.setMsgTag(code.substring(0, code.indexOf("-")));
    	hub.setMsgCd(code);
    	hub.setMsgExp(msgExp);
    	HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
    	request.setAttribute("Log", hub);
	}
}

package egovframework.hub.web;

/**
 * OPEN API Controller
 * @author wiseopen
 * @since 2014.04.17
 * @version 1.0
 * @see cheon
 *
 */

import java.net.URLDecoder;
import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.HubConfig;
import egovframework.hub.service.Hub;
import egovframework.hub.service.HubService;
import egovframework.hub.service.impl.heler.HubErrorCheckHelper;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.util.UtilHub;
import egovframework.common.util.UtilString;


@Controller
public class HubController implements InitializingBean {
	
	protected static final Log logger = LogFactory.getLog(HubController.class);
	
    @Resource(name="XmlService")
    private HubService xmlService;
    
    @Resource(name="JsonService")
    private HubService jsonService;
    
	HttpServletRequest ExceptionRequst ;
	
	@Autowired
    public HubErrorCheckHelper hubErrorCheckHelper;
	
	public void afterPropertiesSet()  {

	}

	/**
	 * 반환하는 타입에 따라서 서비스 class를 주입한다.
	 * xml 형식은 XmlServiceImpl 주입하고 json 형식은 JsonServiceImp calss 주입한다.
	 * @param hub
	 */
	private HubService setServiceType(Hub hub){
		if(UtilString.null2Blank(hub.getType()).equals("XML")){
			return xmlService;
		}else{
			return jsonService;
		}
	}
	
	/**
	 *  POST 방식으로 RESTFUL
	 * @param API_RES
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/portal/openapi/{API_RES}", method=RequestMethod.POST)
	public ModelAndView postHub(@PathVariable("API_RES") String API_RES,HttpServletRequest request) {
		Hub hub = new Hub();
		HubService hubService= null;
		ModelAndView modelAndView = new ModelAndView();
		try{
			setDefaultParam(API_RES,request,hub); //기본적인 parameter셋팅
			hubService = setServiceType(hub);//서비스 방식 선택
			hubService.selectApiMessageList(hub);//메시지 settting 
			
			int returnErr = hubService.hubErrorCheck(modelAndView,hub);//에러 확인 및 에러를 generate 한다.
			if(returnErr != 0){ //에러가 있을 경우 리턴
				return modelAndView;
			}
			// 데이터 조회
			returnErr = hubService.selectHubData(request,hub);
			if(returnErr != 0){ //data가 없을 경우 에러 형식에 맞게 generate한다
				hubService.markErrorMessage(hub,modelAndView);
			}else{ //정상일 경우 정상데이터 generate한다.
				hubService.makeData(modelAndView, request, hub);

			}
			return modelAndView;
		}catch(DataAccessException sve) {
			EgovWebUtil.exLogging(sve);
			hubService.markErrorMessage(hub,modelAndView); //error 메시지 만드는 서비스 메소드 호출
			return modelAndView;
		} catch(Exception e) {
			EgovWebUtil.exLogging(e);
			hubService.markErrorMessage(hub,modelAndView); //error 메시지 만드는 서비스 메소드 호출
			return modelAndView;
        }
	}
	
	/**
	 * GET방식으로 RESTFUL
	 * @param API_RES
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/portal/openapi/{API_RES}", method=RequestMethod.GET)
	public ModelAndView getHub(@PathVariable("API_RES") String API_RES,HttpServletRequest request) {
		Hub hub = new Hub();
		HubService hubService= null;
		ModelAndView modelAndView = new ModelAndView();
		try{
			setDefaultParam(API_RES,request,hub); //기본적인 parameter셋팅
			hubService = setServiceType(hub);//서비스 방식 선택
			hubService.selectApiMessageList(hub);//메시지 settting 
			
			int returnErr = hubService.hubErrorCheck(modelAndView,hub);//에러 확인 및 에러를 generate 한다.
			
			if(returnErr != 0){ //에러가 있을 경우 리턴
				return modelAndView;
			}
			// 데이터 조회
			returnErr = hubService.selectHubData(request,hub);
			if(returnErr != 0){ //data가 없을 경우 에러 형식에 맞게 generate한다
				hubService.markErrorMessage(hub,modelAndView);
			}else{ //정상일 경우 정상데이터 generate한다.
				if ( hub != null ) 	hubService.makeData(modelAndView, request, hub);
			}
			return modelAndView;
		} catch(DataAccessException sve) {
			EgovWebUtil.exLogging(sve);
			hubService.markErrorMessage(hub,modelAndView); //error 메시지 만드는 서비스 메소드 호출
			return modelAndView;
		} catch(Exception e) {
			EgovWebUtil.exLogging(e);
			hubService.markErrorMessage(hub,modelAndView); //error 메시지 만드는 서비스 메소드 호출
			return modelAndView;
        }
	}
	
	/**
	 * request에 변수를 hub에 매핑하여 셋팅한다.
	 * @param API_RES
	 * @param request
	 * @param hub
	 * @return
	 * @throws Exception
	 */
	private int setDefaultParam(String API_RES,HttpServletRequest request,Hub hub)throws DataAccessException, Exception{
		
		HashMap<String,String> queryMap = new HashMap<String,String>();
		String queryString = URLDecoder.decode(UtilString.null2Blank(request.getQueryString()),"UTF-8").replaceAll("\\|", "%20").replaceAll("\\+", "%20");
		logger.debug("========================================\n"+queryString);
		String queryString2 = URLDecoder.decode(URLDecoder.decode(UtilString.null2Blank(request.getQueryString()),"MS949"),"UTF-8").replaceAll("\\|", "%20").replaceAll("\\+", "%20");
		logger.debug("========================================\n"+queryString2);
		String queryString3 = URLDecoder.decode(URLDecoder.decode(UtilString.null2Blank(request.getQueryString()),"8859_1"),"UTF-8").replaceAll("\\|", "%20").replaceAll("\\+", "%20");
		logger.debug("========================================\n"+queryString3);
		String queryString4 = URLDecoder.decode(URLDecoder.decode(URLDecoder.decode(UtilString.null2Blank(request.getQueryString()),"MS949"),"8859_1"),"UTF-8").replaceAll("\\|", "%20").replaceAll("\\+", "%20");
		logger.debug("========================================\n"+queryString4);
		if(!UtilString.null2Blank(queryString).equals("")){
			if (queryString != null) {
				String[] arrString = UtilString.getSplitArray(queryString,"&");
				for(int i=0; i <arrString.length; i++){
					String[] arrParam =  UtilString.getSplitArray(arrString[i],"=");
					if(arrParam.length == 2){
						if(arrParam[1].equalsIgnoreCase("Ext.util.JSONP.callback")|| (arrParam[0].equalsIgnoreCase("callback"))){//callback 셋팅
							hub.setCallback(arrParam[1]);
						}else{
							queryMap.put(arrParam[0].toUpperCase(), arrParam[1]);
						}
					}
				}
			}
		}
		
		hub.setUserIp(UtilHub.getUserIp(request)); //사용자 IP 셋팅
		hub.setQueryMap(queryMap);
		hub.setType(UtilHub.setContextType(request,queryMap));//타입 설정
		hub.setApiRes(API_RES);
		hub.setActKey(UtilString.null2Blank(queryMap.get("KEY")));
		hub.setpIndex(UtilString.null2Blank(queryMap.get("PINDEX")).equals("") ? "1" : queryMap.get("PINDEX")); //값이 없으면 1
		if(hub.getActKey().equals("")){
			hub.setpSize(HubConfig.HUB_SAMPLE);//5건
			hub.setpIndex("1");//1페이지안
		}else{
			hub.setpSize(UtilString.null2Blank(queryMap.get("PSIZE")).equals("") ? HubConfig.HUB_DEFAULT_DATA : queryMap.get("PSIZE"));//값이 없으면 100
		}
		return 0;
	}
}

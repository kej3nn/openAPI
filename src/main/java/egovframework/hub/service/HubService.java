package egovframework.hub.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

/**
 * OPEN API를 서비스하는 인터페이스
 * XML 형식은 XmlServiceImpl 주입, JSON 형식 JSONServiceImpl 주입
 * @author wiseopen
 * @since 2014.04.17
 * @version 1.0
 * @see cheon
 *
 */

public interface HubService {
	
	/**
	 * 반환할 OPEN API를 data를 가공하여 조회한다.
	 * @param request
	 * @param hub
	 * @return int
	 * @
	 */
	public int selectHubData(HttpServletRequest request,Hub hub) ;
	/**
	 * OPEN API에서 사용하는 API Message를 조회하여 셋팅한다.
	 * @param hub
	 * @
	 */
	public void selectApiMessageList(Hub hub) ;
	/**
	 * 원하는 형식으로 generate한다.
	 * @param modelAndView
	 * @param request
	 * @param hub
	 * @
	 */
	public void makeData(ModelAndView modelAndView,HttpServletRequest request,Hub hub);
	/**
	 * Data Error이 있을 경우 원하는 형식으로 generate한다.
	 * @param hub
	 * @param modelAndView
	 * @
	 */
	public void  markErrorMessage(Hub hub,ModelAndView modelAndView);
	/**
	 * Data Error가 있는지 검증한다.
	 * @param modelAndView
	 * @param hub
	 * @return
	 * @
	 */
	public int hubErrorCheck(ModelAndView modelAndView, Hub hub);
	
	/**
	 * System Error이 있을 경우 원하는 형식으로 generate한다.
	 * @param msg
	 * @
	 */
	public void systemErrorMsg(String msg,Hub hub);
}

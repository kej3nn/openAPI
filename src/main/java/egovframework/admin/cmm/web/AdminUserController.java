package egovframework.admin.cmm.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import egovframework.admin.user.service.AdminUserService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.common.base.constants.RequestAttribute;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.ggportal.user.web.PortalUserController;

/**
 * 관리자 정보를 관리하는 서비스 클래스이다.
 * 
 * @author jhkim
 * @version 1.0 2019/12/01
 */
@Controller
public class AdminUserController extends BaseController {
	
	public static final String ADM_MAIN_PAGE = "/admin/adminMain.do";

	@Resource(name="adminUserService")
	private AdminUserService adminUserService;
	
	/**
	 * 관리자 메뉴 접근시 유저 및 권한을 체크한다.
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/admin/user/loginProc.do", method=RequestMethod.POST)
	public ModelAndView loginProc(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mv = new ModelAndView();
    	String errMsg = "";
    	String viewName = "";
    	
    	try {
    		
    		// 포털에 로그인되어있는지 체크
    		/*
    		if ( !EgovUserDetailsHelper.isAuthenticatedPortal() ) {
    			// 비정상 접근
    			mv.setViewName("redirect:" + PortalUserController.MAIN_PAGE);
    			return mv;
    		}
    		*/
    		
    		Params params = getParams(request, false);
    		
    		// 접속자의 IP 획득
    		String ip = StringUtils.defaultIfEmpty(request.getRemoteAddr(), "");
	        if ( StringUtils.equals("::1", ip) || StringUtils.equals("0:0:0:0:0:0:0:1", ip) ) {	
	        	// 로컬호스트 체크
	            ip = "127.0.0.1";
	        }
	        params.put(RequestAttribute.USER_IP, ip);
	        
    		
    		// 관리자 메뉴 접근시 유저 및 권한 체크
    		int result = adminUserService.updateLoginProc(params);
    		
    		if ( result > 0 ) {
    			viewName = "redirect:" + ADM_MAIN_PAGE;
    		}
    		else {
    			
    			if ( result == -90 ) {
    				errMsg = "존재하지 않는 사용자 정보 입니다.";
    			}
    			else if ( result == -80 ) {
    				errMsg = "존재하지 않는 관리자 정보 입니다.";
    			}
    			else {
    				errMsg = "처리도중 오류가 발생하였습니다.";
    			}
    			
    			viewName = "forward:/portal/user/redirect.do";
    		}
    		
    		if ( StringUtils.isNotBlank(errMsg) )	mv.addObject("errMsg", errMsg);	
    		mv.setViewName(viewName);
    	} catch(DataAccessException dae) {
    		EgovWebUtil.exLogging(dae);
    	} catch(Exception e) {
    		EgovWebUtil.exLogging(e);
    		mv.addObject("errMsg", "처리도중 오류가 발생하였습니다.");	
    		mv.setViewName("forward:/portal/user/redirect.do");
    		return mv;
    	}
    	return mv;
	}
	
}

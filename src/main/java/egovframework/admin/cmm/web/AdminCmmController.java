package egovframework.admin.cmm.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.common.base.controller.BaseController;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.admin.basicinf.service.CommMenuService;
import egovframework.admin.basicinf.service.CommUsr;
import egovframework.admin.basicinf.service.CommUsrService;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.SessionLocaleResolver;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.common.WiseOpenButton;
import egovframework.common.helper.Encodehelper;
import egovframework.common.helper.Messagehelper;
import egovframework.common.util.UtilMenu;


/**
 * 관리자 공통으로 이동하는 클래스
 * @author wiseopen
 * @since 2014.04.17
 * @version 1.0
 *
 */
@Controller
public class AdminCmmController extends BaseController implements InitializingBean {

	protected static final Log logger = LogFactory.getLog(AdminCmmController.class);
	
	@Resource
	EgovMessageSource message;
	
	@Resource
	Encodehelper encodehelper;
	
	@Resource(name = "CommMenuService")
    private CommMenuService commMenuService;
	
	@Resource(name = "CommUsrService")
    private CommUsrService commUsrService;
	
	@Autowired
    private DefaultBeanValidator beanValidator;
	
	//공통 메시지 사용시 선언
	@Resource
	Messagehelper messagehelper;
	
	@Autowired
    private SessionLocaleResolver sessionLocaleResolver;

	public void afterPropertiesSet() {
	}

	/**
	 * 관리자 최초화면으로 이동한다.
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/admin.do")
	public String adminLoginPage(ModelMap model){
		return "/admin/admin";  
	}

	/**
	 * 로그인화면으로 이동한다.
	 * @param model
	 * @param commUsr
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/admLog.do")
	public String adminLogPage(ModelMap model, @ModelAttribute("commUsr") CommUsr commUsr, HttpServletRequest request, HttpSession session){
		
		if ( EgovUserDetailsHelper.isAuthenticated() ) {
			return "redirect:/admin/adminMain.do";
		}
		else {
			return "redirect:/portal/mainPage.do";	// 로그인 막음.
		}
		/*
		String userIp = request.getRemoteAddr();
		//userIp.startsWith("172.16.1") || 
		//logger.debug("ip = " + userIp + "!!!!!!!!!!!!!!!!");
		//아이피 차단을 걸었을때
		if(EgovProperties.getProperty("ipcheck.option").equals("on")){
			
			String[] iplist = EgovProperties.getProperty("ipcheck.iplist").split(",");
			boolean pass = false;
			for(String ip : iplist) {
				if(userIp.startsWith(ip)) {
					pass = true;
					break;
				}
			}
			
	    	if(pass){
	    		session.setAttribute("admLoginFlag", "OK");
	    		if(EgovUserDetailsHelper.isAuthenticated() ) {
	    			CommUsr loginVo = (CommUsr)session.getAttribute("loginVO");
	    			return pageStartMenu(loginVo);
	    		}
	    		model.addAttribute("adminlogin", commUsr);
	    		return "/admin/adminlogin";  	
	    	} else{
	    		
	    		return "/admin/error"; 
		    }
	    } 
		
		//차단이 안됐을시...
		session.setAttribute("admLoginFlag", "OK");
		 if(EgovUserDetailsHelper.isAuthenticated() ) {
				CommUsr loginVo = (CommUsr)session.getAttribute("loginVO");
				return pageStartMenu(loginVo);
			}
				model.addAttribute("adminlogin", commUsr);
		return "/admin/adminlogin";  	*/
	}

	@RequestMapping("/admin/error")
	public void alert(HttpServletRequest request, HttpServletResponse response) throws IOException{

	     PrintWriter writer = response.getWriter();
	     writer.println("<script type='text/javascript'>");
	     writer.println("alert('허용 IP가 아닙니다.');");
	     writer.println("history.back();");
	     writer.println("</script>");
	     writer.flush();
	     return;
	}
	
	/**
	 * 사용자 정보가 있는지 체크한 후 성공여부에 따라 페이지로 이동한다.
	 * @param session
	 * @param commUsr
	 * @param bindingResult
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unused")
	@RequestMapping("/admin/loginexec.do")
	public void adminLoginExec(HttpSession session, @ModelAttribute("commUsr") CommUsr commUsr, BindingResult bindingResult
			, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		/*
		Locale locale = new Locale("ko", "KR", "");       
		
		sessionLocaleResolver.setLocale(request, response, locale);
		
		response.setContentType("text/html;charset=UTF-8");
		
		try {
			PrintWriter writer = response.getWriter();
			CommUsr loginVO = commUsrService.selectCommUsrCheck(commUsr);
			session.setAttribute("loginVO", loginVO);                 
			CommUsr loginVo = (CommUsr)session.getAttribute("loginVO");
			if( loginVo != null){
				logger.debug( "vo 성공!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
				session.setAttribute("ssoState", "Y");	//내부협업 접근을 위해 임시 추가
				if(EgovUserDetailsHelper.isAuthenticated()) { //인증된 사용자인지 아닌지를 체크한다.
				
				logger.debug("세션성공!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
				
				writer.println("<script>top.location.href='/admin/adminMain.do';</script>");
				
				}
			} else {
				try {
					session.invalidate(); //세션초기화
					writer = response.getWriter();
					writer.println("<script>alert(\"아이디 또는 비밀번호가 올바르지 않습니다.\");</script>");
					writer.println("<script>location.href='/admin/admin.do';</script>");
					writer.close();
					return;
				} catch (IOException e1) {
					session.invalidate(); //세션초기화
					EgovWebUtil.exLogging(e1);
				}
			}
			
		} catch(IOException e) {
			//session.invalidate(); //세션초기화
			session.setAttribute("usrId", "");
			session.setAttribute("usrPw", "");
			session.setAttribute("usrPki", "");
			PrintWriter writer = null;
			try {
				writer = response.getWriter();
				writer.println("<script>location.href='/admin/admin.do';</script>");
				writer.close();
			} catch (IOException e1) {
				session.invalidate(); //세션초기화
				EgovWebUtil.exLogging(e1);
			}
		}catch(Exception e) {
			session.setAttribute("usrId", "");
			session.setAttribute("usrPw", "");
			session.setAttribute("usrPki", "");
			PrintWriter writer = null;
			try {
				writer = response.getWriter();
				writer.println("<script>location.href='/admin/admin.do';</script>");
				writer.close();
			} catch (IOException e1) {
				//session.invalidate(); //세션초기화
				session.setAttribute("usrId", "");
				session.setAttribute("usrPw", "");
				session.setAttribute("usrPki", "");
				EgovWebUtil.exLogging(e1);
			}
		}finally{
		}*/
	}
	
	/**
	 * 관리자 상단 메뉴를 조회한다.
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/admintop.do")
	public String adminTopPage(HttpSession session, ModelMap model, HttpServletRequest request,  HttpServletResponse response){
		//메뉴 select 
		Locale locale = new Locale("ko", "KR", "");              
		response.setLocale(locale);
		sessionLocaleResolver.setLocale(request, response, locale);
		CommUsr loginVo = (CommUsr)session.getAttribute("loginVO");
		
		int menuAccGrant = 0;
		if(session.getAttribute("menuAcc") != null){
			menuAccGrant = (Integer)session.getAttribute("menuAcc");  
				WiseOpenButton wiseOpenButton = new WiseOpenButton(); // 스프링 주입시 싱글톤이 적용되서 사용자 권한이 이상해짐
				wiseOpenButton.setAcc(menuAccGrant);
				session.setAttribute("button", wiseOpenButton);
			//}
		}
		
		if(loginVo == null){
			 loginVo = new CommUsr();
			 loginVo.setAccCd("SYS");
		}
		try {
			loginVo.setMenuTop(true);
			model.addAttribute("admintop", UtilMenu.getAdminMenu(commMenuService.selectCommMenuTop(loginVo)));
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return "/admin/admintop";  
	}
	
	/**
	 * 로그아웃
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/adminlogOut.do")
	public String adminLogOut(HttpSession session){

		if ( EgovUserDetailsHelper.isAuthenticatedPortal() ) {
			getSession(false).invalidate();
		}

        String sbUrl = EgovProperties.getProperty("url.member.main") + "/login/logout.do" + "?returnUrl=" +
                EgovProperties.getProperty("url.open.main") +
                "/portal/mainPage.do";

		return "redirect:" + sbUrl;
//		session.invalidate();
//		return "redirect:/admin/admLog.do?code=adminLogin";
//		return "redirect:/portal/mainPage.do";
		
	}
	
	/**
	 * 언어변화
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/adminLanguage.do")
	public String adminLanguage(){
		return "redirect:/admin/admin.do";  
	}

	/**
	 * 사용자를  수정한다.
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/ajaxBeforeSendAdmin.do")
	@ResponseBody
	public void ajaxBeforeSend(){
	}
	
	/**
	 * pageStartMenu를 호출하여 로그인상태라면 관리자페이지로 이동시킨다.
	 * @param loginVo
	 * @return
	 */
	//@RequestMapping("/redirectpage")
	private String pageStartMenu(CommUsr loginVo){
		return "redirect:/admin/adminMain.do";
	}
	
	/**
	 * 비밀번호 변경기간 초과시 비밀번호 변경화면으로 이동(초과기간은 90일로 지정)
	 * @param session
	 * @param commUsr
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/user/adminChangePasswd.do")
	public String adminChangePasswd(HttpSession session, @ModelAttribute("commUsr") CommUsr commUsr, ModelMap model) {
		if (commUsr == null) {
			commUsr = new CommUsr();
		}
		if(EgovUserDetailsHelper.isAuthenticated()) {
			commUsr.setUsrId((String)session.getAttribute("usrId"));
			commUsr.setUsrPw((String)session.getAttribute("usrPw"));
			if ( commUsrService.selectCommUsrChangePwDttm(commUsr) )	//다이렉트로 url 치고 들어올 수 있어서 한번더 체크
				return "/admin/user/adminchangepasswd";
			else
				return "redirect:/admin/admin.do";
		} else {
			return "redirect:/admin/admin.do";
		}
	}
	
	/**
	 * 비밀번호 변경기간 초과시 비밀번호 변경
	 * @param session
	 * @param commUsr
	 * @param model
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/user/adminChangePasswdExec.do")
	public void adminChangePasswdExec(HttpSession session, @ModelAttribute("commUsr") CommUsr commUsr, ModelMap model, HttpServletResponse response) {
		if (commUsr == null) {
			commUsr = new CommUsr();
		}
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter writer = null;
		try {
			writer = response.getWriter();
			if(EgovUserDetailsHelper.isAuthenticated()) {
				commUsr.setUsrId((String)session.getAttribute("usrId"));
				CommUsr resultVO = new CommUsr();
                commUsr = commUsrService.selectCommUsrCheck(commUsr);
				int pwCheckCnt = commUsrService.selectUserPwCheck(commUsr); //비밀번호 변경시 기존의 비밀번호로 변경못하도록 체크한다.
				if (pwCheckCnt != 1) {
					logger.debug("회원정보 있음.");
					if (commUsrService.saveCommUsrChangePw(commUsr) > 0) {	//정상변경
						logger.debug("90일초과 비밀번호 변경.");
						writer.println("<script>alert('정상적으로 변경되었습니다.');</script>");
						writer.println("<script>location.href='/admin/admin.do';</script>");
					}
				} else {
					logger.debug("비밀번호 틀림.");
                    writer.println("<script>alert('변경하려는 비밀번호가 기존 비밀번호와 같습니다.');</script>");
                    writer.println("<script>location.href='/admin/user/adminChangePasswd.do';</script>");
                }
			} 
			writer.println("<script>location.href='/admin/user/adminChangePasswd.do';</script>");
			
		} catch (Exception e) {
			EgovWebUtil.exTransactionLogging(e);
		} finally{
			if(writer != null){
				writer.close();
			}
		}
	}

	/**
	 * 관리자 메인페이지
	 * @param model
	 * @param commUsr
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/adminMain.do")
	public String adminMain(ModelMap model, @ModelAttribute("SearchVO") CommUsr commUsr,  HttpSession session) {
		
		if ( !EgovUserDetailsHelper.isAuthenticated() ) {
			return "redirect:/portal/mainPage.do";
		}

		if (commUsr == null) {
			commUsr = new CommUsr();
		}
		
		commUsr.setUsrId((String)session.getAttribute("usrId"));
		model.addAttribute("AccCd", commUsrService.selectAccCdCheck(commUsr) ); //AccCd 권한 체크하여 sys,admin 인 경우만 업무처리정보 볼수있다.
//		model.addAttribute("QnA", commUsrService.selectQNACnt() ); //Q&A 답변 요청 건수
//		model.addAttribute("GALLERY", commUsrService.selectGalleryCnt() ); // 활용사례등록 요청 건수..
		
		return "/admin/adminmain";
	}
}

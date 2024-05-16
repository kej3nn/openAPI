package egovframework.admin.user.web;

/**
 * 
 * 관리자회원 서비스 클래스
 * @author jyson
 * @since 2014.09.18
 * @version 1.0
 * @see
 *
 */

import java.io.PrintWriter;
import java.util.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.admin.user.service.*;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.WiseOpenConfig;
import egovframework.common.code.service.CodeListService;
import egovframework.common.grid.IBSResultVO;
import egovframework.common.grid.IBSheetListVO;
import egovframework.common.helper.Messagehelper;
import egovframework.common.util.UtilString;
import egovframework.portal.model.User;

@Controller
public class UserController implements InitializingBean {

	protected static final Log logger = LogFactory.getLog(UserController.class);
	
	@Resource
	private UserService userService;
	
	@Resource
	private UserKeyService userKeyService;
	
	//공통코드 사용시 선언
	@Resource
	private CodeListService commCodeListService;
	
	//공통 메시지 사용시 선언
	@Resource
	Messagehelper messagehelper;
	
	@Resource
	EgovMessageSource message;
	
	static class userKeys extends HashMap<String, ArrayList<UserKey>> { }
	
	public void afterPropertiesSet() {

	}

	/**            
	 * 공통코드를 조회 한다.
	 * @return
	 * @throws Exception
	 */
	@ModelAttribute("codeMap")
	public Map<String, Object> getcodeMap(){
		Map<String, Object> codeMap = new HashMap<String, Object>();
		try {
			codeMap.put("area", commCodeListService.getCodeList("C1005"));
			codeMap.put("member", commCodeListService.getCodeList("C1006"));
			codeMap.put("limit", commCodeListService.getCodeList("D1030"));
			codeMap.put("usrEmail", commCodeListService.getCodeList("C1009")); //이메일
			codeMap.put("usrTel", commCodeListService.getCodeList("C1008")); //전화번호(집)
			codeMap.put("usrHp", commCodeListService.getCodeList("C1007")); //휴대폰 연락처
			codeMap.put("naidCd", commCodeListService.getCodeList("C1016")); //연계시스템 국고보조금
			codeMap.put("jobCd", commCodeListService.getCodeList("C1003")); //직원직책
			codeMap.put("notiHhCd", commCodeListService.getCodeList("C1025")); //알림시간 select box
			
		}  catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return codeMap;
	}

	/**
	 * 회원목록화면으로 이동한다.
	 * @param model
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/admin/user/userPage.do")
	public String userPage(ModelMap model){
		//페이지 title을 가져오려면 반드시 *Page로 끝나야한다.
		//Interceptor(PageNavigationInterceptor)에서 조회함
		return "/admin/user/userlist";
	}

	/**
	 * 회원목록 전체조회
	 * @param userVo
	 * @param model
	 * @return IBSheetListVO<UserVo>
	 * @throws Exception
	 */
	@RequestMapping("/admin/user/userListAll.do")
	@ResponseBody
	public IBSheetListVO<UserVo> userListAll(@ModelAttribute("searchVO") UserVo userVo, ModelMap model){
		List<UserVo> list = new ArrayList<UserVo>();
		if (userVo != null) {
			list = userService.userListAllIbPaging(userVo);
		}

		return new IBSheetListVO<UserVo>(list, list.size());
	}

	/**
	 * 인증키정보 화면으로 이동한다.
	 * @param model
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/admin/user/userKeyPage.do")
	public String userKeyPage(ModelMap model){
		//페이지 title을 가져오려면 반드시 *Page로 끝나야한다.
		//Interceptor(PageNavigationInterceptor)에서 조회함
		return "/admin/user/userkey";
	}

	/**
	 * 인증키정보 전체조회
	 * @param userKey
	 * @param model
	 * @return IBSheetListVO<UserKey>
	 * @throws Exception
	 */
	@RequestMapping("/admin/user/userKeyAll.do")
	@ResponseBody
	public IBSheetListVO<UserKey> userKeyAll(@ModelAttribute("searchVO") UserKey userKey, ModelMap model){
		Map<String, Object> map = new HashMap<String, Object>();
		if (userKey != null) {
			map = userKeyService.userKeyAllIbPaging(userKey);
		}
		@SuppressWarnings("unchecked")
		List<UserKey> result = (List<UserKey>) map.get("resultList");
		int cnt = Integer.parseInt((String)map.get("resultCnt"));
		
		return new IBSheetListVO<UserKey>(result, cnt);
	}

	/**
	 * 인증키 이용제한 수정
	 * @param userKeys
	 * @param locale
	 * @return IBSResultVO<UserKey>
	 * @throws Exception
	 */
	@RequestMapping("/admin/user/updateUserKey.do")
	@ResponseBody
	public IBSResultVO<UserKey> updateUserKey(@RequestBody userKeys userKeys, Locale locale){
		ArrayList<UserKey> list = new ArrayList<UserKey>();
		if (userKeys != null) {
			list = userKeys.get("data");
		}
		int result = userKeyService.updateUserKeyCUD(list);
		String resmsg;
		if(result > 0) {
			result = 0;
			resmsg = message.getMessage("MSG.SAVE");
		} else {
			result = -1;
			resmsg = message.getMessage("ERR.SAVE");
		}
		
		return new IBSResultVO<UserKey>(result, resmsg);
		
	}
	
	
	/**
	 * 회원가입 전 이용약관 동의 및 가입 확인 페이지
	 * @param model
	 * @param commUser
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/user/agmtReg.do")
	public String agmtReg(ModelMap model, @ModelAttribute("SearchVO") CommUsr commUser ) {
		return "/admin/user/useragmtreg";
	}
	
	/**
	 * 회원가입 페이지
	 * @param model
	 * @param commUsr
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/user/memReg.do")
	public String memReg(ModelMap model, @ModelAttribute("SearchVO") CommUsr commUsr ) {
		if (commUsr == null) {
			commUsr = new CommUsr();
		}
		String agreeYn = StringUtils.defaultString(commUsr.getAgreeYn());
		if( "Y".equals(agreeYn) ){ //이용약관 동의해야 한다.
			model.addAttribute("usrAgreeYn", agreeYn); //약관동의 값 전달
			return "/admin/user/usermemreg";
		}
		return "/admin/user/useragmtreg";
	}
	
	/**
	 * 회원아이디 중복확인
	 * @param commUsr
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/user/memRegUsrIdDup.do")
	@ResponseBody
	public IBSResultVO<User> memRegUsrIdDup(@ModelAttribute("SearchVO") CommUsr commUsr, ModelMap model){
		int result = 0;
		if (commUsr != null) {
			result = userService.memRegUsrIdDup(commUsr);
		}
		return new IBSResultVO<User>(result, messagehelper.getSavaMessage(result));
	}
	
	/**
	 * 관리자 회원계정 insert한다.
	 * @param model
	 * @param commUsr
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/user/memRegInsert.do")
	@ResponseBody
	public IBSResultVO<CommUsr> memRegInsert(ModelMap model, @ModelAttribute("SearchVO") CommUsr commUsr, HttpSession session) {
		if (commUsr == null) {
			commUsr = new CommUsr();
		}
		int result = 0;
		if ("1,,".equals(StringUtils.defaultString(commUsr.getUsrTel()))) { //전화번호 입력을 안했을경우 1,, 값으로 넘어온다.
			commUsr.setUsrTel("1");  //ibatis에서 eqals로 값비교 위해 임의로 1로 변환
		}
		if ("1,,".equals(StringUtils.defaultString(commUsr.getUsrHp()))) { //전화번호 입력을 안했을경우 1,, 값으로 넘어온다.
			commUsr.setUsrHp("1"); 
		}
		if (",".equals(StringUtils.defaultString(commUsr.getUsrEmail()))) { //이메일 입력을 안했을경우 , 값으로 넘어온다.
			commUsr.setUsrEmail("1"); 
		}
		
		//GPIN 세선졍보 Set
		commUsr.setRauthDi(UtilString.getSessionVal(session, "dupInfo"));			//중복가입정보
		commUsr.setRauthVid(UtilString.getSessionVal(session, "virtualNo"));		//개인식별번호
		commUsr.setRauthSex(UtilString.getSessionVal(session, "sex"));				//성별
		commUsr.setRauthBirth(UtilString.getSessionVal(session, "birthDate"));		//생년월일
		commUsr.setRauthYn(UtilString.getSessionVal(session, "rauthYn"));			//실명인증 여부
		commUsr.setRauthNi(UtilString.getSessionVal(session, "nationalInfo"));		//내외국인 여부
		commUsr.setUsrNm((String)session.getAttribute("realName") );
		
		 
		result = userService.memRegInsertCUD(commUsr, WiseOpenConfig.STATUS_I); //회원계정 insert 한다.
		UtilString.clearGPINSessionVal(session);			//정보 입력 후 GPIN 세션 초기화(실패해도 초기화)
		return new IBSResultVO<CommUsr>(result, messagehelper.getSavaMessage(result));
	}
	
	/**
	 * 관리자 회원가입 결과 페이지
	 * @param model
	 * @param commUsr
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/user/memResult.do")
	public String memResult(ModelMap model, @ModelAttribute("SearchVO") CommUsr commUsr) {
		if (commUsr == null) {
			commUsr = new CommUsr();
		} else {
			commUsr = userService.selectSmsSendInfo(commUsr); //sms전송하기 위한 정보 조회
		}

		model.addAttribute("UsrId", StringUtils.defaultString(commUsr.getUsrId())); //사용자가 가입한 id
		
		if( "Y".equals(StringUtils.defaultString(commUsr.getHpYn())) ){ //문자메세지 수신동의 했을때
			/*int result = 0;
			
			commUsr.setSmsSeq( portalUserService.selectSmsSeq() ); //SMS의 seq값 MAX+1
			String sendMsg = "열린재정 시스템 관리자 계정 가입완료 됐습니다.\nID :"+commUsr.getUsrId();
			String rcvHp = "15448822"; //(암호화)콜백 휴대폰번호
			
			commUsr.setSendMsg(sendMsg); //전달하는 메세지 정보.
			commUsr.setRcvHp(rcvHp); //콜백 휴대폰번호 ..
			
			//transSmsCUD() 인자타입 맞춰주기 위해 사용.
			User user = new User();
			user.setSmsSeq( commUsr.getSmsSeq() );
			user.setSendMsg( commUsr.getSendMsg() );
			user.setUserHp( commUsr.getUsrHp() );
			user.setRcvHp( commUsr.getRcvHp() ); 
			
			result = portalUserService.transSmsCUD(user, WiseOpenConfig.STATUS_I); //sms전송한다.
*/			
		}
		return "/admin/user/memresult";
	}

	/**
	 * 관리자 아이디 / 비밀번호 찾기 페이지
	 * @param model
	 * @param commUsr
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/user/memIdPwSearch.do")
	public String memIdPwSearch(ModelMap model, @ModelAttribute("SearchVO") CommUsr commUsr ) {
		return "/admin/user/useridpwsearch";
	}

	/**
	 * 관리자 아이디 / 비밀번호 찾기 확인 페이지
	 * @param model
	 * @param commUsr
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/user/memIdPwSearchResult.do")
	public String memIdPwSearchResult( ModelMap model, @ModelAttribute("SearchVO") CommUsr commUsr, HttpSession session ) {
		if (commUsr == null) {
			commUsr = new CommUsr();
		}
		String searchId =  session.getAttribute("amdinSearchId") == null ? "" : (String)session.getAttribute("amdinSearchId");		//중복가입정보
		if(!searchId.equals(StringUtils.defaultString(commUsr.getUsrId()))){ // 추가(왠지 모의해킹 걸리지 않았을까???)
			UtilString.clearGPINSessionVal(session);			//정보 입력 후 GPIN 세션 초기화(실패해도 초기화)
			session.setAttribute("amdinSearchId",""); 
			return "/admin/user/useridpwsearch";
		}else{
			User user = new User(); //타입맞추기 위해 생성.
			String messageCheck = commUsr.getMessageCheck() == null ? "N" : commUsr.getMessageCheck();
			
			commUsr = userService.UserInfoCUD(commUsr); //비밀번호 초기화,업데이트 및 사용자 정보 조회 sms로 보낼타입으로 리턴한다.
			commUsr.setMessageCheck(messageCheck);		//조회 후 수신동의 여부 set
			model.addAttribute("emptyHp", "N");			//default 'N' 세팅
			model.addAttribute("CommUsr", commUsr ); //확인 페이지에서 사용.
			user.setUserHp(StringUtils.defaultString(commUsr.getUsrHp())); //전화번호만 따로담는다.
			user.setUserPw(StringUtils.defaultString(commUsr.getUsrPw())); //초기화 후 비밀번호를 담는다.

			UtilString.clearGPINSessionVal(session);			//정보 입력 후 GPIN 세션 초기화(실패해도 초기화)
			session.setAttribute("amdinSearchId",""); 
			return "/admin/user/useridpwsearchresult";
		}
	}

	/**
	 * 공인인증서 등록 페이지 
	 * @param model
	 * @param commUsr
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/user/ksignReg.do")
	public String ksignReg(ModelMap model, @ModelAttribute("SearchVO") CommUsr commUsr ) {
		return "/admin/user/ksignreg";
	}

	/**
	 * 공인인증서 발급 페이지 
	 * @param model
	 * @param commUsr
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/user/ksignIssue.do")
	public String ksignIssue(ModelMap model, @ModelAttribute("SearchVO") CommUsr commUsr ) {
		return "/admin/user/ksignissue";
	}

	/**
	 * 관리자 본인인증 최초 1회만 본인인증할때만 나타난다.
	 * @param model
	 * @param commUsr
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/user/adminIpin.do")
	public String adminIpin(ModelMap model, @ModelAttribute("SearchVO") CommUsr commUsr ) {
			return "/admin/user/adminipin";
	}
	
	/**
	 * 회원정보 수정하기전 아이디/비밀번호 체크 페이지
	 * @param model
	 * @param commUsr
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/user/pwConfirm.do")
	public String pwConfirm(ModelMap model, @ModelAttribute("SearchVO") CommUsr commUsr, HttpSession session, HttpServletRequest request ) {
		/* 국회사무처는 비밀번호 체크 안함 패스
		egovframework.admin.basicinf.service.CommUsr loginVO = (egovframework.admin.basicinf.service.CommUsr)session.getAttribute("loginVO");
		model.addAttribute("usrId", loginVO.getUsrId());
		model.addAttribute("pwPass", request.getParameter("pwPass"));
		return "/admin/user/adminpwconfirm";*/

		if (commUsr != null) {
			commUsr.setUsrId((String)session.getAttribute("portalUserId"));
			model.addAttribute("Usr", userService.getMemIdPwSearchInfo(commUsr) ); // id를 가지고 정보를 조회한다.
		}
		return "/admin/user/adminmemupd";
	}

	/**
	 * 관리자 정보 수정 페이지
	 * @param model
	 * @param commUsr
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/user/memUpd.do")
	public String memUpd(ModelMap model, @ModelAttribute("SearchVO") CommUsr commUsr, HttpSession session) {
		if(commUsr != null && userService.selectPwConfirm(commUsr)){ //아이디와 비밀번호가 일치할때
		//	if(EgovUserDetailsHelper.isAuthenticatedPortal()) {	//로그인을 한 상태인지 확인한다.
		//		user.setUserId((String)session.getAttribute("portalUserId"));	//로그인 성공시 아이디 세션에 저장	
				model.addAttribute("Usr", userService.getMemIdPwSearchInfo(commUsr) ); // id를 가지고 정보를 조회한다.
				return "/admin/user/adminmemupd";
		//	}
		} 
		
		return "redirect:/admin/user/pwConfirm.do?pwPass=F"; //로그인 실패했을때 다시 이동.
	}

	/**
	 * 관리자 회원정보 수정 update 한다.
	 * @param model
	 * @param commUsr
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/admin/user/memInfoUpd.do")
	public void memInfoUpdCUD(ModelMap model, @ModelAttribute("SearchVO") CommUsr commUsr, HttpServletResponse response ) {
		response.setContentType("text/html;charset=UTF-8");
		try {
			PrintWriter writer = response.getWriter();
			//if(EgovUserDetailsHelper.isAuthenticatedPortal()) {	//로그인을 한 상태인지 확인한다. 
			int result = 0;
			/*
			if("1,,".equals( commUsr.getUsrTel() ) ){ //전화번호 입력을 안했을경우 1,, 값으로 넘어온다. 
				commUsr.setUsrTel("1");  //ibatis에서 eqals로 값비교 위해 임의로 1로 변환
			}
			if("1,,".equals( commUsr.getUsrHp() ) ){ //전화번호 입력을 안했을경우 1,, 값으로 넘어온다. 
				commUsr.setUsrHp("1"); 
			}
			if(",".equals( commUsr.getUsrEmail() ) ){ //이메일 입력을 안했을경우 , 값으로 넘어온다.
				commUsr.setUsrEmail("1"); 
			}
			 */
			if (commUsr != null) {
				result = userService.memRegInsertCUD(commUsr, WiseOpenConfig.STATUS_U); //회원정보 수정.
			}
			if(result == 1){
				writer.println("<script>alert('회원정보가 정상적으로 수정되었습니다.');</script>");
				writer.println("<script>location.href='/admin/adminMain.do';</script>"); //수정이 완료되면 이동
			}else{
				writer.println("<script>alert('회원정보 수정이 실패하였습니다.\n다시 확인해 주세요.');</script>");
				writer.println("<script>location.href='/admin/user/pwConfirm.do';</script>"); //수정실패시 재수정페이지로 이동.
			}
			//}
			writer.close();
			
		}  catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
	}
	
	/**
	 * 아이핀 인증(관리자 최초 로그인시)
	 * @param model
	 * @param commUsr
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("admin/user/adminipinAgreeExec.do")
	@ResponseBody
	public void ipinAgreeExec(ModelMap model, @ModelAttribute("SearchVO") CommUsr commUsr, HttpSession session, HttpServletResponse response) {
		response.setContentType("text/html;charset=UTF-8");
		try {
			
			PrintWriter writer = response.getWriter();
			int result = 0;
			if (commUsr != null) {
				commUsr.setUsrId(UtilString.getSessionVal(session, "usrId"));				//로그인ID
				//GPIN 세선졍보 Set
				commUsr.setRauthDi(UtilString.getSessionVal(session, "dupInfo"));			//중복가입정보
				commUsr.setRauthVid(UtilString.getSessionVal(session, "virtualNo"));		//개인식별번호
				commUsr.setRauthSex(UtilString.getSessionVal(session, "sex"));				//성별
				commUsr.setRauthBirth(UtilString.getSessionVal(session, "birthDate"));		//생년월일
				commUsr.setRauthYn(UtilString.getSessionVal(session, "rauthYn"));			//실명인증 여부
				commUsr.setRauthNi(UtilString.getSessionVal(session, "nationalInfo"));		//내외국인 여부
				//
				result = userService.saveIpinAgree(commUsr);
			}
			if ( result > 0 ) {
				writer.println("<script>alert('정상적으로 인증되었습니다.');</script>");
				writer.println("<script>location.href='/admin/adminMain.do';</script>"); //수정 완료시 관리자 메인으로
			} else {
				writer.println("<script>alert('인증 실패하였습니다.');</script>");
				writer.println("<script>location.href='/admin/user/adminIpin.do';</script>"); //인증실패시 재인증페이지로 이동.
			}
			UtilString.clearGPINSessionVal(session);			//정보 입력 후 GPIN 세션 초기화(실패해도 초기화)
			writer.close();
		}  catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
	}
	
	/**
	 * I-PIN 인증내역으로 관리자 ID 찾기
	 * @param model
	 * @param commUsr
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/user/findAdminId.do")
	@ResponseBody
	public String findAdminId(ModelMap model, @ModelAttribute("SearchVO") CommUsr commUsr, HttpSession session) {
		String userId = "";
		if (commUsr != null) {
			commUsr.setRauthDi(UtilString.getSessionVal(session, "dupInfo"));			//중복가입정보
			commUsr.setRauthVid(UtilString.getSessionVal(session, "virtualNo"));		//개인식별번호

			userId = userService.findAdminId(commUsr);

			session.setAttribute("amdinSearchId",userId);	//찾은 id 넣기
			session.setAttribute("dupInfo","");
			session.setAttribute("virtualNo","");
		}
		return userId;
	}
}
 
package egovframework.ggportal.user.web;

import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.RSAPublicKeySpec;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.ggportal.bbs.service.PortalBbsAdminService;
import egovframework.ggportal.bbs.service.PortalBbsListService;
import egovframework.ggportal.user.service.PortalMyPageService;
import egovframework.ggportal.user.service.PortalUserKeyService;

/**
 * 마이페이지
 * @author 장홍식
 *
 */
@Controller("ggportalMyPageController")
public class PortalMyPageController extends BaseController {

	public final static String QNA_BBS_CD = "QNA01";
	public final static String GALLERY_BBS_CD = "GALLERY";
	public final static String BLOG_BBS_CD = "BLOG";
	
    /**
     * 게시판 설정을 관리하는 서비스
     */
    @Resource(name="ggportalBbsAdminService")
    private PortalBbsAdminService portalBbsAdminService;
    
    /**
     * 게시판 내용을 관리하는 서비스
     */
    @Resource(name="ggportalBbsListService")
    private PortalBbsListService portalBbsListService;
    
    /**
     * 마이페이지 서비스
     */
    @Resource(name="ggportalMyPageService")
    private PortalMyPageService portalMyPageService;
    
    /**
     * 사용자 키 서비스
     */
    @Resource(name="ggportalUserKeyService")
    private PortalUserKeyService portalUserKeyService;
    
    private static String RSA_WEB_KEY = "_RSA_WEB_Key_";
    private static String RSA_INSTANCE = "RSA";
    
    @RequestMapping("/portal/myPage/myPage.do")
    public String selectMyPage(HttpServletRequest request, Model model) {
		Params params = getParams(request, true);
    	return "ggportal/mypage/myPage";
    }
    
	/**
	 * 나의 게시판 데이터
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/myPage/myBBSList.do")
	public String myBBSList(HttpServletRequest request, Model model) {
		Params params = getParams(request, true);
		
        debug("Request parameters: " + params);
        params.put("myUserCd", params.getInt("regId"));
        
        // 게시판 내용을 검색한다.
        
        Object result = portalBbsListService.searchBbsList(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
		return "jsonView";
	}
	
    //////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////// 인증키 관련 컨트롤러 //////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////
    
	/**
	 * 인증키 발급 화면
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/myPage/actKeyPage.do")
	public String actKeyPage(HttpServletRequest request, Model model) {
		Params params = getParams(request, true);
    	model.addAttribute("tabIdx", params.getInt("tabIdx", 0));
		model.addAttribute("menuCd");
        return "ggportal/mypage/actKey/actKey";
	}
	
	/**
	 * 인증키 등록
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/myPage/insertActKey.do")
	public String insertActKey(HttpServletRequest request, Model model) {
		Params params = getParams(request, true);
		
		Object result = portalUserKeyService.insertActKeyCUD(params);
		
		addObject(model, result);
		return "jsonView";
	}
	
	/**
	 * 인증키 폐기
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/myPage/deleteActKey.do")
	public String deleteActKey(HttpServletRequest request, Model model) {
		Params params = getParams(request, true);
		
		Object result = portalUserKeyService.deleteActKey(params);
		
		addObject(model, result);
		return "jsonView";
	}

	/**
	 * 인증키 목록 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/myPage/searchActKey.do")
	public String searchActKey(HttpServletRequest request, Model model) {
		Params params = getParams(request, true);
		
		Object result = portalUserKeyService.searchActKey(params);
		addObject(model, result);
		
		return "jsonView";
	}
	
	/**
	 * OpenAPI 목록 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/myPage/searchOpenAPI.do")
	public String searchOpenAPI(HttpServletRequest request, Model model) {
		Params params = getParams(request, true);
		
		Object result = portalMyPageService.searchOpenApi(params);
		addObject(model, result);
		
		return "jsonView";
	}
	/**
	 * OpenAPI 인증키 폐기
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/myPage/updateDiscardActKey.do")
	public String updateDiscardActKey(HttpServletRequest request, Model model) {
		Params params = getParams(request, true);
		Object result = portalMyPageService.updateDiscardActKey(params);
		
        addObject(model, result);
		return "jsonView";
	}
    //////////////////////////////////////////////////////////////////////////////////////
    //////////////////// 나의 질문 내역  관련 컨트롤러 ////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////
	/**
	 * 나의 질문 내역 화면
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/myPage/myQnaPage.do")
	public String myQnaPage(HttpServletRequest request, Model model) {
		Params params = getParams(request, true);
        params.put("bbsCd", QNA_BBS_CD);

		selectBbsAdmin(params, model);
        return "ggportal/mypage/myQna/searchMyQna";
	}
	
	/**
	 * 질문 등록 화면
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/myPage/insertMyQnaPage.do")
	public String insertMyQnaPage(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        params.put("bbsCd", QNA_BBS_CD);
        
		selectBbsAdmin(params, model);
		return "ggportal/mypage/myQna/insertMyQna";
	}
	
	/**
	 * 질문 조회화면
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/myPage/selectMyQnaPage.do")
	public String selectMyQnaPage(HttpServletRequest request, Model model) {
		        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        params.put("bbsCd", QNA_BBS_CD);
        
		selectBbsAdmin(params, model);
		return "ggportal/mypage/myQna/selectMyQna";
	}
	
	@RequestMapping("/portal/myPage/updateMyQnaPage.do")
	public String updateMyQnaPage(HttpServletRequest request, Model model) {
		        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        params.put("bbsCd", QNA_BBS_CD);
        
		selectBbsAdmin(params, model);
		return "ggportal/mypage/myQna/updateMyQna";
	}
	
    //////////////////////////////////////////////////////////////////////////////////////
    //////////////////////// 활용 갤러리,블로그 관련 컨트롤러 ////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////
	/**
	 * 활용 갤러리 목록 화면
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/myPage/utilGalleryPage.do")
	public String utilGalleryPage(HttpServletRequest request, Model model) {
		Params params = getParams(request, true);
        params.put("bbsCd", GALLERY_BBS_CD);
        
		selectBbsAdmin(params, model);
        return "ggportal/mypage/utilGallery/searchUtilGallery";
	}
	
	/**
	 * 블로그 목록 화면
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/myPage/utilBlogPage.do")
	public String utilBlogPage(HttpServletRequest request, Model model) {
		Params params = getParams(request, true);
        params.put("bbsCd", BLOG_BBS_CD);
        
		selectBbsAdmin(params, model);
        return "ggportal/mypage/utilGallery/searchUtilGallery";
	}
		
	/**
	 * 활용 갤러리 등록 화면
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/myPage/insertUtilGalleryPage.do")
	public String insertUtilGalleryPage(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        params.put("bbsCd", GALLERY_BBS_CD);
        
		selectBbsAdmin(params, model);
		return "ggportal/mypage/utilGallery/insertUtilGallery";
	}
	
	/**
	 * 활용 갤러리 활용데이터(공공데이터) 팝업(검색용)으로 이동(iframe)
	 */
	@RequestMapping("/portal/myPage/popup/openInfSearchPop.do")
	public String openInfSearchPopup(HttpServletRequest request, Model model){
		return "ggportal/mypage/utilGallery/popup/openInfSearchPop";
	}
	
	/**
	 * 활용데이터(공공데이터 선택 팝업 데이터 리스트 조회)
	 */
	@RequestMapping("/portal/myPage/popup/selectOpenInfSearchPop.do")
	public String selectOpenListPop(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);
        
        Object result = portalMyPageService.selectOpenInfSearchPop(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 안내수신정보 저장
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/portal/myPage/insertDvp.do")
	public String insertDvp(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        
        debug("Request parameters: " + params);
        
        Object result = portalMyPageService.updateDvp(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);
        
        return "jsonView";
	}
	/*
	* 안내수신정보 load 등록화면
	* 
	* @param request
	* @param model
	* @return
	* @throws Exception
	*/
	@RequestMapping("/portal/myPage/searchBbsDvp.do")
	public String searchBbsDvp(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
		Params params = getParams(request, true);
		
		debug("Request parameters: " + params);
		
		Object result = portalBbsListService.searchBbsDvp(params);
		
		debug("Processing results: " + result);
		
		addObject(model, result);
		
		return "jsonView";
	}
	/**
	 * 블로그 등록 화면
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/myPage/insertUtilBlogPage.do")
	public String insertUtilBlogPage(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        params.put("bbsCd", BLOG_BBS_CD);
        
		selectBbsAdmin(params, model);
		return "ggportal/mypage/utilGallery/insertUtilGallery";
	}
	
	/**
	 * 활용 갤러리 등록
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/myPage/insertUtilGallery.do")
	public String insertUtilGallery(HttpServletRequest request, Model model) {
		Params params = getParams(request, true);
        params.put("bbsCd", GALLERY_BBS_CD);
		
		Object result = portalMyPageService.insertUtilGalleryCUD(params);
		
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
		return "jsonView";
	}
	
	
	/**
	 * 블로그 등록
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/myPage/insertUtilBlog.do")
	public String insertUtilBlog(HttpServletRequest request, Model model) {
		Params params = getParams(request, true);
        params.put("bbsCd", BLOG_BBS_CD);
		
		Object result = portalMyPageService.insertUtilGalleryCUD(params);
		
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
		return "jsonView";
	}
	
	/**
	 * 활용 갤러리 상세조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/myPage/selectUtilGalleryPage.do")
	public String selectUtilGalleryPage(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        params.put("bbsCd", GALLERY_BBS_CD);
        
		selectBbsAdmin(params, model);
		return "ggportal/mypage/utilGallery/selectUtilGallery";
	}
	
	/**
	 * 블로그 상세조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/myPage/selectUtilBlogPage.do")
	public String selectUtilBlogPage(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        params.put("bbsCd", BLOG_BBS_CD);
        
		selectBbsAdmin(params, model);
		return "ggportal/mypage/utilGallery/selectUtilGallery";
	}
	
	/**
	 * 활용 갤러리 수정 화면
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/myPage/updateUtilGalleryPage.do")
	public String updateUtilGalleryPage(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        params.put("bbsCd", GALLERY_BBS_CD);
        
		selectBbsAdmin(params, model);
		return "ggportal/mypage/utilGallery/updateUtilGallery";
	}
	
	/**
	 * 활용 갤러리 수정 화면
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/myPage/updateUtilBlogPage.do")
	public String updateUtilBlogPage(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        params.put("bbsCd", BLOG_BBS_CD);
        
		selectBbsAdmin(params, model);
		return "ggportal/mypage/utilGallery/updateUtilGallery";
	}
	
	/**
	 * 활용 갤러리 수정
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/myPage/updateUtilGallery.do")
	public String updateUtilGallery(HttpServletRequest request, Model model) {
		Params params = getParams(request, true);
        params.put("bbsCd", GALLERY_BBS_CD);
		
		Object result = portalMyPageService.updateUtilGalleryCUD(params);
		
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
		return "jsonView";
	}
	
	/**
	 * 활용 갤러리 수정
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/myPage/updateUtilBlog.do")
	public String updateUtilBlog(HttpServletRequest request, Model model) {
		Params params = getParams(request, true);
        params.put("bbsCd", BLOG_BBS_CD);
		
		Object result = portalMyPageService.updateUtilGalleryCUD(params);
		
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
		return "jsonView";
	}
	
    //////////////////////////////////////////////////////////////////////////////////////
    //////////////////////// 회원정보수정 관련 컨트롤러 ////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////
	
	@RequestMapping("/portal/myPage/updateUserInfoPage.do")
	public String updateUserInfoPage(HttpServletRequest request, Model model) {
		Params params = getParams(request, true);
		return "ggportal/mypage/userInfo/userInfo";
	}
	
	@RequestMapping("/portal/myPage/selectUserInfo.do")
	public String selectUserInfo(HttpServletRequest request, Model model) {
		
		Params params = getParams(request, true);
		
		Object result = portalMyPageService.selectUserInfo(params);
		
        addObject(model, result);
		return "jsonView";
	}
	
	@RequestMapping("/portal/myPage/updateUserInfo.do")
	public String updateUserInfo(HttpServletRequest request, Model model) {
		Params params = getParams(request, true);
		Object result = portalMyPageService.updateUserInfoCUD(params);
		
        addObject(model, result);
		return "jsonView";
	}
	
	@RequestMapping("/portal/myPage/deleteUserInfo.do")
	public String deleteUserInfo(HttpServletRequest request, Model model) {
		Params params = getParams(request, true);
		Object result = portalMyPageService.deleteUserInfoCUD(params);
		
        HttpSession session = getSession(false);
        
        if (session != null) {
            session.invalidate();
        }
        
        addObject(model, result);
		return "jsonView";
	}
	
	@RequestMapping("/portal/myPage/deleteUserInfoPage.do")
	public String deleteUserInfoPage(HttpServletRequest request, Model model) {
		
		return "ggportal/mypage/secession/secession";
	}
	
	@RequestMapping("/portal/myPage/selectListUseActKey.do")
	public String selectListUseActKey(HttpServletRequest request, Model model) {
		Params params = getParams(request, true);
		Object result = portalMyPageService.selectListUseActKey(params);
		
		addObject(model, result);
		return "jsonView";
	}
	
	//////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////// 통계스크랩 관련 컨트롤러 ////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////
	/**
	 * 통계스크랩 페이지이동
	 */
	@RequestMapping("/portal/myPage/statUserScrapPage.do")
	public String statUserScrapPage(HttpServletRequest request, Model model) {
        return "ggportal/mypage/statScrap/searchStatScrap";
	}
	
	/**
	 * 통계스크랩 리스트 조회
	 */
	@RequestMapping("/portal/myPage/statUserScrapList.do")
	public String statUserScrapList(HttpServletRequest request, Model model) {
		Params params = getParams(request, true);
        
		Object result = portalMyPageService.statUserScrapList(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
		return "jsonView";
	}
	
	/**
	 * 통계스크랩 삭제
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/myPage/delStatUserScrap.do")
	public String delStatUserScrap(HttpServletRequest request, Model model) {
		Params params = getParams(request, true);
        
		Object result = portalMyPageService.delStatUserScrap(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
		return "jsonView";
	}
	
	/**
	 * 검색연혁 및 추천정보
	 */
	@RequestMapping("/portal/myPage/searchHisRcmdPage.do")
	public String searchHisRcmdPage(HttpServletRequest request, Model model) {
		Params params = getParams(request, true);
		return "/ggportal/mypage/schhis/searchHisRcmd";
	}
	
	/**
	 * 유저 검색로그 조회
	 */
	@RequestMapping("/portal/myPage/searchSearchHisData.do")
	public String searchSearchHisData(HttpServletRequest request, Model model) {
		Params params = getParams(request, true);
        
		Object result = portalMyPageService.searchSearchHisData(params);
        
        addObject(model, result);
        
		return "jsonView";
	}
	
	/**
	 * 뉴스레터 수신동의 페이지 이동
	 */
	@RequestMapping("/portal/myPage/newsletterAgreePage.do")
	public String newsletterAgreePage(HttpServletRequest request, Model model) {
		Params params = getParams(request, true);
		
		model.addAttribute("data", portalMyPageService.selectNewsletter(params));
		
		return "/ggportal/mypage/newsletter/newsletterAgree";
	}
	
	/**
	 * 뉴스레터 수신동의
	 */
	@RequestMapping("/portal/myPage/saveNewsletterAgree.do")
	public String insertHisRcmd(HttpServletRequest request, Model model) {
		Params params = getParams(request, true);
        
		Object result = portalMyPageService.saveNewsletterAgree(params);
        
        addObject(model, result);
        
		return "jsonView";
	}
	
	/**
	 * 청구 기본정보수정
	 */
	@RequestMapping("/portal/myPage/exposeDefaultUpdPage.do")
	public ModelAndView exposeDefaultUpdPage(HttpServletRequest request, Model model) {
		ModelAndView modelAndView = new ModelAndView();
		
		Params params = getParams(request, true);
		
		HttpSession session = request.getSession();
		
		// 실명인증 여부
		if ( StringUtils.isNotEmpty((String)session.getAttribute("dupInfo")) ) {
			modelAndView.addObject("isReal", "Y");
			modelAndView.setViewName("/ggportal/mypage/expose/exposeDefaultUpd");
		} else {
			
			// initRsa(modelAndView, request); //RSA 키 생성
			
			modelAndView.addObject("URL", "/portal/myPage/exposeDefaultUpdPage.do");
			modelAndView.setViewName("/soportal/expose/opnLogin");
		}
		
		return modelAndView;
	}
	
	/**
	 * 청구 기본정보 조회
	 */
	@RequestMapping("/portal/myPage/exposeDefaultUpdInfo.do")
	public String exposeDefaultUpdInfo(HttpServletRequest request, Model model) {
		
		Params params = getParams(request, true);
		
		Object result = portalMyPageService.selectExposeDefaultUpdInfo(params);
		
        addObject(model, result);
		return "jsonView";
	}
	
	/**
	 * 청구 기본정보 수정
	 */
	@RequestMapping("/portal/myPage/updateExposeDefaultUpd.do")
		public String updateExposeDefaultUpd(HttpServletRequest request, Model model) {
			Params params = getParams(request, true);
			Object result = portalMyPageService.updateExposeDefaultUpdCUD(params);
			
	        addObject(model, result);
			return "jsonView";
		}
	/////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////// private method /////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////
	private void selectBbsAdmin(Params params, Model model) {
        debug("Request parameters: " + params);
        // 게시판 설정을 조회한다.
        Record result = portalBbsAdminService.selectBbsAdmin(params);
        debug("Processing results: " + result);
        // 모델에 객체를 추가한다.
        addObject(model, result);
	}
	
    /**
     * rsa 공개키, 개인키 생성 -
     * 
     * @param request
     */
    public void initRsa(ModelAndView modelAndView, HttpServletRequest request) {
        HttpSession session = request.getSession();
		
        KeyPairGenerator generator;
        try {
            generator = KeyPairGenerator.getInstance(PortalMyPageController.RSA_INSTANCE);
            generator.initialize(1024);
 
            KeyPair keyPair = generator.genKeyPair();
            KeyFactory keyFactory = KeyFactory.getInstance(PortalMyPageController.RSA_INSTANCE);
            PublicKey publicKey = keyPair.getPublic();
            PrivateKey privateKey = keyPair.getPrivate();
 
            session.setAttribute(PortalMyPageController.RSA_WEB_KEY, privateKey); // session에 RSA 개인키를 세션에 저장
 
            RSAPublicKeySpec publicSpec = (RSAPublicKeySpec) keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);
            String publicKeyModulus = publicSpec.getModulus().toString(16);
            String publicKeyExponent = publicSpec.getPublicExponent().toString(16);
            
            modelAndView.addObject("RSAModulus",publicKeyModulus);
            modelAndView.addObject("RSAExponent", publicKeyExponent);
            
        } catch (Exception e) {
        	debug("rsa 공개키, 개인키 생성에 실패하였습니다.");
        }
    }
    
    /**
     * 정보공개 나의 청구서 목록을 조회한다.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/myPage/searchMyOpnzAplList.do")
    public String searchMyOpnzAplList(HttpServletRequest request, Model model, HttpSession session) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);

		// 내용을 검색한다.
		Object result = portalMyPageService.searchMyOpnzAplList(params);
	    
		debug("Processing results: " + result);
	        
	    // 모델에 객체를 추가한다.
	    addObject(model, result);
		
        // 뷰이름을 반환한다.
        return "jsonView";
    }
    
    /**
	 * 기존 청구서 저장
	 */
	@RequestMapping("/portal/myPage/updateMyOpnzApl.do")
	public String updateMyOpnzApl(HttpServletRequest request, Model model) {
		Params params = getParams(request, true);
		Object result = portalMyPageService.updateMyOpnzApl(params);
		
        addObject(model, result);
		return "jsonView";
	}
}

package egovframework.portal.nadata.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.common.base.constants.SessionAttribute;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.portal.nadata.service.PortalNaDataSitemapService;

/**
 * 국회사무처 정보서비스 카탈로그 화면 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/09/11
 */
@Controller
public class PortalNaDataSitemapController extends BaseController {
	
	@Resource(name="portalNaDataSitemapService")
	protected PortalNaDataSitemapService portalNaDataSitemapService;
	
	/**
	 * 정보서비스 사이트맵 화면으로 이동한다.
	 */
	@RequestMapping("/portal/nadata/sitemap/naDataSitemapPage.do")  
	public String naDataSitemapPage(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        model.addAttribute("schOrg", portalNaDataSitemapService.selectCommOrgList(params));	// 기관
        
		return "portal/nadata/naDataSitemap";
	}
	
	/**
	 * 정보서비스 사이트맵 리스트 조회
	 */
	@RequestMapping("/portal/nadata/sitemap/selectSiteMapList.do")
	public String selectSiteMapList(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        Object result = portalNaDataSitemapService.selectSiteMapList(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        return "jsonView";
        
	}
	
	/**
	 * 사이트맵 썸네일 불러오기
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/nadata/sitemap/selectThumbnail.do")
    public String selectThumbnail(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 썸네일을 조회한다.
        Object result = portalNaDataSitemapService.selectDataSiteMapThumbnail(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "imageView";
    }
	
	
	/**
	 * 사이트맵 메뉴목록 불러오기
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/nadata/sitemap/selectMenuList.do")
    public String selectMenuList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        Object result = portalNaDataSitemapService.selectMenuList(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }

	/**
	 * 정보서비스 사이트맵 검색 조회
	 */
	@RequestMapping("/portal/nadata/sitemap/searchSiteMapList.do")
	public String searchSiteMapList(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        Object result = portalNaDataSitemapService.searchSiteMapList(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        return "jsonView";
        
	}

	/**
	 * 정보서비스 사이트맵 독립도메인 화면으로 이동한다.
	 */
	@RequestMapping("/infonavi")
	public String infonaviPage(HttpServletRequest request, Model model) {
		
		Params params = new Params();
		
		// 메뉴정보를 로그에 담는다.
		params.put("sysTag", "K");
		params.put("menuId", 248); //정보서비스 사이트맵 248
		// 로그인 되어있을경우
		HttpSession session = getSession();
        params.put("userCd", session.getAttribute(SessionAttribute.USER_CD));
        params.put("userIp",StringUtils.defaultIfEmpty(request.getRemoteAddr(), ""));
        params.put("menuUrl", "/infonavi");

        portalNaDataSitemapService.insertLogMenu(params);
        
		return "/portal/nadata/infonavi";
	}
	
}

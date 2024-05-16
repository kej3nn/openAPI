package egovframework.admin.menu.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.admin.menu.service.SiteMenuService;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.helper.TABListVo;

/**
 * 관리자 메뉴관리 클래스
 * 
 * @author  손정식
 * @version	1.0
 * @since	2019/07/29
 */

@Controller
public class SiteMenuController extends BaseController {

	@Resource(name="siteMenuService")
	protected SiteMenuService siteMenuService;
	
	/**
	 * 정보 분류 페이지 이동
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/menu/siteMenuPage.do")
	public String statStddUiPage(ModelMap model) {
		return "/admin/menu/siteMenu";
	}
	
	/**
	 * 정보 분류 메인 리스트 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/menu/siteMenuList.do")
	public String siteMenuList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        Object result = siteMenuService.siteMenuList(params);
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 정보 분류 팝업 리스트 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/menu/siteMenuPopList.do")
	public String siteMenuPopList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        Object result = siteMenuService.siteMenuPopList(params);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }

	/**
	 * 정보 분류 상세 조회
	 * @param params
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/menu/siteMenuDtl.do")
	@ResponseBody
	public TABListVo<Record> siteMenuDtl(@RequestBody Params params, HttpServletRequest request, ModelMap model) {
		return new TABListVo<Record>(siteMenuService.siteMenuDtl(params));
	}
	
	/**
	 * 정보 분류 ID 중복체크
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/menu/siteMenuDupChk.do")
	public String siteMenuDupChk(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        debug("Request parameters: " + params);
        
        Object result = siteMenuService.siteMenuDupChk(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	
	@RequestMapping("/admin/menu/popup/siteMenuPop.do")
	public String infSetUiPop (ModelMap model){
		return "/admin/menu/popup/siteMenuPop";
	}
	
	/**
	 * 정보 분류 등록/수정
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/menu/saveSiteMenu.do")
	public String saveSiteMenu(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        debug("Request parameters: " + params);
        
        Object result = siteMenuService.saveSiteMenu(request, params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 정보 분류 삭제
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/menu/deleteSiteMenu.do")
	public String deleteStatSttsCate(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        debug("Request parameters: " + params);
        
        Object result = siteMenuService.deleteSiteMenu(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 정보 썸네일 불러오기
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/menu/selectThumbnail.do")
    public String selectThumbnail(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 공공데이터 데이터셋 썸네일을 조회한다.
        Object result = siteMenuService.selectSiteMenuThumbnail(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "imageView";
    }
	
	/**
	 * 정보 분류 순서 저장
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/menu/saveSiteMenuOrder.do")
    public String saveSiteMenuOrder(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
		
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 공공데이터 데이터셋 썸네일을 조회한다.
        Object result = siteMenuService.saveSiteMenuOrder(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
}

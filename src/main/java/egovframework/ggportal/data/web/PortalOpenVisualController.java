package egovframework.ggportal.data.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.ggportal.data.service.PortalOpenVisualService;

/**
 * 데이터 시각화 컨트롤러
 * @author hsJang
 *
 */
@Controller("ggportalOpenVisualController")
public class PortalOpenVisualController extends BaseController {
	
	@Resource(name = "ggportalOpenVisualService")
	private PortalOpenVisualService portalOpenVisualService;
	
	/**
	 * 데이터 시각화 목록 화면
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/data/visual/searchVisualMainPage.do")
	public String searchVisualMainPage(HttpServletRequest request, Model model) {
		return "ggportal/data/visual/searchVisual";
	}

	/**
	 * 데이터 시각화 목록 데이터
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/data/visual/searchVisualData.do")
	public String searchVisualData(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
		Object result = portalOpenVisualService.searchListVisual(params);
        addObject(model, result);
		return "jsonView";
	}
	
	/**
	 * 데이터 시각화 상세 화면
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/data/visual/selectVisualPage.do")
	public String selectVisualPage(HttpServletRequest request, Model model) {
        Params params = getParams(request, false);
    	addObject(model, params);
    	// 2015.09.13 김은삼 [1] 메타정보 조회 SQL 추가 BEGIN
        // 데이터 시각화 메타정보를 조회한다.
        Object result = portalOpenVisualService.selectVisualMeta(params);
        
        model.addAttribute("meta", result);
    	// 2015.09.13 김은삼 [1] 메타정보 조회 SQL 추가 END
		return "ggportal/data/visual/selectVisual";
	}
	
	/**
	 * 데이터 시각화 상세 데이터
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/data/visual/selectVisualData.do")
	public String selectVisualData(HttpServletRequest request, Model model) {
        Params params = getParams(request, false);
        Object result = portalOpenVisualService.selectVisualData(params);
    	addObject(model, result);
    	return "jsonView";
	}

}

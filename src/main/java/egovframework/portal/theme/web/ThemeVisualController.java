package egovframework.portal.theme.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.portal.theme.service.ThemeVisualService;

@Controller("ThemeVisualController")
public class ThemeVisualController extends BaseController {
	
	@Resource(name="ThemeVisualService")
	private ThemeVisualService themeVisualService;
	
	/**
	 * 국회의원 차트 페이지 이동(팝업)
	 */
	@RequestMapping("/portal/theme/visual/searchVisualPage.do")
	public String memberSchChartPopPage(HttpServletRequest request, Model model) {
		
		return "/portal/theme/searchVisual";
	}
	
	/**
	 * TreeMap Chart 데이터 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/theme/visual/selectTreeMapData.do")
	public String selectTreeMapData(HttpServletRequest request, Model model)  {
        Params params = getParams(request, false);
        
		Object result = themeVisualService.selectTreeMapData(params);
    	addObject(model, result);
		return "jsonView";
	}
	
	/**
	 * Column Chart 데이터 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/theme/visual/selectColumnReeleData.do")
	public String selectColumnReeleData(HttpServletRequest request, Model model)  {
        Params params = getParams(request, false);
        
		Object result = themeVisualService.selectColumnReeleData(params);
    	addObject(model, result);
		return "jsonView";
	}
	
	/**
	 * Pie 데이터 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/theme/visual/selectPieData.do")
	public String selectPieData(HttpServletRequest request, Model model)  {
        Params params = getParams(request, false);
        
		Object result = themeVisualService.selectPieData(params);
    	addObject(model, result);
		return "jsonView";
	}
	
	/**
	 * Column Chart 데이터 조회(연령)
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/theme/visual/selectColumnAgeData.do")
	public String selectColumnAgeData(HttpServletRequest request, Model model)  {
        Params params = getParams(request, false);
        
		Object result = themeVisualService.selectColumnAgeData(params);
    	addObject(model, result);
		return "jsonView";
	}
	
	/**
	 * 정당 및 교섭단체 페이지 이동(테마정보 공개 > 정당 및 교섭단체)
	 */
	@RequestMapping("/portal/theme/visual/partyNegotiationInfoPage.do")
	public String partyNegotiationInfoPage(HttpServletRequest request, Model model) {
		return "/portal/theme/partyNegotiationInfo";
	}
	
	/**
	 * 정당 및 교섭단체 페이지 이동(국회의원 > 정당 및 교섭단체)
	 */
	@RequestMapping("/portal/assm/assmPartyNegotiationPage.do")
	public String assmPartyNegotiationPage(HttpServletRequest request, Model model) {
		return "/portal/theme/partyNegotiationInfo";
	}
	
	/**
	 * 정당 및 교섭단체 정보 데이터 조회
	 */
	@RequestMapping("/portal/theme/visual/selectHgNumSeat.do")
	public String selectHgNumSeat(HttpServletRequest request, Model model)  {
        Params params = getParams(request, false);
		Object result = themeVisualService.selectHgNumSeat(params);
    	addObject(model, result);
		return "jsonView";
	}
	
	/**
	 * Parliament Chart 데이터 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/theme/visual/selectParliamentData.do")
	public String selectParliamentData(HttpServletRequest request, Model model)  {
        Params params = getParams(request, false);
        
		Object result = themeVisualService.selectParliamentData(params); 
    	addObject(model, result);
		return "jsonView";
	}
}

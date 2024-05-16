package egovframework.portal.assm.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.portal.assm.service.AssmMemberChartService;

/**
 * 국회의원 차트 컨트롤러 클래스
 * 
 * @author	SBCHOI
 * @version 1.0
 * @since   2019/10/24
 */
@Controller("AssmMemberChartController")
public class AssmMemberChartController extends BaseController {

	@Resource(name="AssmMemberChartService")
	private AssmMemberChartService assmMemberChartService;
	
	/**
	 * 국회의원 차트 페이지 이동(팝업)
	 */
	@RequestMapping("/portal/assm/chart/memberSchChartPopPage.do")
	public String memberSchChartPopPage(HttpServletRequest request, Model model) {
		
		return "/portal/assm/chart/memberSchChartPop";
	}
	
	/**
	 * TreeMap Chart 데이터 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/assm/chart/selectTreeMapData.do")
	public String selectTreeMapData(HttpServletRequest request, Model model)  {
        Params params = getParams(request, false);
        
		Object result = assmMemberChartService.selectTreeMapData(params);
    	addObject(model, result);
		return "jsonView";
	}
	
	/**
	 * Column Chart 데이터 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/assm/chart/selectColumnReeleData.do")
	public String selectColumnReeleData(HttpServletRequest request, Model model)  {
        Params params = getParams(request, false);
        
		Object result = assmMemberChartService.selectColumnReeleData(params);
    	addObject(model, result);
		return "jsonView";
	}
	
	/**
	 * Pie 데이터 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/assm/chart/selectPieData.do")
	public String selectPieData(HttpServletRequest request, Model model)  {
        Params params = getParams(request, false);
        
		Object result = assmMemberChartService.selectPieData(params);
    	addObject(model, result);
		return "jsonView";
	}
	
	/**
	 * Column Chart 데이터 조회(연령)
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/assm/chart/selectColumnAgeData.do")
	public String selectColumnAgeData(HttpServletRequest request, Model model)  {
        Params params = getParams(request, false);
        
		Object result = assmMemberChartService.selectColumnAgeData(params);
    	addObject(model, result);
		return "jsonView";
	}
	
	
}
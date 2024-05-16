package egovframework.admin.stat.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.admin.stat.service.StatUsageStateService;
import egovframework.admin.stat.service.StatsMgmtService;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;

/**
 * 관리자 통계 활용현황
 * 
 * @author 	김정호
 * @version	1.0
 * @since	2018/01/26
 */
@Controller
public class StatUsageStateController extends BaseController {

	@Resource(name="statUsageStateService")
	protected StatUsageStateService statUsageStateService;
	
	@Resource(name="statsMgmtService")
	protected StatsMgmtService statsMgmtService;
	
	/**
	 * 통계 활용현황 페이지 이동
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/stat/statUsageStatePage.do")
	public String statUsageStatePage(ModelMap model) {
		
		Params params = new Params();
		params.set("grpCd", "C1023");
		model.addAttribute("userIpTagList", statsMgmtService.selectOption(params));	// IP 구분
		
		return "/admin/stat/stats/statUsageState";
	}
	
	/**
	 * 통계 활용현황 리스트 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/stat/statUsageStateList.do")
	public String statUsageStateList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        Object result = statUsageStateService.statUsageStateList(params);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	@RequestMapping(value="/admin/stat/statUsageStateChart.do")
	public String statUsageStateChart(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        Object result = statUsageStateService.statUsageStateChart(params);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 메뉴별 활용현황 페이지 이동
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/stat/menuUsageStatePage.do")
	public String menuUsageStatePage(ModelMap model) {
		return "/admin/stat/stats/menuUsageState";
	}
	/**
	 * 메뉴별 활용현황 리스트 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/stat/menuUsageStateList.do")
	public String menuUsageStateList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        Object result = statUsageStateService.menuUsageStateList(params);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 분류별 활용현황 페이지 이동
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/stat/cateUsageStatePage.do")
	public String cateUsageStatePage(ModelMap model) {
		
		Params params = new Params();
		params.set("grpCd", "C1023");
		model.addAttribute("userIpTagList", statsMgmtService.selectOption(params));	// IP 구분
		
		return "/admin/stat/stats/cateUsageState";
	}
	/**
	 * 분류별 활용현황 리스트 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/stat/cateUsageStateList.do")
	public String cateUsageStateList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        Object result = statUsageStateService.cateUsageStateList(params);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 통계표별 활용현황 페이지 이동
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/stat/statblUsageStatePage.do")
	public String statblUsageStatePage(ModelMap model) {
		return "/admin/stat/stats/statblUsageState";
	}
	/**
	 * 통계표별 활용현황 리스트 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/stat/statblUsageStateList.do")
	public String statblUsageStateList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        Object result = statUsageStateService.statblUsageStateList(params);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 출처별 활용현황 페이지 이동
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/stat/orgUsageStatePage.do")
	public String orgUsageStatePage(ModelMap model) {
		return "/admin/stat/stats/orgUsageState";
	}
	
	/**
	 * 출처별 활용현황 리스트 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/stat/orgUsageStateList.do")
	public String orgUsageStateList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        Object result = statUsageStateService.orgUsageStateList(params);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 사용자별 로그 분석 페이지 이동
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/stat/userUsageStatePage.do")
	public String userUsageStatePage(ModelMap model) {
		return "/admin/stat/stats/userUsageState";
	}
	
	/**
	 * 사용자별 로그 분석 리스트 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/stat/userUsageStateListPaging.do")
	public String userUsageStateListPaging(HttpServletRequest request, Model model){
		// 파라메터를 가져온다.
		Params params = getParams(request, true);
		
		Object result = statUsageStateService.selectUserUsageStateListPaging(params);
		
		// 모델에 객체를 추가한다.
		addObject(model, result);
		
		return "jsonView";
		
	}
	
	/**
	 * API 호출 현황 페이지 이동
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/stat/apiUsageStatePage.do")
	public String apiUsageStatePage(ModelMap model) {
		return "/admin/stat/stats/apiUsageState";
	}
	
	/**
	 * API 호출 현황 리스트 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/stat/apiUsageStateList.do")
	public String apiUsageStateList(HttpServletRequest request, Model model){
		// 파라메터를 가져온다.
		Params params = getParams(request, true);
		
		Object result = statUsageStateService.selectApiUsageStateListPaging(params);
		
		// 모델에 객체를 추가한다.
		addObject(model, result);
		
		return "jsonView";
		
	}
	
    /**
     * API 호출 PieChart 조회
     * @throws Exception 
     * @throws DataAccessException 
     */

    @RequestMapping(value = "/admin/stat/userUsageStatePie.do")
    public String userUsageStatePie(HttpServletRequest request, Model model) throws DataAccessException, Exception {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        Object result = statUsageStateService.userUsageStatePie(params);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        return "jsonView";

    }
    
    /**
     * API 호출 BarChart 조회
     * @throws Exception 
     * @throws DataAccessException 
     */

    @RequestMapping(value = "/admin/stat/apiUsageStateGraph.do")
    public String apiUsageStateGraph(HttpServletRequest request, Model model) throws DataAccessException, Exception {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        Object result = statUsageStateService.apiUsageStateGraph(params);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        return "jsonView";

    }
}

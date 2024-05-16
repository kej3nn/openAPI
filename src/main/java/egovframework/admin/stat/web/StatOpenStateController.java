package egovframework.admin.stat.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.admin.stat.service.StatOpenStateService;
import egovframework.common.base.constants.ModelAttribute;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 관리자 통계공개 현황
 * 
 * @author 	김정호
 * @version	1.0
 * @since	2018/01/26
 */
@Controller
public class StatOpenStateController extends BaseController {

	@Resource(name="statOpenStateService")
	protected StatOpenStateService statOpenStateService;
	
	/**
	 * 통계공개 현황 페이지 이동
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/stat/statOpenStatePage.do")
	public String statOpenStatePage(ModelMap model) {
		return "/admin/stat/stats/statOpenState";
	}
	
	/**
	 * 통계표 현황 리스트 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/stat/statTblStateList.do")
	public String statTblStateList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        Object result = statOpenStateService.statTblStateList(params);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	
	/**
	 * 통계공개 현황 리스트 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/stat/statOpenStateList.do")
	public String statOpenStateList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        Object result = statOpenStateService.statOpenStateList(params);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	
}

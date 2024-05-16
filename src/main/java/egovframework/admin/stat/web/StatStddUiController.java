package egovframework.admin.stat.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.admin.stat.service.StatStddUiService;
import egovframework.common.base.constants.ModelAttribute;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.grid.IBSheetListVO;
import egovframework.common.helper.TABListVo;

/**
 * 관리자 표준단위 정보 클래스
 * 
 * @author 	김정호
 * @version	1.0
 * @since	2017/06/28
 */

@Controller
public class StatStddUiController extends BaseController {

	@Resource(name="statStddUiService")
	protected StatStddUiService statStddUiService;
	
	/**
	 * 페이지 이동
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/stat/statStddUiPage.do")
	public String statStddUiPage(ModelMap model) {
		return "/admin/stat/stdd/statStddUi";
	}

	/**
	 * 표준항목분류정보 메인 리스트 조회
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/stat/statStddUiList.do")
	public String statStddUiList(HttpServletRequest request, Model model){

        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        debug("Request parameters: " + params);
        
        Object result = statStddUiService.statStddUiList(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	/**
	 * 표준단위정보 상세 조회
	 * 
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/stat/statStddUiDtl.do")
	@ResponseBody
	public TABListVo<Map<String, Object>> statStddUiDtl(@RequestBody Map<String, String> paramMap, HttpServletRequest request, ModelMap model) {
		Params params = getParams(request, true);
		return new TABListVo<Map<String, Object>>(statStddUiService.statStddUiDtl(paramMap));
	}
	
	/**
	 * 표준단위 팝업
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/stat/popup/statStddUiPop.do")
	public String statStddUiPop (ModelMap model){
		return "/admin/stat/stdd/popup/statStddUiPop";
	}
	
	/**
	 * 표준그룹단위 팝업
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/stat/popup/statStddGrpUiPop.do")
	public String statStddGrpUiPop (ModelMap model){
		return "/admin/stat/stdd/popup/statStddGrpUiPop";
	}
	
	/**
	 * 표준단위 중복체크
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/stat/statStddUiDupChk.do")
	public String statStddUiDupChk(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        debug("Request parameters: " + params);
        
        Object result = statStddUiService.statStddUiDupChk(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	/**
	 * 표준단위정보를 등록한다.
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/stat/insertStatStddUi.do")
	public String insertStatStddUi(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        //데이터 처리 진행 코드(입력)
        params.set(ModelAttribute.ACTION_STATUS, ModelAttribute.ACTION_INS);
        
        debug("Request parameters: " + params);
        
        Object result = statStddUiService.saveStatStddUi(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	
	/**
	 * 표준단위정보를 수정한다.
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/stat/updateStatStddUi.do")
	public String updateStatStddUi(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        //데이터 처리 진행 코드(입력)
        params.set(ModelAttribute.ACTION_STATUS, ModelAttribute.ACTION_UPD);
        
        debug("Request parameters: " + params);
        
        Object result = statStddUiService.saveStatStddUi(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	/**
	 * 표준단위정보를 삭제한다.
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/stat/deleteStatStddUi.do")
	public String deleteStatStddUi(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        //데이터 처리 진행 코드(입력)
        params.set(ModelAttribute.ACTION_STATUS, ModelAttribute.ACTION_DEL);
        
        debug("Request parameters: " + params);
        
        Object result = statStddUiService.saveStatStddUi(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	/**
	 * 표준단위정보 순서저장
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/stat/saveStatStddUiOrder.do")
	public String saveSttsStatOrder(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        debug("Request parameters: " + params);
        
        Object result = statStddUiService.saveStatStddUiOrder(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 표준단위정보 단위 그룹 조회
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/stat/statStddGrpUiList.do")
	public String statStddGrpUiList(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        debug("Request parameters: " + params);
        
        Object result = statStddUiService.statStddGrpUiListPaging(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	/**
	 * 표준단위정보 팝업 리스트 조회
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/stat/statStddUiPopList.do")
	public String statStddUiPopList(HttpServletRequest request, Model model){
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        debug("Request parameters: " + params);
        
        Object result = statStddUiService.statStddUiPopList(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	
}

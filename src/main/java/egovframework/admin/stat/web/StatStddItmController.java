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

import egovframework.admin.stat.service.StatStddItmService;
import egovframework.admin.stat.service.StatsMgmtService;
import egovframework.common.base.constants.ModelAttribute;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.grid.IBSheetListVO;
import egovframework.common.helper.TABListVo;

/**
 * 표준항목 분류정의 클래스
 * 
 * @author 	김정호
 * @version	1.0
 * @since	2017/06/26
 */

@Controller
public class StatStddItmController extends BaseController {

	@Resource(name="statStddItmService")
	protected StatStddItmService statStddItmService;
	
	@Resource(name="statsMgmtService")
	protected StatsMgmtService statsMgmtService;
	
	/**
	 * 페이지 이동
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/stat/statStddItmPage.do")
	public String statInputPage(ModelMap model) {
		return "/admin/stat/stdd/statStddItm";
	}

	/**
	 * 표준항목분류정보 메인 리스트 조회
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/stat/statStddItmList.do")
	public String statStddItmList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        Object result = statStddItmService.statStddItmListPaging(params);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 표준항목분류정보 상세 조회
	 * 
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/stat/statStddItmDtl.do")
	@ResponseBody
	public TABListVo<Map<String, Object>> statStddItmDtl(@RequestBody Map<String, String> paramMap, HttpServletRequest request, ModelMap model) {
		Params params = getParams(request, true);
		//Map<String, Object> map = statStddItmService.statStddItmDtl(paramMap);
		//return new TABListVo<Map<String, Object>>(map.get("DATA"));
		return new TABListVo<Map<String, Object>>(statStddItmService.statStddItmDtl(paramMap));
	}
	
	/**
	 * 표준항목분류 팝업
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/stat/popup/statStddItmPop.do")
	public String statStddItmPop (ModelMap model){
		return "/admin/stat/stdd/popup/statStddItmPop";
	}
	
	/**
	 * 표준항목분류정보를 등록한다.
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/stat/insertStatStddItm.do")
	public String insertStatStddItm(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        //데이터 처리 진행 코드(입력)
        params.set(ModelAttribute.ACTION_STATUS, ModelAttribute.ACTION_INS);
        
        debug("Request parameters: " + params);
        
        Object result = statStddItmService.saveStatStddItm(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	
	/**
	 * 표준항목분류정보를 수정한다.
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/stat/updateStatStddItm.do")
	public String updateStatStddItm(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        //데이터 처리 진행 코드(입력)
        params.set(ModelAttribute.ACTION_STATUS, ModelAttribute.ACTION_UPD);
        
        debug("Request parameters: " + params);
        
        Object result = statStddItmService.saveStatStddItm(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	/**
	 * 표준항목분류정보를 삭제한다.
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/stat/deleteStatStddItm.do")
	public String deleteStatStddItm(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        //데이터 처리 진행 코드(입력)
        params.set(ModelAttribute.ACTION_STATUS, ModelAttribute.ACTION_DEL);
        
        debug("Request parameters: " + params);
        
        Object result = statStddItmService.saveStatStddItm(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	/**
	 * 표준항목분류명 저장
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/stat/saveStatStddItmNm.do")
    public String saveStatStddItmNm(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        debug("Request parameters: " + params);
        
        Object result = statStddItmService.saveStatStddItmNm(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 표준항목분류 순서저장
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/stat/saveStatStddItmOrder.do")
    public String saveStatStddItmOrder(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        debug("Request parameters: " + params);
        
        Object result = statStddItmService.saveStatStddItmOrder(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
}

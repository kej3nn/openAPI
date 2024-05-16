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

import egovframework.admin.stat.service.StatStddMetaService;
import egovframework.admin.stat.service.StatsMgmtService;
import egovframework.common.base.constants.ModelAttribute;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.grid.IBSheetListVO;
import egovframework.common.helper.TABListVo;

/**
 * 관리자 표준메타 정의 클래스
 * 
 * @author 	김정호
 * @version	1.0
 * @since	2017/07/03
 */

@Controller
public class StatStddMetaController extends BaseController {

	@Resource(name="statStddMetaService")
	protected StatStddMetaService statStddMetaService;
	
	@Resource(name="statsMgmtService")
	protected StatsMgmtService statsMgmtService;
	
	/**
	 * 페이지 이동
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/stat/statStddMetaPage.do")
	public String statStddMetaPage(ModelMap model) {
		Params params = new Params();
		params.set("grpCd", "S1008");
		model.addAttribute("sttsCdList", statsMgmtService.selectOption(params));	//통계구분
		
		return "/admin/stat/stdd/statStddMeta";
	}

	/**
	 * 표준메타정보 메인 리스트 조회
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/stat/statStddMetaList.do")
	@ResponseBody
	public IBSheetListVO<Map<String, Object>> statStddMetaList(HttpServletRequest request, ModelMap model){
		// 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        List<Map<String, Object>> list = statStddMetaService.statStddMetaListPaging(params);
        return new IBSheetListVO<Map<String, Object>>(list, list == null?0:list.size());
	}
	
	/**
	 * 표준메타정보 상세 조회
	 * 
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/stat/statStddMetaDtl.do")
	@ResponseBody
	public TABListVo<Map<String, Object>> statStddMetaDtl(@RequestBody Map<String, String> paramMap, HttpServletRequest request, ModelMap model) {
		Params params = getParams(request, true);
		return new TABListVo<Map<String, Object>>(statStddMetaService.statStddMetaDtl(paramMap));
	}
	
	
	/**
	 * 표준메타정보를 등록한다.
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/stat/insertStatStddMeta.do")
	public String insertStatStddMeta(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        //데이터 처리 진행 코드(입력)
        params.set(ModelAttribute.ACTION_STATUS, ModelAttribute.ACTION_INS);
        
        debug("Request parameters: " + params);
        
        Object result = statStddMetaService.saveStatStddMeta(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	
	/**
	 * 표준메타정보를 수정한다.
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/stat/updateStatStddMeta.do")
	public String updateStatStddMeta(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        //데이터 처리 진행 코드(입력)
        params.set(ModelAttribute.ACTION_STATUS, ModelAttribute.ACTION_UPD);
        
        debug("Request parameters: " + params);
        
        Object result = statStddMetaService.saveStatStddMeta(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	/**
	 * 표준메타정보를 삭제한다.
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/stat/deleteStatStddMeta.do")
	public String deleteStatStddMeta(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        //데이터 처리 진행 코드(입력)
        params.set(ModelAttribute.ACTION_STATUS, ModelAttribute.ACTION_DEL);
        
        debug("Request parameters: " + params);
        
        Object result = statStddMetaService.saveStatStddMeta(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	/**
	 * 표준메타정보 순서저장
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/stat/saveStatStddMetaOrder.do")
    public String saveStatStddItmNm(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        debug("Request parameters: " + params);
        
        Object result = statStddMetaService.saveStatStddMetaOrder(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);
        
        return "jsonView";
    }
	

}

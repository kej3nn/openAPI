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
import egovframework.admin.stat.service.StatSttsCateService;
import egovframework.common.base.constants.ModelAttribute;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.grid.IBSheetListVO;
import egovframework.common.helper.TABListVo;

/**
 * 관리자 통계표 분류 클래스
 * 
 * @author 	김정호
 * @version	1.0
 * @since	2017/08/21
 */

@Controller
public class StatSttsCateController extends BaseController {

	@Resource(name="statSttsCateService")
	protected StatSttsCateService statSttsCateService;
	
	/**
	 * 통계표 분류 페이지 이동
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/stat/statSttsCatePage.do")
	public String statStddUiPage(ModelMap model) {
		return "/admin/stat/stat/statSttsCate";
	}
	
	/**
	 * 통계표 분류 메인 리스트 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/stat/statSttsCateList.do")
	public String statSttsCateList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        Object result = statSttsCateService.statSttsCateList(params);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 통계표 분류 팝업 리스트 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/stat/statSttsCatePopList.do")
	public String statSttsCatePopList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        Object result = statSttsCateService.statSttsCatePopList(params);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }

	/**
	 * 통계표 분류 상세 조회
	 * @param params
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/stat/statSttsCateDtl.do")
	@ResponseBody
	public TABListVo<Record> statSttsCateDtl(@RequestBody Params params, HttpServletRequest request, ModelMap model) {
		return new TABListVo<Record>(statSttsCateService.statSttsCateDtl(params));
	}
	
	/**
	 * 통계표 분류 ID 중복체크
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/stat/statSttsCateDupChk.do")
	public String statSttsCateDupChk(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        debug("Request parameters: " + params);
        
        Object result = statSttsCateService.statSttsCateDupChk(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	
	@RequestMapping("/admin/stat/popup/statSttsCatePop.do")
	public String statStddUiPop (ModelMap model){
		return "/admin/stat/stat/popup/statSttsCatePop";
	}
	
	/**
	 * 통계표 분류 등록/수정
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/stat/saveStatSttsCate.do")
	public String saveStatSttsCate(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        debug("Request parameters: " + params);
        
        Object result = statSttsCateService.saveStatSttsCate(request, params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 통계표 분류 삭제
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/stat/deleteStatSttsCate.do")
	public String deleteStatSttsCate(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        debug("Request parameters: " + params);
        
        Object result = statSttsCateService.deleteStatSttsCate(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 통계표 썸네일 불러오기
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/stat/selectThumbnail.do")
    public String selectThumbnail(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 공공데이터 데이터셋 썸네일을 조회한다.
        Object result = statSttsCateService.selectStatCateThumbnail(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "imageView";
    }
	
	/**
	 * 통계표 분류 순서 저장
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/stat/saveStatSttsCateOrder.do")
    public String saveStatSttsCateOrder(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 공공데이터 데이터셋 썸네일을 조회한다.
        Object result = statSttsCateService.saveStatSttsCateOrder(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
}

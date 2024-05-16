package egovframework.admin.stat.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.admin.stat.service.StatSttsMajorService;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.helper.TABListVo;

/**
 * 관리자 주요통계지표관리 컨트롤러 클래스 이다.
 * 
 * @author 	김정호
 * @version	1.0
 * @since	2017/08/10
 */

@Controller
public class StatSttsMajorController extends BaseController {

	@Resource(name="statSttsMajorService")
	protected StatSttsMajorService statSttsMajorService;
	
	/**
	 * 주요통계지표 페이지 이동
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/stat/statSttsMajorPage.do")
	public String statSttsMajorPage(ModelMap model) {
		return "/admin/stat/stat/statSttsMajor";
	}
	
	/**
	 * 주요통계지표 관리 메인 리스트
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/stat/statSttsMajorList.do")
	public String statSttsMajorList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        Object result = statSttsMajorService.statSttsMajorList(params);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 통계값 항목/분류 콤보 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/stat/statTblItmCombo.do")
	public String statTblItmCombo(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        Object result = statSttsMajorService.statTblItmCombo(params);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 통계값 자료구분 콤보 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/stat/statTblOptDtadvsCombo.do")
	public String statTblOptDtadvsCombo(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        Object result = statSttsMajorService.statTblOptDtadvsCombo(params);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 주요통계지표 상세
	 * @param params
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/stat/statSttsMajorDtl.do")
	@ResponseBody
	public TABListVo<Record> statSttsMajorDtl(@RequestBody Params params, HttpServletRequest request, ModelMap model) {
		return new TABListVo<Record>(statSttsMajorService.statSttsMajorDtl(params));
	}

	/**
	 * 주요통계지표 통계표 팝업 이동
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/stat/popup/statTblPopup.do")
	public String statTblPopup(HttpServletRequest request, Model model){
		return "/admin/stat/stat/popup/statTblPopup";
	}  
	
	/**
	 * 주요통계지표 통계표 팝업 리스트 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/stat/popup/statTblPopupList.do")
	public String statTblPopupList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        Object result = statSttsMajorService.statTblPopupList(params);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }

	/**
	 * 주요통계지표 삭제
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/stat/deleteStatSttsMajor.do")
	public String deleteStatSttsMajor(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        Object result = statSttsMajorService.deleteStatSttsMajor(params);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 주요통계지표 순서저장
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/stat/saveStatSttsMajorOrder.do")
	public String saveStatSttsMajorOrder(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        Object result = statSttsMajorService.saveStatSttsMajorOrder(params);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 주요통계지표 등록/저장
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/stat/saveStatSttsMajor.do")
	public String saveStatSttsMajor(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        Object result = statSttsMajorService.saveStatSttsMajor(request, params);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
}

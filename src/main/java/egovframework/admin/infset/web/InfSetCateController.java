package egovframework.admin.infset.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.admin.infset.service.InfSetCateService;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.helper.TABListVo;

/**
 * 관리자 정보 분류 클래스
 * 
 * @author  손정식
 * @version	1.0
 * @since	2019/07/29
 */

@Controller
public class InfSetCateController extends BaseController {

	@Resource(name="infSetCateService")
	protected InfSetCateService infSetCateService;
	
	/**
	 * 정보 분류 페이지 이동
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/infs/cate/infSetCatePage.do")
	public String statStddUiPage(ModelMap model) {
		return "/admin/infset/cate/infSetCate";
	}
	
	/**
	 * 정보 분류 메인 리스트 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/infs/cate/infSetCateList.do")
	public String infSetCateList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        Object result = infSetCateService.infSetCateList(params);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 정보 분류 팝업 리스트 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/infs/cate/infSetCatePopList.do")
	public String infSetCatePopList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        Object result = infSetCateService.infSetCatePopList(params);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }

	/**
	 * 정보 분류 상세 조회
	 * @param params
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/infs/cate/infSetCateDtl.do")
	@ResponseBody
	public TABListVo<Record> infSetCateDtl(@RequestBody Params params, HttpServletRequest request, ModelMap model) {
		return new TABListVo<Record>(infSetCateService.infSetCateDtl(params));
	}
	
	/**
	 * 정보 분류 ID 중복체크
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/infs/cate/infSetCateDupChk.do")
	public String infSetCateDupChk(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        debug("Request parameters: " + params);
        
        Object result = infSetCateService.infSetCateDupChk(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	
	@RequestMapping("/admin/infs/cate/popup/infSetCatePop.do")
	public String infSetUiPop (ModelMap model){
		return "/admin/infset/cate/popup/infSetCatePop";
	}
	
	/**
	 * 정보 분류 등록/수정
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/infs/cate/saveInfSetCate.do")
	public String saveInfSetCate(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        debug("Request parameters: " + params);
        
        Object result = infSetCateService.saveInfSetCate(request, params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 정보 분류 삭제
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/infs/cate/deleteInfSetCate.do")
	public String deleteStatSttsCate(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        debug("Request parameters: " + params);
        
        Object result = infSetCateService.deleteInfSetCate(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 정보 썸네일 불러오기
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/infs/cate/selectThumbnail.do")
    public String selectThumbnail(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 공공데이터 데이터셋 썸네일을 조회한다.
        Object result = infSetCateService.selectInfSetCateThumbnail(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "imageView";
    }
	
	/**
	 * 정보 분류 순서 저장
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/infs/cate/saveInfSetCateOrder.do")
    public String saveStatSttsCateOrder(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 공공데이터 데이터셋 썸네일을 조회한다.
        Object result = infSetCateService.saveInfSetCateOrder(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
}

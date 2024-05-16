package egovframework.admin.infset.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.admin.infset.service.DocInfCateService;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.helper.TABListVo;

/**
 * 관리자 문서 분류 클래스
 * 
 * @author  손정식
 * @version	1.0
 * @since	2019/08/06
 */

@Controller
public class DocInfCateController extends BaseController {

	@Resource(name="docInfCateService")
	protected DocInfCateService docInfCateService;
	
	/**
	 * 문서 분류 페이지 이동
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/infs/cate/docInfCatePage.do")
	public String statStddUiPage(ModelMap model) {
		return "/admin/infset/cate/docInfCate";
	}
	
	/**
	 * 문서 분류 메인 리스트 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/infs/cate/docInfCateList.do")
	public String docInfCateList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        Object result = docInfCateService.docInfCateList(params);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 문서 분류 팝업 리스트 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/infs/cate/docInfCatePopList.do")
	public String docInfCatePopList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        Object result = docInfCateService.docInfCatePopList(params);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }

	/**
	 * 문서 분류 상세 조회
	 * @param params
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/infs/cate/docInfCateDtl.do")
	@ResponseBody
	public TABListVo<Record> docInfCateDtl(@RequestBody Params params, HttpServletRequest request, ModelMap model) {
		return new TABListVo<Record>(docInfCateService.docInfCateDtl(params));
	}
	
	/**
	 * 문서 분류 ID 중복체크
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/infs/cate/docInfCateDupChk.do")
	public String docInfCateDupChk(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        debug("Request parameters: " + params);
        
        Object result = docInfCateService.docInfCateDupChk(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);
        
        return "jsonView";
	}
	
	
	@RequestMapping("/admin/infs/cate/popup/docInfCatePop.do")
	public String docInfUiPop (ModelMap model){
		return "/admin/infset/cate/popup/docInfCatePop";
	}
	
	/**
	 * 문서 분류 등록/수정
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/infs/cate/saveDocInfCate.do")
	public String saveDocInfCate(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        debug("Request parameters: " + params);
        
        Object result = docInfCateService.saveDocInfCate(request, params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 문서 분류 삭제
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/infs/cate/deleteDocInfCate.do")
	public String deleteStatSttsCate(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        debug("Request parameters: " + params);
        
        Object result = docInfCateService.deleteDocInfCate(params);
        
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
	@RequestMapping("/admin/infs/cate/selectDocInfCateThumbnail.do")
    public String selectDocInfCateThumbnail(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 공공데이터 데이터셋 썸네일을 조회한다.
        Object result = docInfCateService.selectDocInfCateThumbnail(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "imageView";
    }
	
	/**
	 * 문서 분류 순서 저장
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/infs/cate/saveDocInfCateOrder.do")
    public String saveStatSttsCateOrder(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 공공데이터 데이터셋 썸네일을 조회한다.
        Object result = docInfCateService.saveDocInfCateOrder(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	/**
	 * 정보셋 분류체계 팝업(검색용)으로 이동(iframe)
	 */
	@RequestMapping("/admin/infs/mgmt/popup/docInfCateSearchPop.do")
	public String docInfCateSearchPopup(HttpServletRequest request, Model model){
		return "/admin/infset/mgmt/popup/docInfCateSearchPop";
	}
	
}

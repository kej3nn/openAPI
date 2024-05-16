package egovframework.admin.infset.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.admin.infset.service.DocInfMgmtService;
import egovframework.admin.stat.service.StatsMgmtService;
import egovframework.common.base.constants.ModelAttribute;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.helper.Messagehelper;
import egovframework.common.helper.TABListVo;

/**
 * 정보공개 문서를 관리는 컨트롤러 클래스
 * @author	JHKIM
 * @version 1.0
 * @since   2019/08/05
 */

@Controller
public class DocInfMgmtController extends BaseController { 
	
	protected static final Log logger = LogFactory.getLog(DocInfMgmtController.class);
	
	@Resource(name="docInfMgmtService")
	protected DocInfMgmtService docInfMgmtService;
	
	@Resource(name="statsMgmtService")
	protected StatsMgmtService statsMgmtService;
	
	
	/**
	 * 정보공개 문서관리 화면으로 이동한다.
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/infs/doc/docInfMgmtPage.do")
	public String docInfMgmtPage(ModelMap model) {
		
		Params params = new Params();
		
		params.set("grpCd", "D1008");
		model.addAttribute("cclCdList", statsMgmtService.selectOption(params));	// 이용허락조건
		
		params.set("grpCd", "S1009");
		model.addAttribute("openStateList", statsMgmtService.selectOption(params));	// 공개상태
		params.set("grpCd", "S1009");
		model.addAttribute("openStateList", statsMgmtService.selectOption(params));	// 공개상태
		params.set("grpCd", "D1009");
		model.addAttribute("loadCd", statsMgmtService.selectOption(params));	// 적재주기
		
		return "/admin/infset/doc/docInfMgmt";
	}
	
	/**
	 * 메인 리스트 조회(페이징 처리)
	 */
	@RequestMapping("/admin/infs/doc/docInfMainListPaging.do")
	public String docInfMainListPaging(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        Object result = docInfMgmtService.selectDocInfMainListPaging(params);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    } 
	
	/**
	 * 정보공개 문서관리 상세 데이터 조회
	 */
	@RequestMapping("/admin/infs/doc/docInfDtl.do")
	@ResponseBody
	public TABListVo<Record> infSetDtl(@RequestBody Params params, HttpServletRequest request, ModelMap model) {
		return new TABListVo<Record>(docInfMgmtService.selectDtl(params));
	}
	
	/**
	 * 정보공개 문서관리 마스터정보 데이터 등록
	 */
	@RequestMapping(value="/admin/infs/doc/insertDocInf.do")
	public String insertDocInf(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        //데이터 처리 진행 코드(입력)
        params.set(ModelAttribute.ACTION_STATUS, ModelAttribute.ACTION_INS);
        
        Object result = docInfMgmtService.saveDocInf(params);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 정보공개 문서관리 마스터정보 데이터 수정
	 */
	@RequestMapping(value="/admin/infs/doc/updateDocInf.do")
	public String updateInfSet(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        //데이터 처리 진행 코드(입력)
        params.set(ModelAttribute.ACTION_STATUS, ModelAttribute.ACTION_UPD);
        
        Object result = docInfMgmtService.saveDocInf(params);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 문서관리 데이터 삭제
	 */
	@RequestMapping(value="/admin/infs/doc/deleteDocInf.do")
	public String deleteDocInf(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);
        
        // 데이터 처리 진행 코드(입력)
        params.set(ModelAttribute.ACTION_STATUS, ModelAttribute.ACTION_DEL);
        
        Object result = docInfMgmtService.deleteDocInf(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 정보셋 분류체계 팝업으로 이동(iframe)
	 */
	@RequestMapping("/admin/infs/doc/popup/docInfCatePop.do")
	public String docInfCatePop(HttpServletRequest request, Model model){
		return "/admin/infset/doc/popup/docInfCatePop";
	}
	
	/**
	 * 정보셋 분류체계 팝업 데이터 리스트 조회
	 */
	@RequestMapping("/admin/infs/doc/popup/selectDocInfCatePop.do")
	public String selectDocInfCatePop(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        Object result = docInfMgmtService.selectDocInfCatePop(params);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 정보공개 문서관리 관리 관련 분류 조회
	 * @return
	 */
	@RequestMapping("/admin/infs/doc/selectDocInfCate.do")
	public String selectDocInfCate(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        Object result = docInfMgmtService.selectDocInfCate(params);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	
	/**
	 * 정보공개 문서관리 관리 관련 유저 조회
	 */
	@RequestMapping("/admin/infs/doc/selectDocInfUsr.do")
	public String selectInfoSetUsr(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        Object result = docInfMgmtService.selectDocInfUsr(params);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 정보공개 문서관리 관리 공개처리
	 */
	@RequestMapping("/admin/infs/doc/updateDocInfOpenState.do")
	public String updateInfSetOpenState(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        params.set("openState", "Y");
        Object result = docInfMgmtService.updateDocInfOpenState(params);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 정보공개 문서관리 관리 공개 취소처리
	 */
	@RequestMapping("/admin/infs/doc/updateDocInfOpenStateCancel.do")
	public String updateInfSetOpenStateCancel(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        params.set("openState", "N");
        Object result = docInfMgmtService.updateDocInfOpenState(params);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 정보공개 문서 파일을 조회한다. 
	 */
	@RequestMapping("/admin/infs/doc/selectDocInfFile.do")
	public String selectDocInfFile(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);
        
        Object result = docInfMgmtService.selectDocInfFile(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 정보공개 문서 파일을 등록한다. 
	 */
	@RequestMapping("/admin/infs/doc/insertDocInfFile.do")
	public String insertDocInfFile(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);
        
        // 데이터 처리 진행 코드(입력)
        params.set(ModelAttribute.ACTION_STATUS, ModelAttribute.ACTION_INS);
        
        Object result = docInfMgmtService.saveDocInfFile(request, params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 정보공개 문서 파일을 저장한다. 
	 */
	@RequestMapping("/admin/infs/doc/saveDocInfFile.do")
	public String saveDocInfFile(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);
        
        // 데이터 처리 진행 코드(수정)
        params.set(ModelAttribute.ACTION_STATUS, ModelAttribute.ACTION_UPD);
        
        Object result = docInfMgmtService.saveDocInfFile(request, params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 정보공개 문서 파일을 삭제한다. 
	 */
	@RequestMapping("/admin/infs/doc/deleteDocInfFile.do")
	public String deleteDocInfFile(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);
        
        // 데이터 처리 진행 코드(삭제)
        params.set(ModelAttribute.ACTION_STATUS, ModelAttribute.ACTION_DEL);
        
        Object result = docInfMgmtService.deleteDocInfFile(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 문서공개 원본 파일 고유번호를 조회한다.
	 */
	@RequestMapping("/admin/infs/doc/selectDocInfFileSrcFileSeq.do")
	public String selectDocInfFileSrcFileSeq(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);
        
        Object result = docInfMgmtService.selectDocInfFileSrcFileSeq(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 문서공개 첨부파일 순서를 조정한다.
	 */
	@RequestMapping("/admin/infs/doc/saveDocInfFileOrder.do")
	public String saveDocInfFileOrder(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);
        
        Object result = docInfMgmtService.saveDocInfFileOrder(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 문서공개 첨부파일 이미지 팝업창을 연다
	 */
	@RequestMapping("/admin/infs/doc/popup/docInfFileThumbnail.do")
	public String docInfFileThumbnail(HttpServletRequest request, Model model) {
        return "/admin/infset/doc/popup/docInfFileThumbnail";
    }
	
	/**
	 * 문서공개 첨부파일 이미지를 미리보기 한다. 
	 */
	@RequestMapping("/admin/infs/doc/selectDocInfFileThumbnail.do")
	public String selectDocInfFileThumbnail(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);
        
        Object result = docInfMgmtService.selectDocInfFileThumbnail(params);
        
        addObject(model, result);
        
        return "imageView";
    }
}

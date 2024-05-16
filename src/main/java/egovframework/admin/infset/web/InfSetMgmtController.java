package egovframework.admin.infset.web;

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

import egovframework.admin.infset.service.InfSetMgmtService;
import egovframework.admin.stat.service.StatsMgmtService;
import egovframework.common.base.constants.ModelAttribute;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.helper.TABListVo;

/**
 * 정보셋을 관리하는 컨트롤러 클래스
 * @author	JHKIM
 * @version 1.0
 * @since   2019/07/29
 */

@Controller
public class InfSetMgmtController extends BaseController { 
	
	protected static final Log logger = LogFactory.getLog(InfSetMgmtController.class);
	
	private static final String GC_INFS_TAG_DOC 	= "D";
	private static final String GC_INFS_TAG_OPEN 	= "O";
	private static final String GC_INFS_TAG_STAT 	= "S";
	
	@Resource(name="infSetMgmtService")
	protected InfSetMgmtService infSetMgmtService;
	
	@Resource(name="statsMgmtService")
	protected StatsMgmtService statsMgmtService;
	
	
	/**
	 * 정보셋 관리 화면으로 이동한다.
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/infs/mgmt/infsetMgmtPage.do")
	public String infsetMgmtPage(ModelMap model) {
		
		Params params = new Params();
		
		params.set("grpCd", "S1103");
		model.addAttribute("dtacycleList", statsMgmtService.selectOption(params));	// 추천순위
		
		params.set("grpCd", "S1009");
		model.addAttribute("openStateList", statsMgmtService.selectOption(params));	// 공개상태
		
		return "/admin/infset/mgmt/infSetMgmt";
	}
	
	/**
	 * 메인 리스트 조회(페이징 처리)
	 */
	@RequestMapping("/admin/infs/mgmt/infSetMainListPaging.do")
	public String infSetMainListPaging(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);
        
        Object result = infSetMgmtService.selectInfSetMainListPaging(params);
        
        addObject(model, result);
        
        return "jsonView";
    } 
	
	/**
	 * 상세 데이터 조회
	 */
	@RequestMapping("/admin/infs/mgmt/infSetDtl.do")
	@ResponseBody
	public TABListVo<Record> infSetDtl(@RequestBody Params params, HttpServletRequest request, ModelMap model) {
		return new TABListVo<Record>(infSetMgmtService.selectDtl(params));
	}
	
	/**
	 * 정보셋 마스터정보 데이터 등록
	 */
	@RequestMapping(value="/admin/infs/mgmt/insertInfSet.do")
	public String insertInfSet(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);
        
        // 데이터 처리 진행 코드(입력)
        params.set(ModelAttribute.ACTION_STATUS, ModelAttribute.ACTION_INS);
        
        Object result = infSetMgmtService.saveInfSet(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 정보셋 마스터정보 데이터 수정
	 */
	@RequestMapping(value="/admin/infs/mgmt/updateInfSet.do")
	public String updateInfSet(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);
        
        // 데이터 처리 진행 코드(입력)
        params.set(ModelAttribute.ACTION_STATUS, ModelAttribute.ACTION_UPD);
        
        Object result = infSetMgmtService.saveInfSet(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 정보셋 마스터정보 데이터 삭제
	 */
	@RequestMapping(value="/admin/infs/mgmt/deleteInfSet.do")
	public String deleteInfSet(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);
        
        // 데이터 처리 진행 코드(입력)
        params.set(ModelAttribute.ACTION_STATUS, ModelAttribute.ACTION_DEL);
        
        Object result = infSetMgmtService.deleteInfSet(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 정보셋 분류체계 팝업으로 이동(iframe)
	 */
	@RequestMapping("/admin/infs/mgmt/popup/infSetCatePop.do")
	public String infsCatePopup(HttpServletRequest request, Model model){
		return "/admin/infset/mgmt/popup/infSetCatePop";
	}
	
	/**
	 * 정보셋 분류체계 팝업(검색용)으로 이동(iframe)
	 */
	@RequestMapping("/admin/infs/mgmt/popup/infSetCateSearchPop.do")
	public String infSetCateSearchPopup(HttpServletRequest request, Model model){
		return "/admin/infset/mgmt/popup/infSetCateSearchPop";
	}
	
	/**
	 * 정보셋 분류체계 팝업 데이터 리스트 조회
	 */
	@RequestMapping("/admin/infs/mgmt/popup/selectInfSetCatePop.do")
	public String selectInfSetCatePop(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);
        
        Object result = infSetMgmtService.selectInfSetCatePop(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 정보셋 관리 관련 분류 조회
	 * @return
	 */
	@RequestMapping("/admin/infs/mgmt/selectInfoSetCate.do")
	public String selectInfoSetCate(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);
        
        Object result = infSetMgmtService.selectInfoSetCate(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	
	/**
	 * 정보셋 관리 관련 유저 조회
	 */
	@RequestMapping("/admin/infs/mgmt/selectInfoSetUsr.do")
	public String selectInfoSetUsr(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);
        
        Object result = infSetMgmtService.selectInfoSetUsr(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 문서데이터 선택 팝업으로 이동(iframe)
	 */
	@RequestMapping("/admin/infs/mgmt/popup/docListPop.do")
	public String docListPop(HttpServletRequest request, Model model){
		return "/admin/infset/mgmt/popup/docListPop";
	}
	
	/**
	 * 문서데이터 선택 팝업 데이터 리스트 조회
	 */
	@RequestMapping("/admin/infs/mgmt/popup/selectDocListPop.do")
	public String selectDocListPop(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);
        
        Object result = infSetMgmtService.selectDocListPop(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 공공데이터 선택 팝업으로 이동(iframe)
	 */
	@RequestMapping("/admin/infs/mgmt/popup/openListPop.do")
	public String openListPop(HttpServletRequest request, Model model){
		return "/admin/infset/mgmt/popup/openListPop";
	}
	
	/**
	 * 공공데이터 선택 팝업 데이터 리스트 조회
	 */
	@RequestMapping("/admin/infs/mgmt/popup/selectOpenListPop.do")
	public String selectOpenListPop(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);
        
        Object result = infSetMgmtService.selectOpenListPop(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 통계표 선택 팝업으로 이동(iframe)
	 */
	@RequestMapping("/admin/infs/mgmt/popup/statListPop.do")
	public String statListPop(HttpServletRequest request, Model model){
		return "/admin/infset/mgmt/popup/statListPop";
	}
	
	/**
	 * 통계표 선택 팝업 데이터 리스트 조회
	 */
	@RequestMapping("/admin/infs/mgmt/popup/selectStatListPop.do")
	public String selectStatListPop(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);
        
        Object result = infSetMgmtService.selectStatListPop(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 정보셋 관련 데이터의 문서 데이터를 입력한다
	 */
	@RequestMapping("/admin/infs/mgmt/saveInfoSetRelDoc.do")
	public String saveInfoSetRelDoc(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);
        
        // 정보셋 관련데이터 구분 키(정보셋구분, 객체ID)
        params.set("infsTagKey", GC_INFS_TAG_DOC);
        params.set("objIdKey", "docId");
        
        Object result = infSetMgmtService.saveInfSetRel(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 정보셋 관련 데이터의 공공데이터를 입력한다
	 */
	@RequestMapping("/admin/infs/mgmt/saveInfoSetRelOpen.do")
	public String saveInfoSetRelOpen(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);
        
        // 정보셋 관련데이터 구분 키(정보셋구분, 객체ID)
        params.set("infsTagKey", GC_INFS_TAG_OPEN);
        params.set("objIdKey", "infId");
        
        Object result = infSetMgmtService.saveInfSetRel(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 정보셋 관련 데이터의 통계 데이터를 입력한다
	 */
	@RequestMapping("/admin/infs/mgmt/saveInfoSetRelStat.do")
	public String saveInfoSetRelStat(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);
        
        // 정보셋 관련데이터 구분 키(정보셋구분, 객체ID)
        params.set("infsTagKey", GC_INFS_TAG_STAT);
        params.set("objIdKey", "statblId");
        
        Object result = infSetMgmtService.saveInfSetRel(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 정보셋 관리 관련 문서데이터 조회
	 */
	@RequestMapping("/admin/infs/mgmt/selectInfoSetRelDoc.do")
	public String selectInfoSetRelDoc(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);
        
        Object result = infSetMgmtService.selectInfoSetRelDoc(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 정보셋 관리 관련 공공데이터 조회
	 */
	@RequestMapping("/admin/infs/mgmt/selectInfoSetRelOpen.do")
	public String selectInfoSetRelOpen(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);
        
        Object result = infSetMgmtService.selectInfoSetRelOpen(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 정보셋 관리 관련 통계데이터 조회
	 */
	@RequestMapping("/admin/infs/mgmt/selectInfoSetRelStat.do")
	public String selectInfoSetRelStat(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);
        
        Object result = infSetMgmtService.selectInfoSetRelStat(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 정보셋 관리 공개처리
	 */
	@RequestMapping("/admin/infs/mgmt/updateInfSetOpenState.do")
	public String updateInfSetOpenState(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);
        
        params.set("openState", "Y");
        Object result = infSetMgmtService.updateInfSetOpenState(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 정보셋 관리 공개 취소처리
	 */
	@RequestMapping("/admin/infs/mgmt/updateInfSetOpenStateCancel.do")
	public String updateInfSetOpenStateCancel(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);
        
        params.set("openState", "N");
        Object result = infSetMgmtService.updateInfSetOpenState(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 정보셋 관리 설명 조회
	 */
	@RequestMapping("/admin/infs/mgmt/selectInfSetExp.do")
	public String selectInfSetExp(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);
        
        Object result = infSetMgmtService.selectInfSetExp(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 정보셋 관리 설명 데이터 등록
	 */
	@RequestMapping("/admin/infs/mgmt/insertInfSetExp.do")
	public String insertInfSetExp(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);
        
        // 데이터 처리 진행 코드(입력)
        params.set(ModelAttribute.ACTION_STATUS, ModelAttribute.ACTION_INS);
        
        Object result = infSetMgmtService.saveInfSetExp(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 정보셋 관리 설명 데이터 수정
	 */
	@RequestMapping("/admin/infs/mgmt/updateInfSetExp.do")
	public String updateInfSetExp(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);
        
        // 데이터 처리 진행 코드(수정)
        params.set(ModelAttribute.ACTION_STATUS, ModelAttribute.ACTION_UPD);
        
        Object result = infSetMgmtService.saveInfSetExp(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 정보셋 관리 설명 데이터 삭제
	 */
	@RequestMapping("/admin/infs/mgmt/deleteInfSetExp.do")
	public String deleteInfSetExp(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);
        
        Object result = infSetMgmtService.deleteInfSetExp(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 정보셋 관리 설명 시트 순서 저장
	 */
	@RequestMapping("/admin/infs/mgmt/saveInfSetExpOrder.do")
	public String saveInfSetExpOrder(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);
        
        Object result = infSetMgmtService.saveInfSetExpOrder(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
}

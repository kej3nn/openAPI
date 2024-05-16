package egovframework.portal.doc.web;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.ggportal.data.service.PortalOpenInfSrvService;
import egovframework.portal.doc.service.PortalDocInfService;
import egovframework.portal.infs.service.PortalInfsListService;

/**
 * 문서관리 서비스를 관리하는 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2018/08/20
 */
@Controller
public class PortalDocInfController extends BaseController {
	
	/**
     * 조회 뷰이름
     */
    public static final Map<String, String> selectViewNames = new HashMap<String, String>();
    
    /*
     * 클래스 변수를 초기화한다.
     */
    static {
        // 조회 뷰이름
        selectViewNames.put(PortalDocInfService.SERVICE_TYPE_FILE,    "portal/doc/service/selectFile");
    }
	
	@Resource(name="portalDocInfService")
	protected PortalDocInfService portalDocInfService;
	
	@Resource(name="portalInfsListService")
	protected PortalInfsListService portalInfsListService;
	
    /**
     * 문서관리 메타정보 조회
     */
    @RequestMapping("/portal/doc/docInfPage.do")
	public String docInfPage(HttpServletRequest request, Model model) {
    	Params params = getParams(request, false);
		
		model.addAttribute("meta", portalDocInfService.selectDocInfMeta(params));	// 메타정보
		
		return "portal/doc/docInfPage";
	}
    
    /**
     * 문서관리 서비스 화면을 조회한다.
     */
    @RequestMapping("/portal/doc/docInfPage.do/{docId}")
	public String docInfDirectPage(@PathVariable("docId") String docId, HttpServletRequest request, Model model) {
		model.addAttribute("docId", docId);
		
		Params params = getParams(request, false);
		
		params.set("docId", docId);
		
		// 문서 메타 정보 조회
		Record meta = portalDocInfService.selectDocInfMeta(params);	
		
		model.addAttribute("meta", meta);	// 메타정보
		
		portalInfsListService.keepSearchParam(params, model);
		
		return selectViewNames.get(meta.getString("srvCd"));
	}
    
    /**
     * 문서 평가점수를 등록한다.
     */
    @RequestMapping("/portal/doc/insertDocInfAppr.do")
   	public String insertDocInfAppr(HttpServletRequest request, Model model) {
   		Params params = getParams(request, false);
   		
   		Object result = portalDocInfService.insertDocInfAppr(params);
   		
   		addObject(model, result);
   		
   		return "jsonView";
   	}
    
}

package egovframework.portal.nadata.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.portal.nadata.service.PortalNaDataCommService;

/**
 * 국회사무처 보고서&발간물 위원회 화면 클래스
 * 
 * @author	JSSON
 * @version 1.0
 * @since   2019/09/11
 */
@Controller
public class PortalNaDataCommController extends BaseController {
	
	@Resource(name="portalNaDataCommService")
	protected PortalNaDataCommService portalNaDataCommService;
	
	/**
	 * 보고서&발간물 서비스 화면으로 이동한다.
	 */
	@RequestMapping("/portal/nadata/catalog/naDataCommPage.do")
	public ModelAndView naDataCatalogPage(HttpServletRequest request, Model model) {
		ModelAndView modelAndView = new ModelAndView();
		
		// 파라메터를 가져온다.
        Params params = getParams(request, false);
	        
        // 모델에 객체를 추가한다.
        // 분류
     	modelAndView.addObject("itmList", portalNaDataCommService.selectDataCommItm(params));
        // 기관
     	modelAndView.addObject("orgList", portalNaDataCommService.selectDataCommOrg(params));
        // 발간년도
     	modelAndView.addObject("cycleList", portalNaDataCommService.selectDataCommCycle(params));
	     	
     	modelAndView.setViewName("/portal/nadata/naDataComm");
     	
		return modelAndView;
	}
	
    /**
     * 국회사무처 보고서&발간물 내용을 검색한다.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/nadata/catalog/searchNaDataComm.do")
    public String searchNaDataComm(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 내용을 검색한다.
        Object result = portalNaDataCommService.searchNaDataComm(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }

	/**
	 * 국회사무처 보고서&발간물 썸네일 불러오기
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/nadata/catalog/selectNaDataCommThumbnail.do")
    public String selectNaDataCommThumbnail(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 데이터셋 썸네일을 조회한다.
        Object result = portalNaDataCommService.selectNaDataCommThumbnail(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "imageView";
    }
	
}

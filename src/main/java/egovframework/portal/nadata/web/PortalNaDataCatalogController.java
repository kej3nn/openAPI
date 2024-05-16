package egovframework.portal.nadata.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import egovframework.admin.stat.service.StatsMgmtService;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.portal.infs.service.PortalInfsListService;
import egovframework.portal.nadata.service.PortalNaDataCatalogService;

/**
 * 국회사무처 정보서비스 카탈로그 화면 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/09/11
 */
@Controller
public class PortalNaDataCatalogController extends BaseController {
	
	@Resource(name="portalNaDataCatalogService")
	protected PortalNaDataCatalogService portalNaDataCatalogService;
	
	@Resource(name="portalInfsListService")
	protected PortalInfsListService portalInfsListService;
	
	@Resource(name="statsMgmtService")
	protected StatsMgmtService statsMgmtService;
	
	/**
	 * 정보카달로그서비스 사이트맵 화면으로 이동한다.
	 */
	@RequestMapping("/portal/nadata/catalog/naDataCatalogPage.do")
		public String naDataCatalogPage(HttpServletRequest request, Model model,
				@RequestParam(required=false, defaultValue="") String infoId) {
			// 파라메터를 가져온다.
	        Params params = getParams(request, false);
	        
	        debug("Request parameters: " + params);
	        
	        params.put("cateTag", "CT110");
			model.addAttribute("list", portalNaDataCatalogService.selectNaTopCateList(params));
			
			model.addAttribute("paramInfoId", infoId);
			
			if ( StringUtils.isNotBlank(infoId) ) {
				model.addAttribute("paramCateId", portalNaDataCatalogService.selectNaSetTopCateId(infoId));
			}
			
			Params optParams = new Params();
			model.addAttribute("orgList", portalInfsListService.selectCommOrgTop(optParams));	// 기관
			
			optParams.set("grpCd", "A8010");
			model.addAttribute("srcSysList", statsMgmtService.selectSysOption(optParams));	// 원본 시스템
			
			optParams.set("grpCd", "A8011");
			model.addAttribute("srvInfoList", statsMgmtService.selectOption(optParams));	// 서비스정보(유형)
			
			model.addAttribute("cateTag", "CT110");
			
			return "portal/nadata/naDataCatalog";
	}
	
	/**
	 * 정보카달로그 썸네일 불러오기
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/nadata/catalog/selectThumbnail.do")
    public String selectThumbnail(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 공공데이터 데이터셋 썸네일을 조회한다.
        Object result = portalNaDataCatalogService.selectNaSetCateThumbnail(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "imageView";
    }
	
	/**
	 * 정보카탈로그분류 트리 목록을 조회한다.
	 * @return
	 */
	@RequestMapping("/portal/nadata/catalog/selectNaDataCateTree.do")
    public String selectNaDataCateTree(HttpServletRequest request, Model model) {
        Params params = getParams(request, false);

        Object result = portalNaDataCatalogService.selectNaDataCateTree(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 정보셋 상세 조회
	 */
	@RequestMapping("/portal/nadata/catalog/selectInfoDtl.do")
    public String selectInfoDtl(HttpServletRequest request, Model model) {
        Params params = getParams(request, false);

        Object result = portalNaDataCatalogService.selectInfoDtl(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 정보카탈로그 디렉토리 목록 검색
	 */
	@RequestMapping("/portal/nadata/catalog/searchNaSetDirPaging.do")
    public String searchNaSetDirPaging(HttpServletRequest request, Model model) {
        Params params = getParams(request, false);

        Object result = portalNaDataCatalogService.selectNaSetDirPaging(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 정보카탈로그 목록(트리) 다운로드
	 */
	@RequestMapping("/portal/nadata/catalog/selectNaDataCateTreeExcel.do")
	public ModelAndView selectNaDataCateTreeExcel(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
		
		ModelAndView modelAndView = new ModelAndView();
		
		Object result = portalNaDataCatalogService.selectNaDataCatalogExcel(params);
		
		modelAndView.addObject("result", result);
		modelAndView.setViewName("/portal/nadata/naDataCatalogExcel");
        
        return modelAndView;
	}
	
	/**
	 * 정보카탈로그 목록 다운로드
	 */
	@RequestMapping("/portal/nadata/catalog/selectNaDataListExcel.do")
	public ModelAndView selectNaDataListExcel(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
		
		ModelAndView modelAndView = new ModelAndView();
		
		Object result = portalNaDataCatalogService.selectNaDataCatalogListExcel(params);
		
		modelAndView.addObject("result", result);
		modelAndView.setViewName("/portal/nadata/naDataCatalogListExcel");
        
        return modelAndView;
	}
	
	/**
	 * 정보카탈로그 목록
	 */
	@RequestMapping("/portal/nadata/catalog/selectNaSetListPaging.do")
    public String selectNaSetListPaging(HttpServletRequest request, Model model) {
        Params params = getParams(request, false);

        Object result = portalNaDataCatalogService.selectNaSetListPaging(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
}

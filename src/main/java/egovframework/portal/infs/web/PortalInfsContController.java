package egovframework.portal.infs.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.portal.infs.service.PortalInfsContService;
import egovframework.soportal.stat.service.StatListService;

/**
 * 사전정보공개 컨텐츠를 관리하는 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/08/12
 */
@Controller("portalInfsContController")
public class PortalInfsContController extends BaseController {
	
	@Resource(name="portalInfsContService")
	protected PortalInfsContService portalInfsContService;

	/**
	 * 사전정보공개 컨텐츠 목록화면으로 이동한다.
	 */
	@RequestMapping("/portal/infs/cont/infsContPage.do")
	public String infsContPage(@RequestParam(required=false, defaultValue="") String cateId, 
			@RequestParam(required=false, defaultValue="") String infsId, HttpServletRequest request, Model model) {
		model.addAttribute("paramInfsId", infsId);
		model.addAttribute("paramCateId", cateId);
		return "portal/infs/cont/infsContPage";
	}
	
	/**
	 * 정보분류 트리 목록을 조회한다.
	 * @return
	 */
	@RequestMapping("/portal/infs/cont/selectInfoCateTree.do")
    public String selectInfCateTree(HttpServletRequest request, Model model) {
        Params params = getParams(request, false);

        Object result = portalInfsContService.selectInfoCateTree(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 정보셋 상세 조회
	 */
	@RequestMapping("/portal/infs/cont/selectInfsDtl.do")
    public String selectInfsDtl(HttpServletRequest request, Model model) {
        Params params = getParams(request, false);

        Object result = portalInfsContService.selectInfsDtl(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 정보셋 설명 조회
	 */
	@RequestMapping("/portal/infs/cont/selectInfsExp.do")
    public String selectInfsExp(HttpServletRequest request, Model model) {
        Params params = getParams(request, false);

        Object result = portalInfsContService.selectInfsExp(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 정보셋에 연결된 데이터들 조회(문서, 공개, 통계)
	 */
	@RequestMapping("/portal/infs/cont/selectInfsRel.do")
    public String selectInfsRel(HttpServletRequest request, Model model) {
        Params params = getParams(request, false);

        Object result = portalInfsContService.selectInfsRel(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 정보공개 컨텐츠 모바일 조회(페이징)
	 */
	@RequestMapping("/portal/infs/cont/selectInfsContPaging.do")
    public String selectInfsContPaging(HttpServletRequest request, Model model) {
        Params params = getParams(request, false);

        Object result = portalInfsContService.selectInfsContPaging(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 정보공개 컨텐츠 목록 검색
	 */
	@RequestMapping("/portal/infs/cont/searchInfsCont.do")
    public String searchInfsCont(HttpServletRequest request, Model model) {
        Params params = getParams(request, false);

        Object result = portalInfsContService.searchInfsCont(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 정보공개 컨텐츠 목록 다운로드
	 */
	@RequestMapping("/portal/infs/cont/infsListExcel.do")
	public ModelAndView infsListExcel(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
		
		ModelAndView modelAndView = new ModelAndView();
		
		Object result = portalInfsContService.selectInfoCateTreeExcel(params);
		
		modelAndView.addObject("result", result);
		modelAndView.setViewName("/portal/infs/cont/infsListExcel");
        
        return modelAndView;
	}
	
	/**
	 * 정보분류 부모ID가 속한 하위의 카테고리를 조회한다.
	 */
	@RequestMapping("/portal/infs/cont/selectInfoCateChild.do")
	public String selectInfoCateChild(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
		
		Object result = portalInfsContService.selectInfoCateChild(params);
		
		addObject(model, result);
        
        return "jsonView";
	}
	
	/**
	 * 모바일에서 분류ID로 바로가기할때 파라미터로 넘어오는 분류 ID의 전체 CATE_ID를 가져온다.
	 */
	@RequestMapping("/portal/infs/cont/selectInfoCateFullPathCateId.do")
	public String selectInfoCateFullPathCateId(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
		
		Object result = portalInfsContService.selectInfoCateFullPathCateId(params);
		
		addObject(model, result);
        
        return "jsonView";
	}
	
}

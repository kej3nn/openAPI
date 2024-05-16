package egovframework.portal.infs.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.exception.SystemException;
import egovframework.common.base.model.Params;
import egovframework.portal.infs.service.PortalInfsListService;

/**
 * 사전정보공개 목록을 관리하는 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2018/08/12
 */
@Controller("portalInfsListController")
public class PortalInfsListController extends BaseController {

	@Resource(name="portalInfsListService")
	protected PortalInfsListService portalInfsListService;
	
	/**
	 * 사전정보공개 목록 화면으로 이동한다.
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/portal/infs/list/infsListPage.do")
	public String infsListPage(HttpServletRequest request, Model model) {
		model.addAttribute("schOrg", portalInfsListService.selectCommOrgTop(new Params()));	// 기관
		
		Params params = getParams(request, false);
		//setSearchParam(params, model);
		portalInfsListService.keepSearchParam(params, model);
		
		
		return "portal/infs/list/infsListPage";
	}
	
	/**
	 * 정보공개 목록 조회(페이징)
	 */
	@RequestMapping("/portal/infs/list/selectInfsListPaging.do")
    public String selectInfsExp(HttpServletRequest request, Model model) {
        Params params = getParams(request, false);
        
        Object result = portalInfsListService.selectInfsListPaging(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	@RequestMapping("/portal/infs/list/infsListDtl.do")
	public String infsListDtl(HttpServletRequest request, Model model) {
		Params params = getParams(request, false);
//		setSearchParam(params, model);
		portalInfsListService.keepSearchParam(params, model);
		
		return "portal/infs/list/infsListDtl";
	}
	
	
	/**
	 * 정보공개 일괄 다운로드 페이지로 이동한다.
	 */
	@RequestMapping("/portal/infs/list/infsListDownPage.do")
	public String infsListDownPage(HttpServletRequest request, Model model) {
		return "portal/infs/list/infsListDown";
	}
	
	/**
	 * 정보서비스 목록을 조회한다.
	 */
	@RequestMapping("/portal/infs/list/selectInfsInfoRelList.do")
    public String selectInfsInfoRelList(HttpServletRequest request, Model model) {
        Params params = getParams(request, false);
        
        Object result = portalInfsListService.selectInfsInfoRelList(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 정보공개 일괄 다운로드를 수행한다.
	 */
	@RequestMapping("/portal/infs/list/download.do")
	public void download(HttpServletResponse response, HttpServletRequest request) {
		Params params = getParams(request, false);
		
		try {
			portalInfsListService.download(request, response, params);
		}
		catch(ServiceException e) {
			EgovWebUtil.exLogging(e);
			throw new ServiceException(e.getMessage());
		}
		catch(DataAccessException e) {
			EgovWebUtil.exLogging(e);
		}
		catch(Exception e) {
			error("Exception : " , e);
			EgovWebUtil.exLogging(e);
			throw new SystemException("다운로드중 에러가 발생하였습니다.");
		}
	}
}

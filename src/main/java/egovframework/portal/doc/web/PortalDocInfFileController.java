package egovframework.portal.doc.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.portal.doc.service.PortalDocInfFileService;
import egovframework.portal.doc.service.PortalDocInfService;

/**
 * 문서관리 파일 서비스를 관리하는 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2018/08/21
 */
@Controller
public class PortalDocInfFileController extends BaseController {

	@Resource(name="portalDocInfFileService")
	protected PortalDocInfFileService portalDocInfFileService;
	
	/**
	 * 문서관리 파일 서비스 정보 조회
	 */
	@RequestMapping("/portal/doc/file/searchFileData.do")
    public String searchFileData(HttpServletRequest request, Model model) {
        Params params = getParams(request, false);
        
        Object result = portalDocInfFileService.searchDocInfFile(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 문서관리 파일 서비스 파일 다운로드
	 */
	@RequestMapping("/portal/doc/file/downloadFileData.do")
    public String downloadFileData(HttpServletRequest request, Model model) {
        Params params = getParams(request, false);
        
        Object result = portalDocInfFileService.selectDocInfFileCUD(params);
        
        addObject(model, result);
        
        return "fileDownloadView";
    }
}

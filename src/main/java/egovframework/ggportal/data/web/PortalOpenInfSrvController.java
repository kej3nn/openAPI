/*
 * @(#)PortalOpenInfSrvController.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.data.web;

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
import egovframework.portal.infs.service.PortalInfsListService;

/**
 * 공공데이터 서비스를 관리하는 컨트롤러 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Controller("ggportalOpenInfSrvController")
public class PortalOpenInfSrvController extends BaseController {
    /**
     * 조회 뷰이름
     */
    public static final Map<String, String> selectViewNames = new HashMap<String, String>();
    
    /*
     * 클래스 변수를 초기화한다.
     */
    static {
        // 조회 뷰이름
        selectViewNames.put(PortalOpenInfSrvService.SERVICE_TYPE_SHEET,   "ggportal/data/service/selectSheet");
        selectViewNames.put(PortalOpenInfSrvService.SERVICE_TYPE_CHART,   "ggportal/data/service/selectChart");
        selectViewNames.put(PortalOpenInfSrvService.SERVICE_TYPE_MAP,     "ggportal/data/service/selectMap");
        selectViewNames.put(PortalOpenInfSrvService.SERVICE_TYPE_FILE,    "ggportal/data/service/selectFile");
        selectViewNames.put(PortalOpenInfSrvService.SERVICE_TYPE_OPENAPI, "ggportal/data/service/selectOpenApi");
        selectViewNames.put(PortalOpenInfSrvService.SERVICE_TYPE_LINK,    "ggportal/data/service/selectLink");
        selectViewNames.put(PortalOpenInfSrvService.SERVICE_TYPE_VISUAL,    "ggportal/data/service/selectVisual");
    }
    
    /**
     * 공공데이터 서비스를 관리하는 서비스
     */
    @Resource(name="ggportalOpenInfSrvService")
    private PortalOpenInfSrvService portalOpenInfSrvService;
    
    /**
     * 사전정보공개 목록 서비스를 관리하는 서비스
     */
    @Resource(name="portalInfsListService")
	protected PortalInfsListService portalInfsListService;
    
    /**
     * 공공데이터 서비스를 조회하는 화면으로 이동한다.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/data/service/selectServicePage.do")
    public String selectServicePage(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        model.addAttribute("infId", params.getString("infId"));
        
        debug("Request parameters: " + params);
        
        // 공공데이터 서비스 메타정보를 조회한다.
        Record result = portalOpenInfSrvService.selectOpenInfSrvMetaCUD(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 조회 파라미터 유지(사전정보공개)
        portalInfsListService.keepSearchParam(params, model);
        
        // 뷰이름을 반환한다.
        return selectViewNames.get(result.getString("srvCd"));
    }
    
    /**
     * 공공데이터 서비스를 조회하는 화면으로 이동한다. (공공데이터ID가 넘어와 바로조회할 경우)
     * @param infId		공공데이터ID
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/portal/data/service/selectServicePage.do/{infId}")
    public String selectServiceInfIdPage(@PathVariable("infId") String infId, HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        params.set("infId", infId);	//공공데이터 ID 파라미터로 넣어준다.
        model.addAttribute("infId", infId);
        
        debug("Request parameters: " + params);
        
        // 공공데이터 서비스 메타정보를 조회한다.
        Record result = portalOpenInfSrvService.selectOpenInfSrvMetaCUD(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 조회 파라미터 유지(사전정보공개)
        portalInfsListService.keepSearchParam(params, model);

        // 뷰이름을 반환한다.
        return selectViewNames.get(result.getString("srvCd"));
    }
    
    /**
     * 공공데이터 Open API 서비스를 조회하는 화면으로 이동한다. - 국회사무처 (공공데이터ID가 넘어와 바로조회할 경우)
     */
    @RequestMapping("/portal/data/service/selectAPIServicePage.do/{infId}")
    public String selectAPIServicePage(@PathVariable("infId") String infId, HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        params.set("infId", infId);	//공공데이터 ID 파라미터로 넣어준다.
        model.addAttribute("infId", infId);
        params.set("isApiPage", "Y");
        
        debug("Request parameters: " + params);
        
        // 공공데이터 서비스 메타정보를 조회한다.
        Record result = portalOpenInfSrvService.selectOpenInfApiSrvMetaCUD(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 조회 파라미터 유지(사전정보공개)
        portalInfsListService.keepSearchParam(params, model);

        
        // 뷰이름을 반환한다.
        return "ggportal/data/service/selectNaOpenApi";
    }
    
    /**
     * 공공데이터 서비스 평가점수를 등록한다.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/data/service/insertAppraisal.do")
    public String insertAppraisal(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 공공데이터 서비스 평가점수를 등록한다.
        Object result = portalOpenInfSrvService.insertOpenInfSrvApprCUD(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
}
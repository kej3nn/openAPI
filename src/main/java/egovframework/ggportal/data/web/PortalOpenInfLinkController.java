/*
 * @(#)PortalOpenInfLinkController.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.data.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.ggportal.data.service.PortalOpenInfLinkService;

/**
 * 공공데이터 링크 서비스를 관리하는 컨트롤러 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Controller("ggportalOpenInfLInkController")
public class PortalOpenInfLinkController extends BaseController {
    /**
     * 공공데이터 링크 서비스를 관리하는 서비스
     */
    @Resource(name="ggportalOpenInfLinkService")
    private PortalOpenInfLinkService portalOpenInfLinkService;
    
    /**
     * 공공데이터 링크 서비스 메타정보를 조회한다.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/data/link/selectLinkMeta.do")
    public String selectLinkMeta(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 공공데이터 링크 서비스 메타정보를 조회한다.
        Object result = portalOpenInfLinkService.selectOpenInfLinkMeta(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
    
    /**
     * 공공데이터 링크 서비스 데이터를 검색한다.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/data/link/searchLinkData.do")
    public String searchLinkData(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 공공데이터 링크 서비스 데이터를 검색한다.
        Object result = portalOpenInfLinkService.searchOpenInfLinkData(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
    
    /**
     * 공공데이터 링크 서비스 데이터를 조회한다.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/data/link/selectLinkData.do")
    public String selectLinkData(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 공공데이터 링크 서비스 데이터를 조회한다.
        Record result = portalOpenInfLinkService.selectOpenInfLinkDataCUD(params);
        
        debug("Processing results: " + result);
        
        // 뷰이름을 반환한다.
        return "redirect:" + result.getString("linkUrl");
    }
    
    /**
     * 공공데이터 링크 서비스 썸네일을 조회한다.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/data/link/selectLinkTmnl.do")
    public String selectLinkTmnl(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 공공데이터 링크 서비스 썸네일을 조회한다.
        Record result = portalOpenInfLinkService.selectOpenInfLinkTmnl(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "imageView";
    }
}
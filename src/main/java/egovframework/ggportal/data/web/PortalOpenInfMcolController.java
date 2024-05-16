/*
 * @(#)PortalOpenInfMcolController.java 1.0 2015/06/15
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
import egovframework.ggportal.data.service.PortalOpenInfMcolService;

/**
 * 공공데이터 지도 서비스를 관리하는 컨트롤러 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Controller("ggportalOpenInfMcolController")
public class PortalOpenInfMcolController extends BaseController {
    /**
     * 공공데이터 지도 서비스를 관리하는 서비스
     */
    @Resource(name="ggportalOpenInfMcolService")
    private PortalOpenInfMcolService portalOpenInfMcolService;
    
    /**
     * 공공데이터 지도 서비스 메타정보를 조회한다.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/data/map/selectMapMeta.do")
    public String selectMapMeta(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 공공데이터 지도 서비스 메타정보를 조회한다.
        Object result = portalOpenInfMcolService.selectOpenInfMcolMeta(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
    
    /**
     * 공공데이터 지도 서비스 데이터를 검색한다.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/data/map/searchMapData.do")
    public String searchMapData(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 공공데이터 지도 서비스 데이터를 검색한다.
        Object result = portalOpenInfMcolService.searchOpenInfMcolData(params, false);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
    
    /**
     * MAP에서 shape 파일이 있는지 확인하고 리스트 조회한다.
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/portal/data/map/selectOpenInfIsShape.do")
    public String selectOpenInfIsShape(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // MAP에서 shape 파일이 있는지 확인하고 리스트 조회한다.
        Object result = portalOpenInfMcolService.selectOpenInfIsShape(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
}
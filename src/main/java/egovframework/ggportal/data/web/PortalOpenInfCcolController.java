/*
 * @(#)PortalOpenInfCcolController.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.data.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.ggportal.data.service.PortalOpenInfCcolService;

/**
 * 공공데이터 차트 서비스를 관리하는 컨트롤러 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Controller("ggportalOpenInfCcolController")
public class PortalOpenInfCcolController extends BaseController {
    /**
     * 공공데이터 차트 서비스를 관리하는 서비스
     */
    @Resource(name="ggportalOpenInfCcolService")
    private PortalOpenInfCcolService portalOpenInfCcolService;
    
    /**
     * 공공데이터 차트 서비스 메타정보를 조회한다.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/data/chart/selectChartMeta.do")
    public String selectChartMeta(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 공공데이터 차트 서비스 메타정보를 조회한다.
        Object result = portalOpenInfCcolService.selectOpenInfCcolMeta(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
    
    /**
     * 공공데이터 차트 서비스 데이터를 검색한다.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/data/chart/searchChartData.do")
    public String searchChartData(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 공공데이터 차트 서비스 데이터를 검색한다.
        Object result = portalOpenInfCcolService.searchOpenInfCcolData(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
    
    /**
     * 공공데이터 차트 서비스 데이터를 다운로드한다.
     * 
     * @param request HTTP 요청
     * @param response HTTP 응답
     * @throws Exception 발생오류
     */
    @RequestMapping("/portal/data/chart/downloadChartData.do")
    public void downloadChartData(HttpServletRequest request, HttpServletResponse response) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 공공데이터 시트 서비스 데이터를 다운로드한다.
        portalOpenInfCcolService.downloadOpenInfCcolDataCUD(request, response, params);
    }
}
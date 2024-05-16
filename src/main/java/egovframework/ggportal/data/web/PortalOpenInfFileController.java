/*
 * @(#)PortalOpenInfFileController.java 1.0 2015/06/15
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
import egovframework.ggportal.data.service.PortalOpenInfFileService;

/**
 * 공공데이터 파일 서비스를 관리하는 컨트롤러 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Controller("ggportalOpenInfFileController")
public class PortalOpenInfFileController extends BaseController {
    /**
     * 공공데이터 파일 서비스를 관리하는 서비스
     */
    @Resource(name="ggportalOpenInfFileService")
    private PortalOpenInfFileService portalOpenInfFileService;
    
    /**
     * 공공데이터 파일 서비스 메타정보를 조회한다.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/data/file/selectFileMeta.do")
    public String selectFileMeta(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 공공데이터 파일 서비스 메타정보를 조회한다.
        Object result = portalOpenInfFileService.selectOpenInfFileMeta(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
    
    /**
     * 공공데이터 파일 서비스 데이터를 검색한다.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/data/file/searchFileData.do")
    public String searchFileData(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 공공데이터 파일 서비스 데이터를 검색한다.
        Object result = portalOpenInfFileService.searchOpenInfFileData(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
    
    /**
     * 공공데이터 파일 서비스 데이터를 조회한다.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/data/file/selectFileData.do")
    public String selectFileData(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 공공데이터 파일 서비스 데이터를 조회한다.
        Record result = portalOpenInfFileService.selectOpenInfFileDataCUD(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "redirect:/synap/skin/doc.html?rs=" + result.getString("rs") + "&fn=" + result.getString("fn");
    }
    
    /**
     * 공공데이터 파일 서비스 데이터를 다운로드한다.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/data/file/downloadFileData.do")
    public String downloadFileData(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 공공데이터 파일 서비스 데이터를 조회한다.
        Object result = portalOpenInfFileService.selectOpenInfFileDataCUD(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "fileDownloadView";
    }
}
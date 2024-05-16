/*
 * @(#)PortalOpenInfScolController.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.data.web;

import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.util.UtilString;
import egovframework.ggportal.data.service.PortalOpenInfScolService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;

/**
 * 공공데이터 시트 서비스를 관리하는 컨트롤러 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Controller("ggportalOpenInfScolController")
public class PortalOpenInfScolController extends BaseController {
    /**
     * 공공데이터 시트 서비스를 관리하는 서비스
     */
    @Resource(name="ggportalOpenInfScolService")
    private PortalOpenInfScolService portalOpenInfScolService;
    
    /**
     * 공공데이터 시트 서비스 메타정보를 조회한다.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/data/sheet/selectSheetMeta.do")
    public String selectSheetMeta(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 공공데이터 시트 서비스 메타정보를 조회한다.
        Object result = portalOpenInfScolService.selectOpenInfScolMeta(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
    
    /**
     * 공공데이터 시트 서비스 데이터를 검색한다.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/data/sheet/searchSheetData.do")
    public String searchSheetData(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 공공데이터 시트 서비스 데이터를 검색한다.
        Object result = portalOpenInfScolService.searchOpenInfScolData(params);

        // HTML Entity 표출 처리
        ArrayList<Record> arrPag = null;
        try {
            arrPag = (ArrayList<Record>) ((Paging) result).getData();

            for (int i = 0; i < arrPag.size(); i++) {
                String opbFlNm = arrPag.get(i).getString("OPB_FL_NM");

                opbFlNm = UtilString.reverse2AMP(opbFlNm);
                opbFlNm = UtilString.reverse2MIDDOT(opbFlNm);
                opbFlNm = UtilString.reverse2GT(opbFlNm);
                opbFlNm = UtilString.reverse2LT(opbFlNm);
                opbFlNm = UtilString.reverse2APOS(opbFlNm);
                opbFlNm = UtilString.reverse2QUOT(opbFlNm);

                arrPag.get(i).put("OPB_FL_NM", opbFlNm);
            }
        } catch (NullPointerException e) {
            e.printStackTrace(); 
        }

        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
    
    /**
     * 공공데이터 시트 서비스 데이터를 다운로드한다.
     * 
     * @param request HTTP 요청
     * @param response HTTP 응답
     * @throws Exception 발생오류
     */
    @RequestMapping("/portal/data/sheet/downloadSheetData.do")
    public void downloadSheetData(HttpServletRequest request, HttpServletResponse response) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 공공데이터 시트 서비스 데이터를 다운로드한다.
        portalOpenInfScolService.downloadOpenInfScolDataCUD(request, response, params);
    }
    
     /**
     * 시트서비스를 조회한다.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/data/sheet/selectRecommandDataSet.do")
    public String selectRecommandDataSet(HttpServletRequest request, Model model) {
        
    	// 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 공공데이터 시트 서비스 메타정보를 조회한다.
        Object result = portalOpenInfScolService.selectRecommandDataSet(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
    
    /**
     * 공공데이터 시트 서비스 대용량 데이터를 다운로드한다.
     * 
     * @param request HTTP 요청
     * @param response HTTP 응답
     * @throws Exception 발생오류
     */
    @RequestMapping("/portal/data/sheet/downloadBigSheetData.do")
    public String downloadBigSheetData(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 공공데이터 시트 서비스 데이터를 다운로드한다.
        Object result = portalOpenInfScolService.downloadBbsFileCUD(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        return "fileDownloadView";
    }
    
    /**
     * 유저 파일다운로드 데이터 조회
     */
    @RequestMapping("/portal/data/sheet/searchUsrDefFileData.do")
    public String searchUsrDefFileData(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 공공데이터 시트 서비스 데이터를 검색한다.
        Object result = portalOpenInfScolService.searchUsrDefFileData(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 유저 파일다운로드 데이터를 다운로드한다.
     */
    @RequestMapping("/portal/data/sheet/downloadFileData.do")
    public String downloadFileData(HttpServletRequest request, Model model) {
    	// 파라메터를 가져온다.
    	Params params = getParams(request, false);
    	
    	debug("Request parameters: " + params);
    	
    	// 공공데이터 시트 서비스 데이터를 검색한다.
    	Object result = portalOpenInfScolService.searchUsrDefFileOneData(params);
    	
    	debug("Processing results: " + result);
    	
    	// 모델에 객체를 추가한다.
    	addObject(model, result);
    	
    	// 뷰이름을 반환한다.
    	return "fileDownloadView";
    }
    
    
}
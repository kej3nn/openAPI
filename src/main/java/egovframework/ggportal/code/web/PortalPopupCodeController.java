/*
 * @(#)PortalPopupCodeController.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.code.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.ggportal.code.service.PortalPopupCodeService;

/**
 * 팝업 코드를 관리하는 컨트롤러 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Controller("ggportalPopupCodeController")
public class PortalPopupCodeController extends BaseController {
    /**
     * 팝업 코드를 관리하는 서비스
     */
    @Resource(name="ggportalPopupCodeService")
    private PortalPopupCodeService portalPopupCodeService;
    
    /**
     * 팝업 코드를 검색한다.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/common/code/searchPopupCode.do")
    public String searchPopupCode(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 공통 코드를 검색한다.
        Object result = portalPopupCodeService.searchPopupCode(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
}
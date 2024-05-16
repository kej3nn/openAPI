/*
 * @(#)PortalSearchController.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.main.web;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.common.base.controller.BaseController;

/**
 * 통합 검색 컨트롤러 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Controller("ggportalSearchController")
public class PortalSearchController extends BaseController {
    /**
     * 통합 검색 화면으로 이동한다.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/searchPage.do")
    public String searchPage(HttpServletRequest request, Model model) {
        // 뷰이름을 반환한다.
        return "ggportal/main/search";
    }
}
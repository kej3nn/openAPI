/*
 * @(#)OpenDttypeController.java 1.0 2015/06/01
 *
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.admin.dtfile.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.admin.dtfile.service.OpenDttypeService;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;

/**
 * 데이터 유형을 관리하는 컨트롤러 클래스이다.
 *
 * @author 김은삼
 * @version 1.0 2015/06/01
 */
@Controller("openDttypeController")
public class OpenDttypeController extends BaseController {
    /**
     * 데이터 유형을 관리하는 서비스
     */
    @Resource(name = "openDttypeService")
    protected OpenDttypeService openDttypeService;

    /**
     * 데이터 유형을 관리하는 화면으로 이동한다.
     *
     * @param request HTTP 요청
     * @return 뷰이름
     */
    @RequestMapping("/admin/dtfile/manageOpenDttypePage.do")
    public String manageOpenDttypePage(HttpServletRequest request, Model model) {
        // 뷰이름을 반환한다.
        return "admin/dtfile/manageOpenDttype";
    }

    /**
     * 데이터 유형을 검색한다.
     *
     * @param request HTTP 요청
     * @param model   모델
     * @return 뷰이름
     */
    @RequestMapping("/admin/dtfile/searchOpenDttype.do")
    public String searchOpenDttype(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);

        // 데이터 유형을 검색한다.
        Object result = openDttypeService.searchOpenDttype(params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 데이터 유형 옵션을 검색한다.
     *
     * @param request HTTP 요청
     * @param model   모델
     * @return 뷰이름
     */
    @RequestMapping("/admin/dtfile/searchOpenDttypeOpt.do")
    public String searchOpenDttypeOpt(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);

        // 데이터 유형 옵션을 검색한다.
        Object result = openDttypeService.searchOpenDttypeOpt(params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 데이터 유형을 저장한다.
     *
     * @param request HTTP 요청
     * @param model   모델
     * @return 뷰이름
     */
    @RequestMapping("/admin/dtfile/saveOpenDttype.do")
    public String saveOpenDttype(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);

        // 데이터 유형을 저장한다.
        Object result = openDttypeService.saveOpenDttype(params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }
}
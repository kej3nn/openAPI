/*
 * @(#)PortalUserKeyController.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.user.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

import egovframework.common.base.controller.BaseController;
import egovframework.ggportal.user.service.PortalUserKeyService;

/**
 * 사용자 인증키를 관리하는 컨트롤러 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Controller("ggportalUserKeyController")
public class PortalUserKeyController extends BaseController {
    /**
     * 사용자 인증키를 관리하는 서비스
     */
    @Resource(name="ggportalUserKeyService")
    private PortalUserKeyService portalUserKeyService;
}
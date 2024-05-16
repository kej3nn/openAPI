/*
 * @(#)GlobalConstants.java 1.0 2015/06/01
 *
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.common.base.constants;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.common.util.UtilString;

/**
 * 전역 상수 클래스이다.
 *
 * @author 김은삼
 * @version 1.0 2015/06/01
 */
public class GlobalConstants extends BaseConstants {
    /**
     * 시리얼 버전 아이디
     */
    private static final long serialVersionUID = 1L;

    /**
     * 라인 피드
     */
    public static final String LINE_FEED = "\n";

    /**
     * 시트 페이지 크기
     */
    public static final int IBSHEET_ROWS = 100;

    /**
     * 시스템 어플 타입
     */
    public static final String SYSTEM_APP_TYPE = UtilString.null2Blank(EgovProperties.getProperty("Globals.AppType"));

    /**
     * 어플리케이션 권한(공백일경우 포털, 어드민 전부사용 / 포털사용 : P / 어드민만 사용 : A)
     */
    public static final String SYSTEM_APP_AUTH = UtilString.null2Blank(EgovProperties.getProperty("Globals.AppAuth"));

    /**
     * 시스템 관리자 데이터 입력 권한 구분(ORG : 부서코드 / USR : 유저별)
     */
    public static final String SYSTEM_INPUT_GBN = "ORG";
}
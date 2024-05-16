/*
 * @(#)RequestAttribute.java 1.0 2015/06/01
 *
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.common.base.constants;

/**
 * HTTP 요청 속성 상수 클래스이다.
 *
 * @author 김은삼
 * @version 1.0 2015/06/01
 */
public class RequestAttribute extends BaseConstants {
    /**
     * 시리얼 버전 아이디
     */
    private static final long serialVersionUID = 1L;

    /**
     * 로케일
     */
    public static final String LOCALE = "locale";

    /**
     * 아이피
     */
    public static final String USER_IP = "userIp";

    /**
     * 시스템 태그
     */
    public static final String SYSTEM_TAG = "systemTag";

    /**
     * 사용자 에이전트
     */
    public static final String USER_AGENT = "user-agent";

    /**
     * 시트 사용자 에이전트
     */
    public static final String SHEET_USER_AGENT = "ibuseragent";

    /**
     * 제이쿼리 AJAX 헤더
     */
    public static final String JQUERY_AJAX_HEADER = "X-Requested-With";

    /**
     * 응답 유형
     */
    public static final String RESPONSE_TYPE = "responseType";

    /**
     * URI
     */
    public static final String URI = "uri";

    /**
     * 액션
     */
    public static final String ACTION = "action";

    /**
     * 쿼리 이름
     */
    public static final String QUERY_NAMES = "queryNames";

    /**
     * 쿼리 문자열
     */
    public static final String QUERY_STRING = "queryString";

    /**
     * 메뉴
     */
    public static final String MENU = "menu";

    /**
     * 서브 메뉴
     */
    public static final String MENUS = "menus";

    /**
     * 폐기 요청 형식
     */
    public static final String REVOKE_TYPE = "revokeType";

    /**
     * 폐기 요청 방식
     */
    public static final String REVOKE_METHOD = "revokeMethod";

    /**
     * 폐기 요청 URL
     */
    public static final String REVOKE_URL = "revokeUrl";

    /**
     * 폐기 요청 인자
     */
    public static final String REVOKE_ARGS = "revokeArgs";

    /**
     * 시스템 앱 타입
     */
    public static final String APP_TYPE = "systemAppType";

    /**
     * 포털 메뉴 목록
     */
    public static final String MENU_LST = "menuLst";

    /**
     * 디폴트 생성자이다.
     */
    public RequestAttribute() {
        super();
    }
}
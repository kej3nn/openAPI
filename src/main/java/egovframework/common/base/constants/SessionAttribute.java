/*
 * @(#)SessionAttribute.java 1.0 2015/06/01
 *
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.common.base.constants;

/**
 * HTTP 세션 속성 상수 클래스이다.
 *
 * @author 김은삼
 * @version 1.0 2015/06/01
 */
public class SessionAttribute extends BaseConstants {
    /**
     * 시리얼 버전 아이디
     */
    private static final long serialVersionUID = 1L;

    /**
     * 사용자
     */
    public static final String USER = "PortalLoginVO";

    /**
     * 사용자 코드
     */
    public static final String USER_CD = "portalUserCd";

    /**
     * 사용자 아이디
     */
    public static final String USER_ID = "portalUserId";

    /**
     * 사용자 이름
     */
    public static final String USER_NM = "portalUserNm";

    /**
     * 사용자 이메일
     */
    public static final String USER_EMAIL = "portalUserEmail";

    /**
     * 사용자 연락처
     */
    public static final String USER_TEL = "portalUserTel";

    /**
     * 이용약관 동의여부
     */
    public static final String AGREE_YN = "portalAgreeYn";

    /**
     * 기관명
     */
    public static final String ORG_NAME = "portalOrgName";

    /**
     * 기관코드
     */
    public static final String ORG_CODE = "portalOrgCode";

    /**
     * 부서코드
     */
    public static final String DEPT_CODE = "portalDeptCode";

    /**
     * 접속 계정 코드
     */
    public static final String CONT_SITE_CD = "portalContSiteCd";

    /**
     * 접속 계정 이름
     */
    public static final String CONT_SITE_NM = "portalContSiteNm";

    /**
     * 서비스 제공자
     */
    public static final String PROVIDER_NAME = "portalProviderName";

    /**
     * 상태 토큰
     */
    public static final String STATE = "state";

    /**
     * 트위터
     */
    public static final String TWITTER = "twitter";

    /**
     * 요청 토큰
     */
    public static final String REQUEST_TOKEN = "requestToken";

    /**
     * 게시판 사용자 비밀번호
     */
    public static final String BBS_USER_PW = "bbsUserPw";

    /**
     * 관리자여부
     */
    public static final String IS_ADMIN = "PortalIsAdmin";

    /**
     * 디폴트 생성자이다.
     */
    public SessionAttribute() {
        super();
    }
}
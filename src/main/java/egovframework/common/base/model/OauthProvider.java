/*
 * @(#)OauthProvider.java 1.0 2015/06/15
 *
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.common.base.model;

import java.util.ArrayList;
import java.util.List;

/**
 * 인증 제공자 모델 클래스이다.
 *
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
public class OauthProvider extends BaseModel {
    /**
     * 시리얼 버전 아이디
     */
    private static final long serialVersionUID = 1L;

    /**
     * 네이버
     */
    public static final String NAVER = "Naver";

    /**
     * 다음
     */
    public static final String DAUM = "Daum";

    /**
     * 카카오
     */
    public static final String KAKAO = "Kakao";

    /**
     * 구글
     */
    public static final String GOOGLE = "Google";

    /**
     * 페이스북
     */
    public static final String FACEBOOK = "Facebook";

    /**
     * 트위터
     */
    public static final String TWITTER = "Twitter";

    /**
     * 헤더 리소스 요청 형식
     */
    public static final String REQUEST_TYPE_HEADER = "header";

    /**
     * 쿼리 리소스 요청 형식
     */
    public static final String REQUEST_TYPE_QUERY = "query";

    /**
     * 바디 리소스 요청 형식
     */
    public static final String REQUEST_TYPE_BODY = "body";

    /**
     * 헤더 폐기 요청 형식
     */
    public static final String REVOKE_TYPE_HEADER = "header";

    /**
     * 쿼리 폐기 요청 형식
     */
    public static final String REVOKE_TYPE_QUERY = "query";

    /**
     * RESTful 폐기 요청 형식
     */
    public static final String REVOKE_TYPE_RESTFUL = "restful";

    /**
     * 스크립트 폐기 요청 형식
     */
    public static final String REVOKE_TYPE_SCRIPT = "script";

    /**
     * 제공자 이름
     */
    public static final String PROVIDER_CODE = "ProviderCode";

    /**
     * 제공자 이름
     */
    public static final String PROVIDER_NAME = "ProviderName";

    /**
     * 제공자 설명
     */
    public static final String PROVIDER_DESC = "ProviderDesc";

    /**
     * 인증 엔드포인트
     */
    public static final String AUTH_ENDPOINT = "AuthEndpoint";

    /**
     * 접근 토큰 엔드포인트
     */
    public static final String TOKEN_ENDPOINT = "TokenEndpoint";

    /**
     * 클라이언트 아이디
     */
    public static final String CLIENT_ID = "ClientId";

    /**
     * 클라이언트 시크릿 필수 여부
     */
    public static final String SECRET_REQUIRED = "SecretRequired";

    /**
     * 클라이언트 시크릿
     */
    public static final String CLIENT_SECRET = "ClientSecret";

    /**
     * 리다이렉트 경로
     */
    public static final String REDIRECT_URI = "RedirectUri";

    /**
     * 서비스 범위 필수 여부
     */
    public static final String SCOPE_REQUIRED = "ScopeRequired";

    /**
     * 서비스 범위
     */
    public static final String SCOPE = "Scope";

    /**
     * 상태 토큰 필수 여부
     */
    public static final String STATE_REQUIRED = "StateRequired";

    /**
     * 리소스 요청 형식
     */
    public static final String REQUEST_TYPE = "RequestType";

    /**
     * 리소스 요청 방식
     */
    public static final String REQUEST_METHOD = "RequestMethod";

    /**
     * 사용자 프로파일 URL
     */
    public static final String PROFILE_URL = "ProfileUrl";

    /**
     * 폐기 요청 형식
     */
    public static final String REVOKE_TYPE = "RevokeType";

    /**
     * 폐기 요청 방식
     */
    public static final String REVOKE_METHOD = "RevokeMethod";

    /**
     * 폐기 요청 URL
     */
    public static final String REVOKE_URL = "RevokeUrl";

    /**
     * 폐기 요청 인자
     */
    public static final String REVOKE_ARGS = "RevokeArgs";

    /**
     * 서비스 제공자 이름
     */
    public static final List<String> providerNames = new ArrayList<String>();

    /*
     * 클래스 변수를 초기화한다.
     */
    static {
        // 서비스 제공자 이름
        providerNames.add(NAVER);
        providerNames.add(DAUM);
        providerNames.add(KAKAO);
        providerNames.add(GOOGLE);
        providerNames.add(FACEBOOK);
        providerNames.add(TWITTER);
    }

    /**
     * 디폴트 생성자이다.
     */
    public OauthProvider() {
        super();
    }

    /**
     * 제공자 코드를 반환한다.
     *
     * @return 제공자 코드
     */
    public String getProviderCode() {
        return getString(PROVIDER_CODE);
    }

    /**
     * 제공자 이름을 반환한다.
     *
     * @return 제공자 이름
     */
    public String getProviderName() {
        return getString(PROVIDER_NAME);
    }

    /**
     * 제공자 설명을 반환한다.
     *
     * @return 제공자 설명
     */
    public String getProviderDesc() {
        return getString(PROVIDER_DESC);
    }

    /**
     * 인증 엔드포인트를 반환한다.
     *
     * @return 인증 엔드포인트
     */
    public String getAuthEndpoint() {
        return getString(AUTH_ENDPOINT);
    }

    /**
     * 접근 토큰 엔드포인트를 반환한다.
     *
     * @return 접근 토큰 엔드포인트
     */
    public String getTokenEndpoint() {
        return getString(TOKEN_ENDPOINT);
    }

    /**
     * 클라이언트 아이디를 반환한다.
     *
     * @return 클라이언트 아이디
     */
    public String getClientId() {
        return getString(CLIENT_ID);
    }

    /**
     * 클라이언트 시크릿 필수 여부를 반환한다.
     *
     * @return 클라이언트 시크릿 필수 여부
     */
    public boolean getSecretRequired() {
        return getBoolean(SECRET_REQUIRED);
    }

    /**
     * 클라이언트 시크릿을 반환한다.
     *
     * @return 클라이언트 시크릿
     */
    public String getClientSecret() {
        return getString(CLIENT_SECRET);
    }

    /**
     * 리다이렉트 경로를 반환한다.
     *
     * @return 리다이렉트 경로
     */
    public String getRedirectUri() {
        return getString(REDIRECT_URI);
    }

    /**
     * 서비스 범위 필수 여부를 반환한다.
     *
     * @return 서비스 범위 필수 여부
     */
    public boolean getScopeRequired() {
        return getBoolean(SCOPE_REQUIRED);
    }

    /**
     * 서비스 범위를 반환한다.
     *
     * @return 서비스 범위
     */
    public String getScope() {
        return getString(SCOPE);
    }

    /**
     * 상태 토큰 필수 여부를 반환한다.
     *
     * @return 상태 토큰 필수 여부
     */
    public boolean getStateRequired() {
        return getBoolean(STATE_REQUIRED);
    }

    /**
     * 리소스 요청 형식을 반환한다.
     *
     * @return 리소스 요청 형식
     */
    public String getRequestType() {
        return getString(REQUEST_TYPE);
    }

    /**
     * 리소스 요청 방식을 반환한다.
     *
     * @return 리소스 요청 방식
     */
    public String getRequestMethod() {
        return getString(REQUEST_METHOD);
    }

    /**
     * 사용자 프로파일 URL을 반환한다.
     *
     * @return 사용자 프로파일 URL
     */
    public String getProfileUrl() {
        return getString(PROFILE_URL);
    }

    /**
     * 폐기 요청 형식을 반환한다.
     *
     * @return 폐기 요청 형식
     */
    public String getRevokeType() {
        return getString(REVOKE_TYPE);
    }

    /**
     * 폐기 요청 방식을 반환한다.
     *
     * @return 폐기 요청 방식
     */
    public String getRevokeMethod() {
        return getString(REVOKE_METHOD);
    }

    /**
     * 폐기 요청 URL을 반환한다.
     *
     * @return 폐기 요청 URL
     */
    public String getRevokeUrl() {
        return getString(REVOKE_URL);
    }

    /**
     * 폐기 요청 인자를 반환한다.
     *
     * @return 폐기 요청 인자
     */
    public String getRevokeArgs() {
        return getString(REVOKE_ARGS);
    }
}
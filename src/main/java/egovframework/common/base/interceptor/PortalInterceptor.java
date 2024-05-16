/*
 * @(#)PortalInterceptor.java 1.0 2015/06/01
 *
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.common.base.interceptor;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.dao.DataAccessException;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.constants.GlobalConstants;
import egovframework.common.base.constants.RequestAttribute;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.ggportal.menu.service.PortalSiteMenuService;

/**
 * 포털 인터셉터 클래스이다.
 *
 * @author 김은삼
 * @version 1.0 2015/06/01
 */
public class PortalInterceptor extends BaseInterceptor {
    /**
     * 포털 액션 접두어
     */
    private static final String ACTION_PREFIX_PORTAL = "/portal";

    /**
     * 다운로드 액션 접두어
     */
    private static final String ACTION_PREFIX_DOWNLOAD = "/download";

    /**
     * 뷰 액션 접미어
     */
    private static final String ACTION_SUFFIX_VIEW = "Page.do";

    /**
     * 사용자 인증 액션 접미어
     */
    private static final String ACTION_SUFFIX_AUTHORIZE = "authorizePage.do";

    /**
     * 사용자 등록 액션 접미어
     */
    private static final String ACTION_SUFFIX_REGISTER = "registerPage.do";

    /**
     * 액션 파라메터 이름
     */
    private static final String PARAMETER_NAME_ACTION = "ACTION";

    /**
     * 예외 액션 이름
     */
    private static final String[] extraActionNames = new String[]{
            "banner.do",
            "authorize.do",
            "redirect.do",
            "logout.do",
            "selectAttachFile.do",
            "selectThumbnail.do",
            "selectFileData.do",
            "selectLinkData.do",
            "selectLinkTmnl.do",
            "selectMultimediaData.do"
    };

    /**
     * 예외 VIEW PAGE URL
     */
    private static final String[] extraViewUrls = new String[]{
            "/portal/doc/docInfPage.do",
            "/portal/data/service/selectServicePage.do",
            "/portal/data/service/selectAPIServicePage.do",
            "/portal/stat/selectServicePage.do"
    };


    /**
     * 모바일 시스템 태그
     */
    private static final String SYSTEM_TAG_MOBILE = "mobile";

    /**
     * 외국어 시스템 태그
     */
    private static final String SYSTEM_TAG_OTHERS = "others";

    /**
     * 시스템 태그
     */
    private static final Map<String, String> systemTags = new HashMap<String, String>();

    /**
     * 로컬 호스트
     */
    private static final Map<String, String> localhost = new HashMap<String, String>();

    /*
     * 클래스 변수를 초기화한다.
     */
    static {
        // 시스템 태그
        systemTags.put(SYSTEM_TAG_MOBILE, "M");
        systemTags.put("ko_KR", "K");
        systemTags.put("ko", "K");
//        systemTags.put(SYSTEM_TAG_OTHERS, "E");
        systemTags.put(SYSTEM_TAG_OTHERS, "K");

        // 로컬 호스트
        localhost.put("::1", "127.0.0.1");
        localhost.put("0:0:0:0:0:0:0:1", "127.0.0.1");
    }

    /**
     * 사이트 메뉴를 관리하는 서비스
     */
    @Resource(name = "ggportalSiteMenuService")
    private PortalSiteMenuService portalSiteMenuService;

    /**
     * 디폴트 생성자이다.
     */
    public PortalInterceptor() {
        super();
    }

    /**
     * 속성정보를 설정한다.
     *
     * @param request HTTP 요청
     */
    private void setAttribute(HttpServletRequest request) {
        // HTTP 요청 속성정보를 설정한다.
        setRequestAttribute(request);

        // XML로 정의된 메뉴를 파싱한다.
        parseMenuList(request);
    }

    /**
     * XML로 정의된 메뉴를 파싱한다.
     *
     * @param request
     */
    private void parseMenuList(HttpServletRequest request) {
        request.setAttribute(RequestAttribute.MENU_LST, portalSiteMenuService.parseSiteMenu(new Params()));
    }

    /**
     * HTTP 요청 속성정보를 설정한다.
     *
     * @param request HTTP 요청
     */
    private void setRequestAttribute(HttpServletRequest request) {
        String context = request.getContextPath();
        String uri = request.getRequestURI();

        // 컨텍스트 경로가 루트가 아닌 경우
        if (!"".equals(context)) {
            uri = uri.substring(context.length());
        }

        int index = uri.indexOf(";jsessionid=");

        // 세션 아이디가 있는 경우
        if (index >= 0) {
            uri = uri.substring(0, index);
        }

        // 헤더 속성정보를 설정한다.
        setHeaderAttribute(request, RequestAttribute.USER_AGENT);
        setHeaderAttribute(request, RequestAttribute.SHEET_USER_AGENT);
        setHeaderAttribute(request, RequestAttribute.JQUERY_AJAX_HEADER);

        // 포털 액션인 경우
        if (uri.startsWith(ACTION_PREFIX_PORTAL)) {
            request.setAttribute(RequestAttribute.URI, uri);
            request.setAttribute(RequestAttribute.LOCALE, getLocale(request));
            request.setAttribute(RequestAttribute.USER_IP, getUserIp(request));
            request.setAttribute(RequestAttribute.SYSTEM_TAG, getSystemTag(request));
            request.setAttribute(RequestAttribute.RESPONSE_TYPE, getResponseType(request));
            request.setAttribute(RequestAttribute.APP_TYPE, GlobalConstants.SYSTEM_APP_TYPE);

            // 뷰 액션인 경우
            if (uri.endsWith(ACTION_SUFFIX_VIEW)) {
                // 사용자 인증 액션 또는 사용자 등록 액션인 경우
                if (uri.endsWith(ACTION_SUFFIX_AUTHORIZE) || uri.endsWith(ACTION_SUFFIX_REGISTER)) {
                    // 액션 속성이 없는 경우
                    if (request.getAttribute(RequestAttribute.ACTION) == null) {
                        // 액션 파라메터가 없는 경우
                        if (request.getParameter(PARAMETER_NAME_ACTION) == null) {
                            request.setAttribute(RequestAttribute.ACTION, "/");
                        }
                        // 액션 파라메터가 있는 경우
                        else {
                            request.setAttribute(RequestAttribute.ACTION, request.getParameter(PARAMETER_NAME_ACTION));
                        }
                    }
                }
                // 사용자 인증 액션 또는 사용자 등록 액션이 아닌 경우
                else {
                    request.setAttribute(RequestAttribute.ACTION, uri);

                    String query = request.getQueryString();

                    if (query != null) {
                        String[] tokens = query.split("&");

                        List<String> names = new ArrayList<String>();

                        for (int i = 0; i < tokens.length; i++) {
                            names.add(tokens[i].split("=")[0]);
                        }

                        request.setAttribute(RequestAttribute.QUERY_NAMES, names);
                        request.setAttribute(RequestAttribute.QUERY_STRING, query);
                    }
                }

                // XML로 정의된 메뉴를 파싱한다.
                parseMenuList(request);

                // 메뉴 속성정보를 설정한다.
                setMenuAttribute(request);
            }
            // URL이 예외페이지 인지 체크한다.
            else if (checkExtraViewUrl(request, uri)) {

                // XML로 정의된 메뉴를 파싱한다.
                parseMenuList(request);

                // 메뉴 속성정보를 설정한다.
                setMenuAttribute(request);
            }
        }
    }

    /**
     * URL이 예외페이지 인지 체크한다.
     * 바로가기 할 경우 (xxx.do/ID) 로 넘어가면 URL 조회불가하여 조치
     */
    private boolean checkExtraViewUrl(HttpServletRequest request, String uri) {
        boolean result = false;
        for (int i = 0; i < extraViewUrls.length; i++) {
            if (uri.indexOf(extraViewUrls[i]) >= 0) {
                result = true;
                request.setAttribute(RequestAttribute.URI, extraViewUrls[i]);    // URI 다시 세팅
                break;
            }
        }

        return result;
    }

    /**
     * 헤더 속성정보를 설정한다.
     *
     * @param request HTTP 요청
     * @param key     키
     */
    private void setHeaderAttribute(HttpServletRequest request, String key) {
        String value = request.getHeader(key);

        if (value != null) {
            request.setAttribute(key, value);
        }
    }

    /**
     * 로케일을 반환한다.
     *
     * @param request HTTP 요청
     * @return 로케일
     */
    private String getLocale(HttpServletRequest request) {
        return egovMessageSource.getSessionLocaleResolver().resolveLocale(request).toString();
    }

    /**
     * 사용자 아이피를 반환한다.
     *
     * @param request HTTP 요청
     * @return 사용자 아이피
     */
    private String getUserIp(HttpServletRequest request) {
        String ip = request.getRemoteAddr();

        if (localhost.containsKey(ip)) {
            return localhost.get(ip);
        } else {
            return ip;
        }
    }

    /**
     * 시스템 태그를 반환한다.
     *
     * @param request HTTP 요청
     * @return 시스템 태그
     */
    private String getSystemTag(HttpServletRequest request) {
        String[] patterns = new String[]{
                ".*(iPhone|iPod|Android|Windows CE|BlackBerry|Symbian|Windows Phone|webOs|Opera Mini|Opera Mobi|POLARIS|IEMobile|lgtelecom|nokis|SynyEricsson).*",
                ".*(LG|SAMSUNG|Samsung).*"
        };

        // 사용자 에이전트를 가져온다.
        String agent = (String) request.getAttribute(RequestAttribute.USER_AGENT);

        if (StringUtils.isNotEmpty(agent)) {
            for (int i = 0; i < patterns.length; i++) {
                if (agent.matches(patterns[i])) {
                    return systemTags.get(SYSTEM_TAG_MOBILE);
                }
            }
        }

        // 로케일을 가져온다.
        String locale = (String) request.getAttribute(RequestAttribute.LOCALE);

        if (StringUtils.isNotEmpty(locale) && systemTags.containsKey(locale)) {
            return systemTags.get(locale);
        }

        return systemTags.get(SYSTEM_TAG_OTHERS);
    }

    /**
     * 응답 유형을 반환한다.
     *
     * @param request HTTP 요청
     * @return 응답 유형
     */
    private String getResponseType(HttpServletRequest request) {
        String uri = (String) request.getAttribute(RequestAttribute.URI);

        String type = "json";

        if (uri.endsWith(ACTION_SUFFIX_VIEW)) {
            type = "html";
        } else if (uri.indexOf(ACTION_PREFIX_DOWNLOAD) >= 0) {
            type = "html";
        } else {
            for (int i = 0; i < extraActionNames.length; i++) {
                if (uri.indexOf(extraActionNames[i]) >= 0) {
                    type = "html";
                    break;
                }
            }
        }

        return type;
    }

    /**
     * 메뉴 속성정보를 설정한다.
     *
     * @param request HTTP 요청
     */
    private void setMenuAttribute(HttpServletRequest request) {
        // 파라메터를 가져온다.
        Params params = new Params();
        try {
            params.put("sysTag", request.getAttribute(RequestAttribute.SYSTEM_TAG));
            params.put("userIp", request.getAttribute(RequestAttribute.USER_IP));
            params.put("menuUrl", request.getAttribute(RequestAttribute.URI));

            // 사이트 메뉴를 조회한다.
            Record menu = portalSiteMenuService.selectSiteMenuCUD(params);

            if (menu != null) {

                params.put("lvl1MenuPath", menu.getString("lvl1MenuPath"));

                // 사이트 메뉴를 검색한다.
                //List<?> menus = portalSiteMenuService.searchSiteMenu(params);

                //request.setAttribute(RequestAttribute.MENUS, menus);
                request.setAttribute(RequestAttribute.MENU, menu);
            } else {
                throw new ServiceException("portal.error.000003", getMessage("portal.error.000003"));
            }
        } catch (DataAccessException dae) {
            EgovWebUtil.exLogging(dae);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
            throw new ServiceException("portal.error.000003", getMessage("portal.error.000003"));
        }
    }

    /*
     * (non-Javadoc)
     * @see org.springframework.web.servlet.handler.HandlerInterceptorAdapter#preHandle(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, java.lang.Object)
     */
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        // 속성정보를 설정한다.
        setAttribute(request);

        return true;
    }
}
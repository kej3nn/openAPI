package egovframework.com.cmm.interceptor;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import egovframework.admin.basicinf.service.CommUsr;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.common.base.constants.GlobalConstants;
import egovframework.ggportal.user.web.PortalUserController;

/**
 * 인증여부 체크 인터셉터
 *
 * @author 공통서비스 개발팀 서준식
 * @version 1.0
 * @see <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2011.07.01  서준식          최초 생성
 *  2011.09.07  서준식          인증이 필요없는 URL을 패스하는 로직 추가
 * </pre>
 * @since 2011.07.01
 */

public class AuthenticInterceptor extends HandlerInterceptorAdapter {
    protected static final Log logger = LogFactory.getLog(AuthenticInterceptor.class);
	/*
	private Set<String> permittedURL;

	public void setPermittedURL(Set<String> permittedURL) {
		this.permittedURL = permittedURL;
	}*/

    /**
     * 포털 액션 접두어
     */
    private static final String ACTION_PREFIX_PORTAL = "/portal";

    /* 접근 비허용 URL */
    private String[] ACTION_PORTAL_NOT_EXIST_URL = new String[]{
            "/portal/myPage/",
            //"/portal/expose/",
            "/portal/openapi/openApiActKeyPage.do",
            "/portal/openapi/openApiActKeyUsePage.do",
            "/portal/openapi/openApiActKeyIssPage.do",
            "/portal/openapi/openApiActKeyTestPage.do"
            //"/portal/bbs/qna01/insertBulletinPage.do",	// 포털 Q&A 등록페이지
            //"/portal/bbs/qna01/updateBulletinPage.do"	// 포털 Q&A 수정페이지
    };

    /**
     * preHandle
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws ServletException {
        String uri = getUri(request);

        if (uri.startsWith(ACTION_PREFIX_PORTAL)) {
            return checkPortalLogin(request, response);
        } else {
            //return checkAdminLogin(request, response);
            try {
                if (checkAdminLogin(request, response)) {
                    return true;
                } else {
                    ModelAndView modelAndView = new ModelAndView("forward:/portal/user/redirect.do");
                    modelAndView.addObject("errMsg", "관리자 권한이 없는 사용자이거나 잘못된 접근입니다.");
                    throw new ModelAndViewDefiningException(modelAndView);
                }
            } catch (Exception e) {
                ModelAndView modelAndView = new ModelAndView("forward:/portal/user/redirect.do");
                modelAndView.addObject("errMsg", "관리자 권한이 없는 사용자이거나 잘못된 접근입니다.");
                throw new ModelAndViewDefiningException(modelAndView);
            }
        }
    }

    /**
     * 포털 로그인 체크
     *
     * @param request
     * @param response
     * @return
     */
    private boolean checkPortalLogin(HttpServletRequest request, HttpServletResponse response) {
        String uri = getUri(request);

        try {

            if (StringUtils.isNotEmpty(GlobalConstants.SYSTEM_APP_AUTH) && "N".equals(GlobalConstants.SYSTEM_APP_AUTH)) {

                if (EgovUserDetailsHelper.isAuthenticatedPortal()) {
                    // 로그인 되어있을때 로그인페이지 접근불가
                    if (uri.startsWith(PortalUserController.LOGIN_PAGE)) {
                        response.sendRedirect(PortalUserController.MAIN_PAGE);
                    }

                    return true;
                } else {
                    // 허용하지 않는 URL은 접근불가
                    if (getNotExistUri(uri)) {
                        response.sendRedirect(PortalUserController.LOGIN_PAGE);
                        return false;
                    }

                    return true;
                }
            }
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return true;
    }

    /**
     * 관리자 로그인 체크
     *
     * @param request
     * @param response
     * @return
     */
    private boolean checkAdminLogin(HttpServletRequest request, HttpServletResponse response) {

        String uri = getUri(request);

        // 접근 허용 URI
        String[] ADMIN_PASS_URI = new String[]{
                "/admin/user/loginProc.do"
        };

        try {

            if (StringUtils.isNotEmpty(uri) && uri.endsWith(".do")) {

                for (String url : ADMIN_PASS_URI) {
                    if (uri.startsWith(url)) {
                        return true;
                    }
                }

                CommUsr loginVO = (CommUsr) EgovUserDetailsHelper.getAuthenticatedUser();

                if (loginVO != null) {
                    return true;
                } else {
                    return false;
                }

            }

            return true;
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return false;
    }


    /**
     * 현재 URL 획득
     *
     * @param request
     * @return
     */
    private String getUri(HttpServletRequest request) {
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
        return uri;
    }

    /**
     * 포털 접근 허용 제한 URI 체크
     *
     * @param uri
     * @return
     */
    private boolean getNotExistUri(String uri) {
        if (StringUtils.isEmpty(uri)) return false;

        for (String url : ACTION_PORTAL_NOT_EXIST_URL) {
            if (uri.startsWith(url)) {
                return true;
            }
        }

        return false;
    }
}

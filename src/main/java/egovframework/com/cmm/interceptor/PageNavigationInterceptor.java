
package egovframework.com.cmm.interceptor;

import java.util.Enumeration;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import egovframework.admin.basicinf.service.CommMenu;
import egovframework.admin.basicinf.service.CommMenuService;
import egovframework.admin.basicinf.service.CommUsr;
import egovframework.com.cmm.SessionLocaleResolver;
import egovframework.common.util.UtilString;

/**
 * Page Navigation 처리 class
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */
public class PageNavigationInterceptor extends HandlerInterceptorAdapter {

    protected static final Log logger = LogFactory.getLog(PageNavigationInterceptor.class);

    /**
     * 포털 액션 접두어
     */
    private String ACTION_PREFIX_PORTAL = "/portal";

    /**
     * 관리 액션 접두어
     */
    private String ACTION_PREFIX_ADMIN = "/admin";

    /**
     * 뷰 액션 접미어
     */
    private String ACTION_SUFFIX_VIEW = "Page.do";

    @Resource(name = "CommMenuService")
    private CommMenuService commMenuService;

    @Autowired
    private SessionLocaleResolver sessionLocaleResolver;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        //return checkLogin(request, response);
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) {
        /* 포털 LOCALE 설정 */
        setPortalLocale(request, response, modelAndView);

        /* 관리자 메뉴 권한체크 */
        adminMenuAuth(request, response, modelAndView);
    }

    /**
     * 포털 LOCALE 설정
     *
     * @param request
     * @param response
     * @param modelAndView
     */
    private void setPortalLocale(HttpServletRequest request, HttpServletResponse response, ModelAndView modelAndView) {
        String uri = getUri(request);

        if (modelAndView != null && uri.startsWith(ACTION_PREFIX_PORTAL) && uri.endsWith(ACTION_SUFFIX_VIEW)) {
            Locale locale = new Locale("ko", "KR", "");
            response.setLocale(locale);
            sessionLocaleResolver.setLocale(request, response, locale);
        }
    }

    /**
     * 관리자 메뉴 권한체크
     *
     * @param request
     * @param response
     * @param modelAndView
     */
    private void adminMenuAuth(HttpServletRequest request, HttpServletResponse response, ModelAndView modelAndView) {

        String uri = getUri(request);

        if (modelAndView != null && uri.startsWith(ACTION_PREFIX_ADMIN) && uri.endsWith(ACTION_SUFFIX_VIEW)) {
            CommUsr commUsr = new CommUsr();
            HttpSession session = request.getSession();
            CommUsr loginVo = (CommUsr) session.getAttribute("loginVO");


            if (loginVo == null) {
                commUsr.setAccCd("0");
            } else {
                commUsr.setAccCd(UtilString.null2Blank(loginVo.getAccCd()));
            }

            Enumeration param = request.getParameterNames();
            String strParam = "";
            while (param.hasMoreElements()) {
                String name = (String) param.nextElement();

                String value = request.getParameter(name);
                strParam += name + "=" + value + "&";
            }

            commUsr.setMenuUrl(uri);

            if (StringUtils.isNotBlank(strParam)) {
                commUsr.setMenuParam("?" + strParam.substring(0, strParam.length() - 1));
            }

            commUsr.setMenuTop(false);
            List<CommMenu> list = commMenuService.selectCommMenuTop(commUsr);

            if (list.size() > 0) {

                for (CommMenu commMenu : list) {
                    session.setAttribute("menuAcc", (Integer) commMenu.getMenuAcc());
                    modelAndView.addObject("MENU_URL", commMenu.getMenuNav());
                    modelAndView.addObject("MENU_NM", commMenu.getMenuNm());
                }
            }
        }
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

}

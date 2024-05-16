/*
 * @(#)BaseController.java 1.0 2015/06/01
 *
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.common.base.controller;

import java.util.Enumeration;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.ui.Model;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.admin.basicinf.service.CommUsr;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.common.base.component.BaseComponent;
import egovframework.common.base.constants.ModelAttribute;
import egovframework.common.base.constants.RequestAttribute;
import egovframework.common.base.constants.SessionAttribute;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.exception.SessionException;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Result;
import egovframework.common.util.UtilEncryption;
import egovframework.common.util.UtilString;
import egovframework.portal.model.User;
//import nl.captcha.Captcha;

/**
 * 기본 컨트롤러 클래스이다.
 *
 * @author 김은삼
 * @version 1.0 2015/06/01
 */
public class BaseController extends BaseComponent {
    /**
     * 포털 액션 접두어
     */
    private static final String ACTION_PREFIX_PORTAL = "/portal";

    /**
     * 디폴트 생성자이다.
     */
    protected BaseController() {
        super();
    }

    /**
     * 파라메터 이름을 반환한다.
     *
     * @param name 파라메터 이름
     * @return 파라메터 이름
     */
    private String getParameterName(String name) {
        if (name.endsWith("[]")) {
            return name.substring(0, name.lastIndexOf("[]"));
        }

        return name;
    }

    /**
     * 텍스트 파라메터를 반환한다.
     *
     * @param request HTTP 요청
     * @param name    파라메터 이름
     * @return 텍스트 파라메터
     */
    private String[] getTextParameter(HttpServletRequest request, String name) {
        if (StringUtils.isNotEmpty(name) && request.getParameterValues(name) != null) {
            return request.getParameterValues(name);
        } else {
            return new String[0];
        }
    }

    /**
     * 파일 파라메터를 반환한다.
     *
     * @param request HTTP 요청
     * @param name    파라메터 이름
     * @return 파일 파라메터
     */
    private MultipartFile[] getFileParameter(MultipartHttpServletRequest request, String name) {
        Object[] source = request.getFiles(name).toArray();

        MultipartFile[] destination = new MultipartFile[source.length];

        System.arraycopy(source, 0, destination, 0, destination.length);

        return destination;
    }

    /**
     * HTTP 요청을 반환한다.
     *
     * @return HTTP 요청
     */
    protected HttpServletRequest getRequest() {
        return ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
    }

    /**
     * HTTP 세션을 반환한다.
     *
     * @return HTTP 세션
     */
    protected HttpSession getSession() {
        return getSession(getRequest(), true);
    }

    /**
     * HTTP 세션을 반환한다.
     *
     * @param request HTTP 요청
     * @return HTTP 세션
     */
    protected HttpSession getSession(HttpServletRequest request) {
        return getSession(request, true);
    }

    /**
     * HTTP 세션을 반환한다.
     *
     * @param create 생성여부
     * @return HTTP 세션
     */
    protected HttpSession getSession(boolean create) {
        return getSession(getRequest(), create);
    }

    /**
     * HTTP 세션을 반환한다.
     *
     * @param request HTTP 요청
     * @param create  생성여부
     * @return HTTP 세션
     */
    protected HttpSession getSession(HttpServletRequest request, boolean create) {
        return request.getSession(create);
    }

    /**
     * 로케일을 반환한다.
     *
     * @return 로케일
     */
    protected String getLocale() {
        return getLocale(getRequest());
    }

    /**
     * 로케일을 반환한다.
     *
     * @param request HTTP 요청
     * @return 로케일
     */
    protected String getLocale(HttpServletRequest request) {
        return (String) request.getAttribute(RequestAttribute.LOCALE);
    }

    /**
     * 사용자 에이전트를 반환한다.
     *
     * @return 사용자 에이전트
     */
    protected String getUserAgent() {
        return getUserAgent(getRequest());
    }

    /**
     * 사용자 에이전트를 반환한다.
     *
     * @param request HTTP 요청
     * @return 사용자 에이전트
     */
    protected String getUserAgent(HttpServletRequest request) {
        return (String) request.getAttribute(RequestAttribute.USER_AGENT);
    }

    /**
     * 시트 사용자 에이전트를 반환한다.
     *
     * @return 시트 사용자 에이전트
     */
    protected String getSheetUserAgent() {
        return getSheetUserAgent(getRequest());
    }

    /**
     * 시트 사용자 에이전트를 반환한다.
     *
     * @param request HTTP 요청
     * @return 시트 사용자 에이전트
     */
    protected String getSheetUserAgent(HttpServletRequest request) {
        return (String) request.getAttribute(RequestAttribute.SHEET_USER_AGENT);
    }

    /**
     * 시스템 태그를 반환한다.
     *
     * @return 시스템 태그
     */
    protected String getSystemTag() {
        return getSystemTag(getRequest());
    }

    /**
     * 시스템 태그
     *
     * @param request HTTP 요청
     * @return 시스템 태그
     */
    protected String getSystemTag(HttpServletRequest request) {
        return (String) request.getAttribute(RequestAttribute.SYSTEM_TAG);
    }

    /**
     * 브라우저를 반환한다.
     *
     * @return 브라우저
     */
    protected String getBrowser() {
        return getBrowser(getRequest());
    }

    /**
     * 브라우저를 반환한다.
     *
     * @param request HTTP 요청
     * @return 브라우저
     */
    protected String getBrowser(HttpServletRequest request) {
        return request.getHeader("User-Agent");
        //return UtilString.getBrowser(request);
    }

    /**
     * 사용자 아이피를 반환한다.
     *
     * @return 사용자 아이피
     */
    protected String getUserIp() {
        return getUserIp(getRequest());
    }

    /**
     * 사용자 아이피를 반환한다.
     *
     * @param request HTTP 요청
     * @return 사용자 아이피
     */
    protected String getUserIp(HttpServletRequest request) {
        return (String) request.getAttribute(RequestAttribute.USER_IP);
    }

    /**
     * 파마메터를 반환한다.
     *
     * @return 파라메터
     */
    protected Params getParams() {
        return getParams(getRequest(), false);
    }

    /**
     * 파라메터를 반환한다.
     *
     * @param request HTTP 요청
     * @return 파라메터
     */
    protected Params getParams(HttpServletRequest request) {
        return getParams(request, false);
    }

    /**
     * 파라메터를 반환한다.
     *
     * @param session 세션정보
     * @return 파라메터
     */
    protected Params getParams(boolean session) {
        return getParams(getRequest(), session);
    }

    /**
     * 파라메터를 반환한다.
     *
     * @param request HTTP 요청
     * @param session 세션정보
     * @return 파라메터
     */
    protected Params getParams(HttpServletRequest request, boolean session) {
        Params params = new Params();

        // 게시판 패스워드 값을 새로 매핑한다.
        addBbsPasswordMapping(params, request);

        // 텍스트 파라메터를 추가한다.
        addTextParameter(params, request);

        // 정렬 파라메터를 추가한다.
        addSortParameter(params, request);

        if (request instanceof MultipartHttpServletRequest) {
            // 파일 파라메터를 추가한다.
            addFileParameter(params, (MultipartHttpServletRequest) request);
        }

        // 경로 파라메터를 추가한다.
        addPathParameter(params, request);

        // 속성 파라메터를 추가한다.
        addAttrParameter(params, request);

        // 사용자 파라메터를 추가한다. (관리자 session true, 포털 session false로 전달)
        addUserParameter(params, request, session);

        // 세션 파라메터를 추가한다.
        addSessionParameter(params, request);

        return params;
    }

    /**
     * 패킷 보안상 파라미터명(userPw, newUserPw)을 수정한 관계로 새로운 파라미터명으로 받은 후 매핑
     *
     * @param params
     * @param request
     */
    protected void addBbsPasswordMapping(Params params, HttpServletRequest request) {
        String userPw = request.getParameter("bulletIdInfo");
        String newUserPw = request.getParameter("newBulletIdInfo");
//    	CryptString crypt;
        UtilEncryption ue = null;
        if (!UtilString.isBlank(userPw)) {
            try {
//				crypt = new CryptString();
//	    		params.put("userPw", crypt.decryptBase64(userPw));
                ue = new UtilEncryption();
                params.put("userPw", ue.encryptSha256(userPw, userPw.getBytes()));
            } catch (ServiceException sve) {
                EgovWebUtil.exLogging(sve);
            } catch (Exception e) {
                EgovWebUtil.exLogging(e);
            }
        }
        if (!UtilString.isBlank(newUserPw)) {
            try {
//				crypt = new CryptString();
//	    		params.put("newUserPw", crypt.decryptBase64(newUserPw));
                ue = new UtilEncryption();
                params.put("newUserPw", ue.encryptSha256(newUserPw, newUserPw.getBytes()));
            } catch (ServiceException sve) {
                EgovWebUtil.exLogging(sve);
            } catch (Exception e) {
                EgovWebUtil.exLogging(e);
            }
        }
    }

    /**
     * 텍스트 파라메터를 추가한다.
     *
     * @param params  파라메터
     * @param request HTTP 요청
     */
    protected void addTextParameter(Params params, HttpServletRequest request) {
        Enumeration<?> enumeration = request.getParameterNames();

        while (enumeration.hasMoreElements()) {
            String name = (String) enumeration.nextElement();

            params.set(getParameterName(name), getTextParameter(request, name));
        }
    }

    /**
     * 정렬 파라메터를 추가한다.
     *
     * @param params  파라메터
     * @param request HTTP 요청
     */
    protected void addSortParameter(Params params, HttpServletRequest request) {
        if (getSheetUserAgent(request) != null) {
            String value = params.getString(Params.SHEET_ORDERBY);

            if (!"".equals(value)) {
                String[] values = value.split("\\^");

                String[] columns = values[0].split("\\|");
                String[] directions = values[1].split("\\|");

                StringBuffer buffer = new StringBuffer();

                for (int i = 0; i < columns.length; i++) {
                    if (buffer.length() > 0) {
                        buffer.append(",");
                        buffer.append(System.getProperty("line.separator"));
                    }

                    // buffer.append(columns[i].replaceAll("([^_A-Z])([A-Z])", "$1_$2").toUpperCase());
                    buffer.append("\"" + columns[i].replaceAll("[^_0-9a-zA-Z]", "") + "\"");
                    buffer.append(" ");
                    buffer.append(directions[i].replaceAll("[^a-zA-Z]", "").toUpperCase());
                }

                params.put(Params.SHEET_ORDERBY, buffer.toString());
            }
        }
    }

    /**
     * 파일 파라메터를 추가한다.
     *
     * @param params  파라메터
     * @param request HTTP 요청
     */
    protected void addFileParameter(Params params, MultipartHttpServletRequest request) {
        Iterator<String> iterator = request.getFileNames();

        while (iterator.hasNext()) {
            String name = iterator.next();

            params.set(getParameterName(name), getFileParameter(request, name));
        }
    }

    /**
     * 경로 파라메터를 추가한다.
     *
     * @param params  파라메터
     * @param request HTTP 요청
     */
    protected void addPathParameter(Params params, HttpServletRequest request) {
        // Nothing to do.
    }

    /**
     * 속성 파라메터를 추가한다.
     *
     * @param params  파라메터
     * @param request HTTP 요청
     */
    protected void addAttrParameter(Params params, HttpServletRequest request) {
        params.put(Params.LOCALE, getLocale(request));
        params.put(Params.USER_IP, getUserIp(request));
        params.put(Params.USER_AGENT, getBrowser(request));
        params.put(Params.SYSTEM_TAG, getSystemTag(request));
    }

    /**
     * 사용자 파라메터를 추가한다.
     *
     * @param params  파라메터
     * @param request HTTP 요청
     * @param session 세션정보
     */
    protected void addUserParameter(Params params, HttpServletRequest request, boolean session) {
        try {
            String context = request.getContextPath();
            String action = request.getRequestURI();

            // 컨텍스트 경로가 루트가 아닌 경우
            if (!"".equals(context)) {
                action = action.substring(context.length());
            }

            if (action.startsWith(ACTION_PREFIX_PORTAL)) {
                if (EgovUserDetailsHelper.isAuthenticatedPortal()) {
                    User user = (User) EgovUserDetailsHelper.getAuthenticatedUserPortal();

                    // 이용약관에 동의하지 않은 경우
	                /*
	                if (!"Y".equals(user.getAgreeYn())) {
	                    if (session) {
	                        throw new SessionException("portal.error.000051", getMessage("portal.error.000051"));
	                    }
	                }*/

                    params.put(Params.USER_CD, user.getUserCd());
                    params.put(Params.USER_ID, user.getUserId());

                    if (!params.containsKey(Params.USER_NM)) {
                        params.put(Params.USER_NM, user.getUserNm());
                    }

                    params.put(Params.REG_ID, user.getUserCd());
                    params.put(Params.UPD_ID, user.getUserCd());
                } else {
                    if (session) {
                        throw new SessionException("portal.error.000004", getMessage("portal.error.000004"));
                    }
                }
            } else {
                if (EgovUserDetailsHelper.isAuthenticated()) {
                    CommUsr user = (CommUsr) EgovUserDetailsHelper.getAuthenticatedUser();

                    params.put("usrCd", user.getUsrCd());
                    params.put("usrId", user.getUsrId());
                    params.put("usrNm", user.getUsrNm());
                    params.put("regId", user.getUsrCd());
                    params.put("updId", user.getUsrCd());
                } else {
                    if (session) {
                        throw new SessionException("portal.error.000004", getMessage("portal.error.000004"));
                    }
                }
            }
        } catch (SessionException se) {
            EgovWebUtil.exLogging(se);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
    }

    /**
     * 세션 파라메터를 추가한다.
     *
     * @param params  파라메터
     * @param request HTTP 요청
     */
    protected void addSessionParameter(Params params, HttpServletRequest request) {
        HttpSession session = getSession(request);
        /*
        Captcha captcha = (Captcha) session.getAttribute(Captcha.NAME);
        
        if (captcha != null) {
            params.put(Params.CAPTCHA, captcha);
        }*/

        String password = (String) session.getAttribute(SessionAttribute.BBS_USER_PW);

        if (password != null) {
            if (!params.containsKey("userPw")) {
                params.put("userPw", password);
            }
        }
    }

    /**
     * 모델에 객체를 추가한다.
     *
     * @param model  모델
     * @param object 객체
     */
    protected void addObject(Model model, Object object) {
        if (object instanceof Result) {
            addResult(model, (Result) object);
        } else {
            addData(model, object);
        }
    }

    /**
     * 모델에 데이터를 추가한다.
     *
     * @param model 모델
     * @param data  데이터
     */
    protected void addData(Model model, Object data) {
        if (getSheetUserAgent() == null) {
            if (data instanceof Paging) {
                Paging paging = (Paging) data;

                model.addAttribute(ModelAttribute.PAGE, paging.getPage());
                model.addAttribute(ModelAttribute.ROWS, paging.getRows());
                model.addAttribute(ModelAttribute.DATA, paging.getData());
                model.addAttribute(ModelAttribute.COUNT, paging.getCount());
                model.addAttribute(ModelAttribute.TOTAL, paging.getTotal());
                model.addAttribute(ModelAttribute.PAGES, paging.getPages());
            } else {
                model.addAttribute(ModelAttribute.DATA, data);
            }
        } else {
            if (data instanceof Paging) {
                Paging paging = (Paging) data;

                model.addAttribute(ModelAttribute.SHEET_DATA, paging.getSheetData());
                model.addAttribute(ModelAttribute.SHEET_TOTAL, paging.getSheetTotal());
                model.addAttribute(ModelAttribute.SHEET_ETC, paging.getSheetEtc());
                model.addAttribute(ModelAttribute.SHEET_MESSAGE, paging.getSheetMessage());
                model.addAttribute(ModelAttribute.SHEET_RESULT, paging.getSheetResult());
            } else {
                model.addAttribute(ModelAttribute.SHEET_DATA, data);
            }
        }
    }

    /**
     * 모델에 결과를 추가한다.
     *
     * @param model  모델
     * @param result 결과
     */
    protected void addResult(Model model, Result result) {
        if (getSheetUserAgent() == null) {
            if (result.getSuccess()) {
                model.addAttribute(ModelAttribute.SUCCESS, result.getMessages());
            } else {
                model.addAttribute(ModelAttribute.ERROR, result.getMessages());
            }
        } else {
            model.addAttribute(ModelAttribute.SHEET_RESULT, result.getSheetResult());
            model.addAttribute(ModelAttribute.SHEET_ETC, result.getSheetEtc());
        }
    }
}
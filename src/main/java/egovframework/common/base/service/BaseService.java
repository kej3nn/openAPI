/*
 * @(#)BaseService.java 1.0 2015/06/01
 *
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.common.base.service;

import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.log4j.Logger;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.common.base.model.Messages;
import egovframework.common.base.model.Result;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * 기본 서비스 클래스이다.
 *
 * @author 김은삼
 * @version 1.0 2015/06/01
 */
public class BaseService extends AbstractServiceImpl {
    /**
     * 로그
     */
    protected Log log;

    /**
     * 메시지
     */
    @Resource(name = "egovMessageSource")
    protected EgovMessageSource egovMessageSource;

    /**
     * 디폴트 생성자이다.
     */
    protected BaseService() {
        super();

        // 로그를 생성한다.
        log = LogFactory.getLog(this.getClass());
    }

    /**
     * 로그를 기록한다.
     *
     * @param message 메시지
     */
    protected void trace(Object message) {
        if (log.isTraceEnabled()) {
            log.trace(message);
        }
    }

    /**
     * 로그를 기록한다.
     *
     * @param message   메시지
     * @param throwable 발생오류
     */
    protected void trace(Object message, Throwable throwable) {
        if (log.isTraceEnabled()) {
            log.trace(message, throwable);
        }
    }

    /**
     * 로그를 기록한다.
     *
     * @param message 메시지
     */
    protected void debug(Object message) {
        if (log.isDebugEnabled()) {
            log.debug(message);
        }
    }

    /**
     * 로그를 기록한다.
     *
     * @param message   메시지
     * @param throwable 발생오류
     */
    protected void debug(Object message, Throwable throwable) {
        if (log.isDebugEnabled()) {
            log.debug(message, throwable);
        }
    }

    /**
     * 로그를 기록한다.
     *
     * @param message 메시지
     */
    protected void info(Object message) {
        if (log.isInfoEnabled()) {
            log.info(message);
        }
    }

    /**
     * 로그를 기록한다.
     *
     * @param message   메시지
     * @param throwable 발생오류
     */
    protected void info(Object message, Throwable throwable) {
        if (log.isInfoEnabled()) {
            log.info(message, throwable);
        }
    }

    /**
     * 로그를 기록한다.
     *
     * @param message 메시지
     */
    protected void warn(Object message) {
        if (log.isWarnEnabled()) {
            log.warn(message);
        }
    }

    /**
     * 로그를 기록한다.
     *
     * @param message   메시지
     * @param throwable 발생오류
     */
    protected void warn(Object message, Throwable throwable) {
        if (log.isWarnEnabled()) {
            log.warn(message, throwable);
        }
    }

    /**
     * 로그를 기록한다.
     *
     * @param message 메시지
     */
    protected void error(Object message) {
        if (log.isErrorEnabled()) {
            log.error(message);
        }
    }

    /**
     * 로그를 기록한다.
     *
     * @param message   메시지
     * @param throwable 발생오류
     */
    protected void error(Object message, Throwable throwable) {
        if (log.isErrorEnabled()) {
            log.error(message, throwable);
        }
    }

    /**
     * 로그를 기록한다.
     *
     * @param message 메시지
     */
    protected void fatal(Object message) {
        if (log.isFatalEnabled()) {
            log.fatal(message);
        }
    }

    /**
     * 로그를 기록한다.
     *
     * @param message   메시지
     * @param throwable 발생오류
     */
    protected void fatal(Object message, Throwable throwable) {
        if (log.isFatalEnabled()) {
            log.fatal(message, throwable);
        }
    }

    /**
     * 프로퍼티를 반환한다.
     *
     * @param name 이름
     * @return 프로퍼티
     */
    protected String getProperty(String name) {
        return getProperty(name, name);
    }

    /**
     * 프로퍼티를 반환한다.
     *
     * @param name         이름
     * @param defaultValue 디폴트 값
     * @return 프로퍼티
     */
    protected String getProperty(String code, String defaultValue) {
        return getMessage(code, null, defaultValue);
    }

    /**
     * 메시지를 반환한다.
     *
     * @param code 코드
     * @return 메시지
     */
    protected String getMessage(String code) {
        return getMessage(code, null, code);
    }

    /**
     * 메시지를 반환한다.
     *
     * @param code      코드
     * @param arguments 변수
     * @return 메시지
     */
    protected String getMessage(String code, Object[] arguments) {
        return getMessage(code, arguments, code);
    }

    /**
     * 메시지를 반환한다.
     *
     * @param code           코드
     * @param defaultMessage 디폴트 메시지
     * @return 메시지
     */
    protected String getMessage(String code, String defaultMessage) {
        return getMessage(code, null, defaultMessage);
    }

    /**
     * 메시지를 반환한다.
     *
     * @param code           코드
     * @param arguments      변수
     * @param defaultMessage 디폴트 메시지
     * @return 메시지
     */
    protected String getMessage(String code, Object[] arguments, String defaultMessage) {
        Locale locale = egovMessageSource.getSessionLocaleResolver().getLocale();

        return egovMessageSource.getReloadableResourceBundleMessageSource().getMessage(code, arguments, defaultMessage, locale);
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
        return getSession(true);
    }

    /**
     * HTTP 세션을 반환한다.
     *
     * @param create 생성여부
     * @return HTTP 세션
     */
    protected HttpSession getSession(boolean create) {
        return getRequest().getSession(create);
    }

    /**
     * 처리결과를 반환한다.
     *
     * @param message 메시지
     * @return 처리결과
     */
    protected Result success(String message) {
        Messages messages = new Messages();

        messages.put(Messages.MESSAGE, message);

        return success(messages);
    }

    /**
     * 처리결과를 반환한다.
     *
     * @param key     키
     * @param message 메시지
     * @return 처리결과
     */
    protected Result success(String key, String message) {
        Messages messages = new Messages();

        messages.put(key, message);

        return success(messages);
    }

    /**
     * 처리결과를 반환한다.
     *
     * @param messages 메시지
     * @return 처리결과
     */
    protected Result success(Messages messages) {
        Result result = new Result();

        result.put(Result.SUCCESS, true);
        result.put(Result.MESSAGES, messages);

        return result;
    }

    /**
     * 처리결과를 반환한다.
     *
     * @param message 메시지
     * @return 처리결과
     */
    protected Result failure(String message) {
        Messages messages = new Messages();

        messages.put(Messages.MESSAGE, message);

        return failure(messages);
    }

    /**
     * 처리결과를 반환한다.
     *
     * @param key     키
     * @param message 메시지
     * @return 처리결과
     */
    protected Result failure(String key, String message) {
        Messages messages = new Messages();

        messages.put(key, message);

        return failure(messages);
    }

    /**
     * 처리결과를 반환한다.
     *
     * @param messages 메시지
     * @return 처리결과
     */
    protected Result failure(Messages messages) {
        Result result = new Result();

        result.put(Result.SUCCESS, false);
        result.put(Result.MESSAGES, messages);

        return result;
    }

    /**
     * DBMS Exception 메세지를 추출한다.
     *
     * @param msg DB에서 받아온 에러 메세지 전문
     * @return
     */
    protected String getDbmsExceptionMsg(String msg) {
        String str = "[ERROR] DATABASE 에러가 발생하였습니다.";
        String[] msgs = msg.split("\n");
        if (msg.indexOf("JDBC") > -1 || msg.indexOf("ORA-") > -1) {
            str = msgs[0].substring(msgs[0].indexOf(":")).replaceAll(":", "").replaceAll("\"", "");
        } else {
            str = msgs[0];
        }

        return str;
    }

    /**
     * DBMS Exception 메세지를 추출한다.
     *
     * @param obj Exception
     * @return
     */
    protected String getDbmsExceptionMsg(Object obj) {
        String str = "[ERROR] DATABASE 에러가 발생하였습니다.";
        if (obj instanceof java.lang.Exception) {
            String msg = ((Exception) obj).getMessage();
            String[] msgs = msg.split("\n");
            if (msg.indexOf("JDBC") > -1 || msg.indexOf("ORA-") > -1) {
                str = msgs[0].substring(msgs[0].indexOf(":")).replaceAll(":", "").replaceAll("\"", "");
            } else {
                str = msgs[0];
            }

        }
        return str;
    }

}
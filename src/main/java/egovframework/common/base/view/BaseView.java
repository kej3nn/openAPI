/*
 * @(#)BaseView.java 1.0 2015/06/01
 *
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.common.base.view;

import java.util.Locale;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.view.AbstractView;

import egovframework.com.cmm.EgovMessageSource;

/**
 * 기본 뷰 클래스이다.
 *
 * @author 김은삼
 * @version 1.0 2015/06/01
 */
public abstract class BaseView extends AbstractView {
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
    protected BaseView() {
        super();

        // 로그를 생성한다.
        log = LogFactory.getLog(getClass());
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
}
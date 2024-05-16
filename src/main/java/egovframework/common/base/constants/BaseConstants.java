/*
 * @(#)BaseConstants.java 1.0 2015/06/01
 *
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.common.base.constants;

import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.util.HashMap;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * 기본 상수 클래스이다.
 *
 * @author 김은삼
 * @version 1.0 2015/06/01
 */
public class BaseConstants extends HashMap<Object, Object> {
    /**
     * 시리얼 버전 아이디
     */
    private static final long serialVersionUID = 1L;

    /**
     * 로그
     */
    protected Log log;

    /**
     * 디폴트 생성자이다.
     */
    protected BaseConstants() {
        super();

        // 로그를 생성한다.
        log = LogFactory.getLog(getClass());

        try {
            Field[] fields = getClass().getDeclaredFields();

            for (int i = 0; i < fields.length; i++) {
                int modifiers = fields[i].getModifiers();

                if (Modifier.isPublic(modifiers) && Modifier.isStatic(modifiers) && Modifier.isFinal(modifiers)) {
                    put(fields[i].getName(), fields[i].get(this));
                }
            }
        } catch (IllegalAccessException iae) {
            error("Detected exception: ", iae);

            throw new RuntimeException(iae);
        }
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
}
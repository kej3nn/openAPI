/*
 * @(#)Messages.java 1.0 2015/06/01
 *
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.common.base.model;

/**
 * 메시지 모델 클래스이다.
 *
 * @author 김은삼
 * @version 1.0 2015/06/01
 */
public class Messages extends BaseModel {
    /**
     * 시리얼 버전 아이디
     */
    private static final long serialVersionUID = 1L;

    /**
     * 메시지
     */
    public static final String MESSAGE = "message";

    /**
     * 디폴트 생성자이다.
     */
    public Messages() {
        super();
    }

    /**
     * 메시지를 반환한다.
     *
     * @return 메시지
     */
    public String getMessage() {
        return getMessage(MESSAGE, "");
    }

    /**
     * 메시지를 반환한다.
     *
     * @param key 키
     * @return 메시지
     */
    public String getMessage(String key) {
        return getMessage(key, "");
    }

    /**
     * 메시지를 반환한다.
     *
     * @param key          키
     * @param defaultValue 디폴트 메시지
     * @return 메시지
     */
    public String getMessage(String key, String defaultValue) {
        return getString(key, defaultValue);
    }
}
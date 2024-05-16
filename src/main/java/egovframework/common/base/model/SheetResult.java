/*
 * @(#)SheetResult.java 1.0 2015/06/01
 *
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.common.base.model;

/**
 * 시트 서버 처리 결과 모델 클래스이다.
 *
 * @author 김은삼
 * @version 1.0 2015/06/01
 */
public class SheetResult extends BaseModel {
    /**
     * 시리얼 버전 아이디
     */
    private static final long serialVersionUID = 1L;

    /**
     * 처리 결과 코드
     */
    public static final String CODE = "Code";

    /**
     * 처리 결과 메시지
     */
    public static final String MESSAGE = "Message";

    /**
     * 트랜잭션 처리 결과
     */
    public static final String RESULT = "Result";

    /**
     * 처리 결과 코드를 반환한다.
     *
     * @return 처리 결과 코드
     */
    public int getCode() {
        return getInt(CODE);
    }

    /**
     * 처리 결과 메시지를 반환한다.
     *
     * @return 처리 결과 메시지
     */
    public String getMessage() {
        return getString(MESSAGE);
    }

    /**
     * 트랜잭션 처리 결과를 반환한다.
     *
     * @return 트랜잭션 처리 결과
     */
    public String getResult() {
        return getString(RESULT);
    }
}
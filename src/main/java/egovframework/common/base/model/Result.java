/*
 * @(#)Result.java 1.0 2015/06/01
 *
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.common.base.model;

/**
 * 결과 모델 클래스이다.
 *
 * @author 김은삼
 * @version 1.0 2015/06/01
 */
public class Result extends BaseModel {
    /**
     * 시리얼 버전 아이디
     */
    private static final long serialVersionUID = 1L;

    /**
     * 처리결과
     */
    public static final String SUCCESS = "success";

    /**
     * 메시지
     */
    public static final String MESSAGES = "messages";

    /**
     * 시트 서버 처리 결과
     */
    public static final String SHEET_RESULT = "Result";

    /**
     * 시트 기타 데이터
     */
    public static final String SHEET_ETC = "Etc";

    /**
     * 디폴트 생성자이다.
     */
    public Result() {
        super();
    }

    /**
     * 처리결과를 반환한다.
     *
     * @return 처리결과
     */
    public boolean getSuccess() {
        return getBoolean(SUCCESS);
    }

    /**
     * 메시지를 반환한다.
     *
     * @return 메시지
     */
    public Messages getMessages() {
        return (Messages) get(MESSAGES);
    }

    /**
     * 시트 서버 처리 결과를 반환한다.
     *
     * @return 시트 서버 처리 결과
     */
    public Object getSheetResult() {
        if (containsKey(SHEET_RESULT)) {
            return get(SHEET_RESULT);
        } else {
            SheetResult result = new SheetResult();

            result.put(SheetResult.CODE, getSuccess() ? 0 : -1);
            result.put(SheetResult.MESSAGE, getMessages().getMessage());

            return result;
        }
    }

    /**
     * 시트 기타 데이터를 반환한다.
     *
     * @return 시트 기타 데이터
     */
    public Object getSheetEtc() {
        return get(SHEET_ETC);
    }
}
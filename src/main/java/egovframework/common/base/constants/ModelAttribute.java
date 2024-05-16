/*
 * @(#)ModelAttribute.java 1.0 2015/06/01
 *
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.common.base.constants;

/**
 * 모델 속성 상수 클래스이다.
 *
 * @author 김은삼
 * @version 1.0 2015/06/01
 */
public class ModelAttribute extends BaseConstants {
    /**
     * 시리얼 버전 아이디
     */
    private static final long serialVersionUID = 1L;

    /**
     * 검색 데이터
     */
    public static final String DATA = "data";

    /**
     * 페이지 번호
     */
    public static final String PAGE = "page";

    /**
     * 페이지 크기
     */
    public static final String ROWS = "rows";

    /**
     * 검색 카운트
     */
    public static final String COUNT = "count";

    /**
     * 전체 카운트
     */
    public static final String TOTAL = "total";

    /**
     * 전체 페이지
     */
    public static final String PAGES = "pages";

    /**
     * 완료
     */
    public static final String SUCCESS = "success";

    /**
     * 오류
     */
    public static final String ERROR = "error";

    /**
     * 시트 검색 데이터
     */
    public static final String SHEET_DATA = "Data";

    /**
     * 시트 전체 카운트
     */
    public static final String SHEET_TOTAL = "Total";

    /**
     * 시트 기타 데이터
     */
    public static final String SHEET_ETC = "Etc";

    /**
     * 시트 서버 메시지
     */
    public static final String SHEET_MESSAGE = "Message";

    /**
     * 시트 서버 처리 결과
     */
    public static final String SHEET_RESULT = "Result";

    /**
     * 데이터 처리 진행 코드
     */
    public static final String ACTION_STATUS = "Status";

    /**
     * 데이터 처리 진행 상세 코드
     */
    public static final String ACTION_INS = "I";
    public static final String ACTION_UPD = "U";
    public static final String ACTION_DEL = "D";

    /**
     * 디폴트 생성자이다.
     */
    public ModelAttribute() {
        super();
    }
}
/*
 * @(#)Paging.java 1.0 2015/06/01
 *
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.common.base.model;

/**
 * 페이징 모델 클래스이다.
 *
 * @author 김은삼
 * @version 1.0 2015/06/01
 */
public class Paging extends BaseModel {
    /**
     * 시리얼 버전 아이디
     */
    private static final long serialVersionUID = 1L;

    /**
     * 페이지 번호
     */
    public static final String PAGE = "page";

    /**
     * 페이지 크기
     */
    public static final String ROWS = "rows";

    /**
     * 검색 데이터
     */
    public static final String DATA = "data";

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
     * 디폴트 생성자이다.
     */
    public Paging() {
        super();
    }

    /**
     * 페이지 번호를 반환한다.
     *
     * @return 페이지 번호
     */
    public int getPage() {
        return getInt(PAGE);
    }

    /**
     * 페이지 크기를 반환한다.
     *
     * @return 페이지 크기
     */
    public int getRows() {
        return getInt(ROWS);
    }

    /**
     * 검색 데이터를 반환한다.
     *
     * @return 검색 데이터
     */
    public Object getData() {
        return get(DATA);
    }

    /**
     * 검색 카운트를 반환한다.
     *
     * @return 검색 카운트
     */
    public int getCount() {
        return getInt(COUNT);
    }

    /**
     * 전체 카운트를 반환한다.
     *
     * @return 전체 카운트
     */
    public int getTotal() {
        return getInt(TOTAL);
    }

    /**
     * 전체 페이지를 반환한다.
     *
     * @return 전체 페이지
     */
    public int getPages() {
        return getInt(PAGES);
    }

    /**
     * 시트 검색 데이터를 반환한다.
     *
     * @return 시트 검색 데이터
     */
    public Object getSheetData() {
        return containsKey(SHEET_DATA) ? get(SHEET_DATA) : get(DATA);
    }

    /**
     * 시트 전체 카운트를 반환한다.
     *
     * @return 시트 전체 카운트
     */
    public int getSheetTotal() {
        return containsKey(SHEET_TOTAL) ? getInt(SHEET_TOTAL) : getInt(COUNT);
    }

    /**
     * 시트 기타 데이터를 반환한다.
     *
     * @return 시트 기타 데이터
     */
    public Object getSheetEtc() {
        return get(SHEET_ETC);
    }

    /**
     * 시트 서버 메시지를 반환한다.
     *
     * @return 시트 서버 메시지
     */
    public String getSheetMessage() {
        return getString(SHEET_MESSAGE);
    }

    /**
     * 시트 서버 처리 결과를 반환한다.
     *
     * @return 시트 서버 처리 결과
     */
    public Object getSheetResult() {
        return get(SHEET_RESULT);
    }
}
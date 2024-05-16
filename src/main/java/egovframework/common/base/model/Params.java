/*
 * @(#)Params.java 1.0 2015/06/01
 *
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.common.base.model;

import java.util.Map;

//import nl.captcha.Captcha;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.web.multipart.MultipartFile;

/**
 * 파라메터 모델 클래스이다.
 *
 * @author 김은삼
 * @version 1.0 2015/06/01
 */
public class Params extends BaseModel {
    /**
     * 시리얼 버전 아이디
     */
    private static final long serialVersionUID = 1L;

    /**
     * 디폴트 페이지 번호
     */
    public static final int DEFAULT_PAGE = 1;

    /**
     * 디폴트 페이지 크기
     */
    public static final int DEFAULT_ROWS = 10;

    /**
     * 로케일
     */
    public static final String LOCALE = "locale";

    /**
     * 시스템 태그
     */
    public static final String SYSTEM_TAG = "sysTag";

    /**
     * 사용자 에이전트
     */
    public static final String USER_AGENT = "userAgent";

    /**
     * 사용자 코드
     */
    public static final String USER_CD = "userCd";

    /**
     * 사용자 코드
     */
    public static final String USER_ID = "userId";

    /**
     * 사용자 코드
     */
    public static final String USER_NM = "userNm";

    /**
     * 사용자 코드
     */
    public static final String REG_ID = "regId";

    /**
     * 사용자 코드
     */
    public static final String UPD_ID = "updId";

    /**
     * 사용자 아이피
     */
    public static final String USER_IP = "userIp";

    /**
     * 타임 스탬프
     */
    public static final String TIMESTAMP = "timestamp";

    /**
     * 페이지 번호
     */
    public static final String PAGE = "page";

    /**
     * 페이지 크기
     */
    public static final String ROWS = "rows";

    /**
     * 페이징 모드
     */
    public static final String PAGING = "paging";

    /**
     * 시작 행번호
     */
    public static final String START = "start";

    /**
     * 종료 행번호
     */
    public static final String END = "end";

    /**
     * 시트 데이터
     */
    public static final String SHEET_DATA = "sheetData";

    /**
     * 시트 정렬값
     */
    public static final String SHEET_ORDERBY = "orderby";

    /**
     * 등록 상태값
     */
    public static final String STATUS_INSERT = "I";

    /**
     * 수정 상태값
     */
    public static final String STATUS_UPDATE = "U";

    /**
     * 삭제 상태값
     */
    public static final String STATUS_DELETE = "D";

    /**
     * 보안 코드
     */
    public static final String CAPTCHA = "captcha";

    /**
     * 2015/11/06 박일환추가
     * 저장코드
     */
    public static final String SAVE_CD = "saveCd";


    /**
     * 디폴트 생성자이다.
     */
    public Params() {
        super();
    }

    /**
     * 맵을 인자로 가지는 생성자이다.
     *
     * @param map 맵
     */
    public Params(Map<?, ?> map) {
        super(map);
    }

    /**
     * 값을 설정한다.
     *
     * @param key   키
     * @param value 값
     * @return 기존 값
     */
    public Object set(Object key, Object value) {
        if (value instanceof Object[]) {
            Object[] values = (Object[]) value;

            if (values.length == 1) {
                return put(key, values[0]);
            }
        }

        return put(key, value);
    }

    /**
     * 로케일을 반환한다.
     *
     * @return 로케일
     */
    public String getLocale() {
        return getString(LOCALE);
    }

    /**
     * 시스템 태그를 반환한다.
     *
     * @return 시스템 태그
     */
    public String getSystemTag() {
        return getString(SYSTEM_TAG);
    }

    /**
     * 사용자 에이전트를 반환한다.
     *
     * @return 사용자 에이전트
     */
    public String getUserAgent() {
        return getString(USER_AGENT);
    }

    /**
     * 사용자 코드를 반환한다.
     *
     * @return 사용자 코드
     */
    public String getUserCd() {
        return getString(USER_CD);
    }

    /**
     * 사용자 아이디를 반환한다.
     *
     * @return 사용자 아이디
     */
    public String getUserId() {
        return getString(USER_ID);
    }

    /**
     * 사용자 이름을 반환한다.
     *
     * @return 사용자 이름
     */
    public String getUserNm() {
        return getString(USER_NM);
    }

    /**
     * 등록자 아이디를 반환한다.
     *
     * @return 등록자 아이디
     */
    public String getRegId() {
        return getString(REG_ID);
    }

    /**
     * 수정자 아이디를 반환한다.
     *
     * @return 수정자 아이디
     */
    public String getUpdId() {
        return getString(UPD_ID);
    }

    /**
     * 사용자 아이피를 반환한다.
     *
     * @return 사용자 아이피
     */
    public String getUserIp() {
        return getString(USER_IP);
    }

    /**
     * 타임 스탬프를 반환한다.
     *
     * @return 타임 스탬프
     */
    public String getTimestamp() {
        return getString(TIMESTAMP);
    }

    /**
     * 페이지 번호를 반환한다.
     *
     * @return 페이지 번호
     */
    public int getPage() {
        return getInt(PAGE, DEFAULT_PAGE);
    }

    /**
     * 페이지 크기를 반환한다.
     *
     * @return 페이지 크기
     */
    public int getRows() {
        return getInt(ROWS, DEFAULT_ROWS);
    }

    /**
     * JSON 객체를 반환한다.
     *
     * @param key 키
     * @return JSON 객체
     */
    public Params getJsonObject(String key) {
        Object value = get(key);

        if (value instanceof Object) {
            JSONObject jsonObject = (JSONObject) JSONValue.parse(value.toString());

            return new Params(jsonObject);
        }

        return null;
    }

    /**
     * JSON 객체 배열을 반환한다.
     *
     * @param key 키
     * @return JSON 객체 배열
     */
    public Params[] getJsonArray(String key) {
        Object value = get(key);

        if (value instanceof Object) {
            JSONArray jsonArray = (JSONArray) JSONValue.parse(value.toString());

            Params[] paramsArray = new Params[jsonArray.size()];

            for (int i = 0; i < paramsArray.length; i++) {
                paramsArray[i] = new Params((JSONObject) jsonArray.get(i));
            }

            return paramsArray;
        }

        return new Params[0];
    }

    /**
     * 파일을 반환한다.
     *
     * @param key 키
     * @return 파일
     */
    public MultipartFile getFile(String key) {
        return (MultipartFile) get(key);
    }

    /**
     * 파일 배열을 반환한다.
     *
     * @param key 키
     * @return 파일 배열
     */
    public MultipartFile[] getFileArray(String key) {
        Object value = get(key);

        if (value instanceof MultipartFile[]) {
            return (MultipartFile[]) value;
        }

        if (value instanceof MultipartFile) {
            return new MultipartFile[]{(MultipartFile) value};
        }

        return new MultipartFile[0];
    }

    /**
     * 보안 코드를 반환한다.
     *
     * @param key 키
     * @return 보안 코드
     */
//    public Captcha getCaptcha(String key) {
//        return (Captcha) get(key);
//    }
}
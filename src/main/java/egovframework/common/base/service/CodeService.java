/*
 * @(#)CodeService.java 1.0 2015/06/01
 *
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.common.base.service;

import java.util.List;

import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 코드 서비스 클래스이다.
 *
 * @author 김은삼
 * @version 1.0 2015/06/01
 */
public class CodeService extends BaseService {
    /**
     * 코드
     */
    protected static final String CODE = "code";

    /**
     * 이름
     */
    protected static final String NAME = "name";

    /**
     * 디폴트 코드
     */
    protected static final String DEFAULT_CODE = "defaultCode";

    /**
     * 디폴트 이름
     */
    protected static final String DEFAULT_NAME = "defaultName";

    /**
     * 디폴트 코드를 추가한다.
     *
     * @param data   데이터
     * @param params 파라메터
     */
    @SuppressWarnings({"rawtypes", "unchecked"})
    protected void addDefaultCode(List data, Params params) {
        if (params.containsKey(DEFAULT_CODE)) {
            Record code = new Record();

            if (params.containsKey(DEFAULT_NAME)) {
                code.put(CODE, params.getString(DEFAULT_CODE));
                code.put(NAME, params.getString(DEFAULT_NAME));
            } else {
                code.put(CODE, params.getString(DEFAULT_CODE));
                code.put(NAME, params.getString(DEFAULT_CODE));
            }

            data.add(0, code);
        }
    }
}
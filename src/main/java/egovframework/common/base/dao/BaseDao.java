/*
 * @(#)BaseDao.java 1.0 2015/06/01
 *
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.common.base.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;

/**
 * 기본 DAO 클래스이다.
 *
 * @author 김은삼
 * @version 1.0 2015/06/01
 */
public class BaseDao extends EgovComAbstractDAO {
    /**
     * 상단 데이터 접미어
     */
    public static final String SUFFIX_UPPER = "Upper";

    /**
     * 검색 카운트 접미어
     */
    public static final String SUFFIX_COUNT = "Count";

    /**
     * 전체 카운트 접미어
     */
    public static final String SUFFIX_TOTAL = "Total";

    /**
     * 매뉴얼 페이징 모드
     */
    public static final int PAGING_MANUAL = 0;

    /**
     * 스크롤 페이징 모드
     */
    public static final int PAGING_SCROLL = 1;

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
    protected BaseDao() {
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

    /**
     * 데이터를 검색한다.
     *
     * @param id 아이디
     * @return 검색결과
     */
    public List<?> search(String id) {
        return getSqlMapClientTemplate().queryForList(id);
    }

    /**
     * 데이터를 검색한다.
     *
     * @param id     아이디
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> search(String id, Object params) {
        return getSqlMapClientTemplate().queryForList(id, params);
    }

    /**
     * 데이터를 검색한다.
     *
     * @param id   아이디
     * @param page 페이지 번호
     * @param rows 페이지 크기
     * @return 검색결과
     */
    public Paging search(String id, int page, int rows) {
        return search(id, null, page, rows, PAGING_SCROLL, false, false);
    }

    /**
     * 데이터를 검색한다.
     *
     * @param id     아이디
     * @param params 파라메터
     * @param page   페이지 번호
     * @param rows   페이지 크기
     * @return 검색결과
     */
    public Paging search(String id, Object params, int page, int rows) {
        return search(id, params, page, rows, PAGING_SCROLL, false, false);
    }

    /**
     * 데이터를 검색한다.
     *
     * @param id   아이디
     * @param page 페이지 번호
     * @param rows 페이지 크기
     * @param mode 페이징 방식
     * @return 검색결과
     */
    public Paging search(String id, int page, int rows, int mode) {
        return search(id, null, page, rows, mode, false, false);
    }

    /**
     * 데이터를 검색한다.
     *
     * @param id     아이디
     * @param params 파라메터
     * @param page   페이지 번호
     * @param rows   페이지 크기
     * @param mode   페이징 방식
     * @return 검색결과
     */
    public Paging search(String id, Object params, int page, int rows, int mode) {
        return search(id, params, page, rows, mode, false, false);
    }

    /**
     * 데이터를 검색한다.
     *
     * @param id       아이디
     * @param page     페이지 번호
     * @param rows     페이지 크기
     * @param mode     페이징 방식
     * @param announce 상단 데이터
     * @return 검색결과
     */
    public Paging search(String id, int page, int rows, int mode, boolean announce) {
        return search(id, null, page, rows, mode, announce, false);
    }

    /**
     * 데이터를 검색한다.
     *
     * @param id       아이디
     * @param params   파라메터
     * @param page     페이지 번호
     * @param rows     페이지 크기
     * @param mode     페이징 방식
     * @param announce 상단 데이터
     * @return 검색결과
     */
    public Paging search(String id, Object params, int page, int rows, int mode, boolean announce) {
        return search(id, params, page, rows, mode, announce, false);
    }

    /**
     * 데이터를 검색한다.
     *
     * @param id       아이디
     * @param params   파라메터
     * @param page     페이지 번호
     * @param rows     페이지 크기
     * @param mode     페이징 방식
     * @param announce 상단 데이터
     * @param totality 전체 카운트
     * @return 검색결과
     */
    public Paging search(String id, Object params, int page, int rows, int mode, boolean announce, boolean totality) {
        List<Object> data = new ArrayList<Object>();

        if (announce) {
            // 상단 데이터를 검색한다.
            data.addAll((List<?>) getSqlMapClientTemplate().queryForList(id + SUFFIX_UPPER, params));
        }

        int total = 0;
        int count = 0;

        if (totality) {
            // 전체 카운트를 조회한다.
            total = ((Integer) getSqlMapClientTemplate().queryForObject(id + SUFFIX_TOTAL, params)).intValue();

            if (total > 0) {
                // 검색 카운트를 조회한다.
                count = ((Integer) getSqlMapClientTemplate().queryForObject(id + SUFFIX_COUNT, params)).intValue();
            }
        } else {
            // 검색 카운트를 조회한다.
            total = count = ((Integer) getSqlMapClientTemplate().queryForObject(id + SUFFIX_COUNT, params)).intValue();
        }

        int pages = 0;
        int index = 0;

        if (count > 0) {
            pages = (count / rows) + (count % rows > 0 ? 1 : 0);

            index = (page > pages ? pages : page) - 1;

            // 스크롤 페이징 모드인 경우
            if (PAGING_SCROLL == mode) {
                // 데이터를 검색한다.
                data.addAll((List<?>) getSqlMapClientTemplate().queryForList(id, params, index * rows, rows));
            }
            // 매뉴얼 페이징 모드인 경우
            else {
                Object parameters = params != null ? params : new Params();

                if (parameters instanceof Params) {
                    ((Params) parameters).put(Params.PAGING, PAGING_MANUAL);
                    ((Params) parameters).put(Params.START, (index * rows) + 1);
                    ((Params) parameters).put(Params.END, (index + 1) * rows);
                }

                // 데이터를 검색한다.
                data.addAll((List<?>) getSqlMapClientTemplate().queryForList(id, parameters));
            }
        }

        Paging paging = new Paging();

        paging.put(Paging.PAGE, index + 1);
        paging.put(Paging.ROWS, rows);
        paging.put(Paging.DATA, data);
        paging.put(Paging.COUNT, count);
        paging.put(Paging.TOTAL, total);
        paging.put(Paging.PAGES, pages);

        return paging;
    }


    /**
     * 데이터를 등록한다.
     *
     * @param id 아이디
     * @return 등록결과
     */
    public Object insert(String id) {
        return getSqlMapClientTemplate().insert(id);
    }

    /**
     * 데이터를 등록한다.
     *
     * @param id     아이디
     * @param params 파라메터
     * @return 등록결과
     */
    public Object insert(String id, Object params) {
        return getSqlMapClientTemplate().insert(id, params);
    }

    /**
     * 데이터를 조회한다.
     *
     * @param id 아이디
     * @return 조회결과
     */
    public Object select(String id) {
        return getSqlMapClientTemplate().queryForObject(id);
    }

    /**
     * 데이터를 조회한다.
     *
     * @param id     아이디
     * @param params 파라메터
     * @return 조회결과
     */
    public Object select(String id, Object params) {
        return getSqlMapClientTemplate().queryForObject(id, params);
    }

    /**
     * 데이터를 조회한다.
     *
     * @param id     아이디
     * @param params 파라메터
     * @param record 조회결과
     * @return 조회결과
     */
    public Object select(String id, Object params, Object record) {
        return getSqlMapClientTemplate().queryForObject(id, params, record);
    }

    /**
     * 데이터를 수정한다.
     *
     * @param id 아이디
     * @return 수정결과
     */
    public int update(String id) {
        return getSqlMapClientTemplate().update(id);
    }

    /**
     * 데이터를 수정한다.
     *
     * @param id     아이디
     * @param params 파라메터
     * @return 수정결과
     */
    public int update(String id, Object params) {
        return getSqlMapClientTemplate().update(id, params);
    }

    /**
     * 데이터를 수정한다.
     *
     * @param id     아이디
     * @param params 파라메터
     * @param count  수정결과
     */
    public void update(String id, Object params, int count) {
        getSqlMapClientTemplate().update(id, params, count);
    }

    /**
     * 데이터를 삭제한다.
     *
     * @param id 아이디
     * @return 삭제결과
     */
    public int delete(String id) {
        return getSqlMapClientTemplate().delete(id);
    }

    /**
     * 데이터를 삭제한다.
     *
     * @param id     아이디
     * @param params 파라메터
     * @return 삭제결과
     */
    public int delete(String id, Object params) {
        return getSqlMapClientTemplate().delete(id, params);
    }

    /**
     * 데이터를 삭제한다.
     *
     * @param id     아이디
     * @param params 파라메터
     * @param count  삭제결과
     */
    public void delete(String id, Object params, int count) {
        getSqlMapClientTemplate().delete(id, params, count);
    }

    /**
     * 배치처리를 시작한다.
     *
     * @throws SQLException 발생오류
     */
    public void startBatch() throws SQLException {
        getSqlMapClientTemplate().getSqlMapClient().startBatch();
    }

    /**
     * 배치처리를 실행한다.
     *
     * @return 실행결과
     * @throws SQLException 발생오류
     */
    public int executeBatch() throws SQLException {
        return getSqlMapClientTemplate().getSqlMapClient().executeBatch();
    }

    /**
     * 프로시져를 수행한다.
     */
    public Object execPrc(String id, Object params) {
        return getSqlMapClientTemplate().queryForObject(id, params);
    }

    /**
     * 머지문을 수행한다.
     * iBatis에서 merge처리시 0으로 리턴되는 issue가 있어 merge문은 1로 return 처리
     *
     * @param id
     * @return
     */
    public int merge(String id) {
        getSqlMapClientTemplate().update(id);
        return 1;
    }

    /**
     * 머지문을 수행한다.
     * iBatis에서 merge처리시 0으로 리턴되는 issue가 있어 merge문은 1로 return 처리
     *
     * @param id
     * @param params
     * @return
     */
    public int merge(String id, Object params) {
        getSqlMapClientTemplate().update(id, params);
        return 1;
    }
}
package egovframework.admin.gaapi.service.impl;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;

/**
 * 구글 애널리틱스을 관리하는 DAO 클래스
 *
 * @version 1.0
 * @author CSB
 * @since 2020/11/02
 */

@Repository(value = "adminGaApiDao")
public class AdminGaApiDao extends BaseDao {

    /**
     * 구글 사이트 분석 현황 - 접속자수 입력
     *
     * @param params
     * @return
     */
    public Object insertStatAcesGG(Params params) throws DataAccessException, Exception {
        return insert("adminGaApiDao.insertStatAcesGG", params);
    }

    /**
     * 구글 사이트 분석 현황 - 접속자수 리스트 조회
     *
     * @param params
     * @param page
     * @param rows
     * @return
     */
    public Paging selectStatAcesGGList(Params params, int page, int rows) {
        return search("adminGaApiDao.selectStatAcesGGList", params, page, rows, PAGING_MANUAL);
    }

    /**
     * 구글 사이트 분석 현황 - 접속자수(중복체크)
     *
     * @param params
     * @return
     */
    public int statAcesGGCheckDup(Params params) throws DataAccessException, Exception {

        return (Integer) select("adminGaApiDao.statAcesGGCheckDup", params);
    }

    /**
     * 구글 사이트 분석 현황 - 페이지 뷰 입력
     *
     * @param params
     * @return
     */
    public Object insertStatPageGG(Params params) throws DataAccessException, Exception {
        return insert("adminGaApiDao.insertStatPageGG", params);
    }

    /**
     * 구글 사이트 분석 현황 - 페이지 뷰 리스트 조회
     *
     * @param params
     * @param page
     * @param rows
     * @return
     */
    public Paging selectStatPageGGList(Params params, int page, int rows) {
        return search("adminGaApiDao.selectStatPageGGList", params, page, rows, PAGING_MANUAL);
    }

    /**
     * 구글 사이트 분석 현황 - 페이지 뷰(중복체크)
     *
     * @param params
     * @return
     */
    public int statPageGGCheckDup(Params params) throws DataAccessException, Exception {

        return (Integer) select("adminGaApiDao.statPageGGCheckDup", params);
    }

    /**
     * 구글 사이트 분석 현황 - 접속자수 (시작날짜 조회)
     */
    public String getStatAcesGGMaxStartDate(Params params) throws DataAccessException, Exception {
        return (String) select("adminGaApiDao.getStatAcesGGMaxStartDate");
    }

    /**
     * 구글 사이트 분석 현황 - 페이지 뷰 (시작날짜 조회)
     */
    public String getStatPageGGMaxStartDate(Params params) throws DataAccessException, Exception {
        return (String) select("adminGaApiDao.getStatPageGGMaxStartDate");
    }

    /**
     * 구글 사이트 분석 현황 - 지역현황 입력
     *
     * @param params
     * @return
     */
    public Object insertStatAreaGG(Params params) throws DataAccessException, Exception {
        return insert("adminGaApiDao.insertStatAreaGG", params);
    }

    /**
     * 구글 사이트 분석 현황 - 지역현황 리스트 조회
     *
     * @param params
     * @param page
     * @param rows
     * @return
     */
    public Paging selectStatAreaGGList(Params params, int page, int rows) {
        return search("adminGaApiDao.selectStatAreaGGList", params, page, rows, PAGING_MANUAL);
    }

    /**
     * 구글 사이트 분석 현황 - 지역현황(중복체크)
     *
     * @param params
     * @return
     */
    public int statAreaGGCheckDup(Params params) throws DataAccessException, Exception {

        return (Integer) select("adminGaApiDao.statAreaGGCheckDup", params);
    }

    /**
     * 구글 사이트 분석 현황 - 지역현황 (시작날짜 조회)
     */
    public String getStatAreaGGMaxStartDate(Params params) throws DataAccessException, Exception {
        return (String) select("adminGaApiDao.getStatAreaGGMaxStartDate");
    }

    /**
     * 구글 사이트 분석 현황 - 접속경로 입력
     *
     * @param params
     * @return
     */
    public Object insertStatAcrtGG(Params params) throws DataAccessException, Exception {
        return insert("adminGaApiDao.insertStatAcrtGG", params);
    }

    /**
     * 구글 사이트 분석 현황 - 접속경로 리스트 조회
     *
     * @param params
     * @param page
     * @param rows
     * @return
     */
    public Paging selectStatAcrtGGList(Params params, int page, int rows) {
        return search("adminGaApiDao.selectStatAcrtGGList", params, page, rows, PAGING_MANUAL);
    }

    /**
     * 구글 사이트 분석 현황 - 접속경로(중복체크)
     *
     * @param params
     * @return
     */
    public int statAcrtGGCheckDup(Params params) throws DataAccessException, Exception {

        return (Integer) select("adminGaApiDao.statAcrtGGCheckDup", params);
    }

    /**
     * 구글 사이트 분석 현황 - 접속경로 (시작날짜 조회)
     */
    public String getStatAcrtGGMaxStartDate(Params params) throws DataAccessException, Exception {
        return (String) select("adminGaApiDao.getStatAcrtGGMaxStartDate");
    }

    /**
     * 구글 사이트 분석 현황 - 접속경로 입력
     *
     * @param params
     * @return
     */
    public Object insertStatPoplGG(Params params) throws DataAccessException, Exception {
        return insert("adminGaApiDao.insertStatPoplGG", params);
    }

    /**
     * 구글 사이트 분석 현황 - 인구통계 리스트 조회
     *
     * @param params
     * @param page
     * @param rows
     * @return
     */
    public Paging selectStatPoplGGList(Params params, int page, int rows) {
        return search("adminGaApiDao.selectStatPoplGGList", params, page, rows, PAGING_MANUAL);
    }

    /**
     * 구글 사이트 분석 현황 - 인구통계(중복체크)
     *
     * @param params
     * @return
     */
    public int statPoplGGCheckDup(Params params) throws DataAccessException, Exception {

        return (Integer) select("adminGaApiDao.statPoplGGCheckDup", params);
    }

    /**
     * 구글 사이트 분석 현황 - 인구통계 (시작날짜 조회)
     */
    public String getStatPoplGGMaxStartDate(Params params) throws DataAccessException, Exception {
        return (String) select("adminGaApiDao.getStatPoplGGMaxStartDate");
    }

    /**
     * 구글 사이트 분석 현황 - 지역현황 상세 입력
     *
     * @param params
     * @return
     */
    public Object insertStatAreaDGG(Params params) throws DataAccessException, Exception {
        return insert("adminGaApiDao.insertStatAreaDGG", params);
    }

    /**
     * 구글 사이트 분석 현황 - 지역현황 상세 리스트 조회
     *
     * @param params
     * @param page
     * @param rows
     * @return
     */
    public Paging selectStatAreaDGGList(Params params, int page, int rows) {
        return search("adminGaApiDao.selectStatAreaDGGList", params, page, rows, PAGING_MANUAL);
    }

    /**
     * 구글 사이트 분석 현황 - 지역현황 상세(중복체크)
     *
     * @param params
     * @return
     */
    public int statAreaDGGCheckDup(Params params) throws DataAccessException, Exception {

        return (Integer) select("adminGaApiDao.statAreaDGGCheckDup", params);
    }

    /**
     * 구글 사이트 분석 현황 - 지역현황 상세 (시작날짜 조회)
     */
    public String getStatAreaDGGMaxStartDate(Params params) throws DataAccessException, Exception {
        return (String) select("adminGaApiDao.getStatAreaDGGMaxStartDate");
    }
}

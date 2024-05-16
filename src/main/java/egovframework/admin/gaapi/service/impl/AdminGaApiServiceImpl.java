package egovframework.admin.gaapi.service.impl;

import javax.annotation.Resource;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.gaapi.service.AdminGaApiService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.service.BaseService;

@Service(value = "adminGaApiService")
public class AdminGaApiServiceImpl extends BaseService implements AdminGaApiService {

    @Resource(name = "adminGaApiDao")
    protected AdminGaApiDao adminGaApiDao;

    /**
     * 구글 사이트 분석 현황 - 접속자수 입력
     */
    @Override
    public void insertStatGaApiSave(Params params) {
        try {
            String statGb = (String) params.get("statGb");
            if (statGb.equals("aces")) {
                adminGaApiDao.insertStatAcesGG(params);
            } else if (statGb.equals("page")) {
                adminGaApiDao.insertStatPageGG(params);
            } else if (statGb.equals("area")) {
                adminGaApiDao.insertStatAreaGG(params);
            } else if (statGb.equals("acrt")) {
                adminGaApiDao.insertStatAcrtGG(params);
            } else if (statGb.equals("popl")) {
                adminGaApiDao.insertStatPoplGG(params);
            } else if (statGb.equals("aread")) {
                adminGaApiDao.insertStatAreaDGG(params);
            }

        } catch (DataAccessException e) {
            EgovWebUtil.exTransactionLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
    }

    /**
     * 구글 사이트 분석 현황 - 접속자수 리스트 조회
     */
    @Override
    public Paging selectStatAcesGGListPaging(Params params) {

        Paging list = adminGaApiDao.selectStatAcesGGList(params, params.getPage(), params.getRows());

        return list;
    }

    /**
     * 구글 사이트 분석 현황 - 접속자수(중복체크)
     */
    @Override
    public int statAcesGGCheckDup(Params params) {
        int result = 0;
        try {
            result = adminGaApiDao.statAcesGGCheckDup(params);
        } catch (DataAccessException e) {
            EgovWebUtil.exTransactionLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }

        return result;
    }

    /**
     * 구글 사이트 분석 현황 - 페이지 뷰  리스트 조회
     */
    @Override
    public Paging selectStatPageGGListPaging(Params params) {

        Paging list = adminGaApiDao.selectStatPageGGList(params, params.getPage(), params.getRows());

        return list;
    }

    /**
     * 구글 사이트 분석 현황 - 페이지 뷰(중복체크)
     */
    @Override
    public int statPageGGCheckDup(Params params) {
        int result = 0;
        try {
            result = adminGaApiDao.statPageGGCheckDup(params);
        } catch (DataAccessException e) {
            EgovWebUtil.exTransactionLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }

        return result;
    }

    /**
     * 구글 사이트 분석 현황 - 접속자수 (시작날짜 조회)
     */
    public String getStatAcesGGMaxStartDate(Params params) {
        String result = "";
        try {
            result = adminGaApiDao.getStatAcesGGMaxStartDate(params);
        } catch (DataAccessException e) {
            EgovWebUtil.exTransactionLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
        return result;
    }

    /**
     * 구글 사이트 분석 현황 - 페이지 뷰 (시작날짜 조회)
     */
    public String getStatPageGGMaxStartDate(Params params) {
        String result = "";
        try {
            result = adminGaApiDao.getStatPageGGMaxStartDate(params);
        } catch (DataAccessException e) {
            EgovWebUtil.exTransactionLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
        return result;
    }

    /**
     * 구글 사이트 분석 현황 - 지역현황 리스트 조회
     */
    @Override
    public Paging selectStatAreaGGListPaging(Params params) {

        Paging list = adminGaApiDao.selectStatAreaGGList(params, params.getPage(), params.getRows());

        return list;
    }

    /**
     * 구글 사이트 분석 현황 - 지역현황(중복체크)
     */
    @Override
    public int statAreaGGCheckDup(Params params) {
        int result = 0;
        try {
            result = adminGaApiDao.statAreaGGCheckDup(params);
        } catch (DataAccessException e) {
            EgovWebUtil.exTransactionLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }

        return result;
    }

    /**
     * 구글 사이트 분석 현황 - 지역현황 (시작날짜 조회)
     */
    public String getStatAreaGGMaxStartDate(Params params) {
        String result = "";
        try {
            result = adminGaApiDao.getStatAreaGGMaxStartDate(params);
        } catch (DataAccessException e) {
            EgovWebUtil.exTransactionLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
        return result;
    }

    /**
     * 구글 사이트 분석 현황 - 접속경로 리스트 조회
     */
    @Override
    public Paging selectStatAcrtGGListPaging(Params params) {

        Paging list = adminGaApiDao.selectStatAcrtGGList(params, params.getPage(), params.getRows());

        return list;
    }

    /**
     * 구글 사이트 분석 현황 - 접속경로(중복체크)
     */
    @Override
    public int statAcrtGGCheckDup(Params params) {
        int result = 0;
        try {
            result = adminGaApiDao.statAcrtGGCheckDup(params);
        } catch (DataAccessException e) {
            EgovWebUtil.exTransactionLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }

        return result;
    }

    /**
     * 구글 사이트 분석 현황 - 접속경로 (시작날짜 조회)
     */
    public String getStatAcrtGGMaxStartDate(Params params) {
        String result = "";
        try {
            result = adminGaApiDao.getStatAcrtGGMaxStartDate(params);
        } catch (DataAccessException e) {
            EgovWebUtil.exTransactionLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
        return result;
    }

    /**
     * 구글 사이트 분석 현황 - 인구통계 리스트 조회
     */
    @Override
    public Paging selectStatPoplGGListPaging(Params params) {

        Paging list = adminGaApiDao.selectStatPoplGGList(params, params.getPage(), params.getRows());

        return list;
    }

    /**
     * 구글 사이트 분석 현황 - 인구통계(중복체크)
     */
    @Override
    public int statPoplGGCheckDup(Params params) {
        int result = 0;
        try {
            result = adminGaApiDao.statPoplGGCheckDup(params);
        } catch (DataAccessException e) {
            EgovWebUtil.exTransactionLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }

        return result;
    }

    /**
     * 구글 사이트 분석 현황 - 인구통계 (시작날짜 조회)
     */
    public String getStatPoplGGMaxStartDate(Params params) {
        String result = "";
        try {
            result = adminGaApiDao.getStatPoplGGMaxStartDate(params);
        } catch (DataAccessException e) {
            EgovWebUtil.exTransactionLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
        return result;
    }

    /**
     * 구글 사이트 분석 현황 - 지역현황 상세 리스트 조회
     */
    @Override
    public Paging selectStatAreaDGGListPaging(Params params) {

        Paging list = adminGaApiDao.selectStatAreaDGGList(params, params.getPage(), params.getRows());

        return list;
    }

    /**
     * 구글 사이트 분석 현황 - 지역현황 상세(중복체크)
     */
    @Override
    public int statAreaDGGCheckDup(Params params) {
        int result = 0;
        try {
            result = adminGaApiDao.statAreaDGGCheckDup(params);
        } catch (DataAccessException e) {
            EgovWebUtil.exTransactionLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }

        return result;
    }

    /**
     * 구글 사이트 분석 현황 - 지역현황 상세 (시작날짜 조회)
     */
    public String getStatAreaDGGMaxStartDate(Params params) {
        String result = "";
        try {
            result = adminGaApiDao.getStatAreaDGGMaxStartDate(params);
        } catch (DataAccessException e) {
            EgovWebUtil.exTransactionLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
        return result;
    }
}

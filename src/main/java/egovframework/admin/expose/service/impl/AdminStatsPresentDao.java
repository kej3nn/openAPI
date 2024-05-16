package egovframework.admin.expose.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;

@Repository(value = "adminStatsPresentDao")
public class AdminStatsPresentDao extends BaseDao {

    //청구서처리현황 조회한다.
    public List<?> statAplDeal(Params params) {
        return search("AdminStatsPresent.getStatAplDealList", params);
    }

    //청구방법별 현황 조회한다.
    public List<?> statAplTakMth(Params params) {
        return search("AdminStatsPresent.getStatAplTakMthList", params);
    }

    //청구방법별 현황 조회한다.
    public List<?> statAplOpbFom(Params params) {
        return search("AdminStatsPresent.getStatAplOpbFomList", params);
    }

    //비공개(부분공개)사유별현황 조회
    public List<?> statClsdRson(Params params) {
        return search("AdminStatsPresent.getStatClsdRsonList", params);
    }

    //이의신청서처리 현황 조회
    public List<?> statObjtnDeal(Params params) {
        return search("AdminStatsPresent.getStatObjtnDealList", params);
    }

    //정보공개 처리현황 목록 조회
    public Paging statAplResultList(Params params, int page, int rows) {
        return search("AdminStatsPresent.statAplResultList", params, page, rows, PAGING_MANUAL);
    }

    //정보공개 처리현황 목록 조회
    public Paging statObjtnDealRsltList(Params params, int page, int rows) {
        return search("AdminStatsPresent.statObjtnDealRsltList", params, page, rows, PAGING_MANUAL);
    }

    //공개여부 결정기간별 현황 조회
    public List<?> statAplDcsDt(Params params) {
        return search("AdminStatsPresent.getStatAplDcsDtList", params);
    }

    /**
     * 공개여부 결정기간별 현황(청구서 조회)
     */
    public Paging selectAplDcsdtList(Params params, int page, int rows) {
        return search("AdminStatsPresent.selectAplDcsdtList", params, page, rows, PAGING_MANUAL);
    }

    //정보공개청구서 접근기록 목록 조회
    public Paging selectAcsOpnzAplList(Params params, int page, int rows) {
        return search("AdminStatsPresent.selectAcsOpnzAplList", params, page, rows, PAGING_MANUAL);
    }
}

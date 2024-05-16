package egovframework.admin.expose.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.admin.expose.service.AdminStatsPresentService;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.service.BaseService;

/**
 * 정보공개관리 > 통계/현황 서비스
 *
 * @author Softon
 * @version 1.0
 * @since 2019/08/12
 */

@Service(value = "adminStatsPresentService")
public class AdminStatsPresentServiceImpl extends BaseService implements AdminStatsPresentService {

    @Resource(name = "adminStatsPresentDao")
    protected AdminStatsPresentDao adminStatsPresentDao;

    //청구서처리현황 조회한다.
    @SuppressWarnings("unchecked")
    public List<Record> statAplDeal(Params params) {
        return (List<Record>) adminStatsPresentDao.statAplDeal(params);
    }

    //청구방법별 현황 조회
    @SuppressWarnings("unchecked")
    public List<Record> statAplTakMth(Params params) {
        return (List<Record>) adminStatsPresentDao.statAplTakMth(params);
    }

    //공개방법별 현황 조회
    @SuppressWarnings("unchecked")
    public List<Record> statAplOpbFom(Params params) {
        return (List<Record>) adminStatsPresentDao.statAplOpbFom(params);
    }

    //비공개(부분공개)사유별현황 조회
    @SuppressWarnings("unchecked")
    public List<Record> statClsdRson(Params params) {
        return (List<Record>) adminStatsPresentDao.statClsdRson(params);
    }

    //이의신청서처리 현황 조회
    @SuppressWarnings("unchecked")
    public List<Record> statObjtnDeal(Params params) {
        return (List<Record>) adminStatsPresentDao.statObjtnDeal(params);
    }

    //정보공개 처리현황 목록 조회
    @Override
    public Paging statAplResultPaging(Params params) {
        Paging list = adminStatsPresentDao.statAplResultList(params, params.getPage(), params.getRows());

        return list;
    }

    //이의신청처리 현황 조회
    @Override
    public Paging statObjtnDealRsltPaging(Params params) {
        Paging list = adminStatsPresentDao.statObjtnDealRsltList(params, params.getPage(), params.getRows());

        return list;
    }

    //공개여부 결정기간별 현황 조회
    @SuppressWarnings("unchecked")
    public List<Record> statAplDcsDt(Params params) {
        return (List<Record>) adminStatsPresentDao.statAplDcsDt(params);
    }

    /**
     * 공개여부 결정기간별 현황(청구서 조회)
     */
    @Override
    public Paging selectAplDcsdtListPaging(Params params) {
        Paging list = adminStatsPresentDao.selectAplDcsdtList(params, params.getPage(), params.getRows());

        return list;
    }

    //정보공개청구서 접근기록 목록 조회
    @Override
    public Paging selectAcsOpnzAplListPaging(Params params) {
        Paging list = adminStatsPresentDao.selectAcsOpnzAplList(params, params.getPage(), params.getRows());

        return list;
    }
}

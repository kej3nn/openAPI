package egovframework.admin.expose.service;

import java.util.List;


import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

public interface AdminStatsPresentService {

    public List<Record> statAplDeal(Params params);

    public List<Record> statAplTakMth(Params params);

    public List<Record> statAplOpbFom(Params params);

    public List<Record> statClsdRson(Params params);

    public List<Record> statObjtnDeal(Params params);

    public Paging statAplResultPaging(Params params);

    public Paging statObjtnDealRsltPaging(Params params);

    public List<Record> statAplDcsDt(Params params);

    public Paging selectAplDcsdtListPaging(Params params);

    public Paging selectAcsOpnzAplListPaging(Params params);

}

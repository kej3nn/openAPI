package egovframework.admin.gaapi.service;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;

public interface AdminGaApiService {

    public void insertStatGaApiSave(Params params);

    public Paging selectStatAcesGGListPaging(Params params);

    public int statAcesGGCheckDup(Params params);

    public Paging selectStatPageGGListPaging(Params params);

    public int statPageGGCheckDup(Params params);

    public String getStatPageGGMaxStartDate(Params params);

    public String getStatAcesGGMaxStartDate(Params params);

    public Paging selectStatAreaGGListPaging(Params params);

    public int statAreaGGCheckDup(Params params);

    public String getStatAreaGGMaxStartDate(Params params);

    public Paging selectStatAcrtGGListPaging(Params params);

    public int statAcrtGGCheckDup(Params params);

    public String getStatAcrtGGMaxStartDate(Params params);

    public Paging selectStatPoplGGListPaging(Params params);

    public int statPoplGGCheckDup(Params params);

    public String getStatPoplGGMaxStartDate(Params params);

    public Paging selectStatAreaDGGListPaging(Params params);

    public int statAreaDGGCheckDup(Params params);

    public String getStatAreaDGGMaxStartDate(Params params);
}

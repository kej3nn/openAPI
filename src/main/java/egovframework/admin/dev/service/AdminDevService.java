package egovframework.admin.dev.service;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Result;

public interface AdminDevService {

    Paging selectDevMngListPaging(Params params);

    Result insertDevReceive(Params params);

}

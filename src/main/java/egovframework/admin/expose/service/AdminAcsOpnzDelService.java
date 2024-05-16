package egovframework.admin.expose.service;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Result;

public interface AdminAcsOpnzDelService {

    public Paging acsOpnzDelListPaging(Params params);

    Result saveAcsOpnzDel(Params params);

}

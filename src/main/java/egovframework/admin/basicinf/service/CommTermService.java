package egovframework.admin.basicinf.service;

import java.util.List;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;

public interface CommTermService {

    Paging searchCommTerm(Params params);

    List<Record> selectCommTerm(Params params);

    Result saveCommTerm(Params params);
}

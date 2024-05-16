package egovframework.admin.nadata.service;

import javax.servlet.http.HttpServletRequest;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;

public interface NaCmpsService {

    Paging selectNaCmpsListPaging(Params params);

    Record naCmpsDupChk(Params params);

    Object saveNaCmps(HttpServletRequest request, Params params);

    Record naCmpsDtl(Params params);

    Record selectNaCmpsThumbnail(Params params);

    Object deleteNaCmps(Params params);

    Result saveNaCmpsOrder(Params params);
}

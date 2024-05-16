package egovframework.admin.expose.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Result;

public interface AdminOpenDecisionService {

    public Paging searchOpnDcsPaging(Params params);

    public Map<String, Object> writeOpnDcs(Map<String, String> paramMap);

    public Map<String, Object> detailOpnDcs(Map<String, String> paramMap);

    Object saveOpnDcs(HttpServletRequest request, Params params);

    Object openStartOpnDcs(HttpServletRequest request, Params params);

    public Paging searchOpnObjtnProcPaging(Params params);

    public Map<String, Object> getWriteBaseInfo(Map<String, String> paramMap);

    public Map<String, Object> getUpdateBaseInfo(Map<String, String> paramMap);

    public Map<String, Object> detailOpnObjtnProc(Map<String, String> paramMap);

    public Result cancelOpnProd(HttpServletRequest request, Params params);
}

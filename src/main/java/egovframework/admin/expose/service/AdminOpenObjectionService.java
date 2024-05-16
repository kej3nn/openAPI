package egovframework.admin.expose.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Result;

public interface AdminOpenObjectionService {

    public Paging searchOpnObjtnPaging(Params params);

    public Map<String, Object> writeOpnObjtn(Map<String, String> paramMap);

    Object saveOpnObjtn(HttpServletRequest request, Params params);

    public Paging searchOpnObjtnProcPaging(Params params);

    public Map<String, Object> detailOpnObjtnProc(Map<String, String> paramMap);

    Object comOpnObjtnProc(HttpServletRequest request, Params params);

    Object saveOpnObjtnProc(HttpServletRequest request, Params params);

    public Map<String, Object> searchObjtnDcsProd(Params params);

    public Result insertOpnObjtnProd(HttpServletRequest request, Params params);

    Object openStartOpnObjtn(HttpServletRequest request, Params params);
}

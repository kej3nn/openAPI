package egovframework.admin.openapi.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;

public interface OpenApiMngService {

    List<Record> selectOrgList(Params params);

    Paging selectOpenApiMngListPaging(Params params);

    Object saveOpenApiMng(HttpServletRequest request, Params params);

    Record openApiMngDtl(Params params);

    Object deleteOpenApiMng(Params params);

}

package egovframework.admin.opendatamng.service;

import java.util.List;
import java.util.Map;

import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;

public interface OpenDataMngService {

    public List<Map<String, Object>> openApiLinkageMngListPaging(Params params);

    public Map<String, Object> openApiLinkageMngDtl(Map<String, String> paramMap);

    public List<Map<String, Object>> selectOpenApiLinkDsPopup(Params params);

    public List<Map<String, Object>> selectOpenApiLinkObjSPopup(Params params);

    public Result saveOpenApiLinkageMng(Params params);

    public List<Record> selectOption(Params params);

    public List<Map<String, Object>> openApiLinkageMonListPaging(Params params);

}

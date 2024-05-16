package egovframework.admin.opendatamng.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Params;

@Repository(value = "openDataMngDao")
public class OpenDataMngDao extends BaseDao {

    /**
     * API 연계설정 리스트 조회
     */
    public List<Map<String, Object>> openApiLinkageMngList(Params params) {
        return (List<Map<String, Object>>) list("OpenDataMngDao.openApiLinkageMngList", params);
    }

    /**
     * API 연계설정 상세 조회
     */
    public Map<String, Object> selectOpenApiLinkageMngDtl(Map<String, String> paramMap) {
        return (Map<String, Object>) select("OpenDataMngDao.selectOpenApiLinkageMngDtl", paramMap);
    }

    /**
     * API 연계설정  저장 데이터셋 데이터 리스트 조회
     *
     * @param params
     * @return
     */
    public List<Map<String, Object>> selectOpenApiLinkDsPopList(Params params) {
        return (List<Map<String, Object>>) list("OpenDataMngDao.selectOpenApiLinkDsPopList", params);
    }

    /**
     * API 연계설정  대상객체(통계데이터) 데이터 리스트 조회
     *
     * @param params
     * @return
     */
    public List<Map<String, Object>> selectOpenApiLinkObjSPopList(Params params) {
        return (List<Map<String, Object>>) list("OpenDataMngDao.selectOpenApiLinkObjSPopList", params);
    }

    /**
     * API 연계설정을 등록한다.
     */
    public Object insertOpenApiLinkageMng(Params params) {
        return insert("OpenDataMngDao.insertStatStddMeta", params);
    }

    /**
     * API 연계설정을 수정한다.
     */
    public Object updateOpenApiLinkageMng(Params params) {
        return update("OpenDataMngDao.updateStatStddMeta", params);
    }

    /**
     * API 연계설정을 삭제한다.
     */
    public Object deleteOpenApiLinkageMng(Params params) {
        return delete("OpenDataMngDao.deleteOpenApiLinkageMng", params);
    }

    //공통코드 값을 조회한다.
    public List<?> selectOption(Params params) {
        return search("OpenDataMngDao.selectOption", params);
    }


    /**
     * API연계모니터링 리스트 조회
     */
    public List<Map<String, Object>> openApiLinkageMonList(Params params) {
        return (List<Map<String, Object>>) list("OpenDataMngDao.openApiLinkageMonList", params);

    }
}

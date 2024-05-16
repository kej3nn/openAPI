package egovframework.admin.openapi.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

@Repository(value = "openApiMngDao")
public class OpenApiMngDao extends BaseDao {

    /**
     * 메인 리스트 조회(페이징 처리)
     */
    public Paging selectOpenApiMngList(Params params, int page, int rows) {
        return search("OpenApiMngDao.selectOpenApiMngList", params, page, rows, PAGING_SCROLL);
    }

    public List<Record> selectOrgList(Params params) {
        return (List<Record>) list("OpenApiMngDao.selectOrgList", params);
    }

    /**
     * 제공 OPENAPI 저장
     *
     * @param params
     * @return
     */
    public Object saveOpenApiMng(Params params) {
        return merge("OpenApiMngDao.mergeOpenApiMng", params);
    }

    /**
     * 제공 OPENAPI 조회
     *
     * @param params
     * @return
     */
    public Object selectOpenApiMngDtl(Params params) {
        return select("OpenApiMngDao.selectOpenApiMngDtl", params);
    }

    /**
     * 제공 OPENAPI 삭제
     *
     * @param params
     * @return
     */
    public Object deleteOpenApiMng(Params params) {
        return delete("OpenApiMngDao.deleteOpenApiMng", params);
    }

}

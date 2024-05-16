package egovframework.portal.openapi.service;

import java.util.List;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

public interface PortalOpenApiService {

    /**
     * Open API 전체목록을 검색한다.
     *
     * @param params 파라메터
     * @return 검색결과
     */
    public Paging searchOpenApiList(Params params);

    public List<Record> selectOpenApiItmCd(Params params);

    /**
     * OPEN API 를 조회한다.
     *
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectOpenApiSrvMetaCUD(Params params);

    public Paging selectInfsOpenApiListPaging(Params params);

    public Paging selectOpenApiSupplyListPaging(Params params);

    public List<?> selectOpenApiSupplyList(Params params);

    public List<?> selectGuideList(Params params);
}

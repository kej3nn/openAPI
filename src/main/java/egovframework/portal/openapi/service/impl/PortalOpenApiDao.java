package egovframework.portal.openapi.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;
import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

@Repository("portalOpenApiDao")
public class PortalOpenApiDao extends BaseDao {


    /**
     * 공공데이터 데이터셋 전체목록을 검색한다.
     *
     * @param params 파라메터
     * @param page   페이지 번호
     * @param size   페이지 크기
     * @return 검색결과
     */
    public Paging searchOpenApiList(Params params, int page, int size) {
        // 공공데이터 데이터셋 전체목록을 검색한다.
        return search("PortalOpenApiDao.searchOpenApiList", params, page, size, PAGING_MANUAL);
    }


    /**
     * 통계표 항목분류 리스트 조회
     *
     * @param params
     * @return
     */
    public List<?> selectOpenApiItmCd(Params params) {
        return list("PortalOpenApiDao.selectOpenApiItmCd", params);
    }


    /**
     * OPEN API를 조회한다.
     *
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectOpenApiSrvMeta(Params params) {
        // 공공데이터 서비스 메타정보를 조회한다.
        return (Record) select("PortalOpenApiDao.selectOpenApiSrvMeta", params);
    }

    /**
     * Open API 목록을 조회한다.(국회사무처)
     */
    public Paging selectInfsOpenApiListPaging(Params params, int page, int size) {
        return search("PortalOpenApiDao.selectInfsOpenApiListPaging", params, page, size, PAGING_MANUAL);
    }

    /**
     * Open API 목록을 조회한다.(국회사무처)
     */
    public Paging selectOpenApiSupplyListPaging(Params params, int page, int size) {
        return search("PortalOpenApiDao.selectOpenApiSupplyListPaging", params, page, size, PAGING_MANUAL);
    }

    /**
     * Open API 목록을 조회한다.(국회사무처)
     */
    public List<?> selectOpenApiSupplyList(Params params) {
        return search("PortalOpenApiDao.selectOpenApiSupplyListPaging", params);
    }

    /**
     * 활용가이드 리스트 조회
     *
     * @param params
     * @return
     */
    public List<?> selectGuideList(Params params) {
        return list("PortalOpenApiDao.selectGuideList", params);
    }

}

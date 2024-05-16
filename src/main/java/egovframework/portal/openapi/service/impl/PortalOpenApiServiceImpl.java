package egovframework.portal.openapi.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.portal.openapi.service.PortalOpenApiService;
import egovframework.ggportal.data.service.impl.PortalOpenInfSrvServiceImpl;


@Service("portalOpenApiService")
public class PortalOpenApiServiceImpl extends PortalOpenInfSrvServiceImpl implements PortalOpenApiService {

    @Resource(name = "portalOpenApiDao")
    private PortalOpenApiDao portalOpenApiDao;

    /**
     * 공공데이터 데이터셋 전체목록을 검색한다.
     *
     * @param params 파라메터
     * @return 검색결과
     */
    public Paging searchOpenApiList(Params params) {
        params.put("orgCd", params.getStringArray("orgCd"));
        params.put("cateId", params.getStringArray("cateId"));
        params.put("srvCd", params.getStringArray("srvCd"));
        params.put("schwTagCont", params.getStringArray("schwTagCont"));
        params.put("searchWord", params.getString("searchWord"));

        // 공공데이터 데이터셋 전체목록을 검색한다.
        return portalOpenApiDao.searchOpenApiList(params, params.getPage(), params.getRows());
    }

    /**
     * 통계표 항목분류 리스트 조회
     */
    public List<Record> selectOpenApiItmCd(Params params) {
        return (List<Record>) portalOpenApiDao.selectOpenApiItmCd(params);
    }


    /**
     * OPEN API를 조회한다.
     *
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectOpenApiSrvMetaCUD(Params params) {
        // 공공데이터 서비스 메타정보를 조회한다.
        Record meta = portalOpenApiDao.selectOpenApiSrvMeta(params);
        try {
            // 메타정보가 없는 경우
            if (meta == null) {
                throw new ServiceException("portal.error.000026", getMessage("portal.error.000026"));
            }

            // 공공데이터 서비스 조회이력을 등록한다.
            insertOpenInfSrvHist(params);

            // 공공데이터 서비스 조회수를 수정한다.
            updateOpenInfSrvHits(params);

        } catch (ServiceException sve) {
            EgovWebUtil.exTransactionLogging(sve);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }

        return meta;
    }

    /**
     * Open API 목록을 조회한다.(국회사무처)
     */
    @Override
    public Paging selectInfsOpenApiListPaging(Params params) {
        // 분류체계
        String[] schHdnCateId = params.getStringArray("schHdnCateId");
        ArrayList<String> schArrCateId = new ArrayList<String>(Arrays.asList(schHdnCateId));
        params.set("schArrCateId", schArrCateId);
        

        return portalOpenApiDao.selectInfsOpenApiListPaging(params, params.getPage(), params.getRows());
    }

    @Override
    public Paging selectOpenApiSupplyListPaging(Params params) {
        // 기관
        String[] schHdnOrgCd = params.getStringArray("schHdnOrgCd");
        ArrayList<String> schArrOrgCd = new ArrayList<String>(Arrays.asList(schHdnOrgCd));
        params.set("schArrOrgCd", schArrOrgCd);
        return portalOpenApiDao.selectOpenApiSupplyListPaging(params, params.getPage(), params.getRows());
    }


    @Override
    public List<?> selectOpenApiSupplyList(Params params) {
        // 기관
        String[] schHdnOrgCd = params.getStringArray("schHdnOrgCd");
        ArrayList<String> schArrOrgCd = new ArrayList<String>(Arrays.asList(schHdnOrgCd));
        params.set("schArrOrgCd", schArrOrgCd);
        return portalOpenApiDao.selectOpenApiSupplyList(params);
    }

    @Override
    public List<Record> selectGuideList(Params params) {
        return (List<Record>) portalOpenApiDao.selectGuideList(params);
    }
}

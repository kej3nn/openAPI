package egovframework.admin.nadata.service.impl;

import java.util.List;


import org.springframework.stereotype.Repository;

import egovframework.admin.nadata.service.impl.NaDataSiteMapDao;
import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;


/**
 * 국회 정보 사이트맵을 관리하는 DAO 클래스
 *
 * @version 1.0
 * @author 김재한
 * @since 2019/09/09
 */


@Repository(value = "naDataSiteMapDao")
public class NaDataSiteMapDao extends BaseDao {


    /**
     * 메인 리스트 조회(페이징 처리)
     */
    public Paging selectMainList(Params params, int page, int rows) {
        return search("naDataSiteMapDao.selectMainList", params, page, rows, PAGING_SCROLL);
    }

    /**
     * 기관정보 리스트
     *
     * @param params
     * @return
     */
    public List<Record> selectOrgList(Params params) {
        return (List<Record>) list("naDataSiteMapDao.selectOrgList", params);
    }

    /**
     * 사이트맵 ID 중복 체크
     *
     * @param params
     * @return
     */
    public Object selectNaDataSiteMapDupChk(Params params) {
        return select("naDataSiteMapDao.selectNaDataSiteMapDupChk", params);
    }

    /**
     * 사이트맵 정보 저장
     *
     * @param params
     * @return
     */
    public Object saveNaDataSiteMap(Params params) {
        return merge("naDataSiteMapDao.mergeNaDataSiteMap", params);
    }

    /**
     * 사이트맵 정보 저장
     *
     * @param params
     * @return
     */
    public Object selectNaDataSiteMapDtl(Params params) {
        return select("naDataSiteMapDao.selectNaDataSiteMapDtl", params);
    }

    public Object deleteNaDataSiteMap(Params params) {
        return delete("naDataSiteMapDao.deleteNaDataSiteMap", params);
    }

    /**
     * 사이트맵 순서 저장
     *
     * @param record
     * @return
     */
    public Object saveNaDataSiteMapOrder(Record record) {
        return update("naDataSiteMapDao.saveNaDataSiteMapOrder", record);
    }
}

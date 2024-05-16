package egovframework.admin.nadata.service.impl;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

@Repository(value = "naCmpsDao")
public class NaCmpsDao extends BaseDao {
    /**
     * 메인 리스트 조회(페이징 처리)
     */
    public Paging selectNaCmpsList(Params params, int page, int rows) {
        return search("NaCmpsDao.selectNaCmpsList", params, page, rows, PAGING_SCROLL);
    }

    /**
     * 정보카달로그 ID 중복 체크
     *
     * @param params
     * @return
     */
    public Object selectNaCmpsDupChk(Params params) {
        return select("NaCmpsDao.selectNaCmpsDupChk", params);
    }

    /**
     * 정보카달로그 정보 저장
     *
     * @param params
     * @return
     */
    public Object saveNaCmps(Params params) {
        return merge("NaCmpsDao.mergeNaCmps", params);
    }

    /**
     * 정보카달로그 상세 조회
     *
     * @param params
     * @return
     */
    public Object selectNaCmpsDtl(Params params) {
        return select("NaCmpsDao.selectNaCmpsDtl", params);
    }

    /**
     * 정보카달로그 정보 삭제
     *
     * @param params
     * @return
     */
    public Object deleteNaCmps(Params params) {
        return delete("NaCmpsDao.deleteNaCmps", params);
    }

    /**
     * 정보카달로그 순서 저장
     *
     * @param record
     * @return
     */
    public Object saveNaDataSiteMapOrder(Record record) {
        return update("NaCmpsDao.saveNaDataSiteMapOrder", record);
    }
}

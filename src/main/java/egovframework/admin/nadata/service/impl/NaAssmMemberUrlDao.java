package egovframework.admin.nadata.service.impl;


import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;

/**
 * 관리자 - 국회의원 URL 관리 DAO 클래스
 *
 * @version 1.0
 * @author JHKIM
 * @since 2020/11/11
 */
@Repository(value = "naAssmMemberUrlDao")
public class NaAssmMemberUrlDao extends BaseDao {

    /**
     * 데이터 조회 - 페이징
     *
     * @param params
     * @param page
     * @param rows
     * @return
     */
    public Paging searchNaAssmMemberUrl(Params params, int page, int rows) {
        return search("naAssmMemberUrlDao.searchNaAssmMemberUrl", params, page, rows, PAGING_SCROLL);
    }

    /**
     * 데이터 수정
     *
     * @param params
     * @return
     */
    public Object saveNaAssmMemberUrl(Params params) {
        return update("naAssmMemberUrlDao.saveNaAssmMemberUrl", params);
    }

    /**
     * URL 코드 중복체크
     *
     * @param params
     * @return
     */
    public int selectDuplicateNaAssmMemberUrl(Params params) {
        return (Integer) select("naAssmMemberUrlDao.selectDuplicateNaAssmMemberUrl", params);
    }
}

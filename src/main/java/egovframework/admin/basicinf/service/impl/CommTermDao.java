package egovframework.admin.basicinf.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 관리자 - 동의어 관리
 *
 * @author JHKIM
 * @version 1.0
 * @since 2019/11/12
 */
@Repository(value = "commTermDao")
public class CommTermDao extends BaseDao {

    /**
     * 데이터를 조회한다. - 페이징
     */
    Paging searchCommTerm(Params params, int page, int rows) {
        return search("commTermDao.searchCommTerm", params, page, rows, PAGING_MANUAL);
    }

    /**
     * 데이터를 조회한다.
     *
     * @param params
     * @return
     */
    List<Record> selectCommTerm(Params params) {
        return (List<Record>) list("commTermDao.searchCommTerm", params);
    }

    /**
     * 입력 중복체크
     */
    int selectCommTermDup(Params params) {
        return (Integer) select("commTermDao.selectCommTermDup", params);
    }

    /**
     * 데이터를 등록한다.
     */
    Object insertCommTerm(Params params) {
        return insert("commTermDao.insertCommTerm", params);
    }

    /**
     * 데이터를 수정한다.
     */
    Object updateCommTerm(Params params) {
        return update("commTermDao.updateCommTerm", params);
    }

    /**
     * 데이터를 삭제한다.
     */
    Object deleteCommTerm(Params params) {
        return delete("commTermDao.deleteCommTerm", params);
    }
}

package egovframework.admin.expose.service.impl;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 기관관리 관리를 위한 DAO 클래스
 *
 * @author 정인선
 * @since 2019.08.27
 */

@Repository("AdminInstMgmtDao")
public class AdminInstMgmtDao extends BaseDao {

    /**
     * 기관정보 전체조회
     *
     * @param params
     * @return
     */

    public List<?> selectInstMgmtListTree(Params params) throws DataAccessException, Exception {
        return list("AdminInstMgmtDao.selectInstMgmtListTree", params);
    }

    /**
     * 기관정보 등록
     *
     * @param commOrg
     */
    public void insertInstMgmt(Params params) {
        merge("AdminInstMgmtDao.insertInstMgmt", params);

    }

    /**
     * 기관정보 단건조회
     *
     * @param params
     * @return
     */
    public Record instMgmtRetr(Params params) {
        return (Record) select("AdminInstMgmtDao.instMgmtRetr", params);
    }
}

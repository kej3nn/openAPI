package egovframework.admin.basicinf.service.impl;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.admin.basicinf.service.CommMenuAcc;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * 메뉴 관리를 위한 데이터 접근 클래스
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */
@Repository("CommMenuAccDAO")
public class CommMenuAccDAO extends EgovComAbstractDAO {

    /**
     * 전체 리스트 조회
     *
     * @param commMenu
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<CommMenuAcc> selectMenuList(CommMenuAcc commMenuAcc) throws DataAccessException, Exception {
        return (List<CommMenuAcc>) list("CommMenuAccDAO.selectMenuList", commMenuAcc);
    }

    /**
     * 전체 리스트 조회 건수
     *
     * @param commMenu
     * @return
     * @throws DataAccessException, Exception
     */
    public int selectMenuListCnt(CommMenuAcc commMenuAcc) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("CommMenuAccDAO.selectMenuListCnt", commMenuAcc);
    }

    /**
     * 메뉴권한을 저장한다
     *
     * @param saveVO
     * @return
     * @throws DataAccessException, Exception
     */
    public int updateCommMenuAcc(CommMenuAcc saveVO) throws DataAccessException, Exception {
        return (Integer) update("CommMenuAccDAO.updateCommMenuAcc", saveVO);
    }

}


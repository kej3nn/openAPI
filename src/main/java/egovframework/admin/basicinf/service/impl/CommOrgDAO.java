package egovframework.admin.basicinf.service.impl;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.admin.basicinf.service.CommOrg;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * 조직정보 관리를 위한 DAO 클래스
 *
 * @author KJH
 * @since 2014.07.17
 */

@Repository("CommOrgDAO")
public class CommOrgDAO extends EgovComAbstractDAO {


    /**
     * 조직정보 팝업
     *
     * @param CommUsr
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<CommOrg> selectCommOrgListAll(CommOrg commOrg) throws DataAccessException, Exception {
        return (List<CommOrg>) list("CommOrgDAO.selectCommOrgListAll", commOrg);
    }


    /**
     * 조직정보 전체조회
     *
     * @param commOrg
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<CommOrg> selectCommOrgListTree(CommOrg commOrg) throws DataAccessException, Exception {
        return (List<CommOrg>) list("CommOrgDAO.selectCommOrgListTree", commOrg);
    }

    /**
     * 조직코드 체크
     *
     * @param commOrg
     * @return
     */
    public int selectCommOrgCdDup(CommOrg commOrg) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("CommOrgDAO.selectCommOrgCdDup", commOrg);

    }


    /**
     * 조직정보 등록
     *
     * @param commOrg
     * @return
     */
    public int insertCommOrg(CommOrg commOrg) throws DataAccessException, Exception {
        return (Integer) update("CommOrgDAO.insertCommOrg", commOrg);

    }

    /**
     * 조직정보 단건조회
     * @param commOrg
     * @return
     */
    //public CommOrg commOrgRetr(CommOrg commOrg) {
    //	return (CommOrg)selectByPk("CommOrgDAO.commOrgRetr", commOrg);
    //}

    /**
     * 조직정보 단건조회
     *
     * @param commOrg
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<CommOrg> commOrgRetr(CommOrg commOrg) throws DataAccessException, Exception {
        return (List<CommOrg>) list("CommOrgDAO.commOrgRetr", commOrg);
    }

    /**
     * 조직정보 삭제(하위조직 같이 삭제)
     *
     * @param commOrg
     * @return
     */
    public int deleteLowCommOrg(CommOrg commOrg) throws DataAccessException, Exception {
        return (Integer) update("CommOrgDAO.deleteLowCommOrg", commOrg);
    }

    /**
     * 조직정보 수정
     *
     * @param commOrg
     * @return
     */
    public int updateCommOrg(CommOrg commOrg) throws DataAccessException, Exception {
        return (Integer) update("CommOrgDAO.updateCommOrg", commOrg);
    }

    /**
     * 조직정보 미사용 체크시 하위메뉴 모두 미사용 처리
     *
     * @param commOrg
     * @return
     */
    public int updateLowUseYnCommOrg(CommOrg commOrg) throws DataAccessException, Exception {
        return (Integer) update("CommOrgDAO.updateLowUseYnCommOrg", commOrg);
    }

    /**
     * 조직정보 메뉴순서 수정
     *
     * @param commOrg
     * @return
     * @throws DataAccessException, Exception
     */
    public int commOrgListUpdateTreeOrder(CommOrg commOrg) throws DataAccessException, Exception {
        return (Integer) update("CommOrgDAO.commOrgListUpdateTreeOrder", commOrg);
    }


    /**
     * 해당 조직명이 변경시 하위분류의 해당조직명도 같이 변경하도록 하기위해 조회부터한다.
     *
     * @param commOrg
     * @return
     * @throws DataAccessException, Exception
     */
    public List<CommOrg> getOrgFullNmQuery(CommOrg commOrg) throws DataAccessException, Exception {
        return (List<CommOrg>) list("CommOrgDAO.getOrgFullNmQuery", commOrg);
    }

    /**
     * 하위분류의 해당 조직명도 변경하기 위해 조되한 data로 해당하는 것 모두 변경한다.
     *
     * @param commOrg
     * @return
     * @throws DataAccessException, Exception
     */
    public int actOrgFullNmUpd(CommOrg commOrg) throws DataAccessException, Exception {
        return (Integer) update("CommOrgDAO.actOrgFullNmUpd", commOrg);
    }

}

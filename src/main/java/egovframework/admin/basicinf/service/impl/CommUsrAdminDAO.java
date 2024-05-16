package egovframework.admin.basicinf.service.impl;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.admin.basicinf.service.CommUsrAdmin;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * 담당자관리 DAO
 *
 * @author KJH
 * @since 2014.07.23
 */
@Repository("CommUsrAdminDAO")
public class CommUsrAdminDAO extends EgovComAbstractDAO {


    /**
     * 사용자 체크 한다.
     *
     * @param commUsrAdmin
     * @return
     * @throws DataAccessException, Exception
     */
    public CommUsrAdmin selectCommUsrAdminCheck(CommUsrAdmin commUsrAdmin) throws DataAccessException, Exception {
        return (CommUsrAdmin) selectByPk("CommUsrAdminDAO.selectCommUsrAdminCheck", commUsrAdmin);
    }

    /**
     * 사용자 정보를 전체 조회 한다.
     *
     * @param CommUsr
     * @return
     * @throws DataAccessException, Exception
     */

    @SuppressWarnings("unchecked")
    public List<CommUsrAdmin> selectCommUsrAdminListAll(CommUsrAdmin commUsrAdmin) throws DataAccessException, Exception {
        return (List<CommUsrAdmin>) list("CommUsrAdminDAO.selectCommUsrAdminListAll", commUsrAdmin);
    }

    /**
     * 사용자 정보를 전체 건수를 조회  한다.
     *
     * @param CommUsr
     * @return
     * @throws DataAccessException, Exception
     */

    public int selectCommUsrAdminListAllCnt(CommUsrAdmin commUsrAdmin) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("CommUsrAdminDAO.selectCommUsrAdminListAllCnt", commUsrAdmin);
    }

    /**
     * 사용자 단건 조회
     *
     * @param commUsrAdmin
     * @return
     * @throws DataAccessException, Exception
     */
    public CommUsrAdmin selectCommUsrAdminDtlInfo(CommUsrAdmin commUsrAdmin) throws DataAccessException, Exception {
        return (CommUsrAdmin) selectByPk("CommUsrAdminDAO.selectCommUsrAdminDtlInfo", commUsrAdmin);
    }

    /**
     * 직원팝업 검색
     *
     * @param commUsrAdmin
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<CommUsrAdmin> selectCommUsrAdminPopList(CommUsrAdmin commUsrAdmin) throws DataAccessException, Exception {
        return (List<CommUsrAdmin>) list("CommUsrAdminDAO.selectCommUsrAdminPopList", commUsrAdmin);
    }

    /**
     * 직원팝업 검색(직책추가)
     *
     * @param commUsrAdmin
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<CommUsrAdmin> selectCommUsrAdminPosPopList(CommUsrAdmin commUsrAdmin) throws DataAccessException, Exception {
        return (List<CommUsrAdmin>) list("CommUsrAdminDAO.selectCommUsrAdminPosPopList", commUsrAdmin);
    }

    /**
     * 담당자 정보 등록
     *
     * @param commUsrAdmin
     * @return
     * @throws DataAccessException, Exception
     */
    public int save(CommUsrAdmin commUsrAdmin) throws DataAccessException, Exception {
        return (Integer) update("CommUsrAdminDAO.save", commUsrAdmin);
    }

    /**
     * 담당자 정보 수정
     *
     * @param commUsrAdmin
     * @return
     * @throws DataAccessException, Exception
     */
    public int update(CommUsrAdmin commUsrAdmin) throws DataAccessException, Exception {
        return (Integer) update("CommUsrAdminDAO.update", commUsrAdmin);
    }

    /**
     * 담당자 승인
     *
     * @param commUsrAdmin
     * @return
     * @throws DataAccessException, Exception
     */
    public int approval(CommUsrAdmin commUsrAdmin) throws DataAccessException, Exception {
        return (Integer) update("CommUsrAdminDAO.approval", commUsrAdmin);
    }

    /**
     * 담당자 승인 취소
     *
     * @param commUsrAdmin
     * @return
     * @throws DataAccessException, Exception
     */
    public int approvalCancel(CommUsrAdmin commUsrAdmin) throws DataAccessException, Exception {
        return (Integer) update("CommUsrAdminDAO.approvalCancel", commUsrAdmin);
    }

    /**
     * 담당자ID 중복체크
     *
     * @param commUsrAdmin
     * @return
     * @throws DataAccessException, Exception
     */
    public int usrIdDup(CommUsrAdmin commUsrAdmin) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("CommUsrAdminDAO.idDup", commUsrAdmin);
    }

    /**
     * 비밀번호 초기화시 랜덤문자
     *
     * @return
     * @throws DataAccessException, Exception
     */
    public String randomPw() throws DataAccessException, Exception {
        return (String) selectByPk("CommUsrAdminDAO.randomPw", "");
        //(String)getSqlMapClientTemplate().se

    }

    /**
     * 생성된 랜덤문자 비밀번호 초기화
     *
     * @param commUsrAdmin
     * @return
     * @throws DataAccessException, Exception
     */
    public int initialPw(CommUsrAdmin commUsrAdmin) throws DataAccessException, Exception {
        return (Integer) update("CommUsrAdminDAO.initialPw", commUsrAdmin);
    }


}

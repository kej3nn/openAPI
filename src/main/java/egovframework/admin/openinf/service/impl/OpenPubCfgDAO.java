package egovframework.admin.openinf.service.impl;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.admin.openinf.service.OpenPubCfg;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * 분류정보 관리를 위한 데이터 접근 클래스
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.07.16
 */
@Repository("OpenPubCfgDAO")
public class OpenPubCfgDAO extends EgovComAbstractDAO {

    /**
     * 공표기준 목록을 전체 조회한다.
     *
     * @param OpenPubCfg
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<OpenPubCfg> selectOpenPubCfgListAll(OpenPubCfg openPubCfg) throws DataAccessException, Exception {
        return (List<OpenPubCfg>) list("OpenPubCfgDAO.selectOpenPubCfgListAll", openPubCfg);
    }

    /**
     * 공표기준 목록의 전체 건수를 조회 한다.
     *
     * @param OpenPubCfg
     * @return
     * @throws DataAccessException, Exception
     */
    public int selectOpenPubCfgListAllCnt(OpenPubCfg openPubCfg) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject(
                "OpenPubCfgDAO.selectOpenPubCfgListAllCnt", openPubCfg);
    }

    /**
     * 관련데이터셋 중복을 체크한다.
     *
     * @param OpenPubCfg
     * @return
     * @throws DataAccessException, Exception
     */
    public int selectOpenPubCfgRefDsCheckDup(OpenPubCfg openPubCfg) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenPubCfgDAO.selectOpenPubCfgRefDsCheckDup", openPubCfg);
    }

    /**
     * 분류항목을 단건 조회한다.
     *
     * @param OpenCate
     * @return
     * @throws DataAccessException, Exception
     */
    public OpenPubCfg selectOpenPubCfgOne(OpenPubCfg openPubCfg) throws DataAccessException, Exception {
        return (OpenPubCfg) selectByPk("OpenPubCfgDAO.selectOpenPubCfgOne", openPubCfg);
    }

    /**
     * 공표기준 컬럼 list를 조회한다.
     *
     * @param openPubCfg
     * @param model
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<OpenPubCfg> selectRefColId(OpenPubCfg openPubCfg) throws DataAccessException, Exception {
        return (List<OpenPubCfg>) list("OpenPubCfgDAO.selectRefColId", openPubCfg);
    }


    /**
     * 공표기준의 Id중 MAX값을 가져오고 1을 더한다.
     *
     * @param OpenCfg
     * @return Integer
     * @throws DataAccessException, Exception
     */
    public int getOpenPubCfgMaxId(OpenPubCfg openPubCfg) throws DataAccessException, Exception {
        return (Integer) selectByPk("OpenPubCfgDAO.getOpenPubCfgMaxId", openPubCfg);
    }

    /**
     * 공표기준을 등록한다.
     *
     * @param OpenCfg
     * @return Integer
     * @throws DataAccessException, Exception
     */
    public int insertOpenCfg(OpenPubCfg openPubCfg) throws DataAccessException, Exception {
        return (Integer) update("OpenPubCfgDAO.insertOpenCfg", openPubCfg);
    }

    /**
     * 연간 공표일정을 등록한다.
     *
     * @param OpenCfg
     * @return Integer
     * @throws DataAccessException, Exception
     */
    public OpenPubCfg callSPM(OpenPubCfg openPubCfg) throws DataAccessException, Exception {
        getSqlMapClientTemplate().queryForObject("OpenPubCfgDAO.callSPM", openPubCfg);
        return openPubCfg;
    }

    /**
     * 공표기준을 삭제 한다.
     *
     * @param OpenCfg
     * @return
     * @throws DataAccessException, Exception
     */
    public int deleteOpenCfg(OpenPubCfg openPubCfg) throws DataAccessException, Exception {
        return (Integer) delete("OpenPubCfgDAO.deleteOpenCfg", openPubCfg);
    }

    /**
     * 공표기준을 수정 한다.
     *
     * @param OpenCfg
     * @return
     * @throws DataAccessException, Exception
     */
    public int updateOpenCfg(OpenPubCfg openPubCfg) throws DataAccessException, Exception {
        return (Integer) delete("OpenPubCfgDAO.updateOpenCfg", openPubCfg);
    }

    /**
     * OPEN_DS의 PUB_YN을 수정 한다. (인자값에 따라 수정)
     *
     * @param OpenCfg
     * @return
     * @throws DataAccessException, Exception
     */
    public int updateOpenDsPubYn(OpenPubCfg openPubCfg) throws DataAccessException, Exception {
        return (Integer) delete("OpenPubCfgDAO.updateOpenDsPubYn", openPubCfg);
    }

    /**
     * OPEN_DSCOL의 PUB_YN을 수정 한다. (인자값에 따라 수정)
     *
     * @param OpenCfg
     * @return
     * @throws DataAccessException, Exception
     */
    public int updateOpenDsColPubYn(OpenPubCfg openPubCfg) throws DataAccessException, Exception {
        return (Integer) delete("OpenPubCfgDAO.updateOpenDsColPubYn", openPubCfg);
    }

    /**
     * OPEN_DS의 PUB_YN을 수정 한다. (무조건 N으로 수정)
     *
     * @param OpenCfg
     * @return
     * @throws DataAccessException, Exception
     */
    public int updateOpenDsPubN(OpenPubCfg openPubCfg) throws DataAccessException, Exception {
        return (Integer) delete("OpenPubCfgDAO.updateOpenDsPubN", openPubCfg);
    }

    /**
     * OPEN_DSCOL의 PUB_YN을 수정 한다. (무조건 N으로 수정)
     *
     * @param OpenCfg
     * @return
     * @throws DataAccessException, Exception
     */
    public int updateOpenDsColPubN(OpenPubCfg openPubCfg) throws DataAccessException, Exception {
        return (Integer) delete("OpenPubCfgDAO.updateOpenDsColPubN", openPubCfg);
    }

}

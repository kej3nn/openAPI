package egovframework.admin.openinf.service.impl;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.admin.openinf.service.OpenDt;
import egovframework.admin.openinf.service.OpenDtbl;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("OpenDtDAO")
public class OpenDtDAO extends EgovComAbstractDAO {

    @SuppressWarnings("unchecked")
    public List<OpenDt> selectOpenDtList(OpenDt openDt) throws DataAccessException, Exception {
        return (List<OpenDt>) list("OpenDtDAO.selectOpenDtList", openDt);
    }

    public int selectOpenDtListCnt(OpenDt openDt) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenDtDAO.selectOpenDtListCnt", openDt);
    }

    public OpenDt selectOpenDtDtl(OpenDt openDt) throws DataAccessException, Exception {
        return (OpenDt) selectByPk("OpenDtDAO.selectOpenDtDtl", openDt);
    }

    @SuppressWarnings("unchecked")
    public List<OpenDtbl> selectOpenDtblList(OpenDtbl openDtbl) throws DataAccessException, Exception {
        return (List<OpenDtbl>) list("OpenDtDAO.selectOpenDtblList", openDtbl);
    }

    public int selectOpenDtblListCnt(OpenDtbl openDtbl) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenDtDAO.selectOpenDtblListCnt", openDtbl);
    }

    @SuppressWarnings("unchecked")
    public List<OpenDtbl> selectOpenDtSrcPopList(OpenDtbl openDtbl) throws DataAccessException, Exception {
        return (List<OpenDtbl>) list("OpenDtDAO.selectOpenDtSrcPopList", openDtbl);
    }

    public int selectOpenDtSrcPopListCnt(OpenDtbl openDtbl) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenDtDAO.selectOpenDtSrcPopListCnt", openDtbl);
    }


    public int getDtId(OpenDtbl openDtbl) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenDtDAO.getDtId", openDtbl);
    }

    public int insertDt(OpenDtbl openDtbl) throws DataAccessException, Exception {
        return (Integer) update("OpenDtDAO.insertDt", openDtbl);
    }

    public int updateDt(OpenDtbl openDtbl) throws DataAccessException, Exception {
        return (Integer) update("OpenDtDAO.updateDt", openDtbl);
    }

    public int deleteDt(OpenDtbl openDtbl) throws DataAccessException, Exception {
        return (Integer) update("OpenDtDAO.deleteDt", openDtbl);
    }

    public int insertDtbl(OpenDtbl saveVO) throws DataAccessException, Exception {
        return (Integer) update("OpenDtDAO.insertDtbl", saveVO);
    }

    public int updateDtbl(OpenDtbl saveVO) throws DataAccessException, Exception {
        return (Integer) update("OpenDtDAO.updateDtbl", saveVO);
    }

    public int deleteDtbl(OpenDtbl saveVO) throws DataAccessException, Exception {
        return (Integer) update("OpenDtDAO.deleteDtbl", saveVO);
    }

    public int getUseDtInf(OpenDtbl openDtbl) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenDtDAO.getUseDtInf", openDtbl);
    }

    public int selectReg(OpenDtbl saveVO) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenDtDAO.selectReg", saveVO);
    }

}

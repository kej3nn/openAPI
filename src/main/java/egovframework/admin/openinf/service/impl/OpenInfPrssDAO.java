package egovframework.admin.openinf.service.impl;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.admin.openinf.service.OpenInf;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("OpenInfPrssDAO")
public class OpenInfPrssDAO extends EgovComAbstractDAO {

    @SuppressWarnings("unchecked")
    public List<OpenInf> selectOpenInfPrssListAll(OpenInf openInf) throws DataAccessException, Exception {
        return (List<OpenInf>) list("OpenInfPrssDAO.selectOpenInfPrssListAll", openInf);
    }

    public int selectOpenInfPrssListAllCnt(OpenInf openInf) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfPrssDAO.selectOpenInfPrssListAllCnt", openInf);
    }

    @SuppressWarnings("unchecked")
    public List<OpenInf> selectOpenInfPrssDtl(OpenInf openInf) throws DataAccessException, Exception {
        return (List<OpenInf>) list("OpenInfPrssDAO.selectOpenInfPrssDtl", openInf);
    }

    public int insertLog(OpenInf saveVO) throws DataAccessException, Exception {
        return (Integer) update("OpenInfPrssDAO.insertLog", saveVO);
    }

    public int updateOpenInfPrss(OpenInf saveVO) throws DataAccessException, Exception {
        return (Integer) update("OpenInfPrssDAO.updateOpenInfPrss", saveVO);
    }

    @SuppressWarnings("unchecked")
    public List<OpenInf> selectOpenInfPrssLogList(OpenInf openInf) throws DataAccessException, Exception {
        return (List<OpenInf>) list("OpenInfPrssDAO.selectOpenInfPrssLogList", openInf);
    }

    public int selectOpenInfPrssLogListCnt(OpenInf openInf) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfPrssDAO.selectOpenInfPrssLogListCnt", openInf);
    }

}

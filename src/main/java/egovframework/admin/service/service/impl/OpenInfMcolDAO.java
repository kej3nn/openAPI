package egovframework.admin.service.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.admin.service.service.OpenInfMcol;
import egovframework.admin.service.service.OpenInfSrv;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * 서비스설정관리
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */
@Repository("OpenInfMcolDAO")
public class OpenInfMcolDAO extends EgovComAbstractDAO {

    @SuppressWarnings("unchecked")
    public List<OpenInfMcol> selectOpenInfColList(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<OpenInfMcol>) list("OpenInfMcolDAO.selectOpenInfColList", openInfSrv);
    }

    public int mergeIntoCol(OpenInfMcol openInfMcol) throws DataAccessException, Exception {
        return (Integer) update("OpenInfMcolDAO.mergeIntoCol", openInfMcol);
    }

    public OpenInfMcol selectOpenInfColInfo(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (OpenInfMcol) selectByPk("OpenInfMcolDAO.selectOpenInfColInfo", openInfSrv);
    }

    public int updateOpt(OpenInfMcol openInfMcol) throws DataAccessException, Exception {
        return (Integer) update("OpenInfMcolDAO.updateOpt", openInfMcol);
    }

    @SuppressWarnings("unchecked")
    public List<OpenInfMcol> selectOpenInfColViewPopInfo(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<OpenInfMcol>) list("OpenInfMcolDAO.selectOpenInfColViewPopInfo", openInfSrv);
    }

    public int selectMetaListCnt(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("OpenInfMcolDAO.selectMetaListCnt", openInfSrv);
    }

    @SuppressWarnings("unchecked")
    public List<LinkedHashMap<String, ?>> selectMetaListAll(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<LinkedHashMap<String, ?>>) list("OpenInfMcolDAO.selectMetaListAll", openInfSrv);
    }


    /**
     * select 절을 조회한다.
     *
     * @param openInfSrv
     * @return
     * @throws DataAccessException, Exception
     */
    @SuppressWarnings("unchecked")
    public List<OpenInfMcol> selectOpenInfColViewPopInfoCond(OpenInfSrv openInfSrv) throws DataAccessException, Exception {
        return (List<OpenInfMcol>) list("OpenInfMcolDAO.selectOpenInfColViewPopInfoCond", openInfSrv);
    }

}

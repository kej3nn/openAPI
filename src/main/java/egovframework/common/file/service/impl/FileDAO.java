package egovframework.common.file.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.admin.service.service.OpenInfLcol;
import egovframework.admin.service.service.OpenInfScol;
import egovframework.admin.service.service.OpenInfVcol;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * 서비스설정관리
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */
@Repository("FileDAO")
public class FileDAO extends EgovComAbstractDAO {


    public int fileSeq() throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("FileDAO.fileSeq");
    }

    public int fileMultiSeq() throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("FileDAO.fileMultiSeq");
    }

    public int fileBbsSeq() throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("FileDAO.fileBbsSeq");
    }

    public int filePublishSeq() throws DataAccessException, Exception {
        return (Integer) getSqlMapClientTemplate().queryForObject("FileDAO.filePublishSeq");
    }

    @SuppressWarnings("unchecked")
    public List<HashMap<String, Object>> getFileNameByFileSeq(int fileSeq) throws DataAccessException, Exception {
        return getSqlMapClientTemplate().queryForList("FileDAO.getFileNameByOpenInfFileSeq", fileSeq);
    }

    @SuppressWarnings("unchecked")
    public List<HashMap<String, Object>> getFileNameByBbsFileSeq(int fileSeq) throws DataAccessException, Exception {
        return getSqlMapClientTemplate().queryForList("FileDAO.getFileNameByBbsFileSeq", fileSeq);
    }

    @SuppressWarnings("unchecked")
    public List<HashMap<String, Object>> getFileNameByPublishFileSeq(int fileSeq) throws DataAccessException, Exception {
        return getSqlMapClientTemplate().queryForList("FileDAO.getFileNameByPublishFileSeq", fileSeq);
    }

    @SuppressWarnings("unchecked")
    public List<HashMap<String, Object>> getFileNameByCateId(String etc) throws DataAccessException, Exception {
        return getSqlMapClientTemplate().queryForList("FileDAO.getFileNameByCateId", etc);
    }

    @SuppressWarnings("unchecked")
    public List<HashMap<String, Object>> getFileNameByLinkSeq(OpenInfLcol openInfLcol) throws DataAccessException, Exception {
        return getSqlMapClientTemplate().queryForList("FileDAO.getFileNameByLinkSeq", openInfLcol);
    }

    @SuppressWarnings("unchecked")
    public List<HashMap<String, Object>> getFileNameByMediaNo(OpenInfVcol openInfVcol) throws DataAccessException, Exception {
        return getSqlMapClientTemplate().queryForList("FileDAO.getFileNameByMediaNo", openInfVcol);
    }

    @SuppressWarnings("unchecked")
    public List<HashMap<String, Object>> getFileNameByVistnSeq(OpenInfVcol openInfVcol) throws DataAccessException, Exception {
        return getSqlMapClientTemplate().queryForList("FileDAO.getFileNameByVistnSeq", openInfVcol);
    }

    @SuppressWarnings("unchecked")
    public List<HashMap<String, Object>> getFileNameByOpenFileSeq(OpenInfScol openInfScol) throws DataAccessException, Exception {
        return getSqlMapClientTemplate().queryForList("FileDAO.getFileNameByOpenFileSeq", openInfScol);
    }

    public List<HashMap<String, Object>> getFileNameByOpenSheetSeq(
            OpenInfScol openInfScol) {
        return getSqlMapClientTemplate().queryForList("FileDAO.getFileNameByOpenSheetSeq", openInfScol);
    }

    public List<HashMap<String, Object>> getFileNameByOpenLinkSeq(
            OpenInfScol openInfScol) {
        return getSqlMapClientTemplate().queryForList("FileDAO.getFileNameByOpenLinkSeq", openInfScol);
    }

}

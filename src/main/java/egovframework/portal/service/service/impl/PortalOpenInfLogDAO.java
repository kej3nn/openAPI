package egovframework.portal.service.service.impl;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.portal.service.service.OpenInfLog;

/**
 * 서비스설정관리
 * @author wiseopen
 * @since 2014.04.17
 * @version 1.0
 * @see
 *
 */
@Repository("PortalOpenInfLogDAO")
public class PortalOpenInfLogDAO extends EgovComAbstractDAO {

	    
	/**
	 * 서비스 로그를 기록한다.
	 * @param openInfSrvLog
	 * @return
	 * @throws DataAccessException, Exception
	 */
	public int saveLogOpenInfSave(OpenInfLog openInfSrvLog) throws DataAccessException, Exception {
		return (Integer)update("PortalOpenInfLogDAO.saveLogOpenInfSave", openInfSrvLog);
	}
	
	/**
	 * 서비스의 조회 횟수를 +1 증가한다.
	 * @param openInfSrvLog
	 * @return
	 * @throws DataAccessException, Exception
	 */
	public int saveLogOpenInfViewCnt(OpenInfLog openInfSrvLog) throws DataAccessException, Exception {
		return (Integer)update("PortalOpenInfLogDAO.saveLogOpenInfViewCnt", openInfSrvLog);
	}
	/**
	 * INF_SEQ를 가져온다
	 * @param openInfSrvLog
	 * @return
	 * @throws DataAccessException, Exception
	 */
	public int getInfSeq(OpenInfLog openInfSrvLog) throws DataAccessException, Exception {
		return (Integer) getSqlMapClientTemplate().queryForObject("PortalOpenInfLogDAO.getInfSeq", openInfSrvLog);
	}
	
	/**
	 * 서비스 로그를 INSERT 한다.
	 * @param openInfSrvLog
	 * @return
	 * @throws DataAccessException, Exception
	 */
	public int saveLogOpenInfSrv(OpenInfLog openInfSrvLog) throws DataAccessException, Exception {
		return (Integer)update("PortalOpenInfLogDAO.saveLogOpenInfSrv", openInfSrvLog);
	}
    /**
     * 파일 다운로드 기록을 INSERT한다.
     * @param openInfFileLog
     * @throws DataAccessException, Exception
     */
    public void insertLogOpenInfFile(OpenInfLog openInfFileLog) throws DataAccessException, Exception {
    	update("PortalOpenInfLogDAO.insertLogOpenInfFile", openInfFileLog);
    }
    /**
     * 파일 다운로드 횟수를 업데이트한다.
     * @param openInfFileLog
     * @throws DataAccessException, Exception
     */
    public void upOpenInfFileViewCnt(OpenInfLog openInfFileLog) throws DataAccessException, Exception {
    	update("PortalOpenInfLogDAO.upOpenInfFileViewCnt", openInfFileLog);
    }
    /**
     * 링크 다운로드 기록을 INSERT한다.
     * @param openInfLinkLog
     * @throws DataAccessException, Exception
     */
    public void insertLogOpenInfLink(OpenInfLog openInfLinkLog) throws DataAccessException, Exception {
	   	update("PortalOpenInfLogDAO.insertLogOpenInfLink", openInfLinkLog);
	}
    /**
     * 링크 다운로드 기록을 UPDATE한다.
     * @param openInfLinkLog
     * @throws DataAccessException, Exception
     */
    public void upOpenInfLinkViewCnt(OpenInfLog openInfLinkLog) throws DataAccessException, Exception {
    	update("PortalOpenInfLogDAO.upOpenInfLinkViewCnt", openInfLinkLog);
    }
  
    public void insertLogPortal(OpenInfLog openInfSrvLog) throws DataAccessException, Exception {
		 	update("PortalOpenInfLogDAO.insertLogPortal", openInfSrvLog);
	}
	
}

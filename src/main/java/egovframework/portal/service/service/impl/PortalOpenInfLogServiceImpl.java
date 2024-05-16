package egovframework.portal.service.service.impl;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.service.service.OpenInfFcol;
import egovframework.admin.service.service.OpenInfLcol;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.portal.service.service.OpenInfLog;
import egovframework.portal.service.service.PortalOpenInfLogService;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * 메뉴를 관리를 위한 서비스 구현 클래스
 * @author wiseopen
 * @since 2014.04.17
 * @version 1.0
 * @see
 *
 */

@Service("PortalOpenInfLogService")
public class PortalOpenInfLogServiceImpl extends AbstractServiceImpl  implements PortalOpenInfLogService{

    @Resource(name = "PortalOpenInfLogDAO")
    protected PortalOpenInfLogDAO portalOpenInfLogDAO;
    
    private static final Logger logger = Logger.getLogger(PortalOpenInfLogServiceImpl.class);
    
    public int saveLogOpenInfSave(OpenInfLog openInfSrvLog,HttpServletRequest requset){
    	int result = 0;
    	try {
			result = portalOpenInfLogDAO.saveLogOpenInfSave(openInfSrvLog);
		} catch (DataAccessException dae) {
    		EgovWebUtil.exTransactionLogging(dae);
		} catch (Exception e) {
			EgovWebUtil.exTransactionLogging(e);
		} 
    	return result;
    }
    public int saveLogOpenInfViewCnt(OpenInfLog openInfSrvLog,HttpServletRequest requset){
    	int result = 0;
    	try {
    		int infSeq = portalOpenInfLogDAO.getInfSeq(openInfSrvLog);
    		openInfSrvLog.setInfSeq(infSeq);
    		portalOpenInfLogDAO.saveLogOpenInfViewCnt(openInfSrvLog);
			result = portalOpenInfLogDAO.saveLogOpenInfSrv(openInfSrvLog);
		} catch (DataAccessException dae) {
    		EgovWebUtil.exTransactionLogging(dae);
		} catch (Exception e) {
			EgovWebUtil.exTransactionLogging(e);
		}
    	return result;
    }
    
	public void insertLogOpenInfFile(OpenInfLog openInfFileLog,HttpServletRequest requset) {
		try {
			int infSeq = portalOpenInfLogDAO.getInfSeq(openInfFileLog);	
			openInfFileLog.setInfSeq(infSeq);	// 로그에서 사용하는 infSeq는 tb_open_inf의 seq가 아니라 tb_open_inf_srv의 infSeq와 같아야함  
			portalOpenInfLogDAO.insertLogOpenInfFile(openInfFileLog);	// 로그 기록
			portalOpenInfLogDAO.upOpenInfFileViewCnt(openInfFileLog);	// viewCnt +1
		} catch (DataAccessException dae) {
    		EgovWebUtil.exTransactionLogging(dae);
		} catch (Exception e) {
			EgovWebUtil.exTransactionLogging(e);
		} 
	}

	public void insertLogOpenInfLink(OpenInfLog openInfLinkLog,HttpServletRequest requset) {
		try {
			portalOpenInfLogDAO.insertLogOpenInfLink(openInfLinkLog);	//로그 기록
			portalOpenInfLogDAO.upOpenInfLinkViewCnt(openInfLinkLog);	// viewCnt +1
		} catch (DataAccessException dae) {
    		EgovWebUtil.exTransactionLogging(dae);
		} catch (Exception e) {
			EgovWebUtil.exTransactionLogging(e);
		} 

	}
	
	public void insertLogPortal(OpenInfLog openInfLog,HttpServletRequest requset){
		//portalOpenInfLogDAO.insertLogPortal(openInfLog);	// 로그 기록
	}
	
}
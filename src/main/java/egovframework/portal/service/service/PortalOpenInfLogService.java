package egovframework.portal.service.service;

import javax.servlet.http.HttpServletRequest;

import egovframework.admin.service.service.OpenInfFcol;
import egovframework.admin.service.service.OpenInfLcol;




/**
 * 공공데이터 로그 서비스를 정의하기 위한 서비스 인터페이스
 * @author wiseopen
 * @since 2014.04.17
 * @version 1.0
 * @see
 *
 */

public interface PortalOpenInfLogService {
	
	/**
	 * 각 서비스 조회 로그를 저장한다.
	 * @param openInfSrvLog
	 * @param requset
	 * @return
	 * @throws Exception
	 */
	public int saveLogOpenInfSave(OpenInfLog openInfSrvLog,HttpServletRequest requset);
	/**
	 * 조회한 서비스를 조회를 1증가한다.
	 * @param openInfSrvLog
	 * @param requset
	 * @return
	 * @throws Exception
	 */
	public int saveLogOpenInfViewCnt(OpenInfLog openInfSrvLog,HttpServletRequest requset);
	/**
	 * 다운로드한 파일을 기록한다.
	 * @param openInfFileLog
	 * @throws Exception
	 */
	public void insertLogOpenInfFile(OpenInfLog openInfFileLog,HttpServletRequest requset);
	/**
	 * 다운로드한 링크를 기록한다.
	 * @param openInfLinkLog
	 * @throws Exception
	 */
	public void insertLogOpenInfLink(OpenInfLog openInfLinkLog,HttpServletRequest requset);
	
	public void insertLogPortal(OpenInfLog openInfLinkLog,HttpServletRequest requset);
}

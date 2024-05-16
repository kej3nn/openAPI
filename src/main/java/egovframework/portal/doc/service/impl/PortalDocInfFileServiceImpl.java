package egovframework.portal.doc.service.impl;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.exception.SystemException;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.service.BaseService;
import egovframework.common.base.view.FileDownloadView;
import egovframework.common.util.UtilString;
import egovframework.portal.doc.service.PortalDocInfFileService;
import egovframework.portal.doc.service.PortalDocInfService;

/**
 * 문서관리 파일서비스를 관리하는 서비스 구현 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2018/08/21
 */
@Service(value="portalDocInfFileService")
public class PortalDocInfFileServiceImpl extends BaseService implements PortalDocInfFileService {

	@Resource(name="portalDocInfService")
	protected PortalDocInfService portalDocInfService;
	
	@Resource(name="portalDocInfFileDao")
	protected PortalDocInfFileDao portalDocInfFileDao;

	/**
	 * 문서관리 파일 서비스 정보 조회
	 */
	@Override
	public List<Record> searchDocInfFile(Params params) {
		return portalDocInfFileDao.searchDocInfFile(params);
	}

	/**
	 * 문서관리 파일 서비스 정보 조회(단건) => 파일 다운로드
	 */
	@Override
	public Record selectDocInfFileCUD(Params params) {
		Record file =  portalDocInfFileDao.selectDocInfFile(params);
		try {
			// 데이터가 없는 경우
	        if (file == null) {
	            throw new ServiceException("portal.error.000024", getMessage("portal.error.000024"));
	        }
        
        	// 문서관리 파일서비스 조회이력 등록
        	portalDocInfFileDao.insertLogDocInfFile(params);
        	
        	// 문서관리 파일서비스 조회수 수정
        	portalDocInfFileDao.updateDocInfFileViewCnt(params);
        	
        	file.put(FileDownloadView.FILE_PATH, getFilePath(file));
        	file.put(FileDownloadView.FILE_NAME, getFileName(file));
        	file.put(FileDownloadView.FILE_SIZE, getFileSize(file));
        	
		} catch(ServiceException sve) {
			EgovWebUtil.exTransactionLogging(sve);
			throw new SystemException("portal.error.000001", getMessage("portal.error.000001"));
		} catch(Exception e) {
			EgovWebUtil.exTransactionLogging(e);
        	throw new SystemException("portal.error.000001", getMessage("portal.error.000001"));
        }
        
		return file;
	}
	
	/**
     * 파일 경로를 반환한다.
     * 
     * @param file 파일
     * @return 파일 경로
     */
	private String getFilePath(Record file) {
        StringBuffer buffer = new StringBuffer();
        
        buffer.append(UtilString.getServiceFolder("DF"));
        buffer.append(File.separator);
        buffer.append(file.getString("docId"));
        buffer.append(File.separator);
        buffer.append(EgovWebUtil.filePathReplaceAll(file.getString("saveFileNm")));
        
        return buffer.toString();
    }
	
	/**
     * 파일 이름을 반환한다.
     * 
     * @param file 파일
     * @return 파일 이름
     */
	private String getFileName(Record file) {
        StringBuffer buffer = new StringBuffer();
        
        buffer.append(file.getString("viewFileNm"));
        
        return buffer.toString();
    }
	
	/**
     * 파일 크기를 반환한다.
     * 
     * @param file 파일
     * @return 파일 크기
     */
	private String getFileSize(Record file) {
        return file.getString("fileSize");
    }
}

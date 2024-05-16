package egovframework.admin.mainmng.service.impl;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import egovframework.admin.mainmng.service.MainMngOrder;
import egovframework.admin.mainmng.service.MainMngService;
import egovframework.admin.openinf.service.OpenMetaOrder;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.common.base.model.Params;
import egovframework.common.file.service.FileVo;
import egovframework.common.util.SFTPSyncManager;

@Service("mainMngService")
public class MainMngServiceImpl implements MainMngService {
	
	@Resource(name = "mainMngDAO")
	private MainMngDAO mainMngDao;

	@Override
	public List<Map<String, Object>> selectListCate() {
		return mainMngDao.selectListCate();
	}

	@Override
	public int updateCateSeqCUD(ArrayList<OpenMetaOrder> list) {
    	int result = 0;
    	for(OpenMetaOrder vo : list){
   			result += mainMngDao.updateCateOrder(vo);	
    	}
		return result;
	}
	
	@Override
	public List<Map<String, Object>> selectListMainMng(Params params) {
		return mainMngDao.selectListMainMng(params);
	}

	@Override
	public int saveMainMngData(HttpServletRequest request, String usrId, FileVo fileVo) {
		
		String saveFileNm = request.getParameter("saveFileNm");
		if(fileVo.getFile() != null && fileVo.getFile().length == 1) {
			saveFileNm = fileUpload(fileVo.getFile()[0], request.getParameter("saveFileNm"), 0);
		}
		String subSaveFileNm = request.getParameter("subSaveFileNm");
		if(fileVo.getFile1() != null && fileVo.getFile1().length == 1) {
			subSaveFileNm = fileUpload(fileVo.getFile1()[0], request.getParameter("subSaveFileNm"), 1);
		}
		/*
		if("".equals(saveFileNm)) {
			throw new RuntimeException("파일 업로드 에러!!");
		}
		*/
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("seqceNo", request.getParameter("seqceNo"));
		params.put("srvTit", request.getParameter("srvTit"));
		params.put("homeTagCd", request.getParameter("homeTagCd"));
		params.put("strtDttm", request.getParameter("strtDttm"));
		params.put("endDttm", request.getParameter("endDttm"));
		params.put("linkUrl", request.getParameter("linkUrl"));
		params.put("saveFileNm", saveFileNm);
		params.put("subSaveFileNm", subSaveFileNm);
		params.put("popupYn", request.getParameter("popupYn"));
		params.put("useYn", request.getParameter("useYn"));
		params.put("usrId", usrId);
		params.put("srvCont", request.getParameter("srvCont"));		// 팝업 내용텍스트
		int result = mainMngDao.saveMainMngData(params);
		return result;
		
	}
	
	@Override
	public int updateMainMngCUD(ArrayList<MainMngOrder> list) {
    	int result = 0;
    	for(MainMngOrder vo : list){
   			result += mainMngDao.updateMainMngOrder(vo);	
    	}
		return result;
	}
	
	@Override
	public void deleteMainMng(String seqceNo) {
		mainMngDao.deleteMainMng(seqceNo);
	}

	
	
	
	
	private String fileUpload(MultipartFile file, String orgFileNm, int index) {

		String saveFileNm = "";
		// 정보만 수정인 경우
		if(file.getSize() == 0) {
			return orgFileNm;
		}
		
		String realFileNm = file.getOriginalFilename();
		int ext = realFileNm.lastIndexOf(".");
		String fileExt = "";
		if(ext > -1) {
			fileExt = realFileNm.substring(ext);
		}
		
		String directory = EgovWebUtil.folderPathReplaceAll(EgovProperties.getProperty("Globals.MainMngImgFilePath"));
		directory = EgovWebUtil.folderPathReplaceAll(directory);
		
		File directoryPath = new File(directory);
		 // 수정 : 권한 설정
		directoryPath.setExecutable(true, true);
		directoryPath.setReadable(true);
		directoryPath.setWritable(true, true);
		
		if(!directoryPath.exists()) {
			directoryPath.mkdirs();
		}
		FileOutputStream fos = null;
		
		try {
			byte fileData[] = file.getBytes();
			long time = System.currentTimeMillis(); 
			String pattern = "yyyyMMddHHmmssSSS";
			SimpleDateFormat sf = new SimpleDateFormat(pattern);
			saveFileNm = sf.format(new Date(time)) + index + fileExt;
			
			fos = new FileOutputStream(directoryPath + "/" + saveFileNm);
			fos.write(fileData);
			
		    if(EgovProperties.getProperty("sftp.option").equals("on")){
		    	SFTPSyncManager sftp = new SFTPSyncManager();
		    	sftp.runsftp("U", directoryPath.getPath(), directoryPath.getPath());
		    }

			// zip 압축 전송 START
		    /*
			if("on".equals(EgovProperties.getProperty("FileNetConn.option"))) {
				UtilZip utilZip = new UtilZip();
				String sendDir = EgovProperties.getProperty("FileNetConn.sendDir");
				File _sendDir = new File(sendDir);
				if(!_sendDir.exists()) {
					_sendDir.mkdirs();
				}
				utilZip.zipByEtl(directoryPath.getPath(), sendDir);
			}*/
			// zip 압축 전송 END
			
		} catch (FileNotFoundException e) {
			EgovWebUtil.exLogging(e);
			return "";
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
			return "";
		} finally {
			if (fos != null) {
				try {
					fos.close();
				} catch (FileNotFoundException e) {
					EgovWebUtil.exLogging(e);
				} catch (Exception e) {
					EgovWebUtil.exLogging(e);
				}
			}
		}
		
		return saveFileNm;
	}
	
	 public Map<String, Object> selectOpenMetaOrderPageListAllMainTreeIbPaging(OpenMetaOrder openMetaOrder) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			List<OpenMetaOrder> result = mainMngDao.selectOpenMetaOrderListAllMainTree(openMetaOrder);
			int cnt = result.size();
			map.put("resultList", result);
			map.put("resultCnt", Integer.toString(cnt));
			
		} catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return map;
    }
	
	public int openMetaOrderBySave(ArrayList<OpenMetaOrder> list) {
    	int result = 0;
    	try {
    		for(OpenMetaOrder openMetaOrder : list){
    			result += mainMngDao.updateOrderby(openMetaOrder);	
    		}
		} catch (DataAccessException e) {
			EgovWebUtil.exTransactionLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exTransactionLogging(e);
		}
		return result;
    }

}

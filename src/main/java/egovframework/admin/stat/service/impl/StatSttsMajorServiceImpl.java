package egovframework.admin.stat.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.admin.stat.service.StatSttsMajorService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.exception.SystemException;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;
import egovframework.common.base.service.BaseService;

/**
 * 관리자 주요통계지표관리 서비스 클래스 이다.
 * 
 * @author	김정호
 * @version 1.0
 * @since   2017/08/10
 */

@Service(value="statSttsMajorService")
public class StatSttsMajorServiceImpl extends BaseService implements StatSttsMajorService {
	
	public static final int BUFF_SIZE = 2048;

	@Resource(name="statSttsMajorDao")
	protected StatSttsMajorDao statSttsMajorDao;

	/**
	 * 주요통계지표 관리 메인 리스트
	 */
	@Override
	public List<Record> statSttsMajorList(Params params) {
		return (List<Record>) statSttsMajorDao.selectStatSttsMajorList(params);
	}

	/**
	 * 통계값 항목/분류 콤보 조회
	 */
	@Override
	public List<Record> statTblItmCombo(Params params) {
		return (List<Record>) statSttsMajorDao.selectStatTblItmCombo(params);
	}

	/**
	 * 통계값 자료구분 콤보 조회
	 */
	@Override
	public List<Record> statTblOptDtadvsCombo(Params params) {
		return (List<Record>) statSttsMajorDao.selectStatTblOptDtadvsCombo(params);
	}

	/**
	 * 주요통계지표 상세
	 */
	@Override
	public Record statSttsMajorDtl(Params params) {
		return statSttsMajorDao.selectStatSttsMajorDtl(params);
	}

	/**
	 * 주요통계지표 통계표 팝업 리스트 조회
	 */
	@Override
	public List<Record> statTblPopupList(Params params) {
		return (List<Record>) statSttsMajorDao.selectStatTblPopupList(params);
	}

	/**
	 * 주요통계지표 삭제
	 */
	@Override
	public Result deleteStatSttsMajor(Params params) {
		try{
			int result = (int) statSttsMajorDao.deleteStatSttsMajor(params);
			if ( result <= 0 ) {
				throw new ServiceException("admin.error.000001", getMessage("admin.error.000001"));
			}
			
		} catch (DataAccessException dae) {
			EgovWebUtil.exTransactionLogging(dae);
		} catch (Exception e) {
			EgovWebUtil.exTransactionLogging(e);
		}
		return success(getMessage("admin.message.000005"));	//삭제가 완료되었습니다
	}
	
	/**
	 * 주요통계지표 순서저장
	 */
	@Override
	public Result saveStatSttsMajorOrder(Params params) {
		Record rec = null;
		try {
			JSONArray jsonArray = new JSONObject(params.getJsonObject("ibsSaveJson")).getJSONArray("data");
			for (int i = 0; i < jsonArray.length(); i++) {
	        	rec = new Record();
	        	JSONObject jsonObj = (JSONObject) jsonArray.get(i);
	        	rec.put("majorId", jsonObj.getString("majorId"));
	        	rec.put("vOrder", jsonObj.getInt("vOrder"));
	        	statSttsMajorDao.updateStatSttsMajorOrder(rec);
			}
		} catch(JSONException je) {
			error("Exception : " , je);
			EgovWebUtil.exTransactionLogging(je);
			throw new ServiceException("admin.error.000003", getMessage("admin.error.000003"));	
		} catch(Exception e) {
			error("Exception : " , e);
			EgovWebUtil.exTransactionLogging(e);
			throw new ServiceException("admin.error.000003", getMessage("admin.error.000003"));
		}
		return success(getMessage("admin.message.000004"));
	}

	/**
	 * 주요통계지표 등록/수정
	 */
	@Override
	public Object saveStatSttsMajor(HttpServletRequest request, Params params) {
		final MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
		
		if ( StringUtils.isEmpty(params.getString("majorId")) ) {
			int majorId = statSttsMajorDao.selectMaxMajorId();
			params.set("majorId", String.valueOf(majorId));
		}
		
		FileOutputStream fos = null;
		
		try {
			//저장 디렉토리(properties + ID)
			String directoryPath = EgovProperties.getProperty("Globals.StatSttsMajorFilePath");
			directoryPath = EgovWebUtil.folderPathReplaceAll(directoryPath);
			
			File dir = new File(directoryPath);
			// 수정 : 권한 설정
            dir.setExecutable(true, true);
            dir.setReadable(true);
            dir.setWritable(true, true);
            
			if ( !dir.isDirectory() ) {
				dir.mkdir();
			}

			// 저장 파일 맵
			Map<String,MultipartFile> fileMap = multiRequest.getFileMap();
			
			// saveKey에 맞게 파일이 있을경우 해당 파일 저장
			for ( String saveKey : fileMap.keySet() ) {
				
				MultipartFile file = fileMap.get(saveKey);
				
				if ( file.getSize() > 0 ) {
					String srcFileNm = file.getOriginalFilename(); 						//원본 파일명
					String fileExt = FilenameUtils.getExtension(srcFileNm);				//파일 확장자
					String viewFileNm = params.getString("majorId") + getFileSuffix(saveKey) + "." + fileExt;	//저장파일명(파라미터 값)
					
					params.set(saveKey, viewFileNm);

					if(viewFileNm != null && !"".equals(viewFileNm)){
						fos = new FileOutputStream(EgovWebUtil.filePathBlackList(directoryPath + File.separator + viewFileNm));
						InputStream stream = file.getInputStream();
					    int bytesRead = 0;
					    byte[] buffer = new byte[BUFF_SIZE];

					    while ((bytesRead = stream.read(buffer, 0, BUFF_SIZE)) != -1) {
					    	fos.write(buffer, 0, bytesRead);
					    }
					}
				}
				else {
					// 파일이 없는 경우 DB값 null 처리
					params.set(saveKey, "");
				}
			}
			
			statSttsMajorDao.saveStatSttsMajor(params);
			
			
		} catch(IOException ioe) {
			EgovWebUtil.exTransactionLogging(ioe);
			throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
		} catch (Exception e) {
			EgovWebUtil.exTransactionLogging(e);
			throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
		} finally {
        	try {
        		if ( fos != null ) {
        			fos.close();
        		}
        	} catch(IOException ioe) {
        		EgovWebUtil.exLogging(ioe);
        	}
        }
		
		return success(getMessage("admin.message.000006"));
	}
	
	/**
	 * 파일 SaveName에 따른 suffix 설정
	 * @param saveKey
	 * @return
	 */
	private String getFileSuffix(String saveKey) {
		String suffix = "";
		if ( saveKey.equals("view1FileNm") ) {
			suffix = "_PD";		// 증감
		}
		else if ( saveKey.equals("view2FileNm") ) {
			suffix = "_PR";		// 증감률
		}
		return suffix;
	}
	
}

package egovframework.admin.infset.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.admin.infset.service.InfSetCateService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.exception.SystemException;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;
import egovframework.common.base.service.BaseService;
import egovframework.common.base.view.ImageView;

/**
 * 관리자 정보 분류 클래스
 * 
 * @author 	손정식
 * @version	1.0
 * @since	2017/08/21
 */

@Service(value="infSetCateService")
public class InfSetCateServiceImpl extends BaseService implements InfSetCateService {

	public static final int BUFF_SIZE = 2048;
	
	@Resource(name="infSetCateDao")
	protected InfSetCateDao infSetCateDao;

	/**
	 * 정보 분류 메인 리스트 조회
	 */
	@Override
	public List<Record> infSetCateList(Params params) {
		return (List<Record>) infSetCateDao.selectInfSetCateList(params);
	}
	
	/**
	 * 정보 분류 팝업 리스트 조회
	 */
	@Override
	public List<Record> infSetCatePopList(Params params) {
		return (List<Record>) infSetCateDao.selectInfSetCatePopList(params);
	}

	/**
	 * 정보 분류 상세 조회
	 */
	@Override
	public Record infSetCateDtl(Params params) {
		return (Record) infSetCateDao.selectInfSetCateDtl(params);
	}

	/**
	 * 정보 분류 ID 중복체크
	 */
	@Override
	public Record infSetCateDupChk(Params params) {
		return (Record) infSetCateDao.selectInfSetCateDupChk(params);
	}

	/**
	 * 정보 분류 등록/수정
	 */
	@Override
	public Object saveInfSetCate(HttpServletRequest request, Params params) {
		final MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
		String cateId = params.getString("cateId");
		FileOutputStream fos = null;
		try {
		
			MultipartFile file = multiRequest.getFile("cateFile");	//정보 분류 이미지
			if ( file.getSize() > 0 ) {
				String srcFileNm = file.getOriginalFilename(); 					//원본 파일명
				String fileExt = FilenameUtils.getExtension(srcFileNm);			//파일 확장자
				String saveFileNm = cateId + "." + fileExt;	//저장파일명(파라미터 값)
				params.put("srcFileNm", srcFileNm);
				params.put("saveFileNm", saveFileNm);
				params.put("viewFileNm", saveFileNm);
				
				//저장 디렉토리(properties + ID)
				String directoryPath = EgovProperties.getProperty("Globals.InfSetCateFilePath");
				directoryPath = EgovWebUtil.folderPathReplaceAll(directoryPath);
				File directory = new File(directoryPath);
				// 수정 : 권한 설정
				directory.setExecutable(true, true);
				directory.setReadable(true);
				directory.setWritable(true, true);
	            
				if ( !directory.isDirectory() ) {
					directory.mkdir();
				}

				if(saveFileNm != null && !"".equals(saveFileNm)){
					fos = new FileOutputStream(EgovWebUtil.filePathBlackList(directoryPath + File.separator + saveFileNm));
					InputStream stream = file.getInputStream();
				    int bytesRead = 0;
				    byte[] buffer = new byte[BUFF_SIZE];

				    while ((bytesRead = stream.read(buffer, 0, BUFF_SIZE)) != -1) {
				    	fos.write(buffer, 0, bytesRead);
				    }
				}
			}
				
			/* 데이터 저장 */
			infSetCateDao.saveInfSetCate(params);
			
			// 데이터 수정시 사용여부 N처리 될 경우 N처리된 하위 항목들은 모두 동일하게 사용여부 N처리 한다.
			if ( StringUtils.equals("N", params.getString("useYn")) ) {
				// infSetCateDao.updateInfoCateChildUseN(params);  // 보류
			}
			
			//관련된 분류 전체명, 분류 레벨 일괄 업데이트 처리
			infSetCateDao.updateInfSetCateFullnm(params);
			
		} catch(IOException ioe) {
			EgovWebUtil.exTransactionLogging(ioe);
			throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
		} catch(Exception e) {
			EgovWebUtil.exTransactionLogging(e);
			throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
		} finally {
			try {
        		if ( fos != null ) {
        			fos.close();
        		}
        	} catch(IOException e) {
        		EgovWebUtil.exTransactionLogging(e);
        	} catch(Exception e) {
        		EgovWebUtil.exTransactionLogging(e);
        	}
		}
		
		return success(getMessage("admin.message.000006"));
	}

	/**
	 * 정보 썸네일 불러오기
	 */
	@Override
	public Record selectInfSetCateThumbnail(Params params) {
		Record file = (Record) infSetCateDao.selectInfSetCateDtl(params);
        
		Record thumbnail = new Record();
        thumbnail.put("cateId",     params.getString("cateId"));
        thumbnail.put("saveFileNm", params.getString("saveFileNm"));
        
        thumbnail.put(ImageView.FILE_PATH, getFilePath(file));
        thumbnail.put(ImageView.FILE_NAME, params.getString("saveFileNm"));
        
        return thumbnail;
	}

	/**
	 * 정보 분류 삭제
	 */
	@Override
	public Object deleteInfSetCate(Params params) {
		try{
			Record child = infSetCateDao.selectInfSetCateHaveChild(params);
			String haveChild = child.getString("haveChild");
			if ( "N".equals(haveChild)  ) {
				infSetCateDao.deleteInfSetCate(params);
			} else {
				//삭제 하려는 행에 자식분류가 존재 합니다.\n자식분류 먼저 삭제 하여 주시기 바랍니다.
				throw new ServiceException(getMessage("admin.message.000008"));
			}
		}catch(DataAccessException dae){
			EgovWebUtil.exTransactionLogging(dae);
		}catch (Exception e) {
			EgovWebUtil.exTransactionLogging(e);
		}
		return success(getMessage("admin.message.000005"));
	}

	/**
	 * 정보 분류 순서 저장
	 */
	@Override
	public Result saveInfSetCateOrder(Params params) {
		Record rec = null;
		try {
			/*
			JSONArray jsonArray = new JSONObject(params.getJsonObject("ibsSaveJson")).getJSONArray("data");
			for (int i = 0; i < jsonArray.length(); i++) {
	        	rec = new Record();
	        	JSONObject jsonObj = (JSONObject) jsonArray.get(i);
	        	rec.put("cateId", jsonObj.getString("cateId"));
	        	rec.put("vOrder", jsonObj.getInt("vOrder"));
	        	statSttsCateDao.saveStatSttsCateOrder(rec);
			}
			*/
			Params[] data = params.getJsonArray(Params.SHEET_DATA);
			for (int i = 0; i < data.length; i++) {
				rec = new Record();
	        	rec.put("cateId", data[i].getString("cateId"));
	        	rec.put("vOrder", data[i].getInt("vOrder"));
	        	infSetCateDao.saveInfSetCateOrder(rec);
			}
		} catch(DataAccessException e){
			EgovWebUtil.exTransactionLogging(e);
		}catch(Exception e) {
			error("Exception : " , e);
			EgovWebUtil.exTransactionLogging(e);
			throw new ServiceException("admin.error.000003", getMessage("admin.error.000003"));
		}
		return success(getMessage("admin.message.000004"));
	}
	
	/**
	 * 정보 분류 파일 정보 가져오기
	 * @param file
	 * @return
	 */
	private String getFilePath(Record file) {
        StringBuffer buffer = new StringBuffer();
        
        buffer.append(EgovProperties.getProperty("Globals.InfSetCateFilePath"));
//        buffer.append(file.getString("cateId"));
//        buffer.append(File.separator);
        buffer.append(EgovWebUtil.filePathReplaceAll(file.getString("saveFileNm")));
        
        return buffer.toString();
    }
}

package egovframework.admin.infset.service.impl;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
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

import com.unidocs.workflow.client.ConfigNotFoundException;
import com.unidocs.workflow.client.ConnectionFailedException;
import com.unidocs.workflow.client.InvalidRequestException;
import com.unidocs.workflow.client.WFJob;
import com.unidocs.workflow.common.FileEx;
import com.unidocs.workflow.common.JobResult;

import egovframework.admin.infset.service.DocInfMgmtService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.common.DocToPdfGenerator;
import egovframework.common.TSGenerator;
import egovframework.common.base.constants.ModelAttribute;
import egovframework.common.base.exception.DBCustomException;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.exception.SystemException;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;
import egovframework.common.base.service.BaseService;
import egovframework.common.base.view.ImageView;

/**
 * 정보공개 문서를 관리하는 서비스 클래스
 * @author	JHKIM
 * @version 1.0
 * @since   2019/08/05
 */

@Service(value="docInfMgmtService")
public class DocInfMgmtServiceImpl extends BaseService implements DocInfMgmtService {

	@Resource(name="docInfMgmtDao")
	protected DocInfMgmtDao docInfMgmtDao;

	/**
	 * 메인 리스트 조회(페이징 처리)
	 */
	@Override
	public Paging selectDocInfMainListPaging(Params params) {
		
		
		// 분류체계 여러개 검색(IN 절)
		if ( StringUtils.isNotEmpty(params.getString("cateIds")) ) {
			ArrayList<String> iterCateId = new ArrayList<String>(Arrays.asList(params.getString("cateIds").split(",")));
			params.set("iterCateId", iterCateId);
		}
		
		Paging list = docInfMgmtDao.selectMainList(params, params.getPage(), params.getRows());
		return list;
	}

	/**
	 * 상세 데이터 조회
	 */
	@Override
	public Record selectDtl(Params params) {
		return docInfMgmtDao.selectDtl(params);
	}
	
	/**
	 * 정보공개 문서관리 분류체계 팝업 조회
	 */
	@Override
	public List<Record> selectDocInfCatePop(Params params) {
		return docInfMgmtDao.selectDocInfCatePop(params);
	}

	/**
	 * 정보공개 문서관리 데이터 저장
	 */
	@Override
	public Result saveDocInf(Params params) {
		try {
			if ( ModelAttribute.ACTION_INS.equals(params.getString(ModelAttribute.ACTION_STATUS)) ) {
				// 신규 시퀀스 조회
				params.put("seq", docInfMgmtDao.getSqDocInfSeq());
				
				// 신규 정보ID 조회
				params.put("docId", docInfMgmtDao.getDocId(params));
			}
			
			// 정보셋 마스터 정보 등록
			saveDocInfMst(params);
			
			// 정보셋 키워드 등록
			saveDocInfTag(params);
			
			// 정보셋 관리 분류 등록
			saveDocInfCate(params);
			
			// 정보셋 관리 담당자 등록
			saveDocInfUsr(params);
			
			// 정보셋 마스터정보 대표여부 데이터 수정(위 트랜젝션(대표여부 데이터) 처리후 수정됨)
			int updCnt = (Integer) docInfMgmtDao.updateDocInfMstRpst(params);
			if ( updCnt <= 0 ) {
				throw new ServiceException("admin.error.000003", getMessage("admin.error.000003"));
			}
			
			// 백업 후 삭제
			docInfMgmtDao.execSpBcupDocInf(params);
			
			//데이터 처리진행코드에 따른 메시지
			if ( ModelAttribute.ACTION_INS.equals(params.getString(ModelAttribute.ACTION_STATUS)) ) {
				return success(getMessage("admin.message.000003"));
			} else if ( ModelAttribute.ACTION_UPD.equals(params.getString(ModelAttribute.ACTION_STATUS)) ) {
				return success(getMessage("admin.message.000004"));
			} else {
				return success(getMessage("admin.message.000003"));
			}
		} catch(DataAccessException dae) {
			error("DataAccessException : " , dae);
			EgovWebUtil.exTransactionLogging(dae);
			SQLException se = (SQLException) ((DataAccessException) dae).getRootCause();
			throw new DBCustomException(getDbmsExceptionMsg(se));
		} catch(Exception e) {
			error("Exception : " , e);
			EgovWebUtil.exTransactionLogging(e);
			throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
		}
	}
	
	/**
	 * 정보공개 문서관리 마스터정보 데이터 등록/수정
	 */
	private void saveDocInfMst(Params params) {
		String strActionStatus = params.getString(ModelAttribute.ACTION_STATUS);
		
		if ( ModelAttribute.ACTION_INS.equals(strActionStatus) ) {
			docInfMgmtDao.insertDocInfMst(params);
		} 
		else if ( ModelAttribute.ACTION_UPD.equals(strActionStatus) ) {
			docInfMgmtDao.updateDocInfMst(params);
		}
	}
	
	/**
	 * 문서관리 데이터 삭제
	 */
	public Result deleteDocInf(Params params) {
		try {
			// 백업 후 삭제
			docInfMgmtDao.execSpBcupDocInf(params);
			
			return success(getMessage("admin.message.000005"));	//삭제가 완료 되었습니다.
		} catch(DataAccessException dae) {
			error("DataAccessException : " , dae);
			//procedure 리턴 메세지 표시.
			SQLException se = (SQLException) ((DataAccessException) dae).getRootCause();
			throw new DBCustomException(getDbmsExceptionMsg(se));
		} catch(Exception e) {
			error("Exception : " , e);
			EgovWebUtil.exLogging(e);
			throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
		}
	}
	/**
	 * 정보공개 문서관리 태그 수정
	 */
	private void saveDocInfTag(Params params) {
		String docId = params.getString("docId");
		String schwTagCont = params.getString("schwTagCont");
		String[] tagArr = schwTagCont.split(",");
		
		if ( tagArr.length > 0 ) {
			// DELETE 하고
			docInfMgmtDao.deleteDocInfTag(params);
			
			// FOR LOOP INSERT
			for ( String tag : tagArr ) {
				Record record = new Record();
				record.put("docId", docId);
				record.put("tagNm", tag);
				docInfMgmtDao.insertDocInfTag(record);
			}
		}
	}
	
	/**
	 * 정보공개 문서관리 관련 분류 조회
	 */
	@Override
	public List<Record> selectDocInfCate(Params params) {
		return docInfMgmtDao.selectDocInfCate(params);
	}
	/**
	 * 정보공개 문서관리 관련 분류 등록 저장
	 */
	public void saveDocInfCate(Params params) throws JSONException {
		Record record = null;
		String docId = params.getString("docId");
		String regId = params.getString("regId");
		String updId = params.getString("updId");

		JSONArray jsonArray = new JSONObject(params.getJsonObject("ibsSaveJson2")).getJSONArray("data");
		for ( int i=0; i < jsonArray.length(); i++ ) {
			JSONObject jObj = (JSONObject) jsonArray.get(i);
			String status = jObj.getString("status");
			record = new Record();
			record.put("docId", docId);
			record.put("cateId", jObj.getString("cateId"));
			
			// 삭제로 넘어온 행
			if ( StringUtils.equals(status, ModelAttribute.ACTION_DEL) ) {
				docInfMgmtDao.deleteDocInfCate(record);
			}
			else if ( StringUtils.equals(status, ModelAttribute.ACTION_INS) || StringUtils.equals(status, ModelAttribute.ACTION_UPD) ) {
				record.put("regId", regId);
				record.put("updId", updId);
				record.put("rpstYn", jObj.getString("rpstYn"));
				record.put("useYn",  jObj.getString("useYn"));
				docInfMgmtDao.mergeDocInfCate(record);
			}
		}
	}
	
	/**
	 * 정보공개 문서관리 관련 유저 조회
	 */
	public List<Record> selectDocInfUsr(Params params) {
		return docInfMgmtDao.selectDocInfUsr(params);
	}
	/**
	 * 정보공개 문서관리 관련 담당자 CUD
	 */
	public void saveDocInfUsr(Params params) throws JSONException {
		
		Record record = null;
		String docId = params.getString("docId");
		String regId = params.getString("regId");
		String updId = params.getString("updId");
		
		JSONArray jsonArray = new JSONObject(params.getJsonObject("ibsSaveJson")).getJSONArray("data");
		for ( int i=0; i < jsonArray.length(); i++ ) {
			JSONObject jObj = (JSONObject) jsonArray.get(i);
			String status = jObj.getString("status");
			record = new Record();
			record.put("docId", docId);
			record.put("seqceNo", jObj.getString("seqceNo"));
			
			// 삭제로 넘어온 행
			if ( StringUtils.equals(status, ModelAttribute.ACTION_DEL) ) {
				docInfMgmtDao.deleteDocInfUsr(record);
			}
			else if ( StringUtils.equals(status, ModelAttribute.ACTION_INS) || StringUtils.equals(status, ModelAttribute.ACTION_UPD) ) {
				record.put("regId", regId);
				record.put("updId", updId);
				record.put("orgCd", jObj.getString("orgCd"));
				record.put("usrCd", jObj.getString("usrCd"));
				record.put("rpstYn", jObj.getString("rpstYn"));
				record.put("prssAccCd", jObj.getString("prssAccCd"));
				record.put("srcViewYn", jObj.getString("srcViewYn"));
				record.put("useYn", jObj.getString("useYn"));
				docInfMgmtDao.mergeDocInfUsr(record);
			}
		}
	}


	/**
	 * 정보공개 문서관리 공개/공개취소 처리
	 */
	@Override
	public Result updateDocInfOpenState(Params params) {
		try {
			String openState = StringUtils.equals(params.getString("openState"), "Y") ? "공개" : "공개취소";
			docInfMgmtDao.updateDocInfOpenState(params);
			
			return success("정상적으로 " + openState + "처리 되었습니다.");
		} catch(DataAccessException dae) {
			error("DataAccessException : " , dae);
			EgovWebUtil.exTransactionLogging(dae);
			SQLException se = (SQLException) ((DataAccessException) dae).getRootCause();
			throw new DBCustomException(getDbmsExceptionMsg(se));
		} catch(Exception e) {
			error("Exception : " , e);
			EgovWebUtil.exTransactionLogging(e);
			throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
		}
	}
	
	/**
	 * 정보공개 문서 파일을 조회한다. 
	 */
	@Override
	public List<Record> selectDocInfFile(Params params) {
		return docInfMgmtDao.selectDocInfFile(params);
	}

	/**
	 * 정보공개 문서 파일을 등록/수정 한다. 
	 */
	@Override
	public Result saveDocInfFile(HttpServletRequest request, Params params) {
		MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
		
		try {
			
			String status = params.getString(ModelAttribute.ACTION_STATUS);
			
			if ( StringUtils.equals(status, ModelAttribute.ACTION_INS) ) {
				makeDocInfFiles(multiRequest, params);
				
				docInfMgmtDao.insertDocInfFile(params);
			}
			else if ( StringUtils.equals(status, ModelAttribute.ACTION_UPD) ) {
				
				makeDocInfFiles(multiRequest, params);
				
				docInfMgmtDao.updateDocInfFile(params);
			}
			
			return success("정상적으로 처리 되었습니다.");
		} catch(DataAccessException dae) {
			error("DataAccessException : " , dae);
			EgovWebUtil.exTransactionLogging(dae);
			SQLException se = (SQLException) ((DataAccessException) dae).getRootCause();
			throw new DBCustomException(getDbmsExceptionMsg(se));
		} catch(Exception e) {
			error("Exception : " , e);
			EgovWebUtil.exTransactionLogging(e);
			throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
		}
	}
	
	/**
	 * 첨부파일 생성 및 변경저장
	 * @param multiRequest
	 * @param params
	 * @throws Exception
	 */
	private void makeDocInfFiles(MultipartHttpServletRequest multiRequest, Params params) {
		String docId = params.getString("docId");
		String status = params.getString(ModelAttribute.ACTION_STATUS);
		MultipartFile docFile = multiRequest.getFile("docFile");
		MultipartFile imgFile = multiRequest.getFile("imgFile");
		FileOutputStream fis1 = null;
		FileOutputStream fis2 = null;
		
		try {
			// 저장 디렉토리(properties + ID)
			String directoryPath = EgovProperties.getProperty("Globals.docInfFilePath") + File.separator + docId + File.separator;
			directoryPath = EgovWebUtil.folderPathReplaceAll(directoryPath);
			
			String uuid = UUID.randomUUID().toString().replaceAll("-", "");		// UNIQUE ID
			
			// 폴더가 없으면 생성
			File docDir = new File(directoryPath);
			// 수정 : 권한 설정
			docDir.setExecutable(true, true);
			docDir.setReadable(true);
			docDir.setWritable(true, true);
	        
			if ( !docDir.exists() ) {
				docDir.mkdirs();
			}
			
			// 첨부파일 등록하는 경우
			if ( docFile.getSize() > 0 ) {
				String srcFileNm = docFile.getOriginalFilename();			// 원본파일명
				String fileExt = FilenameUtils.getExtension(srcFileNm);		// 확장자
				String saveFileNm = uuid + "." + fileExt;					// 저장파일명(고유ID)
				long fileSize = docFile.getSize();							// 파일사이즈
				
				if(srcFileNm != null && !"".equals(srcFileNm)){
					fis1 = new FileOutputStream(EgovWebUtil.filePathBlackList(directoryPath + saveFileNm));
					//OutputStream bos = fis1;
					InputStream stream = docFile.getInputStream();
				    int bytesRead = 0;
				    byte[] buffer = new byte[2048];

				    while ((bytesRead = stream.read(buffer, 0, 2048)) != -1) {
				    	fis1.write(buffer, 0, bytesRead);
				    }
				    
				    params.put("srcFileNm", srcFileNm);
				    params.put("saveFileNm", saveFileNm);
				    params.put("viewFileNm", params.getString("viewFileNm") + "." + fileExt);
				    params.put("fileExt", fileExt);
				    params.put("fileSize", fileSize);
				}
			}
			else {
				if ( StringUtils.equals(status, ModelAttribute.ACTION_UPD) ) {
					// 파일 수정시 기존에 저장된 확장자 붙여준다.
					params.put("viewFileNm", params.getString("viewFileNm") + "." + params.getString("fileExt"));
				}
			}
			
			// 이미지 파일 등록하는경우
			if ( imgFile.getSize() > 0 ) {
				
				String imgDirPath = EgovWebUtil.folderPathReplaceAll(directoryPath + File.separator + "img");
				File imgDir = new File(imgDirPath);
				// 수정 : 권한 설정
				imgDir.setExecutable(true, true);
				imgDir.setReadable(true);
	            imgDir.setWritable(true, true);
	            
				if ( !imgDir.exists() ) {
					imgDir.mkdirs();
				}
				
				String srcFileNm = imgFile.getOriginalFilename();
				String fileExt = FilenameUtils.getExtension(srcFileNm);
				String saveFileNm = uuid + "." + fileExt;
				
				if ( StringUtils.contains(fileExt, "png") || StringUtils.contains(fileExt, "gif") 
						|| StringUtils.contains(fileExt, "jpg") || StringUtils.contains(fileExt, "jpeg") ) {
					// nothing to do..
				}
				else {
					throw new SystemException("이미지 파일만 선택해 주세요.(GIF/JPG/PNG)");
				}
				
				if(srcFileNm != null && !"".equals(srcFileNm)){
					String saveImgDir = EgovWebUtil.filePathBlackList(directoryPath + "img" + File.separator);
					String saveImgFile = EgovWebUtil.filePathBlackList(saveImgDir + saveFileNm);
					fis2 = new FileOutputStream(EgovWebUtil.filePathBlackList(saveImgFile));
					//OutputStream bos = fis2;
					InputStream stream = imgFile.getInputStream();
				    int bytesRead = 0;
				    byte[] buffer = new byte[2048];

				    while ((bytesRead = stream.read(buffer, 0, 2048)) != -1) {
				    	fis2.write(buffer, 0, bytesRead);
				    }
				    
				    // 썸네일 생성
				    makeThumbnail(new File(saveImgFile), saveImgDir, saveFileNm, fileExt);
				    
				    params.put("tmnlImgFile", saveFileNm);
				}
			}
		} catch(SystemException se){
			EgovWebUtil.exLogging(se);
			throw new ServiceException(se.getMessage());
		} catch(FileNotFoundException fne) {
			EgovWebUtil.exLogging(fne);
		} catch(Exception e) {
			EgovWebUtil.exLogging(e);
		} finally {
			try {
				if ( fis1 != null ) {
					fis1.close();
				}
				if ( fis2 != null ) {
					fis2.close();
				}
			} catch(FileNotFoundException e){
				EgovWebUtil.exLogging(e);
			}
			catch(Exception e) {
				EgovWebUtil.exLogging(e);
			}
		}
	}
	
	/**
	 * 썸네일 이미지를 생성한다.
	 * @param originFile	이미지 파일
	 * @param fileDir		파일저장 디렉토리
	 * @param fileNm		파일명
	 * @param fileExt		확장자
	 * @throws IOException 
	 * @throws Exception
	 */
	private void makeThumbnail(File originFile, String fileDir, String fileNm, String fileExt) throws IOException {
		int thumbWidth = 250;
		
		// 원본파일 버퍼 생성
		BufferedImage originFileBuffer = null;
		originFileBuffer = ImageIO.read( originFile );
		// 썸네일 높이 계산
		int originWidth;
		int originHeight;
		if (originFileBuffer != null) {
			originWidth = originFileBuffer.getWidth();
			originHeight = originFileBuffer.getHeight();
		} else {
			throw new SystemException("썸네일 생성 대상 파일에 오류가 있습니다.");
		}

		int thumbHeight = originHeight * thumbWidth / originWidth ;
		
		// 썸네일 파일 버퍼 생성
		BufferedImage thumbFileBuffer = new BufferedImage(thumbWidth, thumbHeight, BufferedImage.TYPE_3BYTE_BGR);
		
		// 썸네일 파일 생성
		File thumbFile =  new File(fileDir + "thumb_" + fileNm );
		
		Graphics2D graphic = thumbFileBuffer.createGraphics();
		
		graphic.drawImage(originFileBuffer, 0, 0, thumbWidth, thumbHeight, null);
		
		ImageIO.write( thumbFileBuffer, fileExt  , thumbFile );

	}

	/**
	 * 정보공개 문서 파일을 삭제한다. 
	 */
	@Override
	public Result deleteDocInfFile(Params params) {
		try {
			docInfMgmtDao.deleteDocInfFile(params);
			return success(getMessage("admin.message.000005"));
		} catch(DataAccessException dae) {
			error("DataAccessException : " , dae);
			EgovWebUtil.exTransactionLogging(dae);
			SQLException se = (SQLException) ((DataAccessException) dae).getRootCause();
			throw new DBCustomException(getDbmsExceptionMsg(se));
		} catch(Exception e) {
			error("Exception : " , e);
			EgovWebUtil.exTransactionLogging(e);
			throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
		}
	}

	/**
	 * 문서공개 원본 파일 고유번호를 조회한다.
	 */
	@Override
	public List<Record> selectDocInfFileSrcFileSeq(Params params) {
		return docInfMgmtDao.selectDocInfFileSrcFileSeq(params);
	}

	/**
	 * 문서공개 첨부파일 순서를 저장한다.
	 */
	@Override
	public Result saveDocInfFileOrder(Params params) {
		String updId = params.getString("updId");
		Params[] data = params.getJsonArray(Params.SHEET_DATA);
		
		for (int i = 0; i < data.length; i++) {
        	data[i].put("updId", updId);
        	docInfMgmtDao.saveDocInfFileOrder(data[i]);
        }
		
		return success(getMessage("저장이 완료되었습니다."));
	}

	/**
	 * 문서공개 첨부파일 이미지를 미리보기 한다. 
	 */
	@Override
	public Record selectDocInfFileThumbnail(Params params) {
		List<Record> list = docInfMgmtDao.selectDocInfFile(params);
		Record file  = null;
		if ( list.size() > 0 && list.size() == 1 ) {
			file = list.get(0);
			
			// 원본 표시여부
			file.put("srcYn", StringUtils.equals("Y", params.getString("srcYn")) ? true : false);
		}
        
		Record thumbnail = new Record();
        thumbnail.put("docId", params.getString("docId"));
        thumbnail.put("tmnlImgFile", thumbnail.getString("tmnlImgFile"));
        
        thumbnail.put(ImageView.FILE_PATH, getFilePath(file));
        thumbnail.put(ImageView.FILE_NAME, thumbnail.getString("tmnlImgFile"));
        
        return thumbnail;
	}
	
	/**
	 * 문서공개 첨부파일 파일 정보 가져오기
	 * @param file
	 * @return
	 */
	private String getFilePath(Record file) {
        StringBuffer buffer = new StringBuffer();
        
        buffer.append(EgovProperties.getProperty("Globals.docInfFilePath"));
        buffer.append(file.getString("docId"));
        buffer.append(File.separator);
        buffer.append("img");
        buffer.append(File.separator);
        
        // 원본 표시여부
        if ( !file.getBoolean("srcYn") ) {
        	buffer.append("thumb_");
        }
        buffer.append(EgovWebUtil.filePathReplaceAll(file.getString("tmnlImgFile")));
        
        return buffer.toString();
    }
}

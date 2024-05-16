package egovframework.admin.stat.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

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

import egovframework.admin.stat.service.StatSttsStatService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.common.base.constants.ModelAttribute;
import egovframework.common.base.exception.DBCustomException;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.exception.SystemException;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;
import egovframework.common.base.service.BaseService;

/**
 * 통계 메타를 관리하는 서비스 클래스
 * @author	김정호
 * @version 1.0
 * @since   2017/08/07
 */
@Service(value="statSttsStatService")
public class StatSttsStatServiceImpl extends BaseService implements StatSttsStatService {
	
	public static final int BUFF_SIZE = 2048;
	
	/**
	 * 통계설명 팝업 아이콘
	 */
	protected static final String STAT_EXP_POP_ICON = "<img src=\"../../images/admin/icon_book.png\"/>";
	/**
	 * 통계표 팝업 아이콘
	 */
	protected static final String STAT_TBL_POP_ICON = "<img src=\"../../images/admin/icon_file.gif\"/>";
	
	@Resource(name="statSttsStatDao")
	protected StatSttsStatDao statSttsStatDao;

	/**
	 * 통계 설명 리스트 조회
	 */
	@Override
	public List<Record> statSttsStatList(Params params) {
		String statNm = "";			//통계메타명
		String statId = "";			//통계메타ID
		String statExpHtml = "";	//통계설명 Html 값
		//리스트 조회
		List<Record> list = (List<Record>) statSttsStatDao.selectStatSttsStat(params);	
		
		//조회된 리스트에 통계설명 팝업 아이콘 끼워 넣는다.(클릭시 통계설명 팝업창)
		for ( Record r : list ) {
			statId = r.getString("statId");
			statNm = r.getString("statNm");
			statExpHtml = " <a href=\"/admin/stat/popup/statMetaExpPopup.do?statId="+statId+"\" target=\"_blank\" title=\"통계설명(팝업)\">" + STAT_EXP_POP_ICON + "</a>";
			r.put("statNm", statNm + statExpHtml);
		}
		
		return list;
	}
	
	/**
	 * 통계 설명 관리 입력
	 */
	@Override
	public Result insertStatSttsStat(Params params) {
		statSttsStatDao.insertStatSttsStat(params);
		return success(getMessage("admin.message.000003"));	//등록이 완료되었습니다
	}

	/**
	 * 통계 설명 관리 상세
	 */
	@Override
	public Record statSttsStatDtl(Params params) {
		return (Record) statSttsStatDao.selectStatSttsStatDtl(params);
	}
	
	/**
	 * 통계설명 메타정보 조회
	 */
	@Override
	public List<Record> statSttsStddMeta(Params params) {
		return (List<Record>) statSttsStatDao.selectStatSttsStddMeta(params);
	}
	
	/**
	 * 통계 설명 관리 담당자 리스트 조회
	 */
	@Override
	public List<Record> statSttsStatUsrList(Params params) {
		return (List<Record>) statSttsStatDao.selectSttsStatUsrList(params);
	}

	/**
	 * 통계 설명 메타정보 메타입력 유형코드 조회(실 데이터 확인 후)
	 */
	@Override
	public List<Record> statSttsStatExistMetaCd(Params params) {
		return (List<Record>) statSttsStatDao.selectStatSttsStatExistMetaCd(params);
	}

	/**
	 * 통계설명 메타정보 저장
	 */
	@Override
	public Result saveStatSttsStatMeta(HttpServletRequest request, Params params) {
		try {

			/* 통계설명정보 저장 */
			statSttsStatDao.saveSttsStat(params);
			
			LinkedList<Record> list = new LinkedList<Record>();
			String statId = params.getString("statId");		//통계 설명 ID
			
			/**
			 * 넘어온 파라미터 중에 동적으로 생성된 파라미터만 뽑아서 리스트화 한다 
			 */
			for( Entry<Object, Object> elem : params.entrySet() ){
				String key = String.valueOf(elem.getKey());
				String value = String.valueOf(elem.getValue());
				if ( key.indexOf("MTCD_") > -1 ) {	//동적 생성된 파라미터 구분자
					Record rec = new Record();
					String metaId = getMetatyCdIdxValue(key, 1);	//메타 ID
					String metatyCd = getMetatyCdIdxValue(key, 2);	//메타 입력 유형 코드
	
					rec.put("statId", statId);
					rec.put("metaId", Integer.parseInt(metaId));
					
					//리스트에 파라미터의 meta 가 속해 있는지 확인하고 속해 있는경우 index 값 넘겨준다
					int metaIdx = iExistMetaDataIdx(list, metaId);
					
					if ( "ST".equals(metatyCd) ) {
						//문자열 인 경우
						if ( metaIdx > -1 ) {	//리스트 정보가 있는 경우
							if ( "kor".equals(getMetatyCdIdxValue(key, 3)) ) {
								//한글 인 경우
								list.get(metaIdx).put("metaCont", value);	//해당 index에 값을 추가로 넣음	
							} else {
								list.get(metaIdx).put("engMetaCont", value);
							}
						} else {
							if ( "kor".equals(getMetatyCdIdxValue(key, 3)) ) {
								rec.put("metaCont", value);
							} else {
								rec.put("engMetaCont", value);
							}
						}
					} else if ( "SB".equals(metatyCd) ) {
						//콤보박스 인 경우
						rec.put("ditcCd", value);
					} else if ( "NB".equals(metatyCd) || "DD".equals(metatyCd) ) {
						//숫자형 이거나 날짜인 경우
						rec.put("metaCont", value);
					} else if ( "FL".equals(metatyCd) ) {
						//파일인 경우
						if ( metaIdx > -1 ) {
							if ( "saveNm".equals(getMetatyCdIdxValue(key, 3)) ) {
								list.get(metaIdx).put("saveFileNm", value);		//저장파일명
							} else if ( "viewKorNm".equals(getMetatyCdIdxValue(key, 3)) ) {
								list.get(metaIdx).put("viewFileNm", value);		//출력파일명(한글)
							} else if ( "viewEngNm".equals(getMetatyCdIdxValue(key, 3)) ) {
								list.get(metaIdx).put("engViewFileNm", value);	//출력파일명(영문)
							}
						} else {
							if ( "saveNm".equals(getMetatyCdIdxValue(key, 3)) ) {
								rec.put("saveFileNm", value);
							} else if ( "viewKorNm".equals(getMetatyCdIdxValue(key, 3)) ) { 
								rec.put("viewFileNm", value);
							} else if ( "viewEngNm".equals(getMetatyCdIdxValue(key, 3)) ) { 
								rec.put("engViewFileNm", value);
							}
						}
					}
					if ( metaIdx <= -1 ) {	//리스트 index 확인한 후 키 값이 생성되지 않은 경우
						list.push(rec);
					} 
				}
			}
			
			/* 메타 파일 저장 */
			saveStatMetaFile(request, list, params);
			
			/* 리스트화 한 데이터 저장(TB_STTS_STAT_META 머지인투) */
			statSttsStatDao.saveSttsStatMeta(list);
			
			/* 통계설명 관리 담당자 저장 */
			saveStatMetaUsr(params);
			
			/* 통계메타 정보 백업 */
			params.set(ModelAttribute.ACTION_STATUS, ModelAttribute.ACTION_UPD);
			statSttsStatDao.execSpBcupSttsStat(params);
			
			return success(getMessage("admin.message.000006"));
			
		} catch(DataAccessException dae) {
			//procedure 리턴 메세지 표시.
			SQLException se = (SQLException) ((DataAccessException) dae).getRootCause();
			throw new DBCustomException(getDbmsExceptionMsg(se));
		} catch(ServiceException se) {
			EgovWebUtil.exLogging(se);
			throw new SystemException("에러발생");
		} catch(Exception e) {
			EgovWebUtil.exLogging(e);
			throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
			/*if (e instanceof DataAccessException) {
				SQLException se = (SQLException) ((DataAccessException) e).getRootCause();
				String msg = se.getMessage();
				//throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
				
				//return failure("test");
			} else {
				throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
			}*/
		}
		
	}

	/**
	 * 통계설명 관리 담당자 저장
	 * @param params
	 */
	private void saveStatMetaUsr(Params params) {
		int updCnt = 0;
		int usrCnt = 0;

		String statId = params.getString("statId");
		String regId = params.getString("regId");
		String updId = params.getString("updId");
		
		Map<String, LinkedList<Record>> pMap = new HashMap<String, LinkedList<Record>>();
		LinkedList<Record> usrList = new LinkedList<Record>();
		Record usrRec = null;
		Record usrOwnerRec = new Record();
       
		try{
			//ibsheet에서 넘어온 json data
	        JSONArray jsonArray = new JSONObject(params.getJsonObject("ibsSaveJson")).getJSONArray("data");
	        for (int i = 0; i < jsonArray.length(); i++) {
	        	usrRec = new Record();
	        	JSONObject jsonObj = (JSONObject) jsonArray.get(i);
	        	usrRec.put("statId", statId);
	        	
	        	// 테이블 키값이 usrCd인데 유저가 없을경우 dummyUser 세팅
	        	if ( StringUtils.isEmpty(jsonObj.getString("usrCd")) ) {
	        		usrRec.put("usrCd", "0");
	        	} 
	        	else {
	        		usrRec.put("usrCd", jsonObj.getString("usrCd"));
	        	}
	        	
	        	usrRec.put("orgCd", jsonObj.getString("orgCd"));
	        	usrRec.put("rpstYn", jsonObj.getString("rpstYn"));
	        	usrRec.put("prssAccCd", jsonObj.getString("prssAccCd"));
	        	usrRec.put("srcViewYn", jsonObj.getString("srcViewYn"));
	        	usrRec.put("vOrder", i+1);
	        	if ( !StringUtils.isEmpty(jsonObj.getString("status")) && "D".equals(jsonObj.getString("status")) ) {
	        		//상태가 삭제 인 경우
	        		usrRec.put("useYn",   "N");
	        	} else {
	        		usrRec.put("useYn",   jsonObj.getString("useYn"));
	        	}
	        	usrRec.put("regId", regId);
	        	usrRec.put("updId", updId);
	        	usrList.add(usrCnt++, usrRec);
	        	
	        	//대표 담당자 지정 값 확인(마스터 테이블<TB_STTS_STAT>에 값 저장하기 위함)
	        	if ( "Y".equals(jsonObj.getString("rpstYn")) ) {
	        		usrOwnerRec.put("statId", statId);
	        		usrOwnerRec.put("orgCd", jsonObj.getString("orgCd"));
	        		
	        		// 테이블 키값이 usrCd인데 유저가 없을경우 dummyUser 세팅
	            	if ( StringUtils.isEmpty(jsonObj.getString("usrCd")) ) {
	            		usrOwnerRec.put("usrCd", "0");
	            	} 
	            	else {
	            		usrOwnerRec.put("usrCd", jsonObj.getString("usrCd"));
	            	}
	        	}
	        }
	        
	        pMap.put("pMap", usrList);
			
			//통계설명 관리담당자 수정
	 		statSttsStatDao.delSttsStatUsr(params);	//데이터 일괄 삭제(USE_YN update)
			updCnt = (Integer) statSttsStatDao.mergeSttsStatUsr(pMap);	//머지인투 처리
	 		if ( updCnt <= 0 )	{
				throw new ServiceException("admin.error.000003", getMessage("admin.error.000003"));
			}
			
			//대표담당자 처리
			updCnt = (Integer) statSttsStatDao.updateSttsStatOwner(usrOwnerRec);
			if ( updCnt <= 0 ) {
				throw new ServiceException("admin.error.000003", getMessage("admin.error.000003"));
			}
		} catch (DataAccessException dae) {
			EgovWebUtil.exLogging(dae);
		} catch (JSONException je) {
			EgovWebUtil.exLogging(je);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
	}
	
	/**
	 * 메타 관련 파일 저장
	 * @param request
	 * @param list
	 * @param params
	 * @return
	 * @throws IOException 
	 * @throws Exception
	 */
	private LinkedList<Record> saveStatMetaFile(HttpServletRequest request, LinkedList<Record> list, Params params) throws IOException {
		final MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
 		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		MultipartFile file;
		String filePath = "";
		FileOutputStream fos = null;
		
		try {
			//저장 디렉토리(properties + 통계설명 ID)
			String directoryPath = EgovProperties.getProperty("Globals.StatSttsStatMetaFilePath") + File.separator + params.getString("statId");
			 
			while (itr.hasNext()) {
				Entry<String, MultipartFile> entry = itr.next();
				String key = String.valueOf(entry.getKey());
			 
				file = entry.getValue();
				if (!"".equals(file.getOriginalFilename())) {
					String metaId = getMetatyCdIdxValue(key, 1);
					int metaIdx = iExistMetaDataIdx(list, metaId);
					String srcFileNm = file.getOriginalFilename(); 					//원본 파일명
					String fileExt = FilenameUtils.getExtension(srcFileNm);			//파일 확장자
					String saveFileNm = list.get(metaIdx).getString("saveFileNm");	//저장파일명(파라미터 값)
					
					list.get(metaIdx).put("srcFileNm", srcFileNm);		
					list.get(metaIdx).put("fileSize", file.getSize());	//파일 사이즈
					list.get(metaIdx).put("fileExt", fileExt);			

					if(saveFileNm != null && !"".equals(saveFileNm)){
						fos = new FileOutputStream(EgovWebUtil.filePathBlackList(directoryPath + File.separator + saveFileNm + "." + fileExt));
						InputStream stream = file.getInputStream();
					    int bytesRead = 0;
					    byte[] buffer = new byte[BUFF_SIZE];

					    while ((bytesRead = stream.read(buffer, 0, BUFF_SIZE)) != -1) {
					    	fos.write(buffer, 0, bytesRead);
					    }
					}
				}
			}
		} catch(IOException ioe) {
			EgovWebUtil.exLogging(ioe);
			throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
		} catch(Exception e) {
			EgovWebUtil.exLogging(e);
			throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
		} finally {
    		if ( fos != null ) {
    			fos.close();
    		}
		}
		
		return list;
	}

	/**
	 * 통계설명 정보 삭제(메타정보, 유저 포함)
	 */
	@Override
	public Result deleteStatSttsStat(Params params) {
		try {
			/* 통계메타 정보 백업 후 삭제 */
			params.set(ModelAttribute.ACTION_STATUS, ModelAttribute.ACTION_DEL);
			statSttsStatDao.execSpBcupSttsStat(params);
			
			return success(getMessage("admin.message.000005"));	//삭제가 완료 되었습니다.
			
		} catch(DataAccessException dae) {
			//procedure 리턴 메세지 표시.
			SQLException se = (SQLException) ((DataAccessException) dae).getRootCause();
			throw new DBCustomException(getDbmsExceptionMsg(se));
		} catch(Exception e) {
			EgovWebUtil.exLogging(e);
			throw new SystemException("admin.error.000001", getMessage("admin.error.000001"));
		}
		
		
	}
	
	/**
	 * 메타 입력 유형코드 키 값으로 idx에 속한 데이터 가져온다.
	 * @param fId	임의로 생성한 키값
	 * @param idx	index
	 * @return	키 값의 split한 index 값
	 */
	private String getMetatyCdIdxValue(String key, int idx) {
		String[] str;
		if ( "".equals(key) ) {
			return "";
		} else {
			str = key.split("_");
			return str[idx];
		}
	}
	
	/**
	 * 리스트에 파라미터의 meta 가 속해 있는지 확인하고 속해 있는경우 index 값 넘겨준다
	 * @param list		통계설명 메타정보 리스트
	 * @param metaId	메타 ID
	 * @return	리스트에 속한 메타 ID의 index
	 */
	private int iExistMetaDataIdx(LinkedList<Record> list, String metaId) {
		for ( int i=0; i < list.size(); i++ ) {
			Record rec = list.get(i);
			if ( !StringUtils.isEmpty(rec.getString("metaId")) && rec.getString("metaId").equals(metaId) ) {
				return i;
			}
		}
		return -1;
	}

	/**
	 * 순서 저장
	 */
	@Override
	public Result saveSttsStatOrder(Params params) {
		Record rec = null;
		try {
			JSONArray jsonArray = new JSONObject(params.getJsonObject("ibsSaveJson")).getJSONArray("data");
			for (int i = 0; i < jsonArray.length(); i++) {
	        	rec = new Record();
	        	JSONObject jsonObj = (JSONObject) jsonArray.get(i);
	        	rec.put("statId", jsonObj.getString("statId"));
	        	rec.put("vOrder", jsonObj.getInt("vOrder"));
	        	statSttsStatDao.updateSttsStatMetaVorder(rec);
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
	 * 통계설명 ID를 사용하는 공개된 통계표 갯수 확인
	 * @param params
	 * @return
	 */
	@Override
	public Record statSttsOpenStateTblCnt(Params params) {
		return (Record) statSttsStatDao.selectStatSttsOpenStateTblCnt(params);
	}

}
	



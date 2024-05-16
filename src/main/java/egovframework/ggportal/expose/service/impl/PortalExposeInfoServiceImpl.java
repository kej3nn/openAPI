/*
 * @(#)PortalExposeInfoServiceImpl.java 1.0 2019/07/19
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.expose.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.exception.SystemException;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;
import egovframework.common.base.service.BaseService;
import egovframework.common.base.view.FileDownloadView;
import egovframework.ggportal.expose.service.PortalExposeInfoService;
/**
 * 정보공개 요청을 관리하는 서비스 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Service("portalExposeInfoService")
public class PortalExposeInfoServiceImpl extends BaseService implements PortalExposeInfoService {
	
	public static final int BUFF_SIZE = 2048;
	
	public long FILE_MAX_SIZE = 1024 * 1024 * 30;
	
	
    /**
     * 정보공개 요청을 관리하는 DAO
     */
    @Resource(name="portalExposeInfoDao")
    private PortalExposeInfoDao portalExposeInfoDao;
    
    /**
     * 정보공개 청구대상기관 정보를 조회한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> selectNaboOrg(Params params) {
        // 청구대상기관 정보를 검색한다.
        return portalExposeInfoDao.selectNaboOrg(params);
    }

    /**
     * 정보공개 코드 정보를 조회한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> selectComCode(Params params) {
        // 코드 정보를 검색한다.
        return portalExposeInfoDao.selectComCode(params);
    }

    /**
     * 정보공개 청구서작성 데이터를 등록한다.
     * 
     * @param params 파라메터
     * @return 등록결과
     */
	@Override
	public Object insertAccount(HttpServletRequest request, Params params) {
		final MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
		
		// 작성된 청구서 변경시 본인여부와 현재상태 체크(수정시 파라미터 변조 방지)
		if ( StringUtils.isNotEmpty(params.getString("apl_no")) ) {
			String status = portalExposeInfoDao.selectOpnzUsrAccChkStatus(params);
			if ( StringUtils.equals("X", status) ) {
				throw new ServiceException("본인의 청구서만 수정 할 수 있습니다."); 
			}
			else if ( !StringUtils.equals("01", status) ) {
				throw new ServiceException("신청중인 청구서만 수정 할 수 있습니다.");
			}
		}
		
		int transCnt = portalExposeInfoDao.selectOpnzAplTransCnt(params);
		if ( transCnt > 0 ) {
			throw new ServiceException("이송중인 청구건은 수정 할 수 없습니다.");
		}

		//신청일자
		DateFormat sdFormat = new SimpleDateFormat("yyyyMMdd");
		Date nowDate = new Date();
		params.set("aplDt", String.valueOf(sdFormat.format(nowDate)));
		
		//진행상태 > 접수중 01
		params.set("prgStatCd", "01");
		
		String apl_pno = getInserValue(params.getString("apl_pno1"), params.getString("apl_pno2"), params.getString("apl_pno3"), "-");
		String apl_mbl_pno = getInserValue(params.getString("apl_mbl_pno1"), params.getString("apl_mbl_pno2"), params.getString("apl_mbl_pno3"), "-");
		String apl_fax_no = getInserValue(params.getString("apl_fax_no1"), params.getString("apl_fax_no2"), params.getString("apl_fax_no3"), "-");
		String apl_email = getInserValue(params.getString("apl_email1"), params.getString("apl_email2"), "", "@");

		params.set("aplPno", apl_pno);			//신청전화번호
		params.set("aplMblPno", apl_mbl_pno);	//신청휴대전화번호
		params.set("aplFaxNo", apl_fax_no);	//신청팩스번호
		params.set("aplEmailAddr", apl_email);	//신청이메일주소
		params.set("aplZpno", params.getString("apl_zpno"));		//신청우편번호
		params.set("apl1Addr", params.getString("apl_addr1"));	//신청1주소
		params.set("apl2Addr", params.getString("apl_addr2"));	//신청2주소
		params.set("aplSj", params.getString("apl_sj_bfmod"));	//신청제목
		params.set("aplDtsCn", params.getString("apl_dtscn_bfmod"));	//신청상세내용
		
		params.set("opbFomVal", params.getString("opb_fom"));	//공개형태값
		params.set("opbFomEtc", params.getString("opb_fom_etc"));	//공개형태기타
		params.set("aplTakMth", params.getString("apl_tak_mth"));	//신청수령방법
		params.set("aplTakMthEtc", params.getString("apl_takmth_etc"));	//신청수령방법기타
		params.set("feeRdtnCd", params.getString("fee_rdtn_yn"));	//수수료감면코드
		params.set("feeRdtnRson", params.getString("fee_rdtn_rson"));	//수수료감면사유
		params.set("dcsNtcRcvMthCd", params.getString("dcs_ntc_rcvmth"));	//결정통지수신방법코드
		params.set("dcsNtcRcvMthSms", params.getString("dcs_ntc_rcvmth_sms"));	//결정통지수신방법코드(SMS)
		params.set("dcsNtcRcvMthMail", params.getString("dcs_ntc_rcvmth_mail"));	//결정통지수신방법코드(메일)
		params.set("dcsNtcRcvMthTalk", params.getString("dcs_ntc_rcvmth_talk"));	//결정통지수신방법코드(카카오알림톡)
		
		
		if ( StringUtils.isNotBlank(params.getString("dcsNtcRcvMthSms")) || StringUtils.isNotBlank(params.getString("dcsNtcRcvMthSms")) ) {
			if ( StringUtils.equals(params.getString("dcsNtcRcvMthSms"), params.getString("dcsNtcRcvMthTalk")) ) {
				throw new ServiceException("SMS와 카카오알림톡은 동시에 선택할 수 없습니다.");
			}
		}

		params.set("aplInstCd", params.getString("apl_instcd"));			//청구기관코드
		if ( StringUtils.isEmpty(params.getString("apl_deal_instcd")) ) {
			params.set("aplDealInstCd", params.getString("apl_instcd"));
		}
		else {
			params.set("aplDealInstCd", params.getString("apl_deal_instcd"));
		}
		/*
		params.set("aplCorpNm", ""); 		//신청법인명?
		params.set("aplBno", ""); 			//신청사업자등록번호?
		params.set("aplModSj", ""); 		//신청수정제목?
		params.set("aplModDtsCn", ""); 	//신청수정상세내용?
		
		params.set("sysRegId", ""); 		//등록자ID?
		params.set("sysRegDttm", ""); 	//등록일자?
		params.set("sysUpdId", ""); 		//수정자ID?
		params.set("sysUpdDttm", ""); 	//수정일자?
	*/	
		//등록구분 0.온라인, 1.오프라인
		params.set("rgDiv", "0");
		String msg = "";
		
		try {
			//저장 디렉토리
			String directoryPath = EgovProperties.getProperty("Globals.OpnzAplFilePath");
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
					String srcFileNm = file.getOriginalFilename(); 				//원본 파일명
					String fileExt = FilenameUtils.getExtension(srcFileNm);		//파일 확장자
					String filePhNm = (new Date()).getTime() + "." + fileExt;   //저장파일명
					
					if ( file.getSize() > FILE_MAX_SIZE ) {
						throw new ServiceException("30MB 이내의 파일만 등록해 주세요.");
					}
					
					if ( saveKey.equals("file") ) {
						params.set("attchFlNm", srcFileNm);		//첨부파일명
						params.set("attchFlPhNm", filePhNm);	//저장파일명
					}

					if ( saveKey.equals("file1") ) {
						params.set("feeAttchFlNm", srcFileNm);	//수수료첨부파일명
						params.set("feeAttchFlPh", filePhNm);	//수수료첨부파일 저장파일명
					}
					
					params.set(saveKey, filePhNm);
					
					if(filePhNm != null && !"".equals(filePhNm)){
						@SuppressWarnings("resource")
						FileOutputStream fos = null;
						try {
							fos = new FileOutputStream(EgovWebUtil.filePathBlackList(directoryPath + File.separator + filePhNm));
							InputStream stream = file.getInputStream();
							int bytesRead = 0;
							byte[] buffer = new byte[BUFF_SIZE];
							
							while ((bytesRead = stream.read(buffer, 0, BUFF_SIZE)) != -1) {
								fos.write(buffer, 0, bytesRead);
							}
						} catch(IOException ioe) {
							EgovWebUtil.exLogging(ioe);
						} catch(Exception e) {
							EgovWebUtil.exLogging(e);
						} finally {
							try {
				        		if ( fos != null ) {
				        			fos.close();
				        		}
				        	} catch (DataAccessException e) {
				    			EgovWebUtil.exLogging(e);
				    		} catch (Exception e) {
				    			EgovWebUtil.exLogging(e);
				    		}
						}
					}
				}else {
					// 파일이 없는 경우 DB값 null 처리
					params.set(saveKey, "");
				}
				
			}
			
			//신청번호
			if ( StringUtils.isEmpty(params.getString("apl_no")) ) {
				
				String aplNo = portalExposeInfoDao.selectNextAplNo();
				params.set("aplNo", String.valueOf(aplNo));

				portalExposeInfoDao.saveAccount(params);
				msg = "정보공개 청구서를 등록 하였습니다.";
				//기관 정보공개 담당자에게 SMS 발송
				accountRegSendSMS(request, params);
				
				
				params.set("prg_stat_cd", "01");
				params.put("usr_id", "");
				params.set("hist_cn",  "온라인 청구서");
				portalExposeInfoDao.insertOpnHist(params);
				
			}else{
				
				if(StringUtils.isEmpty(params.getString("attchFlNm"))){
					if(params.getString("apl_attch_delete").equals("Y")){
						params.put("attchFlNm", "");
						params.put("attchFlPhNm", "");
					}else{
						params.put("attchFlNm", params.get("apl_attch_flnm"));
						params.put("attchFlPhNm", params.get("apl_attch_flph"));
					}
				}
				
				if(StringUtils.isEmpty(params.getString("feeAttchFlNm"))){
					if(params.getString("fee_rdtn_attch_delete").equals("Y")){
						params.put("feeAttchFlNm", "");
						params.put("feeAttchFlPh", "");
					}else{
						params.put("feeAttchFlNm", params.get("fee_rdtn_attch_flnm"));
						params.put("feeAttchFlPh", params.get("fee_rdtn_attch_flph"));
					}
				}
				
				params.set("aplNo", params.getString("apl_no"));
				portalExposeInfoDao.saveAccount(params);
				msg = "정보공개 청구서를 수정 하였습니다.";
			}
			
		} catch (ServiceException sve){
			EgovWebUtil.exLogging(sve);
			throw new ServiceException(sve.getMessage());
		}
		catch(SystemException e) {
			EgovWebUtil.exTransactionLogging(e);
			throw new SystemException(e.getMessage());
		} catch (DataAccessException e) {
			EgovWebUtil.exTransactionLogging(e);
			throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
		} catch (Exception e) {
			error("Exception : " , e);
			EgovWebUtil.exTransactionLogging(e);
			throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
		}
		
		
		return success(msg);
	}	

	/**
	 * 전화번호, 우편번호, 이메일 Sum  
	 * @param String
	 * @param String
	 * @param String
	 * @return String
	 * @throws
	 */
	public String getInserValue(String val1, String val2, String val3, String val){
		String rtnVal = "";
		if(!"".equals(val2)){
			if(!"".equals(val3)){
				rtnVal = val1 + val + val2+ val +val3;			
			}else{
				rtnVal = val1 + val + val2;
			}
		}
		return rtnVal;
	}
	
    /**
     * 정보공개 청구서처리현황 내용을 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public Paging searchAccount(Params params) {
    	params.put("aplDtFrom", ((String) params.get("aplDtFrom")).replaceAll("-", ""));
    	params.put("aplDtTo", ((String) params.get("aplDtTo")).replaceAll("-", ""));
    	    	
        return portalExposeInfoDao.searchAccount(params, params.getPage(), params.getRows());
    }

	/**
	 * 정보공개 청구서작성 내용을 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
	public Map<String, Object> getInfoOpenApplyDetail(Params params) {
		return (Map<String, Object>) portalExposeInfoDao.getInfoOpenApplyDetail(params);
	}

    /**
     * 정보공개 청구를 취하한다.
     * 
     * @param params 파라메터
     * @return 등록결과
     */
	@Override
	public Object withdrawAccount(HttpServletRequest request , Params params) {

		String msg = "";

		try {			
			params.put("prg_stat_cd", "99");	

			portalExposeInfoDao.updateOpnApplyCancle(params);
			if("1".equals(params.get("apl_cancle"))){
				portalExposeInfoDao.updateOpnRcpCancle(params);
			}
			
			params.put("aplNo", params.get("apl_no"));
			params.put("hist_cn", "청구인에 의한 청구취하");
			portalExposeInfoDao.insertOpnHist(params);

			msg = "청구취하되었습니다.";
			//기관 정보공개 담당자에게 SMS 발송
			accountWithdrawSendSMS(request, params);			
		}
		 catch (DataAccessException e) {
			error("Exception : " , e);
			EgovWebUtil.exTransactionLogging(e);
			throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
		} catch (Exception e) {
			error("Exception : " , e);
			EgovWebUtil.exTransactionLogging(e);
			throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
		}		
		
		return success(msg);
	}	

	/**
	 * 정보공개 청구서 처리 이력을 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
	public List<?> getInfoOpenApplyHist(Params params){
		return portalExposeInfoDao.getInfoOpenApplyHist(params);
	}
	
    /**
     * 정보공개 이의신청서 대상을 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public Paging targetObjection(Params params) {
    	params.put("aplDtFrom", ((String) params.get("aplDtFrom")).replaceAll("-", ""));
    	params.put("aplDtTo", ((String) params.get("aplDtTo")).replaceAll("-", ""));
    	
        return portalExposeInfoDao.targetObjection(params, params.getPage(), params.getRows());
    }

    /**
     * 정보공개 이의신청서작성 데이터를 등록한다.
     * 
     * @param params 파라메터
     * @return 등록결과
     */
	@Override
	public Object insertObjection(HttpServletRequest request, Params params) {
		final MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;

		String msg = "";
		//FileOutputStream fos = null;
		
		try {
			//저장 디렉토리
			String directoryPath = EgovProperties.getProperty("Globals.OpnzAplFilePath");
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
					String srcFileNm = file.getOriginalFilename(); 				//원본 파일명
					String fileExt = FilenameUtils.getExtension(srcFileNm);		//파일 확장자
					String filePhNm = (new Date()).getTime() + "." + fileExt;   //저장파일명
					
					params.set("objtnAplFlnm", srcFileNm);	//첨부파일명
					params.set("objtnAplFlph", filePhNm);	//저장파일명명
					params.set(saveKey, filePhNm);
					
					if(filePhNm != null && !"".equals(filePhNm)){
						@SuppressWarnings("resource")
						FileOutputStream fos = null;
						try {
							fos = new FileOutputStream(EgovWebUtil.filePathBlackList(directoryPath + File.separator + filePhNm));
							InputStream stream = file.getInputStream();
							int bytesRead = 0;
							byte[] buffer = new byte[BUFF_SIZE];
							
							while ((bytesRead = stream.read(buffer, 0, BUFF_SIZE)) != -1) {
								fos.write(buffer, 0, bytesRead);
							}
						} catch(IOException ioe) {
							EgovWebUtil.exLogging(ioe);
						} catch(Exception e) {
							EgovWebUtil.exLogging(e);
						} finally {
							try {
				        		if ( fos != null ) {
				        			fos.close();
				        		}
				        	} catch (DataAccessException e) {
				    			EgovWebUtil.exLogging(e);
				    		} catch (Exception e) {
				    			EgovWebUtil.exLogging(e);
				    		}
						}
					}
				}else {
					// 파일이 없는 경우 DB값 null 처리
					params.set(saveKey, "");
				}
				
			}
			
			//이의신청 다음순번 확인
			String nextObjtnSno = portalExposeInfoDao.getInfoOpenObjtnSnoNext(params);
			params.put("objtnSno", nextObjtnSno);
			
			String dcsNtcDt = null;
			if("".equals(params.get("dcsNtcDt"))) {
				dcsNtcDt =  (String) params.get("firstDcsDt");
			} else {
				dcsNtcDt = (String) params.get("dcsNtcDt");
			}
			
			params.put("apl_no", params.get("aplNo"));
			params.put("histDiv", "21");									// Hist 구분
			params.put("histCn", "");										// Hist 내용 
			params.put("usrId", "");
			params.put("objtnNtcsYn", params.get("ntcs_yn"));
			params.put("dcsNtcDt", dcsNtcDt.replaceAll("-", ""));
			params.put("objtnRson", "");
			params.put("opb_clsd_cn", params.get("opb_clsd_cn"));
			params.put("objtnStatCd", "01");
			params.put("objtnRgDiv", "0");
			
			// 이의신청 내용 DB 입력
			portalExposeInfoDao.insertObjection(params);
			portalExposeInfoDao.objectionHist(params);
			msg = "이의신청이 등록되었습니다.";
			//기관 정보공개 담당자에게 SMS발송
			objectionRegSendSMS(request, params);
		
			//이의신청의 취지 및 이유를 확인하여 저장한다.
			String[] clsdNo = params.getStringArray("clsd_no");
			String[] objtnRson = params.getStringArray("objtn_rson");
			
			if(clsdNo.length > 0){
	        					
				for(int i=0; i<clsdNo.length; i++){
					if(objtnRson[i] != null && !"".equals(objtnRson[i])){
						params.put("clsdNo", clsdNo[i]);
						params.put("objtnRson", objtnRson[i]);

						portalExposeInfoDao.updateOpnDcsClsd(params);
					}
				}
			}
			
		} catch (DataAccessException e) {
			error("Exception : " , e);
			EgovWebUtil.exTransactionLogging(e);
			throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
		} catch (Exception e) {
			error("Exception : " , e);
			EgovWebUtil.exTransactionLogging(e);
			throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
		}
		
		return success(msg);
	}	

    /**
     * 정보공개 이의신청서작성 데이터를 수정한다.
     * 
     * @param params 파라메터
     * @return 등록결과
     */
	@Override
	public Object updateObjection(HttpServletRequest request, Params params) {
		final MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;

		String msg = "";

		try {
			
			if ( StringUtils.isEmpty(params.getString("aplNo")) ) {
				throw new ServiceException("청구서 번호가 없습니다.");
			}
			
			// 작성된 이의신청서 변경시 본인여부와 현재상태 체크(수정시 파라미터 변조 방지)
			String status = portalExposeInfoDao.selectOpnzUsrObjChkStatus(params);
			if ( StringUtils.equals("X", status) ) {
				throw new ServiceException("본인의 이의신청서만 수정 할 수 있습니다."); 
			}
			else if ( !StringUtils.equals("01", status) ) {
				throw new ServiceException("신청중인 이의신청서만 수정 할 수 있습니다.");
			}
			
			//저장 디렉토리
			String directoryPath = EgovProperties.getProperty("Globals.OpnzAplFilePath");
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
					String srcFileNm = file.getOriginalFilename(); 				//원본 파일명
					String fileExt = FilenameUtils.getExtension(srcFileNm);		//파일 확장자
					String filePhNm = (new Date()).getTime() + "." + fileExt;   //저장파일명
					
					params.set("objtnAplFlnm", srcFileNm);	//첨부파일명
					params.set("objtnAplFlph", filePhNm);	//저장파일명명
					params.set(saveKey, filePhNm);
					
					if(filePhNm != null && !"".equals(filePhNm)){
						@SuppressWarnings("resource")
						FileOutputStream fos = null;
						try {
							fos = new FileOutputStream(EgovWebUtil.filePathBlackList(directoryPath + File.separator + filePhNm));
							InputStream stream = file.getInputStream();
							int bytesRead = 0;
							byte[] buffer = new byte[BUFF_SIZE];
							
							while ((bytesRead = stream.read(buffer, 0, BUFF_SIZE)) != -1) {
								fos.write(buffer, 0, bytesRead);
							}
						} catch(IOException ioe) {
							EgovWebUtil.exLogging(ioe);
						} catch(Exception e) {
							EgovWebUtil.exLogging(e);
						} finally {
							try {
				        		if ( fos != null ) {
				        			fos.close();
				        		}
				        	} catch (DataAccessException e) {
				    			EgovWebUtil.exLogging(e);
				    		} catch (Exception e) {
				    			EgovWebUtil.exLogging(e);
				    		}
						}
					}
				}else {
					// 파일이 없는 경우 DB값 null 처리
					params.set(saveKey, "");
				}
				
			}			
			
			params.put("objtnRson", " ");
			
			if(params.getString("objtn_attch_delete").equals("Y")){
					params.put("objtnAplFlnm", "");
					params.put("objtnAplFlph", "");
					portalExposeInfoDao.deleteObjectionFiles(params);
					portalExposeInfoDao.updateObjection(params);
			}else{
				portalExposeInfoDao.updateObjection(params);
			}
			
			//이의신청의 취지 및 이유를 확인하여 수정한다.
			//수정 전 기존 내용은 지운다.
			portalExposeInfoDao.deleteOpnDcsClsd(params);
			
			String[] clsdNo = params.getStringArray("clsd_no");
			String[] objtnRson = params.getStringArray("objtn_rson");
			
			if(clsdNo.length > 0){
	        					
				for(int i=0; i<clsdNo.length; i++){
					if(objtnRson[i] != null && !"".equals(objtnRson[i])){
						params.put("clsdNo", clsdNo[i]);
						params.put("objtnRson", objtnRson[i]);

						portalExposeInfoDao.updateOpnDcsClsd(params);
					}
				}
			}
			
			msg = "이의신청이 수정되었습니다.";
			
		} catch (ServiceException sve){
			EgovWebUtil.exLogging(sve);
			throw new ServiceException(sve.getMessage());
		} catch (DataAccessException e) {
			error("Exception : " , e);
			EgovWebUtil.exTransactionLogging(e);
			throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
		} catch (Exception e) {
			error("Exception : " , e);
			EgovWebUtil.exTransactionLogging(e);
			throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
		}
		
		return success(msg);
	}	
	
    /**
	 * 정보공개 이의신청서 작성 내용을 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
	public Map<String, Object> getWriteBaseInfo(Params params) {
		return (Map<String, Object>) portalExposeInfoDao.getWriteBaseInfo(params);
	}

    /**
	 * 정보공개 이의신청서 수정 내용을 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
	public Map<String, Object> getUpdateBaseInfo(Params params) {
		return (Map<String, Object>) portalExposeInfoDao.getUpdateBaseInfo(params);
	}
	
    /**
     * 정보공개 이의신청서 처리현황을 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public Paging searchObjection(Params params) {
    	params.put("aplDtFrom", ((String) params.get("aplDtFrom")).replaceAll("-", ""));
    	params.put("aplDtTo", ((String) params.get("aplDtTo")).replaceAll("-", ""));
    	
        return portalExposeInfoDao.searchObjection(params, params.getPage(), params.getRows());
    }    
    
    /**
     * 정보공개 이의신청서를 이의취하한다.
     * 
     * @param params 파라메터
     * @return 등록결과
     */
	@Override
	public Object withdrawObjection(HttpServletRequest request, Params params) {
		final MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;

		String msg = "";
		
		try {
			
			params.put("apl_no", params.get("aplNo"));
			params.put("histDiv", "29");									// Hist 구분
			params.put("histCn", "청구자의 원에 의한 청구취하");			// Hist 내용 
			params.put("usrId", "");
			params.put("objtnDealRslt", "99");
			portalExposeInfoDao.withdrawObjection(params);
			portalExposeInfoDao.objectionHist(params);
			msg = "이의신청이 취하되었습니다.";
			//기관 정보공개 담당자에게 SMS 발송
			objectionWithdrawSendSMS(request, params);
			
		} catch (DataAccessException e) {
			error("Exception : " , e);
			EgovWebUtil.exTransactionLogging(e);
			throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
		} catch (Exception e) {
			error("Exception : " , e);
			EgovWebUtil.exTransactionLogging(e);
			throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
		}
		
		
		return success(msg);
	}	


	
	/**
	 * 정보공개 이의신청서 작성 내용을 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
	public Map<String, Object> getOpnObjtnDetail(Params params) {
		return (Map<String, Object>) portalExposeInfoDao.getOpnObjtnDetail(params);
	}

	/**
	 * 정보공개 이의신청서 처리 이력을 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
	public List<?> getObjtnHist(Params params){
		return portalExposeInfoDao.getObjtnHist(params);
	}
	
	/**
	 * 청구인이 정보공개 청구시 -  기관 정보공개 담당자에게 SMS 발송한다.
     * 
     * @param params 파라메터
     * @return 처리결과
     */
	@SuppressWarnings({ "unchecked", "deprecation" })	
	public boolean accountRegSendSMS(HttpServletRequest request, Params params) {
		
		/* 선택 청구기관 코드 */
		String inst_cd = params.getString("apl_instcd");
		params.put("inst_cd", inst_cd);
		
		/* 청구인 */
		String apl_pn = params.getString("aplPn");
		
		/* 청구제목 */
		String modsj =  params.getString("apl_sj_bfmod");
		
		/* 청구일 */
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date(System.currentTimeMillis()));
		String apl_dt = new SimpleDateFormat("yyyyMMdd").format(cal.getTime());
		
		apl_dt = apl_dt.substring(0, 4)+"년"+apl_dt.substring(4, 6)+"월"+apl_dt.substring(6, 8)+"일 ";
		
		/*************************************************************
		 * 청구인이 정보공개 청구시 -  기관 정보공개 담당자에게 SMS 발송
		 *************************************************************/
		
		//SMS발송시 필요정보
		//보내는 전화번호 > 기관 대표연락처
		//받는 전화번호 > 청구기관 담당자 연락처
		
		//기관 정보 조회
		List<Record> opnzInstList = (List<Record>) portalExposeInfoDao.getOpnzInstInfo(inst_cd);
		
		//기관 담당자 정보 조회
		List<Record> opnUsrRelList = (List<Record>) portalExposeInfoDao.getOpnUsrRelInfo(inst_cd);
		if(opnUsrRelList.size() > 0){
			String send_phone = opnzInstList.get(0).getString("INST_PNO"); // SMS 발송 번호
			String dest_phone = opnUsrRelList.get(0).getString("USR_MBL_PNO"); // SMS 수신 번호
			
			params.put("notiHHCd", opnUsrRelList.get(0).getString("NOTI_HH_CD"));
			params.put("notiStartHH", opnUsrRelList.get(0).getString("NOTI_START_HH"));
			params.put("notiEndHH", opnUsrRelList.get(0).getString("NOTI_END_HH"));
			
			String sendTime = getSendTime(params);
			
			params.put("sendTime", sendTime);
			
			//params.put("send_phone", send_phone);
//			params.put("send_phone", EgovProperties.getProperty("KakaoBizTalk.sendPhone"));
			params.put("send_phone", opnUsrRelList.get(0).getString("USR_PNO"));	// 기관별 대표자번호로 변경
			params.put("dest_phone", dest_phone);
			params.put("msgType", "5"); // 메시지 내용 msgType 이 "5" 일경우 MMS 발송
			params.put("subject", "정보공개안내 SMS");
			params.put("dest_name", apl_pn);
			params.put("send_name", "국회사무처");
			String apl_title = "'"+modsj+"'건으로";
			String msg1 = apl_pn + "님이 " + apl_dt + apl_title;
			String msg2 = " 정보공개를 청구하였습니다.";
			params.put("msg_body", msg1.trim()+msg2);
			
					
			try{
					
				// 테스트시 담당자에게 문자 안날라가게 
				if(request.getRequestURL().substring(0,16).equals("http://localhost")){							
					params.put("dest_phone", "01052671720"); // SMS ,
					params.put("send_phone", "01052671720"); // SMS 발송번호
				}
				
				portalExposeInfoDao.insertSMSRow(params);
			 
			}catch (DataAccessException dae) { 
				EgovWebUtil.exTransactionLogging(dae);
			}catch (Exception e) {
				EgovWebUtil.exTransactionLogging(e);
			}
		}
		return true;
	}
	
	
	/**
	 * 청구인이 청구취하시 - 기관 정보공개 담당자에게 SMS 발송한다.
     * 
     * @param params 파라메터
     * @return 처리결과
     */
	@SuppressWarnings("unchecked")
	public boolean accountWithdrawSendSMS(HttpServletRequest request, Params params) {
		
		/*************************************************************
		 * 기관 담당자에게 SMS 발송 
		 *************************************************************/
		/* 청구기관코드  */
		String inst_cd = (String) params.get("apl_deal_instcd");
		params.put("inst_cd", inst_cd);	

		//기관 정보 조회
		List<Record> opnzInstList = (List<Record>) portalExposeInfoDao.getOpnzInstInfo(inst_cd);
		
		//기관 담당자 정보 조회
		List<Record> opnUsrRelList = (List<Record>) portalExposeInfoDao.getOpnUsrRelInfo(inst_cd);
		if(opnUsrRelList.size() > 0){
			String send_phone = opnzInstList.get(0).getString("INST_PNO"); // SMS 발송 번호
			String dest_phone = opnUsrRelList.get(0).getString("USR_MBL_PNO"); // SMS 수신 번호
			
			params.put("notiHHCd", opnUsrRelList.get(0).getString("NOTI_HH_CD"));
			params.put("notiStartHH", opnUsrRelList.get(0).getString("NOTI_START_HH"));
			params.put("notiEndHH", opnUsrRelList.get(0).getString("NOTI_END_HH"));
			
			String sendTime = getSendTime(params);
			
			params.put("sendTime", sendTime);
			
			/* 청구인 */
			String apl_pn = (String)params.get("apl_pn");
			
			/* 청구일자 */
			String apl_dt = (String)params.get("apl_dt");
			apl_dt = apl_dt.substring(0, 4)+"년"+apl_dt.substring(4, 6)+"월"+apl_dt.substring(6, 8)+"일 ";
	
			/* 청구제목, 메세지 내용 */
			String modsj = portalExposeInfoDao.getAplModSJ((String) params.get("apl_no"));
			String apl_title = "'"+modsj+"'건으로";
			String msg1 = apl_pn + "님이 " + apl_dt + apl_title;
			String msg2 = " 신청한 정보공개청구서가 취하되었습니다.";
			params.put("msg_body", msg1.trim()+ msg2);
	
			//params.put("send_phone", send_phone);
//			params.put("send_phone", EgovProperties.getProperty("KakaoBizTalk.sendPhone"));
			params.put("send_phone", opnUsrRelList.get(0).getString("USR_PNO"));	// 기관별 대표자번호로 변경
			params.put("dest_phone", dest_phone);
			params.put("msgType", "5"); // 메시지 내용 msgType 이 "5" 일경우 MMS 발송
			params.put("subject", "정보공개안내 SMS");
			params.put("dest_name", apl_pn);
			params.put("send_name", "국회사무처");
			
			try{
				
				// 테스트시 담당자에게 문자 안날라가게 
				if(request.getRequestURL().substring(0,16).equals("http://localhost")){							
					params.put("dest_phone", "01052671720"); // SMS ,
					params.put("send_phone", "01052671720"); // SMS 발송번호
				}
				
				portalExposeInfoDao.insertSMSRow(params);
					
			}catch (DataAccessException dae) { 
				EgovWebUtil.exTransactionLogging(dae);
			}catch (Exception e) {
				EgovWebUtil.exTransactionLogging(e);
			}
		}
		return true;
	}

	/**
	 * 청구인이 이의신청 작성시 -  기관 정보공개 담당자에게 SMS 발송한다.
     * 
     * @param params 파라메터
     * @return 처리결과
     */
	public boolean objectionRegSendSMS(HttpServletRequest request, Params params) {
		
		/*************************************************************
		 * SMS
		 *************************************************************/
	
		/* 처리기관 코드*/ 
		String inst_cd = params.getString("apl_instcd");
		params.put("inst_cd", inst_cd);

		//기관 정보 조회
		List<Record> opnzInstList = (List<Record>) portalExposeInfoDao.getOpnzInstInfo(inst_cd);
		
		//기관 담당자 정보 조회
		List<Record> opnUsrRelList = (List<Record>) portalExposeInfoDao.getOpnUsrRelInfo(inst_cd);
		if(opnUsrRelList.size() > 0){
			String send_phone = opnzInstList.get(0).getString("INST_PNO"); // SMS 발송 번호
			String dest_phone = opnUsrRelList.get(0).getString("USR_MBL_PNO"); // SMS 수신 번호
			
			params.put("notiHHCd", opnUsrRelList.get(0).getString("NOTI_HH_CD"));
			params.put("notiStartHH", opnUsrRelList.get(0).getString("NOTI_START_HH"));
			params.put("notiEndHH", opnUsrRelList.get(0).getString("NOTI_END_HH"));
			
			String sendTime = getSendTime(params);
			
			params.put("sendTime", sendTime);
			
			/* 청구인 */
			String apl_pn = (String)params.get("aplPn");
			
			/* 이의신청일  */
			Calendar cal = Calendar.getInstance();
			cal.setTime(new Date(System.currentTimeMillis()));
			String apl_dt = new SimpleDateFormat("yyyyMMdd").format(cal.getTime());
			apl_dt = apl_dt.substring(0, 4)+"년"+apl_dt.substring(4, 6)+"월"+apl_dt.substring(6, 8)+"일 ";
			
			/* 메세지 내용 */
			String modsj = portalExposeInfoDao.getAplModSJ((String) params.get("apl_no"));
			String apl_title = "'"+modsj+"'건에 대하여";
			String msg1 = apl_pn + "님이 " + apl_dt + apl_title;
			String msg2 = " 이의신청 하였습니다.";
			params.put("msg_body", msg1.trim()+ msg2);
			
			//params.put("send_phone", send_phone);
//			params.put("send_phone", EgovProperties.getProperty("KakaoBizTalk.sendPhone"));
			params.put("send_phone", opnUsrRelList.get(0).getString("USR_PNO"));	// 기관별 대표자번호로 변경
			params.put("dest_phone", dest_phone);
			params.put("msgType", "5"); // 메시지 내용 msgType 이 "5" 일경우 MMS 발송
			params.put("subject", "정보공개안내 SMS");
			params.put("dest_name", apl_pn);
			params.put("send_name", "국회사무처");
			
			try{
				
				// 테스트시 담당자에게 문자 안날라가게 
				if(request.getRequestURL().substring(0,16).equals("http://localhost")){							
					params.put("dest_phone", "01052671720"); // SMS ,
					params.put("send_phone", "01052671720"); // SMS 발송번호
				}
				
				portalExposeInfoDao.insertSMSRow(params);
					
			}catch (DataAccessException dae) { 
				EgovWebUtil.exTransactionLogging(dae);
			}catch (Exception e) {
				EgovWebUtil.exTransactionLogging(e);
			}
		}
		return true;
	}
	
	/**
	 * 청구인이 이의신청 이의취하시 -  기관 정보공개 담당자에게 SMS 발송한다.
     * 
     * @param params 파라메터
     * @return 처리결과
     */
	public boolean objectionWithdrawSendSMS(HttpServletRequest request, Params params) {
		
		/*************************************************************
		 * SMS, E-mail 발송 
		 *************************************************************/
		
		/* 처리기관 코드*/ 
		String inst_cd = params.getString("aplDealInstcd");
		
		//기관 정보 조회
		List<Record> opnzInstList = (List<Record>) portalExposeInfoDao.getOpnzInstInfo(inst_cd);
		
		//기관 담당자 정보 조회
		List<Record> opnUsrRelList = (List<Record>) portalExposeInfoDao.getOpnUsrRelInfo(inst_cd);
		if(opnUsrRelList.size() > 0){
			String send_phone = opnzInstList.get(0).getString("INST_PNO"); // SMS 발송 번호
			String dest_phone = opnUsrRelList.get(0).getString("USR_MBL_PNO"); // SMS 수신 번호
			
			params.put("notiHHCd", opnUsrRelList.get(0).getString("NOTI_HH_CD"));
			params.put("notiStartHH", opnUsrRelList.get(0).getString("NOTI_START_HH"));
			params.put("notiEndHH", opnUsrRelList.get(0).getString("NOTI_END_HH"));
			
			String sendTime = getSendTime(params);
			
			params.put("sendTime", sendTime);
			
			/* 청구인 */
			String apl_pn = (String)params.get("aplPn");
			
			/* 이의신청일 조회  */
			String apl_dt = (String)params.get("apl_dt");
			apl_dt = apl_dt.substring(0, 4)+"년"+apl_dt.substring(4, 6)+"월"+apl_dt.substring(6, 8)+"일 ";
			
			/* 메세지 내용 */
			String modsj = portalExposeInfoDao.getAplModSJ((String) params.get("apl_no"));
			String apl_title = "'"+modsj+"'건으로";
			String msg1 = apl_pn + "님이 " + apl_dt + apl_title;
			String msg2 = " 신청한 이의신청서가 취하되었습니다.";
			params.put("msg_body", msg1.trim()+ msg2);
	
			//params.put("send_phone", send_phone);
//			params.put("send_phone", EgovProperties.getProperty("KakaoBizTalk.sendPhone"));
			params.put("send_phone", opnUsrRelList.get(0).getString("USR_PNO"));	// 기관별 대표자번호로 변경
			params.put("dest_phone", dest_phone);
			params.put("msgType", "5"); // 메시지 내용 msgType 이 "5" 일경우 MMS 발송
			params.put("subject", "정보공개안내 SMS");
			params.put("dest_name", apl_pn);
			params.put("send_name", "국회사무처");
			
			try{
				
				// 테스트시 담당자에게 문자 안날라가게 
				if(request.getRequestURL().substring(0,16).equals("http://localhost")){							
					params.put("dest_phone", "01052671720"); // SMS ,
					params.put("send_phone", "01052671720"); // SMS 발송번호
				}
				
				portalExposeInfoDao.insertSMSRow(params);
					
			}catch (DataAccessException dae) { 
				EgovWebUtil.exTransactionLogging(dae);
			}catch (Exception e) { 
				EgovWebUtil.exTransactionLogging(e);
			}
		}
		return true;
	}
	
	
	/**
	 * 첨부파일 다운로드
	 */
	@Override
	public Record downloadOpnAplFile(Params params) {
		Record file = new Record();
		
        file.put(FileDownloadView.FILE_NAME, params.get("fileName"));
        file.put(FileDownloadView.FILE_PATH, getMtiFilePath(params));
        try {
			file.put(FileDownloadView.FILE_SIZE, getFileSize(file));
		} catch (FileNotFoundException e) {
			EgovWebUtil.exLogging(e);
		} catch (IOException e) {
			EgovWebUtil.exLogging(e);
		}
        return file;
	}
	
	/**
     * 파일 크기를 반환한다.
     * 
     * @param file 파일
     * @return 파일 크기
     * @throws IOException 
     * @throws FileNotFoundException 
     */
    private int getFileSize(Record file) throws FileNotFoundException, IOException {
    	FileInputStream fis = null;
    	byte[] bytes = null;
    	
    	try {
    		fis = new FileInputStream(file.getString("filePath"));
    		
    		bytes = IOUtils.toByteArray(fis);
    		
    	} catch(FileNotFoundException fe) {
    		EgovWebUtil.exLogging(fe);
    	} catch(Exception e) {
    		EgovWebUtil.exLogging(e);
    	} finally {
    		try {
        		if ( fis != null ) {
        			fis.close();
        		}
        	} catch (DataAccessException e) {
    			EgovWebUtil.exLogging(e);
    		} catch (Exception e) {
    			EgovWebUtil.exLogging(e);
    		}
    	}
    	
    	return bytes.length;
    }
    
    /**
   	 * 파일경로 가져오기
   	 * @param file
   	 * @return
   	 */
   	private String getMtiFilePath(Params params) {
       StringBuffer buffer = new StringBuffer();
       
       buffer.append(EgovProperties.getProperty("Globals.OpnzAplFilePath"));
       buffer.append(File.separator);
       buffer.append(EgovWebUtil.filePathReplaceAll(params.getString("filePath")));
       
       return buffer.toString();
   }

	/**
	 * 양식파일 다운로드
	 */
	@Override
	public Record downloadBasicFile(Params params) {
		Record file = new Record();
		
        file.put(FileDownloadView.FILE_NAME, params.get("fileName"));
        file.put(FileDownloadView.FILE_PATH, getBasicFilePath(params));
        try {
			file.put(FileDownloadView.FILE_SIZE, getFileSize(file));
		} catch (FileNotFoundException e) {
			EgovWebUtil.exLogging(e);
		} catch (IOException e) {
			EgovWebUtil.exLogging(e);
		}
        return file;
	}
	
    /**
   	 * 양식파일경로 가져오기
   	 * @param file
   	 * @return
   	 */
   	private String getBasicFilePath(Params params) {
       StringBuffer buffer = new StringBuffer();
       
       buffer.append(EgovProperties.getProperty("Globals.BasicFilePath"));
       buffer.append(File.separator);
       buffer.append(EgovWebUtil.filePathReplaceAll(params.getString("filePath")));
       
       return buffer.toString();
   }
   	
    /**
   	 * SMS 발송일을 확인한다. 
   	 * 주말/휴일, 공휴일 제외하며, 설정 수신시간을 확인한다.
   	 * @param file
   	 * @return
   	 */
   	private String getSendTime(Params params) {
   		String sendTime = "";
       
   		Calendar cal = Calendar.getInstance();
		
		//시스템 현재 시간
		String nowHH =  new SimpleDateFormat("HH").format(cal.getTime());
		String nowDay = new SimpleDateFormat("yyyyMMdd").format(cal.getTime());
		//String nowDay = "20190912";
		
		//기관 담당자가 설정한 수신시간을 확인한다.
		String notiStartHH = params.getString("notiStartHH");
		String notiEndHH = params.getString("notiEndHH");
		
		String chkDay = "";
		String setTime =  "";
		

		if(Integer.parseInt(notiStartHH) > Integer.parseInt(nowHH)){	//현재시간이 설정시간보다 작으면, 날짜는 오늘날짜로 설정하여 확인한다. 
			chkDay = nowDay;
			setTime = notiStartHH;
		}else if(Integer.parseInt(notiEndHH) < Integer.parseInt(nowHH)){ //현재시간이 설정시간보다 크다면, 날짜는 내일날짜로 설정하여 확인한다.
			chkDay = getNextDay(nowDay);
			setTime = notiStartHH;
		}else{
			chkDay = nowDay;
			setTime = "NOW";
		}

		int cnt = 0; //설정날짜가 휴무일 또는 공휴일을 포함할 경우 새로운 날짜를 뽑아낸다.
		while(cnt <10){ //10일 이상 쉬는 날이 없으므로 10번정도 돌려 확인한다.

			//설정된 날짜를 확인한다. (휴무일/공휴일)
			//int isType = HolidayUtil.getHolidayType(chkDay);
			int isType = 1;
			if(isType == 1){
				break;
			}else{
				chkDay = getNextDay(chkDay);
				if(setTime.equals("NOW")) setTime = notiStartHH;
			}
		}
		
		if(!setTime.equals("NOW")) sendTime = chkDay.substring(0, 4)+"-"+chkDay.substring(4, 6)+"-"+chkDay.substring(6, 8)+" "+setTime+":00:00";
       
		return sendTime;
   }
   	
    /**
   	 * 넘어온 값의 다음날짜를 리턴한다.
   	 * @return
   	 */
   	private String getNextDay(String chkDay) {
       
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		Date next_dt = null;
		try {
			next_dt = formatter.parse(chkDay);
		}catch (DataAccessException dae) { 
			EgovWebUtil.exLogging(dae);
		}catch (Exception e) { 
			EgovWebUtil.exLogging(e);
		}
		next_dt = new Date(next_dt.getTime() + (1000*60*60*24*+1));  
		String nextDay = new SimpleDateFormat("yyyyMMdd").format(next_dt);
		
		return nextDay;
   }
   	
   	/**
   	 * 청구 기본정보(사용자정보) 입력
   	 */
   	@Override
	public Result updateExposeDefaultInfo(Params params) {
   		
   		try {
   			
   			if ( StringUtils.isNotEmpty( params.getString("dcs_ntc_rcvmth_sms")) ){
   				params.set("dcsNtcRcvMthSms", params.getString("dcs_ntc_rcvmth_sms"));		//결정통지수신방법코드(SMS)
   			}
   			
   			if ( StringUtils.isNotEmpty( params.getString("dcs_ntc_rcvmth_talk")) ){
   				params.set("dcsNtcRcvMthTalk", params.getString("dcs_ntc_rcvmth_talk"));		//결정통지수신방법코드(카카오알림톡)
   			}
   			
   			if ( StringUtils.equals(params.getString("dcsNtcRcvMthSms"), params.getString("dcsNtcRcvMthTalk")) ) {
   				throw new ServiceException("SMS와 카카오알림톡은 동시에 선택할 수 없습니다.");
   			}
   			
   			HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
	        HttpSession session = req.getSession();
	        
	        // 주민번호가 없을경우 기본정보 저장시 세션값 넣어준다.
	        Map<String, Object> opnLoginUsr = portalExposeInfoDao.selectLoginUserInfo(params);
	        if ( !opnLoginUsr.isEmpty() 
					&& StringUtils.isEmpty((String)opnLoginUsr.get("rauthDi")) ) {
				
				params.set("rauthBirth", (String) session.getAttribute("loginRno1")); //생년월일
				params.set("rauthDi", (String) session.getAttribute("dupInfo"));      // 본인인증중복가입확인정보
				params.set("rauthTag", (String) session.getAttribute("rauthTag"));    //본인인증구분
				params.set("rauthNi", (String) session.getAttribute("loginDiv"));     //본인인증내외국인구분
				
			}
   			
   			portalExposeInfoDao.updateExposeDefaultInfo(params);
   			
		}catch (DataAccessException dae) { 
			EgovWebUtil.exLogging(dae);
		}catch (Exception e) { 
			EgovWebUtil.exLogging(e);
		}
		
		return success(getMessage("portal.message.000004"));
	}
   	
   	/**
	 * 로그인 사용자정보를 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
	public Map<String, Object> selectLoginUserInfo(Params params) {
		return (Map<String, Object>) portalExposeInfoDao.selectLoginUserInfo(params);
	}

	/**
	 * 이의신청 대상 항목을 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
	public List<?> selectOpnDcsClsd(Params params){
		return portalExposeInfoDao.selectOpnDcsClsd(params);
	}

	/**
	 * 이의신청 대상 선택 항목을 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
	public List<?> selectOpnDcsChkClsd(Params params){
		return portalExposeInfoDao.selectOpnDcsChkClsd(params);
	}

    /**
     * 정보공개 처리상태를 조회한다.
     * 
     * @param params 파라메터
     * @return 처리상태
     */
	@Override
	public String getPrgStatCd(String apl_no) {
		return portalExposeInfoDao.getPrgStatCd(apl_no);
	}	
	
	/**
   	 * 청구 본인 인증정보 업데이트
   	 */
   	@Override
	public Result updateUserRauth(Params params) {
   		
   		try {
   			
   			HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
	        HttpSession session = req.getSession();
	        
	        // DI값이 없을경우 세션값을  넣어준다.
	        Map<String, Object> opnLoginUsr = portalExposeInfoDao.selectLoginUserInfo(params);
	        
	        
	        if ( !opnLoginUsr.isEmpty() && StringUtils.isEmpty((String)opnLoginUsr.get("rauthDi")) ) {
				
				params.set("rauthBirth", (String) session.getAttribute("loginRno1")); //생년월일
				params.set("rauthDi", (String) session.getAttribute("dupInfo"));      // 본인인증중복가입확인정보
				params.set("rauthTag", (String) session.getAttribute("rauthTag"));    //본인인증구분
				params.set("rauthNi", (String) session.getAttribute("loginDiv"));     //본인인증내외국인구분
				
			}
   			
   			portalExposeInfoDao.updateUserRauth(params);
   			
		}catch (DataAccessException dae) { 
			EgovWebUtil.exLogging(dae);
		}catch (Exception e) { 
			EgovWebUtil.exLogging(e);
		}
		
		return success(getMessage("portal.message.000004"));
	}
}
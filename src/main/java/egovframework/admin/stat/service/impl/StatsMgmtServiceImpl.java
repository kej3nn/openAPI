package egovframework.admin.stat.service.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.basicinf.service.CommUsr;
import egovframework.admin.openinf.service.OpenInf;
import egovframework.admin.stat.service.StatsMgmtService;
import egovframework.admin.stat.service.StatsStddTblItm;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.common.base.constants.GlobalConstants;
import egovframework.common.base.constants.ModelAttribute;
import egovframework.common.base.exception.DBCustomException;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.exception.SystemException;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;
import egovframework.common.base.service.BaseService;
import egovframework.common.util.UtilString;

/**
 * 통계표를 관리하는 서비스 클래스
 * @author	김정호
 * @version 1.0
 * @since   2017/05/25
 */

@Service(value="statsMgmtService")
public class StatsMgmtServiceImpl extends BaseService implements StatsMgmtService {
	
	/**
	 * 통계표 태그 값
	 */
	protected static final String TBL_STATBL_TAG = "T";
	
	/**
     * 배치 카운트
     */
    private static final int BATCH_COUNT = 10000;
    /**
     * 최대 파일 크기
     */
    private static final long MAX_FILE_SIZE = 1024 * 1024 * 20;

	@Resource(name="statsMgmtDao")
	protected StatsMgmtDao statsMgmtDao;
	
	@Resource(name="statInputDao")
	protected StatInputDao statInputDao;
	
	//공통코드 값을 조회한다.
	@Override
	public List<Record> selectOption(Params params) {
		return (List<Record>)statsMgmtDao.selectOption(params);
	}
	//정보카탈로그 시스템 코드 값을 조회한다.
	@Override
	public List<Record> selectSysOption(Params params) {
		return (List<Record>)statsMgmtDao.selectSysOption(params);
	}

	//통계 공통코드 값을 조회한다.
	@Override
	public List<Record> selectSTTSOption(Params params) {
		return (List<Record>)statsMgmtDao.selectSTTSOption(params);
	}
	
	//통계메타명 팝업 데이터 리스트 조회	
	@Override
	public List<Map<String, Object>> selectStatMetaPopup(Params params) {
		return statsMgmtDao.selectStatsMetaPopList(params);
	}
	
	//분류체계 팝업 데이터 리스트 조회
	@Override
	public List<Map<String, Object>> selectStatCatePopup(Params params) {
		return statsMgmtDao.selectStatsCatePopList(params);
	}
	
	/**
	 * 통계표 관리 메인 리스트 조회
	 */
	@Override
	public List<Record> statsMgmtListPaging(Params params) {
		String statblId = "";		//통계표ID
		String statblNm = "";		//통계표명
		String statExpHtml = "";	//통계설명 HTML
		String statTblHtml = "";	//통계표팝업 HTML
		
		//조회시 시스템 체크 여부
		if ( !StringUtils.isEmpty(params.getString("korYn")) || !StringUtils.isEmpty(params.getString("engYn")) 
				|| !StringUtils.isEmpty(params.getString("korMobileYn")) || !StringUtils.isEmpty(params.getString("engMobileYn")) ) {
			params.set("systemExist", "Y");
		}
		
		//조회시 작성주기 체크 여부
		if ( !StringUtils.isEmpty(params.getString("YYdtacycleYn")) || !StringUtils.isEmpty(params.getString("HYdtacycleYn")) 
				|| !StringUtils.isEmpty(params.getString("QYdtacycleYn")) || !StringUtils.isEmpty(params.getString("MMdtacycleYn")) ) {
			params.set("dtacycleExist", "Y");
		}
		
		if(EgovUserDetailsHelper.isAuthenticated()) {
			CommUsr loginVO = null;
    		EgovUserDetailsHelper.getAuthenticatedUser();
    		loginVO = (CommUsr)EgovUserDetailsHelper.getAuthenticatedUser();
    		params.put("accCd", loginVO.getAccCd());	//로그인 된 유저 권환 획득
        }
		
		// 분류체계 여러개 검색(IN 절)
		if ( StringUtils.isNotEmpty(params.getString("cateIds")) ) {
			ArrayList<String> iterCateId = new ArrayList<String>(Arrays.asList(params.getString("cateIds").split(",")));
			params.set("iterCateId", iterCateId);
		}
		
		List<Record> list = (List<Record>) statsMgmtDao.statsMgmtList(params);
		
		//조회된 리스트에 통계설명 팝업 아이콘 끼워 넣는다.(클릭시 통계설명 팝업창)
		/*
		for ( Record r : list ) {
			if ( "T".equals(r.getString("statblTag")) ) {
				statblId = r.getString("statblId");
				statblNm = r.getString("statblNm");
				ctsSrvCd = r.getString("ctsSrvCd");
				statExpHtml = " <a href=\"/admin/stat/popup/statMetaExpPopup.do?statblId="+statblId+"\" target=\"_blank\" title=\"통계설명(팝업)\">" + StatSttsStatServiceImpl.STAT_EXP_POP_ICON + "</a>";
				statTblHtml = "";
				if ( StringUtils.equals(ctsSrvCd, "N") ) {
					statTblHtml = "<a href=\"/admin/stat/statPreviewPage/"+statblId+".do\" target=\"_blank\" title=\"통계표(팝업)\">" + StatSttsStatServiceImpl.STAT_TBL_POP_ICON + "</a>";
				}
				r.put("statblNm", statblNm + statExpHtml + statTblHtml);
			}
		}*/
	
		return list;
	}
	
	/**
	 * 통계표 관리 상세 조회
	 */
	@Override
	public Map<String, Object> selectStatsMgmtDtl(Map<String, String> paramMap) {
		Map<String, Object> rMap = new HashMap<String, Object>();
		Map<String, Object> dataMap = new HashMap<String, Object>();
		
		dataMap.put("OPT_DATA", (List<Map<String, Object>>) statsMgmtDao.selectStatsMgmtDtlOpt(paramMap));		//통계표 옵션정보 조회
		dataMap.put("SCHL_DATA", (List<Map<String, Object>>) statsMgmtDao.selectStatsMgmtDtlSchl(paramMap));	//통계자료 작성일정 조회
		
		rMap.put("DATA", statsMgmtDao.selectStatsMgmtDtl(paramMap));
		rMap.put("DATA2", dataMap);
		return rMap;
	}

	/**
	 * 통계표 입력/수정
	 */
	@Override
	public Result saveStatsMgmt(Params params) {
		try {
			/* 통계표 정보 저장 */
			saveStatsTbl(params);
			
			/* 통계표 분류체계 저장 */
			//saveStatTblCate(params);
			
			/* 통계표 키워드 저장 */
			saveStatsTag(params);
			
			/* 통계표 옵션 정보 저장 */
			saveStatsOpt(params);
			
			/* 통계표 자료작성 일정 저장 */
			saveStatsSchl(params);
			
			/* 통계표 분류정보 저장 */
			saveStatsCateInfo(params);

			/* 통계표 담당자 저장 */
			saveStatsUsr(params);
			
			/* 연관통계표 저장 */
			saveStatsTblRel(params);
			
			/* 통계표 정보 백업 */
			statsMgmtDao.execSpBcupSttsTbl(params);
			
			/* 통계자료작성대장 생성 */ 
			statsMgmtDao.execSpCreateSttsWrtlist(params);
			
			
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
			//procedure 리턴 메세지 표시.
			SQLException se = (SQLException) ((DataAccessException) dae).getRootCause();
			throw new DBCustomException(getDbmsExceptionMsg(se));
		} catch(Exception e) {
			error("Exception : " , e);
			EgovWebUtil.exTransactionLogging(e);
			throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
		}
		
	}
	
	/**
	 * 통계표 정보 저장
	 * @param params
	 */
	public void saveStatsTbl(Params params) {
		try{
			int updCnt = 0;
			String strActionStatus = params.getString(ModelAttribute.ACTION_STATUS);
			log.warn("strActionStatus="+strActionStatus);
			
			// 여러개중 첫번째 CateId를 넣어준다.
			JSONArray jsonArray = new JSONObject(params.getJsonObject("ibsSaveJson3")).getJSONArray("data");
			JSONObject jObj = (JSONObject) jsonArray.get(0);
			params.set("cateId", jObj.getString("cateId"));
				
			if ( ModelAttribute.ACTION_INS.equals(strActionStatus) ) {
				statsMgmtDao.insertStatsTbl(params);
			} 
			else if ( ModelAttribute.ACTION_UPD.equals(strActionStatus) ) {
				
				//params.set("cateId", params.getString("cateIds").split(",")[0]);	// 여러개중 첫번째 CateId를 넣어준다.
				updCnt = (Integer) statsMgmtDao.updateStatsTbl(params);
				
				if ( updCnt <= 0 ) {
					throw new ServiceException("admin.error.000003", getMessage("admin.error.000003"));
				}
			}
		} catch (DataAccessException dae) {
			EgovWebUtil.exTransactionLogging(dae);
		} catch (Exception e) {
			EgovWebUtil.exTransactionLogging(e);
		}
	}
	
	/**
	 * 통계표 키워드 저장
	 */
	public void saveStatsTag(Params params) {
		int updCnt = 0;
		String strActionStatus = params.getString(ModelAttribute.ACTION_STATUS);
		List<Record> tagList = new ArrayList<Record>();
		String statblId = params.getString("statblId");				//통계표 ID
		String regId = params.getString("regId");
		String updId = params.getString("updId");
		String strSchwTagCont = params.getString("schwTagCont");		//한글 키워드
		String strEngSchwTagCont = params.getString("engSchwTagCont");	//영문 키워드
		
		if ( StringUtils.isNotEmpty(strSchwTagCont) ) {
			String[] tmpArr = strSchwTagCont.split(",");
			for ( String tag : tmpArr ) {
				Record r = new Record();
				r.put("statblId", statblId);
				r.put("sysTag", "K");
				r.put("tagNm", tag);
				r.put("regId", regId);
				r.put("updId", updId);
				tagList.add(r);
			}
		}
		
		if ( StringUtils.isNotEmpty(strEngSchwTagCont) ) {
			String[] tmpArr = strEngSchwTagCont.split(",");
			for ( String tag : tmpArr ) {
				Record r = new Record();
				r.put("statblId", statblId);
				r.put("sysTag", "E");
				r.put("tagNm", tag);
				r.put("regId", regId);
				r.put("updId", updId);
				tagList.add(r);
			}
		}
		
		if ( tagList.size() > 0 ) {
			if ( ModelAttribute.ACTION_INS.equals(strActionStatus) ) {	
				statsMgmtDao.insertStatsTag(tagList);	//데이터 등록
			} else if ( ModelAttribute.ACTION_UPD.equals(strActionStatus) ) {
				statsMgmtDao.delStatsTag(params);		//데이터 삭제하고
				statsMgmtDao.insertStatsTag(tagList);	//등록
			}
		}
	}
	
	/**
	 * 통계표 옵션 정보 저장
	 * @param params
	 */
	public void saveStatsOpt(Params params) {
		
		String strActionStatus = params.getString(ModelAttribute.ACTION_STATUS);
		log.warn("saveStatsOpt strActionStatus="+strActionStatus);
		int optCnt = 0;
		int updCnt = 0;
		Map<String, List<HashMap<String, String>>> pMap = new HashMap<String, List<HashMap<String, String>>>();
		List<HashMap<String, String>> optList = new ArrayList<HashMap<String, String>>();
		HashMap<String, String> optMap = null;
		String statblId = params.getString("statblId");
		try{	
			// 통계분석(자료생성할 항목들)
			if ( params.getStringArray("statsDataTypeCd").length > 0 ) {
				String[] statsDataTypeArr = params.getStringArray("statsDataTypeCd");
				for ( int i=0; i < params.getStringArray("statsDataTypeCd").length; i++ ) {
					optMap = new HashMap<String, String>();
					optMap.put("statblId", statblId);
					optMap.put("optCd", "DD");
					optMap.put("optVal", statsDataTypeArr[i] );
					optList.add(optCnt++, optMap);
				}
			}
			
			// 통계분석(보기옵션)
			if ( params.getStringArray("dvsViewCd").length > 0 ) {
				String[] dvsViewArr = params.getStringArray("dvsViewCd");
				for ( int i=0; i < params.getStringArray("dvsViewCd").length; i++ ) {
					optMap = new HashMap<String, String>();
					optMap.put("statblId", statblId);
					optMap.put("optCd", "DP");
					optMap.put("optVal", dvsViewArr[i] );
					optList.add(optCnt++, optMap);
				}
			}
			
			//검색자료주기
			if ( !StringUtils.isEmpty(params.getString("optDC"))  ) {
				optList.add(optCnt++, addOptMapWithStrVal(statblId, "DC", params.getString("optDC")));
			}
			//검색시계열수(시트)
			if ( !StringUtils.isEmpty(params.getString("optTN"))  ) {
				optList.add(optCnt++, addOptMapWithStrVal(statblId, "TN", params.getString("optTN")));
			}
			//검색시계열수(차트)
			if ( !StringUtils.isEmpty(params.getString("optTC"))  ) {
				optList.add(optCnt++, addOptMapWithStrVal(statblId, "TC", params.getString("optTC")));
			}
			//시계열 합계출력
			if ( !StringUtils.isEmpty(params.getString("optTL"))  ) {
				optList.add(optCnt++, addOptMapWithStrVal(statblId, "TL", params.getString("optTL")));
			}
			//항목 단위출력
			if ( !StringUtils.isEmpty(params.getString("optIU"))  ) {    
				optList.add(optCnt++, addOptMapWithStrVal(statblId, "IU", params.getString("optIU")));
			}
			//시계열 정렬
			if ( !StringUtils.isEmpty(params.getString("optTO"))  ) {    
				optList.add(optCnt++, addOptMapWithStrVal(statblId, "TO", params.getString("optTO")));
			}
			//표두/표측(시계열)
			if ( !StringUtils.isEmpty(params.getString("optST"))  ) {
				optList.add(optCnt++, addOptMapWithStrVal(statblId, "ST", params.getString("optST")));
			}
			//표두/표측(그룹) - 20190401/신규추가
			if ( !StringUtils.isEmpty(params.getString("optSG"))  ) {
				optList.add(optCnt++, addOptMapWithStrVal(statblId, "SG", params.getString("optSG")));
			}
			//표두/표측(분류)
			if ( !StringUtils.isEmpty(params.getString("optSC"))  ) {
				optList.add(optCnt++, addOptMapWithStrVal(statblId, "SC", params.getString("optSC")));
			}
			//표두/표측(항목)
			if ( !StringUtils.isEmpty(params.getString("optSI"))  ) {
				optList.add(optCnt++, addOptMapWithStrVal(statblId, "SI", params.getString("optSI")));
			}
			
			pMap.put("pMap", optList);
			
			//통계 옵션데이터 등록/수정
			if ( ModelAttribute.ACTION_INS.equals(strActionStatus) ) {	
				statsMgmtDao.insertStatsOpt(pMap);	//데이터 등록
			} else if ( ModelAttribute.ACTION_UPD.equals(strActionStatus) ) {
				updCnt = (Integer) statsMgmtDao.delStatsOpt(params);	//데이터 일괄 삭제(USE_YN update)
				if ( updCnt <= 0 )	throw new ServiceException("admin.error.000003", getMessage("admin.error.000003"));
				updCnt = (Integer) statsMgmtDao.mergeStatsOpt(pMap);	//머지인투 처리
				if ( updCnt <= 0 )	throw new ServiceException("admin.error.000003", getMessage("admin.error.000003"));
			}
			
			//저장 후 분류 정보 없을 경우 분류 위치 옵션 값 삭제 
			/* 20190410-사용여부 'N' 처리할 필요가 없어보임
			int clsCnt = statInputDao.selectStatInputClsCnt(params);
			if ( clsCnt <= 0 ) {
				statsMgmtDao.delStatsOptInSc(params);
			}*/
		} catch (DataAccessException dae) {
    		EgovWebUtil.exTransactionLogging(dae);
		} catch (Exception e) {
			EgovWebUtil.exTransactionLogging(e);
		}
	}
	
	/**
	 * 통계표 자료작성 일정 등록
	 * @param params
	 */
	public void saveStatsSchl(Params params) {
		String strActionStatus = params.getString(ModelAttribute.ACTION_STATUS);
		log.warn("saveStatsSchl strActionStatus="+strActionStatus);
		int schlCnt = 0;
		Map<String, List<HashMap<String, String>>> pMap = new HashMap<String, List<HashMap<String, String>>>();
		List<HashMap<String, String>> schlList = new ArrayList<HashMap<String, String>>();
		HashMap<String, String> schlMap = null;
		String statblId = params.getString("statblId");
		
		//통계자료
		if ( params.getStringArray("dtacycleCd").length > 0 ) {
			String[] dtacycleCdArr = params.getStringArray("dtacycleCd");
			for ( int i=0; i < params.getStringArray("dtacycleCd").length; i++ ) {
				if ( "YY".equals(dtacycleCdArr[i]) ) {	//주기가 년도인경우
					schlMap = new HashMap<String, String>(); 
					schlMap.put("statblId", statblId);
					schlMap.put("dtacycleCd", dtacycleCdArr[i]);
					schlMap.put("wrttimeIdtfr", "00");
					schlMap.put("wrtstddCd", params.getString("wrtstddCd"));
					schlMap.put("wrtStartMd", params.getString("wrtstartMdYY").replaceAll("-", ""));
					schlMap.put("wrtEndMd", params.getString("wrtendMdYY").replaceAll("-", ""));
					schlList.add(schlCnt++, schlMap);
				} else if ( "HY".equals(dtacycleCdArr[i]) ) {	//반기인경우
					for ( int j=1; j < 3; j++ ) {	//반기 2번 loop(상/하반기)
						schlMap = new HashMap<String, String>();
						schlMap.put("statblId", statblId);
						schlMap.put("dtacycleCd", dtacycleCdArr[i]);
						schlMap.put("wrttimeIdtfr", "0" + String.valueOf(j));	//01, 02
						schlMap.put("wrtstddCd", params.getString("wrtstddCd"));
						//캘린더가 2개(wrtendMdHY01, wrtendMdHY02) 존재하여 순서대로 2번입력
						schlMap.put("wrtStartMd", params.getString("wrtstartMdHY0"+String.valueOf(j)).replaceAll("-", ""));	
						schlMap.put("wrtEndMd", params.getString("wrtendMdHY0"+String.valueOf(j)).replaceAll("-", ""));
						schlList.add(schlCnt++, schlMap);
					}
				} else if ( "QY".equals(dtacycleCdArr[i]) ) {	//분기인경우
					for ( int j=1; j < 5; j++ ) {	//4번 loop(1,2,3,4분기)
						schlMap = new HashMap<String, String>();
						schlMap.put("statblId", statblId);
						schlMap.put("dtacycleCd", dtacycleCdArr[i]);
						schlMap.put("wrttimeIdtfr", "0" + String.valueOf(j));
						schlMap.put("wrtstddCd", params.getString("wrtstddCd"));
						schlMap.put("wrtStartMd", params.getString("wrtstartMdQY0"+String.valueOf(j)).replaceAll("-", ""));	
						schlMap.put("wrtEndMd", params.getString("wrtendMdQY0"+String.valueOf(j)).replaceAll("-", ""));
						schlList.add(schlCnt++, schlMap);
					}
				} else if ( "MM".equals(dtacycleCdArr[i]) ) {	//월 인경우
					for ( int j=1; j < 13; j++ ) {	//12번 loop
						schlMap = new HashMap<String, String>();
						schlMap.put("statblId", statblId);
						schlMap.put("dtacycleCd", dtacycleCdArr[i]);
						schlMap.put("wrttimeIdtfr", (j < 10 ? "0":"") + String.valueOf(j));
						schlMap.put("wrtstddCd", params.getString("wrtstddCd"));
						schlMap.put("wrtStartMd",  (j < 10 ? "0":"") + String.valueOf(j) + params.getString("wrtstartMdMM")  );
						schlMap.put("wrtEndMd",  (j < 10 ? "0":"") + String.valueOf(j) + params.getString("wrtendMdMM")  );	
						schlList.add(schlCnt++, schlMap);
					}
				}
			}
		}
		
		pMap.put("pMap", schlList);
		//통계 스케쥴 데이터 등록/수정
		if ( ModelAttribute.ACTION_INS.equals(strActionStatus) ) {	
			statsMgmtDao.insertStatsSchl(pMap);	//데이터 등록
		} else if ( ModelAttribute.ACTION_UPD.equals(strActionStatus) ) {
			statsMgmtDao.deleteStatsSchl(params);	//삭제하고
			statsMgmtDao.insertStatsSchl(pMap);		//데이터 등록
		}
	}
	
	/**
	 * 통계표 담당자 저장
	 * @param params
	 */
	public void saveStatsUsr(Params params) {
		int updCnt = 0;
		int usrCnt = 0;
		String strActionStatus = params.getString(ModelAttribute.ACTION_STATUS);
		log.warn("saveStatsUsr strActionStatus="+strActionStatus);
		Map<String, List<HashMap<String, String>>> pMap = new HashMap<String, List<HashMap<String, String>>>();
		List<HashMap<String, String>> usrList = new ArrayList<HashMap<String, String>>();
		HashMap<String, String> usrMap = null;
		HashMap<String, String> usrOwnerMap = new HashMap<String, String>();
		String statblId = params.getString("statblId");
		String regId = params.getString("regId");
		String updId = params.getString("updId");
        try{
		    JSONArray jsonArray = new JSONObject(params.getJsonObject("ibsSaveJson")).getJSONArray("data");
		    for (int i = 0; i < jsonArray.length(); i++) {
		    	usrMap = new HashMap<String, String>();
		    	JSONObject jsonObj = (JSONObject) jsonArray.get(i);
		    	usrMap.put("statblId", statblId);
		    	
		    	// 테이블 키값이 usrCd인데 유저가 없을경우 dummyUser 세팅
		    	if ( StringUtils.isEmpty(jsonObj.getString("usrCd")) ) {
		    		usrMap.put("usrCd", "0");
		    	} 
		    	else {
		    		usrMap.put("usrCd", jsonObj.getString("usrCd"));
		    	}
		    	
		    	usrMap.put("orgCd", jsonObj.getString("orgCd"));
		    	usrMap.put("rpstYn", jsonObj.getString("rpstYn"));
		    	usrMap.put("prssAccCd", jsonObj.getString("prssAccCd"));
		    	usrMap.put("srcViewYn", jsonObj.getString("srcViewYn"));
		    	usrMap.put("useYn", jsonObj.getString("useYn"));
		    	usrMap.put("regId", regId);
		    	usrMap.put("updId", updId);
		    	usrList.add(usrCnt++, usrMap);
		    	
		    	if ( "Y".equals(jsonObj.getString("rpstYn")) ) {
		    		usrOwnerMap.put("statblId", statblId);
		    		usrOwnerMap.put("orgCd", jsonObj.getString("orgCd"));
		    		
		    		// 테이블 키값이 usrCd인데 유저가 없을경우 dummyUser 세팅
		        	if ( StringUtils.isEmpty(jsonObj.getString("usrCd")) ) {
		        		usrOwnerMap.put("usrCd", "0");
		        	} 
		        	else {
		        		usrOwnerMap.put("usrCd", jsonObj.getString("usrCd"));
		        	}
		    	}
		    }
		    
		    pMap.put("pMap", usrList);
			
			//통계 관리담당자 등록/수정
			if ( ModelAttribute.ACTION_INS.equals(strActionStatus) ) {	
				statsMgmtDao.insertStatsUsr(pMap);	//데이터 등록
			} else if ( ModelAttribute.ACTION_UPD.equals(strActionStatus) ) {
				statsMgmtDao.delStatsUsr(params);	//데이터 일괄 삭제(USE_YN update)
				updCnt = (Integer) statsMgmtDao.mergeStatsUsr(pMap);	//머지인투 처리
				if ( updCnt <= 0 )	throw new ServiceException("admin.error.000003", getMessage("admin.error.000003"));
			}
			
			updCnt = (Integer) statsMgmtDao.updateStatsOwnerUsr(usrOwnerMap);
			if ( updCnt <= 0 ) {
				throw new ServiceException("admin.error.000003", getMessage("admin.error.000003"));
			}
        }catch(DataAccessException dae){
        	EgovWebUtil.exTransactionLogging(dae);
        }catch (Exception e) {
        	EgovWebUtil.exTransactionLogging(e);
		}
	}
	
	//통계 Option테이블에 데이터를 넣기위한 map 객체 생성
	private HashMap<String, String> addOptMapWithStrVal(String statblId, String optCd, String optVal) {
		HashMap<String, String> optMap = new HashMap<String, String>();
		optMap.put("statblId", statblId);
		optMap.put("optCd", optCd);
		optMap.put("optVal", optVal);
		return optMap;
	}

	//통계표 관리담당자 목록 조회
	@Override
	public List<Record> statsUsrListPaging(Params params) {
		// 유저 입력 권한(부서별 or 개인별)
		CommUsr loginVO = (CommUsr)EgovUserDetailsHelper.getAuthenticatedUser();
		params.put("SysInpGbn", GlobalConstants.SYSTEM_INPUT_GBN);
		params.put("orgCd", loginVO.getOrgCd());	// 로그인 된 부서코드
		params.put("usrCd", loginVO.getUsrCd());	//로그인 된 유저 코드
		
		return statsMgmtDao.selectStatsUsrList(params);
	}


	/**
	 * 표준항목분류정보 계층 조회
	 */
	@Override
	public List<Map<String, Object>> selectStatStddItmPopup(Params params) {
		return statsMgmtDao.selectStatsStddItmPopList(params);
	}

	/**
	 * 표준항목단위정보 팝업 조회
	 */
	@Override
	public List<Map<String, Object>> selectStatsStddUiPopup(Params params) {
		return statsMgmtDao.selectStatsStddUiPopup(params);
	}
	
	/**
	 * 통계표 항목분류 리스트 조회
	 */
	@Override
	public List<Map<String, Object>> statsTblItmListPaging(Params params) {
		return statsMgmtDao.statsTblItmList(params);
	}

	/**
	 * 통계표 항목분류 입력/수정
	 */
	@Override
	public Result saveStddTblItmCUD(List<StatsStddTblItm> list, Params params) {
		int iTotalBatchCnt = 0;
		int mergeIdx = 0;
		int delIdx = 0;
		List<StatsStddTblItm> mergeList = new ArrayList<StatsStddTblItm>();	//입력/수정 list
		List<StatsStddTblItm> delList = new ArrayList<StatsStddTblItm>();	//삭제 list
			
		try {
			//status에 맞게 list 재정의
			for ( StatsStddTblItm vo : list )  {
				if ( "D".equals(vo.getStatus()) ) {
					delList.add(delIdx++, vo);
				} else {
					mergeList.add(mergeIdx++, vo);
					vo.setGb(params.getString("gb"));
					vo.setStatblId(params.getString("statblId"));
					//mergeList.add(mergeIdx++, vo);
					statsMgmtDao.mergeStddTblItm(vo);
					iTotalBatchCnt++;
					
					//BATCH_COUNT 단위로 끊어서 배치 실행
					if (iTotalBatchCnt > 0 && iTotalBatchCnt % BATCH_COUNT == 0) {
						statsMgmtDao.executeBatch();	//배치 실행
						statsMgmtDao.startBatch();
					}
				}
			}
			
			statsMgmtDao.executeBatch();	//배치 실행
			
			Map<String, Object> pMap = new HashMap<String, Object>();
			pMap.put("mergeList", mergeList);
			pMap.put("delList", delList);
			pMap.put("gb",  params.getString("gb"));
			pMap.put("statblId",  params.getString("statblId"));
			pMap.put("usrId",  params.getString("regId"));
			/*
			//입력/수정 값이 있을경우만 처리
			if ( !mergeList.isEmpty() ) {	
				int updCnt = (Integer) statsMgmtDao.mergeStddTblItm(pMap);
				if ( updCnt <= 0 ) {
					throw new ServiceException("admin.error.000003", getMessage("admin.error.000003"));
				}
			}
			*/
			
			//삭제 값이 있을경우만 처리
			if ( !delList.isEmpty() ) {
				int delCnt = (Integer) statsMgmtDao.delStddTblItm(pMap);
				if ( delCnt == 0 ) {
					throw new ServiceException("admin.error.000001", getMessage("admin.error.000001"));
				}
			}
			
			// 통계표 정보 항목/분류/그룹 설정 시 처리 작업
			statsMgmtDao.execSpModSttsTblItm(params);
	
			//출력항목명 FullNm 계층 업데이트
			statsMgmtDao.updateStddTblItmFullNm(pMap);
			
			/* 통계자료작성대장 생성 */ 
			statsMgmtDao.execSpCreateSttsWrtlist(params);
			
			return success(getMessage("admin.message.000007") + "(입력된 데이터가 있을경우 다시 입력해 주세요)");
		
		} catch (ServiceException sve) {
			return failure(getMessage("시스템 오류가 발생하였습니다"));
		} catch(DataAccessException dae) {
			error("DataAccessException : " , dae);
			//procedure 리턴 메세지 표시.
			SQLException se = (SQLException) ((DataAccessException) dae).getRootCause();
			throw new DBCustomException(getDbmsExceptionMsg(se));
		} catch(Exception e) {
			error("Exception : " , e);
			EgovWebUtil.exTransactionLogging(e);
			throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
		}
	}

	/**
	 * 항목/분류 순서 저장
	 */
	@Override
	public Result saveStddTblItmOrder(List<StatsStddTblItm> list, Params params) {
		for ( StatsStddTblItm itm : list ) {
			itm.setStatblId(params.getString("statblId"));
			statsMgmtDao.saveStddTblItmOrder(itm);
		}
		return success(getMessage("admin.message.000007"));
	}
	
	/**
	 * 통계표 메인 순서저장
	 */
	@Override
	public Result saveStatsMgmtOrder(Params params) {
		Record rec = null;
		try {
			JSONArray jsonArray = new JSONObject(params.getJsonObject("ibsSaveJson")).getJSONArray("data");
			for (int i = 0; i < jsonArray.length(); i++) {
	        	rec = new Record();
	        	JSONObject jsonObj = (JSONObject) jsonArray.get(i);
	        	if ( TBL_STATBL_TAG.equals(jsonObj.getString("statblTag")) ) {		//순서는 통계표 데이터만 저장
	        		rec.put("statblId", jsonObj.getString("statblId"));
	        		rec.put("vOrder", jsonObj.getInt("vOrder"));
	        		statsMgmtDao.saveStatsMgmtOrder(rec);
	        		
	        	}
			}
		} catch (JSONException je) {
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
	 * 통계표 백업후 삭제
	 */
	@Override
	public Result deleteStatsMgmt(Params params) {
		try {
			/* 통계표 정보 백업 후 삭제 */
			params.set(ModelAttribute.ACTION_STATUS, ModelAttribute.ACTION_DEL);
			statsMgmtDao.execSpBcupSttsTbl(params);
			
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
	 * 통계표 공개상태를 공개/취소 한다.
	 */
	@Override
	public Result updateOpenState(Params params) {
		statsMgmtDao.updateOpenState(params);
		return success(getMessage("admin.message.000007"));
	}
	
	/**
	 * 통계표 분석자료 일괄생성
	 */
	@Override
	public Result execSttsAnlsAll(Params params) {
		statsMgmtDao.execSttsAnlsAll(params);
		return success("정상적으로 호출 하였습니다.");
	}
	
	/**
	 * 통계표 복사
	 */
	@Override
	public Result execCopySttsTbl(Params params) {
		statsMgmtDao.execCopySttsTbl(params);
		return success("정상적으로 처리하였습니다.");
	}
	

	/**
	 * 통계표 분류체계 조회
	 */
	@Override
	public List<Record> statSttsTblCateList(Params params) {
		return statsMgmtDao.selectStatSttsTblCateList(params);
	}
	
	/**
	 * 통계표 분류체계 등록, 삭제
	 */
	public void saveStatTblCate(Params params) {
		
		String statblId = params.getString("statblId");
		String cateIds = params.getString("cateIds");
				
		if ( StringUtils.isNotEmpty(cateIds) ) {
			
			statsMgmtDao.updateStatTblCate(params);		// 기존정보 삭제하고(USE_YN = 'N')
			
			// 신규 정보 입력한다.(MERGE INTO)
			String[] tmpArr = cateIds.split(",");
			for ( String cateId : tmpArr ) {
				Record r = new Record();
				r.put("statblId", statblId);
				r.put("cateId", cateId);
				statsMgmtDao.insertStatTblCate(r);
			}
			
			statsMgmtDao.deleteStatTblCate(params);		// 데이터 삭제 = use_yn = 'N' 인것들
		}
	}

	/**
	 * 연관 통계표 팝업 조회
	 * @param params
	 * @return
	 */
	public List<Record> selectSttsTblPopList(Params params) {
		return statsMgmtDao.selectSttsTblPopList(params);
	}
	
	/**
	 * 연관 통계표 리스트 조회
	 */
	public List<Record> selectSttsTblList(Params params) {
		return statsMgmtDao.selectSttsTblList(params);
	}
	
	/**
	 * 연관 통계표 저장
	 * @param params
	 */
	public void saveStatsTblRel(Params params) {
		int updCnt = 0;
		int tblCnt = 0;
		String strActionStatus = params.getString(ModelAttribute.ACTION_STATUS);

		Map<String, List<HashMap<String, String>>> pMap = new HashMap<String, List<HashMap<String, String>>>();
		List<HashMap<String, String>> tblList = new ArrayList<HashMap<String, String>>();
		HashMap<String, String> tblMap = null;
		
		String statblId = params.getString("statblId");
		String regId = params.getString("regId");
		String updId = params.getString("updId");
		try{
	        JSONArray jsonArray = new JSONObject(params.getJsonObject("ibsSaveJson2")).getJSONArray("data");
	        if ( jsonArray.length() > 0 ) {
		        for (int i = 0; i < jsonArray.length(); i++) {
		        	tblMap = new HashMap<String, String>();
		        	JSONObject jsonObj = (JSONObject) jsonArray.get(i);
		        	
		        	String status = jsonObj.getString("status");
		        	if ( !StringUtils.equals("D", status) ) {
			        	tblMap.put("statblId", statblId);
			        	tblMap.put("relStatblId", jsonObj.getString("relStatblId"));
			        	tblMap.put("useYn", jsonObj.getString("useYn"));
			        	tblMap.put("regId", regId);
			        	tblMap.put("updId", updId);
			        	tblList.add(tblCnt++, tblMap);
		        	}
		        }
		        
		        pMap.put("pMap", tblList);
				
				// 연관 통계표 등록/수정
				if ( ModelAttribute.ACTION_INS.equals(strActionStatus) ) {	
					statsMgmtDao.mergeStatsTblRel(pMap);	//데이터 등록
				} else if ( ModelAttribute.ACTION_UPD.equals(strActionStatus) ) {
					statsMgmtDao.delStatsTblRel(params);	//데이터 일괄 삭제(USE_YN update)
					updCnt = (Integer) statsMgmtDao.mergeStatsTblRel(pMap);	//머지인투 처리
					if ( updCnt <= 0 )	throw new ServiceException("admin.error.000003", getMessage("admin.error.000003"));
				}
	        }
		}catch(DataAccessException dae){
			EgovWebUtil.exTransactionLogging(dae);
		}catch (Exception e) {
			EgovWebUtil.exTransactionLogging(e);
		}
	}
	
	public List<Record> selectStatsCateInfoList(Params params) {
		return statsMgmtDao.selectStatsCateInfoList(params);
	}
	public List<Record> selectStatCateInfoPop(Params params) {
		return statsMgmtDao.selectStatCateInfoPop(params);
	}
	
	/**
	 * 통계표 분류정보 관련 분류 등록 저장
	 */
	public void saveStatsCateInfo(Params params) throws JSONException {
		Record record = null;
		String statblId = params.getString("statblId");
		String regId = params.getString("regId");
		String updId = params.getString("updId");
		
		JSONArray jsonArray = new JSONObject(params.getJsonObject("ibsSaveJson3")).getJSONArray("data");
		if ( jsonArray.length() > 0) {
			for ( int i=0; i < jsonArray.length(); i++ ) {
				JSONObject jObj = (JSONObject) jsonArray.get(i);
				String status = jObj.getString("status");
				record = new Record();
				record.put("statblId", statblId);
				record.put("cateId", jObj.getString("cateId"));
				
				// 삭제로 넘어온 행
				if ( StringUtils.equals(status, ModelAttribute.ACTION_DEL) ) {
					statsMgmtDao.deleteStatsCateInfo(record);
				}
				else if ( StringUtils.equals(status, ModelAttribute.ACTION_INS) || StringUtils.equals(status, ModelAttribute.ACTION_UPD) ) {
					record.put("regId", regId);
					record.put("updId", updId);
					record.put("rpstYn", jObj.getString("rpstYn"));
					record.put("useYn",  jObj.getString("useYn"));
					statsMgmtDao.mergeStatsCateInfo(record);
				}
			}
			
			// 분류체계 대표여부 처리
			statsMgmtDao.updateMstStatsCateInfo(params);
		}
	}
	@Override
	public Paging selectStfStatsMgmtListPaging(Params params) {
		if(EgovUserDetailsHelper.isAuthenticated()) {
			CommUsr loginVO = null;
    		EgovUserDetailsHelper.getAuthenticatedUser();
    		loginVO = (CommUsr)EgovUserDetailsHelper.getAuthenticatedUser();
    		params.put("accCd", loginVO.getAccCd());	//로그인 된 유저 권환 획득
    		// 유저 입력 권한(부서별 or 개인별)
    		params.put("SysInpGbn", GlobalConstants.SYSTEM_INPUT_GBN);
    		params.put("inpOrgCd", loginVO.getOrgCd());	// 로그인 된 부서코드
    		params.put("inpUsrCd", loginVO.getUsrCd());	//로그인 된 유저 코드
        }
		Paging list = statsMgmtDao.selectStfStatsMgmtList(params, params.getPage(), params.getRows());
		
		return list;
	}
	@Override
	public Object saveStfStatsMgmt(HttpServletRequest request, Params params) {
		try {
			statsMgmtDao.saveStfStatsMgmt(params);
			saveStatsTag(params);
			/* 통계표 정보 백업 */
			statsMgmtDao.execSpBcupSttsTbl(params);
			if ( ModelAttribute.ACTION_UPD.equals(params.getString(ModelAttribute.ACTION_STATUS)) ) {
				return success(getMessage("admin.message.000004"));
			}
		} catch(DataAccessException dae) {
			error("DataAccessException : " , dae);
			//procedure 리턴 메세지 표시.
			SQLException se = (SQLException) ((DataAccessException) dae).getRootCause();
			throw new DBCustomException(getDbmsExceptionMsg(se));
		} catch(Exception e) {
			error("Exception : " , e);
			EgovWebUtil.exTransactionLogging(e);
			throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
		}
		return "";
	}
	@Override
	public Record stfStatsMgmtDtl(Params params) {
		Record result = null;
		try {
			result =  (Record)statsMgmtDao.selectStfStatsMgmtDtl(params);
		}catch(DataAccessException dae){
			EgovWebUtil.exLogging(dae);
		}catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return result;
	}
	
}

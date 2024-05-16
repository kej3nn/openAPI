package egovframework.admin.stat.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Pattern;

import javax.annotation.Resource;

import org.apache.commons.lang.ObjectUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import egovframework.admin.basicinf.service.CommUsr;
import egovframework.admin.stat.service.StatInputService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.common.base.constants.GlobalConstants;
import egovframework.common.base.exception.DBCustomException;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;
import egovframework.common.base.service.BaseService;
import egovframework.common.util.UtilExcelDtChck;
import egovframework.rte.fdl.cmmn.exception.EgovBizException;

/**
 * 통계표 입력을 관리하는 서비스
 * 
 * @author	김정호
 * @version 1.0
 * @since   2017/06/02
 */

@Service(value="statInputService")
public class StatInputServiceImpl extends BaseService implements StatInputService {
	
	/**
	 * 항목/분류 구분 키 값
	 */
	protected static final String ITM_TAG_KEY = "itmTag";
	/**
	 * 항목 코드 값
	 */
	protected static final String ITM_TAG_ITEM = "I";
	/**
	 * 분류 코드 값
	 */
	protected static final String ITM_TAG_CLS = "C";
	/**
	 * 그룹 코드 값
	 */
	protected static final String ITM_TAG_GRP = "G";
	/**
	 * 항목 SaveName 값
	 */
	private static final String SAVENAME_ITM_NM = "iCol_";
	/**
	 * 분류 SaveName 값
	 */
	private static final String SAVENAME_CLS_NM = "cCol";
	/**
	 * 그룹 SaveName 값
	 */
	private static final String SAVENAME_GRP_NM = "gCol";
	/**
	 * 자료시점코드 SaveName 값
	 */
	private static final String SAVENAME_WRTTIME_IDTFR_ID = "wrttimeIdtfrId";
	/**
	 * 자료시점 SaveName 값
	 */
	private static final String SAVENAME_DTADVS_YEAR = "dYear";
	/**
	 * 통계자료 코드 SaveName 값
	 */
	private static final String SAVENAME_DTADVS_CD = "dtadvsCd";
	/**
	 * 통계자료 명 SaveName 값
	 */
	private static final String SAVENAME_DTADVS_NM = "dtadvsNm";
	/**
	 * 데이터 값
	 */
	private static final String DATA_DTA_VAL = "dtaVal";
	/**
	 * 주석 식별자
	 */
	private static final String DATA_CMMT_IDTFR = "cmmtIdtfr";
	/**
	 * 항목 자료번호
	 */
	private static final String DATA_ITM_DATANO = "itmDatano";
	/**
	 * 분류 자료번호
	 */
	private static final String DATA_CLS_DATANO = "clsDatano";
	/**
	 * 그룹 자료번호
	 */
	private static final String DATA_GRP_DATANO = "grpDatano";
	/**
     * 최대 파일 크기
     */
    private static final long MAX_FILE_SIZE = 1024 * 1024 * 20;
    /**
     * 엑셀 폼 자료시점코드 엑셀 컬럼 번호
     */
    private static final long EXCEL_COL_IDX_WRTTIME_IDTFR_ID = 0;
    /**
     * 엑셀 폼 자료구분코드 엑셀 컬럼 번호 - 자료구분
     */
    private static final long EXCEL_COL_IDX_DTADVS = 1;
    /**
     * 엑셀 폼 자료구분코드 엑셀 컬럼 번호 - 분류
     */
    private static final long EXCEL_COL_IDX_CLS_DATANO = 2;
    /**
     * 엑셀 폼 자료구분코드 엑셀 컬럼 번호 - 그룹
     */
    private static final long EXCEL_COL_IDX_GRP_DATANO = 3;
    /**
     * 배치 카운트
     */
    private static final int BATCH_COUNT = 10000;
    
    public static final int BUFF_SIZE = 2048;

	@Resource(name="statInputDao")
	protected StatInputDao statInputDao;
	
	@Resource(name="statsMgmtDao")
	protected StatsMgmtDao statsMgmtDao;

	/**
	 * 통게표 메인 리스트 조회(페이징 처리)
	 */
	@Override
	public Paging statInputMainListPaging(Params params) { 
		String statblId = "";		//통계표ID
		String statblNm = "";		//통계표명
		String statExpHtml = "";	//통계설명 Html 값
		String statTblHtml = "";	//통계표팝업 HTML
		
		if ( params.getStringArray("inputStatus") != null ) {	//입력상태
			params.set("inputStatusArr", new ArrayList<String>(Arrays.asList(params.getStringArray("inputStatus"))));
		}
		
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
		
		// 분류체계 여러개 검색(IN 절)
		if ( StringUtils.isNotEmpty(params.getString("cateIds")) ) {
			ArrayList<String> iterCateId = new ArrayList<String>(Arrays.asList(params.getString("cateIds").split(",")));
			params.set("iterCateId", iterCateId);
		}
		
		/* 리스트 조회 */
		Paging list = statInputDao.selectStatInputMainList(params, params.getPage(), params.getRows());
		
		/* 조회된 데이터에 팝업 그림에 이벤트 넣기 */
		ArrayList<LinkedHashMap<String, Object>> lList = (ArrayList<LinkedHashMap<String, Object>>) list.get("data");
		for ( int i=0; i < lList.size(); i++ ) {
			LinkedHashMap<String, Object> r = lList.get(i);
			statblId = String.valueOf(r.get("statblId"));
			statblNm = String.valueOf(r.get("statblNm"));
			statExpHtml = " <a href=\"/admin/stat/popup/statMetaExpPopup.do?statblId="+statblId+"\" target=\"_blank\" title=\"통계설명(팝업)\">" + StatSttsStatServiceImpl.STAT_EXP_POP_ICON + "</a>";
			statTblHtml = "<a href=\"/admin/stat/statPreviewPage/"+statblId+".do\" target=\"_blank\" title=\"통계표(팝업)\">" + StatSttsStatServiceImpl.STAT_TBL_POP_ICON + "</a>";
			r.put("statblNm", statblNm + statExpHtml + statTblHtml);
		}
		return list;
	}

	/**
	 * 통계표 상세 조회
	 */
	@Override
	public Map<String, Object> statInputDtl(Map<String, String> paramMap) {
		Map<String, Object> rMap = new HashMap<String, Object>();
		rMap.put("DATA", statInputDao.selectStatInputDtl(paramMap));
		
		if(EgovUserDetailsHelper.isAuthenticated()) {
			CommUsr loginVO = null;
			Params params = new Params(paramMap);
    		EgovUserDetailsHelper.getAuthenticatedUser();
    		loginVO = (CommUsr)EgovUserDetailsHelper.getAuthenticatedUser();
    		String accCd = loginVO.getAccCd();
    		List<Record> usrList = new ArrayList<Record>();
    		//관리자는 모든 권한 부여
    		if ( "SYS".equals(accCd) ) {
    			Record r = new Record();
    			r.put("prssAccCd", 50);
    			usrList.add(r);
    		} else {
    			// 유저 입력 권한(부서별 or 개인별)
        		params.put("SysInpGbn", GlobalConstants.SYSTEM_INPUT_GBN);
        		params.put("inpOrgCd", loginVO.getOrgCd());	// 로그인 된 부서코드
        		params.put("inpUsrCd", loginVO.getUsrCd());	//로그인 된 유저 코드
        		
	    		//관련 통계표 유저정보 가져온다.
    			String prssAccCd = statInputDao.selectStatsInputUsrAcc(params);
    			Record r = new Record();
    			r.put("prssAccCd", prssAccCd);
    			usrList.add(r);
    		}
    		rMap.put("DATA2", usrList);
        }
		
		return rMap;
	}

	/**
	 * 통계표 분류/항목 조회
	 */
	@Override
	public Map<String, Object> selectStatInputItm(Params params) {
		Map<String, Object> rMap = new HashMap<String, Object>();
		int iMaxLevel = 0;
		int cMaxLevel = 0;
		int gMaxLevel = 0;
		int iCnt = 0;
		int cCnt = 0;
		int gCnt = 0;
		
		//항목 조회
		params.set(ITM_TAG_KEY, ITM_TAG_ITEM);
		List<Map<String, Object>> iList = (List<Map<String, Object>>) statInputDao.selectStatInputItm(params);
		
		if ( iList.size() > 0 ) {
			iMaxLevel = ((BigDecimal) iList.get(0).get("maxLevel")).intValue();
			for ( Object iData : iList ) {
				Map<String, Object> iRow = (Map<String, Object>) iData;
				int iIsLeaf = ((BigDecimal) iRow.get("leaf")).intValue();
				String sDummyYn = String.valueOf(iRow.get("dummyYn"));
				//자식 항목이 없 것들만 항목으로 취급(레벨단위로 되어있기 때문에 최하위 항목 시트에 표시)
				//if ( iIsLeaf == 1 ) {
				if ( "N".equals(sDummyYn) ) {
					iCnt++;
				}
			}
		}
		
		//분류 조회
		params.set(ITM_TAG_KEY, ITM_TAG_CLS);
		List<Map<String, Object>> cList = (List<Map<String, Object>>) statInputDao.selectStatInputItm(params);
		
		if ( cList.size() > 0 ) {
			cMaxLevel = ((BigDecimal) cList.get(0).get("maxLevel")).intValue();
			for ( Object cData : cList ) {
				Map<String, Object> cRow = (Map<String, Object>) cData;
				int cLevel = ((BigDecimal) cRow.get("level")).intValue();
				if ( cLevel == 1 ) {
					cCnt++;
				}
			}
		}
		
		//그룹 조회
		params.set(ITM_TAG_KEY, ITM_TAG_GRP);
		List<Map<String, Object>> gList = (List<Map<String, Object>>) statInputDao.selectStatInputItm(params);
		
		if ( gList.size() > 0 ) {
			gMaxLevel = ((BigDecimal) gList.get(0).get("maxLevel")).intValue();
			for ( Object gData : gList ) {
				Map<String, Object> gRow = (Map<String, Object>) gData;
				int gLevel = ((BigDecimal) gRow.get("level")).intValue();
				if ( gLevel == 1 ) {
					gCnt++;
				}
			}
		}
		
		rMap.put("I_DATA", iList);				//항목 데이터
		rMap.put("I_MAX_LEVEL", iMaxLevel);		//항목 최대레벨
		rMap.put("I_COL_CNT", iCnt);			//항목 갯수
		
		rMap.put("C_DATA", cList);				//분류 데이터
		rMap.put("C_MAX_LEVEL", cMaxLevel);		//분류 최대레벨
		rMap.put("C_COL_CNT", cCnt);			//분류 갯수
		
		rMap.put("G_DATA", gList);				//그룹 데이터
		rMap.put("G_MAX_LEVEL", gMaxLevel);		//그룹 최대레벨
		rMap.put("G_COL_CNT", gCnt);			//그룹 갯수

		// 통계기호 입력시트 여부
		rMap.put("MARK_YN", StringUtils.isNotEmpty(params.getString("markYn")) && params.getString("markYn").equals("Y") ? "Y" : "N");
		
		// 주석 입력 여부
		rMap.put("CMMT_YN", StringUtils.isNotEmpty(params.getString("cmmtYn")) && params.getString("cmmtYn").equals("Y") ? "Y" : "N");
		
		return rMap;
	}

	/**
	 * 통계표 입력 시트 조회
	 */
	@Override
	public List<Map<String, Object>> statInputList(Params params) {
		return getStatInputSheetData(params);
	}
	
	/**
	 * 통계표 입력 시트 조회
	 */
	public List<Map<String, Object>> getStatInputSheetData(Params params) {
		List<Map<String, Object>> list = new LinkedList<Map<String, Object>>();
		LinkedHashMap<String, Map<String, Object>> tMap = new LinkedHashMap<String, Map<String, Object>>();
		HashMap<String, Object> row = null;
		int listIdx = 0;
		int cMaxLevel = 0;
		int cIsLeaf = 0;
		String sDummyYn = "";
		//String sWrttimeDesc = params.getString("wrttimeDesc");	//자료작성시점
		
		// 통계기호 입력여부
		String markYn = StringUtils.isNotEmpty(params.getString("markYn")) && params.getString("markYn").equals("Y") ? "Y" : "N";
		
		// 주석입력 조회여부
		String cmmtYn = StringUtils.isNotEmpty(params.getString("cmmtYn")) && params.getString("cmmtYn").equals("Y") ? "Y" : "N";
		
		//통계 데이터셋 연계정보 조회
		Map<String, Object> stddDscn = (Map<String, Object>) statInputDao.selectStatInputDscn(params);
		params.set("ownerCd", stddDscn.get("ownerCd"));					//대상 owner
		params.set("dsId", stddDscn.get("dsId"));						//대상 데이터셋명
		
		//분류 조회
		params.set(ITM_TAG_KEY, ITM_TAG_CLS);
		List<Map<String, Object>> cList = (List<Map<String, Object>>) statInputDao.selectStatInputItm(params);
		//그룹 조회
		params.set(ITM_TAG_KEY, ITM_TAG_GRP);
		List<Map<String, Object>> gList = (List<Map<String, Object>>) statInputDao.selectStatInputItm(params);
		//통계자료코드 조회
		List<Map<String, Object>> dtaList = (List<Map<String, Object>>) statInputDao.selectStatDtadvsCd(params);

		
		/* 통계표 일괄 등록 파라미터 세팅 */
		setBatchInputParam(params);	
		
		ArrayList<String> iterBatchWrttimeIdtfrId = (ArrayList<String>) params.get("iterBatchWrttimeIdtfrId");	// 일괄 등록 자료시점
		ArrayList<String> iterBatchWrttimeDesc = (ArrayList<String>) params.get("iterBatchWrttimeDesc");		// 일괄 등록 자료시점 설명
		
		for ( int batchCnt=0; batchCnt < iterBatchWrttimeIdtfrId.size(); batchCnt ++ ) {
			// 그룹, 분류가 모두 있을경우
			if ( gList.size() > 0 && cList.size() > 0 ) {
				//데이터 조회시 where 조회조건으로 사용
				params.set("grpExistYn", "Y");	//그룹 데이터 존재
				params.set("clsExistYn", "Y");	//분류 데이터 존재
								
				Params dummyMap = new Params();
				dummyMap.set("batchWrttimeIdtfrId", iterBatchWrttimeIdtfrId.get(batchCnt));
				dummyMap.set("batchWrttimeDesc", iterBatchWrttimeDesc.get(batchCnt));
				dummyMap.set("dtaList", dtaList);
				dummyMap.set("grpData", gList);
				dummyMap.set("clsData", cList);
				setInputSheetBasisAll(tMap, dummyMap);
			}	// 그룹만 있을경우
			else if ( gList.size() > 0 && cList.size() == 0 ) {
				//데이터 조회시 where 조회조건으로 사용
				params.set("grpExistYn", "Y");	//그룹 데이터 존재
				params.set("clsExistYn", "N");	//분류 데이터 미존재
				
				Params grpDummyMap = new Params();
				grpDummyMap.set("gubun", "G");
				grpDummyMap.set("batchWrttimeIdtfrId", iterBatchWrttimeIdtfrId.get(batchCnt));
				grpDummyMap.set("batchWrttimeDesc", iterBatchWrttimeDesc.get(batchCnt));
				grpDummyMap.set("data", gList);
				grpDummyMap.set("dtaList", dtaList);
				setInputSheetBasis(tMap, grpDummyMap);
			} // 분류만 있을경우
			else if ( cList.size() > 0 ) {
				params.set("grpExistYn", "N");	//그룹 데이터 미존재
				params.set("clsExistYn", "Y");	//분류 데이터 존재(데이터 조회시 where 조회조건으로 사용)
				
				Params clsDummyMap = new Params();
				clsDummyMap.set("gubun", "C");
				clsDummyMap.set("batchWrttimeIdtfrId", iterBatchWrttimeIdtfrId.get(batchCnt));
				clsDummyMap.set("batchWrttimeDesc", iterBatchWrttimeDesc.get(batchCnt));
				clsDummyMap.set("data", cList);
				clsDummyMap.set("dtaList", dtaList);
				setInputSheetBasis(tMap, clsDummyMap);
				
			} else {
				// 그룹 및 분류 데이터 없을 경우(항목으로만 생성한다)
				params.set("clsExistYn", "N");	//분류 데이터 미존재
				for ( Map<String, Object> dta : dtaList ) {		//통계자료구분코드는 한건이상 존재(원자료)
					row = new HashMap<String, Object>();
					row.put(SAVENAME_DTADVS_CD, ((String) dta.get(SAVENAME_DTADVS_CD)) );
					row.put(SAVENAME_DTADVS_NM, ((String) dta.get(SAVENAME_DTADVS_NM)) );
					row.put(SAVENAME_WRTTIME_IDTFR_ID, iterBatchWrttimeIdtfrId.get(batchCnt) );
					row.put(SAVENAME_DTADVS_YEAR, iterBatchWrttimeDesc.get(batchCnt) );
					tMap.put(iterBatchWrttimeIdtfrId.get(batchCnt) 
							+ ((String) dta.get(SAVENAME_DTADVS_CD)) , row );
				}
			}
		}
		
		//실제 데이터
		List<Map<String, Object>> dList = (List<Map<String, Object>>) statInputDao.selectStatInputData(params);
		//키값으로 사용하는 데이터
		String sItmDatano = "";			//항목데이터번호
		String sClsDatano = "";			//분류데이터번호
		String sGrpDatano = "";			//그룹데이터번호
		String sDtadvsCd = "";			//비교자료구분코드
		String sWrttimeIdtfrId = "";	// 자료시점 코드
		String tMapKey = "";			// 맵에서 객체 가져오기위한 키
		
		if ( dList.size() > 0 ) {	//데이터가 있는경우
			row = new HashMap<String, Object>();
			
			for ( Object data : dList ) {
				Map<String, Object> dRow = (Map<String, Object>) data;
				
				//ibsheet에서 사용하기 위해 구분값 'iCol_' 항목자료번호 앞에 넣음
				sItmDatano = SAVENAME_ITM_NM + String.valueOf( ((BigDecimal) dRow.get(DATA_ITM_DATANO)).intValue() );
				sWrttimeIdtfrId = String.valueOf(dRow.get("wrttimeIdtfrId"));
				sDtadvsCd = (String) dRow.get(SAVENAME_DTADVS_CD);
				
				sGrpDatano = String.valueOf(ObjectUtils.defaultIfNull(dRow.get(DATA_GRP_DATANO), 0));	// 그룹자료번호
				sClsDatano = String.valueOf(ObjectUtils.defaultIfNull(dRow.get(DATA_CLS_DATANO), 0));	// 분류 자료번호
				
				// 그룹과 분류가 모두 있는경우
				if ( !StringUtils.equals(sGrpDatano, "0") && !StringUtils.equals(sClsDatano, "0") ) {
					tMapKey = sWrttimeIdtfrId + sGrpDatano + sClsDatano + sDtadvsCd;
				}	// 그룹만 있는경우
				else if ( !StringUtils.equals(sGrpDatano, "0") && StringUtils.equals(sClsDatano, "0") ) {
					tMapKey = sWrttimeIdtfrId + sGrpDatano + sDtadvsCd;
				}	// 분류만 있는경우
				else if ( !StringUtils.equals(sClsDatano, "0") ) {
					tMapKey = sWrttimeIdtfrId + sClsDatano + sDtadvsCd;
				}
				else {
					// 분류값이 없는경우 자료시점코드 + 통계자료코드를 키 값으로 활용
					tMapKey = sWrttimeIdtfrId + sDtadvsCd;
				}
				
				if ( dRow.get(DATA_DTA_VAL) != null ) {				//value 값이 없는경우
					
					if ( "Y".equals(markYn) ) {
						// 통계기호 작성할경우 데이터 타입이 String 이다.
						tMap.get(tMapKey).put(sItmDatano, String.valueOf(dRow.get(DATA_DTA_VAL)));
					}
					else if ( "Y".equals(cmmtYn) ) {
						// 주석 작성할경우 데이터 타입이 String 이다.
						if ( dRow.get(DATA_CMMT_IDTFR) != null ) {
							tMap.get(tMapKey).put(sItmDatano, String.valueOf(dRow.get(DATA_CMMT_IDTFR)));
						}
					}
					else {
						// 일반 데이터 형은 시트가 Float 타입이다.
						tMap.get(tMapKey).put(sItmDatano, ((BigDecimal) dRow.get(DATA_DTA_VAL)).doubleValue());
					}
				}
				else if ( dRow.get(DATA_CMMT_IDTFR) != null && "Y".equals(cmmtYn) ) {
					// 데이터 값이 없으면서 주석값은 있을수가 있다.
					tMap.get(tMapKey).put(sItmDatano, String.valueOf(dRow.get(DATA_CMMT_IDTFR)));
				}
			}
		}
		
		//map -> list
		Set<String> entrySet = tMap.keySet();
		Iterator<String> iter = entrySet.iterator();
		while ( iter.hasNext() ) {
			String sKey = ((String) iter.next()); 
			list.add(listIdx++, tMap.get(sKey));
		}

		return list;
	}
	
	/**
	 * 입력 시트 베이스 생성(그룹과 분류가 각각 존재할 경우)
	 * @param tMap		메인에서 사용하는 맵객체
	 * @param dummyMap	베이스 생성조건 맵
	 */
	public void setInputSheetBasis(LinkedHashMap<String, Map<String, Object>> tMap, Params dummyMap) {
		
		String gubun = dummyMap.getString("gubun");	// 구분(I/C/G)
		List<Map<String, Object>> list = (List<Map<String, Object>>) dummyMap.get("data");
		int maxLevel = ((BigDecimal) list.get(0).get("maxLevel")).intValue();	// 최대레벨
		HashMap<String, Object> row = null;
		
		for ( Object data : list ) {
			Map<String, Object> cRow = (Map<String, Object>) data;
			row = new HashMap<String, Object>();
			String datano = String.valueOf( ((BigDecimal) cRow.get("datano")).intValue() );
			if ( StringUtils.equals("N", String.valueOf(cRow.get("dummyYn"))) ) {
				String sFullNm = (String) cRow.get("itmFullNm");	//분류 전체경로
				String[] sFullNmArr = sFullNm.split(">");
				for ( int i=0; i < maxLevel; i++ ) {	//분류 레벨만큼 컬럼 생성
					if ( sFullNmArr.length > 0 ) {
						if ( (i+1) > sFullNmArr.length) {
							row.put((StringUtils.equals(gubun, "G") ? SAVENAME_GRP_NM : SAVENAME_CLS_NM) + String.valueOf(i+1), sFullNmArr[sFullNmArr.length-1] );
						} else {
							row.put((StringUtils.equals(gubun, "G") ? SAVENAME_GRP_NM : SAVENAME_CLS_NM) + String.valueOf(i+1), sFullNmArr[i] );
						}
					} else {
						row.put((StringUtils.equals(gubun, "G") ? SAVENAME_GRP_NM : SAVENAME_CLS_NM) + String.valueOf(i+1), sFullNm);	//1레벨같은경우 해당 값 넣음
					}
				}
				row.put(StringUtils.equals(gubun, "G") ? "gColDatano": "cColDatano", datano);
			}
			
			// 원자료 외 자료구분에 따라 동일한 항목, 분류, 그룹에 대해 데이터 추가 
			setInputSheetBasisCopyDta(tMap, dummyMap, row, datano);
		}
	}
	
	/**
	 * 입력시트 베이스 생성 후 자료구분에 갯수만큼 베이스행 추가해준다.
	 * @param tMap		메인에서 사용하는 맵객체
	 * @param dummyMap	베이스 생성조건 맵
	 * @param row		시트의 한개의 행에 들어있는 정보들
	 * @param dataRow	데이터 구분번호
	 */
	public void setInputSheetBasisCopyDta(LinkedHashMap<String, Map<String, Object>> tMap, Params dummyMap, HashMap<String, Object> row, String dataRow) {
		
		int batchWrttimeIdtfrId = dummyMap.getInt("batchWrttimeIdtfrId");
		String batchWrttimeDesc = dummyMap.getString("batchWrttimeDesc");
		List<Map<String, Object>> dtaList = (List<Map<String, Object>>) dummyMap.get("dtaList");
		//통계자료 구분코드별로 생성된 row에 row 추가 생성(원자료, 전년대비자료 등등)
		for ( Map<String, Object> dta : dtaList ) {
			Map<String, Object> tmpMap = new HashMap<String, Object>();
			tmpMap = (HashMap) row.clone();	//통계자료가 다 건일경우 hashmap(분류정보) 복제하여 put
			tmpMap.put(SAVENAME_DTADVS_CD, ((String) dta.get(SAVENAME_DTADVS_CD)) );
			tmpMap.put(SAVENAME_DTADVS_NM, ((String) dta.get(SAVENAME_DTADVS_NM)) );
			tmpMap.put(SAVENAME_WRTTIME_IDTFR_ID, batchWrttimeIdtfrId );	//자료시점코드
			tmpMap.put(SAVENAME_DTADVS_YEAR, batchWrttimeDesc );			//자료시점
			///LinkedHashMap에 키(항목 datano)와 row를 매칭해서 입력해 둠
			tMap.put(batchWrttimeIdtfrId
					+ dataRow
					+ ((String) dta.get(SAVENAME_DTADVS_CD)) , tmpMap);
		}
	}
	
	/**
	 * 입력 시트 베이스 생성(그룹, 분류가 모두 존재할경우)
	 * @param tMap
	 * @param dummyMap
	 */
	public void setInputSheetBasisAll(LinkedHashMap<String, Map<String, Object>> tMap, Params dummyMap) {
		
		List<Map<String, Object>> grpList = (List<Map<String, Object>>) dummyMap.get("grpData");	// 그룹 데이터
		List<Map<String, Object>> clsList = (List<Map<String, Object>>) dummyMap.get("clsData");	// 분류 데이터
		int grpMaxLevel = ((BigDecimal) grpList.get(0).get("maxLevel")).intValue();		// 그룹 최대레벨
		int clsMaxLevel = ((BigDecimal) clsList.get(0).get("maxLevel")).intValue();		// 분류 최대레벨
		HashMap<String, Object> grpDataRow = null;
		
		for ( Object gData : grpList ) {
			Map<String, Object> grpRow = (Map<String, Object>) gData;
			grpDataRow = new HashMap<String, Object>();
			String grpDatano = String.valueOf( ((BigDecimal) grpRow.get("datano")).intValue() );
			String clsDatano = "";
			
			if ( StringUtils.equals("N", String.valueOf(grpRow.get("dummyYn"))) ) {
				String grpFullNm = (String) grpRow.get("itmFullNm");	//그룹 전체경로
				String[] grpFullNmArr = grpFullNm.split(">");
				for ( int i=0; i < grpMaxLevel; i++ ) {	//그룹 레벨만큼 컬럼 생성
					if ( grpFullNmArr.length > 0 ) {
						if ( (i+1) > grpFullNmArr.length) {
							grpDataRow.put(SAVENAME_GRP_NM + String.valueOf(i+1), grpFullNmArr[grpFullNmArr.length-1] );
						} else {
							grpDataRow.put(SAVENAME_GRP_NM + String.valueOf(i+1), grpFullNmArr[i] );
						}
					} else {
						grpDataRow.put(SAVENAME_GRP_NM + String.valueOf(i+1), grpFullNm);	//1레벨같은경우 해당 값 넣음
					}
				}
				
				// 그룹안에 분류 for loop
				HashMap<String, Object> clsDataRow = null;
				for ( Object clsData : clsList ) {
					Map<String, Object> clsRow = (Map<String, Object>) clsData;
					clsDatano = String.valueOf( ((BigDecimal) clsRow.get("datano")).intValue() );
					String clsFullNm = (String) clsRow.get("itmFullNm");	//분류 전체경로
					String[] clsFullNmArr = clsFullNm.split(">");
					clsDataRow = new HashMap<String, Object>();
					clsDataRow.putAll(grpDataRow);	// 분류 맵에 1차 for loop인 그룹 데이터를 넣어준다.
					
					for ( int i=0; i < clsMaxLevel; i++ ) {	//분류 레벨만큼 컬럼 생성
						if ( clsFullNmArr.length > 0 ) {
							if ( (i+1) > clsFullNmArr.length) {
								clsDataRow.put(SAVENAME_CLS_NM + String.valueOf(i+1), clsFullNmArr[clsFullNmArr.length-1] );
							} else {
								clsDataRow.put(SAVENAME_CLS_NM + String.valueOf(i+1), clsFullNmArr[i] );
							}
						} else {
							clsDataRow.put(SAVENAME_CLS_NM + String.valueOf(i+1), clsFullNm);	//1레벨같은경우 해당 값 넣음
						}
					}
					clsDataRow.put("gColDatano", grpDatano);
					clsDataRow.put("cColDatano", clsDatano);
					
					setInputSheetBasisCopyDta(tMap, dummyMap, clsDataRow, grpDatano + clsDatano);
				}
			}
		}
	}
	
	@Override
	public List<Map<String, Object>> statInputVerifyData(Params params) {
		params.set("verify", "Y");
		//통계 데이터셋 연계정보 조회
		Map<String, Object> stddDscn = (Map<String, Object>) statInputDao.selectStatInputDscn(params);
		params.set("ownerCd", stddDscn.get("ownerCd"));					//대상 owner
		params.set("dsId", stddDscn.get("dsId"));					//대상 데이터셋명
		
		// 통계표 일괄 등록 파라미터 세팅
		setBatchInputParam(params);
		
		return (List<Map<String, Object>>) statInputDao.selectStatInputData(params);
	}
	
	/**
	 * 통계표 입력 검증 및 저장
	 */
	@Override
	public Result saveStatInputData(Params params) {
		int iTotalBatchCnt = 0;
		
		try {
			//통계 데이터셋 연계정보 조회
			Map<String, Object> stddDscn = (Map<String, Object>) statInputDao.selectStatInputDscn(params);
			
			// 통계표 항목의 검증코드와 정규식 확인
			List<Map<String, Object>> chckList = (List<Map<String, Object>>) statInputDao.selectStatChckRegExp(params);
			
			//분류 갯수 확인
			int clsCnt = statInputDao.selectStatInputClsCnt(params);
			
			//그룹 갯수 확인
			int grpCnt = statInputDao.selectStatInputGrpCnt(params);
					
			JSONArray jArrInput = new JSONObject(params.getJsonObject("ibsSaveJson")).getJSONArray("data");
		
			//통계데이터
			LinkedList<HashMap<String, Object>> inputList = getChgJsonArrToVerifyRawData(jArrInput, chckList);
			
			//검증 데이터 변경전 데이터 null 처리
			params.put("ownerCd", stddDscn.get("ownerCd"));						//대상 owner
			params.put("dsId", stddDscn.get("dsId"));							//대상 데이터셋명
			statInputDao.updateStatVerifyDataInit(params);
			
			/* 통계표 입력 데이터 저장 */
			statInputDao.startBatch();	//배치 시작
			for ( Map<String, Object> input : inputList ) {
				input.put("ownerCd", stddDscn.get("ownerCd"));						//대상 owner
				input.put("dsId", stddDscn.get("dsId"));							//대상 데이터셋명
				input.put("statblId", params.getString("statblId"));				//통계표 번호
				input.put("dtacycleCd", params.getString("dtacycleCd"));			//자료주기구분코드
				//input.put("wrttimeIdtfrId", params.getString("wrttimeIdtfrId"));	//자료작성시점
				input.put("clsExistYn", clsCnt > 0 ? "Y" : "N" );					//분류항목 존재여부
				input.put("grpExistYn", grpCnt > 0 ? "Y" : "N" );					//그룹항목 존재여부
				statInputDao.insertStatInputData(input);
				iTotalBatchCnt++;
				
				//BATCH_COUNT 단위로 끊어서 배치 실행
				if (iTotalBatchCnt > 0 && iTotalBatchCnt % BATCH_COUNT == 0) {
					statInputDao.executeBatch();	//배치 실행
					statInputDao.startBatch();
				}
			}
			statInputDao.executeBatch();	//배치 실행
			
			// 일괄 등록 파라미터 세팅
			setBatchInputParam(params);
			
			//통계자료작성 처리 기록(저장 상태로 log 입력)
			ArrayList<String> iterBatchWrtSeq = (ArrayList<String>) params.get("iterBatchWrtSeq");
			params.set("wrtStateCd", "PG");
			
			for ( String wrtSeq : iterBatchWrtSeq ) {
				params.set("wrtSeq", wrtSeq);
				statInputDao.insertStatInputLogWrtList(params);		
			}
		} catch (JSONException je) {
			EgovWebUtil.exTransactionLogging(je);
			return failure("시스템 오류가 발생하였습니다.");
		} catch (Exception e) {
			EgovWebUtil.exTransactionLogging(e);
			return failure("시스템 오류가 발생하였습니다.");
		}
		
		return success(getMessage("admin.message.000006"));
	}
	
	/**
	 * 통계표에서 입력한 json 데이터 list로 변환 후 검증수행
	 * 
	 * @param jArr		통계표 입력 데이터
	 * @param chckList	검증 항목
	 * @return
	 */
	public LinkedList<HashMap<String, Object>> getChgJsonArrToVerifyRawData(JSONArray jArr, List<Map<String, Object>> chckList) throws JSONException {
		
		LinkedList<HashMap<String, Object>> list = new LinkedList<HashMap<String, Object>>();
		HashMap<String, Object> map = null;
		
		for (int i = 0; i < jArr.length(); i++) {
			
        	JSONObject jObj = (JSONObject) jArr.get(i);
        	Iterator<?> keys = jObj.keys();

			while( keys.hasNext() ) {
			    String key = (String)keys.next();
			    //항목이고 값이 있을경우
			    //if ( key.indexOf("iCol_") > -1 && !jObj.get(key).equals("") ) {
			    if ( key.indexOf("iCol_") > -1 ) {	
			    	//키가 항목자료번호 컬럼인 경우
			    	map = new HashMap<String, Object>();
			    	int iItmDatano = Integer.parseInt(key.replace("iCol_", ""));
			    	map.put("itmDatano", iItmDatano);
			    	//지수인 경우 체크
			    	Object dtaVal = jObj.get(key);
			    	if ( dtaVal instanceof Double ) {
			    		map.put("dtaVal", new BigDecimal(String.valueOf(dtaVal)));
			    	} else {
			    		map.put("dtaVal", jObj.get(key));
			    	}
			    	
			    	map.put("wrttimeIdtfrId", (String) jObj.get("wrttimeIdtfrId"));
			    	map.put("dtadvsCd", (String) jObj.get("dtadvsCd"));
			    	map.put("clsDatano", jObj.get("cColDatano"));
			    	map.put("grpDatano", jObj.get("gColDatano"));
			    	
			    	if ( chckList != null ) {
			    		//검증 항목이 있을 경우 검증한다.
				    	for ( Map<String, Object> chck : chckList ) {
				    		int chckDatano = ((BigDecimal) chck.get("datano")).intValue();
				    		if ( iItmDatano == chckDatano ) {
				    			if ( !jObj.get(key).equals("") ) {
					    			String pattern = (String) chck.get("regExpPattern");		//검증식
									//String verifyVal = String.valueOf(jObj.get(key));			//검증값
									//지수인 경우 체크(정수가 8자리 이상인경우 지수형태(ex>1544213E2)로 넘어오기때문에 확인하여 변환해준다)
					    			String verifyVal = "";
							    	Object tmpVerifyVal = jObj.get(key);
							    	if ( tmpVerifyVal instanceof Double ) {
							    		BigDecimal bd = new BigDecimal(String.valueOf(tmpVerifyVal));
							    		verifyVal = bd.toString();
							    	} else {
							    		verifyVal = String.valueOf(tmpVerifyVal);
							    	}
									boolean verifyResult = Pattern.matches(pattern, verifyVal);	//검증결과
									map.put("chckCd", String.valueOf(chck.get("chckCd")));
									map.put("verifyYn", (verifyResult ? "Y":"N"));
				    			} else {
									map.put("chckCd", String.valueOf(chck.get("chckCd")));
									//map.put("verifyYn", "N");
									map.put("verifyYn", "Y");	//값이 없으면 검증 정상으로 표시(필수 입력은 시트에서 스크립트로 체크)
								}
				    		}
				    	}
			    	}
			    	list.add(i, map);
			    }
			}
		}
		
		return list;
	}
	
	/**
	 * jsonArray를 LinkedList<HashMap>으로 로 변화한다
	 * 
	 * @param jArr	변환할 jsonArray
	 * @return
	 */
	public LinkedList<HashMap<String, Object>> getChgJsonArrToList(JSONArray jArr) throws JSONException {
		/*
		String optReplaceBlank = "";
		if ( options != null ) {
			if (options.get("replaceBlank") != null) {
				optReplaceBlank = options.get("replaceBlank");
			}
		}*/
		LinkedList<HashMap<String, Object>> list = new LinkedList<HashMap<String, Object>>();
		HashMap<String, Object> map = null;
		
		for (int i = 0; i < jArr.length(); i++) {
			map = new HashMap<String, Object>();
        	JSONObject jObj = (JSONObject) jArr.get(i);
        	Iterator<?> keys = jObj.keys();

			while( keys.hasNext() ) {
			    String key = (String)keys.next();
			    //map.put( (optReplaceBlank.length() > 0 ? key.replace(optReplaceBlank, "") : key), jObj.get(key));
			    map.put(key, jObj.get(key));
			}
        	list.add(i, map);
		}
		
		return list;
	}
	
	//데이터 검증
	/*
	public boolean verifyInputData(Params params, List<HashMap<String, Object>> verifyList) {
		int failCnt = 0;
		List<HashMap<String, Object>> list = new LinkedList<HashMap<String, Object>>();
		HashMap<String, Object> map = null;
		
		//검증목록
		List<Map<String, Object>> chckList = (List<Map<String, Object>>) statInputDao.selectStatChckRegExp(params);
		
		for ( HashMap<String, Object> verify : verifyList ) {		//검증하려는 데이터 for
			for ( Map<String, Object> chck : chckList ) {	//항목별 검증코드 데이터 list
				if ( verify.containsKey( String.valueOf(chck.get("datano"))) ) {
					map = new HashMap<String, Object>();
					map = (HashMap<String, Object>) verify.clone();
					//검증하려는 키값(항목datano)이 항목별 검증코드의 datano가 있는경우
					String pattern = (String) chck.get("regExpPattern");								//검증식
					String verifyVal = String.valueOf(verify.get(String.valueOf(chck.get("datano"))));	//검증값
					boolean verifyResult = Pattern.matches(pattern, verifyVal);	//검증결과
					map.put("verify", (verifyResult ? "Y":"N"));
					//검증결과 저장로직 추가예정...
					if ( !verifyResult ) {
						failCnt++;
					}
					list.add(map);
				}
			}
		}
		
		if ( failCnt > 0 ) {
			return false;
		}
		
		return true;
	}
*/
	
	/**
	 * 통계데이터 주석 조회
	 */
	@Override
	public List<Map<String, Object>> statInputCmmtListPaging(Params params) {
		//통계 데이터셋 연계정보 조회
		Map<String, Object> stddDscn = (Map<String, Object>) statInputDao.selectStatInputDscn(params);
		params.set("ownerCd", stddDscn.get("ownerCd"));					//대상 owner
		params.set("dsId", stddDscn.get("dsId"));						//대상 데이터셋명

		// 통계표 일괄 등록 파라미터 세팅
		setBatchInputParam(params);	
		
		return statInputDao.selectStatInputCmmtList(params);
	}
	
	/**
	 * 통계표 일괄 등록 파라미터 세팅
	 * @param params
	 */
	private void setBatchInputParam(Params params) {
		// 일괄 등록 여부
		String batchYn = StringUtils.isNotEmpty(params.getString("batchYn")) && params.getString("batchYn").equals("Y") ? "Y" : "N";
		
		// 일괄 등록시 필요한 변수 정의
		ArrayList<String> iterBatchWrttimeIdtfrId = new ArrayList<String>(Arrays.asList(params.getStringArray("batchWrttimeIdtfrId")));	// 일괄 등록 시점(시계열)
		ArrayList<String> iterBatchWrttimeDesc = new ArrayList<String>(Arrays.asList(params.getStringArray("batchWrttimeDesc")));		// 일괄 등록 시점(시계열 시점 설명)
		ArrayList<String> iterBatchWrtSeq = new ArrayList<String>(Arrays.asList(params.getStringArray("batchWrtSeq")));					// 스케쥴 번호
		
		// 일괄 등록 할 경우
		if ( "Y".equals(batchYn) && iterBatchWrttimeIdtfrId.size() > 0 ) {
			/*
			params.put("iterBatchWrttimeIdtfrId", iterBatchWrttimeIdtfrId);
			params.put("iterBatchWrttimeDesc", iterBatchWrttimeDesc);
			params.put("iterBatchWrtSeq", iterBatchWrtSeq);
			*/
		}
		else {
			// 단건으로 등록 할 경우 for 문이 1번 돌아 갈 수 있도록 넣어준다.
			iterBatchWrttimeIdtfrId.add(params.getString("wrttimeIdtfrId"));
			iterBatchWrttimeDesc.add(params.getString("wrttimeDesc"));
			iterBatchWrtSeq.add(params.getString("wrtSeq"));
		}
		
		params.put("iterBatchWrttimeIdtfrId", iterBatchWrttimeIdtfrId);
		params.put("iterBatchWrttimeDesc", iterBatchWrttimeDesc);
		params.put("iterBatchWrtSeq", iterBatchWrtSeq);
	}

	/**
	 * 통계표 입력 엑셀 데이터 검증 및 저장
	 */
	@Override
	public Result saveStatInputExcelData(Params params) {
		
		int iTotalBatchCnt = 0;
		
		try {
			
			//통계 데이터셋 연계정보 조회
			Map<String, Object> stddDscn = (Map<String, Object>) statInputDao.selectStatInputDscn(params);
			
			//분류 갯수 확인
			int clsCnt = statInputDao.selectStatInputClsCnt(params);
			
			//그룹 갯수 확인
			int grpCnt = statInputDao.selectStatInputGrpCnt(params);
		
			//검증 리스트
			List<Map<String, Object>> chckList = (List<Map<String, Object>>) statInputDao.selectStatChckRegExp(params);
			
			//엑셀에서 항목값 추출한 리스트
			LinkedList<HashMap<String, Object>> excelList = readExcelFormData(params);
			
			if ( chckList != null ) {
		    	for ( Map<String, Object> chck : chckList ) {
		    		int chckDatano = ((BigDecimal) chck.get("datano")).intValue();
		    		for ( HashMap<String, Object> excel : excelList ) {
		    			if ( chckDatano == Integer.parseInt((String)excel.get("itmDatano")) ) {
			    			String pattern = (String) chck.get("regExpPattern");		//검증식
							String verifyVal = String.valueOf(excel.get("dtaVal"));		//검증값
							if ( !"".equals(verifyVal) ) {
								boolean verifyResult = Pattern.matches(pattern, verifyVal);	//검증결과
								excel.put("chckCd", String.valueOf(chck.get("chckCd")));
								excel.put("verifyYn", (verifyResult ? "Y":"N"));
							} else {
								excel.put("chckCd", String.valueOf(chck.get("chckCd")));
								excel.put("verifyYn", "Y");		//값이 없으면 검증 정상으로 표시(필수 입력은 시트에서 스크립트로 체크)
							}
		    			}
		    		}
		    	}
	    	}
			
			/* 통계표 입력 데이터 저장 */
			statInputDao.startBatch();	//배치 시작
			for ( Map<String, Object> excel : excelList ) {
				//엑셀 데이터 쓸때 셀 전체데이터를 읽어와서 실제 사용할 데이터만 사용(itmDatano가 숫자인경우 실제 사용할 데이터임)
				if ( isNumber(String.valueOf(excel.get("itmDatano"))) ) {
					excel.put("ownerCd", stddDscn.get("ownerCd"));						//대상 owner
					excel.put("dsId", stddDscn.get("dsId"));							//대상 데이터셋명
					excel.put("statblId", params.getString("statblId"));				//통계표 번호
					excel.put("dtacycleCd", params.getString("dtacycleCd"));			//자료주기구분코드
					excel.put("clsExistYn", clsCnt > 0 ? "Y" : "N" );					//분류항목갯수
					excel.put("grpExistYn", grpCnt > 0 ? "Y" : "N" );					//그룹항목갯수
					//excel.put("wrttimeIdtfrId", params.getString("wrttimeIdtfrId"));	//자료작성시점
					statInputDao.insertStatInputData(excel);
					iTotalBatchCnt++;
				}
				
				//BATCH_COUNT 단위로 끊어서 배치 실행
				if (iTotalBatchCnt > 0 && iTotalBatchCnt % BATCH_COUNT == 0) {
					statInputDao.executeBatch();	//배치 실행
					statInputDao.startBatch();
				}
			}
			
			statInputDao.executeBatch();	//배치 실행

			// 일괄 등록 파라미터 세팅
			setBatchInputParam(params);
			
			//통계자료작성 처리 기록(저장 상태로 log 입력)
			ArrayList<String> iterBatchWrtSeq = (ArrayList<String>) params.get("iterBatchWrtSeq");
			params.set("wrtStateCd", "PG");
			
			for ( String wrtSeq : iterBatchWrtSeq ) {
				params.set("wrtSeq", wrtSeq);
				statInputDao.insertStatInputLogWrtList(params);		
			}
		
			return success("저장이 완료되었습니다.");
			
		} catch (ServiceException sve) {
			//params.put("procRslt", sve.getMessage());
			EgovWebUtil.exTransactionLogging(sve);
            return failure("시스템 오류가 발생하였습니다.");
        } catch (Exception e) {
        	//params.put("procRslt", getMessage("시스템 오류가 발생하였습니다."));
        	EgovWebUtil.exTransactionLogging(e);
            return failure("시스템 오류가 발생하였습니다.");
        }
		
	}
	
	/**
	 * 통계표 입력 양식 엑셀을 읽어온다. 
	 */
	private LinkedList<HashMap<String, Object>> readExcelFormData(Params params) {
		
		String sStatblId = params.getString("statblId");
		LinkedList<HashMap<String, Object>> list = new LinkedList<HashMap<String,Object>>();	//결과 리스트
		
		//try {
			
		HashMap<String, Object> cell = null;	
		
		// 워크북을 가져온다.
        Workbook workbook;
		try {
			workbook = getWorkbook(params);
			// 시트를 가져온다.
			Sheet sheet = getSheet(workbook);
			
			//통계표 파일 체크
			if ( !sStatblId.equals(sheet.getSheetName()) ) {
				throw new ServiceException("업로드 하시는 통계표 양식이 다운받은 양식파일이 아닙니다.\n파일을 확인하세요.");
			} 
			
			Row firRow = sheet.getRow(0);	//첫번째 row
			Iterator<Cell> firRowIter = firRow.iterator();
			
			int itmStartCol = 0;	//항목 값 시작 열(실제 데이터 시작 열)
			int itmStartRow = 0;	//항목 값 시작 행(실제 데이터 시작 행)
			short startCol = firRow.getFirstCellNum();
			short endCol = firRow.getLastCellNum();
			
			//첫번째 행은 항목 기준정보 값이 들어 있음
			while (firRowIter.hasNext()) {
				Cell c = firRowIter.next();
				String val = c.getStringCellValue();
				if ( val.indexOf("10") > -1 ) {	
					//항목 값은 10000으로 시작(데이터가 몇번째 행에 있는지 체크)
					itmStartCol = c.getColumnIndex();
					break;
				}
			}
			
			Iterator<Row> iterator = sheet.iterator();
			while (iterator.hasNext()) {	//Row iter
				
				Row currentRow = iterator.next();
				//Iterator<Cell> cellIterator = currentRow.iterator();
				
				String wrttimeIdtfrId = "";	//자료시점코드(2018년, 2018상반기 등등..)
				String dtadvsCd = "";		//비교자료구분코드(원자료, 전년대비 등등)
				String clsDatano = "";		//분류자료번호(항목만 있을수도 있음)
				String grpDatano = "";		//그룹자료번호(그룹이 없을수도 있음)
				
				//while (cellIterator.hasNext()) {	//Cell iter
				for ( short i=startCol; i < endCol; i++ ) {
					//Cell currentCell = cellIterator.next();
					Cell currentCell = currentRow.getCell(i);
					if ( currentCell == null ) {
						continue;
					}
					String cellVal = UtilExcelDtChck.getCellValue(currentCell);
					
					if ( currentCell.getColumnIndex() == EXCEL_COL_IDX_WRTTIME_IDTFR_ID ) {		//컬럼이 wrttimeIdtfrId(자료시점) 인 경우
						wrttimeIdtfrId = cellVal;
					}
					if ( currentCell.getColumnIndex() == EXCEL_COL_IDX_DTADVS ) {		//컬럼이 dtadvsCd 인 경우
						dtadvsCd = cellVal;
					}
					if ( currentCell.getColumnIndex() == EXCEL_COL_IDX_GRP_DATANO ) {	//컬럼이 grpDatano 인 경우
						grpDatano = cellVal;
					}
					if ( currentCell.getColumnIndex() == EXCEL_COL_IDX_CLS_DATANO ) {	//컬럼이 clsDatano 인 경우
						if ( cellVal.indexOf(DATA_CLS_DATANO) > -1 ) {
							itmStartRow++;
						} else {
							clsDatano = cellVal;
						}
					}
					
					//현재 컬럼이 항목시작 column index보다 큰경우 && 현재 행이 항목시작 row index보다 큰 경우
					if ( itmStartCol <= currentCell.getColumnIndex() && itmStartRow <= currentRow.getRowNum() ) {
						//map 생성후 list에 쌓는다.
						cell = new HashMap<String, Object>();
						cell.put(SAVENAME_WRTTIME_IDTFR_ID, wrttimeIdtfrId);
						cell.put(DATA_CLS_DATANO, clsDatano);
						cell.put(DATA_GRP_DATANO, grpDatano);
						cell.put(SAVENAME_DTADVS_CD, dtadvsCd);
						//항목구분코드는 엑셀 첫번째 row에 있다고 가정
						String itmDatano = UtilExcelDtChck.getCellValue(firRow.getCell(i));	//(10001_Y) '_'로 구분되어 있음(split => [0] : Item 데이터 번호, [1] : 필수 입력 여부
						cell.put(DATA_ITM_DATANO, itmDatano.split("_")[0]);
						if ( "Y".equals(itmDatano.split("_")[1]) && StringUtils.isEmpty(cellVal)  ) {	//필수 입력이 Y고 값이 없으면 exception 넘김
							//itmStartRow-2가 엑셀에서 항목이 레벨단위로 있을경우 마지막 레벨의 항목 text임(itmStartRow는 항목 데이터 값 시작위치, itmStartRow-1은 항목단위
							String colDesc = UtilExcelDtChck.getCellValue(sheet.getRow(itmStartRow-2).getCell(currentCell.getColumnIndex()));	
							throw new ServiceException(colDesc + " 열은 필수 입력입니다.");
						} else {
							cell.put(DATA_DTA_VAL, cellVal);
							list.add(cell);
						}
					}
				}
			}
		} catch (EgovBizException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
        
		
		return list;
	}
	
	/**
	 * 엑셀 업로드 파일을 가져온다.
	 */
	private Workbook getWorkbook(Params params) throws EgovBizException {
		OutputStream bos = null;
        try {
            // 업로드 파일을 가져온다.
            MultipartFile file = params.getFile("uploadExcelFile");
            
            // 업로드 파일이 없는 경우
            if (file == null || file.isEmpty()) {
                throw new EgovBizException(getMessage("업로드 파일이 없습니다."));
            }
            
            if (file.getSize() > MAX_FILE_SIZE) {
                throw new EgovBizException(getMessage("업로드 파일의 크기는 " + MAX_FILE_SIZE + "바이트를 초과할 수 없습니다."));
            }
            
			String realFileNm = file.getOriginalFilename();
//			int ext = realFileNm.lastIndexOf(".");
//			String fileExt = "";
//			if(ext > -1) {
//				fileExt = realFileNm.substring(ext);
//			}
			
			String directoryPath = EgovProperties.getProperty("Globals.ExcelFileUploadTempPath");
			directoryPath = EgovWebUtil.filePathReplaceAll(directoryPath);
			
			File dir = new File(directoryPath);
			// 수정 : 권한 설정
            dir.setExecutable(true, true);
            dir.setReadable(true);
            dir.setWritable(true, true);
            
			if ( !dir.isDirectory() ) {
				dir.mkdir();
			}
			
			long time = System.currentTimeMillis(); 
			String pattern = "yyyyMMddHHmmssSSS";
			SimpleDateFormat sf = new SimpleDateFormat(pattern);
			String saveFileNm = sf.format(new Date(time)) + "_" + realFileNm;

			if(saveFileNm != null && !"".equals(saveFileNm)){
				bos = new FileOutputStream(EgovWebUtil.filePathBlackList(directoryPath + File.separator + saveFileNm));
				InputStream stream = file.getInputStream();
			    int bytesRead = 0;
			    byte[] buffer = new byte[BUFF_SIZE];
			    
			    if ( bos != null ) {
			    	while ((bytesRead = stream.read(buffer, 0, BUFF_SIZE)) != -1) {
			    		bos.write(buffer, 0, bytesRead);
			    	}
			    }
			}

			params.set("srcFileNm", realFileNm);
			params.set("saveFileNm", saveFileNm);

			return WorkbookFactory.create(file.getInputStream());
        }
        catch (IOException ioe) {
            throw new EgovBizException(getMessage("업로드 파일을 읽을 수 없습니다."));
        }
        catch (InvalidFormatException ife) {
            throw new EgovBizException(getMessage("엑셀 파일을 읽을 수 없습니다."));
        }
        catch (OutOfMemoryError oome) {
            throw new EgovBizException(getMessage("엑셀 파일을 로드할 수 없습니다."));
        } finally {
        	try {
        		if ( bos != null ) {
        			bos.close();
        		}
			} catch (IOException e) {
				EgovWebUtil.exLogging(e);
			}
        }
    }
	
	/**
	 * 엑셀 시트를 가져온다. 
	 */
	private Sheet getSheet(Workbook workbook) throws EgovBizException {
        // 시트를 가져온다.
        Sheet sheet = workbook.getSheetAt(0);
        
        // 시트가 없는 경우
        if (sheet == null) {
            throw new EgovBizException(getMessage("엑셀 파일에 시트가 없습니다."));
        }
        
        return sheet;
    }
	
	/**
	 * 입력 시트 베이스 생성(그룹과 분류가 각각 존재할 경우)
	 * @param arrDatas	전체 ARRAYLIST
	 * @param dummyMap	내부함수 파라미터
	 * @param params	사용자 파라미터
	 */
	public void setInputSheetFormBasis(ArrayList<ArrayList<String>> arrDatas, Params dummyMap, Params params) {
		ArrayList<String> arrData = null;
		List<Map<String, Object>> list = (List<Map<String, Object>>) dummyMap.get("list");			// 데이터
		List<Map<String, Object>> dtaList = (List<Map<String, Object>>) dummyMap.get("dtaList");	// 자료구분 데이터
		ArrayList<String> iterBatchWrttimeIdtfrId = (ArrayList<String>) params.get("iterBatchWrttimeIdtfrId");
		ArrayList<String> iterBatchWrttimeDesc = (ArrayList<String>) params.get("iterBatchWrttimeDesc");
		int maxLevel = ((BigDecimal) list.get(0).get("maxLevel")).intValue();
		int batchCnt = dummyMap.getInt("batchCnt");
		int listIdx = dummyMap.getInt("listIdx");
		
		for ( Object data : list ) {	// 값 만큼 for
			Map<String, Object> row = (Map<String, Object>) data;
			String sDummyYn = String.valueOf(row.get("dummyYn"));
			if ( "N".equals(sDummyYn) ) {
				for ( int j=0; j < dtaList.size(); j++ ) {
					arrData = new ArrayList<String>();
					Map<String, Object> dta = dtaList.get(j);
					arrData.add(iterBatchWrttimeIdtfrId.get(batchCnt));		// 자료시점 코드
					arrData.add(((String) dta.get(SAVENAME_DTADVS_CD)));	//통계자료코드
					arrData.add(String.valueOf( ((BigDecimal) row.get("datano")).intValue()) );		//datano
					arrData.add(String.valueOf(listIdx));					//NO
					arrData.add(iterBatchWrttimeDesc.get(batchCnt));		//자료시점	
					String sFullNm = (String) row.get("itmFullNm");		//분류 전체경로
					String[] sFullNmArr = sFullNm.split(">");
					for ( int i=0; i < maxLevel; i++ ) {	//레벨만큼 컬럼 생성
						if ( sFullNmArr.length > 0 ) {
							if ( (i+1) > sFullNmArr.length) {
								arrData.add(sFullNmArr[sFullNmArr.length-1]);
							} else {
								arrData.add(sFullNmArr[i]);
							}
						} else {
							arrData.add(sFullNm);
						}
					}
					arrData.add(((String) dta.get(SAVENAME_DTADVS_NM)));	//통계자료
					arrDatas.add(arrData);
				}
			}
		}
	}
	
	/**
	 * 입력 시트 베이스 생성(그룹과 분류가 모두 존재할 경우)
	 * @param arrDatas	전체 ARRAYLIST
	 * @param dummyMap	내부함수 파라미터
	 * @param params	사용자 파라미터
	 */
	public void setInputSheetFormBasisAll(ArrayList<ArrayList<String>> arrDatas, Params dummyMap, Params params) {
		ArrayList<String> arrData = null;
		List<Map<String, Object>> gList = (List<Map<String, Object>>) dummyMap.get("gList");		// 그룹리스트
		List<Map<String, Object>> cList = (List<Map<String, Object>>) dummyMap.get("cList");		// 분류리스트
		List<Map<String, Object>> dtaList = (List<Map<String, Object>>) dummyMap.get("dtaList");	// 자료구분리스트
		ArrayList<String> iterBatchWrttimeIdtfrId = (ArrayList<String>) params.get("iterBatchWrttimeIdtfrId");	// 자료시점
		ArrayList<String> iterBatchWrttimeDesc = (ArrayList<String>) params.get("iterBatchWrttimeDesc");		// 자료시점명
		int grpMaxLevel = ((BigDecimal) gList.get(0).get("maxLevel")).intValue();	// 그룹 최대레벨
		int clsMaxLevel = ((BigDecimal) cList.get(0).get("maxLevel")).intValue();	// 분류 최대레벨
		int batchCnt = dummyMap.getInt("batchCnt");
		int listIdx = 1;
		
		for ( Object gData : gList ) {	// 값 만큼 for
			Map<String, Object> gRow = (Map<String, Object>) gData;
			String sDummyYn = String.valueOf(gRow.get("dummyYn"));
			if ( "N".equals(sDummyYn) ) {
				for ( int j=0; j < dtaList.size(); j++ ) {
					Map<String, Object> dta = dtaList.get(j);
					String grpDatano = String.valueOf(((BigDecimal) gRow.get("datano")).intValue()); 
					
					for ( Object cData : cList ) {
						arrData = new ArrayList<String>();
						Map<String, Object> cRow = (Map<String, Object>) cData;
						
						arrData.add(iterBatchWrttimeIdtfrId.get(batchCnt));
						arrData.add(((String) dta.get(SAVENAME_DTADVS_CD)));
						arrData.add(String.valueOf( ((BigDecimal) cRow.get("datano")).intValue()) );
						arrData.add(grpDatano);	
						arrData.add(String.valueOf(listIdx++));
						arrData.add(iterBatchWrttimeDesc.get(batchCnt));
						
						//그룹 전체경로
						String grpFullNm = (String) gRow.get("itmFullNm");		
						String[] grpFullNmArr = grpFullNm.split(">");
						for ( int i=0; i < grpMaxLevel; i++ ) {	//레벨만큼 컬럼 생성
							if ( grpFullNmArr.length > 0 ) {
								if ( (i+1) > grpFullNmArr.length) {
									arrData.add(grpFullNmArr[grpFullNmArr.length-1]);
								} else {
									arrData.add(grpFullNmArr[i]);
								}
							} else {
								arrData.add(grpFullNm);
							}
						}
						
						//분류 전체경로
						String clsFullNm = (String) cRow.get("itmFullNm");		
						String[] clsFullNmArr = clsFullNm.split(">");
						for ( int i=0; i < clsMaxLevel; i++ ) {	//레벨만큼 컬럼 생성
							if ( clsFullNmArr.length > 0 ) {
								if ( (i+1) > clsFullNmArr.length) {
									arrData.add(clsFullNmArr[clsFullNmArr.length-1]);
								} else {
									arrData.add(clsFullNmArr[i]);
								}
							} else {
								arrData.add(clsFullNm);
							}
						}
						arrData.add(((String) dta.get(SAVENAME_DTADVS_NM)));
						arrDatas.add(arrData);
					}
				}
			}
		}
	}
	
	/**
	 * 통계표 입력 엑셀 양식을 다운로드 한다.
	 */
	@Override
	public ArrayList<ArrayList<String>> getStatInputSheetFormData(Params params) {
		int listIdx = 1;
		ArrayList<ArrayList<String>> arrDatas = new ArrayList<ArrayList<String>>();
		ArrayList<String> arrData = null;
		
		// 일괄 등록 여부
		String batchYn = StringUtils.isNotEmpty(params.getString("batchYn")) && params.getString("batchYn").equals("Y") ? "Y" : "N";
		
		//분류 조회
		params.set(ITM_TAG_KEY, ITM_TAG_CLS);
		List<Map<String, Object>> cList = (List<Map<String, Object>>) statInputDao.selectStatInputItm(params);
		
		//그룹 조회
		params.set(ITM_TAG_KEY, ITM_TAG_GRP);
		List<Map<String, Object>> gList = (List<Map<String, Object>>) statInputDao.selectStatInputItm(params);
		
		//통계자료코드 조회
		List<Map<String, Object>> dtaList = (List<Map<String, Object>>) statInputDao.selectStatDtadvsCd(params);
		
		/* 통계표 일괄 등록 파라미터 세팅 */
		setBatchInputParam(params);	
		
		ArrayList<String> iterBatchWrttimeIdtfrId = (ArrayList<String>) params.get("iterBatchWrttimeIdtfrId");
		ArrayList<String> iterBatchWrttimeDesc = (ArrayList<String>) params.get("iterBatchWrttimeDesc");
		
		for ( int batchCnt=0; batchCnt < iterBatchWrttimeIdtfrId.size(); batchCnt ++ ) {	
			// 그룹, 분류가 모두 있는경우
			if ( gList.size() > 0 && cList.size() > 0 ) {
				Params grpDummyMap = new Params();
				grpDummyMap.set("gList", gList);
				grpDummyMap.set("cList", cList);
				grpDummyMap.set("dtaList", dtaList);
				grpDummyMap.set("batchCnt", batchCnt);
				setInputSheetFormBasisAll(arrDatas, grpDummyMap, params);
			}	// 그룹만 있는경우
			else if ( gList.size() > 0 && cList.size() == 0 ) {
				Params grpDummyMap = new Params();
				grpDummyMap.set("list", gList);
				grpDummyMap.set("dtaList", dtaList);
				grpDummyMap.set("batchCnt", batchCnt);
				setInputSheetFormBasis(arrDatas, grpDummyMap, params);
				
			}	// 분류만 있는경우
			else if ( cList.size() > 0 ) {
				Params grpDummyMap = new Params();
				grpDummyMap.set("list", cList);
				grpDummyMap.set("dtaList", dtaList);
				grpDummyMap.set("batchCnt", batchCnt);
				setInputSheetFormBasis(arrDatas, grpDummyMap, params);
			}
			else {
				for ( Map<String, Object> dta : dtaList ) {		//통계자료구분코드는 한건이상 존재(원자료)
					arrData = new ArrayList<String>();
					arrData.add(iterBatchWrttimeIdtfrId.get(batchCnt));			// 자료시점 코드
					arrData.add(((String) dta.get(SAVENAME_DTADVS_CD)));		//통계자료코드
					arrData.add("");											//clsDatano 없음
					arrData.add(String.valueOf(listIdx++));						//NO
					arrData.add(iterBatchWrttimeDesc.get(batchCnt));			//자료시점
					arrData.add(((String) dta.get(SAVENAME_DTADVS_NM)));		//통계자료
					arrDatas.add(arrData);
				}
			}
		}
		
		return arrDatas;
	}

	/**
	 * 자료작성상태코드 변경 처리
	 */
	@Override
	public Result updateWrtstate(Params params) {
		
		
		try {
			
			String wrtStateCd = params.getString("wrtStateCd");	// 자료입력상태 처리코드(뭘 처리할것인지)
			
			// 일괄 등록 여부
			String batchYn = StringUtils.isNotEmpty(params.getString("batchYn")) && params.getString("batchYn").equals("Y") ? "Y" : "N";
			
			// 일괄 등록시 필요한 변수 정의
			ArrayList<String> iterWrtSeqs = new ArrayList<String>(Arrays.asList(params.getStringArray("wrtSeqs")));
			
			// 일괄 등록 할 경우
			if ( "Y".equals(batchYn) && iterWrtSeqs.size() > 0 ) {
				params.put("iterWrtSeqs", iterWrtSeqs);
			}
			else {
				// 단건으로 등록 할 경우 for 문이 1번 돌아 갈 수 있도록 넣어준다.
				iterWrtSeqs.add(params.getString("wrtSeq"));
				params.put("iterWrtSeqs", iterWrtSeqs);
			}
			
			//승인요청 상태일 경우 검증 데이터 오류체크
			if ( "AW".equals(wrtStateCd) ) {
				
				int verifyCnt = statInputDao.selectStatInputVerifyCnt(params);
				
				if ( verifyCnt > 0 ) {
					throw new ServiceException(String.valueOf(verifyCnt) + "건의 검증오류가 발견되었습니다.\n처리 할 수 없습니다.");
				}
			}
			
			for ( String wrtSeq : iterWrtSeqs ) {
				// 통계자료작성 처리기록 로그 등록
				params.set("wrtSeq", wrtSeq);
				statInputDao.insertStatInputLogWrtList(params);
				
				// 승인시 통계 분석자료 생성
				/*
				if ( "AC".equals(wrtStateCd) ) {
					statInputDao.execSpCreateSttsAnals(params);
				}
				*/
			}
			
			return success("처리가 완료되었습니다.");
			
		} catch(DataAccessException dae) {
			error("DataAccessException : " , dae);
			//procedure 리턴 메세지 표시.
			SQLException se = (SQLException) ((DataAccessException) dae).getRootCause();
			throw new DBCustomException(getDbmsExceptionMsg(se));	
		} catch (ServiceException sve) {
			EgovWebUtil.exTransactionLogging(sve);
			return failure("시스템 오류가 발생하였습니다.");
        } catch (Exception e) {
        	EgovWebUtil.exTransactionLogging(e);
            return failure("시스템 오류가 발생하였습니다.");
        }
	}

	/**
	 * 선택영역에 대해 통계기호를 저장한다.
	 */
	@Override
	public Result saveStatInputMark(Params params) {
		int iTotalBatchCnt = 0;
		
		try {
			//통계 데이터셋 연계정보 조회
			Map<String, Object> stddDscn = (Map<String, Object>) statInputDao.selectStatInputDscn(params);
			
			//분류 갯수 확인
			int clsCnt = statInputDao.selectStatInputClsCnt(params);
			
			//그룹 갯수 확인
			int grpCnt = statInputDao.selectStatInputGrpCnt(params);
					
			JSONArray jArrInput = new JSONObject(params.getJsonObject("ibsSaveJson")).getJSONArray("data");
		
			//통계데이터
			LinkedList<HashMap<String, Object>> inputList = getChgJsonArrToVerifyRawData(jArrInput, null);
			
			/* 통계표 입력 데이터 저장 */
			statInputDao.startBatch();	//배치 시작
			for ( Map<String, Object> input : inputList ) {
				input.put("ownerCd", stddDscn.get("ownerCd"));						//대상 owner
				input.put("dsId", stddDscn.get("dsId"));							//대상 데이터셋명
				input.put("statblId", params.getString("statblId"));				//통계표 번호
				input.put("dtacycleCd", params.getString("dtacycleCd"));			//자료주기구분코드
				//input.put("wrttimeIdtfrId", params.getString("wrttimeIdtfrId"));	//자료작성시점
				input.put("clsExistYn", clsCnt > 0 ? "Y" : "N" );					//분류항목갯수
				input.put("grpExistYn", grpCnt > 0 ? "Y" : "N" );					//그룹항목갯수
				/* 기호 입력여부(DTA_SVAL에 데이터 입력) */
				input.put("markYn", "Y");											
				statInputDao.insertStatInputData(input);
				iTotalBatchCnt++;
				
				//BATCH_COUNT 단위로 끊어서 배치 실행
				if (iTotalBatchCnt > 0 && iTotalBatchCnt % BATCH_COUNT == 0) {
					statInputDao.executeBatch();	//배치 실행
					statInputDao.startBatch();
				}
			}
			statInputDao.executeBatch();	//배치 실행
		} catch (JSONException je) {
			EgovWebUtil.exTransactionLogging(je);
			return failure("시스템 오류가 발생하였습니다.");	
		} catch (Exception e) {
			EgovWebUtil.exTransactionLogging(e);
			return failure("시스템 오류가 발생하였습니다.");
		}
		
		return success(getMessage("admin.message.000006"));
	}

	/**
	 * 숫자형식인지 체크
	 * @param str
	 * @return	숫자여부
	 */
	private boolean isNumber(String str){
        boolean result = false;
         
        try{
            Double.parseDouble(str) ;
            result = true ;
            
        }catch(NullPointerException npe ){
			EgovWebUtil.exLogging(npe);
        }catch(NumberFormatException nfe ){
        	EgovWebUtil.exLogging(nfe);
        }catch(Exception e){
        	EgovWebUtil.exLogging(e);
        }
         
        return result ;
    }

	/**
	 * 통계값 주석 저장
	 */
	@Override
	public Result saveStatInputCmmtData(Params params) {
		
		try {
			//통계 데이터셋 연계정보 조회
			Map<String, Object> stddDscn = (Map<String, Object>) statInputDao.selectStatInputDscn(params);
			
			JSONArray jArr = new JSONObject(params.getJsonObject("ibsSaveJson")).getJSONArray("data");
		
			//주석데이터
			LinkedList<HashMap<String, Object>> cmmtList = getChgJsonArrToList(jArr);
			
			//주석데이터 저장
			for ( Map<String, Object> cmmt : cmmtList ) {
				cmmt.put("statblId", params.getString("statblId"));
				cmmt.put("ownerCd", stddDscn.get("ownerCd"));					//대상 owner
				cmmt.put("dsId", stddDscn.get("dsId"));							//대상 데이터셋명
				statInputDao.saveStatInputDataCmmt(cmmt);
			}
		} catch (JSONException je) {
			EgovWebUtil.exTransactionLogging(je);
			return failure("시스템 오류가 발생하였습니다.");	
		} catch (Exception e) {
			EgovWebUtil.exTransactionLogging(e);
			return failure("시스템 오류가 발생하였습니다.");
		}
		
		return success(getMessage("admin.message.000006"));
	}

	/**
	 * 자료시점 주석 조회
	 */
	@Override
	public Record selectSttsTblDif(Params params) {
		return statInputDao.selectSttsTblDif(params);
	}
	
	/**
	 * 자료시점 주석 머지처리
	 */
	@Override
	public Result saveStatInputDifData(Params params) {
		try {
			statInputDao.saveSttsTblDif(params);
		} catch (DataAccessException dae) {
			EgovWebUtil.exTransactionLogging(dae);
			return failure("시스템 오류가 발생하였습니다.");		
		} catch (Exception e) {
			EgovWebUtil.exTransactionLogging(e);
			return failure("시스템 오류가 발생하였습니다.");
		}
		return success(getMessage("admin.message.000006"));
	}
	
	/**
	 * 통계자료작성 처리기록 팝업 리스트 조회
	 */
	@Override
	public List<Record> selectStatLogSttsWrtList(Params params) {
		params.set("wrttimeIdtfrIdArr", new ArrayList<String>(Arrays.asList(params.getStringArray("wrttimeIdtfrId"))));
		return statInputDao.selectStatLogSttsWrtList(params);
	}
}


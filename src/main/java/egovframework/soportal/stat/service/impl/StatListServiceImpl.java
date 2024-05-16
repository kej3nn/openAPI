package egovframework.soportal.stat.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.stat.service.impl.StatPreviewDao;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.constants.ModelAttribute;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;
import egovframework.common.base.service.BaseService;
import egovframework.common.helper.Exceldownheler;
import egovframework.common.util.UtilTree;
import egovframework.soportal.stat.service.StatListService;
import egovframework.soportal.stat.web.StatListController;

/**
 * 통계표를 관리하는 서비스 클래스
 * @author	김정호
 * @version 1.0
 * @since   2017/05/25
 */

@Service(value="statListService")
public class StatListServiceImpl extends BaseService implements StatListService {
	
	/**
	 * 통계표 태그 값
	 */
	protected static final String TBL_STATBL_TAG = "T";
	public static final String DTACYCLE_YEAR = "YY";		//검색주기 [년]
	public static final String DTACYCLE_HARF = "HY";		//검색주기 [반기]
	public static final String DTACYCLE_QUARTER = "QY";		//검색주기 [분기]
	public static final String DTACYCLE_MONTH = "MM";		//검색주기 [월]

	@Resource(name="statListDao")
	protected StatListDao statListDao;
	
	@Resource(name="statPreviewDao")
	public StatPreviewDao statPreviewDao;
	
	/**
     * XLS 다운로더
     */
    @Autowired
    private Exceldownheler excelDownhelper;

	private static final String OPT_LOC_HEAD = "H";		//표두
	private static final String OPT_LOC_LEFT = "L";		//표측
	private static final String OPT_LOC_NOUSE = "N";	//사용안함
	
	private static final String OPT_CODE_SI = "SI";		//통계표 위치 옵션(항목)
	private static final String OPT_CODE_SC = "SC";		//통계표 위치 옵션(분류)
	private static final String OPT_CODE_SG = "SG";		//통계표 위치 옵션(그룹)
	private static final String OPT_CODE_ST = "ST";		//통계표 위치 옵션(시계열)
	private static final String WRT_STATE_CD_AC = "AC";	//통계표 승인코드(승인되기 전 상태)
	private static final int ROW_CNT_WRTTIME = 1;		//자료시점(시계열) sheet row 갯수
	private static final int ROW_CNT_UI = 1;			//단위 sheet row 갯수
	private static final int ROW_CNT_DTADVS = 1;		//통계자료 sheet row 갯수
	private static final String DEF_VIEW_OPTION_TSSUM_LOC_FIRST = "F";	//기본보기 옵션(시계열 합계 출력 위치 처음)
	private static final String DEF_VIEW_OPTION_TSSUM_LOC_LAST = "L";	//기본보기 옵션(시계열 합계 출력 위치 마지막)
	
	private static final String ITM_ITM_KEYNM = "ITM";	//시트 항목 컬럼 접두어
	private static final String ITM_CLS_KEYNM = "CATE";	//시트 분류 컬럼 접두어
	private static final String ITM_GRP_KEYNM = "GRP";	//시트 그룹 컬럼 접두어
	
	private static final String STAT_CELL_STYLE_CMMT = "color: blue;font-weight: bold;font-size:x-small;";	//주석 셀 스타일
	private static final String STAT_CELL_STYLE_WRT_STATE_AC = "background-color: #F5D0A9;";				//통계표 미승인 셀 스타일
	
	public static final int MAX_CHK_ITM = 500;	// 트리 체크 제한 갯수
	
	//공통코드 값을 조회한다.
	@SuppressWarnings("unchecked")
	public List<Record> selectOption(Params params) {
		List<Record> result = new ArrayList<Record>();
		try {
			result = (List<Record>)statListDao.selectOption(params);
		}  catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		
		return result;
	}

	//통계 공통코드 값을 조회한다.
	@SuppressWarnings("unchecked")
	public List<Record> selectSTTSOption(Params params) {
		List<Record> result = new ArrayList<Record>();
		try {
			result = (List<Record>)statListDao.selectSTTSOption(params);
		}  catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return result;
	}
	
	/**
	 * 통계표 검색주기 조회
	 */
	public List<Record> statDtacycleList(Params params) {
		List<Record> result = new ArrayList<Record>();
		try {
			result = (List<Record>)statListDao.statDtacycleList(params);
		}  catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return result;
	}

	/*
	 * 자료시점 조회
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Record> statWrtTimeOption(Params params) {
		List<Record> result = new ArrayList<Record>();
		try {
			List<Record> resultOptDC = (List<Record>) statListDao.selectStatTblOptVal(params);
			if ( resultOptDC.size() > 0 ) {
				params.put("dtacycleCd", resultOptDC.get(0).getString("optVal"));
			}
			
			// 복수통계에서 여러개의 통계표가 넘어올경우 사용한다.
			String statblIds = params.getString("statblIds");
			if ( StringUtils.isNotBlank(statblIds) && statblIds.indexOf("|") > 0 ) {
				ArrayList<String> arrStatblId = new ArrayList<String>(Arrays.asList(statblIds.split("\\|")));
				params.set("statblIds", arrStatblId);
			}
			
			result = (List<Record>) statListDao.selectStatWrtTimeOption(params);			
		}  catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return result;
	}

	/*
	 * 자료시점 조회[월/분기 시작년월/분기 및 종료년월/분기]
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Record> statQrtTimeOption(Params params) {
		List<Record> result = new ArrayList<Record>();
		try {
			List<Record> resultOptDC = (List<Record>) statListDao.selectStatTblOptVal(params);
			if ( resultOptDC.size() > 0 ) {
				params.put("dtacycleCd", resultOptDC.get(0).getString("optVal"));
			}
			
			result = (List<Record>) statListDao.selectStatQrtTimeOption(params);
		}  catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		
		return result;
	}
	
	
	
	/**
	 * 통계표 단위 조회
	 */
	public List<Record> statTblUi(Params params) {
		List<Record> result = new ArrayList<Record>();
		try {
			result = (List<Record>) statListDao.selectStatTblUi(params);
		}  catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return result;
	}

	/**
	 * 통계표 통계자료유형 조회
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Record> statTblDtadvs(Params params) {
		List<Record> result = new ArrayList<Record>();
		try {
			result = (List<Record>) statListDao.selectStatTblDtadvs(params);
			
		}  catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return result;
	}
	
	/**
	 * 통계표 관리 메인 리스트 조회
	 */
	public List<Map<String, Object>> statEasyList(Params params) {
		getMainSearchParam(params);		//메인화면 리스트 조회 파라미터 설정
		List<Record> jList = new ArrayList<Record>();
		try {
			jList = statListDao.statEasyList(params);
		}  catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}


		return UtilTree.convertorTreeData(jList, "T", "statblId", "parStatblId", "statblNm", "statblTag", "vOrder");
	}
	
	/**
	 * 통계표 전체 리스트 조회(전체 리스트 엑셀 다운받을경우 사용)
	 */
	public List<Record> statEasyOriginList(Params params) {
		getMainSearchParam(params);		//메인화면 리스트 조회 파라미터 설정
		List<Record> result = new ArrayList<Record>();
		try {
			result = statListDao.statEasyList(params);
		}  catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return result;
	}
	
	/**
	 * 통계표 관리 인기통계 리스트 조회
	 */
	public List<Map<String, Object>> statHitList(Params params) {
		getMainSearchParam(params);		//메인화면 리스트 조회 파라미터 설정
		
		List<Map<String, Object>> jlist = new ArrayList<Map<String,Object>>();
		try {
			jlist = statListDao.statHitList(params);
			if (jlist.size() > 0) {
				for ( Map<String, Object> data : jlist ) {
					if ( "1".equals(String.valueOf(data.get("Level"))) ) {
						//1레벨만 트리 열리도록 수정
						data.put("open", "true");
					}
				}
			}
			
		} catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}

		return jlist;
	}
	
	/**
	 * 통계표 관리 최신통계 리스트 조회
	 */
	public List<Record> statNewList(Params params) {
		List<Record> result = new ArrayList<Record>();
		try {
			result = (List<Record>) statListDao.statNewList(params);
		}  catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return result;
	}
	
	/**
	 * 메인화면 통계표 모바일 리스트 조회
	 */
	public Paging statMobileListPaging(Params params) {
		getMainSearchParam(params);		//메인화면 리스트 조회 파라미터 설정
		Paging result = new Paging();
		try {
			result = (Paging) statListDao.statEasyMobileList(params, params.getPage(), params.getRows());
		} catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return result;
	}
	
	/**
	 * 메인화면 통계표 검색결과 리스트 조회
	 */
	public List<Record> statEasySearchList(Params params) {
		getMainSearchParam(params);		//메인화면 리스트 조회 파라미터 설정
		List<Record> result = new ArrayList<Record>();
		try {
			result = (List<Record>) statListDao.statEasySearchList(params);
		}  catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return result;
	}
	
	/**
	 * 메인화면 리스트 조회 파라미터 설정
	 * @param params
	 */
	private void getMainSearchParam(Params params) {
		// 조회시 시스템 체크 여부
		if (!StringUtils.isEmpty(params.getString("korYn"))
				|| !StringUtils.isEmpty(params.getString("engYn"))
				|| !StringUtils.isEmpty(params.getString("korMobileYn"))
				|| !StringUtils.isEmpty(params.getString("engMobileYn"))) {
			params.set("systemExist", "Y");
		}

		// 조회시 작성주기 체크 여부
		if (!StringUtils.isEmpty(params.getString("YYdtacycleYn"))
				|| !StringUtils.isEmpty(params.getString("HYdtacycleYn"))
				|| !StringUtils.isEmpty(params.getString("QYdtacycleYn"))
				|| !StringUtils.isEmpty(params.getString("MMdtacycleYn"))) {
			params.set("dtacycleExist", "Y");
		}

		// 명칭별(키워드)검색 시 자음 쿼리문 생성
		if (!StringUtils.isEmpty(params.getString("searchKeywordVal"))) {
			Record r = getChosungConvert(params.getString("searchKeywordVal"));
			params.put("searchKeywordVal", r.getString("chosungVal")); // 초성 쿼리문으로 Convert
			params.put("isKeywordEtc", r.getString("isKeywordEtc")); // 키워드 기타 선택 여부
		}
		
		if (!StringUtils.isEmpty(params.getString("searchVal"))) {
			//띄어쓰기에 따라 키워드를 배열로 전환한다.
			String[] arrIterKeywords = params.getString("searchVal").split("\\s+");
			params.put("arrIterKeywords", arrIterKeywords.length);
			params.set("iterKeywords", arrIterKeywords);
		}
		
	}

	/**
	 * 통계표 관리 상세 조회
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectStatDtl(Params params) {
		Map<String, Object> rMap = new HashMap<String, Object>();
		Map<String, Object> dataMap = new HashMap<String, Object>();
		
		try {
			dataMap.put("OPT_DATA", (List<Map<String, Object>>) statListDao.selectStatDtlOpt(params));		//통계표 옵션정보 조회
			dataMap.put("SCHL_DATA", (List<Map<String, Object>>) statListDao.selectStatDtlSchl(params));	//통계자료 작성일정 조회
			if(params.getString("metaCallYn").equals("Y")){
				// 주기
				Params optParam = new Params();
				optParam.set("statblId", params.getString("statblId"));
				optParam.set("optCd", "DC");
				List<Record> resultOptDC = (List<Record>) statListDao.selectStatTblOptVal(optParam);
				params.set("dtacycleCd", resultOptDC.get(0).getString("optVal"));
				
				dataMap.put("CMMT_DATA", (List<Map<String, Object>>) statListDao.selectStatCmmtList(params));	//통계자료 주석정보 조회
			}
			
			rMap.put("DATA", statListDao.selectStatDtl(params));
			if(params.getString("metaCallYn").equals("Y")){
				rMap.put("META_DATA", statListDao.selectStatSttsMeta(params));	//통계 메타 데이터
			}
			rMap.put("DATA2", dataMap);
		}  catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}

		return rMap;
	}

	/**
	 * 통계표 항목분류 리스트 조회
	 */
	public List<Record> statItmJson(Params params) {
		List<Record> result = new ArrayList<Record>();
		try {
			result = (List<Record>) statListDao.statItmJson(params);
		}  catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return result;
	}
	
	private Params getStatDefaultCond(Params params) {
		params.set("viewLocOpt", "B");
		params.set("wrttimeType", "L");
		
		Params optParam = new Params();
		optParam.set("statblId", params.getString("statblId"));
		optParam.set("optCd", "TN");
		List<Record> resultOptTN = (List<Record>) statPreviewDao.selectStatTblOptVal(optParam);
		params.set("wrttimeLastestVal", resultOptTN.get(0).getString("optVal"));	//최근시점 갯수
		
		optParam.set("optCd", "TO");
		List<Record> resultOptTO = (List<Record>) statPreviewDao.selectStatTblOptVal(optParam);
		params.set("wrttimeOrder", ( resultOptTO.size() > 0 ? resultOptTO.get(0).getString("optVal") : "A" ));				// 검색자료주기(오름/내림)
		
		optParam.set("optCd", "DC");
		List<Record> resultOptDC = (List<Record>) statPreviewDao.selectStatTblOptVal(optParam);
		params.set("dtacycleCd", resultOptDC.get(0).getString("optVal"));	//검색자료주기
		
		List<Record> resultDta = statWrtTimeOption(optParam);
		if ( resultDta.size() > 0 ) {
			params.set("wrttimeMinYear", resultDta.get(0).getString("code"));						//기간 년도 최소값
			params.set("wrttimeMaxYear", resultDta.get(resultDta.size() - 1).getString("code"));	//기간 년도 최대값
		}
		
		String dcOptVal = resultOptDC.get(0).getString("optVal");	//주기에 따른 시점
		if ( "YY".equals(dcOptVal) ) {		//년
			params.set("wrttimeMinQt", "00");		//기간 시점 최소값
			params.set("wrttimeMaxQt", "00");		//기간 시점 최대값
		} else if ( "HY".equals(dcOptVal) ) {	//반기
			params.set("wrttimeMinQt", "01");		
			params.set("wrttimeMaxQt", "02");		
		} else if ( "QY".equals(dcOptVal) ) {	//분기
			params.set("wrttimeMinQt", "01");		
			params.set("wrttimeMaxQt", "04");
		} else if ( "MM".equals(dcOptVal) ) {	//월
			params.set("wrttimeMinQt", "01");		
			params.set("wrttimeMaxQt", "12");
		}
		
		Params r = new Params();
		r = (Params) params.clone();
		return r;
	}

	/**
	 * 시트 헤더 설정
	 * @param params
	 * @return	
	 * 		맵객체가 리턴되며 
	 * 			Text		: 헤더Text를 뿌려줄 arrayList
	 * 			Cols		: ibsheet의 컬럼정보 세팅값
	 * 			cmmtRowCol 	: 통계표 주석 row, col 위치 저장 리스트
	 * 			dtadvsLoc	: 통계자료 위치와 순서 저장 맵
	 * 			statCond	: 기본 파라미터 조회조건 정보(deviceType이 모바일(M)로 넘어왔을 경우이거나, 조회 타입이 StatblId(S)통계표 조회로 바로 넘어온 경우)
	 */
	@Override
	public Map<String, Object> statTblItm(Params params) {
		String strGroupTxt = getMessage("stat.ko.group", "그룹");
		Map<String, Object> map = new HashMap<String, Object>();
		Params statCond = null;
		//deviceType이 모바일(M)로 넘어왔을 경우이거나, 조회 타입이 StatblId(S)통계표 조회로 바로 넘어온 경우
		if ( (StringUtils.isNotEmpty(params.getString("deviceType")) && params.getString("deviceType").equals("M"))
			|| (StringUtils.isNotEmpty(params.getString("searchType")) && params.getString("searchType").equals("S"))
		) {
			//기본 조회값을 넘겨준다.
			statCond = getStatDefaultCond(params);
		}
		String sheetLoc = OPT_LOC_HEAD;		//헤더 설정하는 중..
		params.set("SheetLoc", sheetLoc);

		int iMaxLevel = 0;		//항목 레벨(headText row 수)
		int iCateCnt = 0;			//분류 갯수
		int iItmCnt = 0;			//항목 갯수
		int iGrpCnt = 0;			//그룹 갯수
		String stLoc = "N";
		String siLoc = "N";
		String scLoc = "N";
		String sgLoc = "N";
		
		String defViewOptionUiYn = "N";		//기본보기 옵션(항목 단위 출력 여부)
		String defViewOptionTSSumLoc = "N";	//기본보기 옵션(시계열 합계 출력 위치 'S1005 => F:처음, L:마지막, N:없음')
		String dtadvsODUse = "N";			//통계자료가 원자료만 사용하는지 확인
		int dtadvsRowColCnt = 0;			//원자료만 사용하는경우 컬럼/행 위치
		int uiRowCnt = 0;					//단위 row위치
		
		//보기 옵션에 따른 시트 위치 재설정
		Map<String, String> locMap = setLocOptParams(params, OPT_LOC_HEAD);	
		for ( String key : locMap.keySet() ) {
			if ( OPT_CODE_ST.equals(key) ) {
				stLoc = locMap.get(key);
			} else if ( OPT_CODE_SC.equals(key) ) {
				scLoc = locMap.get(key);
			} else if ( OPT_CODE_SI.equals(key) ) {
				siLoc = locMap.get(key);
			} else if ( OPT_CODE_SG.equals(key) ) {
				sgLoc = locMap.get(key);	
			}
		}
		//기본보기 옵션(항목단위 출력여부 조회)
		params.set("optCd", "IU");
		try {
			List<Record> defViewOptionIU = (List<Record>) statListDao.selectStatTblOptVal(params);
			if ( defViewOptionIU.size() > 0 ) {
				defViewOptionUiYn = defViewOptionIU.get(0).getString("optVal");
			}
			
			//기본보기 옵션(시계열 합계 출력 위치)
			params.set("optCd", "TL");
			List<Record> defViewOptionTL = (List<Record>) statListDao.selectStatTblOptVal(params);
			if ( defViewOptionTL.size() > 0 ) {
				defViewOptionTSSumLoc = defViewOptionTL.get(0).getString("optVal");	//F:처음, L:마지막, N:없음
			}
			//통계자료 string[] => ibatis에서 사용하기 위해 array로 변경
			ArrayList<String> iterDtadvsVal = new ArrayList<String>(Arrays.asList(params.getStringArray("dtadvsVal")));
			params.set("iterDtadvsVal", iterDtadvsVal);
			//항목선택 string[] => ibatis에서 사용하기 위해 array로 변경
			ArrayList<String> iterChkItms = new ArrayList<String>(Arrays.asList(params.getStringArray("chkItms")));
			params.set("iterChkItms", iterChkItms);
			//분류선택 string[] => ibatis에서 사용하기 위해 array로 변경
			ArrayList<String> iterChkClss = new ArrayList<String>(Arrays.asList(params.getStringArray("chkClss")));
			params.set("iterChkClss", iterChkClss);
			//그룹선택 string[] => ibatis에서 사용하기 위해 array로 변경
			ArrayList<String> iterChkGrps = new ArrayList<String>(Arrays.asList(params.getStringArray("chkGrps")));
			params.set("iterChkGrps", iterChkGrps);
			
			List<HashMap<String, Object>> cols = new LinkedList<HashMap<String, Object>>();		//ibsheet 컬럼 정보
			ArrayList<Object> gridTxt = new ArrayList<Object>();								//ibsheet headText 정보
			ArrayList<String> colTxt = null;
			
			//헤더정보 조회
			List<Record> list = (List<Record>) statListDao.selectStatTblItm(params);	
			
			/**
			 * 기본적으로 생성되는 시트 헤더정보 
			 */
			//시트 location에 따라 max레벨 증가
			if ( sheetLoc.equals(stLoc) ) {
				iMaxLevel = iMaxLevel + ROW_CNT_WRTTIME;
			} 
			if ( sheetLoc.equals(scLoc) ) {
				iMaxLevel = iMaxLevel + list.get(0).getInt("maxClsLevel");
			} 
			if ( sheetLoc.equals(sgLoc) ) {
				iMaxLevel = iMaxLevel + list.get(0).getInt("maxGrpLevel");
			} 
			if ( sheetLoc.equals(siLoc) ) {
				if ( "Y".equals(defViewOptionUiYn) ) {
					iMaxLevel = iMaxLevel + list.get(0).getInt("maxItmLevel") + ROW_CNT_UI + ROW_CNT_DTADVS;
				} else {
					iMaxLevel = iMaxLevel + list.get(0).getInt("maxItmLevel") + ROW_CNT_DTADVS;
				}
			} 
			
			//위치가 전부 표측일경우 or 위치가 전부 표측일경우(그룹, 분류 사용 안할 경우)
			if ( (OPT_LOC_LEFT.equals(stLoc) && OPT_LOC_LEFT.equals(scLoc) && OPT_LOC_LEFT.equals(siLoc) && OPT_LOC_LEFT.equals(sgLoc)) 					
					|| (OPT_LOC_LEFT.equals(stLoc) && OPT_LOC_NOUSE.equals(scLoc) && OPT_LOC_LEFT.equals(siLoc) && OPT_LOC_NOUSE.equals(sgLoc))
					|| (OPT_LOC_LEFT.equals(stLoc) && OPT_LOC_LEFT.equals(scLoc) && OPT_LOC_LEFT.equals(siLoc) && OPT_LOC_NOUSE.equals(sgLoc))
					|| (OPT_LOC_LEFT.equals(stLoc) && OPT_LOC_NOUSE.equals(scLoc) && OPT_LOC_LEFT.equals(siLoc) && OPT_LOC_LEFT.equals(sgLoc)) ) {
				iMaxLevel = 1;
			}
			
			gridTxt.add(sheetInputColTxt(iMaxLevel, "No"));
			cols.add( addSheetCol("Seq", "seq", 30, "Center", true));
			
			if ( OPT_LOC_HEAD.equals(stLoc) && OPT_LOC_HEAD.equals(siLoc) && OPT_LOC_HEAD.equals(scLoc) && OPT_LOC_HEAD.equals(sgLoc) ) {
				//방향이 표두이거나 옵션에서 가로로보기 했을 경우
				if( (StringUtils.isNotEmpty(params.getString("langGb")) && params.getString("langGb").equals("ENG"))){
					gridTxt.add(sheetInputColTxt(iMaxLevel, "Statistical Value"));
				}else{
					gridTxt.add(sheetInputColTxt(iMaxLevel, "통계값"));
				}
				cols.add( addSheetCol("Text", "COL_dtaVal", 90, "Center", true) );
			}
			
			//설정 위치에 따라 표측에 존재할 경우 ibsheet 컬럼 생성
			if ( OPT_LOC_LEFT.equals(stLoc) ){	//시계열
				if( (StringUtils.isNotEmpty(params.getString("langGb")) && params.getString("langGb").equals("ENG"))){ 
					gridTxt.add(sheetInputColTxt(iMaxLevel, "Data Time"));
				}else{
					gridTxt.add(sheetInputColTxt(iMaxLevel, "자료시점"));
				}
				cols.add( addSheetCol("Html", "wrttimeId", 120, "Center", true));
			}
			
			if ( OPT_LOC_LEFT.equals(sgLoc) ){	//그룹
				int leftColCnt = ((BigDecimal) list.get(0).get("maxGrpLevel")).intValue();
				for ( int i=0; i < leftColCnt; i++ ) {				
					gridTxt.add(sheetInputColTxt(iMaxLevel, strGroupTxt));
					cols.add( addSheetCol("Html", ITM_GRP_KEYNM + String.valueOf(++iGrpCnt), 110, "Left", true));
				}
			}
			
			if ( OPT_LOC_LEFT.equals(scLoc) ){	//분류
				int leftColCnt = ((BigDecimal) list.get(0).get("maxClsLevel")).intValue();
				for ( int i=0; i < leftColCnt; i++ ) {		
					if( (StringUtils.isNotEmpty(params.getString("langGb")) && params.getString("langGb").equals("ENG"))){ 
						gridTxt.add(sheetInputColTxt(iMaxLevel, "Classification"));
					}else{
						gridTxt.add(sheetInputColTxt(iMaxLevel, "분류"));
					}
					cols.add( addSheetCol("Html", ITM_CLS_KEYNM + String.valueOf(++iCateCnt), 110, "Left", true));
				}
			}
			
			if ( OPT_LOC_LEFT.equals(siLoc) ){	//항목
				int leftColCnt = ((BigDecimal) list.get(0).get("maxItmLevel")).intValue();
				for ( int i=0; i < leftColCnt; i++ ) {		
					if( (StringUtils.isNotEmpty(params.getString("langGb")) && params.getString("langGb").equals("ENG"))){
						gridTxt.add(sheetInputColTxt(iMaxLevel, "Items"));
					}else{
						gridTxt.add(sheetInputColTxt(iMaxLevel, "항목"));
					}
					cols.add( addSheetCol("Html", ITM_ITM_KEYNM + String.valueOf(++iItmCnt), 110, "Left", true));
				}
				
				//단위는 기본보기 옵션에 따라 출력여부 표시하고 통계자료는 항목이 있을경우 따라다닌다.
				if ( "Y".equals(defViewOptionUiYn) ) {
					if( (StringUtils.isNotEmpty(params.getString("langGb")) && params.getString("langGb").equals("ENG"))){
						gridTxt.add(sheetInputColTxt(iMaxLevel, "Unit"));
					}else{
						gridTxt.add(sheetInputColTxt(iMaxLevel, "단위"));
					}
					cols.add( addSheetCol("Text", "uiNm", 60, "Center", false) );		//단위
				}
				if( (StringUtils.isNotEmpty(params.getString("langGb")) && params.getString("langGb").equals("ENG"))){
					gridTxt.add(sheetInputColTxt(iMaxLevel, "Statistics"));
				}else{
					gridTxt.add(sheetInputColTxt(iMaxLevel, "통계자료"));
				}
				cols.add( addSheetCol("Text", "dtadvsNm", 120, "Left", true) );	//통계자료
				
				dtadvsRowColCnt = gridTxt.size() - 1;	//현재 통계자료 row 위치
				
				//시계열 위치가 앞쪽인 경우 합계 표시
				if ( DEF_VIEW_OPTION_TSSUM_LOC_FIRST.equals(defViewOptionTSSumLoc) ) {
					if( (StringUtils.isNotEmpty(params.getString("langGb")) && params.getString("langGb").equals("ENG"))){
						gridTxt.add(sheetInputColTxt(iMaxLevel, "Total"));
					}else{
						gridTxt.add(sheetInputColTxt(iMaxLevel, "합계"));
					}
					cols.add( addSheetCol("Text", "itmSum", 90, "Right", false) );		//합계
				}
			}
			
			if ( "T".equals(params.getString("viewLocOpt")) ) {
				//표로 보기 할 경우 컬럼 추가
				if( (StringUtils.isNotEmpty(params.getString("langGb")) && params.getString("langGb").equals("ENG"))){
					gridTxt.add(sheetInputColTxt(iMaxLevel, "Period"));
				}else{
					gridTxt.add(sheetInputColTxt(iMaxLevel, "주기"));
				}
				cols.add( addSheetCol("Text", "tsViewCol", 120, "Center", true) );
			}
			
			/**
			 * 동적으로 생성되는 시트 헤더정보 for 
			 */
			for ( Record r : list ) {
				colTxt = new ArrayList<String>();
				cols.add( addSheetCol("Html", r.getString("sheetKey"), 90, "Right", false) );	//쿼리에서 생성되는 컬럼키 입력
				
				if ( sheetLoc.equals(stLoc) ) {	//시계열(자료시점)
					params.put("wrttimeId", r.getString("wrttimeId"));
					String wrttimeCmtIdtfr = r.getString("wrttimeCmtIdtfr");
					colTxt.add(r.getString("wrttimeNm") + ( wrttimeCmtIdtfr == "" ? "" : "^" + wrttimeCmtIdtfr + ")" ) );
				}
				
				if ( sheetLoc.equals(sgLoc) ) {	// 그룹
					//레벨에 따라 text 입력
					String[] arrFullnm = r.getString("grpFullnm").split(">");
					int level = r.getInt("grpLevel");
					int maxLevel = r.getInt("maxGrpLevel");
					
					String fullCmmtIdtfr = r.getString("grpFullCmmtIdtfr");
					String[] arrFullCmmtIdtfr = {};
					if ( !"".equals(fullCmmtIdtfr) ) {
						arrFullCmmtIdtfr = fullCmmtIdtfr.split(">");
					}
					
					for ( int i=0; i < maxLevel; i++ ) {
						if ( level > i ) {
							if ( arrFullCmmtIdtfr.length > i ) {	
								colTxt.add(arrFullnm[i] + ( "".equals(arrFullCmmtIdtfr[i]) ? "" : "^" + arrFullCmmtIdtfr[i] ) );	//통계표 주석이 있는 경우 '^' 표시
							} else {
								colTxt.add(arrFullnm[i]);
							}
						} else {
							if ( arrFullCmmtIdtfr.length > i ) {
								colTxt.add(arrFullnm[arrFullnm.length-1] + ( "".equals(arrFullCmmtIdtfr[i]) ? "" : "^" + arrFullCmmtIdtfr[i] ) );	//통계표 주석이 있는 경우 '^' 표시
							} else {
								colTxt.add(arrFullnm[arrFullnm.length-1]);
							}
						}
					}
				}
				
				if ( sheetLoc.equals(scLoc) ) {	//분류
					//레벨에 따라 text 입력
					String[] arrFullnm = r.getString("clsFullnm").split(">");
					int level = r.getInt("clsLevel");
					int maxLevel = r.getInt("maxClsLevel");
					
					String fullCmmtIdtfr = r.getString("clsFullCmmtIdtfr");
					String[] arrFullCmmtIdtfr = {};
					if ( !"".equals(fullCmmtIdtfr) ) {
						arrFullCmmtIdtfr = fullCmmtIdtfr.split(">");
					}
					
					for ( int i=0; i < maxLevel; i++ ) {
						if ( level > i ) {
							if ( arrFullCmmtIdtfr.length > i ) {	
								colTxt.add(arrFullnm[i] + ( "".equals(arrFullCmmtIdtfr[i]) ? "" : "^" + arrFullCmmtIdtfr[i] ) );	//통계표 주석이 있는 경우 '^' 표시
							} else {
								colTxt.add(arrFullnm[i]);
							}
						} else {
							if ( arrFullCmmtIdtfr.length > i ) {
								colTxt.add(arrFullnm[arrFullnm.length-1] + ( "".equals(arrFullCmmtIdtfr[i]) ? "" : "^" + arrFullCmmtIdtfr[i] ) );	//통계표 주석이 있는 경우 '^' 표시
							} else {
								colTxt.add(arrFullnm[arrFullnm.length-1]);
							}
						}
					}
				}
				
				if ( sheetLoc.equals(siLoc) ) {	//항목
					//레벨에 따라 text 입력
					String[] arrFullnm = r.getString("itmFullnm").split(">");
					int level = r.getInt("itmLevel");
					int maxLevel = r.getInt("maxItmLevel");
					
					String fullCmmtIdtfr = r.getString("itmFullCmmtIdtfr");
					String[] arrFullCmmtIdtfr = {};
					if ( !"".equals(fullCmmtIdtfr) ) {
						arrFullCmmtIdtfr = fullCmmtIdtfr.split(">");
					}
					
					for ( int i=0; i < maxLevel; i++ ) {
						if ( level > i ) {
							if ( arrFullCmmtIdtfr.length > i ) {
								colTxt.add(arrFullnm[i] + ( "".equals(arrFullCmmtIdtfr[i]) ? "" : "^" + arrFullCmmtIdtfr[i] ) );
							} else {
								colTxt.add(arrFullnm[i]);
							}
						} else {
							if ( arrFullCmmtIdtfr.length > i ) {
								colTxt.add(arrFullnm[arrFullnm.length-1] + ( "".equals(arrFullCmmtIdtfr[i]) ? "" : "^" + arrFullCmmtIdtfr[i] ) );
							} else {
								colTxt.add(arrFullnm[arrFullnm.length-1]);
							}
						}
					}
					
					if ( "Y".equals(defViewOptionUiYn) ) {		
						//기본보기 옵션에 항목 출력여부 예로 설정한 경우
						colTxt.add(r.getString("uiNm"));	//단위
					}
					colTxt.add(r.getString("dtadvsNm"));	//통계자료(원자료, 전년대비자료 등등)
					dtadvsRowColCnt = colTxt.size() - 1;
				}
				
				//위치가 전부 표측일경우, 위치가 전부 표측일경우(분류 사용 안할 경우)
				if ( (OPT_LOC_LEFT.equals(stLoc) && OPT_LOC_LEFT.equals(scLoc) && OPT_LOC_LEFT.equals(siLoc) && OPT_LOC_LEFT.equals(sgLoc)) 					
						|| (OPT_LOC_LEFT.equals(stLoc) && OPT_LOC_NOUSE.equals(scLoc) && OPT_LOC_LEFT.equals(siLoc) && OPT_LOC_NOUSE.equals(sgLoc))
						|| (OPT_LOC_LEFT.equals(stLoc) && OPT_LOC_LEFT.equals(scLoc) && OPT_LOC_LEFT.equals(siLoc) && OPT_LOC_NOUSE.equals(sgLoc))
						|| (OPT_LOC_LEFT.equals(stLoc) && OPT_LOC_NOUSE.equals(scLoc) && OPT_LOC_LEFT.equals(siLoc) && OPT_LOC_LEFT.equals(sgLoc)) ) {	
					colTxt.add("통계값");
				}
				gridTxt.add(colTxt);
			}
			//end for
			
			//시계열 위치가 뒤쪽인 경우 합계 표시
			if ( OPT_LOC_LEFT.equals(siLoc) && DEF_VIEW_OPTION_TSSUM_LOC_LAST.equals(defViewOptionTSSumLoc) ) {
				if( (StringUtils.isNotEmpty(params.getString("langGb")) && params.getString("langGb").equals("ENG"))){ 
					gridTxt.add(sheetInputColTxt(iMaxLevel, "Total"));
				}else{
					gridTxt.add(sheetInputColTxt(iMaxLevel, "합계"));
				}
				cols.add( addSheetCol("Text", "itmSum", 90, "Right", false) );		//합계
			}
			
			/**
			 *  통계자료 위치와 순서 확인(원자료만 있는 경우) 
			 */
			Map<String, Object> dtadvsLoc = new HashMap<String, Object>();	//통계자료 위치와 순서 저장 맵(원자료만 조회될 경우 컬럼 or 행 hidden 처리 위해)
			for (String val : iterDtadvsVal) {
				if ( val.equals("OD") ) {
					dtadvsODUse = "Y";
				}
			}
			if ( OPT_LOC_LEFT.equals(siLoc) && iterDtadvsVal.size() == 1 && "Y".equals(dtadvsODUse) ) {
				//항목이 표측에 있고 통계자료가 원자료만 있는경우
				dtadvsLoc.put("LOC", "LEFT");
				dtadvsLoc.put("CNT", dtadvsRowColCnt);
			} else if ( sheetLoc.equals(siLoc) && iterDtadvsVal.size() == 1 && "Y".equals(dtadvsODUse) ) {
				//항목이 표두에 있고 통계자료가 원자료만 있는경우
				dtadvsLoc.put("LOC", "HEAD");
				dtadvsLoc.put("CNT", dtadvsRowColCnt);
			}
			
			/**
			 * 세로단위로 입력된 arraylist 가로단위로 변환
			 */
			ArrayList<Object> arrGrid = new ArrayList<Object>();
			ArrayList<String> arrCol = null;
			ArrayList<Object> arrGridTxt = (ArrayList<Object>) gridTxt.get(0);
			String[][] tmp = new String[arrGridTxt.size()][gridTxt.size()];
			
			
			List<Record> cmmtRowCol = new ArrayList<Record>();	//통계표 주석 row, col 위치 저장 리스트
			for ( int i=0; i < gridTxt.size(); i++ ) {
				ArrayList<String> c = (ArrayList<String>) gridTxt.get(i);
				for ( int j=0; j < c.size(); j++ ) {
					String val = c.get(j);
					if ( val.indexOf("^") > -1 ) {	//위에서 통계표 주석 표시해놓고 표시가 있는 것은 스타일 적용
						Record r = new Record();
						r.put("row", j);
						r.put("col", i);
						r.put("cmmt", val.substring(0, val.indexOf("^")) + "&nbsp;<span style='"+ STAT_CELL_STYLE_CMMT +"'>"+ val.substring(val.indexOf("^")+1) +"</span>");
						cmmtRowCol.add(r);
						val = val.substring(0, val.indexOf("^"));	//주석 '^' 표시 제거
					}
					//tmp[j][i] =  c.get(j);
					tmp[j][i] =  val;
				}
			}
			
			for ( String x[] : tmp ) { 
				arrCol = new ArrayList<String>();
				for (String y : x) { 
					arrCol.add(y);
				} 
				arrGrid.add(arrCol);
			} 
			//가로 변환 끝
			
			map.put("Text", arrGrid);
			map.put("Cols", cols);
			map.put("cmmtRowCol", cmmtRowCol);
			map.put("dtadvsLoc", dtadvsLoc);
			map.put("statCond", statCond);
		}  catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		
		return map;
	}
	
	/**
	 * 보기 옵션에 따른 시트 위치 재설정
	 * @param params
	 * @param sheetLoc	설정하려는 시트 위치
	 * @return	
	 * 		시계열, 항목, 분류의 위치가 저장된 map 객체
	 */
	private Map<String, String> setLocOptParams(Params params, String sheetLoc) {
		Map<String, String> map = new HashMap<String, String>();	//return map
		String sheetReverseLoc = "";								//시트 반대 위치
		
		if ( OPT_LOC_HEAD.equals(sheetLoc) ) {
			sheetReverseLoc = OPT_LOC_LEFT;
		}  else if (OPT_LOC_LEFT.equals(sheetLoc) ) {
			sheetReverseLoc = OPT_LOC_HEAD;
		}
		
		String viewLocOpt = params.getString("viewLocOpt");	//보기 옵션
		try {
			Map<String, String> optLocMap = statListDao.selectStatTblOptLocation(params);	//항목, 분류, 시계열 표두/표측 위치 조회(H:표두, L:표측)
			
			// 기본보기
			if("B".equals(viewLocOpt)){
				for ( String key : optLocMap.keySet() ) {
					String optCd = key.substring(0, 2);
					String optVal = optLocMap.get(key);
					if ( OPT_CODE_ST.equals(optCd) ) {			//시계열
						if ( sheetLoc.equals(optVal) ) {	
							params.set("STUseYn", "Y");			//쿼리에서 사용하는 파라미터 옵션(시계열)
						}
						map.put("ST", optVal);
					} else if ( OPT_CODE_SC.equals(optCd) ) {	//분류
						if ( sheetLoc.equals(optVal) ) {
							params.set("SCUseYn", "Y");
						}
						map.put("SC", optVal);
					} else if ( OPT_CODE_SI.equals(optCd) ) {	//항목
						if ( sheetLoc.equals(optVal) ) {
							params.set("SIUseYn", "Y");
						}
						map.put("SI", optVal);
					} else if ( OPT_CODE_SG.equals(optCd) ) {	//그룹
						if ( sheetLoc.equals(optVal) ) {
							params.set("SGUseYn", "Y");
						}
						map.put("SG", optVal);
					}				
				}
			}else if("H".equals(viewLocOpt)){ 	// 가로보기
				if ( OPT_LOC_HEAD.equals(sheetLoc) ) {
					params.set("STUseYn", "Y");
					params.set("SCUseYn", "N");
					params.set("SIUseYn", "N");
					params.set("SGUseYn", "N");
					params.set("TBLUseYn", "N");
				}  else if (OPT_LOC_LEFT.equals(sheetLoc) ) {
					params.set("STUseYn", "N");
					params.set("SCUseYn", "Y");
					params.set("SIUseYn", "Y");
					params.set("SGUseYn", "Y");
					params.set("TBLUseYn", "Y");
				}
				map.put("ST", OPT_LOC_HEAD);
				map.put("SC", OPT_LOC_LEFT);
				map.put("SI", OPT_LOC_LEFT);
				map.put("SG", OPT_LOC_LEFT);
				map.put("TBL", OPT_LOC_LEFT);
			}else if("V".equals(viewLocOpt)){	// 세로보기
				if ( OPT_LOC_HEAD.equals(sheetLoc) ) {
					params.set("STUseYn", "N");
					params.set("SCUseYn", "Y");
					params.set("SIUseYn", "Y");
					params.set("SGUseYn", "Y");
					params.set("TBLUseYn", "Y");
				}  else if (OPT_LOC_LEFT.equals(sheetLoc) ) {
					params.set("STUseYn", "Y");
					params.set("SCUseYn", "N");
					params.set("SIUseYn", "N");
					params.set("SGUseYn", "N");
					params.set("TBLUseYn", "N");
				}
				map.put("ST", OPT_LOC_LEFT);
				map.put("SC", OPT_LOC_HEAD);
				map.put("SI", OPT_LOC_HEAD);
				map.put("SG", OPT_LOC_HEAD);
				map.put("TBL", OPT_LOC_HEAD);
			}else if("T".equals(viewLocOpt)){	// 년월보기
				if ( OPT_LOC_HEAD.equals(sheetLoc) ) {
					params.set("STUseYn", "Y");
					params.set("SCUseYn", "N");
					params.set("SIUseYn", "N");
					params.set("SGUseYn", "N");
					params.set("TBLUseYn", "N");
					map.put("ST", OPT_LOC_HEAD);
					map.put("SC", OPT_LOC_LEFT);
					map.put("SI", OPT_LOC_LEFT);
					map.put("TBL", OPT_LOC_LEFT);
				}  else if (OPT_LOC_LEFT.equals(sheetLoc) ) {
					params.set("STUseYn", "Y");
					params.set("SCUseYn", "Y");
					params.set("SIUseYn", "Y");
					params.set("SGUseYn", "Y");
					params.set("TBLUseYn", "Y");
					map.put("ST", OPT_LOC_LEFT);
					map.put("SC", OPT_LOC_LEFT);
					map.put("SI", OPT_LOC_LEFT);
					map.put("SG", OPT_LOC_LEFT);
					map.put("TBL", OPT_LOC_LEFT);
				}
				//171121 김정호 - 표로보기(년월보기)시 주기가 상단으로 위치되도록 수정
				map.put("ST", OPT_LOC_HEAD);
				map.put("SC", OPT_LOC_LEFT);
				map.put("SI", OPT_LOC_LEFT);
				map.put("SG", OPT_LOC_LEFT);
			}else if("U".equals(viewLocOpt)){	// 사용자 보기
				if ( !StringUtils.isEmpty(params.getString("optST")) && sheetLoc.equals(params.getString("optST")) ) {
					params.set("STUseYn", "Y");
					map.put("ST", sheetLoc);
				} else {
					params.set("STUseYn", "N");
					map.put("ST", sheetReverseLoc);
				}
				if ( !StringUtils.isEmpty(params.getString("optSC")) && sheetLoc.equals(params.getString("optSC")) ) {
					params.set("SCUseYn", "Y");
					map.put("SC", sheetLoc);
				} else {
					params.set("SCUseYn", "N");
					map.put("SC", sheetReverseLoc);
				}
				if ( !StringUtils.isEmpty(params.getString("optSI")) && sheetLoc.equals(params.getString("optSI")) ) {
					params.set("SIUseYn", "Y");
					map.put("SI", sheetLoc);
				} else {
					params.set("SIUseYn", "N");
					map.put("SI", sheetReverseLoc);
				}
				if ( !StringUtils.isEmpty(params.getString("optSG")) && sheetLoc.equals(params.getString("optSG")) ) {
					params.set("SGUseYn", "Y");
					map.put("SG", sheetLoc);
				} else {
					params.set("SGUseYn", "N");
					map.put("SG", sheetReverseLoc);
				}			
			}
			
			//표두/표측 정보 중 분류 정보가 없을 경우 사용안함으로 재설정
			if ( "N".equals(optLocMap.get("SCOptVal")) ) {
				params.set("SCUseYn", "N");
				map.put("SC", "N");
			}
			//표두/표측 정보 중 그룹 정보가 없을 경우 사용안함으로 재설정
			if ( "N".equals(optLocMap.get("SGOptVal")) ) {
				params.set("SGUseYn", "N");
				map.put("SG", "N");
			}		
		}  catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return map;
	}
	
	/**
	 * ibsheet 컬럼에 level만큼 headText 입력
	 * @param maxLevel	입력하려는 column의 row 갯수
	 * @param txt		입력되는 text
	 * @return
	 */
	protected ArrayList<String> sheetInputColTxt(int maxLevel, String txt) {
		ArrayList<String> colTxt = new ArrayList<String>();
		for ( int i=0; i < maxLevel; i++ ) {
			colTxt.add(txt);
		}
		return colTxt;
	}
	
	/**
	 * 시트 컬럼 정보 입력
	 * @param type		ibSheet 데이터 Type
	 * @param saveName	ibSheet SaveName
	 * @param width		ibSheet 가로길이
	 * @param align		ibSheet 정렬방향
	 * @param colMerge	ibSheet 컬럼 머지 여부
	 * @return
	 */
	protected HashMap<String, Object> addSheetCol(String type, String saveName, int width, String align, boolean colMerge) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("Type", type);
		map.put("SaveName", saveName);
		map.put("Width", width);
		map.put("Align", align);
		map.put("Edit", false);
		map.put("Hidden", false);
		map.put("ColMerge", colMerge);
		if ( width < 90 ) {
			map.put("MinWidth", 90);
		} else {
			map.put("MinWidth", width);
		}
		return map;
	}
	
	/**
	 * 한글 자음에 대해 쿼리문 생성을 위해 문자를 생성한다.
	 * @param keyword	한글자음 키워드
	 * @return
	 */
	private Record getChosungConvert(String keyword) {
		Record r = new Record();
		String strChosung = "";
		boolean isKeywordEtc = false;
		if("ㄱ".equals(keyword)){ strChosung = "^[가-나]";}
		else if("ㄴ".equals(keyword)){ strChosung = "^[나-다]";}
		else if("ㄷ".equals(keyword)){ strChosung = "^[다-라]";}
		else if("ㄹ".equals(keyword)){ strChosung = "^[라-마]";}
		else if("ㅁ".equals(keyword)){ strChosung = "^[마-바]";}
		else if("ㅂ".equals(keyword)){ strChosung = "^[바-사]";}
		else if("ㅅ".equals(keyword)){ strChosung = "^[사-아]";}
		else if("ㅇ".equals(keyword)){ strChosung = "^[아-자]";}
		else if("ㅈ".equals(keyword)){ strChosung = "^[자-차]";}
		else if("ㅊ".equals(keyword)){ strChosung = "^[차-카]";}
		else if("ㅋ".equals(keyword)){ strChosung = "^[카-타]";}
		else if("ㅌ".equals(keyword)){ strChosung = "^[타-파]";}
		else if("ㅍ".equals(keyword)){ strChosung = "^[파-하]";}
		else if("ㅎ".equals(keyword)){ strChosung = "^[하-힛]";}
		else if("A".equals(keyword)){ strChosung = "^[A]";}
		else if("B".equals(keyword)){ strChosung = "^[B]";}
		else if("C".equals(keyword)){ strChosung = "^[C]";}
		else if("D".equals(keyword)){ strChosung = "^[D]";}
		else if("E".equals(keyword)){ strChosung = "^[E]";}
		else if("F".equals(keyword)){ strChosung = "^[F]";}
		else if("G".equals(keyword)){ strChosung = "^[G]";}
		else if("H".equals(keyword)){ strChosung = "^[H]";}
		else if("I".equals(keyword)){ strChosung = "^[I]";}
		else if("J".equals(keyword)){ strChosung = "^[J]";}
		else if("K".equals(keyword)){ strChosung = "^[K]";}
		else if("L".equals(keyword)){ strChosung = "^[L]";}
		else if("M".equals(keyword)){ strChosung = "^[M]";}
		else if("N".equals(keyword)){ strChosung = "^[N]";}
		else if("O".equals(keyword)){ strChosung = "^[O]";}
		else if("P".equals(keyword)){ strChosung = "^[P]";}
		else if("Q".equals(keyword)){ strChosung = "^[Q]";}
		else if("R".equals(keyword)){ strChosung = "^[R]";}
		else if("S".equals(keyword)){ strChosung = "^[S]";}
		else if("T".equals(keyword)){ strChosung = "^[T]";}
		else if("U".equals(keyword)){ strChosung = "^[U]";}
		else if("V".equals(keyword)){ strChosung = "^[V]";}
		else if("W".equals(keyword)){ strChosung = "^[W]";}
		else if("X".equals(keyword)){ strChosung = "^[X]";}
		else if("Y".equals(keyword)){ strChosung = "^[Y]";}
		else if("Z".equals(keyword)){ strChosung = "^[Z]";}
		else if("ETC".equals(keyword)){
			strChosung = "^[A-Z]"; 
			isKeywordEtc = true;
		}else{
			strChosung = "^[가-힛]";	
			isKeywordEtc = true;
		}
		
		r.put("chosungVal", strChosung);
		r.put("isKeywordEtc", isKeywordEtc ? "Y" : "N");
		return r;
	}
	
	/**
	 * 시트 미리보기 조회
	 * @param params
	 * @return		List 객체
	 * 		
	 */
	@Override
	public List<Record> ststPreviewList(Params params) {
		List<Record> list = new LinkedList<Record>();
		LinkedHashMap<String, Record> tMap = new LinkedHashMap<String, Record>();
		//HashMap<String, Object> row = null;
		
		if ( StringUtils.isNotEmpty(params.getString("deviceType")) && params.getString("deviceType").equals("M") ) {
			getStatDefaultCond(params);
		}
		
		String sheetLoc = OPT_LOC_LEFT;
		params.set("SheetLoc", sheetLoc);

		String stLoc = "N";
		String siLoc = "N";
		String scLoc = "N";
		String sgLoc = "N";
		
		//보기 옵션에 따른 시트 위치 재설정
		Map<String, String> locMap = setLocOptParams(params, OPT_LOC_LEFT);
		for ( String key : locMap.keySet() ) {
			if ( "ST".equals(key) ) {
				stLoc = locMap.get(key);
			} else if ( "SC".equals(key) ) {
				scLoc = locMap.get(key);
			} else if ( "SI".equals(key) ) {
				siLoc = locMap.get(key);
			} else if ( "SG".equals(key) ) {
				sgLoc = locMap.get(key);	
			}
		}
		
		//가로보기(H), 세로보기(V), 표로보기(T) 일 경우 상세 위치 파라미터 재 설정
		if ( "H".equals(params.getString("viewLocOpt")) || "V".equals(params.getString("viewLocOpt")) || "T".equals(params.getString("viewLocOpt")) ) {
			params.set("optST", stLoc);		//시계열
			params.set("optSC", scLoc);		//분류
			params.set("optSI", siLoc);		//항목
			params.set("optSG", sgLoc);		//그룹
		}
		
		//기본보기 옵션(항목단위 출력여부 조회)
		String defViewOptionUiYn = "N";	
		params.set("optCd", "IU");
		try {
			List<Record> defViewOptionIU = (List<Record>) statListDao.selectStatTblOptVal(params);
			if ( defViewOptionIU.size() > 0 ) {
				defViewOptionUiYn = defViewOptionIU.get(0).getString("optVal");
			}
			
			//기본보기 옵션(시계열 합계 출력 위치 'S1005 => F:처음, L:마지막, N:없음)
			String defViewOptionTSSumLoc = "N";
			params.set("optCd", "TL");
			List<Record> defViewOptionTL = (List<Record>) statListDao.selectStatTblOptVal(params);
			if ( defViewOptionTL.size() > 0 ) {
				defViewOptionTSSumLoc = defViewOptionTL.get(0).getString("optVal");	//F:처음, L:마지막, N:없음
			}
			params.set("defViewOptionTSSumLoc", defViewOptionTSSumLoc);
			
			//통계자료 string[] => ibatis에서 사용하기 위해 array로 변경
			ArrayList<String> iterDtadvsVal = new ArrayList<String>(Arrays.asList(params.getStringArray("dtadvsVal")));
			params.set("iterDtadvsVal", iterDtadvsVal);
			//항목선택 string[] => ibatis에서 사용하기 위해 array로 변경
			ArrayList<String> iterChkItms = new ArrayList<String>(Arrays.asList(params.getStringArray("chkItms")));
			params.set("iterChkItms", iterChkItms);
			//분류선택 string[] => ibatis에서 사용하기 위해 array로 변경
			ArrayList<String> iterChkClss = new ArrayList<String>(Arrays.asList(params.getStringArray("chkClss")));
			params.set("iterChkClss", iterChkClss);
			//분류선택 string[] => ibatis에서 사용하기 위해 array로 변경
			ArrayList<String> iterChkGrps = new ArrayList<String>(Arrays.asList(params.getStringArray("chkGrps")));
			params.set("iterChkGrps", iterChkGrps);
			
			//표측 정보 조회
			List<Record> itmList = (List<Record>) statListDao.selectStatTblItm(params);
			
			/**
			 * 표측 정보 for
			 * 	Map에 Sheet row단위로 키를 잡아 저장해 둔다.
			 */
			Record copyRec = new Record();
			for ( Record r : itmList ) {
				Record rec = new Record();	//시트 한줄
				int grpIdx = 0;
				int cateIdx = 0;
				int itmIdx = 0;
				
				//위치가 전부 표두일경우, 위치가 전부 표두일경우(분류 사용 안할 경우)
				if ( (OPT_LOC_HEAD.equals(stLoc) && OPT_LOC_HEAD.equals(scLoc) && OPT_LOC_HEAD.equals(siLoc) && OPT_LOC_HEAD.equals(sgLoc)) 					
						|| (OPT_LOC_HEAD.equals(stLoc) && OPT_LOC_NOUSE.equals(scLoc) && OPT_LOC_HEAD.equals(siLoc) && OPT_LOC_NOUSE.equals(sgLoc))
						|| (OPT_LOC_HEAD.equals(stLoc) && OPT_LOC_HEAD.equals(scLoc) && OPT_LOC_HEAD.equals(siLoc) && OPT_LOC_NOUSE.equals(sgLoc))
						|| (OPT_LOC_HEAD.equals(stLoc) && OPT_LOC_NOUSE.equals(scLoc) && OPT_LOC_HEAD.equals(siLoc) && OPT_LOC_HEAD.equals(sgLoc)) ) {	
					if( (StringUtils.isNotEmpty(params.getString("langGb")) && params.getString("langGb").equals("ENG"))){
						rec.put("COL_dtaVal", "Statistical Value");
					}else{
						rec.put("COL_dtaVal", "통계값");
					}
				}
				
				if ( sheetLoc.equals(stLoc) ) {
					params.put("wrttimeId", r.getString("wrttimeId"));
					String wrttimeCmtIdtfr = r.getString("wrttimeCmtIdtfr");
					rec.put("wrttimeId", r.getString("wrttimeNm") + ( wrttimeCmtIdtfr == "" ? "" : "&nbsp;<span style='"+ STAT_CELL_STYLE_CMMT + "'>" + wrttimeCmtIdtfr + ")</span>" ));
				}
				
				// 그룹
				if ( sheetLoc.equals(sgLoc) ) {
					String[] arrFullnm = r.getString("grpFullnm").split(">");
					int level = r.getInt("grpLevel");
					int maxLevel = r.getInt("maxGrpLevel");
					
					String fullCmmtIdtfr = r.getString("grpFullCmmtIdtfr");
					String[] arrFullCmmtIdtfr = {};
					if ( !"".equals(fullCmmtIdtfr) ) {
						arrFullCmmtIdtfr = fullCmmtIdtfr.split(">");
					}
					
					for ( int i=0; i < maxLevel; i++ ) {
						if ( level > i ) {
							if ( arrFullCmmtIdtfr.length > i ) {
								rec.put(ITM_GRP_KEYNM + String.valueOf(++grpIdx), arrFullnm[i] + ( "".equals(arrFullCmmtIdtfr[i]) ? "" : "&nbsp;<span style='"+ STAT_CELL_STYLE_CMMT +"'>" + arrFullCmmtIdtfr[i] + "</span>" ) );
							} else {
								rec.put(ITM_GRP_KEYNM + String.valueOf(++grpIdx), arrFullnm[i]);
							}
						} else {
							if ( arrFullCmmtIdtfr.length > i ) {
								rec.put(ITM_GRP_KEYNM + String.valueOf(++grpIdx), arrFullnm[arrFullnm.length-1] + ( "".equals(arrFullCmmtIdtfr[i]) ? "" : "&nbsp;<span style='"+ STAT_CELL_STYLE_CMMT +"'>" + arrFullCmmtIdtfr[i] + "</span>" ) );
							} else {
								rec.put(ITM_GRP_KEYNM + String.valueOf(++grpIdx), arrFullnm[arrFullnm.length-1]);
							}
						}
					}
				}
				
				if ( sheetLoc.equals(scLoc) ) {
					String[] arrFullnm = r.getString("clsFullnm").split(">");
					int level = r.getInt("clsLevel");
					int maxLevel = r.getInt("maxClsLevel");
					
					String fullCmmtIdtfr = r.getString("clsFullCmmtIdtfr");
					String[] arrFullCmmtIdtfr = {};
					if ( !"".equals(fullCmmtIdtfr) ) {
						arrFullCmmtIdtfr = fullCmmtIdtfr.split(">");
					}
					
					for ( int i=0; i < maxLevel; i++ ) {
						if ( level > i ) {
							if ( arrFullCmmtIdtfr.length > i ) {
								rec.put(ITM_CLS_KEYNM + String.valueOf(++cateIdx), arrFullnm[i] + ( "".equals(arrFullCmmtIdtfr[i]) ? "" : "&nbsp;<span style='"+ STAT_CELL_STYLE_CMMT +"'>" + arrFullCmmtIdtfr[i] + "</span>" ) );
							} else {
								rec.put(ITM_CLS_KEYNM + String.valueOf(++cateIdx), arrFullnm[i]);
							}
						} else {
							if ( arrFullCmmtIdtfr.length > i ) {
								rec.put(ITM_CLS_KEYNM + String.valueOf(++cateIdx), arrFullnm[arrFullnm.length-1] + ( "".equals(arrFullCmmtIdtfr[i]) ? "" : "&nbsp;<span style='"+ STAT_CELL_STYLE_CMMT +"'>" + arrFullCmmtIdtfr[i] + "</span>" ) );
							} else {
								rec.put(ITM_CLS_KEYNM + String.valueOf(++cateIdx), arrFullnm[arrFullnm.length-1]);
							}
						}
					}
				}
				
				// 항목
				if ( sheetLoc.equals(siLoc) ) {
					String[] arrFullnm = r.getString("itmFullnm").split(">");
					int level = r.getInt("itmLevel");
					int maxLevel = r.getInt("maxItmLevel");
					
					String fullCmmtIdtfr = r.getString("itmFullCmmtIdtfr");
					String[] arrFullCmmtIdtfr = {};
					if ( !"".equals(fullCmmtIdtfr) ) {
						arrFullCmmtIdtfr = fullCmmtIdtfr.split(">");
					}
					
					for ( int i=0; i < maxLevel; i++ ) {
						if ( level > i ) {
							if ( arrFullCmmtIdtfr.length > i ) {
								rec.put(ITM_ITM_KEYNM + String.valueOf(++itmIdx), arrFullnm[i] + ( "".equals(arrFullCmmtIdtfr[i]) ? "" : "&nbsp;<span style='"+ STAT_CELL_STYLE_CMMT +"'>" + arrFullCmmtIdtfr[i] + "</span>" ) );
							} else {
								rec.put(ITM_ITM_KEYNM + String.valueOf(++itmIdx), arrFullnm[i]);
							}
						} else {
							if ( arrFullCmmtIdtfr.length > i ) {
								rec.put(ITM_ITM_KEYNM + String.valueOf(++itmIdx), arrFullnm[arrFullnm.length-1] + ( "".equals(arrFullCmmtIdtfr[i]) ? "" : "&nbsp;<span style='"+ STAT_CELL_STYLE_CMMT +"'>" + arrFullCmmtIdtfr[i] + "</span>" ) );
							} else {
								rec.put(ITM_ITM_KEYNM + String.valueOf(++itmIdx), arrFullnm[arrFullnm.length-1]);
							}
						}
					}
					
					if ( "Y".equals(defViewOptionUiYn) ) {
						//기본보기 옵션에 항목 출력여부 예로 설정한 경우
						rec.put("uiNm", r.getString("uiNm"));		//단위
					}
					rec.put("dtadvsNm", r.getString("dtadvsNm"));	//통계자료(원자료, 전년대비자료 등등)
				}
				
				if ( "T".equals(params.getString("viewLocOpt")) ) {
					//표로 보기 할 경우 컬럼 text값
					rec.put("tsViewCol", r.getString("wrttimeNm"));
				}
				
				if ( tMap.size() == 0 && OPT_LOC_HEAD.equals(siLoc) && DEF_VIEW_OPTION_TSSUM_LOC_FIRST.equals(defViewOptionTSSumLoc) ) {
					//시계열 합계 위치가 처음인 경우 최초 한번만 합계 row 입력
					Record sumRec = new Record();
					for ( Object key : rec.keySet() ) {
						if( (StringUtils.isNotEmpty(params.getString("langGb")) && params.getString("langGb").equals("ENG"))){ 
							sumRec.put(String.valueOf(key), "Total");
						}else{
							sumRec.put(String.valueOf(key), "합계");
						}
					}
					tMap.put("itmSum", sumRec);	
				}
				
				tMap.put(r.getString("sheetKey"), rec);	//시트 분류정보 입력후 map객체에 저장
				
				copyRec = rec;
			}
			
			if ( OPT_LOC_HEAD.equals(siLoc) && DEF_VIEW_OPTION_TSSUM_LOC_LAST.equals(defViewOptionTSSumLoc) ) {
				Record sumRec = new Record();
				for ( Object key : copyRec.keySet() ) {
					if( (StringUtils.isNotEmpty(params.getString("langGb")) && params.getString("langGb").equals("ENG"))){ 
						sumRec.put(String.valueOf(key), "Total");
					}else{
						sumRec.put(String.valueOf(key), "합계");
					}
				}
				tMap.put("itmSum", sumRec);	
			}
			
			/* 시계열 합계를 위해 데이터 그룹 생성(ibatis에서 group by 분기처리) */
			params.set("dataSumGroup", setDataSumGroup(siLoc, stLoc, scLoc, sgLoc));
			
			/**
			 * 시트 입력 데이터 조회
			 * 	데이터 조회시 헤더와 표측 키를 생성하여 가져온다.
			 * 	가져온 표측 키 값을 상단에 만들어 놓은 tmap 객체 키 값 확인하여 차곡차곡 넣어준다.
			 */
			if ( "T".equals(params.getString("viewLocOpt")) ) {
				//표로 보기인경우 데이터 조회시만 세팅
				params.set("TbViewData", "Y");
			}
			
			//통계표 이력 조회 분기(데이터 조회 ID 분기 처리)
			List<Record> dataList = null;
			if ( StringUtils.isNotEmpty(params.getString("hisCycleNo")) ) {
				dataList = statListDao.selectStatHistSheetData(params);
			} else {
				dataList = statListDao.selectStatSheetData(params);
			}
			
			for ( Record d : dataList ) {
				String lKey = d.getString("lKey");				//sheet left key
				String hKey = d.getString("hKey");				//sheet head key
				String dtaVal = d.getString("dtaVal");			//값
				String cmmtIdtfr = d.getString("cmmtIdtfr");	//주석 식별자
				String wrtstateCd = d.getString("wrtstateCd");	//승인상태
				
				if ( StringUtils.isNotEmpty(lKey) ) {	//혹시 모를 nullPointException 방지..
					if ( !"".equals(cmmtIdtfr) && !"".equals(wrtstateCd) && !WRT_STATE_CD_AC.equals(wrtstateCd) ) {
						//주석이 있고 승인되지 않은 경우(주석 색 표시 및 데이터바탕에 노랑색 표시
						//tMap.get(lKey).put(hKey, "<span style='"+ STAT_CELL_STYLE_CMMT +"'>" + cmmtIdtfr + "</span>&nbsp;&nbsp;&nbsp;<span style='"+ STAT_CELL_STYLE_WRT_STATE_AC +"'>"+ dtaVal +"</span>");
					} else if ( !"".equals(cmmtIdtfr) ) {
						//주석만 있는 데이터
						if ( tMap.containsKey(lKey) ) {
							tMap.get(lKey).put(hKey, "<span style='"+ STAT_CELL_STYLE_CMMT +"'>" + cmmtIdtfr + "</span>&nbsp;&nbsp;&nbsp;" + dtaVal);
						}
					} else if ( !"".equals(wrtstateCd) && !WRT_STATE_CD_AC.equals(wrtstateCd) ) {
						//승인되지 않은 데이터
						//tMap.get(lKey).put(hKey, "<span style='"+ STAT_CELL_STYLE_WRT_STATE_AC +"'>"+ dtaVal +"</span>");
					} else {
						//일반 데이터
						//log.debug(tMap);
						if ( tMap.containsKey(lKey) ) {
							tMap.get(lKey).put(hKey, dtaVal);
						}
					}
				}
			}
			
			/**
			 * ibsheet에서 조회되도록 map => list로 변환
			 */
			Set<String> entrySet = tMap.keySet();
			Iterator<String> iter = entrySet.iterator();
			int listIdx = 0;
			while ( iter.hasNext() ) {
				String sKey = ((String) iter.next()); 
				list.add(listIdx++, tMap.get(sKey));
			}
		}  catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		
		return list;
	}

	/**
	 * 시계열 합계를 위해 데이터 그룹 생성한다.
	 * @param siLoc	항목 위치
	 * @param stLoc	시계열 위치
	 * @param scLoc	분류 위치
	 * @param sgLoc	그룹 위치
	 * 
	 * 	 I   : 항목을 그룹지음			IT   : 항목, 시계열
	 *   IC  : 항목, 분류				IG   : 항목, 그룹
	 *   ITC : 항목, 시계열, 분류		ITG  : 항목, 시계열, 그룹
	 *   ICG : 항목, 분류, 그룹			ITCG : 항목, 시계열, 분류, 그룹
	 * @return
	 */
	public String setDataSumGroup(String siLoc, String stLoc, String scLoc, String sgLoc) {
		
		String dataSumGroup = "";
		if ( (OPT_LOC_HEAD.equals(siLoc) && OPT_LOC_LEFT.equals(stLoc) && OPT_LOC_LEFT.equals(scLoc) && OPT_LOC_LEFT.equals(sgLoc)) 
				|| (OPT_LOC_LEFT.equals(siLoc) && OPT_LOC_HEAD.equals(stLoc) && OPT_LOC_HEAD.equals(scLoc) && OPT_LOC_HEAD.equals(sgLoc)) ) {
			dataSumGroup = "I";		// HLLL, LHHH
		} 
		else if ( (OPT_LOC_HEAD.equals(siLoc) && OPT_LOC_HEAD.equals(stLoc) && OPT_LOC_LEFT.equals(scLoc) && OPT_LOC_LEFT.equals(sgLoc))
				|| (OPT_LOC_LEFT.equals(siLoc) && OPT_LOC_LEFT.equals(stLoc) && OPT_LOC_HEAD.equals(scLoc) && OPT_LOC_HEAD.equals(sgLoc)) ) {
			dataSumGroup = "IT";	// HHLL, LLHH
		} 
		else if ( (OPT_LOC_HEAD.equals(siLoc) && OPT_LOC_LEFT.equals(stLoc) && OPT_LOC_HEAD.equals(scLoc) && OPT_LOC_LEFT.equals(sgLoc)) 
				|| (OPT_LOC_LEFT.equals(siLoc) && OPT_LOC_HEAD.equals(stLoc) && OPT_LOC_LEFT.equals(scLoc) && OPT_LOC_HEAD.equals(sgLoc))  ) {
			dataSumGroup = "IC";	// HLHL, LHLH
		}
		else if ( (OPT_LOC_HEAD.equals(siLoc) && OPT_LOC_LEFT.equals(stLoc) && OPT_LOC_LEFT.equals(scLoc) && OPT_LOC_HEAD.equals(sgLoc)) 
				|| (OPT_LOC_LEFT.equals(siLoc) && OPT_LOC_HEAD.equals(stLoc) && OPT_LOC_HEAD.equals(scLoc) && OPT_LOC_LEFT.equals(sgLoc))  ) {
			dataSumGroup = "IG";	// HLLH, LHHL
		}
		else if ( (OPT_LOC_HEAD.equals(siLoc) && OPT_LOC_HEAD.equals(stLoc) && OPT_LOC_HEAD.equals(scLoc) && OPT_LOC_LEFT.equals(sgLoc))
					|| (OPT_LOC_LEFT.equals(siLoc) && OPT_LOC_LEFT.equals(stLoc) && OPT_LOC_LEFT.equals(scLoc) && OPT_LOC_HEAD.equals(sgLoc)) ) {
			dataSumGroup = "ITC";	// HHHL, LLLH
		}
		else if ( (OPT_LOC_HEAD.equals(siLoc) && OPT_LOC_HEAD.equals(stLoc) && OPT_LOC_LEFT.equals(scLoc) && OPT_LOC_HEAD.equals(sgLoc))
				|| (OPT_LOC_LEFT.equals(siLoc) && OPT_LOC_LEFT.equals(stLoc) && OPT_LOC_HEAD.equals(scLoc) && OPT_LOC_LEFT.equals(sgLoc)) ) {
			dataSumGroup = "ITG";	// HHLH, LLHL
		}
		else if ( (OPT_LOC_HEAD.equals(siLoc) && OPT_LOC_LEFT.equals(stLoc) && OPT_LOC_HEAD.equals(scLoc) && OPT_LOC_HEAD.equals(sgLoc))
				|| (OPT_LOC_LEFT.equals(siLoc) && OPT_LOC_HEAD.equals(stLoc) && OPT_LOC_LEFT.equals(scLoc) && OPT_LOC_LEFT.equals(sgLoc)) ) {
			dataSumGroup = "ICG";	// HLHH, LHLL
		}
		else if ( (OPT_LOC_HEAD.equals(siLoc) && OPT_LOC_HEAD.equals(stLoc) && OPT_LOC_HEAD.equals(scLoc) && OPT_LOC_HEAD.equals(sgLoc))
				|| (OPT_LOC_LEFT.equals(siLoc) && OPT_LOC_LEFT.equals(stLoc) && OPT_LOC_LEFT.equals(scLoc) && OPT_LOC_LEFT.equals(sgLoc)) ) {
			dataSumGroup = "ITCG";	// HHHH, LLLL
		}	// 분류가 없을 경우
		else if ( OPT_LOC_NOUSE.equals(scLoc) ) {	
			if ( (OPT_LOC_HEAD.equals(siLoc) && OPT_LOC_LEFT.equals(stLoc) && OPT_LOC_LEFT.equals(sgLoc)) 
					|| (OPT_LOC_LEFT.equals(siLoc) && OPT_LOC_HEAD.equals(stLoc) && OPT_LOC_HEAD.equals(sgLoc)) ) {
				dataSumGroup = "I";		// HLL, LHH
			}
		}	// 그룹이 없을경우
		else if ( OPT_LOC_NOUSE.equals(sgLoc) ) {	
			
		}
		return dataSumGroup;
	}
	
	
	@Override
	public Record statUserTbl(Params params) {
		Record rtn = new Record();
		StringBuffer sb = new StringBuffer();
		try {
			Record usrTbl = statListDao.selectStatUserTbl(params);
			if ( usrTbl != null ) {
				sb.append("statblId=" + usrTbl.getString("statblId"));
				sb.append("&viewLocOpt=" + usrTbl.getString("pivotCd"));			//피봇보기 구분
				sb.append("&optST=" + usrTbl.getString("pivotDcCd"));				//피봇보기 시계열 위치코드
				sb.append("&optSI=" + usrTbl.getString("pivotItmCd"));				//피봇보기 항목 위치코드
				sb.append("&optSC=" + usrTbl.getString("pivotClsCd"));				//피봇보기 구분 위치코드
				sb.append("&optSG=" + usrTbl.getString("pivotGrpCd"));				//피봇보기 구분 위치코드
				
				sb.append("&wrttimeType=" + usrTbl.getString("searchTag"));			//검색기준 구분
				sb.append("&wrttimeOrder=" + usrTbl.getString("sortTag"));			//정렬방식
				//sb.append("&dtadvsVal=" + usrTbl.getString("ddTagCont"));			//자료구분선택내용(원자료 등등)
				sb.append("&wrttimeLastestVal=" + usrTbl.getInt("latestCnt"));		//최근시점 갯수
				sb.append("&dtacycleCd=" + usrTbl.getString("dtacycleCd"));			//자료주기 구분
				
				//최근검색인경우
				if ( StringUtils.isNotEmpty(usrTbl.getString("searchTag")) && "L".equals(usrTbl.getString("searchTag")) ) {	
					Params optParam = new Params();
					
					optParam.set("statblId", usrTbl.getString("statblId"));
					optParam.set("dtacycleCd", usrTbl.getString("dtacycleCd"));
					List<Record> resultDta = (List<Record>) statWrtTimeOption(optParam);
					if ( resultDta.size() > 0 ) {
						sb.append("&wrttimeMinYear=" + resultDta.get(0).getString("code"));							//기간 년도 최소값
						sb.append("&wrttimeMaxYear=" + resultDta.get(resultDta.size() - 1).getString("code"));	//기간 년도 최대값	
						sb.append("&wrttimeStartYear=" + resultDta.get(0).getString("code"));							//기간 년도 시작값
						sb.append("&wrttimeEndYear=" + resultDta.get(resultDta.size() - 1).getString("code"));	//기간 년도 종료값
						StatListController.getWrttimeQt(sb, usrTbl.getString("dtacycleCd"));								//주기에 따른 시점 세팅
					}
				} else {
					sb.append("&wrttimeMinYear=" + usrTbl.getString("startWrttimeIdtfrId").substring(0, 4));		//기간 년도 최소값
					sb.append("&wrttimeMaxYear=" + usrTbl.getString("endWrttimeIdtfrId").substring(0, 4));		//기간 년도 최대값
					sb.append("&wrttimeStartYear=" + usrTbl.getString("startWrttimeIdtfrId").substring(0, 4));	//기간 년도 시작값
					sb.append("&wrttimeEndYear=" + usrTbl.getString("endWrttimeIdtfrId").substring(0, 4));		//기간 년도 종료값
					sb.append("&wrttimeStartQt=" + usrTbl.getString("startWrttimeIdtfrId").substring(4, 6));		//기간 쿼터 시작값(ex:1분기, 하반기, 1월...)
					sb.append("&wrttimeEndQt=" + usrTbl.getString("endWrttimeIdtfrId").substring(4, 6));			//기간 쿼터 종료값
					sb.append("&wrttimeMinQt=" + usrTbl.getString("startWrttimeIdtfrId").substring(4, 6));
					sb.append("&wrttimeMaxQt=" + usrTbl.getString("endWrttimeIdtfrId").substring(4, 6));
				}
				
				sb.append("&dmPointVal=" + usrTbl.getString("dmpointCd"));			//소수점 코드
				sb.append("&uiChgVal=" + usrTbl.getString("uiId"));					//단위 코드
				sb.append("&statblNm=" + usrTbl.getString("statblNm"));				//통계자료명
				
			}
			
			params.set("itmTag", "I");
			List<Record> itmList = (List<Record>) statListDao.selectStatUserTblItm(params);
			for ( Record itm : itmList ) {
				sb.append("&chkItms=" + itm.getString("datano"));
			}
			params.set("itmTag", "C");
			List<Record> clsList = (List<Record>) statListDao.selectStatUserTblItm(params);
			for ( Record cls : clsList ) {
				sb.append("&chkClss=" + cls.getString("datano"));
			}
			params.set("itmTag", "G");
			List<Record> grpList = (List<Record>) statListDao.selectStatUserTblItm(params);
			for ( Record grp : grpList ) {
				sb.append("&chkGrps=" + grp.getString("datano"));
			}
			
			if ( usrTbl != null ) {
				if(usrTbl.getString("ddTagCont") != null){
					String[] dtaList = usrTbl.getString("ddTagCont").split("\\|"); //<--------- UNCHECKED NULL(처리완료)
					for ( String dta : dtaList ) {
						sb.append("&dtadvsVal=" + dta);
					}
				}
				
				rtn.put("firParam", sb.toString());
				if(usrTbl.getString("statblId") != null){
					rtn.put("statblId", usrTbl.getString("statblId")); //<--------- UNCHECKED NULL(처리완료)
				}
			}
		}  catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		
		return rtn;
	}

	/**
	 * 통계스크랩 정보를 등록한다.
	 */
	@Override
	public Record saveStatUserTbl(Params params) {
		try {
			String strMsg = "";

			//주기에 따른 자료시점 세팅
			String dtacycleCd = params.getString("dtacycleCd");
			String strWrttimeStartYear = "";
			String strWrttimeEndYear = "";
			if ( "B".equals(params.getString("wrttimeType")) ) {		//기간검색
				strWrttimeStartYear = "wrttimeStartYear";
				strWrttimeEndYear = "wrttimeEndYear";
			} else if ( "L".equals(params.getString("wrttimeType")) ) {	//주기검색
				strWrttimeStartYear = "wrttimeMinYear";
				strWrttimeEndYear = "wrttimeMaxYear";
			}
			if ( DTACYCLE_YEAR.equals(dtacycleCd) ) {
				params.set("wrtStartYmd", params.getString(strWrttimeStartYear) + "00");
				params.set("wrtEndYmd", params.getString(strWrttimeEndYear) + "00");
			} else if ( DTACYCLE_HARF.equals(dtacycleCd) ) {
				params.set("wrtStartYmd", params.getString(strWrttimeStartYear) 	+ params.getString("wrttimeStartQt"));
				params.set("wrtEndYmd", params.getString(strWrttimeEndYear) 		+ params.getString("wrttimeEndQt"));
			} else if ( DTACYCLE_QUARTER.equals(dtacycleCd) ) {
				params.set("wrtStartYmd", params.getString(strWrttimeStartYear) 	+ params.getString("wrttimeStartQt"));
				params.set("wrtEndYmd", params.getString(strWrttimeEndYear) 		+ params.getString("wrttimeEndQt"));
			} else if ( DTACYCLE_MONTH.equals(dtacycleCd) ) {
				params.set("wrtStartYmd", params.getString(strWrttimeStartYear) 	+ params.getString("wrttimeStartQt"));
				params.set("wrtEndYmd", params.getString(strWrttimeEndYear) 		+ params.getString("wrttimeEndQt"));
			}
			
			//검색기준에 따라 마지막 검색시작, 종료 시점을 입력해 둔다.
			if ( "B".equals(params.getString("wrttimeType")) ) {		//기간검색
				params.set("lsWrttimeIdtfrId", params.getString("wrtStartYmd"));
				params.set("leWrttimeIdtfrId", params.getString("wrtEndYmd"));
			} else if ( "L".equals(params.getString("wrttimeType")) ) {	//주기검색
				//스크랩된 내용으로 실 데이터를 조회하여 시작, 종료시점을 가져온다.
				Record firEndRecd = statListDao.selectStatUserTblFirEndWrttime(params);	
				params.set("lsWrttimeIdtfrId", firEndRecd.getString("lsWrttimeIdtfrId"));
				params.set("leWrttimeIdtfrId", firEndRecd.getString("leWrttimeIdtfrId"));
			}
			
			//증감분석 체크한 항목들 "|"으로 엮는다.
			String[] dtadvsVals = params.getStringArray("dtadvsVals");
			if ( dtadvsVals.length > 0 ) {
				String dtadvsVal = "";
				for ( String dtadvs : dtadvsVals ) {
					dtadvsVal += dtadvs + "|";
				}
				params.set("dtadvsVal", dtadvsVal.substring(0, dtadvsVal.length()-1));
			}
			
			if ( params.getString(ModelAttribute.ACTION_STATUS).equals(ModelAttribute.ACTION_INS) ) {
				/* 통계스크랩 마스터 정보 신규등록 */
				statListDao.insertStatUserTbl(params);
				strMsg = "통계스크랩이 저장되었습니다.";
			} else if ( params.getString(ModelAttribute.ACTION_STATUS).equals(ModelAttribute.ACTION_UPD) ) {
				/* 통계스크랩 마스터 정보 수정 */
				statListDao.updateStatUserTbl(params);
				strMsg = "통계스크랩이 수정되었습니다.";
			}
			
			
			/* 통계스크랩 항목, 분류 정보 등록 */
			ArrayList<String> iterChkItms = new ArrayList<String>(Arrays.asList(params.getStringArray("chkItms")));
			if ( iterChkItms.size() > 0 ) {
				//체크한 항목들 등록
				params.set("itmTag", "I");
				params.set("iterChkVals", iterChkItms);
				statListDao.deleteStatUserTblItm(params);	//삭제하고
				statListDao.insertStatUserTblItm(params);	//등록
			}
			ArrayList<String> iterChkClss = new ArrayList<String>(Arrays.asList(params.getStringArray("chkClss")));
			if ( iterChkClss.size() > 0 ) {
				//체크한 분류들 등록
				params.set("itmTag", "C");
				params.set("iterChkVals", iterChkClss);
				statListDao.deleteStatUserTblItm(params);	//삭제하고
				statListDao.insertStatUserTblItm(params);	//등록
			}
			/* 통계스크랩 > 그룹 정보 등록 */
			ArrayList<String> iterChkGrps = new ArrayList<String>(Arrays.asList(params.getStringArray("chkGrps")));
			if ( iterChkGrps.size() > 0 ) {
				//체크한 분류들 등록
				params.set("itmTag", "G");
				params.set("iterChkVals", iterChkGrps);
				statListDao.deleteStatUserTblItm(params);	//삭제하고
				statListDao.insertStatUserTblItm(params);	//등록
			}
			
			Record result = new Record();
			result.put(Result.SUCCESS,  true);
			result.put(Result.MESSAGES, strMsg);
			result.put("usrTblSeq", params.getInt("seqceNo"));
			return result;
		}  catch (DataAccessException e) {
			EgovWebUtil.exTransactionLogging(e);
			Record result = new Record();
			result.put(Result.SUCCESS,  false);
			result.put(Result.MESSAGES, "시스템 오류가 발생하였습니다.");
			return result;
			//return failure("시스템 오류가 발생하였습니다.");
		} catch (Exception e) {
			EgovWebUtil.exTransactionLogging(e);
			Record result = new Record();
			result.put(Result.SUCCESS,  false);
			result.put(Result.MESSAGES, "시스템 오류가 발생하였습니다.");
			return result;
			//return failure("시스템 오류가 발생하였습니다.");
		}
	}

	/**
	 * 메타데이터 확인 로그
	 */
	@Override
	public void insertLogSttsStat(Params params) {
		try {
			statListDao.insertLogSttsStat(params);
		}  catch (DataAccessException e) {
			EgovWebUtil.exTransactionLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exTransactionLogging(e);
		}
	}
	
	/**
	 * 통계표 열람 로그
	 */
	@Override
	public void insertLogSttsTbl(Params params) {
		try {
			statListDao.insertLogSttsTbl(params);
		}  catch (DataAccessException e) {
			EgovWebUtil.exTransactionLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exTransactionLogging(e);
		}
	}
	
	/**
	 * 통계주제 최상위 레벨
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Record> statCateTopList(Params params) {
		List<Record> result = new ArrayList<Record>();
		try {
			result = (List<Record>) statListDao.statCateTopList(params);
		}  catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return result;
	}
	
	/**
	 * 통계표 이력 검색주기 조회
	 */
	public List<Record> statHistDtacycleList(Params params) {
		List<Record> result = new ArrayList<Record>();
		try {
			result = (List<Record>) statListDao.statHistDtacycleList(params);
		}  catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return result;
	}
	
	/**
	 * 통계표 이력 주기 리스트 조회
	 */
	public List<Record> statHisSttsCycleList(Params params) {
		List<Record> result = new ArrayList<Record>();
		try {
			result = (List<Record>) statListDao.selectStatHisSttsCycleList(params);
		}  catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return result;
	}

	/**
	 * 간편통계 시트 셀 제한시 다운로드(대용량)
	 */
	@Override
	public void downloadStatSheetDataCUD(HttpServletRequest request, HttpServletResponse response, Params params) {
		try {
			/**
			 * 헤더 정보
			 */
			Map<String, Object> headMap = statTblItm(params);
			
			/**
			 * 데이터 정보
			 */
			params.set("STUseYn", "N");		// 헤더정보 조회할때 사용된 파라미터 초기화
			params.set("SIUseYn", "N");
			params.set("SCUseYn", "N");
			params.set("SGUseYn", "N");
			List<Record> dataMap = ststPreviewList(params);
			
			// 엑셀 다운로드
			DownloadStatExcel.downloadStatDataXls(response, request, params, headMap, dataMap);
						
		} catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
	}

	/**
	 * 통계설명 자료 데이터 호출
	 */
	public List<Record> selectContentsList(Params params) {
		List<Record> result = new ArrayList<Record>();
		try {
			result = (List<Record>) statListDao.selectContentsList(params);
		}  catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return result;
	}

	/**
	 * 통계설명 자료 데이터 호출(파일다운로드 목록)
	 */
	public Paging  selectContentsFileList(Params params) {
		Paging result = new Paging();
		try {
			result = statListDao.selectContentsFileList(params, params.getPage(), params.getRows());
		}  catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return result;
	}

	/**
	 * 통계컨텐츠 정보 데이터 호출
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectContentsNabo(Params params) {
		Map<String, Object> dataMap = new HashMap<String, Object>();
		try {
			List<Record> bbsListData = (List<Record>) statListDao.selectContentsBbsList(params);
			String statblNm = "";
			if(bbsListData.size() > 0){
				statblNm = bbsListData.get(0).getString("STATBL_NM");
				for ( int i=0; i < bbsListData.size(); i++ ) {
					String seq = bbsListData.get(i).getString("SEQ");
					int viewCnt = bbsListData.get(i).getInt("VIEW_CNT");
					if(params.getString("seq").equals("TOP") && i==0){
						params.put("seq", seq);
						bbsListData.get(i).put("VIEW_CNT", viewCnt+1);
					}else{
						if(params.getString("seq").equals(seq)) bbsListData.get(i).put("VIEW_CNT", viewCnt+1);
					}
				}
			}
			
			//조회수 Count를 증가시킨다.
			statListDao.updateContentsBbsDataHit(params);
			
			params.put("naverType", "next"); //다음
			List<Record> nextData = (List<Record>) statListDao.selectContentsBbsNaverData(params); //다음 글 정보
			params.put("naverType", "prev"); //이전
			List<Record> prevData = (List<Record>) statListDao.selectContentsBbsNaverData(params); //이전 글 정보
			
			dataMap.put("BBS_DATA", statListDao.selectContentsList(params));
			List<Record> linkData = (List<Record>) statListDao.selectContentsLinkData(params); //링크 정보
			List<Record> fileData = (List<Record>) statListDao.selectContentsFileData(params); //파일 정보
			List<Record> dicData = (List<Record>) statListDao.selectContentsDicData(params); // 용어설명
			
			dataMap.put("NEXT_DATA", nextData);
			dataMap.put("PREV_DATA", prevData);
			dataMap.put("statblNm",  statblNm);
			dataMap.put("LINK_DATA",  linkData);
			dataMap.put("FILE_DATA",  fileData);
			dataMap.put("DIC_DATA",  dicData);
		}  catch (DataAccessException e) {
			EgovWebUtil.exTransactionLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exTransactionLogging(e);
		}
		return dataMap;
	}

	/**
	 * 통계컨텐츠 정보 목록 리스트만 호출
	 */
	@SuppressWarnings("unchecked")
    public Paging selectContentsNaboList(Params params) {
		Paging result = new Paging();
		try {
			result =  statListDao.selectContentsBbsListData(params, params.getPage(), params.getRows());
		}  catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return result;
    }
	/**
	 * 통계 컨턴츠 상세분석
	 */
	public List<Record> selectDtlAnalysisList(Params params) {
		List<Record> result = new ArrayList<Record>();
		try {
			result =  (List<Record>) statListDao.selectDtlAnalysisList(params);
		}  catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return result;
	}

	/**
	 * 주석 조회
	 */
	@Override
	public List<Record> selectStatCmmtList(Params params) {
		List<Record> result = new ArrayList<Record>();
		try {
			result = (List<Record>) statListDao.selectStatCmmtList(params);
		}  catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return result;
	}

	/**
	 * 통계표 카테고리를 검색한다(최상위, 부모, 자기자신)
	 */
	@Override
	public Record selectSttsCateInfo(String statblId) {
		Record result = new Record();
		try {
			result = statListDao.selectSttsCateInfo(statblId);
		}  catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return result;
	}

	@Override
	public Record selectSttsMeta(Params params) {
		Record result = new Record();
		try {
			result =  statListDao.selectSttsMeta(params);
		}  catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return result;
	}
	
	/**
	 * 평가점수 등록
	 */
	@Override
	public Record insertSttsTblAppr(Params params) {
		// 평가점수 등록
		statListDao.insertSttsTblAppr(params);
		
		// 평가점수 조회
		return statListDao.selectSttsTblAppr(params);
	}
}

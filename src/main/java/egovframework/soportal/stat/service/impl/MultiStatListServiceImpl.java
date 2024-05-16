package egovframework.soportal.stat.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
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
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.stat.service.impl.StatPreviewDao;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.constants.ModelAttribute;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;
import egovframework.common.base.service.BaseService;
import egovframework.soportal.stat.service.MultiStatListService;
import egovframework.soportal.stat.web.MultiStatListController;
import egovframework.soportal.stat.web.StatListController;

/**
 * 통계표를 관리하는 서비스 클래스
 * @author	김정호
 * @version 1.0
 * @since   2017/05/25
 */

@Service(value="multiStatListService")
public class MultiStatListServiceImpl extends BaseService implements MultiStatListService {
	
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

	@Resource(name="multiStatListDao")
	protected MultiStatListDao multiStatListDao;

	@Resource(name="statPreviewDao")
	public StatPreviewDao statPreviewDao;
	
	private static final String OPT_LOC_HEAD = "H";		//표두
	private static final String OPT_LOC_LEFT = "L";		//표측
	private static final String OPT_LOC_NOUSE = "N";	//사용안함
	private static final String OPT_CODE_SG = "SG";		//통계표 위치 옵션(그룹)
	private static final String OPT_CODE_SI = "SI";		//통계표 위치 옵션(항목)
	private static final String OPT_CODE_SC = "SC";		//통계표 위치 옵션(분류)
	private static final String OPT_CODE_ST = "ST";		//통계표 위치 옵션(시계열)
	private static final String OPT_CODE_TBL = "TBL";	//통계표 위치 옵션(통계표명칭)
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
	
	/**
	 * 통계표 관리 상세 조회
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectMultiStatDtl(Params params) {
		Map<String, Object> rMap = new HashMap<String, Object>();
		Map<String, Object> dataMap = new HashMap<String, Object>();

		//복수통계 넘어온 시계열 통계 데이터를 변수 할당
		makeStatTabMVal(params);
		
		dataMap.put("OPT_DATA", (List<Map<String, Object>>) multiStatListDao.selectMultiStatDtlOpt(params));	//통계표 옵션정보 조회
		dataMap.put("SCHL_DATA", (List<Map<String, Object>>) multiStatListDao.selectMultiStatDtlSchl(params));	//통계자료 작성일정 조회
		
		if(!params.getString("metaCallYn").equals("N")){
			dataMap.put("CMMT_DATA", (List<Map<String, Object>>) multiStatListDao.selectMultiStatCmmtList(params));	//통계자료 주석정보 조회
		}
		
		rMap.put("DATA", multiStatListDao.selectMultiStatDtl(params));
		rMap.put("DATA2", dataMap);
		return rMap;
	}

	/**
	 * 통계표 검색주기 조회
	 */
	public List<Record> statMultiDtacycleList(Params params) {
		
		//복수통계 넘어온 시계열 통계 데이터를 변수 할당
		makeStatTabMVal(params);
		
		return (List<Record>)multiStatListDao.statMultiDtacycleList(params);
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
	public Map<String, Object> multiTblItm(Params params) {
		String strGroupTxt = getMessage("stat.ko.group", "그룹");
		// 복수통계 화면 유형 구분키
		String multiStatType = params.getString(MultiStatListController.MULTI_STAT_TYPE);
		
		Map<String, Object> map = new HashMap<String, Object>();
		Params statCond = null;

		//deviceType이 모바일(M)로 넘어왔을 경우이거나, 조회 타입이 StatblId(S)통계표 조회로 바로 넘어온 경우
		if ( (StringUtils.isNotEmpty(params.getString("deviceType")) && params.getString("deviceType").equals("M"))
			|| (StringUtils.isNotEmpty(params.getString("searchType")) && params.getString("searchType").equals("S"))
		) {
			//기본 조회값을 넘겨준다.
			statCond = getStatDefaultCond(params);
		}

		//복수통계 넘어온 시계열 통계 데이터를 변수 할당
		makeStatTabMVal(params);
				
		String sheetLoc = OPT_LOC_HEAD;		//헤더 설정하는 중..
		params.set("SheetLoc", sheetLoc);

		int iMaxLevel = 0;	//항목 레벨(headText row 수)
		int iCateCnt = 0;			//분류 갯수
		int iItmCnt = 0;			//항목 갯수
		int iGrpCnt = 0;			//그룹 갯수
		String stLoc = "N";
		String siLoc = "N";
		String scLoc = "N";
		String sgLoc = "N";
		String tblLoc = "N";
		
		String defViewOptionUiYn = "N";		//기본보기 옵션(항목 단위 출력 여부)
		String defViewOptionTSSumLoc = "N";	//기본보기 옵션(시계열 합계 출력 위치 'S1005 => F:처음, L:마지막, N:없음')
		String dtadvsODUse = "N";			//통계자료가 원자료만 사용하는지 확인
		int dtadvsRowColCnt = 0;			//원자료만 사용하는경우 컬럼/행 위치
		int uiRowCnt = 0;						//단위 row위치
		
		try {
			
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
				} else if ( OPT_CODE_TBL.equals(key) ) {
					tblLoc = locMap.get(key);
				}
			}
			
			//기본보기 옵션(항목단위 출력여부 조회)
			params.set("optCd", "IU");
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
			
			List<HashMap<String, Object>> cols = new LinkedList<HashMap<String, Object>>();		//ibsheet 컬럼 정보
			ArrayList<Object> gridTxt = new ArrayList<Object>();								//ibsheet headText 정보
			ArrayList<String> colTxt = null;
			
			//헤더정보 조회
			List<Record> list = (List<Record>) multiStatListDao.selectMultiStatTblItm(params);
			
			/**
			 * 기본적으로 생성되는 시트 헤더정보 
			 */
			//시트 location에 따라 max레벨 증가
			if ( sheetLoc.equals(tblLoc) ) { //통계표명칭 헤더 추가 
				iMaxLevel = iMaxLevel + 1;
			} 
			
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
				
				// 사칙연산 화면인경우 세로보기일때 기호를 표시하기위해 헤더 row 하나 추가해야함
				if ( StringUtils.equals(multiStatType, MultiStatListController.MULTI_STAT_TYPE_FC) ) {
					iMaxLevel = iMaxLevel + 1;
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
			
			if ( OPT_LOC_HEAD.equals(stLoc) ){
				if((StringUtils.isNotEmpty(params.getString("langGb")) && params.getString("langGb").equals("ENG"))){
					gridTxt.add(sheetInputColTxt(iMaxLevel, "Table"));
				}else{
					gridTxt.add(sheetInputColTxt(iMaxLevel, "통계표"));
				}
				cols.add( addSheetCol("Html", "statblNm", 130, "Center", true));
			}
			
			if ( OPT_LOC_HEAD.equals(stLoc) && OPT_LOC_HEAD.equals(siLoc) && OPT_LOC_HEAD.equals(scLoc) && OPT_LOC_HEAD.equals(sgLoc) ) {
				//방향이 표두이거나 옵션에서 가로로보기 했을 경우
				if((StringUtils.isNotEmpty(params.getString("langGb")) && params.getString("langGb").equals("ENG"))){
					gridTxt.add(sheetInputColTxt(iMaxLevel, "Statistical Value"));
				}else{
					gridTxt.add(sheetInputColTxt(iMaxLevel, "통계값"));
				}
				cols.add( addSheetCol("Text", "COL_dtaVal", 60, "Center", true) );
			}
			
			//설정 위치에 따라 표측에 존재할 경우 ibsheet 컬럼 생성
			if ( OPT_LOC_LEFT.equals(stLoc) ){	//시계열
				if((StringUtils.isNotEmpty(params.getString("langGb")) && params.getString("langGb").equals("ENG"))){
					gridTxt.add(sheetInputColTxt(iMaxLevel, "Data Time"));
				}else{
					gridTxt.add(sheetInputColTxt(iMaxLevel, "자료시점"));
				}
				cols.add( addSheetCol("Html", "wrttimeId", 90, "Center", true));
			}
			
			// 세로보기이고 사칙연산 화면일경우 사칙연산값 컬럼 추가
			if ( OPT_LOC_HEAD.equals(siLoc) && StringUtils.equals(multiStatType, MultiStatListController.MULTI_STAT_TYPE_FC) ) {
				if((StringUtils.isNotEmpty(params.getString("langGb")) && params.getString("langGb").equals("ENG"))){
					gridTxt.add(sheetInputColTxt(iMaxLevel, "Result"));
				}else{
					// 파라미터로 넘어온 지표명도 같이 입력해준다.
					gridTxt.add(sheetInputColTxt(iMaxLevel, "계산결과" + ( StringUtils.isNotEmpty(params.getString("calcAqnNm")) ? "("+params.getString("calcAqnNm")+")" : "")) );
				}
				cols.add( addSheetCol("Html", "calcVal", 60, "Right", false) );		// 사칙연산 값
			}
			
			if ( OPT_LOC_LEFT.equals(sgLoc) ){	//그룹
				int leftColCnt = ((BigDecimal) list.get(0).get("maxGrpLevel")).intValue();
				for ( int i=0; i < leftColCnt; i++ ) {				
					gridTxt.add(sheetInputColTxt(iMaxLevel, strGroupTxt));
					cols.add( addSheetCol("Html", ITM_GRP_KEYNM + String.valueOf(++iGrpCnt), 90, "Left", true));
				}
			}
			
			if ( OPT_LOC_LEFT.equals(scLoc) ){	//분류
				int leftColCnt = ((BigDecimal) list.get(0).get("maxClsLevel")).intValue();
				for ( int i=0; i < leftColCnt; i++ ) {		
					if((StringUtils.isNotEmpty(params.getString("langGb")) && params.getString("langGb").equals("ENG"))){
						gridTxt.add(sheetInputColTxt(iMaxLevel, "Classification"));
					}else{
						gridTxt.add(sheetInputColTxt(iMaxLevel, "분류"));
					}
					cols.add( addSheetCol("Html", ITM_CLS_KEYNM+String.valueOf(++iCateCnt), 90, "Center", true));
				}
			}
			
			if ( OPT_LOC_LEFT.equals(siLoc) ){	//항목
				
				int leftColCnt = ((BigDecimal) list.get(0).get("maxItmLevel")).intValue();
				for ( int i=0; i < leftColCnt; i++ ) {	
					if((StringUtils.isNotEmpty(params.getString("langGb")) && params.getString("langGb").equals("ENG"))){
						gridTxt.add(sheetInputColTxt(iMaxLevel, "Items"));
					}else{
						gridTxt.add(sheetInputColTxt(iMaxLevel, "항목"));
					}
					cols.add( addSheetCol("Html", ITM_ITM_KEYNM+String.valueOf(++iItmCnt), 90, "Center", true));
				}
				
				//단위는 기본보기 옵션에 따라 출력여부 표시하고 통계자료는 항목이 있을경우 따라다닌다.
				if ( "Y".equals(defViewOptionUiYn) ) {
					if((StringUtils.isNotEmpty(params.getString("langGb")) && params.getString("langGb").equals("ENG"))){
						gridTxt.add(sheetInputColTxt(iMaxLevel, "Unit"));
					}else{
						gridTxt.add(sheetInputColTxt(iMaxLevel, "단위"));
					}
					cols.add( addSheetCol("Text", "uiNm", 60, "Center", false) );		//단위
				}
				
				if((StringUtils.isNotEmpty(params.getString("langGb")) && params.getString("langGb").equals("ENG"))){
					gridTxt.add(sheetInputColTxt(iMaxLevel, "Statistics"));
				}else{
					gridTxt.add(sheetInputColTxt(iMaxLevel, "통계자료"));
				}
				cols.add( addSheetCol("Text", "dtadvsNm", 120, "Left", true) );	//통계자료
				
				dtadvsRowColCnt = gridTxt.size() - 1;	//현재 통계자료 row 위치
				
				/*
			//시계열 위치가 앞쪽인 경우 합계 표시
			if ( DEF_VIEW_OPTION_TSSUM_LOC_FIRST.equals(defViewOptionTSSumLoc) ) {
				if((StringUtils.isNotEmpty(params.getString("langGb")) && params.getString("langGb").equals("ENG"))){
					gridTxt.add(sheetInputColTxt(iMaxLevel, "Total"));
				}else{
					gridTxt.add(sheetInputColTxt(iMaxLevel, "합계"));
				}
				cols.add( addSheetCol("Text", "itmSum", 60, "Right", false) );		//합계
			}
				 */
				
				// 가로보기이고 사칙연산 화면일경우 기호 컬럼생성
				if ( StringUtils.equals(multiStatType, MultiStatListController.MULTI_STAT_TYPE_FC) ) {
					if((StringUtils.isNotEmpty(params.getString("langGb")) && params.getString("langGb").equals("ENG"))){
						gridTxt.add(sheetInputColTxt(iMaxLevel, "Symbol"));
					}else{
						gridTxt.add(sheetInputColTxt(iMaxLevel, "기호"));
					}
					cols.add( addSheetCol("Text", "alphaOprt", 60, "Center", false) );	// 사칙연산 기호
				}
			}
			
			if ( "T".equals(params.getString("viewLocOpt")) ) {
				//표로 보기 할 경우 컬럼 추가
				if((StringUtils.isNotEmpty(params.getString("langGb")) && params.getString("langGb").equals("ENG"))){
					gridTxt.add(sheetInputColTxt(iMaxLevel, "Period"));
				}else{
					gridTxt.add(sheetInputColTxt(iMaxLevel, "주기"));
				}
				cols.add( addSheetCol("Text", "tsViewCol", 90, "Center", true) );
			}
			
			/**
			 * 동적으로 생성되는 시트 헤더정보 for 
			 */
			for ( Record r : list ) {
				colTxt = new ArrayList<String>();
				cols.add( addSheetCol("Html", r.getString("sheetKey"), 90, "Right", false) );	//쿼리에서 생성되는 컬럼키 입력
				
				if ( OPT_LOC_LEFT.equals(stLoc) ){
					if ( !"".equals(r.getString("cmmtIdtfr")) ) {
						colTxt.add(r.getString("statblNm") + "^" + r.getString("cmmtIdtfr") + ")"); //통계표명칭
					}
					else {
						colTxt.add(r.getString("statblNm")); //통계표명칭	
					}
				}
				if ( sheetLoc.equals(stLoc)  ) {	//시계열(자료시점)
					params.put("wrttimeId", r.getString("wrttimeId"));
					//시계열(자료시점) 주석 식별자는 별도 호출한다.
					String cmmtIdtfr = (r.getString("cmmtIdtfr")).replaceAll(",", ") ");
					colTxt.add(r.getString("wrttimeNm") + ( cmmtIdtfr == "" ? "" : "^" + cmmtIdtfr + ")" ) );	
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
					
					// 사칙연산 화면인경우 헤더에 기호를 추가해주어야 한다
					if ( StringUtils.equals(multiStatType, MultiStatListController.MULTI_STAT_TYPE_FC) ) {
						colTxt.add(r.getString("alphaOprt"));	// 기호
					}
					
					colTxt.add(r.getString("dtadvsNm"));	//통계자료(원자료, 전년대비자료 등등)
					dtadvsRowColCnt = colTxt.size() - 1;
				}
				
				if ( (OPT_LOC_LEFT.equals(stLoc) && OPT_LOC_LEFT.equals(scLoc) && OPT_LOC_LEFT.equals(siLoc) && OPT_LOC_LEFT.equals(sgLoc)) 					
						|| (OPT_LOC_LEFT.equals(stLoc) && OPT_LOC_NOUSE.equals(scLoc) && OPT_LOC_LEFT.equals(siLoc) && OPT_LOC_NOUSE.equals(sgLoc))
						|| (OPT_LOC_LEFT.equals(stLoc) && OPT_LOC_LEFT.equals(scLoc) && OPT_LOC_LEFT.equals(siLoc) && OPT_LOC_NOUSE.equals(sgLoc))
						|| (OPT_LOC_LEFT.equals(stLoc) && OPT_LOC_NOUSE.equals(scLoc) && OPT_LOC_LEFT.equals(siLoc) && OPT_LOC_LEFT.equals(sgLoc)) ) {	
					if((StringUtils.isNotEmpty(params.getString("langGb")) && params.getString("langGb").equals("ENG"))){
						colTxt.add("Statistical Value");
					}else{
						colTxt.add("통계값");
					}
				}
				gridTxt.add(colTxt);
			}
			//end for
			
			//시계열 위치가 뒤쪽인 경우 합계 표시
			if ( OPT_LOC_LEFT.equals(siLoc) && DEF_VIEW_OPTION_TSSUM_LOC_LAST.equals(defViewOptionTSSumLoc) ) {
				if((StringUtils.isNotEmpty(params.getString("langGb")) && params.getString("langGb").equals("ENG"))){
					gridTxt.add(sheetInputColTxt(iMaxLevel, "Total"));
				}else{
					gridTxt.add(sheetInputColTxt(iMaxLevel, "합계"));
				}
				cols.add( addSheetCol("Text", "itmSum", 60, "Right", false) );		//합계
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

	private Params getStatDefaultCond(Params params) {
		params.set("viewLocOpt", "B");
		params.set("wrttimeType", "L");
		params.set("wrttimeOrder", "A");
		params.set("dtadvsVal", "OD");
		
		Params optParam = new Params();
		optParam.set("statblId", params.getString("statblId"));
		optParam.set("optCd", "TN");
		
		List<Record> resultOptTN = (List<Record>) statPreviewDao.selectStatTblOptVal(optParam);
		params.set("wrttimeLastestVal", resultOptTN.get(0).getString("optVal"));	//최근시점 갯수
		
		optParam.set("optCd", "DC");
		List<Record> resultOptDC = (List<Record>) statPreviewDao.selectStatTblOptVal(optParam);
		params.set("dtacycleCd", resultOptDC.get(0).getString("optVal"));	//검색자료주기
		
		List<Record> resultDta = statWrtTimeOption(optParam);
		//List<Record> resultDta = (List<Record>) statPreviewDao.statWrtTimeOption(params);
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
	 * 보기 옵션에 따른 시트 위치 재설정
	 * @param params
	 * @param sheetLoc	설정하려는 시트 위치
	 * @return	
	 * 		시계열, 항목, 분류의 위치가 저장된 map 객체
	 */
	private Map<String, String> setLocOptParams(Params params, String sheetLoc) {
		Map<String, String> map = new HashMap<String, String>();	//return map
		String sheetReverseLoc = "";								//시트 반대 위치
		
		String viewLocOpt = params.getString("viewLocOpt");	//보기 옵션
		Map<String, String> optLocMap = multiStatListDao.selectMultiStatTblOptLocation(params);	//항목, 분류, 시계열 표두/표측 위치 조회(H:표두, L:표측)
		
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

	/*
	 * 자료시점 조회
	 */
	@SuppressWarnings("unchecked")
	public List<Record> statWrtTimeOption(Params params) {
		List<Record> result = new ArrayList<Record>();
		try {
			List<Record> resultOptDC = (List<Record>) statListDao.selectStatTblOptVal(params);
			if ( resultOptDC.size() > 0 ) {
				params.put("dtacycleCd", resultOptDC.get(0).getString("optVal"));
			}
			result = (List<Record>) statListDao.selectStatWrtTimeOption(params);
			
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
	public List<Record> statMultiTblUi(Params params) {
		//복수통계 넘어온 시계열 통계 데이터를 변수 할당
		makeStatTabMVal(params);

		return (List<Record>) multiStatListDao.selectMultiStatTblUi(params);
	}
	
	/**
	 * 통계표 통계자료유형 조회
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Record> statMultiTblDtadvs(Params params) {
		
		//복수통계 넘어온 시계열 통계 데이터를 변수 할당
		makeStatTabMVal(params);
		
		return (List<Record>) multiStatListDao.selectMultiStatTblDtadvs(params);
	}

	/**
	 * 시트 미리보기 조회
	 * @param params
	 * @return		List 객체
	 * 		
	 */
	@Override
	public List<Record> statMultiPreviewList(Params params) {
		List<Record> list = new LinkedList<Record>();
		LinkedHashMap<String, Record> tMap = new LinkedHashMap<String, Record>();
		
		// 복수통계 화면 유형 구분키
		String multiStatType = params.getString(MultiStatListController.MULTI_STAT_TYPE);
		
		//HashMap<String, Object> row = null;

		//복수통계 넘어온 시계열 통계 데이터를 변수 할당
		makeStatTabMVal(params);		

		if ( StringUtils.isNotEmpty(params.getString("deviceType")) && params.getString("deviceType").equals("M") ) {
			getStatDefaultCond(params);
		}
		
		String sheetLoc = OPT_LOC_LEFT;
		params.set("SheetLoc", sheetLoc);
		
		String stLoc = "N";
		String siLoc = "N";
		String scLoc = "N";
		String sgLoc = "N";
		String tblLoc = "N";
		
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
			} else if ( "TBL".equals(key) ) {
				tblLoc = locMap.get(key);
			}
		}
		
		//가로보기(H), 세로보기(V), 표로보기(T) 일 경우 상세 위치 파라미터 재 설정
		if ( "H".equals(params.getString("viewLocOpt")) || "V".equals(params.getString("viewLocOpt")) || "T".equals(params.getString("viewLocOpt")) ) {
			params.set("optST", stLoc);		//시계열
			params.set("optSC", scLoc);		//분류
			params.set("optSI", siLoc);		//항목
			params.set("optSG", sgLoc);		//그룹
			params.set("optTBL", tblLoc);	//통계표명칭
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
			
			//표측 정보 조회
			List<Record> itmList = (List<Record>) multiStatListDao.selectMultiStatTblItm(params);
			
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
				
				if ( (OPT_LOC_HEAD.equals(stLoc) && OPT_LOC_HEAD.equals(scLoc) && OPT_LOC_HEAD.equals(siLoc) && OPT_LOC_HEAD.equals(sgLoc)) 					
						|| (OPT_LOC_HEAD.equals(stLoc) && OPT_LOC_NOUSE.equals(scLoc) && OPT_LOC_HEAD.equals(siLoc) && OPT_LOC_NOUSE.equals(sgLoc))
						|| (OPT_LOC_HEAD.equals(stLoc) && OPT_LOC_HEAD.equals(scLoc) && OPT_LOC_HEAD.equals(siLoc) && OPT_LOC_NOUSE.equals(sgLoc))
						|| (OPT_LOC_HEAD.equals(stLoc) && OPT_LOC_NOUSE.equals(scLoc) && OPT_LOC_HEAD.equals(siLoc) && OPT_LOC_HEAD.equals(sgLoc)) ) {	
					if((StringUtils.isNotEmpty(params.getString("langGb")) && params.getString("langGb").equals("ENG"))){
						rec.put("COL_dtaVal", "Statistical Value");
					}else{
						rec.put("COL_dtaVal", "통계값");
					}
				}
				
				if ( sheetLoc.equals(stLoc) ) {
					params.put("wrttimeId", r.getString("wrttimeId"));
					//시계열(자료시점) 주석 식별자는 별도 호출한다.
					String cmmtIdtfr = (r.getString("cmmtIdtfr")).replaceAll(",", ") ");
					rec.put("wrttimeId", r.getString("wrttimeNm") + ( cmmtIdtfr == "" ? "" : "&nbsp;<span style='"+ STAT_CELL_STYLE_CMMT + "'>" + cmmtIdtfr + ")</span>" ));
				}
				
				if ( !"".equals(r.getString("cmmtIdtfr")) ) {
					rec.put("statblNm", r.getString("statblNm") + "&nbsp;<span style='"+ STAT_CELL_STYLE_CMMT +"'>" + r.getString("cmmtIdtfr") + ")</span>");
				}
				else {
					rec.put("statblNm", r.getString("statblNm"));		//통계표명
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
					
					// 사칙연산 분석화면
					if ( StringUtils.equals(multiStatType, MultiStatListController.MULTI_STAT_TYPE_FC) ) {
						rec.put("alphaOprt", r.getString("alphaOprt"));	// 기호
					}
				}
				
				if ( "T".equals(params.getString("viewLocOpt")) ) {
					//표로 보기 할 경우 컬럼 text값
					rec.put("tsViewCol", r.getString("wrttimeNm"));
				}
				/* 복수통계는 합계 지원하지 않음
			if ( tMap.size() == 0 && OPT_LOC_HEAD.equals(siLoc) && DEF_VIEW_OPTION_TSSUM_LOC_FIRST.equals(defViewOptionTSSumLoc) ) {
				//시계열 합계 위치가 처음인 경우 최초 한번만 합계 row 입력
				Record sumRec = new Record();
				for ( Object key : rec.keySet() ) {
					if((StringUtils.isNotEmpty(params.getString("langGb")) && params.getString("langGb").equals("ENG"))){
						sumRec.put(String.valueOf(key), "Total");
					}else{
						sumRec.put(String.valueOf(key), "합계");
					}
				}
				tMap.put("itmSum", sumRec);	
			}
				 */
				
				// 사칙연산 화면인경우 결과 행(가장 위) 추가(항목 기준으로 움직임)
				if ( tMap.size() == 0 && OPT_LOC_LEFT.equals(siLoc) && StringUtils.equals(multiStatType, MultiStatListController.MULTI_STAT_TYPE_FC) ) {
					Record fCalcRec = new Record();
					for ( Object key : rec.keySet() ) {
						if((StringUtils.isNotEmpty(params.getString("langGb")) && params.getString("langGb").equals("ENG"))){
							fCalcRec.put(String.valueOf(key), "Result");
						}else{
							fCalcRec.put(String.valueOf(key), "계산결과" + ( StringUtils.isNotEmpty(params.getString("calcAqnNm")) ? "("+params.getString("calcAqnNm")+")" : "") );
						}
					}
					fCalcRec.put("uiNm", "");		// 값 비움(시트에 표시 안함)
					fCalcRec.put("alphaOprt", "");
					tMap.put("calcVal", fCalcRec);	
				}
				
				tMap.put(r.getString("sheetKey"), rec);	//시트 분류정보 입력후 map객체에 저장
				
				copyRec = rec;
			}
			/* 복수통계는 합계 지원하지 않음
		if ( OPT_LOC_HEAD.equals(siLoc) && DEF_VIEW_OPTION_TSSUM_LOC_LAST.equals(defViewOptionTSSumLoc) ) {
			Record sumRec = new Record();
			for ( Object key : copyRec.keySet() ) {
				if((StringUtils.isNotEmpty(params.getString("langGb")) && params.getString("langGb").equals("ENG"))){	
					sumRec.put(String.valueOf(key), "Total");
				}else{
					sumRec.put(String.valueOf(key), "합계");
				}
			}
			tMap.put("itmSum", sumRec);	
		}*/
			
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
			
			// 복수통계 - 화면에 따른 분기 처리(기본=복수통계, MULTI_STAT_TYPE_BP=기준시점대비 변동분석 화면, MULTI_STAT_TYPE_FC=사칙연산 분석 화면)
			List<Record> dataList = null;
			
			// 기준시점대비 변동분석 데이터 조회
			if ( StringUtils.equals(multiStatType, MultiStatListController.MULTI_STAT_TYPE_BP) ) {	
				// 증감분석 데이터 키값으로 구분(기준시점대비는 값을 실시간으로 계산하기 때문에 증감분석 구분을 위해 각각 키값으로 설정해 둔다) - SQL에서 사용
				Params dvsOptionParam = new Params();
				dvsOptionParam.set("grpCd", "S1251");
				List<Record> dvsOption = (List<Record>) statListDao.selectOption(dvsOptionParam);
				
				for ( Record r : dvsOption ) {
					if ( iterDtadvsVal.contains(r.getString("code")) ) {	// 넘어온 증감분석 값이 있는경우
						params.set("dtadvs" + r.getString("code"), "Y");
					}
					else {
						params.set("dtadvs" + r.getString("code"), "N");
					}
				}
				
				dataList = multiStatListDao.selectBPointStatSheetData(params);
			}	// 사칙연산 분석 데이터 조회
			else if ( StringUtils.equals(multiStatType, MultiStatListController.MULTI_STAT_TYPE_FC) ) {
				dataList = multiStatListDao.selectMultiStatSheetData(params);	// 원 데이터
				
				// 사칙연산한 결과 데이터
				List<Record> calcList = selectMultiStatCalcList(dataList, params);
				
				dataList.addAll(calcList);	// 원 데이터에 사칙연산 한 데이터를 추가해준다.
			}
			else {
				dataList = multiStatListDao.selectMultiStatSheetData(params);
			}
			
			for ( Record d : dataList ) {
				String lKey = d.getString("lKey");				//sheet left key
				String hKey = d.getString("hKey");				//sheet head key
				String dtaVal = d.getString("dtaVal");			//값
				String cmmtIdtfr = d.getString("cmmtIdtfr");	//주석 식별자
				
				if ( StringUtils.isNotEmpty(lKey) ) {	//혹시 모를 nullPointException 방지..
					if ( !"".equals(cmmtIdtfr) ) {
						//주석만 있는 데이터
						tMap.get(lKey).put(hKey, "<span style='"+ STAT_CELL_STYLE_CMMT +"'>" + cmmtIdtfr + "</span>&nbsp;&nbsp;&nbsp;" + dtaVal);
					} else {
						//일반 데이터
//					System.out.println("lKey="+lKey);
						tMap.get(lKey).put(hKey, dtaVal);
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
		} catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		
		return list;
	}
	
	/*
	 * 자료시점 조회
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Record> statMultiWrtTimeOption(Params params) {
		List<Record> result = new ArrayList<Record>();
		
		try {
			List<Record> resultOptDC = (List<Record>) statListDao.selectStatTblOptVal(params);
			if ( resultOptDC.size() > 0 ) {
				params.put("dtacycleCd", resultOptDC.get(0).getString("optVal"));
			}
			
			result = (List<Record>) multiStatListDao.selectStatMultiWrtTimeOption(params);
			
		}  catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return result;
	}
	
	/**
	 * 복수통계 선택된 시계열 통계에 따른 항목/분류를 변수에 담는다.
	 */
	@SuppressWarnings({ "unused", "null", "unchecked" })
	public void makeStatTabMVal(Params params) {
		
		HashMap<String, HashMap> map = new HashMap<String, HashMap>();
		List<String> chkStatblList = new ArrayList<String>();
		List<String> statblList = null;
		List<String> grpList = null;
		List<String> clsList = null;
		List<String> itmList = null;
		
		List<Object> itmSqlGenerate = new ArrayList<Object>();
		HashMap<String, String> itmSqlMap = null;
		
		List<HashMap> dtaMap = new ArrayList();
		
		int idx = 0;
		if ( StringUtils.isNotBlank(params.getString("sMixval")) ) {
			String[] rows = params.getString("sMixval").split("\\|");
			for ( String row : rows ) {
				String[] rowKey = row.split("-");
				
				if ( rowKey.length > 0 ) {
					
					String statblId = rowKey[0];
					
					chkStatblList.add(statblId);	// 통계표 리스트 전체
					
					if ( map.containsKey(statblId) ) {	// 통계표 값이 있으면
						HashMap<String, ArrayList> tmpMap = map.get(statblId);
						tmpMap.get("grpList").add(rowKey[1]);
						tmpMap.get("clsList").add(rowKey[2]);
						tmpMap.get("itmList").add(rowKey[3]);
					}
					else {
						statblList = new ArrayList<String>();
						grpList = new ArrayList<String>();
						clsList = new ArrayList<String>();
						itmList = new ArrayList<String>();
						statblList.add(statblId);
						grpList.add(rowKey[1]);
						clsList.add(rowKey[2]);
						itmList.add(rowKey[3]);
						
						HashMap<String, List> tmpMap = new HashMap<String, List>();
						tmpMap.put("statblList", statblList);
						tmpMap.put("grpList", grpList);
						tmpMap.put("clsList", clsList);
						tmpMap.put("itmList", itmList);
						map.put(statblId, tmpMap);	// 맵에 데이터를 구분을 통계표ID로 생성해준다.
					}
					
					// ITM, DATA 조회 쿼리에서 생성할 UNION ALL 절
					itmSqlMap = new HashMap<String, String>();
					itmSqlMap.put("statblId", statblId);
					itmSqlMap.put("grpNo", rowKey[1]);
					itmSqlMap.put("clsNo", rowKey[2]);
					itmSqlMap.put("itmNo", rowKey[3]);
					itmSqlMap.put("vOrder", String.valueOf(++idx));	// V_ORDER
					itmSqlGenerate.add(itmSqlMap);
				}
			}
			
			// 각 아이템들 중복제거하고 IBATIS Iterate 수행을 위해 변수 재설정
			Iterator<String> iter = map.keySet().iterator();
			while ( iter.hasNext() ) {
				HashMap<String, List> iterMap = map.get((String)iter.next());
				List<String> allList = new ArrayList<String>();
				allList.addAll(iterMap.get("grpList"));
				allList.addAll(iterMap.get("itmList"));
				allList.addAll(iterMap.get("clsList"));
				
				iterMap.put("allList", new ArrayList<String>(new HashSet<String>(allList)));	// 전체 데이터번호 합친 리스트(SQL에서 필요함)
				iterMap.put("grpList", new ArrayList<String>(new HashSet<String>(iterMap.get("grpList"))));
				iterMap.put("clsList", new ArrayList<String>(new HashSet<String>(iterMap.get("clsList"))));
				iterMap.put("itmList", new ArrayList<String>(new HashSet<String>(iterMap.get("itmList"))));
				
				dtaMap.add(iterMap);
			}
			
			params.set("statblId", chkStatblList.get(0));	// 통계표(기준 통계표 하나만 입력) - 주기같은 데이터를 조회하기 위함
			params.set("iterChkStats", new ArrayList<String>(new HashSet<String>(chkStatblList)));	// 통계표 리스트(중복제거) 
			params.set("wheresMultiData", dtaMap);			// 통계표주석, 통계표단위에서 사용할 LIST
			params.set("multiDataList", itmSqlGenerate);	// ITM, DATA 조회 쿼리에서 사용할 LIST
		}

		// 사칙연산만 기호를 입력한다.
		if ( StringUtils.equals(params.getString(MultiStatListController.MULTI_STAT_TYPE), MultiStatListController.MULTI_STAT_TYPE_FC) 
				&& StringUtils.isNotBlank(params.getString("sAlphaOprt")) && params.containsKey("multiDataList") ) {
			List<HashMap> itmSqlList = (List<HashMap>) params.get("multiDataList");
			String[] arrAlphaOprt = params.getString("sAlphaOprt").split("\\|");
			for ( int i=0; i < itmSqlList.size(); i++ ) {
				if ( StringUtils.isNotEmpty(arrAlphaOprt[i]) ) {
					itmSqlList.get(i).put("alphaOprt", arrAlphaOprt[i]);
				}
			}
		}
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
	
	/**
	 * 통계스크랩 정보를 등록한다.
	 */
	@Override
	public Record saveStatMultiUserTbl(Params params) {
		try {
			
			makeStatTabMVal(params);
			
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
			params.set("lsWrttimeIdtfrId", params.getString("wrtStartYmd"));
			params.set("leWrttimeIdtfrId", params.getString("wrtEndYmd"));
			
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
				multiStatListDao.insertStatMultiUserTbl(params);
				
				// 그룹, 분류, 항목 데이터 저장
				multiStatListDao.insertStatMultiUserTblItm(params);	
				
				strMsg = "통계스크랩이 저장되었습니다.";
			} else if ( params.getString(ModelAttribute.ACTION_STATUS).equals(ModelAttribute.ACTION_UPD) ) {
				/* 통계스크랩 마스터 정보 수정 */
				multiStatListDao.updateStatMultiUserTbl(params);
				
				multiStatListDao.deleteStatMultiUserTblItm(params);	//삭제하고
				multiStatListDao.insertStatMultiUserTblItm(params);	// 그룹, 분류, 항목 데이터 저장
				
				strMsg = "통계스크랩이 수정되었습니다.";
			}

			Record result = new Record();
			result.put(Result.SUCCESS,  true);
			result.put(Result.MESSAGES, strMsg);
			result.put("usrTblSeq", params.getInt("seqceNo"));
			return result;
		} catch (DataAccessException e) {
			EgovWebUtil.exTransactionLogging(e);
			Record result = new Record();
			result.put(Result.SUCCESS,  false);
			result.put(Result.MESSAGES, "시스템 오류가 발생하였습니다.");
			return result;
		} catch (Exception e) {
			EgovWebUtil.exTransactionLogging(e);
			Record result = new Record();
			result.put(Result.SUCCESS,  false);
			result.put(Result.MESSAGES, "시스템 오류가 발생하였습니다.");
			return result;
		}
	}

	@Override
	public Record statMultiUserTbl(Params params) {
		Record rtn = new Record();
		StringBuffer sb = new StringBuffer();

		Record usrTbl = multiStatListDao.selectStatMultiUserTbl(params);
		if ( usrTbl != null ) {
			sb.append("statblId=" + usrTbl.getString("statblId"));
			sb.append("&viewLocOpt=" + usrTbl.getString("pivotCd"));			//피봇보기 구분
			sb.append("&optST=" + usrTbl.getString("pivotDcCd"));				//피봇보기 시계열 위치코드
			sb.append("&optSI=" + usrTbl.getString("pivotItmCd"));				//피봇보기 항목 위치코드
			sb.append("&optSC=" + usrTbl.getString("pivotClsCd"));				//피봇보기 구분 위치코드
			
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
					sb.append("&wrttimeMinYear=" + resultDta.get(0).getString("code"));								//기간 년도 최소값
					sb.append("&wrttimeMaxYear=" + resultDta.get(resultDta.size() - 1).getString("code"));			//기간 년도 최대값	
					sb.append("&wrttimeStartYear=" + resultDta.get(0).getString("code"));							//기간 년도 시작값
					sb.append("&wrttimeEndYear=" + resultDta.get(resultDta.size() - 1).getString("code"));			//기간 년도 종료값
					StatListController.getWrttimeQt(sb, usrTbl.getString("dtacycleCd"));							//주기에 따른 시점 세팅
				}
			} else {
				sb.append("&wrttimeMinYear=" + usrTbl.getString("startWrttimeIdtfrId").substring(0, 4));	//기간 년도 최소값
				sb.append("&wrttimeMaxYear=" + usrTbl.getString("endWrttimeIdtfrId").substring(0, 4));		//기간 년도 최대값
				sb.append("&wrttimeStartYear=" + usrTbl.getString("startWrttimeIdtfrId").substring(0, 4));	//기간 년도 시작값
				sb.append("&wrttimeEndYear=" + usrTbl.getString("endWrttimeIdtfrId").substring(0, 4));		//기간 년도 종료값
				sb.append("&wrttimeStartQt=" + usrTbl.getString("startWrttimeIdtfrId").substring(4, 6));	//기간 쿼터 시작값(ex:1분기, 하반기, 1월...)
				sb.append("&wrttimeEndQt=" + usrTbl.getString("endWrttimeIdtfrId").substring(4, 6));		//기간 쿼터 종료값
				sb.append("&wrttimeMinQt=" + usrTbl.getString("startWrttimeIdtfrId").substring(4, 6));
				sb.append("&wrttimeMaxQt=" + usrTbl.getString("endWrttimeIdtfrId").substring(4, 6));
			}
			
			sb.append("&dmPointVal=" + usrTbl.getString("dmpointCd"));			//소수점 코드
			sb.append("&uiChgVal=" + usrTbl.getString("uiId"));					//단위 코드
			sb.append("&statblNm=" + usrTbl.getString("statblNm"));				//통계자료명
			sb.append("&dtaWrttime=" + usrTbl.getString("dtaWrttime"));			//기준시점
			sb.append("&dtaCalcNullToZero=" + usrTbl.getString("null2zeroYn"));	//NULL값 0으로 계산
			sb.append("&calcAqnNm=" + usrTbl.getString("calcAqnNm"));			//사칙연산 지표
			sb.append("&calcAqn=" + usrTbl.getString("calcAqn"));				//사칙연산 수식
		}
		
		//복수통계 시계열항목은 다건통계를 감안해서 데이터화 한다.
		StringBuffer sbFcalc = new StringBuffer();
		List<Record> itmList = (List<Record>) multiStatListDao.selectStatMultiUserTblItm(params);
		if ( itmList.size() > 0 ) {
			sb.append("&sMixval=");
			sbFcalc.append("&sAlphaOprt=");		// 사칙연산 기호
			List<String> tmpItmList = new ArrayList<String>();
			// String.join은 JAVA8 부터 지원
			for ( Record itm : itmList ) {
				//tmpItmList.add(String.join("-", itm.getString("statblId"), itm.getString("grpDataNo"), itm.getString("clsDataNo"), itm.getString("itmDataNo")));
				tmpItmList.add(itm.getString("statblId") +"-"+ itm.getString("grpDataNo") +"-"+ itm.getString("clsDataNo") +"-"+ itm.getString("itmDataNo"));
				sbFcalc.append(itm.getString("itmSbl")).append("|");
			}
			for ( int i = 0; i < tmpItmList.size(); i++ ) {
				sb.append(tmpItmList.get(i));
				if ( i < tmpItmList.size()-1 ) {	// 마지막에는 '|' 붙이지 않음
					sb.append("|");
				}
			}
			
			sbFcalc.delete(sbFcalc.length()-1, sbFcalc.length());	// 마지막에는 '|' 붙이지 않음
			
			//sb.append(String.join("|", tmpItmList));
		}

		if ( usrTbl != null ) {
			if(usrTbl.getString("ddTagCont") != null){
				String[] dtaList = usrTbl.getString("ddTagCont").split("\\|"); //<--------- UNCHECKED NULL(처리완료)
				for ( String dta : dtaList ) {
					sb.append("&dtadvsVal=" + dta);
				}
			}
			
			//복수통계는 통계스크랩의 고유키값을 넘긴다.
			sb.append("&usrTblSeq=" + params.getString("seqceNo"));
			
			rtn.put("firParam", sb.toString() + sbFcalc.toString());
			if(usrTbl.getString("statblId") != null){
				rtn.put("statblId", usrTbl.getString("statblId")); //<--------- UNCHECKED NULL(처리완료)
			}
		}
		
		return rtn;
	}
	
	/**
	 * 통계스크랩[복수통계] 시계열 정보 조회
	 */
	public List<Record> selectMultiName(Params params) {
		
		makeStatTabMVal(params);
		
		List<Object> multiDataList = (List<Object>) params.get("multiDataList");
		
		List<Record> returnList = new ArrayList<Record>();
		Params paramData = null;
		for ( int i=0; i < multiDataList.size(); i++ ) {
			HashMap map = (HashMap) multiDataList.get(i);
			paramData = new Params();
			paramData.set("dtacycleCd", params.getString("dtacycleCd"));
			paramData.set("statblId", map.get("statblId"));
			paramData.set("itmDatano", map.get("itmNo"));
			paramData.set("clsDatano", map.get("clsNo"));
			paramData.set("grpDatano", map.get("grpNo"));
			paramData.set("alphaOprt", map.get("alphaOprt"));
			returnList.add(multiStatListDao.selectMultiName(paramData));
		}
		return returnList;
	}

	/**
	 * 복수통계 시트 셀 제한시 다운로드(대용량)
	 * @param request
	 * @param response
	 * @param params
	 */
	@Override
	public void downloadStatSheetDataCUD(HttpServletRequest request, HttpServletResponse response, Params params) {
		try {
			//downloadStatDataXls(request, response, params);
			// 헤더 정보
			Map<String, Object> headMap = multiTblItm(params);
			
			// 데이터 정보
			params.set("STUseYn", "N");		// 헤더정보 조회할때 사용된 파라미터 초기화
			params.set("SIUseYn", "N");
			params.set("SCUseYn", "N");
			List<Record> dataMap = statMultiPreviewList(params);
						
			// 엑셀 다운로드
			DownloadStatExcel.downloadStatDataXls(response, request, params, headMap, dataMap);
			
		} catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		
	}
	
	/**
	 * 사칙연산 결과값을 조회한다.
	 * @param dataList	DB에서 조회한 데이터
	 * @param params	파라미터
	 * @return
	 */
	private List<Record> selectMultiStatCalcList(List<Record> dataList, Params params) {
		String calcNull2Zero = params.getString("dtaCalcNullToZero", "N");	// NULL값 0으로 계산여부
		String calcAqn = params.getString("calcAqn");			// 계산식
		String dmPointVal = params.getString("dmPointVal", "");		// 소수점 자기수
		List<Record> calcSqlGenerate = new ArrayList<Record>();		// 사칙연산 SQL 생성 LIST
		Record calcSqlMap = null;
		Record dummyRec = new Record();
		
		boolean iFirst = true;	// 처음값 체크상태
				
		String prevWid = "";
		String prevHKey = "";
		String prevLKey = "";
		String optSI = params.getString("optSI");
		for ( int i=0; i < dataList.size(); i++ ) {
			Record data = dataList.get(i);
			String wid = data.getString("wrttimeIdtfrId");	// 시계열
			String alphaOprt = data.getString("alphaOprt");	// 기호
			String dtaVal = data.getString("dtaVal").replaceAll(",", "");
			
			// 현재 시계열과 이전 시계열이 같으면(데이터 자체에 ORDER BY WRTTIME_IDTFR_ID로 넘어와서 가능)
			if ( StringUtils.equals(prevWid, wid) ) {
				dummyRec.put(alphaOprt, dtaVal);
			}
			else {
				if ( !iFirst ) {	// 첫행 수행했을때는 시계열을 비교할수가 없으므로 무조건 패스
					String imsiCalcAqn = calcAqn;
					Iterator imsiIter = dummyRec.keySet().iterator();
					while ( imsiIter.hasNext() ) {
						String sKey = String.valueOf(imsiIter.next());
						String val = dummyRec.getString(sKey);
						if ( StringUtils.isNotBlank(val) ) {
							if ( val.indexOf("-") == 0 ) {	// 값이 음수인경우 양쪽에 괄호로 감싸준다
								imsiCalcAqn = imsiCalcAqn.replaceAll(sKey, "(" + val + ")");
							}
							else {
								imsiCalcAqn = imsiCalcAqn.replaceAll(sKey, val);
							}
						}
					}
					
					calcSqlMap = new Record();
					if ( StringUtils.equals(optSI, OPT_LOC_HEAD) ) {
						calcSqlMap.put("hKey", "calcVal");
						calcSqlMap.put("lKey", prevLKey);
					}
					else {
						calcSqlMap.put("hKey", prevHKey);
						calcSqlMap.put("lKey", "calcVal");
					}
					calcSqlMap.put("calcAqn", imsiCalcAqn);
					calcSqlMap.put("calcNull2Zero", calcNull2Zero);
					calcSqlMap.put("dmPointVal", dmPointVal);
					calcSqlGenerate.add(calcSqlMap);
				}
				
				iFirst = false;
				//dummyRec = new Record();
				dummyRec.put(alphaOprt, dtaVal);
			}
			
			// 데이터의 마지막인경우 맵에 추가해준다(마지막에는 위의 else 를 안타고 for가 끝나기 때문에 한번더 수행..)
			if ( i == dataList.size()-1 ) {
				String imsiCalcAqn = calcAqn;
				Iterator imsiIter = dummyRec.keySet().iterator();
				while ( imsiIter.hasNext() ) {
					String sKey = String.valueOf(imsiIter.next());
					String val = dummyRec.getString(sKey);
					if ( StringUtils.isNotBlank(val) ) {
						if ( val.indexOf("-") == 0 ) {	// 값이 음수인경우 양쪽에 괄호로 감싸준다
							imsiCalcAqn = imsiCalcAqn.replaceAll(sKey, "(" + val + ")");
						}
						else {
							imsiCalcAqn = imsiCalcAqn.replaceAll(sKey, val);
						}
					}
				}
				
				calcSqlMap = new Record();
				if ( StringUtils.equals(optSI, OPT_LOC_HEAD) ) {
					calcSqlMap.put("hKey", "calcVal");
					calcSqlMap.put("lKey", prevLKey);
				}
				else {
					calcSqlMap.put("hKey", prevHKey);
					calcSqlMap.put("lKey", "calcVal");
				}
				calcSqlMap.put("calcAqn", imsiCalcAqn);
				calcSqlMap.put("calcNull2Zero", calcNull2Zero);
				calcSqlMap.put("dmPointVal", dmPointVal);
				calcSqlGenerate.add(calcSqlMap);
			}
			else {
				prevWid = wid;
				prevHKey = data.getString("hKey");
				prevLKey = data.getString("lKey");
			}
		}
		
		params.put("calcSqlGenerate", calcSqlGenerate);
		
		// 사칙연산 데이터를 SQL문으로 생성하여 받는다.
		return multiStatListDao.selectMultiStatCalcRslt(params);
	}
	
}

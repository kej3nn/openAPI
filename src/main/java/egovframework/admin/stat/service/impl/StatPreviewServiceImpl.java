package egovframework.admin.stat.service.impl;

import java.io.File;
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

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import egovframework.admin.stat.service.StatPreviewService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.service.BaseService;
import egovframework.common.base.view.FileDownloadView;

/**
 * 통계표 표준 단위 정의 서비스
 * 
 * @author	김정호
 * @version 1.0
 * @since   2017/06/28
 */

@Service(value="statPreviewService")
public class StatPreviewServiceImpl extends BaseService implements StatPreviewService {

	@Resource(name="statPreviewDao")
	protected StatPreviewDao statPreviewDao;
	
	@Resource(name="statInputDao")
	protected StatInputDao statInputDao;
	
	@Resource(name="statsMgmtDao")
	protected StatsMgmtDao statsMgmtDao;
	
	private static final String OPT_LOC_HEAD = "H";		//표두
	private static final String OPT_LOC_LEFT = "L";		//표측
	private static final String OPT_LOC_NOUSE = "N";	//사용안함
	
	private static final String OPT_CODE_SI = "SI";		//통계표 위치 옵션(항목)
	private static final String OPT_CODE_SC = "SC";		//통계표 위치 옵션(분류)
	private static final String OPT_CODE_ST = "ST";		//통계표 위치 옵션(시계열)
	private static final String OPT_CODE_SG = "SG";		//통계표 위치 옵션(그룹)
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
	
	/**
	 * 자료시점 조회
	 */
	@Override
	public List<Record> statWrtTimeOption(Params params) {
		//통계 데이터셋 연계정보 조회
		Map<String, Object> stddDscn = (Map<String, Object>) statInputDao.selectStatInputDscn(params);
		params.set("ownerCd", stddDscn.get("ownerCd"));					//대상 owner
		params.set("dsId", stddDscn.get("dsId"));						//대상 데이터셋명
		
		return (List<Record>) statPreviewDao.selectStatWrtTimeOption(params);
	}
	
	/**
	 * 통계표 단위 조회
	 */
	@Override
	public List<Record> statTblUi(Params params) {
		return (List<Record>) statPreviewDao.selectStatTblUi(params);
	}

	/**
	 * 통계표 통계자료유형 조회
	 */
	@Override
	public List<Record> statTblDtadvs(Params params) {
		return (List<Record>) statPreviewDao.selectStatTblDtadvs(params);
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
	 */
	@Override
	public Map<String, Object> statTblItm(Params params) {
		String strGroupTxt = getMessage("stat.ko.group", "그룹");
		Map<String, Object> map = new HashMap<String, Object>();
		
		String sheetLoc = OPT_LOC_HEAD;		//헤더 설정하는 중..
		params.set("SheetLoc", sheetLoc);
		
		int iMaxLevel = 0;		//항목 레벨(headText row 수)
		int iCateCnt = 0;		//분류 갯수
		int iItmCnt = 0;		//항목 갯수
		int iGrpCnt = 0;		//그룹 갯수
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
		List<Record> defViewOptionIU = (List<Record>) statPreviewDao.selectStatTblOptVal(params);
		if ( defViewOptionIU.size() > 0 ) {
			defViewOptionUiYn = defViewOptionIU.get(0).getString("optVal");
		}
		
		//기본보기 옵션(시계열 합계 출력 위치)
		params.set("optCd", "TL");
		List<Record> defViewOptionTL = (List<Record>) statPreviewDao.selectStatTblOptVal(params);
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
		
		//통계 데이터셋 연계정보 조회(실 데이터에서 있는 항목들만 조회)
		Map<String, Object> stddDscn = (Map<String, Object>) statInputDao.selectStatInputDscn(params);
		params.set("ownerCd", stddDscn.get("ownerCd"));					//대상 owner
		params.set("dsId", stddDscn.get("dsId"));						//대상 데이터셋명
		
		List<HashMap<String, Object>> cols = new LinkedList<HashMap<String, Object>>();		//ibsheet 컬럼 정보
		ArrayList<Object> gridTxt = new ArrayList<Object>();								//ibsheet headText 정보
		ArrayList<String> colTxt = null;
		
		//헤더정보 조회
		List<Record> list = (List<Record>) statPreviewDao.selectStatTblItm(params);	
		
		/**
		 * 기본적으로 생성되는 시트 헤더정보 
		 */
		//시트 location에 따라 max레벨 증가
		if ( sheetLoc.equals(stLoc) ) {
			iMaxLevel = iMaxLevel + ROW_CNT_WRTTIME;
		} 
		if ( sheetLoc.equals(sgLoc) ) {
			iMaxLevel = iMaxLevel + list.get(0).getInt("maxGrpLevel");
		} 
		if ( sheetLoc.equals(scLoc) ) {
			iMaxLevel = iMaxLevel + list.get(0).getInt("maxClsLevel");
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
			gridTxt.add(sheetInputColTxt(iMaxLevel, "통계값"));
			cols.add( addSheetCol("Text", "COL_dtaVal", 60, "Center", true) );
		}
		
		//설정 위치에 따라 표측에 존재할 경우 ibsheet 컬럼 생성
		if ( OPT_LOC_LEFT.equals(stLoc) ){	//시계열
			gridTxt.add(sheetInputColTxt(iMaxLevel, "자료시점"));
			cols.add( addSheetCol("Html", "wrttimeId", 90, "Center", true));
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
				gridTxt.add(sheetInputColTxt(iMaxLevel, "분류"));
				cols.add( addSheetCol("Html", ITM_CLS_KEYNM + String.valueOf(++iCateCnt), 90, "Left", true));
			}
		}
		
		if ( OPT_LOC_LEFT.equals(siLoc) ){	//항목
			int leftColCnt = ((BigDecimal) list.get(0).get("maxItmLevel")).intValue();
			for ( int i=0; i < leftColCnt; i++ ) {				
				gridTxt.add(sheetInputColTxt(iMaxLevel, "항목"));
				cols.add( addSheetCol("Html", ITM_ITM_KEYNM + String.valueOf(++iItmCnt), 90, "Left", true));
			}
			
			//단위는 기본보기 옵션에 따라 출력여부 표시하고 통계자료는 항목이 있을경우 따라다닌다.
			if ( "Y".equals(defViewOptionUiYn) ) {
				gridTxt.add(sheetInputColTxt(iMaxLevel, "단위"));
				cols.add( addSheetCol("Text", "uiNm", 60, "Center", false) );		//단위
			}
			
			gridTxt.add(sheetInputColTxt(iMaxLevel, "통계자료"));
			cols.add( addSheetCol("Text", "dtadvsNm", 120, "Left", true) );	//통계자료
			
			dtadvsRowColCnt = gridTxt.size() - 1;	//현재 통계자료 row 위치
			
			//시계열 위치가 앞쪽인 경우 합계 표시
			if ( DEF_VIEW_OPTION_TSSUM_LOC_FIRST.equals(defViewOptionTSSumLoc) ) {
				gridTxt.add(sheetInputColTxt(iMaxLevel, "합계"));
				cols.add( addSheetCol("Text", "itmSum", 60, "Right", false) );		//합계
			}
		}
		
		if ( "T".equals(params.getString("viewLocOpt")) ) {
			//표로 보기 할 경우 컬럼 추가
			gridTxt.add(sheetInputColTxt(iMaxLevel, "주기"));
			cols.add( addSheetCol("Text", "tsViewCol", 90, "Center", true) );
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
				//colTxt.add(r.getString("wrttimeNm"));
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
			gridTxt.add(sheetInputColTxt(iMaxLevel, "합계"));
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
		
		return map;
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
		
		String sheetLoc = OPT_LOC_LEFT;
		params.set("SheetLoc", sheetLoc);
		
		//통계 데이터셋 연계정보 조회
		Map<String, Object> stddDscn = (Map<String, Object>) statInputDao.selectStatInputDscn(params);
		params.set("ownerCd", stddDscn.get("ownerCd"));					//대상 owner
		params.set("dsId", stddDscn.get("dsId"));						//대상 데이터셋명
		
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
			params.set("optSG", sgLoc);		// 그룹
		}
		
		//기본보기 옵션(항목단위 출력여부 조회)
		String defViewOptionUiYn = "N";	
		params.set("optCd", "IU");
		List<Record> defViewOptionIU = (List<Record>) statPreviewDao.selectStatTblOptVal(params);
		if ( defViewOptionIU.size() > 0 ) {
			defViewOptionUiYn = defViewOptionIU.get(0).getString("optVal");
		}
		
		//기본보기 옵션(시계열 합계 출력 위치 'S1005 => F:처음, L:마지막, N:없음)
		String defViewOptionTSSumLoc = "N";
		params.set("optCd", "TL");
		List<Record> defViewOptionTL = (List<Record>) statPreviewDao.selectStatTblOptVal(params);
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
		List<Record> itmList = (List<Record>) statPreviewDao.selectStatTblItm(params);
		
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
				rec.put("COL_dtaVal", "통계값");
			}
			
			if ( sheetLoc.equals(stLoc) ) {
				params.put("wrttimeId", r.getString("wrttimeId"));
				String wrttimeCmtIdtfr = r.getString("wrttimeCmtIdtfr");
				//rec.put("wrttimeId", r.getString("wrttimeNm"));
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
			
			// 분류
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
					sumRec.put(String.valueOf(key), "합계");
				}
				tMap.put("itmSum", sumRec);	
			}
			
			tMap.put(r.getString("sheetKey"), rec);	//시트 분류정보 입력후 map객체에 저장
			
			copyRec = rec;
		}
		
		if ( OPT_LOC_HEAD.equals(siLoc) && DEF_VIEW_OPTION_TSSUM_LOC_LAST.equals(defViewOptionTSSumLoc) ) {
			Record sumRec = new Record();
			for ( Object key : copyRec.keySet() ) {
				sumRec.put(String.valueOf(key), "합계");
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
		List<Record> dataList = statPreviewDao.selectStatSheetData(params);
		for ( Record d : dataList ) {
			String lKey = d.getString("lKey");				//sheet left key
			String hKey = d.getString("hKey");				//sheet head key
			String dtaVal = d.getString("dtaVal");			//값
			String cmmtIdtfr = d.getString("cmmtIdtfr");	//주석 식별자
			String wrtstateCd = d.getString("wrtstateCd");	//승인상태
			
			if ( StringUtils.isNotEmpty(lKey) ) {	//혹시 모를 nullPointException 방지..
				if ( !"".equals(cmmtIdtfr) && !"".equals(wrtstateCd) && !WRT_STATE_CD_AC.equals(wrtstateCd) ) {
					//주석이 있고 승인되지 않은 경우(주석 색 표시 및 데이터바탕에 노랑색 표시
					if ( tMap.containsKey(lKey) ) {
						tMap.get(lKey).put(hKey, "<span style='"+ STAT_CELL_STYLE_CMMT +"'>" + cmmtIdtfr + "</span>&nbsp;&nbsp;&nbsp;<span style='"+ STAT_CELL_STYLE_WRT_STATE_AC +"'>"+ dtaVal +"</span>");
					}
				} else if ( !"".equals(cmmtIdtfr) ) {
					//주석만 있는 데이터
					if ( tMap.containsKey(lKey) ) {
						tMap.get(lKey).put(hKey, "<span style='"+ STAT_CELL_STYLE_CMMT +"'>" + cmmtIdtfr + "</span>&nbsp;&nbsp;&nbsp;" + dtaVal);
					}
				} else if ( !"".equals(wrtstateCd) && !WRT_STATE_CD_AC.equals(wrtstateCd) ) {
					//승인되지 않은 데이터
					if ( tMap.containsKey(lKey) ) {
						tMap.get(lKey).put(hKey, "<span style='"+ STAT_CELL_STYLE_WRT_STATE_AC +"'>"+ dtaVal +"</span>");
					}
				} else {
					//일반 데이터
					//log.debug("lKey="+lKey + " / hkey="+hKey+" / dtaVal="+dtaVal);
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
			/*
			
			if ( (OPT_LOC_LEFT.equals(siLoc) && OPT_LOC_HEAD.equals(stLoc)) || (OPT_LOC_HEAD.equals(siLoc) && OPT_LOC_LEFT.equals(stLoc)) ) {
				dataSumGroup = "I";
			} else if ( (OPT_LOC_HEAD.equals(stLoc) && OPT_LOC_HEAD.equals(siLoc)) || (OPT_LOC_LEFT.equals(stLoc) && OPT_LOC_LEFT.equals(siLoc)) ) {
				dataSumGroup = "ITC";
			}*/
		}	// 그룹이 없을경우
		else if ( OPT_LOC_NOUSE.equals(sgLoc) ) {	
			
		}
		return dataSumGroup;
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
		Map<String, String> optLocMap = statPreviewDao.selectStatTblOptLocation(params);	//항목, 분류, 시계열 표두/표측 위치 조회(H:표두, L:표측)
		
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
		}	// 가로보기
		else if("H".equals(viewLocOpt)){
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
		}	// 세로보기
		else if("V".equals(viewLocOpt)){
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
		}	// 년월보기
		else if("T".equals(viewLocOpt)){
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
				map.put("SG", OPT_LOC_LEFT);
				map.put("SI", OPT_LOC_LEFT);
				map.put("TBL", OPT_LOC_LEFT);
			}
			//171121 김정호 - 표로보기(년월보기)시 주기가 상단으로 위치되도록 수정
			map.put("ST", OPT_LOC_HEAD);
			map.put("SC", OPT_LOC_LEFT);
			map.put("SI", OPT_LOC_LEFT);
			map.put("SG", OPT_LOC_LEFT);
		}	// 사용자 보기
		else if("U".equals(viewLocOpt)){
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
	 * 통계표 옵션 값 조회
	 */
	@Override
	public List<Record> statTblOptVal(Params params) {
		return (List<Record>) statPreviewDao.selectStatTblOptVal(params);
	}

	/**
	 * 통계표 항목분류 리스트 조회
	 */
	@Override
	public List<Record> statTblItmJson(Params params) {
		return (List<Record>) statPreviewDao.selectStatTblItmJson(params);
	}

	/**
	 * 통계표 주석 리스트 조회
	 */
	@Override
	public List<Record> statCmmtList(Params params) {
		//통계 데이터셋 연계정보 조회
		Map<String, Object> stddDscn = (Map<String, Object>) statInputDao.selectStatInputDscn(params);
		params.set("ownerCd", stddDscn.get("ownerCd"));					//대상 owner
		params.set("dsId", stddDscn.get("dsId"));						//대상 데이터셋명
		
		return (List<Record>) statPreviewDao.selectStatCmmtList(params);
	}
	
	/**
	 * 통계설명 팝업 리스트 조회
	 */
	public List<Record> statSttsStatMetaList(Params params) {
		return (List<Record>) statPreviewDao.selectStatSttsStatMetaList(params);
	}
	
	/**
	 * 통계표 정보 상세조회(단건)
	 */
	public Record statSttsTblDtl(Params params) {
		return statPreviewDao.selectStatSttsTblDtl(params);
	}
	
	/**
	 * 연관된 통계표 리스트 조회
	 */
	@Override
	public List<Record> statSttsTblReferenceStatId(Params params) {
		return (List<Record>) statPreviewDao.selectStatSttsTblReferenceStatId(params);
	}

	/**
	 * 통계메타 파일 조회(단건)
	 */
	@Override
	public Record downloadStatMetaFile(Params params) {
		Record file = statPreviewDao.selectDownloadStatMetaFile(params);
		file.put(FileDownloadView.FILE_PATH, getFilePath(file));
        file.put(FileDownloadView.FILE_NAME, getFileName(file));
        file.put(FileDownloadView.FILE_SIZE, getFileSize(file));
        return file;
	}
	
	/**
	 * 파일 경로를 반환한다.
	 * @param file
	 * @return
	 */
	private String getFilePath(Record file) {
        StringBuffer buffer = new StringBuffer();
        
        buffer.append(EgovProperties.getProperty("Globals.StatSttsStatMetaFilePath"));
        buffer.append(file.getString("statId"));
        buffer.append(File.separator);
        buffer.append(EgovWebUtil.filePathReplaceAll(file.getString("saveFileNm")));
        buffer.append(".");
        buffer.append(file.getString("fileExt"));
        
        return buffer.toString();
    }
	
	/**
	 * 파일 이름을 반환한다.
	 * @param file
	 * @return
	 */
	private String getFileName(Record file) {
        StringBuffer buffer = new StringBuffer();
        
        buffer.append(file.getString("viewFileNm"));
        buffer.append(".");
        buffer.append(file.getString("fileExt"));
        
        return buffer.toString();
    }
	
	/**
	 * 파일 크기를 반환한다.
	 * @param file
	 * @return
	 */
	private String getFileSize(Record file) {
        return file.getString("fileSize");
    }

	/**
	 * 통계표 정보를 조회한다.
	 */
	@Override
	public Map<String, Object> statTblDtl(Params params) {
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("statblId", params.getString("statblId"));
		return statsMgmtDao.selectStatsMgmtDtl(paramMap);
	}

	/**
	 * 통계표 관리에 선택된 작성주기만 조회
	 * @param params
	 * @return
	 */
	public List<Record> statCheckedDtacycleList(Params params) {
		return (List<Record>) statPreviewDao.selectStatCheckedDtacycleList(params);
	}
}

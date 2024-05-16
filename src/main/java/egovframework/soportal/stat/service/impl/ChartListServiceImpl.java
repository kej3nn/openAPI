package egovframework.soportal.stat.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.soportal.stat.service.ChartListService;
import egovframework.soportal.stat.service.StatListService;
import egovframework.soportal.stat.service.MultiStatListService;
import egovframework.admin.stat.service.StatPreviewService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.service.BaseService;

/**
 * 통계표를 관리하는 서비스 클래스
 * @author	김정호
 * @version 1.0
 * @since   2017/05/25
 */

@Service(value="chartListService")
public class ChartListServiceImpl extends BaseService implements ChartListService {
	
	@Resource(name="chartListDao")
	protected ChartListDao chartListDao;

	@Resource(name="statListDao")
	protected StatListDao statListDao;

	@Resource(name="statListService")
	protected StatListService statListService;
	
	@Resource(name="multiStatListService")
	protected MultiStatListService multiStatListService;
	
	@Resource(name="statPreviewService")
	protected StatPreviewService statPreviewService;
	
	private static final int MAX_CHART_ITM = 500;	// 차트 범례 제한 갯수

	/**
	 * [간편통계/상세분석] 통계표 챠트 > 조건에 따른 항목정보 및 데이터를 조회한다.
	 */
	public Map<String, Object> easyChartJson(Params params) {
		Map<String, Object> rMap = new HashMap<String, Object>();
		
		try {
			//통계 데이터셋 연계정보 조회
			Map<String, Object> stddDscn = (Map<String, Object>) statListDao.selectStatInputDscn(params);
			params.set("ownerCd", stddDscn.get("ownerCd"));					//대상 owner
			params.set("dsId", stddDscn.get("dsId"));						//대상 데이터셋명
			
			//통계자료 string[] => ibatis에서 사용하기 위해 array로 변경
			ArrayList<String> iterDtadvsVal = new ArrayList<String>(Arrays.asList(params.getStringArray("dtadvsVal")));
			params.set("iterDtadvsVal", iterDtadvsVal);
			
			statMakeItm(params);
			
			if(params.get("displayType").equals("S")){
				params.set("viewLocOpt", "B");
				params.set("wrttimeType", "L");
				params.set("wrttimeOrder", "A");
				params.set("dtadvsVal", "OD");
				
				params.set("optCd", "DC");
				List<Record> resultOptDC = (List<Record>) statPreviewService.statTblOptVal(params);
				params.set("dtacycleCd", resultOptDC.get(0).getString("optVal"));
				
				List<Record> resultDta = (List<Record>) statListService.statWrtTimeOption(params);
				
				if ( resultDta.size() > 0 ) {
					params.set("wrttimeMinYear", resultDta.get(0).getString("code"));								//기간 년도 최소값
					params.set("wrttimeMaxYear", resultDta.get(resultDta.size() - 1).getString("code"));	//기간 년도 최대값
				}
				
				String dtacycleCd = resultOptDC.get(0).getString("optVal");
				
				if ( "YY".equals(dtacycleCd) ) {//년
					params.set("wrttimeStartQt", "00");		//기간 시점 시작값
					params.set("wrttimeEndQt", "00");		//기간 시점 종료값
					params.set("wrttimeMinQt", "00");		//기간 시점 최소값
					params.set("wrttimeMaxQt", "00");		//기간 시점 최대값
				} else if ( "HY".equals(dtacycleCd) ) {	//반기
					params.set("wrttimeStartQt", "01");		//기간 시점 시작값
					params.set("wrttimeEndQt", "02");		//기간 시점 종료값
					params.set("wrttimeMinQt", "01");
					params.set("wrttimeMaxQt", "02");
				} else if ( "QY".equals(dtacycleCd) ) {	//분기
					params.set("wrttimeStartQt", "01");		//기간 시점 시작값
					params.set("wrttimeEndQt", "04");		//기간 시점 종료값
					params.set("wrttimeMinQt", "01");
					params.set("wrttimeMaxQt", "04");
				} else if ( "MM".equals(dtacycleCd) ) {//월
					params.set("wrttimeStartQt", "01");		//기간 시점 시작값
					params.set("wrttimeEndQt", "12");		//기간 시점 종료값
					params.set("wrttimeMinQt", "01");
					params.set("wrttimeMaxQt", "12");
				}
				
			}
			
			List<Map<String, Object>> optlist = statListDao.selectStatDtlOpt(params);
			String wrttimeLastestVal = "50";
			if (optlist.size() > 0) {
				for ( Map<String, Object> data : optlist ) {
					if ( "TC".equals(String.valueOf(data.get("optCd"))) ) wrttimeLastestVal = (String) data.get("optVal");
				}
			}
			
			//최초 통계 조회가 아닐 경우
			if(!params.getString("chartStockType").equals("HISTORY") && !params.getString("displayType").equals("S"))	wrttimeLastestVal = (String) params.getString("wrttimeLastestVal");
			
			params.set("wrttimeLastestVal", wrttimeLastestVal);
			
			rMap.put("divId", params.get("divId"));
			rMap.put("mapVal", params.get("mapVal"));
			rMap.put("displayType", params.get("displayType"));
			rMap.put("OPT_DATA", optlist);
			
			params.set("callType", "ITM");
			rMap.put("CHART_ITM", (List<Map<String, Object>>) chartListDao.easyChartItm(params)); //그룹 분류 항목 정보 호출
			
			params.set("callType", "WRT");
			rMap.put("CHART_WRT", (List<Map<String, Object>>) chartListDao.easyChartItm(params)); //시계열 정보 호출
			
			Params wrtParam = new Params();
			wrtParam.put("statblId", params.getString("statblId"));
			wrtParam.put("optCd", "DC");
			rMap.put("ONE_WRT", (List<Record>) statListService.statWrtTimeOption(wrtParam)); //시계열 년도 정보 확인
			
			if(params.getString("selCategories") != null && !params.getString("selCategories").equals("")){
				params.set("wrttimeMaxYear", params.getString("selCategories"));
				params.set("wrttimeEndYear", params.getString("selCategories"));
			}
			
			//데이터 호출
			rMap.put("CHART_DATA", (List<Map<String, Object>>) chartListDao.easyChartData(params));
			
		} catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return rMap;
	}
	
	/**
	 * [복수통계] 통계표 챠트를 위한 데이터 조회
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> multiChartJson(Params params) {
		Map<String, Object> rMap = new HashMap<String, Object>();
		
		multiStatListService.makeStatTabMVal(params);
		
		try {
			
			//통계 데이터셋 연계정보 조회
			Map<String, Object> stddDscn = (Map<String, Object>) statListDao.selectStatInputDscn(params);
			params.set("ownerCd", stddDscn.get("ownerCd"));					//대상 owner
			params.set("dsId", stddDscn.get("dsId"));						//대상 데이터셋명
			
			//통계자료 string[] => ibatis에서 사용하기 위해 array로 변경
			ArrayList<String> iterDtadvsVal = new ArrayList<String>(Arrays.asList(params.getStringArray("dtadvsVal")));
			params.set("iterDtadvsVal", iterDtadvsVal);
			//항목선택 string[] => ibatis에서 사용하기 위해 array로 변경
			ArrayList<String> iterChkItms = new ArrayList<String>(Arrays.asList(params.getStringArray("chkItms")));
			//params.set("iterChkItms", iterChkItms);
			params.set("iterChkItms", iterChkItms.size() > MAX_CHART_ITM ? null : iterChkItms);
			//분류선택 string[] => ibatis에서 사용하기 위해 array로 변경
			ArrayList<String> iterChkClss = new ArrayList<String>(Arrays.asList(params.getStringArray("chkClss")));
			//params.set("iterChkClss", iterChkClss);
			params.set("iterChkClss", iterChkClss.size() > StatListServiceImpl.MAX_CHK_ITM ? null : iterChkClss);
			
			//return (List<Record>) chartListDao.statMultiChartJson(params);
			params.set("wrttimeLastestVal", "50");
			
			params.set("callType", "ITM"); //항목 분류 정보 호출
			params.set("sumavgYn", ""); //차트 합계/평균 노출여부
			rMap.put("CHART_ITM", (List<Map<String, Object>>) chartListDao.multiChartItm(params));
			params.set("sumavgYn", "N"); //차트 합계/평균 노출여부
			rMap.put("CHART_ITMSA", (List<Map<String, Object>>) chartListDao.multiChartItm(params));
			
			params.set("callType", "WRT"); //시계열 정보 호출
			rMap.put("CHART_WRT", (List<Map<String, Object>>) chartListDao.multiChartItm(params));
			
			//데이터 호출
			rMap.put("CHART_DATA", (List<Map<String, Object>>) chartListDao.multiChartJson(params));
			
		} catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return rMap;
	}

	/**
	 * [간편통계] 통계표 챠트 > 그룹/분류/항목 에 범례 갯수를 확인하여 재할당한다. 
	 */
	@SuppressWarnings("unchecked")
	private void statMakeItm(Params params) {

		//그룹선택 string[] => ibatis에서 사용하기 위해 array로 변경
		ArrayList<String> iterChkGrps = new ArrayList<String>(Arrays.asList(params.getStringArray("chkGrps")));
		
		//분류선택 string[] => ibatis에서 사용하기 위해 array로 변경
		ArrayList<String> iterChkClss = new ArrayList<String>(Arrays.asList(params.getStringArray("chkClss")));
		
		//항목선택 string[] => ibatis에서 사용하기 위해 array로 변경
		ArrayList<String> iterChkItms = new ArrayList<String>(Arrays.asList(params.getStringArray("chkItms")));
		
		try {
			
			//간략조회를 통해 넘어와서 그룹/분류/항목이 없는 경우 쿼리 조회를 통해 해당 항목정보를 넣어준다.
			if(iterChkItms.size() == 0){ 
				params.set("itmTag", "G");
				List<Record> gList = (List<Record>) statListDao.statItmJson(params);
				for(Record data : gList) iterChkGrps.add(String.valueOf(data.get("datano")));
				
				params.set("itmTag", "C");
				List<Record> cList = (List<Record>) statListDao.statItmJson(params);
				for(Record data : cList) iterChkClss.add(String.valueOf(data.get("datano"))); 
				
				params.set("itmTag", "I");
				List<Record> iList = (List<Record>) statListDao.statItmJson(params);
				for(Record data : iList) iterChkItms.add(String.valueOf(data.get("datano")));
			}
			
			//차트 범례 설정 갯수에 따라 그룹/분류/항목을 지정한다.
			if(iterChkGrps.size() > 0){ //[그룹]이 있는 경우
				if(iterChkGrps.size() > MAX_CHART_ITM){ //[그룹] 설정갯수를 넘었다면..
					for(int i=iterChkGrps.size()-1; i>=MAX_CHART_ITM; i--) iterChkGrps.remove(i); //그룹 설정갯수 이상은 배열에서 제거
					if(iterChkClss.size() > 0){
						for(int i=iterChkClss.size()-1; i>0; i--) iterChkClss.remove(i); //분류 첫번째를 제외하고 배열에서 제거
					}
					for(int i=iterChkItms.size()-1; i>0; i--) iterChkItms.remove(i); //항목 첫번째를 제외하고 배열에서 제거
				} else { //[그룹] 설정갯수를 넘지 않았다면..
					
					if(iterChkClss.size() > 0){ //[분류]가 있는 경우
						
						if( ( iterChkGrps.size() * iterChkClss.size() ) > MAX_CHART_ITM ){ //[그룹*분류] 설정갯수를 넘었다면..
							int clsCnt = (int) Math.floor(MAX_CHART_ITM / iterChkGrps.size());
							for(int i=iterChkClss.size()-1; i>=clsCnt; i--) iterChkClss.remove(i); //분류 첫번째를 제외하고 배열에서 제거
							for(int i=iterChkItms.size()-1; i>0; i--) iterChkItms.remove(i); //항목 첫번째를 제외하고 배열에서 제거
						}else{ //[그룹*분류] 설정갯수를 넘지 않았다면..
							if( ( iterChkGrps.size() * iterChkClss.size() * iterChkItms.size() ) > MAX_CHART_ITM ){ //[그룹*분류*항목] 설정갯수를 넘었다면..
								int itmCnt = (int) Math.floor(MAX_CHART_ITM / (iterChkGrps.size() * iterChkClss.size()) );
								for(int i=iterChkItms.size()-1; i>itmCnt; i--) iterChkItms.remove(i);
							}
						}
						
					}else{ //[분류]가 없는 경우
						
						if( ( iterChkGrps.size() * iterChkItms.size() ) > MAX_CHART_ITM ){ //[그룹*항목] 설정갯수를 넘었다면..
							int itmCnt = (int) Math.floor(MAX_CHART_ITM / iterChkGrps.size() );
							for(int i=iterChkItms.size()-1; i>itmCnt; i--) iterChkItms.remove(i);
						}
					}
					
				}
			}else{ //[그룹]이 없는 경우
				
				if(iterChkClss.size() > 0){ //분류가 있는 경우
					
					if( iterChkClss.size() > MAX_CHART_ITM ){ //[분류] 설정갯수를 넘었다면..
						for(int i=iterChkClss.size()-1; i>MAX_CHART_ITM; i--) iterChkClss.remove(i); //분류 설정갯수 이상은 배열에서 제거
						for(int i=iterChkItms.size()-1; i>0; i--) iterChkItms.remove(i); //항목 첫번째를 제외하고 배열에서 제거
					}else{ //[분류] 설정갯수를 넘지 않았다면..
						if( (  iterChkClss.size() * iterChkItms.size() ) > MAX_CHART_ITM ){ //[분류*항목] 설정갯수를 넘었다면..
							int itmCnt = (int) Math.floor(MAX_CHART_ITM / iterChkClss.size() );
							for(int i=iterChkItms.size()-1; i>itmCnt; i--) iterChkItms.remove(i);
						}
					}
					
				}else{ //분류가 없는 경우
					
					if( iterChkItms.size() > MAX_CHART_ITM ){ //[항목] 설정갯수를 넘었다면..
						for(int i=iterChkItms.size()-1; i>MAX_CHART_ITM; i--) iterChkItms.remove(i); //항목 설정갯수 이상은 배열에서 제거
					}
				}
			}
			
			params.set("iterChkGrps", iterChkGrps.size() > 0 ? iterChkGrps : null);
			params.set("iterChkClss", iterChkClss.size() > 0 ? iterChkClss : null);
			params.set("iterChkItms", iterChkItms.size() > 0 ? iterChkItms : null);
		}  catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		
	}

	/**
	 * 통계표 지도를 위한 데이터 조회
	 */
	public Map<String, Object> statMapDataJson(Params params) {
		Map<String, Object> rMap = new HashMap<String, Object>();
		
		try {
			//통계 데이터셋 연계정보 조회
			Map<String, Object> stddDscn = (Map<String, Object>) statListDao.selectStatInputDscn(params);
			params.set("ownerCd", stddDscn.get("ownerCd"));					//대상 owner
			params.set("dsId", stddDscn.get("dsId"));						//대상 데이터셋명
			
			//통계자료 string[] => ibatis에서 사용하기 위해 array로 변경
			ArrayList<String> iterDtadvsVal = new ArrayList<String>(Arrays.asList(params.getStringArray("dtadvsVal")));
			params.set("iterDtadvsVal", iterDtadvsVal);
			//항목선택 string[] => ibatis에서 사용하기 위해 array로 변경
			ArrayList<String> iterChkItms = new ArrayList<String>(Arrays.asList(params.getStringArray("chkItms")));
			//params.set("iterChkItms", iterChkItms);
			params.set("iterChkItms", iterChkItms.size() > StatListServiceImpl.MAX_CHK_ITM ? null : iterChkItms);
			//분류선택 string[] => ibatis에서 사용하기 위해 array로 변경
			ArrayList<String> iterChkClss = new ArrayList<String>(Arrays.asList(params.getStringArray("chkClss")));
			//params.set("iterChkClss", iterChkClss);
			params.set("iterChkClss", iterChkClss.size() > StatListServiceImpl.MAX_CHK_ITM ? null : iterChkClss);
			
			rMap.put("divId", params.get("divId"));
			rMap.put("mapVal", params.get("mapVal"));
			rMap.put("displayType", params.get("displayType"));
			rMap.put("OPT_DATA", statListDao.selectStatDtlOpt(params));
			rMap.put("MAP_DATA", (List<Map<String, Object>>) chartListDao.statMapDataJson(params));
			
		} catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return rMap;
	}
	
	/**
	 * 통계표 지도를 위한 데이터 조회[상세]
	 */
	public List<Record> statMapJsonDetail(Params params) {
		return (List<Record>) chartListDao.statMapJsonDetail(params);
	}
	
}

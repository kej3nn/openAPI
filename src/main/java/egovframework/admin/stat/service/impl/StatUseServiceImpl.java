package egovframework.admin.stat.service.impl;

import java.util.*;

import javax.annotation.Resource;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.stat.service.StatUse;
import egovframework.admin.stat.service.StatUseService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import lombok.NonNull;

@Service("StatUseService")
public class StatUseServiceImpl extends AbstractServiceImpl implements	StatUseService {

	@Resource(name = "StatUseDao")
	private StatUseDao statUseDao;

	/**
	 * 분류별 활용 통계 Sheet형 자료 조회한디.
	 * 
	 * @param statUse
	 * @return List<StatUse>
	 * @throws Exception
	 */
	@Override
	public List<StatUse> getUseStatCateSheetAll(@NonNull StatUse statUse) {
		// 날짜 데이터 에서 '-' 제외
		formatPubDttm(statUse);
//		statUse.setPubDttmFrom(StringUtils.defaultString(statUse.getPubDttmFrom()).replaceAll("-", ""));
//		statUse.setPubDttmTo(StringUtils.defaultString(statUse.getPubDttmTo()).replaceAll("-", ""));
		
		List<StatUse> result = new ArrayList<StatUse>();
		try {
			result = statUseDao.getUseStatCateSheetAll(statUse);
		} catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return result;
	}

	/**
	 * 분류별 활용 통계 Chart형 자료 조회한다.
	 * @param statUse
	 * @return Map<String, Object>
	 * @throws Exception
	 */
	@Override
	public Map<String, Object> getUseStatCateChartAll(@NonNull StatUse statUse) {
		Map<String, Object> map = new HashMap<String, Object>();
		// 날짜 데이터 에서 '-' 제외
		formatPubDttm(statUse);
//		statUse.setPubDttmFrom(StringUtils.defaultString(statUse.getPubDttmFrom()).replaceAll("-", ""));
//		statUse.setPubDttmTo(StringUtils.defaultString(statUse.getPubDttmTo()).replaceAll("-", ""));
		
		try {
			// 차트 데이터 정보
			// 범례 조회 ==> 시리즈 조회(공공데이터 수, 서비스 수, OpenAPI수, Chart수, File 수, Link 수,
			// Map 수, RAW Sheet 수, TS Sheet수)
			List<StatUse> seriesResult = statUseDao.getUseSeriesResult(statUse);
			// X축 데이터 조회 ==> 분류목록 조회
			List<LinkedHashMap<String, ?>> chartDataX = statUseDao.getCateChartDataX(statUse);
			// Y축 데이터 조회 ==> 실제 분류목록의 건수들 조회
			List<LinkedHashMap<String, ?>> chartDataY = statUseDao.getCateChartDataY(statUse);
			
			map.put("seriesResult", seriesResult);
			map.put("chartDataX", chartDataX);
			map.put("chartDataY", chartDataY);
		} catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return map;
	}
	
	/**
	 * 기관별 활용 통계 Sheet형 자료 조회한디.
	 * 
	 * @param statUse
	 * @return List<StatUse>
	 * @throws Exception
	 */
	@Override
	public List<StatUse> getUseStatOrgSheetAll(@NonNull StatUse statUse) {
		// 날짜 데이터 에서 '-' 제외
		formatPubDttm(statUse);
//		statUse.setPubDttmFrom(StringUtils.defaultString(statUse.getPubDttmFrom()).replaceAll("-", ""));
//		statUse.setPubDttmTo(StringUtils.defaultString(statUse.getPubDttmTo()).replaceAll("-", ""));
		
		List<StatUse> result = new ArrayList<StatUse>();
		
		try {
			result = statUseDao.getUseStatOrgSheetAll(statUse);
		} catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return result;
	}

	/**
	 * 기관별 활용 통계 Chart형 자료 조회한다.
	 * @param statUse
	 * @return Map<String, Object>
	 * @throws Exception
	 */
	@Override
	public Map<String, Object> getUseStatOrgChartAll(@NonNull StatUse statUse) {
		Map<String, Object> map = new HashMap<String, Object>();
		// 날짜 데이터 에서 '-' 제외
		formatPubDttm(statUse);
//		statUse.setPubDttmFrom(StringUtils.defaultString(statUse.getPubDttmFrom()).replaceAll("-", ""));
//		statUse.setPubDttmTo(StringUtils.defaultString(statUse.getPubDttmTo()).replaceAll("-", ""));
		
		try {
			// 차트 데이터 정보
			// 범례 조회 ==> 시리즈 조회(공공데이터 수, 서비스 수, OpenAPI수, Chart수, File 수, Link 수,
			// Map 수, RAW Sheet 수, TS Sheet수)
			List<StatUse> seriesResult = statUseDao.getUseSeriesResult(statUse);
			// X축 데이터 조회 ==> 분류목록 조회
			List<LinkedHashMap<String, ?>> chartDataX = statUseDao.getOrgChartDataX(statUse);
			// Y축 데이터 조회 ==> 실제 분류목록의 건수들 조회
			List<LinkedHashMap<String, ?>> chartDataY = statUseDao.getOrgChartDataY(statUse);

			
			map.put("seriesResult", seriesResult);
			map.put("chartDataX", chartDataX);
			map.put("chartDataY", chartDataY);
			
		} catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}	
		return map;
	}
	
	/**
	 * 보유데이터별 활용 통계 Sheet형 자료 조회한디.
	 * 
	 * @param statUse
	 * @return List<StatUse>
	 * @throws Exception
	 */
	@Override
	public List<StatUse> getUseStatDtSheetAll(@NonNull StatUse statUse) {
		// 날짜 데이터 에서 '-' 제외
		formatPubDttm(statUse);
//		statUse.setPubDttmFrom(StringUtils.defaultString(statUse.getPubDttmFrom()).replaceAll("-", ""));
//		statUse.setPubDttmTo(StringUtils.defaultString(statUse.getPubDttmTo()).replaceAll("-", ""));
		
		List<StatUse> result = new ArrayList<StatUse>();
		try {
			result = statUseDao.getUseStatDtSheetAll(statUse);
			
		} catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return result;
	}

	/**
	 * 보유데이터별 활용 통계 Chart형 자료 조회한다.
	 * @param statUse
	 * @return Map<String, Object>
	 * @throws Exception
	 */
	@Override
	public Map<String, Object> getUseStatDtChartAll(@NonNull StatUse statUse) {
		Map<String, Object> map = new HashMap<String, Object>();
		// 날짜 데이터 에서 '-' 제외
		formatPubDttm(statUse);
//		statUse.setPubDttmFrom(StringUtils.defaultString(statUse.getPubDttmFrom()).replaceAll("-", ""));
//		statUse.setPubDttmTo(StringUtils.defaultString(statUse.getPubDttmTo()).replaceAll("-", ""));
		
		try {
			// 차트 데이터 정보
			// 범례 조회 ==> 시리즈 조회(공공데이터 수, 서비스 수, OpenAPI수, Chart수, File 수, Link 수,
			// Map 수, RAW Sheet 수, TS Sheet수)
			List<StatUse> seriesResult = statUseDao.getUseSeriesResult(statUse);
			// X축 데이터 조회 ==> 분류목록 조회
			List<LinkedHashMap<String, ?>> chartDataX = statUseDao.getDtChartDataX(statUse);
			// Y축 데이터 조회 ==> 실제 분류목록의 건수들 조회
			List<LinkedHashMap<String, ?>> chartDataY = statUseDao.getDtChartDataY(statUse);
			// 소분류 별 조회수  ==> 실제 분류목록의 건수들 조회
			List<LinkedHashMap<String, ?>> dataSetCnt = statUseDao.getUseStatDatasetSheetCnt(statUse);
			
			map.put("seriesResult", seriesResult);
			map.put("chartDataX", chartDataX);
			map.put("chartDataY", chartDataY);
			map.put("dataSetCnt", dataSetCnt);
		} catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}

		return map;
	}

	@Override
	public List<Map<String, Object>> getUseStatDatasetSheetAll(@NonNull StatUse statUse) {
		// 날짜 데이터 에서 '-' 제외
		formatPubDttm(statUse);
//		statUse.setPubDttmFrom(StringUtils.defaultString(statUse.getPubDttmFrom()).replaceAll("-", ""));
//		statUse.setPubDttmTo(StringUtils.defaultString(statUse.getPubDttmTo()).replaceAll("-", ""));
		
		List<Map<String, Object>> result = new ArrayList<Map<String,Object>>();
		try {
			result = statUseDao.getUseStatDatasetSheetAll(statUse);
		} catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return result;
	}
	

	@Override
	public List<Map<String, Object>> getActKeySheetAll(@NonNull StatUse statUse) {
		// 날짜 데이터 에서 '-' 제외
		formatPubDttm(statUse);
//		statUse.setPubDttmFrom(StringUtils.defaultString(statUse.getPubDttmFrom()).replaceAll("-", ""));
//		statUse.setPubDttmTo(StringUtils.defaultString(statUse.getPubDttmTo()).replaceAll("-", ""));
		
		List<Map<String, Object>> result = new ArrayList<Map<String,Object>>();
		try {
			result = statUseDao.getActKeySheetAll(statUse);
		} catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return result;
	}

	private void formatPubDttm(StatUse statUse) {
		String pubDttmFrom = statUse.getPubDttmFrom() == null ? "" : statUse.getPubDttmFrom();
		String pubDttmTo = statUse.getPubDttmTo() == null ? "" : statUse.getPubDttmTo();
		statUse.setPubDttmFrom(pubDttmFrom.replaceAll("-", ""));
		statUse.setPubDttmTo(pubDttmTo.replaceAll("-", ""));
	}

	/*public List<LinkedHashMap<String,?>> setChartData(List<LinkedHashMap<String,?>> caroResult, String[] gridColHead,String[] dataYear){
		List<LinkedHashMap<String,?>> chartResult = new ArrayList<LinkedHashMap<String,?>>(); 
		List<LinkedHashMap<String,?>> chartResult2 = null;
		LinkedHashMap<String,Object> chartMap = null;
		LinkedHashMap<String,Object> chartMap2 = null;
		for(LinkedHashMap<String,?> map:caroResult){
			chartResult2 = new ArrayList<LinkedHashMap<String,?>>(); 
			for(int i=0; i < gridColHead.length; i++){
				chartMap = new LinkedHashMap<String,Object>();
				chartMap.put("X", i+1);
				chartMap.put("Y",UtilString.replace((String)map.get(gridColHead[i]), ",", ""));
				chartMap.put("Name", dataYear[i]);
				chartMap.put("Sliecd", "false");
				chartResult2.add(chartMap);
			}
			chartMap2 = new LinkedHashMap<String,Object>();
			chartMap2.put("DATA", chartResult2);
			String title=(String)map.get("ITEM_NM1");
			if(!UtilString.null2Blank(map.get("ITEM_NM2")).equals("")){
				title = (String)map.get("ITEM_NM1") +"/" +(String)map.get("ITEM_NM2");
			}
			chartMap2.put("TITLE",title);
			chartResult.add(chartMap2);
		}
		return chartResult;
	}*/
}

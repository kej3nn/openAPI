package egovframework.admin.stat.service.impl;

import java.util.*;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.stat.service.StatOpen;
import egovframework.admin.stat.service.StatOpenService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import lombok.NonNull;

@Service("StatOpenService")
public class StatOpenServiceImpl extends AbstractServiceImpl implements	StatOpenService {

	@Resource(name = "StatOpenDao")
	private StatOpenDao statOpenDao;

	/**
	 * 분류별 개방 통계 Sheet형 자료 조회한디.
	 * 
	 * @param statOpen
	 * @return List<StatOpen>
	 * @throws Exception
	 */
	@Override
	public List<StatOpen> getOpenStatCateSheetAll(@NonNull StatOpen statOpen) {
		//statOpen.setPubDttmFrom(statOpen.getPubDttmFrom().replaceAll("-", ""));
		statOpen.setPubDttmTo(StringUtils.defaultString(statOpen.getPubDttmTo()).replaceAll("-", ""));
		List<StatOpen> result = new ArrayList<StatOpen>();
		try {
			result = statOpenDao.getOpenStatCateSheetAll(statOpen);
			
		} catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return result;
	}

	
	/**
	 * 분류별 개방 통계 Chart형 자료 조회한다.
	 * @param statOpen
	 * @return Map<String, Object>
	 * @throws Exception
	 */
	@Override
	public Map<String, Object> getOpenStatCateChartAll(@NonNull StatOpen statOpen) {
		Map<String, Object> map = new HashMap<String, Object>();
		// 날짜 데이터 에서 '-' 제외
		//statOpen.setPubDttmFrom(statOpen.getPubDttmFrom().replaceAll("-", ""));
		statOpen.setPubDttmTo(StringUtils.defaultString(statOpen.getPubDttmTo()).replaceAll("-", ""));

		try {
			// 차트 데이터 정보
			// 범례 조회 ==> 시리즈 조회(공공데이터 수, 서비스 수, OpenAPI수, Chart수, File 수, Link 수,
			// Map 수, RAW Sheet 수, TS Sheet수)
			List<StatOpen> seriesResult = statOpenDao.getOpenSeriesResult(statOpen);
			// X축 데이터 조회 ==> 분류목록 조회
			List<LinkedHashMap<String, ?>> chartDataX = statOpenDao.getCateChartDataX(statOpen);
			// Y축 데이터 조회 ==> 실제 분류목록의 건수들 조회
			List<LinkedHashMap<String, ?>> chartDataY = statOpenDao.getCateChartDataY(statOpen);
			
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
	 * 기관별 개방 통계 Sheet형 자료 조회한디.
	 * 
	 * @param statOpen
	 * @return List<StatOpen>
	 * @throws Exception
	 */
	@Override
	public List<StatOpen> getOpenStatOrgSheetAll(@NonNull StatOpen statOpen) {
		//statOpen.setPubDttmFrom(statOpen.getPubDttmFrom().replaceAll("-", ""));
		statOpen.setPubDttmTo(StringUtils.defaultString(statOpen.getPubDttmTo()).replaceAll("-", ""));
		
		List<StatOpen> result = new ArrayList<StatOpen>();
		try {
			result = statOpenDao.getOpenStatOrgSheetAll(statOpen);
		} catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return result;
	}

	
	/**
	 * 기관별 개방 통계 Chart형 자료 조회한다.
	 * @param statOpen
	 * @return Map<String, Object>
	 * @throws Exception
	 */
	@Override
	public Map<String, Object> getOpenStatOrgChartAll(@NonNull StatOpen statOpen) {
		Map<String, Object> map = new HashMap<String, Object>();
		// 날짜 데이터 에서 '-' 제외
		//statOpen.setPubDttmFrom(statOpen.getPubDttmFrom().replaceAll("-", ""));
		statOpen.setPubDttmTo(StringUtils.defaultString(statOpen.getPubDttmTo()).replaceAll("-", ""));

		try {
			// 차트 데이터 정보
			// 범례 조회 ==> 시리즈 조회(공공데이터 수, 서비스 수, OpenAPI수, Chart수, File 수, Link 수,
			// Map 수, RAW Sheet 수, TS Sheet수)
			List<StatOpen> seriesResult = statOpenDao.getOpenSeriesResult(statOpen);
			// X축 데이터 조회 ==> 분류목록 조회
			List<LinkedHashMap<String, ?>> chartDataX = statOpenDao.getOrgChartDataX(statOpen);
			// Y축 데이터 조회 ==> 실제 분류목록의 건수들 조회
			List<LinkedHashMap<String, ?>> chartDataY = statOpenDao.getOrgChartDataY(statOpen);
			
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
	 * 보유데이터별 개방 통계 Sheet형 자료 조회한디.
	 * 
	 * @param statOpen
	 * @return List<StatOpen>
	 * @throws Exception
	 */
	@Override
	public List<StatOpen> getOpenStatDtSheetAll(@NonNull StatOpen statOpen) {
		//statOpen.setPubDttmFrom(statOpen.getPubDttmFrom().replaceAll("-", ""));
		statOpen.setPubDttmTo(StringUtils.defaultString(statOpen.getPubDttmTo()).replaceAll("-", ""));
		List<StatOpen> result = new ArrayList<StatOpen>();
		try {
			result =  statOpenDao.getOpenStatDtSheetAll(statOpen);
			
		} catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return result;
	}

	
	/**
	 * 보유데이터별 개방 통계 Chart형 자료 조회한다.
	 * @param statOpen
	 * @return Map<String, Object>
	 * @throws Exception
	 */
	@Override
	public Map<String, Object> getOpenStatDtChartAll(@NonNull StatOpen statOpen) {
		Map<String, Object> map = new HashMap<String, Object>();
		// 날짜 데이터 에서 '-' 제외
		//statOpen.setPubDttmFrom(statOpen.getPubDttmFrom().replaceAll("-", ""));
		statOpen.setPubDttmTo(StringUtils.defaultString(statOpen.getPubDttmTo()).replaceAll("-", ""));

		try {
			// 차트 데이터 정보
			// 범례 조회 ==> 시리즈 조회(공공데이터 수, 서비스 수, OpenAPI수, Chart수, File 수, Link 수,
			// Map 수, RAW Sheet 수, TS Sheet수)
			List<StatOpen> seriesResult = statOpenDao.getOpenSeriesResult(statOpen);
			// X축 데이터 조회 ==> 분류목록 조회
			List<LinkedHashMap<String, ?>> chartDataX = statOpenDao.getDtChartDataX(statOpen);
			// Y축 데이터 조회 ==> 실제 분류목록의 건수들 조회
			List<LinkedHashMap<String, ?>> chartDataY = statOpenDao.getDtChartDataY(statOpen);
			
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

}

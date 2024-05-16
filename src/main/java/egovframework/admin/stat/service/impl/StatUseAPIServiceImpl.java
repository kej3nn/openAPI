package egovframework.admin.stat.service.impl;

import java.util.*;

import javax.annotation.Resource;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.stat.service.StatUseAPI;
import egovframework.admin.stat.service.StatUseAPIService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import lombok.NonNull;

@Service("StatUseAPIService")
public class StatUseAPIServiceImpl extends AbstractServiceImpl implements	StatUseAPIService {

	@Resource(name = "StatUseAPIDao")
	private StatUseAPIDao statUseAPIDao;

	/**
	 * API 성능현황 통계 Sheet형 자료 조회한디.
	 * 
	 * @param statUseAPI
	 * @return List<StatOpen>
	 * @throws Exception
	 */
	@Override
	public List<StatUseAPI> getUseAPIStatSheetAll(@NonNull StatUseAPI statUseAPI) {
		String pubDttmFrom = statUseAPI.getPubDttmFrom() == null ? "" : statUseAPI.getPubDttmFrom();
		String pubDttmTo = statUseAPI.getPubDttmTo() == null ? "" : statUseAPI.getPubDttmTo();
		statUseAPI.setPubDttmFrom(pubDttmFrom.replaceAll("-", ""));
		statUseAPI.setPubDttmTo(pubDttmTo.replaceAll("-", ""));
		List<StatUseAPI> result = new ArrayList<StatUseAPI>();
		try {
			result = statUseAPIDao.getUseFBStatSheetAll(statUseAPI);
		} catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return result;
	}

	/**
	 * API 성능현황 통계 Chart형 자료 조회한다.
	 * @param statUseAPI
	 * @return Map<String, Object>
	 * @throws Exception
	 */
	@Override
	public Map<String, Object> getUseAPIStatChartAll(@NonNull StatUseAPI statUseAPI) {
		Map<String, Object> map = new HashMap<String, Object>();
		// 날짜 데이터 에서 '-' 제외
		String pubDttmFrom = statUseAPI.getPubDttmFrom() == null ? "" : statUseAPI.getPubDttmFrom();
		String pubDttmTo = statUseAPI.getPubDttmTo() == null ? "" : statUseAPI.getPubDttmTo();
		statUseAPI.setPubDttmFrom(pubDttmFrom.replaceAll("-", ""));
		statUseAPI.setPubDttmTo(pubDttmTo.replaceAll("-", ""));
		
		try {
			// 차트 데이터 정보
			// 범례 조회 ==> 시리즈 조회(공공데이터 수, 서비스 수, OpenAPI수, Chart수, File 수, Link 수,
			// Map 수, RAW Sheet 수, TS Sheet수)
			List<StatUseAPI> seriesResult = statUseAPIDao.getUseAPISeriesResult(statUseAPI);
			// X축 데이터 조회 ==> 분류목록 조회
			List<LinkedHashMap<String, ?>> chartDataX = statUseAPIDao.getChartDataX(statUseAPI);
			// Y축 데이터 조회 ==> 실제 분류목록의 건수들 조회
			List<LinkedHashMap<String, ?>> chartDataY = statUseAPIDao.getChartDataY(statUseAPI);
			
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

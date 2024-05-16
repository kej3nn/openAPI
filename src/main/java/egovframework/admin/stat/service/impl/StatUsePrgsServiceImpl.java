package egovframework.admin.stat.service.impl;

import java.util.*;

import javax.annotation.Resource;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.stat.service.StatUse;
import egovframework.admin.stat.service.StatUsePrgsService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import lombok.NonNull;

@Service("StatUsePrgsService")
public class StatUsePrgsServiceImpl extends AbstractServiceImpl implements	StatUsePrgsService {

	@Resource(name = "StatUsePrgsDao")
	private StatUsePrgsDao statUsePrgsDao;

	/**
	 * 활용 추이 통계 Sheet형 자료 조회한디.
	 * 
	 * @param statUse
	 * @return List<StatOpen>
	 * @throws Exception
	 */
	@Override
	public List<StatUse> getUseStatPrgsSheetAll(@NonNull StatUse statUse) {
		String pubDttmFrom = statUse.getPubDttmFrom() == null ? "" : statUse.getPubDttmFrom();
		String pubDttmTo = statUse.getPubDttmTo() == null ? "" : statUse.getPubDttmTo();
		statUse.setPubDttmFrom(pubDttmFrom.replaceAll("-", ""));
		statUse.setPubDttmTo(pubDttmTo.replaceAll("-", ""));
		
		List<StatUse> result = new ArrayList<StatUse>();
		try {
			result = statUsePrgsDao.getUseStatPrgsSheetAll(statUse);
		} catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return result;
	}

	/**
	 * 활용 추이 통계 Chart형 자료 조회한다.
	 * @param statUse
	 * @return Map<String, Object>
	 * @throws Exception
	 */
	@Override
	public Map<String, Object> getUseStatPrgsChartAll(@NonNull StatUse statUse) {
		Map<String, Object> map = new HashMap<String, Object>();
		String pubDttmFrom = statUse.getPubDttmFrom() == null ? "" : statUse.getPubDttmFrom();
		String pubDttmTo = statUse.getPubDttmTo() == null ? "" : statUse.getPubDttmTo();
		// 날짜 데이터 에서 '-' 제외
		statUse.setPubDttmFrom(pubDttmFrom.replaceAll("-", ""));
		statUse.setPubDttmTo(pubDttmTo.replaceAll("-", ""));
		
		try {
			// 차트 데이터 정보
			// 범례 조회 ==> 시리즈 조회(공공데이터 수, 서비스 수, OpenAPI수, Chart수, File 수, Link 수,
			// Map 수, RAW Sheet 수, TS Sheet수)
			List<StatUse> seriesResult = statUsePrgsDao.getUsePrgsSeriesResult(statUse);
			// X축 데이터 조회 ==> 분류목록 조회
			List<LinkedHashMap<String, ?>> chartDataX = statUsePrgsDao.getChartDataX(statUse);
			// Y축 데이터 조회 ==> 실제 분류목록의 건수들 조회
			List<LinkedHashMap<String, ?>> chartDataY = statUsePrgsDao.getChartDataY(statUse);
			
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

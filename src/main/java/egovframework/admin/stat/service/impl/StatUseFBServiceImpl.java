package egovframework.admin.stat.service.impl;

import java.util.*;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.stat.service.StatUseFB;
import egovframework.admin.stat.service.StatUseFBService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import lombok.NonNull;

@Service("StatUseFBService")
public class StatUseFBServiceImpl extends AbstractServiceImpl implements	StatUseFBService {

	@Resource(name = "StatUseFBDao")
	private StatUseFBDao statUseFBDao;

	/**
	 * 활용 추이 통계 Sheet형 자료 조회한디.
	 * 
	 * @param statUseFB
	 * @return List<StatOpen>
	 * @throws Exception
	 */
	@Override
	public List<StatUseFB> getUseFBStatSheetAll(@NonNull StatUseFB statUseFB) {
		statUseFB.setPubDttmFrom(StringUtils.defaultString(statUseFB.getPubDttmFrom()).replaceAll("-", ""));
		statUseFB.setPubDttmTo(StringUtils.defaultString(statUseFB.getPubDttmTo()).replaceAll("-", ""));
		List<StatUseFB> result = new ArrayList<StatUseFB>();
		try {
			result = statUseFBDao.getUseFBStatSheetAll(statUseFB);
		} catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return result;
	}

	
	/**
	 * 활용 추이 통계 Chart형 자료 조회한다.
	 * @param statUseFB
	 * @return Map<String, Object>
	 * @throws Exception
	 */
	@Override
	public Map<String, Object> getUseFBStatChartAll(@NonNull StatUseFB statUseFB) {
		Map<String, Object> map = new HashMap<String, Object>();
		// 날짜 데이터 에서 '-' 제외
		statUseFB.setPubDttmFrom(StringUtils.defaultString(statUseFB.getPubDttmFrom()).replaceAll("-", ""));
		statUseFB.setPubDttmTo(StringUtils.defaultString(statUseFB.getPubDttmTo()).replaceAll("-", ""));

		try {
			// 차트 데이터 정보
			// 범례 조회 ==> 시리즈 조회(공공데이터 수, 서비스 수, OpenAPI수, Chart수, File 수, Link 수,
			// Map 수, RAW Sheet 수, TS Sheet수)
			List<StatUseFB> seriesResult = statUseFBDao.getUseFBSeriesResult(statUseFB);
			// X축 데이터 조회 ==> 분류목록 조회
			List<LinkedHashMap<String, ?>> chartDataX = statUseFBDao.getChartDataX(statUseFB);
			// Y축 데이터 조회 ==> 실제 분류목록의 건수들 조회
			List<LinkedHashMap<String, ?>> chartDataY = statUseFBDao.getChartDataY(statUseFB);
			
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

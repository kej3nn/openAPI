package egovframework.admin.stat.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.stat.service.StatOpenStats;
import egovframework.admin.stat.service.StatOpenStatsService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("StatOpenStatsService")
public class StatOpenStatsServiceImpl extends AbstractServiceImpl implements
		StatOpenStatsService {

	@Resource(name = "StatOpenStatsDao")
	private StatOpenStatsDao statOpenStatsDao;

	/**
	 * 통계 건수 구한다.
	 */
	@Override
	public Map<String, Object> selectStatsCnt() {
		Map<String,Object> map = new HashMap<String,Object>();
		
		try {
			map.put("infTotalCnt", statOpenStatsDao.openInfTotalCnt() ); //공공데이터 개방 총 건수 (리얼)
			map.put("orgCnt", statOpenStatsDao.openOrgCnt() ); //공공데이터 개방기관 건수 (리얼)
			map.put("srvCnt", statOpenStatsDao.openSrvCnt() ); //개방서비스 유형 건수(리얼)
			map.put("dtCnt", statOpenStatsDao.openDtCnt() ); //보유데이터 건수 (리얼)
			map.put("statUseDtCnt", statOpenStatsDao.openStatUseDtCnt() ); //공공데이터 활용 건수 (통계)
			map.put("feedBackCnt", statOpenStatsDao.openFeedBackCnt() ); //활용피드백 건수 (통계)
		}  catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		
		return map;
	}

	/**
	 * 개방 및 활용 통계 sheet 조회
	 */
	@Override
	public List<StatOpenStats> getStatsSheetAll(StatOpenStats statOpenStats) {
		List<StatOpenStats> result = new ArrayList<StatOpenStats>();
		try {
			result = statOpenStatsDao.getStatsSheetAll(statOpenStats);
		} catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		return result;
	}
}

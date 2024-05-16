package egovframework.admin.stat.service;

import java.util.List;
import java.util.Map;

public interface StatOpenStatsService {

	/**
	 * 통계 건수 구한다.
	 * @return
	 * @throws Exception
	 */
	public Map<String,Object> selectStatsCnt();

	/**
	 * 개방 및 활용 통계 sheet 조회
	 * @param statOpenStats
	 * @return
	 * @throws Exception
	 */
	public List<StatOpenStats> getStatsSheetAll(StatOpenStats statOpenStats);

}

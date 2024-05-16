package egovframework.stats.data.service;

import java.util.List;

import egovframework.common.base.model.Params;

public interface StatsDataService {
	
	public static final String STATS_DATA = "sdata";
	
	public List<?> searchStatsTree(Params params);
	
	public List<?> searchStatsTreeTest(Params params);
}

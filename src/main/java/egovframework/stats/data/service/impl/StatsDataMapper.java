package egovframework.stats.data.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.common.base.mapper.BaseMapper;
import egovframework.common.base.model.Params;

@Repository(value="statsDataMapper")
public class StatsDataMapper extends BaseMapper {
	
	public List<?> searchStatsTree(Params params) {
		return search("StatsDataMapper.searchStatsTree", params);
    }
	
	public List<?> searchStatsTreeTest(Params params) {
		return search("StatsDataMapper.searchStatsTreeTest", params);
    }
}

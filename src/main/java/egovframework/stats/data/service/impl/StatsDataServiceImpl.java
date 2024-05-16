package egovframework.stats.data.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.common.base.model.Params;
import egovframework.stats.data.service.StatsDataService;

@Service(value="statsDataService")
public class StatsDataServiceImpl implements StatsDataService {
	
	@Resource(name="statsDataMapper")
	private StatsDataMapper statsDataMapper;

	@Override
	public List<?> searchStatsTree(Params params) {
		return (List<?>) statsDataMapper.searchStatsTree(params);
	}

	@Override
	public List<?> searchStatsTreeTest(Params params) {
		return (List<?>) statsDataMapper.searchStatsTreeTest(params);
	}

}

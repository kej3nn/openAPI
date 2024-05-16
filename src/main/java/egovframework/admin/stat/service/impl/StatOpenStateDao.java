package egovframework.admin.stat.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

@Repository(value="statOpenStateDao")
public class StatOpenStateDao extends BaseDao {
	
	/**
	 * 통계표 현황
	 * @param params
	 * @return
	 */
	public List<?> selectStatTblState(Params params) {
		return list("statOpenStateDao.selectStatTblState", params); 
	}

	/**
	 * 통계표 누적 공계현황
	 * @param params
	 * @return
	 */
	public List<?> selectStatOpenState(Params params) {
		return list("statOpenStateDao.selectStatOpenState", params); 
	}
	
}

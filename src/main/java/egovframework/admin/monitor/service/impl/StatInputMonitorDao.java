package egovframework.admin.monitor.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 연계 모니터링을 관리하는 DAO 클래스
 *
 * @version 1.0
 * @author JSSON
 * @since 2019/10/01
 */

@Repository(value = "statInputMonitorDao")
public class StatInputMonitorDao extends BaseDao {

    public Paging selectStatInputMonitorList(Params params, int page, int rows) {
        return search("statInputMonitorDao.selectStatInputMonitorList", params, page, rows, PAGING_SCROLL);
    }

    public Object statInputMonitorChart(Params params) {
        return select("statInputMonitorDao.selectStatInputMonitorChart", params);
    }
    
	@SuppressWarnings("unchecked")
	public List<LinkedHashMap<String,?>> selectOpenInputMonitorstatblList(Params params) throws DataAccessException, Exception {
		return (List<LinkedHashMap<String, ?>>) list("statInputMonitorDao.selectOpenInputMonitorstatblList", params);
	}
    
	@SuppressWarnings("unchecked")
	public List<LinkedHashMap<String,?>> selectOpenInputMonitorwrtOrgList(Params params) throws DataAccessException, Exception {
		return (List<LinkedHashMap<String, ?>>) list("statInputMonitorDao.selectOpenInputMonitorwrtOrgList", params);
	}

}

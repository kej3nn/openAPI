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

@Repository(value = "openInputMonitorDao")
public class OpenInputMonitorDao extends BaseDao {

    public Paging selectOpenInputMonitorList(Params params, int page, int rows) {
        return search("openInputMonitorDao.selectOpenInputMonitorList", params, page, rows, PAGING_SCROLL);
    }

    public Object openInputMonitorChart(Params params) {
        return select("openInputMonitorDao.selectOpenInputMonitorChart", params);
    }
    
	@SuppressWarnings("unchecked")
	public List<LinkedHashMap<String,?>> selectOpenInputMonitorOrgList(Params params) throws DataAccessException, Exception {
		return (List<LinkedHashMap<String, ?>>) list("openInputMonitorDao.selectOpenInputMonitorOrgList", params);
	}
    
	@SuppressWarnings("unchecked")
	public List<LinkedHashMap<String,?>> selectOpenInputMonitorDsList(Params params) throws DataAccessException, Exception {
		return (List<LinkedHashMap<String, ?>>) list("openInputMonitorDao.selectOpenInputMonitorDsList", params);
	}

}

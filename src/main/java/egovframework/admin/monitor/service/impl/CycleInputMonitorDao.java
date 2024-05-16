package egovframework.admin.monitor.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 연계 모니터링을 관리하는 DAO 클래스
 *
 * @author JSSON
 * @version 1.0
 * @since 2019/10/01
 */

@Repository(value = "cycleInputMonitorDao")
public class CycleInputMonitorDao extends BaseDao {
    //공통코드 값을 조회한다.
    public List<?> selectOption(Params params) {
        return search("cycleInputMonitorDao.selectOption", params);
    }	
    public Paging selectCycleInputMonitorList(Params params, int page, int rows) {
        return search("cycleInputMonitorDao.selectCycleInputMonitorList", params, page, rows, PAGING_SCROLL);
    }

    public Object cycleInputMonitorChart(Params params) {
        return select("cycleInputMonitorDao.selectCycleInputMonitorChart", params);
    }

}

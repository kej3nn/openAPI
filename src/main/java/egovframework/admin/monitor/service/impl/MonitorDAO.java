package egovframework.admin.monitor.service.impl;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.admin.monitor.service.Monitor;
import egovframework.admin.monitor.service.Monitor2;
import egovframework.admin.monitor.service.StatService;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.portal.service.service.OpenInfLog;

@Repository("MonitorDAO")
public class MonitorDAO extends EgovComAbstractDAO {


    @SuppressWarnings("unchecked")
    public List<OpenInfLog> selectMenuLogList(Monitor monitor) {
        return (List<OpenInfLog>) list("MonitorDAO.selectMenuLogList", monitor);
    }

    @SuppressWarnings("unchecked")
    public List<OpenInfLog> selectMenuLogList2(Monitor monitor) {
        return (List<OpenInfLog>) list("MonitorDAO.selectMenuLogList2", monitor);
    }

    /**
     * 망 연계 모니터링 목록
     *
     * @param map
     * @return
     */
    public List<Monitor2> selectNetConnMonitorList(Monitor2 monitor) {
        return (List<Monitor2>) list("MonitorDAO.selectNetConnMonitorList", monitor);
    }

    /**
     * 망 연계 모니터링 상세
     *
     * @param monitor
     * @return
     */
    public List<Monitor2> selectNetConnMonitorDetail(Monitor2 monitor) {
        return (List<Monitor2>) list("MonitorDAO.selectNetConnMonitorDetail", monitor);
    }

    /**
     * 품질 모니터링 목록
     *
     * @param monitor
     * @return
     */
    public List<Monitor2> selectQuailtyMonitorList(Monitor2 monitor) {
        return (List<Monitor2>) list("MonitorDAO.selectQuailtyMonitorList", monitor);
    }

    /**
     * 품질 모니터링 상세
     *
     * @param monitor
     * @return
     */
    public List<Monitor2> selectQuailtyMonitorDetail(Monitor2 monitor) {
        return (List<Monitor2>) list("MonitorDAO.selectQuailtyMonitorDetail", monitor);
    }

    /**
     * 외부 연계 모니터링 목록
     *
     * @param monitor
     * @return
     */
    public List<Monitor2> selectOutMonitorList(Monitor2 monitor) {
        return (List<Monitor2>) list("MonitorDAO.selectOutMonitorList", monitor);
    }

    /**
     * 메타정보를 전체 조회 한다.
     *
     * @param StatService
     * @return List
     * @throws DataAccessException, Exception
     */
    public List<StatService> selectStatServiceListAll(StatService statService) {

        return (List<StatService>) list("MonitorDAO.selectStatServiceListAll", statService);
    }

    public int selectStatServiceListAllCnt(StatService statService) {

        return (Integer) getSqlMapClientTemplate().queryForObject("MonitorDAO.selectStatServiceListAllCnt", statService);
    }

    public List<StatService> selectStatServiceList(StatService statService) throws DataAccessException, Exception {
        return (List<StatService>) list("MonitorDAO.selectStatServiceList", statService);
    }

}

package egovframework.admin.monitor.service.impl;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;

/**
 * 연계 모니터링을 관리하는 DAO 클래스
 *
 * @version 1.0
 * @author JSSON
 * @since 2019/10/01
 */

@Repository(value = "linkMonitorDao")
public class LinkMonitorDao extends BaseDao {

    public Paging selectLinkMonitorList(Params params, int page, int rows) {
        return search("linkMonitorDao.selectLinkMonitorList", params, page, rows, PAGING_MANUAL);
    }

}

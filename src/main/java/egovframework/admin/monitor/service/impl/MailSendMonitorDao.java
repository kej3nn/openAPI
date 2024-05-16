package egovframework.admin.monitor.service.impl;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.exception.SystemException;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

@Repository(value = "mailSendMonitorDao")
public class MailSendMonitorDao extends BaseDao {

    public Paging selectMailMonitorList(Params params, int page, int rows) {
        return search("mailSendMonitorDao.selectMailMonitorList", params, page, rows, PAGING_MANUAL);
    }

    public void insertMailReSend(Params params) {
        insert("mailSendMonitorDao.insertMailReSend", params);
    }

    public Record selectMailContent(Params params) {
        return (Record) select("mailSendMonitorDao.selectMailContent", params);
    }
}

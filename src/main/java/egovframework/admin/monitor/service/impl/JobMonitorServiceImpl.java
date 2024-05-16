package egovframework.admin.monitor.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.admin.monitor.service.JobMonitorService;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.service.BaseService;

@Service(value = "jobMonitorService")
public class JobMonitorServiceImpl extends BaseService implements JobMonitorService {

    @Resource(name = "jobMonitorDao")
    protected JobMonitorDao jobMonitorDao;


    /**
     * 메인 리스트 조회(페이징 처리)
     */
    @Override
    public Paging selectJobMonitorListPaging(Params params) {

        Paging list = jobMonitorDao.selectJobMonitorList(params, params.getPage(), params.getRows());

        return list;
    }

}

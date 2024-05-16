package egovframework.admin.monitor.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.admin.monitor.service.LinkMonitorService;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.service.BaseService;

@Service(value = "linkMonitorService")
public class LinkMonitorServiceImpl extends BaseService implements LinkMonitorService {

    @Resource(name = "linkMonitorDao")
    protected LinkMonitorDao linkMonitorDao;


    /**
     * 메인 리스트 조회(페이징 처리)
     */
    @Override
    public Paging selectLinkMonitorListPaging(Params params) {

        Paging list = linkMonitorDao.selectLinkMonitorList(params, params.getPage(), params.getRows());

        return list;
    }

}

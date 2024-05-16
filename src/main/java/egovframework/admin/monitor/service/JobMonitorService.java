package egovframework.admin.monitor.service;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;

public interface JobMonitorService {

    public Paging selectJobMonitorListPaging(Params params);

}

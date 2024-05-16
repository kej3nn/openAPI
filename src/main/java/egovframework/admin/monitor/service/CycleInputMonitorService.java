package egovframework.admin.monitor.service;

import java.util.List;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

public interface CycleInputMonitorService {

    public Paging selectCycleInputMonitorListPaging(Params params);

    public Object cycleInputMonitorChart(Params params);
    public List<Record> selectOption(Params params);
}

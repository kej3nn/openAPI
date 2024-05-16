package egovframework.admin.monitor.service;

import java.util.List;
import java.util.Map;

public interface MonitorService {
    public Map<String, Object> menuLogIbPaging(Monitor monitor);

    public Map<String, Object> menuLog2IbPaging(Monitor monitor);


    public Map<String, Object> netConnMonitorListIbPaging(Monitor2 monitor);

    public Map<String, Object> netConnMonitorDetailIbPaging(Monitor2 monitor);

    public Map<String, Object> qualityMonitorListIbPaging(Monitor2 monitor);

    public Map<String, Object> qualityMonitorDetailIbPaging(Monitor2 monitor);

    public Map<String, Object> outConnMonitorListIbPaging(Monitor2 monitor);

    public Map<String, Object> selectStatServiceListAllIbPaging(StatService statService);

    public List<StatService> selectStatServiceList(StatService statService);
}


package egovframework.admin.monitor.service;

import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;

public interface OpenInputMonitorService {

    public Paging selectOpenInputMonitorListPaging(Params params);

    public Object openInputMonitorChart(Params params);
    
    public List<LinkedHashMap<String,?>> selectOpenInputMonitorOrgList(Params params) throws DataAccessException, Exception;
    
    public List<LinkedHashMap<String,?>> selectOpenInputMonitorDsList(Params params) throws DataAccessException, Exception;
}

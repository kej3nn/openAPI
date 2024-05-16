package egovframework.admin.monitor.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.monitor.service.OpenInputMonitorService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.service.BaseService;

@Service(value = "openInputMonitorService")
public class OpenInputMonitorServiceImpl extends BaseService implements OpenInputMonitorService {

    @Resource(name = "openInputMonitorDao")
    protected OpenInputMonitorDao openInputMonitorDao;


    /**
     * 메인 리스트 조회(페이징 처리)
     */
    @Override
    public Paging selectOpenInputMonitorListPaging(Params params) {

        Paging list = openInputMonitorDao.selectOpenInputMonitorList(params, params.getPage(), params.getRows());

        return list;
    }
    
    


    @Override
    public Record openInputMonitorChart(Params params) {
        Record result = new Record();

        try {
            result = (Record) openInputMonitorDao.openInputMonitorChart(params);

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return result;
    }
    
	public List<LinkedHashMap<String,?>> selectOpenInputMonitorOrgList(Params params) throws DataAccessException, Exception {
        return openInputMonitorDao.selectOpenInputMonitorOrgList(params);       
}
	
	public List<LinkedHashMap<String,?>> selectOpenInputMonitorDsList(Params params) throws DataAccessException, Exception {
        return openInputMonitorDao.selectOpenInputMonitorDsList(params);       
}
}

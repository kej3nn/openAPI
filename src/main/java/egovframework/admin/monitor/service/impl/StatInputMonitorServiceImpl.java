package egovframework.admin.monitor.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.monitor.service.StatInputMonitorService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.service.BaseService;

@Service(value = "statInputMonitorService")
public class StatInputMonitorServiceImpl extends BaseService implements StatInputMonitorService {

    @Resource(name = "statInputMonitorDao")
    protected StatInputMonitorDao statInputMonitorDao;


    /**
     * 메인 리스트 조회(페이징 처리)
     */
    @Override
    public Paging selectStatInputMonitorListPaging(Params params) {

        Paging list = statInputMonitorDao.selectStatInputMonitorList(params, params.getPage(), params.getRows());

        return list;
    }


    @Override
    public Record statInputMonitorChart(Params params) {
        Record result = new Record();

        try {
            result = (Record) statInputMonitorDao.statInputMonitorChart(params);

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return result;
    }
    
	public List<LinkedHashMap<String,?>> selectOpenInputMonitorstatblList(Params params) throws DataAccessException, Exception {
        return statInputMonitorDao.selectOpenInputMonitorstatblList(params);       
}
	
	public List<LinkedHashMap<String,?>> selectOpenInputMonitorwrtOrgList(Params params) throws DataAccessException, Exception {
        return statInputMonitorDao.selectOpenInputMonitorwrtOrgList(params);       
}
}

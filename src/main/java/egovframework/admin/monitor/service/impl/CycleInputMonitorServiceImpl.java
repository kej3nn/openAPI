package egovframework.admin.monitor.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.monitor.service.CycleInputMonitorService;
import egovframework.admin.monitor.service.OpenInputMonitorService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.service.BaseService;

@Service(value = "cycleInputMonitorService")
public class CycleInputMonitorServiceImpl extends BaseService implements CycleInputMonitorService {

    @Resource(name = "cycleInputMonitorDao")
    protected CycleInputMonitorDao cycleInputMonitorDao;

    public List<Record> selectOption(Params params) {
        return (List<Record>) cycleInputMonitorDao.selectOption(params);
    }

    /**
     * 메인 리스트 조회(페이징 처리)
     */
    @Override
    public Paging selectCycleInputMonitorListPaging(Params params) {
        if (params.getStringArray("loadCd") != null) {    //입력주기
            params.set("loadCdArr", new ArrayList<String>(Arrays.asList(params.getStringArray("loadCd"))));
        }
        Paging list = cycleInputMonitorDao.selectCycleInputMonitorList(params, params.getPage(), params.getRows());
        return list;
    }


    @Override
    public Record cycleInputMonitorChart(Params params) {
        Record result = new Record();

        try {
            if (params.getStringArray("loadCd") != null) {    //입력주기
                params.set("loadCdArr", new ArrayList<String>(Arrays.asList(params.getStringArray("loadCd"))));
            }
        	result = (Record) cycleInputMonitorDao.cycleInputMonitorChart(params);

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return result;
    }
}

package egovframework.admin.monitor.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.admin.monitor.service.Monitor;
import egovframework.admin.monitor.service.Monitor2;
import egovframework.admin.monitor.service.MonitorService;
import egovframework.admin.monitor.service.StatService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.portal.service.service.OpenInfLog;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("MonitorService")
public class MonitorServiceImpl extends AbstractServiceImpl implements MonitorService {

    @Resource(name = "MonitorDAO")
    private MonitorDAO monitorDAO;

    @Override
    public Map<String, Object> menuLogIbPaging(Monitor monitor) {
        int cnt = 0;
        List<OpenInfLog> result = monitorDAO.selectMenuLogList(monitor);
        if (result.size() != 0) {
            cnt = result.get(0).getTotCnt();
        }
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("resultList", result);
        map.put("resultCnt", Integer.toString(cnt));
        return map;
    }

    @Override
    public Map<String, Object> menuLog2IbPaging(Monitor monitor) {
        int cnt = 0;
        List<OpenInfLog> result = monitorDAO.selectMenuLogList2(monitor);
        if (result.size() != 0) {
            cnt = result.get(0).getTotCnt();
        }
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("resultList", result);
        map.put("resultCnt", Integer.toString(cnt));
        return map;
    }

    @Override
    public Map<String, Object> netConnMonitorListIbPaging(Monitor2 param) {
        param.setStartDttm(param.getStartDttm().replaceAll("-", ""));
        param.setEndDttm(param.getEndDttm().replaceAll("-", ""));

        List<Monitor2> result = monitorDAO.selectNetConnMonitorList(param);
        int cnt = 0;
        if (result.size() > 0) {
            cnt = result.get(0).getTotalCnt();
        }
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("resultList", result);
        map.put("resultCnt", Integer.toString(cnt));
        return map;
    }

    @Override
    public Map<String, Object> netConnMonitorDetailIbPaging(Monitor2 monitor) {
        List<Monitor2> result = monitorDAO.selectNetConnMonitorDetail(monitor);
        int cnt = 0;
        if (result.size() > 0) {
            cnt = result.get(0).getTotalCnt();
        }
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("resultList", result);
        map.put("resultCnt", Integer.toString(cnt));
        return map;
    }

    @Override
    public Map<String, Object> qualityMonitorListIbPaging(Monitor2 monitor) {
        monitor.setStartDttm(monitor.getStartDttm().replaceAll("-", ""));
        monitor.setEndDttm(monitor.getEndDttm().replaceAll("-", ""));

        List<Monitor2> result = monitorDAO.selectQuailtyMonitorList(monitor);
        int cnt = 0;
        if (result.size() > 0) {
            cnt = result.get(0).getTotalCnt();
        }
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("resultList", result);
        map.put("resultCnt", Integer.toString(cnt));
        return map;
    }

    @Override
    public Map<String, Object> qualityMonitorDetailIbPaging(Monitor2 monitor) {
        List<Monitor2> result = monitorDAO.selectQuailtyMonitorDetail(monitor);
        int cnt = 0;
        if (result.size() > 0) {
            cnt = result.get(0).getTotalCnt();
        }
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("resultList", result);
        map.put("resultCnt", Integer.toString(cnt));
        return map;
    }

    @Override
    public Map<String, Object> outConnMonitorListIbPaging(Monitor2 monitor) {
        monitor.setStartDttm(monitor.getStartDttm().replaceAll("-", ""));
        monitor.setEndDttm(monitor.getEndDttm().replaceAll("-", ""));

        List<Monitor2> result = monitorDAO.selectOutMonitorList(monitor);
        int cnt = 0;
        if (result.size() > 0) {
            cnt = result.get(0).getTotalCnt();
        }
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("resultList", result);
        map.put("resultCnt", Integer.toString(cnt));
        return map;
    }

    @Override
    public Map<String, Object> selectStatServiceListAllIbPaging(StatService statService) {

        List<StatService> result = monitorDAO.selectStatServiceListAll(statService);
        int cnt = monitorDAO.selectStatServiceListAllCnt(statService);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("resultList", result);
        map.put("resultCnt", Integer.toString(cnt));
        return map;
    }

    @Override
    public List<StatService> selectStatServiceList(StatService statService) {
        List<StatService> result = new ArrayList<StatService>();
        try {
            result = monitorDAO.selectStatServiceList(statService);
            result.get(0).setAppr(result.get(0).getApprGrade() + " / " + result.get(0).getApprCnt());
        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }
}

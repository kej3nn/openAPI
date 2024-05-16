package egovframework.admin.monitor.web;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.MapUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.admin.basicinf.service.CommMenuService;
import egovframework.admin.basicinf.service.CommUsrService;
import egovframework.admin.monitor.service.Monitor;
import egovframework.admin.monitor.service.Monitor2;
import egovframework.admin.monitor.service.MonitorService;
import egovframework.admin.monitor.service.StatService;
import egovframework.admin.opendt.web.OpenCateController;
import egovframework.admin.openinf.service.OpenOrgUsrRel;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.code.service.CodeListService;
import egovframework.common.file.service.FileService;
import egovframework.common.grid.IBSheetListVO;
import egovframework.common.helper.Messagehelper;
import egovframework.common.helper.MetaExceldownhelper;
import egovframework.common.util.UtilJson;

@Controller
//@SessionAttributes(types = SgvnCommAid.class)
public class MonitorController implements InitializingBean {

    protected static final Log logger = LogFactory.getLog(OpenCateController.class);

    static class statService extends HashMap<String, ArrayList<StatService>> {
    }

    static class OpenOrgUsrRels extends
            HashMap<String, ArrayList<OpenOrgUsrRel>> {
    }

    @Resource(name = "CommUsrService")
    private CommUsrService commUsrService;

    @Resource(name = "MonitorService")
    private MonitorService monitorService;


    //공통코드 사용시 선언
    @Resource
    private CodeListService commCodeListService;


    //공통 메시지 사용시 선언
    @Resource
    Messagehelper messagehelper;

    @Resource
    EgovMessageSource message;

    @Autowired
    MetaExceldownhelper metaExceldownhelper;

    @Resource(name = "CommMenuService")
    private CommMenuService commMenuService;

    @Resource(name = "FileService")
    private FileService FileService;

    private ObjectMapper objectMapper = new ObjectMapper();


    public void afterPropertiesSet() {

    }

    /**
     * 공통코드를 조회 한다.
     *
     * @return Map<String, Object>
     * @throws Exception
     */

    @ModelAttribute("codeMap")
    public Map<String, Object> getcodeMap() {
        Map<String, Object> codeMap = new HashMap<String, Object>();
        try {
            codeMap.put("cclCdIbs", UtilJson.convertJsonString(commCodeListService
                    .getCodeListIBS("D1008")));
            codeMap.put("cateIdIbs", UtilJson.convertJsonString(commCodeListService
                    .getCodeListIBS("D1025")));// 분류정보 ibSheet
            codeMap.put("orgCdIbs", UtilJson.convertJsonString(commCodeListService
                    .getEntityCodeListIBS("ORG_CD")));
            codeMap.put("infStatsIbs", UtilJson
                    .convertJsonString(commCodeListService
                            .getEntityCodeListIBS("INF_STATS")));
            codeMap.put("pressStateIbs", UtilJson
                    .convertJsonString(commCodeListService
                            .getEntityCodeListIBS("PRSS_STATE")));
            codeMap.put("cateNm", commCodeListService.getEntityCodeList("CATE_NM"));// 분류정보
            codeMap.put("openCd", commCodeListService.getCodeList("D1001"));
            codeMap.put("causeCd", commCodeListService.getCodeList("D1002"));
            codeMap.put("cclCd", commCodeListService.getCodeList("D1008"));
            codeMap.put("loadCd", commCodeListService.getCodeList("D1009"));
            codeMap.put("themeCd", commCodeListService.getCodeList("D1105"));
            codeMap.put("saCd", commCodeListService.getCodeList("D1106"));
            codeMap.put("jobCdIbs", UtilJson.convertJsonString(commCodeListService
                    .getCodeListIBS("C1003", true)));

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return codeMap;
    }


    /**
     * 내부연계모니터링 조회화면으로 이동한다.
     *
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/monitor/monitorInPage.do")
    public String monitorInPage(ModelMap model) {

        return "/admin/monitor/monitorin";
    }

    /**
     * 외부연계모니터링 조회화면으로 이동한다.
     *
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/monitor/monitorOutPage.do")
    public String monitorOutPage(ModelMap model) {
        return "/admin/monitor/monitorout";
    }


    /**
     * 내부연계모니터링 조회화면으로 이동한다.
     *
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/monitor/menuLogPage.do")
    public String menuLogPage(ModelMap model) {
        return "/admin/monitor/menulog";
    }

    @RequestMapping("/admin/monitor/menuLogList.do")
    @ResponseBody
    public IBSheetListVO<Monitor> menuLogList(@ModelAttribute("monitor") Monitor monitor, ModelMap model) {
        // 페이징 처리시 반드시 *IbPaging 메소드명을 사용해야함
        Map<String, Object> map = monitorService.menuLogIbPaging(monitor);
        @SuppressWarnings("unchecked")
        List<Monitor> result = (List<Monitor>) map.get("resultList");
        int cnt = Integer.parseInt((String) map.get("resultCnt"));
        return new IBSheetListVO<Monitor>(result, cnt);

    }

    @RequestMapping("/admin/monitor/menuLogList2.do")
    @ResponseBody
    public IBSheetListVO<Monitor> menuLogList2(@ModelAttribute("monitor") Monitor monitor, ModelMap model) {
        // 페이징 처리시 반드시 *IbPaging 메소드명을 사용해야함
        Map<String, Object> map = monitorService.menuLog2IbPaging(monitor);
        @SuppressWarnings("unchecked")
        List<Monitor> result = (List<Monitor>) map.get("resultList");
        int cnt = Integer.parseInt((String) map.get("resultCnt"));
        return new IBSheetListVO<Monitor>(result, cnt);

    }


    /**
     * 망 연계 모니터링 화면
     *
     * @param model
     * @return
     */
    @RequestMapping("/admin/monitor/netConnMonitorPage.do")
    public String netConnMonitorPage() {
        return "/admin/monitor/netConnMonitor";
    }

    /**
     * 목록
     *
     * @param param
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/monitor/netConnMonitorList.do")
    @ResponseBody
    public IBSheetListVO<Monitor2> netConnMonitorList(@ModelAttribute Monitor2 param, ModelMap model) {
        Map<String, Object> resultMap = monitorService.netConnMonitorListIbPaging(param);
        List<Monitor2> result = (List<Monitor2>) resultMap.get("resultList");
        int cnt = Integer.parseInt((String) resultMap.get("resultCnt"));
        return new IBSheetListVO<Monitor2>(result, cnt);
    }

    @RequestMapping("/admin/monitor/netConnMonitorDetail.do")
    @ResponseBody
    public IBSheetListVO<Monitor2> netConnMonitorDetail(@ModelAttribute Monitor2 param, ModelMap model) {
        Map<String, Object> resultMap = monitorService.netConnMonitorDetailIbPaging(param);

        if (MapUtils.isNotEmpty(resultMap)) {
            List<Monitor2> result = (List<Monitor2>) resultMap.get("resultList");
            int cnt = Integer.parseInt((String) resultMap.get("resultCnt"));
            return new IBSheetListVO<Monitor2>(result, cnt);
        } else {
            return new IBSheetListVO<Monitor2>();
        }
    }

    /**
     * 개인정보비식별_모니터링
     *
     * @param model
     * @return
     */
    @RequestMapping("/admin/monitor/personInfoPage.do")
    public String personInfoPage() {
        return "/admin/monitor/personInfo";
    }


    /**
     * 품질 모니터링
     *
     * @param model
     * @return
     */
    @RequestMapping("/admin/monitor/qualityInfoPage.do")
    public String qualityInfoPage() {
        return "/admin/monitor/qualityInfo";
    }

    @RequestMapping("/admin/monitor/qualityInfoList.do")
    @ResponseBody
    public IBSheetListVO<Monitor2> qualityInfoList(@ModelAttribute Monitor2 param, ModelMap model) {
        Map<String, Object> resultMap = monitorService.qualityMonitorListIbPaging(param);
        List<Monitor2> result = (List<Monitor2>) resultMap.get("resultList");
        int cnt = Integer.parseInt((String) resultMap.get("resultCnt"));
        return new IBSheetListVO<Monitor2>(result, cnt);
    }

    @RequestMapping("/admin/monitor/qualityInfoDetail.do")
    @ResponseBody
    public IBSheetListVO<Monitor2> qualityInfoDetail(@ModelAttribute Monitor2 param, ModelMap model) {
        Map<String, Object> resultMap = monitorService.qualityMonitorDetailIbPaging(param);
        List<Monitor2> result = (List<Monitor2>) resultMap.get("resultList");
        int cnt = Integer.parseInt((String) resultMap.get("resultCnt"));
        return new IBSheetListVO<Monitor2>(result, cnt);
    }

    /**
     * 외부연계 모니터링
     *
     * @return
     */
    @RequestMapping("/admin/monitor/outConnMonitorPage.do")
    public String outConnMonitorPage() {
        return "/admin/monitor/outConnMonitor";
    }

    /**
     * 주소로그 모니터링
     *
     * @return
     */
    @RequestMapping("/admin/monitor/refLogMonitorPage.do")
    public String refLogMonitorPage() {
        return "/admin/monitor/refLogMonitor";
    }

    @RequestMapping("/admin/monitor/outConnMonitorList.do")
    @ResponseBody
    public IBSheetListVO<Monitor2> outConnMonitorList(@ModelAttribute Monitor2 param, ModelMap model) {
        Map<String, Object> resultMap = monitorService.outConnMonitorListIbPaging(param);
        List<Monitor2> result = (List<Monitor2>) resultMap.get("resultList");
        int cnt = Integer.parseInt((String) resultMap.get("resultCnt"));
        return new IBSheetListVO<Monitor2>(result, cnt);
    }

    /**
     * 주소정제 모니터링 화면
     *
     * @param model
     * @return
     */
    @RequestMapping("/admin/monitor/refMonitorPage.do")
    public String refMonitorPage() {
        return "/admin/monitor/refMonitor";
    }

    /**
     * 서비스 현황 화면
     *
     * @param model
     * @return
     */
    @RequestMapping("/admin/monitor/statServicePage.do")
    public String statServicePage() {
        return "/admin/monitor/statService";
    }

    /**
     * 목록
     *
     * @param param
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/monitor/statServiceListAll.do")
    @ResponseBody
    public IBSheetListVO<StatService> statServiceListAll(@ModelAttribute("searchVO") StatService statService, ModelMap model) {
        Map<String, Object> resultMap = monitorService.selectStatServiceListAllIbPaging(statService);
        List<StatService> result = (List<StatService>) resultMap.get("resultList");
        int cnt = Integer.parseInt((String) resultMap.get("resultCnt"));
        return new IBSheetListVO<StatService>(result, cnt);
    }


    /**
     * 목록
     *
     * @param param
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/monitor/statServiceList.do")
    @ResponseBody
    public Map<String, Object> statServiceList(StatService statService, ModelMap model) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("DATA", monitorService.selectStatServiceList(statService));
        return map;
    }
}

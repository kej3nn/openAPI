package egovframework.admin.gaapi.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.security.GeneralSecurityException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import com.google.api.client.googleapis.auth.oauth2.GoogleCredential;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.gson.GsonFactory;
import com.google.api.services.analyticsreporting.v4.AnalyticsReporting;
import com.google.api.services.analyticsreporting.v4.AnalyticsReportingScopes;
import com.google.api.services.analyticsreporting.v4.model.*;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.admin.gaapi.service.AdminGaApiService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;

/**
 * 구글 애널리틱스 화면 컨트롤러 클래스
 *
 * @version 1.0
 * @author CSB
 * @since 2020/11/02
 */
@Controller
public class AdminGaApiController extends BaseController {

    protected static final Log logger = LogFactory.getLog(AdminGaApiController.class);

    @Resource(name = "adminGaApiService")
    protected AdminGaApiService adminGaApiService;

    private static final String APPLICATION_NAME = "OPEN ASSEMBLY"; //어플리케이션 이름
    private static final JsonFactory JSON_FACTORY = GsonFactory.getDefaultInstance();
    private static final String KEY_FILE_LOCATION = EgovProperties.getProperty("Globals.GoogleKeyFile"); //구글 키파일(json)
    private static final String VIEW_ID = EgovProperties.getProperty("Globals.GoogleViewId"); //구글 뷰아이디


    /**
     * 구글 사이트 분석 현황 - 접속자수 리스트 - 페이지
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/gaapi/statAcesGGPage.do")
    public String statAcesGGPage(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        ArrayList<String> metricsList = null;
        ArrayList<String> dimensionList = null;

        try {
            Date dDate = new Date();
            dDate = new Date(dDate.getTime() + (1000 * 60 * 60 * 24 * -1));
            SimpleDateFormat dSdf = new SimpleDateFormat("yyyyMMdd");
            String yesterday = dSdf.format(dDate);

            params.put("yyyymmdd", yesterday); //어제 날짜 세팅
            params.put("statGb", "aces");

            int dup = adminGaApiService.statAcesGGCheckDup(params);

            if (dup == 0) {

                AnalyticsReporting service = initializeAnalyticsReporting(); //구글 서비스계정 인증

                String[] metricsArray = {"users", "sessions", "bounceRate", "sessionDuration"};
                String[] dimensionArray = {"date"};

                String startDate = adminGaApiService.getStatAcesGGMaxStartDate(params); //시작 날짜 조회
                params.put("startDate", startDate);

                metricsList = new ArrayList<String>();
                for (int i = 0; i < metricsArray.length; i++) {
                    String[] splitMetrics = metricsArray[i].split(",");
                    for (int j = 0; j < splitMetrics.length; j++) {
                        metricsList.add(splitMetrics[j]);
                    }
                }

                dimensionList = new ArrayList<String>();
                for (int i = 0; i < dimensionArray.length; i++) {
                    String[] splitDimension = dimensionArray[i].split(",");
                    for (int j = 0; j < splitDimension.length; j++) {
                        dimensionList.add(splitDimension[j]);
                    }
                }

                GetReportsResponse response = getReport(service, metricsList, dimensionList, params); //GA 데이터 호출
                saveGA(response, params); // GA 데이터 저장
                response.clear();
                metricsList.clear();
                dimensionList.clear();
            }
        } catch (IOException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        // 뷰이름을 반환한다.
        return "/admin/gaapi/statAcesGG";
    }

    /**
     * 구글 사이트 분석 현황 - 접속자수 리스트 조회
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/gaapi/selectStatAcesGGList.do")
    public String selectStatAcesGGList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        Object result = adminGaApiService.selectStatAcesGGListPaging(params);
        // 모델에 객체를 추가한다.
        addObject(model, result);
        return "jsonView";
    }

    /**
     * 구글 사이트 분석 현황 - 페이지 뷰 - 페이지
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/gaapi/statPageGGPage.do")
    public String statPageGGPage(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        ArrayList<String> metricsList = null;
        ArrayList<String> dimensionList = null;

        try {
            Date dDate = new Date();
            dDate = new Date(dDate.getTime() + (1000 * 60 * 60 * 24 * -1));
            SimpleDateFormat dSdf = new SimpleDateFormat("yyyyMMdd");
            String yesterday = dSdf.format(dDate);

            params.put("yyyymmdd", yesterday); //어제 날짜 세팅
            params.put("statGb", "page");

            int dup = adminGaApiService.statPageGGCheckDup(params);

            if (dup == 0) {
                AnalyticsReporting service = initializeAnalyticsReporting(); //구글 서비스계정 인증

                String[] metricsArray = {"pageviews"};
                String[] dimensionArray = {"date", "pageTitle"};

                String startDate = adminGaApiService.getStatPageGGMaxStartDate(params); //시작 날짜 조회
                params.put("startDate", startDate);

                metricsList = new ArrayList<String>();
                for (int i = 0; i < metricsArray.length; i++) {
                    String[] splitMetrics = metricsArray[i].split(",");
                    for (int j = 0; j < splitMetrics.length; j++) {
                        metricsList.add(splitMetrics[j]);
                    }
                }

                dimensionList = new ArrayList<String>();
                for (int i = 0; i < dimensionArray.length; i++) {
                    String[] splitDimension = dimensionArray[i].split(",");
                    for (int j = 0; j < splitDimension.length; j++) {
                        dimensionList.add(splitDimension[j]);
                    }
                }

                GetReportsResponse response = getReport(service, metricsList, dimensionList, params); //GA 데이터 호출
                saveGA(response, params); // GA 데이터 저장
                response.clear();
                metricsList.clear();
                dimensionList.clear();
            }
        } catch (IOException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        // 뷰이름을 반환한다.
        return "/admin/gaapi/statPageGG";
    }

    /**
     * 구글 페이지 뷰 리스트 조회
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/gaapi/selectStatPageGGList.do")
    public String selectStatPageGGList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        Object result = adminGaApiService.selectStatPageGGListPaging(params);
        // 모델에 객체를 추가한다.
        addObject(model, result);
        return "jsonView";
    }

    /**
     * 구글 사이트 분석 현황 - 지역현황 - 페이지
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/gaapi/statAreaGGPage.do")
    public String statAreaGGPage(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        ArrayList<String> metricsList = null;
        ArrayList<String> dimensionList = null;

        try {
            Date dDate = new Date();
            dDate = new Date(dDate.getTime() + (1000 * 60 * 60 * 24 * -1));
            SimpleDateFormat dSdf = new SimpleDateFormat("yyyyMMdd");
            String yesterday = dSdf.format(dDate);

            params.put("yyyymmdd", yesterday); //어제 날짜 세팅
            params.put("statGb", "area");

            int dup = adminGaApiService.statAreaGGCheckDup(params);

            if (dup == 0) {
                AnalyticsReporting service = initializeAnalyticsReporting(); //구글 서비스계정 인증

                String[] metricsArray = {"users", "newUsers", "sessions"};
                String[] dimensionArray = {"date", "countryIsoCode", "country"};

                String startDate = adminGaApiService.getStatAreaGGMaxStartDate(params); //시작 날짜 조회
                params.put("startDate", startDate);

                metricsList = new ArrayList<String>();
                for (int i = 0; i < metricsArray.length; i++) {
                    String[] splitMetrics = metricsArray[i].split(",");
                    for (int j = 0; j < splitMetrics.length; j++) {
                        metricsList.add(splitMetrics[j]);
                    }
                }

                dimensionList = new ArrayList<String>();
                for (int i = 0; i < dimensionArray.length; i++) {
                    String[] splitDimension = dimensionArray[i].split(",");
                    for (int j = 0; j < splitDimension.length; j++) {
                        dimensionList.add(splitDimension[j]);
                    }
                }

                GetReportsResponse response = getReport(service, metricsList, dimensionList, params); //GA 데이터 호출
                saveGA(response, params); // GA 데이터 저장
                response.clear();
                metricsList.clear();
                dimensionList.clear();
            }
        } catch (IOException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        // 뷰이름을 반환한다.
        return "/admin/gaapi/statAreaGG";
    }

    /**
     * 구글 사이트 분석 현황 - 지역현황 리스트 조회
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/gaapi/selectStatAreaGGList.do")
    public String selectStatAreaGGList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        Object result = adminGaApiService.selectStatAreaGGListPaging(params);
        // 모델에 객체를 추가한다.
        addObject(model, result);
        return "jsonView";
    }

    /**
     * 구글 사이트 분석 현황 - 접속경로 - 페이지
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/gaapi/statAcrtGGPage.do")
    public String statAcrtGGPage(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        ArrayList<String> metricsList = null;
        ArrayList<String> dimensionList = null;

        try {
            Date dDate = new Date();
            dDate = new Date(dDate.getTime() + (1000 * 60 * 60 * 24 * -1));
            SimpleDateFormat dSdf = new SimpleDateFormat("yyyyMMdd");
            String yesterday = dSdf.format(dDate);

            params.put("yyyymmdd", yesterday); //어제 날짜 세팅
            params.put("statGb", "acrt");

            int dup = adminGaApiService.statAcrtGGCheckDup(params);

            if (dup == 0) {
                AnalyticsReporting service = initializeAnalyticsReporting(); //구글 서비스계정 인증

                String[] metricsArray = {"users", "newUsers", "sessions"};
                String[] dimensionArray = {"date", "deviceCategory"};

                String startDate = adminGaApiService.getStatAcrtGGMaxStartDate(params); //시작 날짜 조회
                params.put("startDate", startDate);

                metricsList = new ArrayList<String>();
                for (int i = 0; i < metricsArray.length; i++) {
                    String[] splitMetrics = metricsArray[i].split(",");
                    for (int j = 0; j < splitMetrics.length; j++) {
                        metricsList.add(splitMetrics[j]);
                    }
                }

                dimensionList = new ArrayList<String>();
                for (int i = 0; i < dimensionArray.length; i++) {
                    String[] splitDimension = dimensionArray[i].split(",");
                    for (int j = 0; j < splitDimension.length; j++) {
                        dimensionList.add(splitDimension[j]);
                    }
                }

                GetReportsResponse response = getReport(service, metricsList, dimensionList, params); //GA 데이터 호출
                saveGA(response, params); // GA 데이터 저장
                response.clear();
                metricsList.clear();
                dimensionList.clear();
            }
        } catch (IOException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        // 뷰이름을 반환한다.
        return "/admin/gaapi/statAcrtGG";
    }

    /**
     * 구글 사이트 분석 현황 - 접속경로 리스트 조회
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/gaapi/selectStatAcrtGGList.do")
    public String selectStatAcrtGGList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        Object result = adminGaApiService.selectStatAcrtGGListPaging(params);
        // 모델에 객체를 추가한다.
        addObject(model, result);
        return "jsonView";
    }

    /**
     * 구글 사이트 분석 현황 - 인구통계 - 페이지
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/gaapi/statPoplGGPage.do")
    public String statPoplGGPage(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        ArrayList<String> metricsList = null;
        ArrayList<String> dimensionList = null;

        try {
            Date dDate = new Date();
            dDate = new Date(dDate.getTime() + (1000 * 60 * 60 * 24 * -1));
            SimpleDateFormat dSdf = new SimpleDateFormat("yyyyMMdd");
            String yesterday = dSdf.format(dDate);

            params.put("yyyymmdd", yesterday); //어제 날짜 세팅
            params.put("statGb", "popl");

            int dup = adminGaApiService.statPoplGGCheckDup(params);

            if (dup == 0) {
                AnalyticsReporting service = initializeAnalyticsReporting(); //구글 서비스계정 인증

                String[] metricsArray = {"users"};
                String[] dimensionArray = {"date", "userGender", "userAgeBracket"};

                String startDate = adminGaApiService.getStatPoplGGMaxStartDate(params); //시작 날짜 조회
                params.put("startDate", startDate);

                metricsList = new ArrayList<String>();
                for (int i = 0; i < metricsArray.length; i++) {
                    String[] splitMetrics = metricsArray[i].split(",");
                    for (int j = 0; j < splitMetrics.length; j++) {
                        metricsList.add(splitMetrics[j]);
                    }
                }

                dimensionList = new ArrayList<String>();
                for (int i = 0; i < dimensionArray.length; i++) {
                    String[] splitDimension = dimensionArray[i].split(",");
                    for (int j = 0; j < splitDimension.length; j++) {
                        dimensionList.add(splitDimension[j]);
                    }
                }

                GetReportsResponse response = getReport(service, metricsList, dimensionList, params); //GA 데이터 호출
                saveGA(response, params); // GA 데이터 저장
                response.clear();
                metricsList.clear();
                dimensionList.clear();
            }
        } catch (IOException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        // 뷰이름을 반환한다.
        return "/admin/gaapi/statPoplGG";
    }

    /**
     * 구글 사이트 분석 현황 - 인구통계 리스트 조회
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/gaapi/selectStatPoplGGList.do")
    public String selectStatPoplGGList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        Object result = adminGaApiService.selectStatPoplGGListPaging(params);
        // 모델에 객체를 추가한다.
        addObject(model, result);
        return "jsonView";
    }

    /**
     * 구글 사이트 분석 현황 - 지역현황 상세 - 페이지
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/gaapi/statAreaDGGPage.do")
    public String statAreaDGGPage(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        ArrayList<String> metricsList = null;
        ArrayList<String> dimensionList = null;

        try {
            Date dDate = new Date();
            dDate = new Date(dDate.getTime() + (1000 * 60 * 60 * 24 * -1));
            SimpleDateFormat dSdf = new SimpleDateFormat("yyyyMMdd");
            String yesterday = dSdf.format(dDate);

            params.put("yyyymmdd", yesterday); //어제 날짜 세팅
            params.put("statGb", "aread");

            int dup = adminGaApiService.statAreaDGGCheckDup(params);

            if (dup == 0) {
                AnalyticsReporting service = initializeAnalyticsReporting(); //구글 서비스계정 인증

                String[] metricsArray = {"users", "newUsers", "sessions"};
                String[] dimensionArray = {"date", "countryIsoCode", "country", "regionId", "region"};

                String startDate = adminGaApiService.getStatAreaDGGMaxStartDate(params); //시작 날짜 조회
                params.put("startDate", startDate);

                metricsList = new ArrayList<String>();
                for (int i = 0; i < metricsArray.length; i++) {
                    String[] splitMetrics = metricsArray[i].split(",");
                    for (int j = 0; j < splitMetrics.length; j++) {
                        metricsList.add(splitMetrics[j]);
                    }
                }

                dimensionList = new ArrayList<String>();
                for (int i = 0; i < dimensionArray.length; i++) {
                    String[] splitDimension = dimensionArray[i].split(",");
                    for (int j = 0; j < splitDimension.length; j++) {
                        dimensionList.add(splitDimension[j]);
                    }
                }

                GetReportsResponse response = getReport(service, metricsList, dimensionList, params); //GA 데이터 호출
                saveGA(response, params); // GA 데이터 저장
                response.clear();
                metricsList.clear();
                dimensionList.clear();
            }
        } catch (IOException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        // 뷰이름을 반환한다.
        return "/admin/gaapi/statAreaDGG";
    }

    /**
     * 구글 사이트 분석 현황 - 지역현황 상세 리스트 조회
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/gaapi/selectStatAreaDGGList.do")
    public String selectStatAreaDGGList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        Object result = adminGaApiService.selectStatAreaDGGListPaging(params);
        // 모델에 객체를 추가한다.
        addObject(model, result);
        return "jsonView";
    }

    /**
     * 구글 서비스 계정 인증
     *
     * @param file
     * @return
     * @throws GeneralSecurityException
     * @throws IOException
     */
    private static AnalyticsReporting initializeAnalyticsReporting() throws GeneralSecurityException, IOException {
        // 구글 서비스계정 인증
        ClassPathResource resource = new ClassPathResource(KEY_FILE_LOCATION);
        File jsonFile = resource.getFile();
        try {
            HttpTransport httpTransport = GoogleNetHttpTransport.newTrustedTransport();
            GoogleCredential credential = GoogleCredential
                    .fromStream(new FileInputStream(jsonFile))
                    .createScoped(AnalyticsReportingScopes.all());
            return new AnalyticsReporting.Builder(httpTransport, JSON_FACTORY, credential)
                    .setApplicationName(APPLICATION_NAME).build();

        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
            return null;

        } catch (Throwable t) {
            EgovWebUtil.exLogging(t);
            return null;
        }
    }

    /**
     * 구글 애널리틱스 데이터 호출
     *
     * @param service
     * @param metrics
     * @param params
     * @return
     * @throws IOException
     */
    private static GetReportsResponse getReport(AnalyticsReporting service, ArrayList<String> metrics, ArrayList<String> dimensions, Params params) throws IOException {

        String statDate = (String) params.get("startDate"); // 시작 날짜 조회
        //2020-02-16 열린국회 오픈일
        DateRange dateRange = new DateRange();
        if (statDate != null && statDate != "") {
            dateRange.setStartDate(statDate);
        } else {
            dateRange.setStartDate("2020-02-16"); //초기 데이터 적재연도
        }
        dateRange.setEndDate("yesterday");

        int metricsSize = metrics.size();
        Metric[] metricsArray = new Metric[metricsSize];

        for (int i = 0; i < metricsSize; i++) { // Metric 설정
            Metric metric = new Metric()
                    .setExpression("ga:" + metrics.get(i))
                    .setAlias((String) metrics.get(i));
            metricsArray[i] = metric;
        }

        int dimensionsSize = dimensions.size();
        Dimension[] dimensionsArray = new Dimension[dimensionsSize];

        for (int i = 0; i < dimensionsSize; i++) {
            Dimension dimension = new Dimension()
                    .setName("ga:" + dimensions.get(i));
            dimensionsArray[i] = dimension;
        }
        // 구글애널리틱스 API 세팅
        ReportRequest request = new ReportRequest()
                .setViewId(VIEW_ID)
                .setDateRanges(Arrays.asList(dateRange))
                .setMetrics(Arrays.asList(metricsArray))
                .setDimensions(Arrays.asList(dimensionsArray));

        ArrayList<ReportRequest> requests = new ArrayList<ReportRequest>();
        requests.add(request);

        GetReportsRequest getReport = new GetReportsRequest()
                .setReportRequests(requests);

        // 구글애널리틱스 API 호출
        GetReportsResponse response = service.reports().batchGet(getReport).execute();

        return response;
    }

    /**
     * 구글 애널리틱스 데이터 저장
     *
     * @param response
     * @param params
     */
    public void saveGA(GetReportsResponse response, Params params) {

        for (Report report : response.getReports()) {
            ColumnHeader header = report.getColumnHeader();
            List<String> dimensionHeaders = header.getDimensions();
            List<MetricHeaderEntry> metricHeaders = header.getMetricHeader().getMetricHeaderEntries();
            List<ReportRow> rows = report.getData().getRows();

            if (rows == null) {
                return;
            }
            for (ReportRow row : rows) {
                List<String> dimensions = row.getDimensions();
                List<DateRangeValues> metrics = row.getMetrics();

                for (int i = 0; i < dimensionHeaders.size() && i < dimensions.size(); i++) {
                    String dimensionName = (dimensionHeaders.get(i)).replace("ga:", "");

                    params.put(dimensionName, dimensions.get(i));
                }

                for (int j = 0; j < metrics.size(); j++) {
                    DateRangeValues values = metrics.get(j);
                    for (int k = 0; k < values.getValues().size() && k < metricHeaders.size(); k++) {
                        params.put(metricHeaders.get(k).getName(), values.getValues().get(k));
                    }
                }
                adminGaApiService.insertStatGaApiSave(params); //구글 접속자수 저장
            }
        }
    }
}

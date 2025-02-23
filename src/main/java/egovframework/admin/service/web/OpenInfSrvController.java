package egovframework.admin.service.web;

import java.io.*;
import java.lang.reflect.Method;
import java.net.URLDecoder;
import java.util.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import egovframework.admin.basicinf.service.CommUsr;
import egovframework.admin.service.service.*;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.common.WiseOpenConfig;
import egovframework.common.base.controller.BaseController;
import egovframework.common.code.service.CodeListService;
import egovframework.common.file.service.FileService;
import egovframework.common.file.service.FileVo;
import egovframework.common.grid.CommVo;
import egovframework.common.grid.IBSResultVO;
import egovframework.common.grid.IBSheetListVO;
import egovframework.common.helper.*;
import egovframework.common.util.UtilJson;
import egovframework.common.util.UtilString;
import egovframework.common.util.UtilTree;

/**
 * 사용자 페이지로 이동하는 클래스
 *
 * @author wiseopenParams
 * @version 1.0
 * @since 2014.04.17
 */
@Controller
public class OpenInfSrvController extends BaseController implements InitializingBean {

    public static final int BUFF_SIZE = 2048;

    protected static final Log logger = LogFactory.getLog(OpenInfSrvController.class);

    // 공통코드 사용시 선언
    @Resource
    private CodeListService commCodeListService;

    @Resource(name = "FileService")
    private FileService FileService;

    @Resource(name = "OpenInfScolService")
    private OpenInfSrvService openInfSrvService;

    @Resource(name = "OpenInfScolService")
    private OpenInfSrvService openInfScolService;

    @Resource(name = "OpenInfMcolService")
    private OpenInfSrvService openInfMcolService;

    @Resource(name = "OpenInfTcolService")
    private OpenInfSrvService openInfTcolService;

    @Resource(name = "OpenInfCcolService")
    private OpenInfSrvService openInfCcolService;

    @Resource(name = "OpenInfAcolService")
    private OpenInfSrvService openInfAcolService;

    @Resource(name = "OpenInfLcolService")
    private OpenInfSrvService openInfLcolService;

    @Resource(name = "OpenInfFcolService")
    private OpenInfSrvService openInfFcolService;

    @Resource(name = "OpenInfVcolService")
    private OpenInfSrvService openInfVcolService;

    // 공통 메시지 사용시 선언
    @Resource
    Messagehelper messagehelper;

    @Autowired
    Jsondownheler jsondownheler;

    @Autowired
    Csvdownheler csvdownheler;

    @Autowired
    Exceldownheler exceldownheler;

    private ObjectMapper objectMapper = new ObjectMapper();

    static class openInfTcols extends HashMap<String, ArrayList<OpenInfTcol>> {
    }// IbSheet 데이터받기

    static class openInfScols extends HashMap<String, ArrayList<OpenInfScol>> {
    }// IbSheet 데이터받기

    static class openInfCcols extends HashMap<String, ArrayList<OpenInfCcol>> {
    }// IbSheet 데이터받기

    static class openInfMcols extends HashMap<String, ArrayList<OpenInfMcol>> {
    }// IbSheet 데이터받기

    static class openInfLcols extends HashMap<String, ArrayList<OpenInfLcol>> {
    }// IbSheet 데이터받기

    static class openInfFcols extends HashMap<String, ArrayList<OpenInfFcol>> {
    }// IbSheet 데이터받기

    static class openInfAcols extends HashMap<String, ArrayList<OpenInfAcol>> {
    }// IbSheet 데이터받기

    static class openInfVcols extends HashMap<String, ArrayList<OpenInfVcol>> {
    }// IbSheet 데이터받기

    public void afterPropertiesSet() {

    }

    /**
     * 공통코드를 조회 한다.
     *
     * @return
     * @throws Exception
     */
    @ModelAttribute("codeMap")
    public Map<String, Object> getcodeMap(String viewLang) {
        Map<String, Object> codeMap = new HashMap<String, Object>();
        codeMap.put("infStateIbs",
                UtilJson.convertJsonString(commCodeListService.getEntityCodeListIBS("INF_STATS", false, viewLang)));// 관리자권한
        // ibSheet
        codeMap.put("filtCd", commCodeListService.getCodeList("D1014"));// 관리자권한 ibSheet
        codeMap.put("viewCdIbs",
                UtilJson.convertJsonString(commCodeListService.getCodeListIBS("D1015", false, viewLang)));
        codeMap.put("viewCdApiIbs",
                UtilJson.convertJsonString(commCodeListService.getCodeListIBS("D1023", false, viewLang)));
        codeMap.put("colCdIbs",
                UtilJson.convertJsonString(commCodeListService.getCodeListIBS("D1021", false, viewLang)));
        codeMap.put("markerCd", commCodeListService.getCodeList("D1019"));
        codeMap.put("condOp", commCodeListService.getEntityCodeList("OP", "", viewLang));// 연산자
        codeMap.put("filtCode", commCodeListService.getEntityCodeList("FILT_CODE", "CODELIST", viewLang));// 대상코드
        codeMap.put("carryPeriodCd", commCodeListService.getEntityCodeList("FILT_CODE", "D1009", viewLang));// 적재주기(안전행정부표준코드)
        codeMap.put("useAgreeCd", commCodeListService.getEntityCodeList("FILT_CODE", "D1008", viewLang));// 이용허락 조건
        codeMap.put("cateNm", commCodeListService.getEntityCodeList("CATE_NM", "", viewLang));// 분류정보
        codeMap.put("tColCd", commCodeListService.getCodeList("D1029"));// 컬럼속성
        codeMap.put("xlnCd", commCodeListService.getCodeList("D1016")); // 축선색상코드
        codeMap.put("ylnCd", commCodeListService.getCodeList("D1017")); // 격자색상코드
        codeMap.put("sgrpCd", commCodeListService.getCodeList("D1018")); // 시리즈그룹코드
        codeMap.put("seriesCd", commCodeListService.getCodeList("D1020")); // 시리즈유형코드
        codeMap.put("seriesCdIbs",
                UtilJson.convertJsonString(commCodeListService.getEntityCodeListIBS("BAR", true, viewLang)));
        codeMap.put("barCdIbs",
                UtilJson.convertJsonString(commCodeListService.getEntityCodeListIBS("BAR", true, viewLang)));
        codeMap.put("pieIbs",
                UtilJson.convertJsonString(commCodeListService.getEntityCodeListIBS("PIE", true, viewLang)));
        codeMap.put("unitCdIbs",
                UtilJson.convertJsonString(commCodeListService.getCodeListIBS("D1013", true, viewLang))); // 단위
//		codeMap.put("seriesCdIbs", UtilJson.convertJsonString(commCodeListService.getCodeListIBS("D1020", true,viewLang)));
        codeMap.put("convCd", commCodeListService.getCodeList("S1002"));// 원자료
        codeMap.put("fileCd", commCodeListService.getCodeList("D1022"));// 파일종류
        codeMap.put("tblCd", commCodeListService.getEntityCodeList("TBL_CD"));// 팝업종류
        codeMap.put("bar", commCodeListService.getEntityCodeList("BAR"));// 팝업종류
        codeMap.put("pie", commCodeListService.getEntityCodeList("PIE"));// 팝업종류
        codeMap.put("fsclYy", commCodeListService.getCodeList("S1003")); // 회계년도

        // 2015.08.13 신익진 추가S
        codeMap.put("mediaMtdCd", commCodeListService.getCodeList("D1102"));
        codeMap.put("mediaTypeCd", commCodeListService.getCodeList("D1101"));
        codeMap.put("cclCd", commCodeListService.getCodeList("D1008"));
        codeMap.put("mediaMtdCdIbs",
                UtilJson.convertJsonString(commCodeListService.getCodeListIBS("D1102", true, viewLang)));
        codeMap.put("mediaTypeCdIbs",
                UtilJson.convertJsonString(commCodeListService.getCodeListIBS("D1101", true, viewLang)));

        // 2018.01.03 추가
        codeMap.put("fvtDataOrder", commCodeListService.getCodeList("C1018")); // 추천 순위
        codeMap.put("infState", commCodeListService.getCodeList("D1007")); // 개방상태
        codeMap.put("infSrv", commCodeListService.getCodeList("D1012")); // 서비스유형
//System.out.println(codeMap.get("viewCdIbs"));
        return codeMap;
    }

    /**
     * 서비스 조회화면으로 이동한다.
     *
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/service/openInfSrvPage.do")
    public String openInfServicePage(ModelMap model) {
        // 페이지 title을 가져오려면 반드시 *Page로 끝나야한다.
        // Interceptor(PageNavigationInterceptor)에서 조회함
        return "/admin/service/openinfsrv";
    }

    /**
     * 서비스를 전체 조회한다.
     *
     * @param openInfSrv
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/service/openInfListAll.do")
    @ResponseBody
    public IBSheetListVO<OpenInfSrv> openInfListAll(OpenInfSrv openInfSrv, ModelMap model) {
        // 페이징 처리와 IbSheet 헤더 정렬은 반드시 *IbPaging 메소드명을 사용해야함(AOP 사용)
        Map<String, Object> map = openInfSrvService.selectOpenInfAllIbPaging(openInfSrv);
        @SuppressWarnings("unchecked")
        List<OpenInfSrv> result = (List<OpenInfSrv>) map.get("resultList");
        int cnt = Integer.parseInt((String) map.get("resultCnt"));
        return new IBSheetListVO<OpenInfSrv>(result, cnt);
    }

    /**
     * 서비스정보를 조회한다.
     *
     * @param openInfSrv
     * @param model
     * @param srvCd
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/service/openInfSrvtInfo.do")
    @ResponseBody
    public TABListVo<OpenInfSrv> openInfSheetInfo(@RequestBody OpenInfSrv openInfSrv, ModelMap model, String srvCd) {
        if (openInfSrv == null) {
            openInfSrv = new OpenInfSrv();
        }
        if (EgovUserDetailsHelper.isAuthenticated()) {
            CommUsr loginVO = null;
            EgovUserDetailsHelper.getAuthenticatedUser();
            loginVO = (CommUsr) EgovUserDetailsHelper.getAuthenticatedUser();
            openInfSrv.setAccCd(loginVO.getAccCd()); // 로그인 된 유저 권환 획득
            openInfSrv.setSessionUsrCd(loginVO.getUsrCd());
        }
        return new TABListVo<OpenInfSrv>(openInfSrvService.selectOpenInfSrvInfo(openInfSrv));
    }

    /**
     * 서비스를 저장한다.
     *
     * @param openInfSrv
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/service/openInfColReg.do")
    @ResponseBody
    public IBSResultVO<CommVo> openInfColReg(HttpServletRequest request, OpenInfScol openInfSrv, ModelMap model) {
        FileOutputStream fos = null;
        if (openInfSrv == null) {
            openInfSrv = new OpenInfScol();
        }
        try {
            // OPEN API 인코딩 변환
            if (StringUtils.defaultString(openInfSrv.getSrvCd()).equals("A")) {
                String apiExp = URLDecoder.decode(StringUtils.defaultString(openInfSrv.getApiExp()), "UTF-8")
                        .replaceAll("\\|", "%20").replaceAll("\\+", "%20");
                openInfSrv.setApiExp(apiExp);

            } else if (StringUtils.defaultString(openInfSrv.getSrvCd()).equals("F")
                    || StringUtils.defaultString(openInfSrv.getSrvCd()).equals("S")) {
                final MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
                String infId = StringUtils.defaultString(openInfSrv.getInfId());
                // OPEN FILE 썸네일
                MultipartFile file = multiRequest.getFile("uploadTmnlfile");
                if (file.getSize() > 0) {
                    String srcFileNm = file.getOriginalFilename(); // 원본 파일명
                    String fileExt = FilenameUtils.getExtension(srcFileNm); // 파일확장자
                    String saveFileNm = infId + "." + fileExt; // 저장파일명(파라미터 값)

                    openInfSrv.setTmnlImgFile(saveFileNm);

                    // 저장 디렉토리(properties + ID)
                    String directoryPath = "";
                    if (StringUtils.defaultString(openInfSrv.getSrvCd()).equals("F")) {
                        directoryPath = EgovProperties.getProperty("Globals.OpenfileImg");
                    } else {
                        directoryPath = EgovProperties.getProperty("Globals.OpensheetImg");
                    }
                    directoryPath = EgovWebUtil.folderPathReplaceAll(directoryPath);
                    File directory = new File(directoryPath);

                    // 수정 : 권한 설정
                    directory.setExecutable(true, true);
                    directory.setReadable(true);
                    directory.setWritable(true, true);

                    if (!directory.isDirectory()) {
                        directory.mkdir();
                    }

                    if (saveFileNm != null && !"".equals(saveFileNm)) {
                        fos = new FileOutputStream(
                                EgovWebUtil.filePathBlackList(directoryPath + File.separator + saveFileNm));
                        InputStream stream = file.getInputStream();
                        int bytesRead = 0;
                        byte[] buffer = new byte[BUFF_SIZE];

                        while ((bytesRead = stream.read(buffer, 0, BUFF_SIZE)) != -1) {
                            fos.write(buffer, 0, bytesRead);
                        }

                    }

                }

            }

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        } finally {
            try {
                if (fos != null) {
                    fos.close();
                }
            } catch (IOException e) {
                EgovWebUtil.exLogging(e);
            } catch (Exception e) {
                EgovWebUtil.exLogging(e);
            }
        }
        int result = openInfSrvService.openInfSrvCUD(openInfSrv);
        return new IBSResultVO<CommVo>(result, messagehelper.getSavaMessage(result));
    }

    /**
     * 각서비스 컬럼을 조회한다.
     *
     * @param openInfSrv
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/service/openInfColList.do")
    @ResponseBody
    public IBSheetListVO<Object> openInfColList(OpenInfSrv openInfSrv, ModelMap model) {
        if (openInfSrv == null) {
            openInfSrv = new OpenInfSrv();
        }
        OpenInfSrvService service = setSerivce(StringUtils.defaultString(openInfSrv.getSrvCd()));
        Map<String, Object> map = service.selectOpenInfColList(openInfSrv);
        @SuppressWarnings("unchecked")
        List<Object> result = (List<Object>) map.get("resultList");
        return new IBSheetListVO<Object>(result, result.size());
    }

    /**
     * Sheet 서비스 컬럼을 저장한다.
     *
     * @param openInfSrv
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/service/openInfScolSave.do")
    @ResponseBody
    public IBSResultVO<CommVo> openInfScolSave(OpenInfSrv openInfSrv, ModelMap model, HttpServletRequest request,
                                               HttpServletResponse res) {
        if (openInfSrv == null) {
            openInfSrv = new OpenInfSrv();
        }
        final MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;

        String infId = StringUtils.defaultString(openInfSrv.getInfId());
        FileOutputStream fos = null;

        HashMap<String, Object> map = new HashMap<String, Object>();

        Enumeration<?> enumeration = request.getParameterNames();

        while (enumeration.hasMoreElements()) {
            String name = (String) enumeration.nextElement();
            map.put(getParameterName(name), getTextParameter(request, name));
        }

        Map<Object, Object> ibsMap = (Map<Object, Object>) JSONValue.parse(map.get("ibsSaveJson").toString());
        ObjectMapper mapper = new ObjectMapper();
        Map<String, ArrayList<OpenInfScol>> list2 = new HashMap<String, ArrayList<OpenInfScol>>();
        try {
            list2 = mapper.readValue(map.get("ibsSaveJson").toString(),
                    new TypeReference<Map<String, ArrayList<OpenInfScol>>>() {
                    });
        } catch (JsonParseException e1) {
            EgovWebUtil.exTransactionLogging(e1);
        } catch (JsonMappingException e1) {
            EgovWebUtil.exTransactionLogging(e1);
        } catch (IOException e1) {
            EgovWebUtil.exTransactionLogging(e1);
        }
        List<OpenInfScol> ibsList = (ArrayList<OpenInfScol>) ibsMap.get("data");

        // OPEN FILE 썸네일 저장용
        MultipartFile file = multiRequest.getFile("uploadTmnlfile");
        try {
            if (file.getSize() > 0) {
                String srcFileNm = file.getOriginalFilename(); // 원본 파일명
                String fileExt = FilenameUtils.getExtension(srcFileNm); // 파일확장자
                String saveFileNm = infId + "." + fileExt; // 저장파일명(파라미터 값)

                openInfSrv.setTmnlImgFile(saveFileNm);

                // 저장 디렉토리(properties + ID)
                String directoryPath = EgovProperties.getProperty("Globals.OpensheetImg");
                directoryPath = EgovWebUtil.folderPathReplaceAll(directoryPath);
                File directory = new File(directoryPath);

                // 수정 : 권한 설정
                directory.setExecutable(true, true);
                directory.setReadable(true);
                directory.setWritable(true, true);

                if (!directory.isDirectory()) {
                    directory.mkdir();
                }

                if (saveFileNm != null && !"".equals(saveFileNm)) {
                    fos = new FileOutputStream(
                            EgovWebUtil.filePathBlackList(directoryPath + File.separator + saveFileNm));
                    InputStream stream = file.getInputStream();
                    int bytesRead = 0;
                    byte[] buffer = new byte[BUFF_SIZE];

                    while ((bytesRead = stream.read(buffer, 0, BUFF_SIZE)) != -1) {
                        fos.write(buffer, 0, bytesRead);
                    }

                }
            }
        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        } finally {
            try {
                if (fos != null) {
                    fos.close();
                }
            } catch (IOException e) {
                EgovWebUtil.exLogging(e);
            } catch (Exception e) {
                EgovWebUtil.exLogging(e);
            }
        }

        ArrayList<?> tmp = (ArrayList<?>) ibsList;
        return openInfColSave(list2.get("data"), openInfSrv, model);
    }

    /**
     * Map 서비스 컬럼을 저장한다.
     *
     * @param data
     * @param openInfSrv
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/service/openInfMcolSave.do")
    @ResponseBody
    public IBSResultVO<CommVo> openInfMcolSave(@RequestBody openInfMcols data, OpenInfSrv openInfSrv, ModelMap model,
                                               HttpServletRequest request) {
        return openInfColSave(data.get("data"), openInfSrv, model);
    }

    /**
     * 통계 Sheet 서비스 컬럼을 저장한다.
     *
     * @param data
     * @param openInfSrv
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/service/openInfTcolSave.do")
    @ResponseBody
    public IBSResultVO<CommVo> openInfTcolSave(@RequestBody openInfTcols data, OpenInfSrv openInfSrv, ModelMap model) {
        return openInfColSave(data.get("data"), openInfSrv, model);
    }

    /**
     * chart 서비스 컬럼을 저장한다.
     *
     * @param data
     * @param openInfSrv
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/service/openInfCcolSave.do")
    @ResponseBody
    public IBSResultVO<CommVo> openInfCcolSave(@RequestBody openInfCcols data, OpenInfSrv openInfSrv, ModelMap model) {
        if (openInfSrv == null) {
            openInfSrv = new OpenInfSrv();
        }
        try {
            String rytitNm = URLDecoder.decode(StringUtils.defaultString(openInfSrv.getRytitNm()), "UTF-8")
                    .replaceAll("\\|", "%20").replaceAll("\\+", "%20");
            String lytitNm = URLDecoder.decode(StringUtils.defaultString(openInfSrv.getLytitNm()), "UTF-8")
                    .replaceAll("\\|", "%20").replaceAll("\\+", "%20");
            openInfSrv.setRytitNm(rytitNm);
            openInfSrv.setLytitNm(lytitNm);

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return openInfColSave(data.get("data"), openInfSrv, model);
    }

    /**
     * 각 컬럼정보를 저장한다.
     *
     * @param list
     * @param openInfSrv
     * @param model
     * @param fileVo
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public IBSResultVO<CommVo> openInfFileColSave(ArrayList<?> list, OpenInfSrv openInfSrv, ModelMap model,
                                                  FileVo fileVo) {
        if (openInfSrv == null) {
            openInfSrv = new OpenInfSrv();
        }
        String fileName = "";
        String[] fileNames = fileVo.getSaveFileNm();
        for (String name : fileNames) {
            fileName = name;
        }

        OpenInfSrvService service = setSerivce(StringUtils.defaultString(openInfSrv.getSrvCd()));

        for (int i = 0; list.size() > i; i++) {
            if (StringUtils.defaultString(openInfSrv.getSrvCd()).equals("L")) { // 링크 서비스
                ((ArrayList<OpenInfLcol>) list).get(i).setTmnlImgFile(fileName);
            } else if (StringUtils.defaultString(openInfSrv.getSrvCd()).equals("V")) { // 멀티미디어 서비스
                ((ArrayList<OpenInfVcol>) list).get(i).setTmnlImgFile(fileName);
            }
        }

        int result = service.openInfColCUD(openInfSrv, list);
        return new IBSResultVO<CommVo>(result, messagehelper.getSavaMessage(result));
    }

    /**
     * 각 컬럼정보를 저장한다.
     *
     * @param list
     * @param openInfSrv
     * @param model
     * @return
     * @throws Exception
     */
    public IBSResultVO<CommVo> openInfColSave(ArrayList<?> list, OpenInfSrv openInfSrv, ModelMap model) {
        if (openInfSrv == null) {
            openInfSrv = new OpenInfSrv();
        }
        OpenInfSrvService service = setSerivce(StringUtils.defaultString(openInfSrv.getSrvCd()));
        int result = service.openInfColCUD(openInfSrv, list);

        return new IBSResultVO<CommVo>(result, messagehelper.getSavaMessage(result));
    }

    /**
     * 링크 컬럼을 저장한다.
     *
     * @param list
     * @param openInfSrv
     * @return
     * @throws Exception
     */
    public IBSResultVO<CommVo> openInfColSave1(ArrayList<?> list, OpenInfSrv openInfSrv) {
        if (openInfSrv == null) {
            openInfSrv = new OpenInfSrv();
        }
        OpenInfSrvService service = setSerivce(StringUtils.defaultString(openInfSrv.getSrvCd()));
        int result = service.openInfColCUD(openInfSrv, list);
        result = 1;
        return new IBSResultVO<CommVo>(result, messagehelper.getSavaMessage(result));
    }

    /**
     * 옵션항목 페이지로 이동한다.
     *
     * @param openInfSrv
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/service/openInfColOptPopUp.do")
    public ModelAndView openInfColOptPopUp(OpenInfSrv openInfSrv, ModelMap model) {
        if (openInfSrv == null) {
            openInfSrv = new OpenInfSrv();
        }
        String srvCd = StringUtils.defaultString(openInfSrv.getSrvCd());
        OpenInfSrvService service = setSerivce(srvCd);
        ModelAndView modelAndView = new ModelAndView("/admin/service/popup/opt" + srvCd.toLowerCase() + "colpopup");
        modelAndView.addObject("resultList", service.selectOpenInfColPopInfo(openInfSrv).get("resultList"));
        return modelAndView;
    }

    /**
     * 옵션항목을 저장한다.
     *
     * @param openInfSrv
     * @param openInfScol
     * @param openInfMcol
     * @param openInfTcol
     * @param openInfCcol
     * @param openInfAcol
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/service/openInfColOptPopUpSave.do")
    @ResponseBody
    public IBSResultVO<CommVo> openInfColOpt(OpenInfSrv openInfSrv, OpenInfScol openInfScol, OpenInfMcol openInfMcol,
                                             OpenInfTcol openInfTcol, OpenInfCcol openInfCcol, OpenInfAcol openInfAcol, ModelMap model) {
        if (openInfSrv == null) {
            openInfSrv = new OpenInfSrv();
        }
        String srvCd = StringUtils.defaultString(openInfSrv.getSrvCd());
        Object obj = setGetObj(srvCd, openInfScol, openInfMcol, openInfTcol, openInfCcol, openInfAcol);
        OpenInfSrvService service = setSerivce(srvCd);
        int result = service.openInColOptPopupCUD(obj);
        return new IBSResultVO<CommVo>(result, messagehelper.getSavaMessage(result));
    }

    /**
     * 서비스 객체를 리턴한다.
     *
     * @param srvCd
     * @param openInfScol
     * @param openInfMcol
     * @param openInfTcol
     * @param openInfCcol
     * @param openInfAcol
     * @return
     */
    private Object setGetObj(String srvCd, OpenInfScol openInfScol, OpenInfMcol openInfMcol, OpenInfTcol openInfTcol,
                             OpenInfCcol openInfCcol, OpenInfAcol openInfAcol) {
        if (srvCd.equals("T")) {
            return openInfTcol;
        } else if (srvCd.equals("S")) {
            return openInfScol;
        } else if (srvCd.equals("C")) {
            return openInfCcol;
        } else if (srvCd.equals("M")) {
            return openInfMcol;
        } else if (srvCd.equals("L")) {
            // return openInfLcol;
            return null;
        } else if (srvCd.equals("F")) {
            // return openInfFcol;
            return null;
        } else if (srvCd.equals("A")) {
            return openInfAcol;
        } else if (srvCd.equals("V")) {
            return null;
        } else {
            return openInfTcol;
        }
    }

    /**
     * 기본 필터를 조회한다.
     *
     * @param filtCode
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/service/selectFiltDefault.do")
    @ResponseBody
    public Map<String, Object> selectFiltDefault(String filtCode) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("filtDefault", commCodeListService.getEntityCodeList("FILT_CODE", filtCode));// 기본값
        return map;
    }

    /**
     * 통계항목을 조회한다.
     *
     * @param dtId
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/service/selectItemCd.do")
    @ResponseBody
    public Map<String, Object> selectItemCd(String dtId) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("itmeCd", commCodeListService.getEntityCodeList("ITEM_CD", dtId));// 기본값
        return map;
    }

    /**
     * Sheet에 헤더항목을 조회한다.
     *
     * @param openInfSrv
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/service/openInfColViewPopUpHead.do")
    @ResponseBody
    public Map<String, Object> openInfColViewPopUpHead(OpenInfSrv openInfSrv, ModelMap model) {
        if (openInfSrv == null) {
            openInfSrv = new OpenInfSrv();
        }

        String srvCd = StringUtils.defaultString(openInfSrv.getSrvCd());
        OpenInfSrvService service = setSerivce(srvCd);

        Map<String, Object> map = service.selectOpenInfColViewPopInfo(openInfSrv);
        @SuppressWarnings("unchecked")
        List<LinkedHashMap<String, String>> unitCd = (List<LinkedHashMap<String, String>>) map.get("UNIT_CD");
        // 단위 조회
        if (unitCd != null && unitCd.size() == 1) {
            map.put("unitCd", commCodeListService.getCodeList(unitCd.get(0).get("UNIT_CD")));
            map.put("unitCdVal", unitCd.get(0).get("UNIT_SUB_CD"));
        } else {
            map.put("unitCd", "");
            map.put("unitCdVal", "");
        }
        return map;
    }

    /**
     * 미리보기 항목을 조회한다.
     *
     * @param openInfSrv
     * @param model
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/admin/service/openInfColViewPopUp.do")
    public ModelAndView openInfColViewPopUp(OpenInfSrv openInfSrv, ModelMap model) {
        if (openInfSrv == null) {
            openInfSrv = new OpenInfSrv();
        }

        String srvCd = StringUtils.defaultString(openInfSrv.getSrvCd());
        OpenInfSrvService service = setSerivce(srvCd);
        ModelAndView modelAndView = new ModelAndView();
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            if (srvCd.equals("T")) {
                // 각종 조회 조건 가져오기
                openInfSrv.setFirstYn("Y");
                map = service.selectOpenInfColViewPopInfo(openInfSrv);
                modelAndView.addObject("qqDate", map.get("qqDate"));
                modelAndView.addObject("mmDate", map.get("mmDate"));
                modelAndView.addObject("yyDate", map.get("yyDate"));
                modelAndView.addObject("info", map.get("info"));
                modelAndView.addObject("search", map.get("search"));
                List<LinkedHashMap<String, String>> unitCd = (List<LinkedHashMap<String, String>>) map.get("UNIT_CD");
                // 단위 조회
                if (unitCd != null && unitCd.size() == 1) {
                    modelAndView.addObject("unitCd", commCodeListService.getCodeList(unitCd.get(0).get("UNIT_CD")));
                    modelAndView.addObject("unitCdVal", unitCd.get(0).get("UNIT_SUB_CD"));
                } else {
                    modelAndView.addObject("unitCd", "");
                    modelAndView.addObject("unitCdVal", "");
                }
                int itemCnt = Integer.parseInt(((OpenInfSrv) map.get("search")).getItemCnt()); // 트리조회
                modelAndView.addObject("treeDate",
                        UtilTree.getTree((List<LinkedHashMap<String, String>>) map.get("treeDate"), itemCnt));
            } else if (srvCd.equals("S")) {
                map = service.selectOpenInfColViewPopInfo(openInfSrv);
                modelAndView.addObject("head", map.get("head"));
                modelAndView.addObject("cond", map.get("cond"));
                modelAndView.addObject("condDtl", map.get("condDtl"));
                // modelAndView.addObject("fsObj",map.get("fsObj"));
            } else if (srvCd.equals("C")) {
                map = service.selectOpenInfColViewPopInfo(openInfSrv);
                modelAndView.addObject("head", map.get("head"));
                modelAndView.addObject("cond", map.get("cond"));
                modelAndView.addObject("condDtl", map.get("condDtl"));
                modelAndView.addObject("series", map.get("totSeries"));
                // modelAndView.addObject("fsObj",map.get("fsObj"));
            } else if (srvCd.equals("M")) {
                map = service.selectOpenInfColViewPopInfo(openInfSrv);
                modelAndView.addObject("latitude", map.get("latitude"));
                modelAndView.addObject("longitude", map.get("longitude"));
                modelAndView.addObject("mapData", map.get("mapData"));
                modelAndView.addObject("infoWin", map.get("infoWin"));
                modelAndView.addObject("markerVal", map.get("markerVal"));
                modelAndView.addObject("mapLevel", map.get("mapLevel"));
                modelAndView.addObject("colList", map.get("colList"));
            } else if (srvCd.equals("L")) {
                map = service.selectOpenInfColViewPopInfo(openInfSrv);
                modelAndView.addObject("resultList", map.get("resultList"));
            } else if (srvCd.equals("F")) {
                map = service.selectOpenInfColList(openInfSrv);
                modelAndView.addObject("resultList", map.get("resultList"));
                modelAndView.addObject("convertFilePath", EgovProperties.getProperty("Globals.ConvertDir"));
            } else if (srvCd.equals("A")) {
                // 미리 보기 구현예정
                map = service.selectOpenInfColViewPopInfo(openInfSrv);
                modelAndView.addObject("printVal", map.get("printVal"));
                modelAndView.addObject("sampleUri", map.get("sampleUri"));
                modelAndView.addObject("resultMsg", map.get("resultMsg"));
                modelAndView.addObject("reqVar", map.get("reqVar"));
                modelAndView.addObject("apiList", map.get("apiList"));
                modelAndView.addObject("apiListCnt", map.get("apiListCnt"));
            } else if (srvCd.equals("V")) {
                map = service.selectOpenInfColViewPopInfo(openInfSrv);
                modelAndView.addObject("resultList", map.get("resultList"));
            } else {
            }
            modelAndView.setViewName("/admin/service/popup/view" + srvCd.toLowerCase() + "col");
            modelAndView.addObject("viewLang", StringUtils.defaultString(openInfSrv.getViewLang()));
            modelAndView.addObject("ds_exp", service.selectOpenInfDsExp(openInfSrv));
            modelAndView.addObject("openInfSrv", openInfSrv);

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return modelAndView;
    }
    
    /**
     * 미리보기 항목을 조회한다.
     *
     * @param openInfSrv
     * @param model
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/admin/service/openInfColTestViewPopUp.do")
    public ModelAndView openInfColTestViewPopUp(OpenInfSrv openInfSrv, ModelMap model) {
        if (openInfSrv == null) {
            openInfSrv = new OpenInfSrv();
        }

        String srvCd = StringUtils.defaultString(openInfSrv.getSrvCd());
        OpenInfSrvService service = setSerivce(srvCd);
        ModelAndView modelAndView = new ModelAndView();
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            if (srvCd.equals("T")) {
                // 각종 조회 조건 가져오기
                openInfSrv.setFirstYn("Y");
                map = service.selectOpenInfColViewPopInfo(openInfSrv);
                modelAndView.addObject("qqDate", map.get("qqDate"));
                modelAndView.addObject("mmDate", map.get("mmDate"));
                modelAndView.addObject("yyDate", map.get("yyDate"));
                modelAndView.addObject("info", map.get("info"));
                modelAndView.addObject("search", map.get("search"));
                List<LinkedHashMap<String, String>> unitCd = (List<LinkedHashMap<String, String>>) map.get("UNIT_CD");
                // 단위 조회
                if (unitCd != null && unitCd.size() == 1) {
                    modelAndView.addObject("unitCd", commCodeListService.getCodeList(unitCd.get(0).get("UNIT_CD")));
                    modelAndView.addObject("unitCdVal", unitCd.get(0).get("UNIT_SUB_CD"));
                } else {
                    modelAndView.addObject("unitCd", "");
                    modelAndView.addObject("unitCdVal", "");
                }
                int itemCnt = Integer.parseInt(((OpenInfSrv) map.get("search")).getItemCnt()); // 트리조회
                modelAndView.addObject("treeDate",
                        UtilTree.getTree((List<LinkedHashMap<String, String>>) map.get("treeDate"), itemCnt));
            } else if (srvCd.equals("S")) {
                map = service.selectOpenInfColViewPopInfo(openInfSrv);
                modelAndView.addObject("head", map.get("head"));
                modelAndView.addObject("cond", map.get("cond"));
                modelAndView.addObject("condDtl", map.get("condDtl"));
                // modelAndView.addObject("fsObj",map.get("fsObj"));
            } else if (srvCd.equals("C")) {
                map = service.selectOpenInfColViewPopInfo(openInfSrv);
                modelAndView.addObject("head", map.get("head"));
                modelAndView.addObject("cond", map.get("cond"));
                modelAndView.addObject("condDtl", map.get("condDtl"));
                modelAndView.addObject("series", map.get("totSeries"));
                // modelAndView.addObject("fsObj",map.get("fsObj"));
            } else if (srvCd.equals("M")) {
                map = service.selectOpenInfColViewPopInfo(openInfSrv);
                modelAndView.addObject("latitude", map.get("latitude"));
                modelAndView.addObject("longitude", map.get("longitude"));
                modelAndView.addObject("mapData", map.get("mapData"));
                modelAndView.addObject("infoWin", map.get("infoWin"));
                modelAndView.addObject("markerVal", map.get("markerVal"));
                modelAndView.addObject("mapLevel", map.get("mapLevel"));
                modelAndView.addObject("colList", map.get("colList"));
            } else if (srvCd.equals("L")) {
                map = service.selectOpenInfColViewPopInfo(openInfSrv);
                modelAndView.addObject("resultList", map.get("resultList"));
            } else if (srvCd.equals("F")) {
                map = service.selectOpenInfColList(openInfSrv);
                modelAndView.addObject("resultList", map.get("resultList"));
                modelAndView.addObject("convertFilePath", EgovProperties.getProperty("Globals.ConvertDir"));
            } else if (srvCd.equals("A")) {
                // 미리 보기 구현예정
                map = service.selectOpenInfColViewPopInfo(openInfSrv);
                modelAndView.addObject("printVal", map.get("printVal"));
                modelAndView.addObject("sampleUri", map.get("sampleUri"));
                modelAndView.addObject("resultMsg", map.get("resultMsg"));
                modelAndView.addObject("reqVar", map.get("reqVar"));
                modelAndView.addObject("apiList", map.get("apiList"));
                modelAndView.addObject("apiListCnt", map.get("apiListCnt"));
            } else if (srvCd.equals("V")) {
                map = service.selectOpenInfColViewPopInfo(openInfSrv);
                modelAndView.addObject("resultList", map.get("resultList"));
            } else {
            }
            modelAndView.setViewName("/admin/service/popup/view" + srvCd.toLowerCase() + "coltest");
            modelAndView.addObject("viewLang", StringUtils.defaultString(openInfSrv.getViewLang()));
            modelAndView.addObject("ds_exp", service.selectOpenInfDsExp(openInfSrv));
            modelAndView.addObject("openInfSrv", openInfSrv);

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return modelAndView;
    }    
    
    
    
    

    /**
     * chart항목을 조회한다.
     *
     * @param openInfSrv
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/service/searchChartData.do")
    @ResponseBody
    public Map<String, Object> searchChartData(OpenInfSrv openInfSrv) {
        if (openInfSrv == null) {
            openInfSrv = new OpenInfSrv();
        }

        String srvCd = StringUtils.defaultString(openInfSrv.getSrvCd());
        OpenInfSrvService service = setSerivce(srvCd);
        Map<String, Object> map = new HashMap<String, Object>();
        map = service.selectOpenInfColViewPopInfo(openInfSrv);
        map.put("srvChart", map.get("srvChart"));
        map.put("initX", service.selectInitX(openInfSrv));
        map.put("seriesResult", map.get("seriesResult"));
        map.put("seriesResultCnt", map.get("seriesResultCnt"));
        map.put("seriesResult2", map.get("seriesResult2"));
        map.put("seriesResultCnt2", map.get("seriesResultCnt2"));
        map.put("chartDataX", map.get("chartDataX"));
        map.put("chartDataY", map.get("chartDataY"));
        map.put("chartDataRY", map.get("chartDataRY"));
        return map;
    }

    /**
     * 통계항목 chart항목을 조회한다.
     *
     * @param openInfSrv
     * @param model
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/admin/service/openInfColTsChartViewPopUp.do")
    public ModelAndView openInfColViewPopUp2(OpenInfSrv openInfSrv, ModelMap model) {
        if (openInfSrv == null) {
            openInfSrv = new OpenInfSrv();
        }

        String srvCd = StringUtils.defaultString(openInfSrv.getSrvCd());
        OpenInfSrvService service = setSerivce(srvCd);
        ModelAndView modelAndView = new ModelAndView();
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            openInfSrv.setFirstYn("Y");
            map = service.selectOpenInfColViewPopInfo(openInfSrv);
            modelAndView.addObject("qqDate", map.get("qqDate"));
            modelAndView.addObject("mmDate", map.get("mmDate"));
            modelAndView.addObject("yyDate", map.get("yyDate"));
            modelAndView.addObject("info", map.get("info"));
            modelAndView.addObject("search", map.get("search"));
            int itemCnt = Integer.parseInt(((OpenInfSrv) map.get("search")).getItemCnt()); // 트리조회
            modelAndView.addObject("treeDate",
                    UtilTree.getTree((List<LinkedHashMap<String, String>>) map.get("treeDate"), itemCnt));
            modelAndView.setViewName("/admin/service/popup/view" + srvCd.toLowerCase() + "ccol");
            modelAndView.addObject("viewLang", StringUtils.defaultString(openInfSrv.getViewLang()));
            modelAndView.addObject("ds_exp", service.selectOpenInfDsExp(openInfSrv));
            modelAndView.addObject("openInfSrv", openInfSrv);

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return modelAndView;
    }

    /**
     * 각서비스 객체를 리턴한다.
     *
     * @param srvCd
     * @return
     */
    private OpenInfSrvService setSerivce(String srvCd) {
        srvCd = srvCd == null ? "" : srvCd;

        logger.debug("서비스타입은 :" + srvCd);
        if (srvCd.equals("T")) {
            return this.openInfTcolService;
        } else if (srvCd.equals("S")) {
            return this.openInfScolService;
        } else if (srvCd.equals("C")) {
            return this.openInfCcolService;
        } else if (srvCd.equals("M")) {
            return this.openInfMcolService;
        } else if (srvCd.equals("L")) {
            return this.openInfLcolService;
        } else if (srvCd.equals("F")) {
            return this.openInfFcolService;
        } else if (srvCd.equals("A")) {
            return this.openInfAcolService;
        } else if (srvCd.equals("V")) {
            return this.openInfVcolService;
        } else {
            logger.debug("서비스 타입 없음");
            return this.openInfScolService;
        }
    }

    /**
     * 원하는 데이터를 조회한다.
     *
     * @param openInfSrv
     * @param mode
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/service/openInfColViewListAll.do")
    @ResponseBody
    public IBSheetListVO<LinkedHashMap<String, ?>> openInfColViewListAll(OpenInfSrv openInfSrv, ModelMap mode) {
        if (openInfSrv == null) {
            openInfSrv = new OpenInfSrv();
        }

        String srvCd = StringUtils.defaultString(openInfSrv.getSrvCd());
        OpenInfSrvService service = setSerivce(srvCd);
        // 페이징 처리와 IbSheet 헤더 정렬은 반드시 *IbPaging 메소드명을 사용해야함(AOP 사용)
        Map<String, Object> map = service.selectMetaAllIbPaging(openInfSrv);
        @SuppressWarnings("unchecked")
        List<LinkedHashMap<String, ?>> result = (List<LinkedHashMap<String, ?>>) map.get("resultList");
        int cnt = Integer.parseInt((String) map.get("resultCnt"));
        return new IBSheetListVO<LinkedHashMap<String, ?>>(result, cnt);
    }

    /**
     * 파일을 다운로드 한다
     *
     * @param openInfSrv
     * @param mode
     * @param response
     * @param requset
     * @throws Exception
     */
    /*
     * @RequestMapping("/admin/service/download.do") public void
     * jsonDownload(OpenInfSrv openInfSrv, ModelMap mode,HttpServletResponse
     * response,HttpServletRequest requset){ if (openInfSrv == null) { openInfSrv =
     * new OpenInfSrv(); }
     *
     * String srvCd = StringUtils.defaultString(openInfSrv.getSrvCd());
     * OpenInfSrvService service = setSerivce(srvCd); Map<String, Object> map =
     * service.selectMetaAllIbPaging(openInfSrv);
     *
     * @SuppressWarnings("unchecked") List<LinkedHashMap<String,?>> result =
     * (List<LinkedHashMap<String,?>>) map.get("resultList");
     *
     * @SuppressWarnings("unchecked") LinkedHashMap<String,?> head =
     * (LinkedHashMap<String,?>) map.get("head"); String infNm =
     * (String)map.get("infNm"); String fileDownType =
     * StringUtils.defaultString(openInfSrv.getFileDownType());
     * if(fileDownType.equals("E")){ exceldownheler.download(result,head,infNm,
     * response,requset); }else if(fileDownType.equals("C")){
     * csvdownheler.download(result,head,infNm, response,requset); }else{
     * jsondownheler.download(result,head,infNm, response,requset); } }
     */

    /**
     * Open API 리스트 출력
     *
     * @param openInfSrv
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/service/openInfAcolList.do")
    @ResponseBody
    public IBSheetListVO<Object> openInfAcolList(OpenInfSrv openInfSrv, ModelMap model) {
        if (openInfSrv == null) {
            openInfSrv = new OpenInfSrv();
        }

        OpenInfSrvService service = setSerivce(StringUtils.defaultString(openInfSrv.getSrvCd()));
        Map<String, Object> map = service.selectOpenInfColList(openInfSrv);
        @SuppressWarnings("unchecked")
        List<Object> result = (List<Object>) map.get("resultList");
        return new IBSheetListVO<Object>(result, result.size());
    }

    /**
     * Open API URI 리스트 출력
     *
     * @param openInfSrv
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/service/openInfAcolUriList.do")
    @ResponseBody
    public IBSheetListVO<Object> selectOpenInfAcolUriList(OpenInfSrv openInfSrv, ModelMap model) {
        if (openInfSrv == null) {
            openInfSrv = new OpenInfSrv();
        }

        OpenInfSrvService service = setSerivce(StringUtils.defaultString(openInfSrv.getSrvCd()));
        Map<String, Object> map = service.selectOpenInfAcolUriList(openInfSrv);
        @SuppressWarnings("unchecked")
        List<Object> result = (List<Object>) map.get("resultList");
        return new IBSheetListVO<Object>(result, result.size());
    }

    /**
     * Open API 리스트 저장
     *
     * @param data
     * @param openInfSrv
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/service/openInfAcolSave.do")
    @ResponseBody
    public IBSResultVO<CommVo> openInfAcolSave(@RequestBody openInfAcols data, OpenInfSrv openInfSrv, ModelMap model) {
        if (openInfSrv == null) {
            openInfSrv = new OpenInfSrv();
        }
        try {
            String apiExp = URLDecoder.decode(StringUtils.defaultString(openInfSrv.getApiExp()), "UTF-8")
                    .replaceAll("\\|", "%20").replaceAll("\\+", "%20");
            openInfSrv.setApiExp(apiExp);

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        if (openInfSrv.getSrvCd() == null) {
            openInfSrv.setSrvCd("");
        }
        return openInfColSave(data.get("data"), openInfSrv, model);
    }

    /**
     * Open API URI 저장(서비스)
     *
     * @param data
     * @param openInfSrv
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/service/openInfAcolApiUriSave.do")
    @ResponseBody
    public IBSResultVO<CommVo> openInfAcolApiUriSave(@RequestBody openInfAcols data, OpenInfSrv openInfSrv,
                                                     ModelMap model) {
        return openInfApiSave(data.get("data"), openInfSrv, model);
    }

    /**
     * Open API URI 저장
     *
     * @param list
     * @param openInfSrv
     * @param model
     * @return
     * @throws Exception
     */
    public IBSResultVO<CommVo> openInfApiSave(ArrayList<?> list, OpenInfSrv openInfSrv, ModelMap model) {
        if (openInfSrv == null) {
            openInfSrv = new OpenInfSrv();
        }

        OpenInfSrvService service = setSerivce(StringUtils.defaultString(openInfSrv.getSrvCd()));
        int result = service.openInfApiSaveCUD(openInfSrv, list);
        return new IBSResultVO<CommVo>(result, messagehelper.getSavaMessage(result));
    }

    /**
     * Open API 리스스 중복체크
     *
     * @param openInfSrv
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/basicinf/openInfAcolApiDup.do")
    @ResponseBody
    public IBSResultVO<OpenInfAcol> openInfAcolApiDup(OpenInfSrv openInfSrv, ModelMap model) {
        if (openInfSrv == null) {
            openInfSrv = new OpenInfSrv();
        }

        int result = 0;
        String srvCd = StringUtils.defaultString(openInfSrv.getSrvCd());
        OpenInfSrvService service = setSerivce(srvCd);
        result = service.openInfAcolApiDup(openInfSrv);
        return new IBSResultVO<OpenInfAcol>(result, messagehelper.getSavaMessage(result));
    }

    /**
     * Open API 미리보기 URL 테스트시 컬럼 조건이 기준정보에 있으면 selectBox 설정
     *
     * @param openInfSrv
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/service/openInfAcolApiFiltVal.do")
    @ResponseBody
    public Map<String, Object> selectPreviewApiTestSelectVal(OpenInfSrv openInfSrv, ModelMap model) {
        if (openInfSrv == null) {
            openInfSrv = new OpenInfSrv();
        }

        OpenInfSrvService service = setSerivce(StringUtils.defaultString(openInfSrv.getSrvCd()));
        Map<String, Object> map = service.selectPreviewApiTestSelectVal(openInfSrv);
        @SuppressWarnings("unchecked")
        List<Object> filtCd = (List<Object>) map.get("filtCd");
        map.put("filtCd", filtCd);
        return map;
    }

    /**
     * Link 리스트 정보
     *
     * @param openInfSrv
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/service/openInfLcolList.do")
    @ResponseBody
    public IBSheetListVO<Object> openInfLcolList(OpenInfSrv openInfSrv, ModelMap model) {
        if (openInfSrv == null) {
            openInfSrv = new OpenInfSrv();
        }

        OpenInfSrvService service = setSerivce(StringUtils.defaultString(openInfSrv.getSrvCd()));
        Map<String, Object> map = service.selectOpenInfColList(openInfSrv);
        @SuppressWarnings("unchecked")
        List<Object> result = (List<Object>) map.get("resultList");
        return new IBSheetListVO<Object>(result, result.size());
    }

    /**
     * Link CUD
     *
     * @param openInfSrv
     * @param model
     * @return
     * @throws Exception
     */
    /*
     * 서비스 이미지 추가로 하위 /admin/service/openInfLcolFileSave.do로 변경
     *
     * @RequestMapping("/admin/service/openInfLcolSave.do")
     *
     * @ResponseBody public IBSResultVO<CommVo> openInfLcolSave(@RequestBody
     * openInfLcols data, OpenInfSrv openInfSrv, ModelMap model){ return
     * openInfColSave(data.get("data"),openInfSrv,model); }
     */
    @RequestMapping("/admin/service/openInfLcolFileSave.do")
    @ResponseBody
    public void openInfLcolFileSave(FileVo fileVo, HttpServletRequest request, OpenInfSrv openInfSrv, ModelMap model,
                                    HttpServletResponse res) {
        final MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
        if (openInfSrv == null) {
            openInfSrv = new OpenInfSrv();
        }

        String infId = StringUtils.defaultString(openInfSrv.getInfId());
        FileOutputStream fos = null;

        try {
            // OPEN FILE 썸네일 저장용
            MultipartFile file = multiRequest.getFile("uploadTmnlSrvfile");
            if (file.getSize() > 0) {
                String srcFileNm = file.getOriginalFilename(); // 원본 파일명
                String fileExt = FilenameUtils.getExtension(srcFileNm); // 파일확장자
                String saveFileNm = infId + "." + fileExt; // 저장파일명(파라미터 값)

                openInfSrv.setTmnlImgFile(saveFileNm);

                // 저장 디렉토리(properties + ID)
                String directoryPath = EgovProperties.getProperty("Globals.OpenlinkImg");
                directoryPath = EgovWebUtil.folderPathReplaceAll(directoryPath);
                File directory = new File(directoryPath);

                // 수정 : 권한 설정
                directory.setExecutable(true, true);
                directory.setReadable(true);
                directory.setWritable(true, true);

                if (!directory.isDirectory()) {
                    directory.mkdir();
                }

                if (saveFileNm != null && !"".equals(saveFileNm)) {
                    fos = new FileOutputStream(
                            EgovWebUtil.filePathBlackList(directoryPath + File.separator + saveFileNm));
                    InputStream stream = file.getInputStream();
                    int bytesRead = 0;
                    byte[] buffer = new byte[BUFF_SIZE];

                    while ((bytesRead = stream.read(buffer, 0, BUFF_SIZE)) != -1) {
                        fos.write(buffer, 0, bytesRead);
                    }

                }

            } // OPEN FILE 썸네일 저장용 END

            // OPEN FILE 파일 저장용
            String rtnVal = "";
            res.setContentType("text/html;charset=UTF-8");
            PrintWriter writer = res.getWriter();

            @SuppressWarnings("unchecked")
            List<OpenInfLcol> list = (List<OpenInfLcol>) UtilString.setQueryStringData(request, new OpenInfLcol(),
                    fileVo);
            rtnVal = objectMapper.writeValueAsString(openInfColSave((ArrayList<?>) list, openInfSrv, model));
            writer.println(rtnVal);
            writer.close(); // return type을 IBSResultVO 하면 IE에서 작업 완료시 다운로드 받는 문제가 생겨 변경..

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        } finally {
            try {
                if (fos != null) {
                    fos.close();
                }
            } catch (IOException e) {
                EgovWebUtil.exLogging(e);
            } catch (Exception e) {
                EgovWebUtil.exLogging(e);
            }
        }
    }

    /**
     * 파일 업로드 및 내용 저장
     *
     * @param fileVo
     * @param request
     * @param openInfSrv
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/service/openInfLcolImgSave.do")
    @ResponseBody
    public void openInfLcolImgSave(FileVo fileVo, HttpServletRequest request, OpenInfSrv openInfSrv, ModelMap model,
                                   HttpServletResponse res) {
        if (openInfSrv == null) {
            openInfSrv = new OpenInfSrv();
        }

        try {
            boolean successFileUpload = false;
            String rtnVal = "";
            res.setContentType("text/html;charset=UTF-8");
            PrintWriter writer = res.getWriter();
            FileService.setFileCuData(fileVo);// 파일재정의(트랙잰션)
            // 파일 타입 체크
            String[] type = {"jpg", "jpeg", "gif", "png"}; // 파일 허용타입
            if (FileService.fileTypeCkeck(fileVo, type)) { // 타입이 정상인지 체크
                successFileUpload = FileService.fileUpload(fileVo, openInfSrv.getMstSeq(),
                        EgovProperties.getProperty("Globals.ServiceFilePath"), WiseOpenConfig.LINK_SERVICE);
            } else {
                rtnVal = objectMapper.writeValueAsString(new IBSResultVO<CommVo>(-2, "저장할 수 없는 파일 형식 입니다.")); // 저장실패
                writer.println(rtnVal);
                writer.close();
                return;
            }
            // UtilString.setQueryStringData을 사용하여 data를 list 형태로 반환다.
            // 반드시 new 연산자를 사용하여 vo를 넘겨야한다.
            if (successFileUpload) {
                @SuppressWarnings("unchecked")
                Enumeration<?> enumeration = request.getParameterNames();
                Map<String, String> paramMap = new HashMap<String, String>();
                while (enumeration.hasMoreElements()) {
                    String name = (String) enumeration.nextElement();

                    paramMap.put(getParameterName(name).toUpperCase(), getTextParameter(request, name));
                }

                List<OpenInfLcol> list = new ArrayList<OpenInfLcol>();
                OpenInfLcol vo = new OpenInfLcol();
                // Class<OpenInfVcol> classObj = (Class<OpenInfVcol>) vo.getClass();
                // Object newObj = classObj.newInstance();
                Method[] m = vo.getClass().getMethods();
                for (int j = 0; j < m.length; j++) {
                    if (m[j].getName().substring(0, 3).equals("set")) {
                        String mNm = m[j].getName().substring(3, m[j].getName().length()).toUpperCase();
                        if (paramMap.containsKey(mNm)) {
                            String type1 = m[j].getParameterTypes()[0].getName();
                            if (type1.equals("int") || type1.equals("java.lang.Integer")) { // 타입이 숫자면 숫자타입으로
                                m[j].invoke(vo, Integer.parseInt(paramMap.get(mNm)));
                            } else {// 날짜 타입 고려하지않았음
                                // m[j].invoke(newObj, new String(arrParam[1].getBytes("8859_1"), "UTF-8"));
                                m[j].invoke(vo, paramMap.get(mNm));
                            }

                        }
                    }
                }
                list.add(vo);
                rtnVal = objectMapper
                        .writeValueAsString(openInfFileColSave((ArrayList<?>) list, openInfSrv, model, fileVo));
            } else {
                rtnVal = objectMapper.writeValueAsString(new IBSResultVO<CommVo>(-2, messagehelper.getSavaMessage(-2))); // 저장실패
            }
            writer.println(rtnVal);
            writer.close(); // return type을 IBSResultVO 하면 IE에서 작업 완료시 다운로드 받는 문제가 생겨 변경..

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
    }

    /**
     * 썸네일 이미지 조회
     *
     * @param openInfLcol
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/service/openInfLcolImgDetailView.do")
    @ResponseBody
    public Map<String, Object> openInfLcolImgDetailView(OpenInfLcol openInfLcol, ModelMap model) {
        OpenInfSrvService service = setSerivce(openInfLcol.getSrvCd());
        Map<String, Object> map = service.selectOpenInfColInfo(openInfLcol, openInfLcol.getLinkSeq());
        map.put("resultImg", map.get("resultImg"));
        return map;
    }

    /**
     * 썸네일 이미지 삭제
     *
     * @param openInfLcol
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/service/openInfLcolDeleteImg.do")
    @ResponseBody
    public Map<String, Object> openInfLcolDeleteImg(OpenInfLcol openInfLcol, ModelMap model) {
        int result = 0;
        // 섬네일 이미지 비우기
        openInfLcol.setTmnlImgFile("");

        ArrayList<OpenInfLcol> list = new ArrayList<OpenInfLcol>();
        list.add(openInfLcol);

        OpenInfSrvService service = setSerivce(openInfLcol.getSrvCd());
        result = service.updateTmnlImgFile(list);

        Map<String, Object> map = new HashMap<String, Object>();

        if (result > 0) {
            map.put("msg", "삭제되었습니다.");
        } else {
            map.put("msg", "에러발생...err");
        }

        return map;
    }

    /**
     * 파일 리스트 조회
     *
     * @param openInfSrv
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/service/openInfFcolList.do")
    @ResponseBody
    public IBSheetListVO<Object> openInfFcolList(OpenInfSrv openInfSrv, ModelMap model) {
        if (openInfSrv == null) {
            openInfSrv = new OpenInfSrv();
        }

        OpenInfSrvService service = setSerivce(StringUtils.defaultString(openInfSrv.getSrvCd()));
        Map<String, Object> map = service.selectOpenInfColList(openInfSrv);
        @SuppressWarnings("unchecked")
        List<Object> result = (List<Object>) map.get("resultList");
        return new IBSheetListVO<Object>(result, result.size());
    }

    /**
     * 파일 조회
     *
     * @param openInfSrv
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/service/openInfFcolList2.do")
    @ResponseBody
    public List<OpenInfFcol> openInfFcolList2(OpenInfSrv openInfSrv, ModelMap model) {
        if (openInfSrv == null) {
            openInfSrv = new OpenInfSrv();
        }

        OpenInfSrvService service = setSerivce(StringUtils.defaultString(openInfSrv.getSrvCd()));
        Map<String, Object> map = service.selectOpenInfColList(openInfSrv);
        @SuppressWarnings("unchecked")
        List<OpenInfFcol> result = (List<OpenInfFcol>) map.get("resultList");
        return result;
    }

    /**
     * 파일 업로드 및 내용 저장
     *
     * @param fileVo
     * @param request
     * @param openInfSrv
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/service/openInfFcolFileSave.do")
    @ResponseBody
    public void openInfFcolFileSave(FileVo fileVo, HttpServletRequest request, OpenInfSrv openInfSrv, ModelMap model,
                                    HttpServletResponse res) {
        final MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
        if (openInfSrv == null) {
            openInfSrv = new OpenInfSrv();
        }

        String infId = StringUtils.defaultString(openInfSrv.getInfId());
        FileOutputStream fos = null;

        try {
            // OPEN FILE 썸네일 저장용
            MultipartFile file = multiRequest.getFile("uploadTmnlfile");
            if (file.getSize() > 0) {
                String srcFileNm = file.getOriginalFilename(); // 원본 파일명
                String fileExt = FilenameUtils.getExtension(srcFileNm); // 파일확장자
                String saveFileNm = infId + "." + fileExt; // 저장파일명(파라미터 값)

                openInfSrv.setTmnlImgFile(saveFileNm);

                // 저장 디렉토리(properties + ID)
                String directoryPath = EgovProperties.getProperty("Globals.OpenfileImg");
                directoryPath = EgovWebUtil.folderPathReplaceAll(directoryPath);
                File directory = new File(directoryPath);

                // 수정 : 권한 설정
                directory.setExecutable(true, true);
                directory.setReadable(true);
                directory.setWritable(true, true);

                if (!directory.isDirectory()) {
                    directory.mkdir();
                }

                if (saveFileNm != null && !"".equals(saveFileNm)) {
                    fos = new FileOutputStream(
                            EgovWebUtil.filePathBlackList(directoryPath + File.separator + saveFileNm));
                    InputStream stream = file.getInputStream();
                    int bytesRead = 0;
                    byte[] buffer = new byte[BUFF_SIZE];

                    while ((bytesRead = stream.read(buffer, 0, BUFF_SIZE)) != -1) {
                        fos.write(buffer, 0, bytesRead);
                    }

                }

            } // OPEN FILE 썸네일 저장용 END

            // OPEN FILE 파일 저장용
            boolean successFileUpload = false;
            String rtnVal = "";
            res.setContentType("text/html;charset=UTF-8");
            PrintWriter writer = res.getWriter();
            FileService.setFileCuData(fileVo);// 파일재정의(트랙잰션)
            // 파일 타입 체크
            String[] type = {"hwp", "ppt", "pptx", "xls", "xlsx", "doc", "txt", "docx", "zip", "pdf"}; // 파일 허용타입
            if (FileService.fileTypeCkeck(fileVo, type)) { // 타입이 정상인지 체크
                logger.debug("=============before");
                successFileUpload = FileService.fileUpload(fileVo, openInfSrv.getMstSeq(),
                        EgovProperties.getProperty("Globals.ServiceFilePath"), WiseOpenConfig.FILE_SERVICE);
                logger.debug("=============after");
            } else {
                rtnVal = objectMapper.writeValueAsString(new IBSResultVO<CommVo>(-2, "저장할 수 없는 파일 형식 입니다.")); // 저장실패
                writer.println(rtnVal);
                writer.close();
                return;
            }
            // UtilString.setQueryStringData을 사용하여 data를 list 형태로 반환다.
            // 반드시 new 연산자를 사용하여 vo를 넘겨야한다.
            if (successFileUpload) {
                @SuppressWarnings("unchecked")
                List<OpenInfFcol> list = (List<OpenInfFcol>) UtilString.setQueryStringData(request, new OpenInfFcol(),
                        fileVo);
                if (list.size() == 0) {
                    rtnVal = objectMapper.writeValueAsString(new IBSResultVO<CommVo>(-2, "데이터 처리도중 에러가 발생하였습니다.")); // 저장실패
                } else {
                    rtnVal = objectMapper.writeValueAsString(openInfColSave((ArrayList<?>) list, openInfSrv, model));
                }
            } else {
                rtnVal = objectMapper.writeValueAsString(new IBSResultVO<CommVo>(-2, messagehelper.getSavaMessage(-2))); // 저장실패
            }
            writer.println(rtnVal);
            writer.close(); // return type을 IBSResultVO 하면 IE에서 작업 완료시 다운로드 받는 문제가 생겨 변경..

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
            handleErrorMessage(res, "데이터 처리도중 에러가 발생하였습니다.");
        } catch (IOException e) {
            EgovWebUtil.exLogging(e);
            handleErrorMessage(res, "데이터 처리도중 에러가 발생하였습니다.");
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
            handleErrorMessage(res, "데이터 처리도중 에러가 발생하였습니다.");
        } finally {
            try {
                if (fos != null) {
                    fos.close();
                }
            } catch (IOException e) {
                EgovWebUtil.exLogging(e);
            } catch (Exception e) {
                EgovWebUtil.exLogging(e);
            }
        }
    }

    /**
     * 파일 리스트 삭제
     *
     * @param data
     * @param openInfSrv
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/service/openInfFcolDel.do")
    @ResponseBody
    public IBSResultVO<CommVo> openInfFcolSave(@RequestBody openInfFcols data, OpenInfSrv openInfSrv, ModelMap model) {
        return openInfColSave(data.get("data"), openInfSrv, model);
    }

    /**
     * 파일 다운로드(미리보기시)
     *
     * @param downCd
     * @param fileSeq
     * @param seq
     * @return
     */
    @RequestMapping("/admin/service/fileDownload.do")
    public ModelAndView download(@RequestParam("downCd") String downCd, @RequestParam("fileSeq") int fileSeq,
                                 @RequestParam("seq") String seq, @RequestParam("etc") String etc) {
        ModelAndView mav = new ModelAndView();
        try {
            HttpServletRequest req = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes())
                    .getRequest();
            String downloadFolder = UtilString.getDownloadFolder(downCd, seq); // 다운로드 폴더

            List<HashMap<String, Object>> map = FileService.getFileNameByFileSeq(downCd, fileSeq, etc);
            String saveFileNm = (String) map.get(0).get("saveFileNm"); // 실제 디스크에 저장된 파일명
            String fileName = (String) map.get(0).get("viewFileNm"); // 사용자에게 보여줄 파일명(출력파일명)
            String fileExtg = (String) map.get(0).get("fileExt"); // 사용자에게 보여줄 확장자명(출력확장자)
            saveFileNm = new String(saveFileNm.getBytes("utf-8"), "iso-8859-1").replace("+", "%20").replaceAll("\\+",
                    "%20");
            String folder = EgovWebUtil.folderPathReplaceAll(downloadFolder + File.separator); // 전체다운경로

            mav.addObject("fileName", fileName + "." + fileExtg);
            mav.addObject("file", new File(folder + EgovWebUtil.filePathReplaceAll(saveFileNm)));
            mav.addObject("bEncode", true);
            mav.setViewName("downloadView"); // viewResolver...

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return mav;
    }

    /**
     * 신규등록시 INF의 Seq를 가져온다.
     *
     * @param openInfSrv
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/service/getMstSeq.do")
    @ResponseBody
    public int getMstSeq(OpenInfSrv openInfSrv, ModelMap model) {
        if (openInfSrv == null) {
            openInfSrv = new OpenInfSrv();
        }

        OpenInfSrvService service = setSerivce(StringUtils.defaultString(openInfSrv.getSrvCd()));
        return service.selectGetMstSeq(openInfSrv);
    }

    /**
     * 신규등록시 INF의 Seq를 가져온다.
     *
     * @param openInfSrv
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/service/getInfSeq.do")
    @ResponseBody
    public int getInfSeq(OpenInfSrv openInfSrv, ModelMap model) {
        if (openInfSrv == null) {
            openInfSrv = new OpenInfSrv();
        }

        OpenInfSrvService service = setSerivce(StringUtils.defaultString(openInfSrv.getSrvCd()));
        return service.selectGetInfSeq(openInfSrv);
    }

    /**
     * 파일 리스트 조회
     *
     * @param openInfSrv
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/service/openInfVcolList.do")
    @ResponseBody
    public IBSheetListVO<Object> openInfVcolList(OpenInfSrv openInfSrv, ModelMap model) {
        if (openInfSrv == null) {
            openInfSrv = new OpenInfSrv();
        }

        OpenInfSrvService service = setSerivce(StringUtils.defaultString(openInfSrv.getSrvCd()));
        Map<String, Object> map = service.selectOpenInfColList(openInfSrv);
        @SuppressWarnings("unchecked")
        List<Object> result = (List<Object>) map.get("resultList");
        return new IBSheetListVO<Object>(result, result.size());
    }

    /**
     * 파일 리스트 조회
     *
     * @param openInfVcol
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/service/openInfVcolDtlList.do")
    @ResponseBody
    public IBSheetListVO<Object> openInfVcolDtlList(OpenInfVcol openInfVcol, ModelMap model) {
        if (openInfVcol == null) {
            openInfVcol = new OpenInfVcol();
        }

        OpenInfSrvService service = setSerivce(openInfVcol.getSrvCd());
        Map<String, Object> map = service.selectOpenInfColDtlList(openInfVcol);
        @SuppressWarnings("unchecked")
        List<Object> result = (List<Object>) map.get("resultList");
        return new IBSheetListVO<Object>(result, result.size());
    }

    /**
     * MultiMedia CUD
     *
     * @param data
     * @param openInfSrv
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/service/openInfVcolSave.do")
    @ResponseBody
    public IBSResultVO<CommVo> openInfVcolSave(@RequestBody openInfVcols data, OpenInfSrv openInfSrv, ModelMap model) {
        return openInfColSave(data.get("data"), openInfSrv, model);
    }

    /**
     * MultiMedia 파일 업로드 및 내용 저장
     *
     * @param fileVo
     * @param request
     * @param openInfVcol
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/service/openInfVcolFileSave.do")
    @ResponseBody
    public void openInfVcolFileSave(FileVo fileVo, HttpServletRequest request, OpenInfVcol openInfVcol, ModelMap model,
                                    HttpServletResponse res) {
        if (openInfVcol == null) {
            openInfVcol = new OpenInfVcol();
        }

        try {
            boolean successFileUpload = false;
            String rtnVal = "";
            res.setContentType("text/html;charset=UTF-8");
            PrintWriter writer = res.getWriter();
            logger.debug("---------------------------------------before setData");
            FileService.setFileCuData(fileVo);// 파일재정의(트랙잰션)
            // 파일 타입 체크
            String[] typeIMG = {"gif", "png", "bmp", "jpg"}; // 이미지파일 허용타입
            String[] typeMTN = {"mkv", "avi", "mp4", "wmv", "mpeg", "mov", "flv", "mpg", "swf"}; // 동영상파일 허용타입
//		String[] typeSND = {"acc", "wma", "wav", "ogg", "mp3", "flac"}; //음원파일 허용타입
            String[] type = {};

            logger.debug("---------------------------------------MediaTypeCd:"
                    + StringUtils.defaultString(openInfVcol.getMediaTypeCd()));
            // 미디어 타입 NULL 아닐 경우
            if (!UtilString.isBlank(openInfVcol.getMediaTypeCd())) {
                String mediaTypeCd = StringUtils.defaultString(openInfVcol.getMediaTypeCd());
                if (mediaTypeCd.equals("MTN")) {
                    type = typeMTN;
//			} else if(mediaTypeCd.equals("SND")) {
//				type = typeSND;
                } else if (mediaTypeCd.equals("IMG")) {
                    type = typeIMG;
                }
            }

            logger.debug("---------------------------------------SaveFileNm:" + openInfVcol.getSaveFileNm());
            // 파일 업로드
            if (!UtilString.isBlank(openInfVcol.getSaveFileNm())) {
                if (FileService.fileTypeCkeck(fileVo, type)) { // 타입이 정상인지 체크
                    logger.debug("---------------------------------------fileTypeChk_Success");
                    successFileUpload = FileService.fileUpload(fileVo, openInfVcol.getMstSeq(),
                            EgovProperties.getProperty("Globals.MediaFilePath"), WiseOpenConfig.MEDIA_SERVICE);
                } else {
                    logger.debug("---------------------------------------fileTypeChk_Fail");
                    rtnVal = objectMapper.writeValueAsString(new IBSResultVO<CommVo>(-2, "저장할 수 없는 파일 형식 입니다.")); // 저장실패
                    writer.println(rtnVal);
                    writer.close();
                    return;
                }

                // UtilString.setQueryStringData을 사용하여 data를 list 형태로 반환다.
                // 반드시 new 연산자를 사용하여 vo를 넘겨야한다.
                if (successFileUpload) {
                    @SuppressWarnings("unchecked")
                    List<OpenInfVcol> list = (List<OpenInfVcol>) UtilString.setQueryStringData(request,
                            new OpenInfVcol(), fileVo);
                    rtnVal = objectMapper
                            .writeValueAsString(openInfVcolDetailSave((ArrayList<?>) list, openInfVcol, model, fileVo));
                } else {
                    rtnVal = objectMapper
                            .writeValueAsString(new IBSResultVO<CommVo>(-2, messagehelper.getSavaMessage(-2))); // 저장실패
                }
            } else { // 출력파일명만 수정
                @SuppressWarnings("unchecked")
                List<OpenInfVcol> list = (List<OpenInfVcol>) UtilString.setQueryStringData(request, new OpenInfVcol(),
                        fileVo);
                rtnVal = objectMapper
                        .writeValueAsString(openInfVcolDetailSave((ArrayList<?>) list, openInfVcol, model, fileVo));
            }

            writer.println(rtnVal);
            writer.close(); // return type을 IBSResultVO 하면 IE에서 작업 완료시 다운로드 받는 문제가 생겨 변경..
        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
    }

    /**
     * 멀티미디어 세부서비스 저장
     *
     * @param data
     * @param openInfSrv
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/service/openInfVcolDetailDel.do")
    @ResponseBody
    public IBSResultVO<CommVo> openInfVcolDetailDel(@RequestBody openInfVcols data, OpenInfSrv openInfSrv,
                                                    ModelMap model) {
        return openInfVcolDetailSave(data.get("data"), openInfSrv, model);
    }

    /**
     * 멀티미디어 세부 서비스 저장
     *
     * @param list
     * @param openInfSrv
     * @param model
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public IBSResultVO<CommVo> openInfVcolDetailSave(ArrayList<?> list, OpenInfSrv openInfSrv, ModelMap model,
                                                     FileVo fileVo) {
        if (openInfSrv == null) {
            openInfSrv = new OpenInfSrv();
        }

        String fileName = "";
        int fileSeq = 0;
        String[] fileNames = fileVo.getSaveFileNm();
        String[] arrFileSeq = fileVo.getArrFileSeq();
        if (!UtilString.isNull(fileNames)) {
            for (String name : fileNames) {
                fileName = name;
            }
        }
        if (!UtilString.isNull(arrFileSeq)) {
            for (String seq : arrFileSeq) {
                fileSeq = Integer.parseInt(seq);
            }
        }

        String srvCd = StringUtils.defaultString(openInfSrv.getSrvCd());
        OpenInfSrvService service = setSerivce(srvCd);

        for (int i = 0; list.size() > i; i++) {
            if (srvCd.equals("V")) { // 링크 서비스
                if (!UtilString.isBlank(fileName)) {
                    logger.debug("------------------------->fileSeq:" + fileSeq);
                    logger.debug("------------------------->list.fileSeq:"
                            + ((ArrayList<OpenInfVcol>) list).get(i).getFileSeq());
                    logger.debug("------------------------->list.arrFileSeq:"
                            + ((ArrayList<OpenInfVcol>) list).get(i).getArrFileSeq());
                    ((ArrayList<OpenInfVcol>) list).get(i).setSaveFileNm(fileName);
                    ((ArrayList<OpenInfVcol>) list).get(i).setTmnlImgFile("thumb_" + fileName);
                    ((ArrayList<OpenInfVcol>) list).get(i).setFileSeq(fileSeq);
                }
            }
        }

        int result = service.openInfVcolDetailSaveCUD(openInfSrv, list);
        return new IBSResultVO<CommVo>(result, messagehelper.getSavaMessage(result));
    }

    /**
     * 멀티미디어 세부 서비스 저장
     *
     * @param list
     * @param openInfSrv
     * @param model
     * @return
     * @throws Exception
     */
    public IBSResultVO<CommVo> openInfVcolDetailSave(ArrayList<?> list, OpenInfSrv openInfSrv, ModelMap model) {
        if (openInfSrv == null) {
            openInfSrv = new OpenInfSrv();
        }

        OpenInfSrvService service = setSerivce(StringUtils.defaultString(openInfSrv.getSrvCd()));
        int result = service.openInfVcolDetailSaveCUD(openInfSrv, list);
        return new IBSResultVO<CommVo>(result, messagehelper.getSavaMessage(result));
    }

    /**
     * 파일 업로드 및 내용 저장
     *
     * @param fileVo
     * @param request
     * @param openInfSrv
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/service/openInfVcolImgSave.do")
    @ResponseBody
    public void openInfVcolImgSave(FileVo fileVo, HttpServletRequest request, OpenInfSrv openInfSrv, ModelMap model,
                                   HttpServletResponse res) {
        if (openInfSrv == null) {
            openInfSrv = new OpenInfSrv();
        }

        try {
            boolean successFileUpload = false;
            String rtnVal = "";
            res.setContentType("text/html;charset=UTF-8");
            PrintWriter writer = res.getWriter();
            FileService.setFileCuData(fileVo);// 파일재정의(트랙잰션)
            // 파일 타입 체크
            String[] type = {"jpg", "jpeg", "gif", "png"}; // 파일 허용타입
            if (FileService.fileTypeCkeck(fileVo, type)) { // 타입이 정상인지 체크
                logger.debug("=============before");
                successFileUpload = FileService.fileUpload(fileVo, openInfSrv.getMstSeq(),
                        EgovProperties.getProperty("Globals.MediaFilePath"), WiseOpenConfig.MEDIA_TMNL_IMG);
                logger.debug("=============after");
            } else {
                rtnVal = objectMapper.writeValueAsString(new IBSResultVO<CommVo>(-2, "저장할 수 없는 파일 형식 입니다.")); // 저장실패
                writer.println(rtnVal);
                writer.close();
                return;
            }
            // UtilString.setQueryStringData을 사용하여 data를 list 형태로 반환다.
            // 반드시 new 연산자를 사용하여 vo를 넘겨야한다.

            if (successFileUpload) {
                @SuppressWarnings("unchecked")
                Enumeration<?> enumeration = request.getParameterNames();
                Map<String, String> paramMap = new HashMap<String, String>();
                while (enumeration.hasMoreElements()) {
                    String name = (String) enumeration.nextElement();

                    paramMap.put(getParameterName(name).toUpperCase(), getTextParameter(request, name));
                }

                List<OpenInfVcol> list = new ArrayList<OpenInfVcol>();
                OpenInfVcol vo = new OpenInfVcol();
                // Class<OpenInfVcol> classObj = (Class<OpenInfVcol>) vo.getClass();
                // Object newObj = classObj.newInstance();
                Method[] m = vo.getClass().getMethods();
                for (int j = 0; j < m.length; j++) {
                    if (m[j].getName().substring(0, 3).equals("set")) {
                        String mNm = m[j].getName().substring(3, m[j].getName().length()).toUpperCase();
                        if (paramMap.containsKey(mNm)) {
                            String type1 = m[j].getParameterTypes()[0].getName();
                            if (type1.equals("int") || type1.equals("java.lang.Integer")) { // 타입이 숫자면 숫자타입으로
                                m[j].invoke(vo, Integer.parseInt(paramMap.get(mNm)));
                            } else {// 날짜 타입 고려하지않았음
                                // m[j].invoke(newObj, new String(arrParam[1].getBytes("8859_1"), "UTF-8"));
                                m[j].invoke(vo, paramMap.get(mNm));
                            }
                        }
                    }
                }
                list.add(vo);

                rtnVal = objectMapper
                        .writeValueAsString(openInfFileColSave((ArrayList<?>) list, openInfSrv, model, fileVo));

            } else {
                rtnVal = objectMapper.writeValueAsString(new IBSResultVO<CommVo>(-2, messagehelper.getSavaMessage(-2))); // 저장실패
            }
            writer.println(rtnVal);
            writer.close(); // return type을 IBSResultVO 하면 IE에서 작업 완료시 다운로드 받는 문제가 생겨 변경..
        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
    }

    private String getParameterName(String name) {
        if (name.endsWith("[]")) {
            return name.substring(0, name.lastIndexOf("[]"));
        }

        return name;
    }

    private String getTextParameter(HttpServletRequest request, String name) {
        return request.getParameter(name);
    }

    /**
     * 썸네일 이미지 조회
     *
     * @param openInfVcol
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/service/openInfVcolImgDetailView.do")
    @ResponseBody
    public Map<String, Object> openInfVcolImgDetailView(OpenInfVcol openInfVcol, ModelMap model) {
        if (openInfVcol == null) {
            openInfVcol = new OpenInfVcol();
        }
        OpenInfSrvService service = setSerivce(openInfVcol.getSrvCd());
        Map<String, Object> map = service.selectOpenInfColInfo(openInfVcol, openInfVcol.getVistnSeq());
        map.put("resultImg", map.get("resultImg"));
        return map;
    }

    /**
     * 썸네일 이미지 삭제
     *
     * @param openInfVcol
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/service/openInfVcolDeleteImg.do")
    @ResponseBody
    public Map<String, Object> openInfVcolDeleteImg(OpenInfVcol openInfVcol, ModelMap model) {
        if (openInfVcol == null) {
            openInfVcol = new OpenInfVcol();
        }
        int result = 0;
        // 섬네일 이미지 비우기
        openInfVcol.setTmnlImgFile("");

        ArrayList<OpenInfVcol> list = new ArrayList<OpenInfVcol>();
        list.add(openInfVcol);

        OpenInfSrvService service = setSerivce(openInfVcol.getSrvCd());
        result = service.updateTmnlImgFile(list);

        Map<String, Object> map = new HashMap<String, Object>();

        if (result > 0) {
            map.put("msg", "삭제되었습니다.");
        } else {
            map.put("msg", "에러발생...err");
        }

        return map;
    }
    
    
    /**
     * 컬럼아이디 변경을 위한 팝업
     * 2023-12-12 ywjo
     *
     * @param openInfSrv
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/service/openInfColIdPopUp.do")
    public ModelAndView openInfColIdPopUp(OpenInfSrv openInfSrv, ModelMap model) {
        if (openInfSrv == null) {
            openInfSrv = new OpenInfSrv();
        }
        String srvCd = StringUtils.defaultString(openInfSrv.getSrvCd());
        OpenInfSrvService service = setSerivce(srvCd);
        ModelAndView modelAndView = new ModelAndView("/admin/service/popup/colidpopup");
        modelAndView.addObject("openInfSrv", openInfSrv);
        //modelAndView.addObject("resultList", service.selectOpenInfColPopInfo(openInfSrv).get("resultList"));
        Map<String, Object> map = service.selectOpenInfColList(openInfSrv);
        @SuppressWarnings("unchecked")
        List<Object> result = (List<Object>) map.get("resultList");
        modelAndView.addObject("resultList", result);
        return modelAndView;
    }
    
	/*
	 * @RequestMapping("/admin/service/openInfColList.do")
	 * 
	 * @ResponseBody public IBSheetListVO<Object> openInfColList(OpenInfSrv
	 * openInfSrv, ModelMap model) { if (openInfSrv == null) { openInfSrv = new
	 * OpenInfSrv(); } OpenInfSrvService service =
	 * setSerivce(StringUtils.defaultString(openInfSrv.getSrvCd())); Map<String,
	 * Object> map = service.selectOpenInfColList(openInfSrv);
	 * 
	 * @SuppressWarnings("unchecked") List<Object> result = (List<Object>)
	 * map.get("resultList"); return new IBSheetListVO<Object>(result,
	 * result.size()); }
	 */

    protected void handleErrorMessage(HttpServletResponse response, String message) {
        try {
            // setContentType("text/html; charset=UTF-8");

            response.reset();

            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);
            // response.setContentType(getContentType());
            response.setContentType("text/html; charset=UTF-8");

            PrintWriter writer = response.getWriter();

            writer.println("<script type=\"text/javascript\">");
            writer.println("(function() {");
            writer.println("    alert(\"" + message + "\");");
            writer.println("})();");
            writer.println("</script>");
        } catch (IOException ioe) {
            EgovWebUtil.exLogging(ioe);
        }
    }
}

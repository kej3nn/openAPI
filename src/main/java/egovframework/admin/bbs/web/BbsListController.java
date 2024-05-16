package egovframework.admin.bbs.web;

import java.io.PrintWriter;
import java.net.URI;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egovframework.admin.bbs.service.BbsAdmin;
import egovframework.admin.bbs.service.BbsList;
import egovframework.admin.bbs.service.BbsListService;
import egovframework.admin.opendt.web.OpenInfTcolItemController;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.common.WiseOpenConfig;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.code.service.CodeListService;
import egovframework.common.file.service.FileService;
import egovframework.common.file.service.FileVo;
import egovframework.common.grid.CommVo;
import egovframework.common.grid.IBSResultVO;
import egovframework.common.grid.IBSheetListVO;
import egovframework.common.helper.Messagehelper;
import egovframework.common.helper.TABListVo;
import egovframework.common.util.UtilJson;
import egovframework.common.util.UtilString;
import egovframework.ggportal.bbs.service.PortalBbsAdminService;
import egovframework.ggportal.bbs.service.PortalBbsFileService;

@Controller
public class BbsListController extends BaseController implements InitializingBean {

    protected static final Log logger = LogFactory.getLog(OpenInfTcolItemController.class);

    //공통코드 사용시 선언
    @Resource
    private CodeListService commCodeListService;

    @Resource(name = "FileService")
    private FileService FileService;

    /**
     * 게시판 첨부파일을 관리하는 서비스
     */
    @Resource(name = "ggportalBbsFileService")
    private PortalBbsFileService portalBbsFileService;


    @Resource(name = "BbsListService")
    private BbsListService bbsListService;

    static class bbsLists extends HashMap<String, ArrayList<BbsList>> {
    }

    //공통 메시지 사용시 선언
    @Resource
    Messagehelper messagehelper;

    @Resource
    EgovMessageSource message;

    /**
     * 게시판 설정을 관리하는 서비스
     */
    @Resource(name = "ggportalBbsAdminService")
    private PortalBbsAdminService portalBbsAdminService;

    private ObjectMapper objectMapper = new ObjectMapper();


    public void afterPropertiesSet() {

    }

    /**
     * 공통코드를 조회 한다.
     *
     * @return
     * @throws Exception
     */
    @ModelAttribute("codeMap")
    public Map<String, Object> getcodeMap() {
        Map<String, Object> codeMap = new HashMap<String, Object>();
        try {
            codeMap.put("ditcCdIbs", UtilJson.convertJsonString(commCodeListService.getCodeListIBS("C1004")));// 게시글 분류 ibSheet
            codeMap.put("faqCdIbs", UtilJson.convertJsonString(commCodeListService.getCodeListIBS("B1001")));// FAQ 분류 ibSheet
            codeMap.put("qnaCdIbs", UtilJson.convertJsonString(commCodeListService.getCodeListIBS("B1002")));// QNA 분류 ibSheet
            codeMap.put("galleryCdIbs", UtilJson.convertJsonString(commCodeListService.getCodeListIBS("B1003")));// 갤러리 분류 ibSheet
            codeMap.put("fsl1001CdIbs", UtilJson.convertJsonString(commCodeListService.getCodeListIBS("B1004")));// 재정배움터 분류 ibSheet
            codeMap.put("fsl1004CdIbs", UtilJson.convertJsonString(commCodeListService.getCodeListIBS("B1005")));// 재정보고서 분류 ibSheet
            codeMap.put("fsl1007CdIbs", UtilJson.convertJsonString(commCodeListService.getCodeListIBS("B1006")));// 재정사이트 분류 ibSheet
            codeMap.put("publicCdIbs", UtilJson.convertJsonString(commCodeListService.getCodeListIBS("B1010")));// 통계간행물 분류 ibSheet
            codeMap.put("ditcCd", commCodeListService.getCodeList("C1004")); // 게시글 분류 select box
            codeMap.put("faqCd", commCodeListService.getCodeList("B1001")); // FAQ 분류 select box
            codeMap.put("qnaCd", commCodeListService.getCodeList("B1002")); // QNA 분류 select box
            codeMap.put("galleryCd", commCodeListService.getCodeList("B1003")); // 갤러리 분류 select box
            codeMap.put("fsl1001Cd", commCodeListService.getCodeList("B1004")); // 재정배움터 분류 select box
            codeMap.put("fsl1004Cd", commCodeListService.getCodeList("B1005")); // 재정보고서 분류 select box
            codeMap.put("fsl1007Cd", commCodeListService.getCodeList("B1006")); // 재정사이트 분류 select box
            codeMap.put("telCd", commCodeListService.getEntityCodeList("LIST_CD", "C1015")); // 연락처 select box
            codeMap.put("emailCd", commCodeListService.getEntityCodeList("LIST_CD", "C1009")); // 이메일 select box
            //통계간행물 추가 2017.01.05
            codeMap.put("publicCd", commCodeListService.getCodeList("B1010")); // 통계간행물 분류 select box

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return codeMap;
    }

    /**
     * 게시판 조회 화면, 게시판관리 정보 가져오기
     *
     * @param bbsAdmin
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/bbsListPage.do")
    public ModelAndView bbsListPage(BbsList bbsList, ModelMap model, String bbsCd) {
        ModelAndView modelAndView = new ModelAndView();

        modelAndView.addObject("bbsCdz", "N");
        // 나중에 삭제(손정식)ㅌ
        if (bbsList.getBbsCd().equals("GALLERY2")) {
            bbsList.setBbsCd("GALLERY");
            modelAndView.addObject("bbsCdz", "Y");
        }
        if (bbsCd.equals("GALLERY2")) {
            bbsCd = "GALLERY";
        }

        Map<String, Object> map = new HashMap<String, Object>();
        map = bbsListService.selectBbsAdminInfo(bbsList);
        //List<CommCode> ditcList, ditcList1, ditcList2, ditcList3, ditcList4 = null;
        modelAndView.addObject("delYn", bbsListService.selectDelYn(bbsList));
        modelAndView.addObject("bbsTypeCd", bbsListService.selectBbsTypeCd(bbsList));

        modelAndView.addObject("bbsCd", bbsCd);

        BbsAdmin listMap = bbsListService.selectBbsDitcCd(bbsList);
        modelAndView.addObject("listMap", listMap);

        try {
            if (!"".equals(listMap.getListCd())) {
                //ditcList = commCodeListService.getCodeList(listCd.getListCd());
                //modelAndView.addObject("listCd", listMap.getListCd());
                modelAndView.addObject("ditcList", commCodeListService.getCodeList(listMap.getListCd()));
                modelAndView.addObject("ditcListIBS", UtilJson.convertJsonString(commCodeListService.getCodeListIBS(listMap.getListCd())));
            }
            if (!"".equals(listMap.getList1Cd())) {
                //modelAndView.addObject("list1Cd", listMap.getList1Cd());
                modelAndView.addObject("ditcList1", commCodeListService.getCodeList(listMap.getList1Cd()));
                modelAndView.addObject("ditcList1IBS", UtilJson.convertJsonString(commCodeListService.getCodeListIBS(listMap.getList1Cd())));
            }
            if (!"".equals(listMap.getList2Cd())) {
                //modelAndView.addObject("list2Cd", listMap.getList2Cd());
                modelAndView.addObject("ditcList2", commCodeListService.getCodeList(listMap.getList2Cd()));
                modelAndView.addObject("ditcList2IBS", UtilJson.convertJsonString(commCodeListService.getCodeListIBS(listMap.getList2Cd())));
            }
            if (!"".equals(listMap.getList3Cd())) {
                //modelAndView.addObject("list3Cd", listMap.getList3Cd());
                modelAndView.addObject("ditcList3", commCodeListService.getCodeList(listMap.getList3Cd()));
                modelAndView.addObject("ditcList3IBS", UtilJson.convertJsonString(commCodeListService.getCodeListIBS(listMap.getList3Cd())));
            }
            if (!"".equals(listMap.getList4Cd())) {
                //modelAndView.addObject("list4Cd", listMap.getList4Cd());
                modelAndView.addObject("ditcList4", commCodeListService.getCodeList(listMap.getList4Cd()));
                modelAndView.addObject("ditcList4IBS", UtilJson.convertJsonString(commCodeListService.getCodeListIBS(listMap.getList4Cd())));
            }

            //modelAndView.addObject("ditcList",ditcList);

            modelAndView.addObject("result", map.get("result"));
            modelAndView.setViewName("/admin/bbs/bbsList");

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return modelAndView;
    }


    /**
     * 게시판 목록 조회
     *
     * @param bbsList
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/selectBbsList.do")
    @ResponseBody
    public IBSheetListVO<BbsList> selectBbsList(@ModelAttribute("searchVO") BbsList bbsList, ModelMap model) {
        //페이징 처리시 반드시 *IbPaging 메소드명을 사용해야함
        Map<String, Object> map = bbsListService.selectBbsListIbPaging(bbsList);
        @SuppressWarnings("unchecked")
        List<BbsList> result = (List<BbsList>) map.get("resultList");
        int cnt = Integer.parseInt((String) map.get("resultCnt"));
        return new IBSheetListVO<BbsList>(result, cnt);
    }

    /**
     * 게시판 단건 조회
     *
     * @param bbsList
     * @param model
     * @param bbsCd
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/selectBbsDtlList.do")
    @ResponseBody
    public TABListVo<BbsList> openInfSheetInfo(@RequestBody BbsList bbsList, ModelMap model, String ansTag) {
        bbsList.setAnsTag(ansTag);
        return new TABListVo<BbsList>(bbsListService.selectBbsDtlList(bbsList));
    }

    /**
     * 게시판 링크(URL) 목록 조회
     *
     * @param bbsList
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/selectBbsLinkList.do")
    @ResponseBody
    public IBSheetListVO<BbsList> selectBbsLinkList(@ModelAttribute("searchVO") BbsList bbsList, ModelMap model) {
        //페이징 처리시 반드시 *IbPaging 메소드명을 사용해야함
        Map<String, Object> map = bbsListService.selectBbsLinkListIbPaging(bbsList);
        @SuppressWarnings("unchecked")
        List<BbsList> result = (List<BbsList>) map.get("resultList");
        int cnt = Integer.parseInt((String) map.get("resultCnt"));
        return new IBSheetListVO<BbsList>(result, cnt);
    }

    /**
     * 게시판 공공데이터 목록 조회
     *
     * @param bbsList
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/selectBbsInfList.do")
    @ResponseBody
    public IBSheetListVO<BbsList> selectBbsInfList(@ModelAttribute("searchVO") BbsList bbsList, ModelMap model) {
        //페이징 처리시 반드시 *IbPaging 메소드명을 사용해야함
        Map<String, Object> map = bbsListService.selectBbsInfListIbPaging(bbsList);
        @SuppressWarnings("unchecked")
        List<BbsList> result = (List<BbsList>) map.get("resultList");
        int cnt = Integer.parseInt((String) map.get("resultCnt"));
        return new IBSheetListVO<BbsList>(result, cnt);
    }

    /**
     * 공공데이터 검색 팝업 화면
     *
     * @return
     */
    @RequestMapping("/admin/bbs/popup/bbsinf_pop.do")
    public String openinfPopPage() {
        return "/admin/bbs/popup/bbsinf_pop";
    }

    /**
     * 공공데이터 검색 팝업 화면 목록 조회
     *
     * @param bbsList
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/popup/selectBbsInfList.do")
    @ResponseBody
    public IBSheetListVO<BbsList> selectBbsinfPop(@ModelAttribute("searchVO") BbsList bbsList, ModelMap model) {
        //페이징 처리시 반드시 *IbPaging 메소드명을 사용해야함
        Map<String, Object> map = bbsListService.selectBbsinfPopIbPaging(bbsList);
        @SuppressWarnings("unchecked")
        List<BbsList> result = (List<BbsList>) map.get("resultList");
        int cnt = Integer.parseInt((String) map.get("resultCnt"));
        return new IBSheetListVO<BbsList>(result, cnt);
    }

    /**
     * 게시판 내용 저장
     *
     * @param saveVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/saveBbsList.do")
    @ResponseBody
    public IBSResultVO<BbsList> saveBbsList(@ModelAttribute BbsList saveVO, ModelMap model) {
        int result = 0;
        result = bbsListService.saveBbsDtlListCUD(saveVO, WiseOpenConfig.STATUS_I);
        return new IBSResultVO<BbsList>(result, messagehelper.getSavaMessage(result), saveVO.getSeq());
    }

    /**
     * 게시판 내용 수정
     *
     * @param saveVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/updateBbsList.do")
    @ResponseBody
    public IBSResultVO<BbsList> updateBbsList(@ModelAttribute BbsList saveVO, ModelMap model) {
        int result = 0;
        result = bbsListService.saveBbsDtlListCUD(saveVO, WiseOpenConfig.STATUS_U);
        return new IBSResultVO<BbsList>(result, messagehelper.getSavaMessage(result), saveVO.getSeq());
    }

    /**
     * 게시판 완전 삭제
     *
     * @param saveVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/deleteBbsList.do")
    @ResponseBody
    public IBSResultVO<BbsList> deleteBbsList(@ModelAttribute BbsList saveVO, ModelMap model) {
        int result = 0;
        result = bbsListService.saveBbsDtlListCUD(saveVO, WiseOpenConfig.STATUS_D);
        return new IBSResultVO<BbsList>(result, messagehelper.getSavaMessage(result), saveVO.getSeq());
    }

    /**
     * 답변/승인 저장
     *
     * @param saveVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/updateAnsState.do")
    @ResponseBody
    public IBSResultVO<BbsList> updateAnsState(@ModelAttribute BbsList saveVO, ModelMap model) {
        int result = 0;
        result = bbsListService.updateAnsStateCUD(saveVO);
        return new IBSResultVO<BbsList>(result, messagehelper.getSavaMessage(result));
    }

    /**
     * 링크 정보 저장
     *
     * @param data
     * @param locale
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/saveBbsLinkList.do")
    @ResponseBody
    public IBSResultVO<BbsList> saveBbsLinkList(@RequestBody bbsLists data, Locale locale) {
        ArrayList<BbsList> list = data.get("data");
        int result = bbsListService.saveBbsLinkListCUD(list);
        String resmsg;
        if (result > 0) {
            result = 0;
            resmsg = message.getMessage("MSG.SAVE");
        } else {
            result = -1;
            resmsg = message.getMessage("ERR.SAVE");
        }

        return new IBSResultVO<BbsList>(result, resmsg, "Url");
    }

    /**
     * 링크 정보 완전 삭제
     *
     * @param data
     * @param locale
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/deleteBbsLinkList.do")
    @ResponseBody
    public IBSResultVO<BbsList> deleteBbsLinkList(@RequestBody bbsLists data, Locale locale) {
        ArrayList<BbsList> list = data.get("data");
        int result = bbsListService.deleteBbsLinkListCUD(list);
        String resmsg;
        if (result > 0) {
            result = 0;
            resmsg = message.getMessage("MSG.SAVE");
        } else {
            result = -1;
            resmsg = message.getMessage("ERR.SAVE");
        }

        return new IBSResultVO<BbsList>(result, resmsg, "Url");
    }

    /**
     * 공공데이터 정보 저장
     *
     * @param data
     * @param locale
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/saveBbsInfList.do")
    @ResponseBody
    public IBSResultVO<BbsList> saveBbsInfList(@RequestBody bbsLists data, Locale locale) {
        ArrayList<BbsList> list = data.get("data");
        int result = bbsListService.saveBbsInfListCUD(list);
        String resmsg;
        if (result > 0) {
            result = 0;
            resmsg = message.getMessage("MSG.SAVE");
        } else {
            result = -1;
            resmsg = message.getMessage("ERR.SAVE");
        }
        return new IBSResultVO<BbsList>(result, resmsg, "Inf");
    }

    /**
     * 공공데이터 정보 완전 삭제
     *
     * @param data
     * @param locale
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/deleteBbsInfList.do")
    @ResponseBody
    public IBSResultVO<BbsList> deleteBbsInfList(@RequestBody bbsLists data, Locale locale) {
        ArrayList<BbsList> list = data.get("data");
        int result = bbsListService.deleteBbsInfListCUD(list);
        String resmsg;
        if (result > 0) {
            result = 0;
            resmsg = message.getMessage("MSG.SAVE");
        } else {
            result = -1;
            resmsg = message.getMessage("ERR.SAVE");
        }
        return new IBSResultVO<BbsList>(result, resmsg, "Inf");
    }

    /**
     * 게시판 첨부파일 목록 조회
     *
     * @param bbsList
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/selectBbsFileList.do")
    @ResponseBody
    public IBSheetListVO<BbsList> selectBbsFileList(@ModelAttribute("searchVO") BbsList bbsList, ModelMap model) {
        //페이징 처리시 반드시 *IbPaging 메소드명을 사용해야함
        Map<String, Object> map = bbsListService.selectBbsFileListIbPaging(bbsList);
        @SuppressWarnings("unchecked")
        List<BbsList> result = (List<BbsList>) map.get("resultList");
        int cnt = Integer.parseInt((String) map.get("resultCnt"));
        return new IBSheetListVO<BbsList>(result, cnt);
    }

    /**
     * 첨부파일 조회
     *
     * @param bbsList
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/selectBbsFileList2.do")
    @ResponseBody
    public List<BbsList> selectBbsFileList2(BbsList bbsList, ModelMap model) {
        //페이징 처리시 반드시 *IbPaging 메소드명을 사용해야함
        Map<String, Object> map = bbsListService.selectBbsFileListIbPaging(bbsList);
        @SuppressWarnings("unchecked")
        List<BbsList> result = (List<BbsList>) map.get("resultList");
        return result;
    }

    @RequestMapping("/admin/bbs/afterSaveFileList.do")
    @ResponseBody
    public Map<String, Object> afterSaveFileList(BbsList bbsList, ModelMap model) {
        Map<String, Object> map = bbsListService.selectBbsFileListIbPaging(bbsList);
        map.put("result", map.get("result"));
        return map;
    }

    @RequestMapping("/admin/bbs/bbsImgDetailView.do")
    @ResponseBody
    public Map<String, Object> bbsImgDetailView(BbsList bbsList, ModelMap model) {
        Map<String, Object> map = bbsListService.bbsImgDetailView(bbsList);
        map.put("resultImg", map.get("resultImg"));
        map.put("resultTopYn", map.get("resultTopYn"));
        return map;
    }

    /**
     * 첨부파일 파일 저장
     *
     * @param fileVo
     * @param request
     * @param bbsList
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/saveBbsFile.do")
    @ResponseBody
    public void saveBbsFile(FileVo fileVo, HttpServletRequest request, BbsList bbsList, ModelMap model, HttpServletResponse res) {
        boolean successFileUpload = false;
        String rtnVal = "";
		/* 파일 타입 체크시... 아래코드 주석 풀고 사용..
		String[] type = {"hwp,ppt"}; //파일 허용타입
		if(FileService.fileTypeCkeck(fileVo, type)){ //타입이 정상인지 체크
			successFileUpload = FileService.fileUpload(fileVo, openInfSrv.getMstSeq(), EgovProperties.getProperty("Globals.ServiceFilePath"), WiseOpenConfig.FILE_SERVICE);
		}else{
			//리턴 에러메시지 뿌려야함
		}
		 */
        int mstSeq = bbsList.getMstSeq();
        int tmpSeq = bbsList.getTmpSeq();
        if (mstSeq == 0) {        // 등록한 직후 파일업로드할 때 SEQ가 0으로 들어가는 거 방지
            bbsList.setMstSeq(tmpSeq);
        }
        String pathPlus = bbsListService.getBbsCd(bbsList.getMstSeq());
        try {
            FileService.setFileCuData(fileVo);//파일재정의(트랙잰션)
            if (pathPlus.equals("FSL1003") || pathPlus.equals("FSL1008") || pathPlus.equals("FSL1012")) {    //국문,영문 보도자료일때는 Directory를 Seq별로 관리하지 않고 bbsCd에다가 몰아넣음
                successFileUpload = FileService.fileUpload(fileVo, bbsList.getMstSeq(), EgovProperties.getProperty("Globals.BbsFilePath") + pathPlus, WiseOpenConfig.FILE_BBS2);
            } else {
                successFileUpload = FileService.fileUpload(fileVo, bbsList.getMstSeq(), EgovProperties.getProperty("Globals.BbsFilePath") + pathPlus, WiseOpenConfig.FILE_BBS);
            }

            //UtilString.setQueryStringData을 사용하여 data를 list 형태로 반환다.
            //반드시 new 연산자를 사용하여 vo를 넘겨야한다..
            res.setContentType("text/html;charset=UTF-8");
            PrintWriter writer = res.getWriter();
            if (successFileUpload) {
                @SuppressWarnings("unchecked")
                List<CommVo> list = (List<CommVo>) UtilString.setQueryStringData(request, new BbsList(), fileVo);
                rtnVal = objectMapper.writeValueAsString(saveBbsFileListCUD((ArrayList<?>) list, bbsList, model, fileVo));
            } else {
                rtnVal = objectMapper.writeValueAsString(new IBSResultVO<CommVo>(-2, messagehelper.getSavaMessage(-2)));    //저장실패
            }
            writer.println(rtnVal);
            writer.close();        //return type을 IBSResultVO 하면 IE에서 작업 완료시 다운로드 받는 문제가 생겨 변경..
        } catch (DataAccessException e) {
            EgovWebUtil.exTransactionLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
    }

    /**
     * 첨부파일 데이터 저장
     *
     * @param list
     * @param bbsList
     * @param model
     * @return
     * @throws Exception
     */
    private IBSResultVO<CommVo> saveBbsFileListCUD(ArrayList<?> list, BbsList bbsList, ModelMap model, FileVo fileVo) {

        int result = bbsListService.saveBbsFileListCUD(bbsList, list, fileVo);
        int fileSeq = 0;
        if (((BbsList) list.get(0)).getStatus().equals("I")) {
            fileSeq = ((BbsList) list.get(0)).getFileSeq();
        } else {
            fileSeq = ((BbsList) list.get(0)).getArrFileSeq();
        }
        return new IBSResultVO<CommVo>(result, messagehelper.getSavaMessage(result), "File", fileSeq);
    }


    @RequestMapping("/admin/bbs/deleteBbsFileList.do")
    @ResponseBody
    public IBSResultVO<BbsList> deleteBbsFileList(@RequestBody bbsLists data, Locale locale) {
        ArrayList<BbsList> list = data.get("data");
        int result = bbsListService.deleteBbsFileListCUD(list);
        String resmsg;
        if (result > 0) {
            result = 0;
            resmsg = message.getMessage("MSG.SAVE");
        } else {
            result = -1;
            resmsg = message.getMessage("ERR.SAVE");
        }
        return new IBSResultVO<BbsList>(result, resmsg, "File");
    }

    /**
     * 첨부 이미지 저장(대표이미지 지정)
     *
     * @param saveVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/updateTopYn.do")
    @ResponseBody
    public IBSResultVO<BbsList> updateTopYn(@ModelAttribute BbsList saveVO, ModelMap model) {
        int result = 0;
        result = bbsListService.updateTopYn(saveVO, WiseOpenConfig.STATUS_I);
        String resmsg;
        if (result > 0) {
            result = 0;
            resmsg = message.getMessage("MSG.SAVE");
        } else {
            result = -1;
            resmsg = message.getMessage("ERR.SAVE");
        }
        return new IBSResultVO<BbsList>(result, resmsg, "Img");
    }

    /**
     * 첨부 이미지 삭제(입력모드에서)
     *
     * @param saveVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/deleteImg.do")
    @ResponseBody
    public IBSResultVO<BbsList> deleteImg(@ModelAttribute BbsList saveVO, ModelMap model) {
        int result = 0;
        result = bbsListService.deleteImg(saveVO, WiseOpenConfig.STATUS_D);
        String resmsg;
        if (result > 0) {
            result = 0;
            resmsg = message.getMessage("MSG.SAVE");
        } else {
            result = -1;
            resmsg = message.getMessage("ERR.SAVE");
        }
        return new IBSResultVO<BbsList>(result, resmsg, "Img");
    }


    /**
     * 첨부이미지 수정
     *
     * @param saveVO
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/updateDeleteImg.do")
    @ResponseBody
    public IBSResultVO<BbsList> updateDeleteImg(@ModelAttribute BbsList saveVO) {
        int result = bbsListService.updateDeleteImgCUD(saveVO);
        String resmsg;
        if (result > 0) {
            result = 0;
            resmsg = message.getMessage("MSG.SAVE");
        } else {
            result = -1;
            resmsg = message.getMessage("ERR.SAVE");
        }
        return new IBSResultVO<BbsList>(result, resmsg, "Img");
    }

    /**
     * 첨부이미지 완전 삭제
     *
     * @param saveVO
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/deleteImgDtl.do")
    @ResponseBody
    public IBSResultVO<BbsList> deleteImgDtl(@ModelAttribute BbsList saveVO) {
        int result = bbsListService.deleteImgDtlCUD(saveVO);
        String resmsg;
        if (result > 0) {
            result = 0;
            resmsg = message.getMessage("MSG.SAVE");
        } else {
            result = -1;
            resmsg = message.getMessage("ERR.SAVE");
        }
        return new IBSResultVO<BbsList>(result, resmsg, "Img");
    }

    /**
     * 통계표 연결 추가 팝업
     */
    @RequestMapping("/admin/bbs/popup/bbstbl_pop.do")
    public String bbsTblPopPage() {
        return "/admin/bbs/popup/bbstbl_pop";
    }

    /**
     * 통계표 연결 메인 리스트 조회
     */
    @RequestMapping("/admin/bbs/popup/selectBbsTblList.do")
    @ResponseBody
    public IBSheetListVO<BbsList> selectBbsTblList(@ModelAttribute("searchVO") BbsList bbsList, ModelMap model) {
        //페이징 처리시 반드시 *IbPaging 메소드명을 사용해야함
        Map<String, Object> map = bbsListService.selectBbsTblIbPaging(bbsList);
        @SuppressWarnings("unchecked")
        List<BbsList> result = (List<BbsList>) map.get("resultList");
        int cnt = (Integer) map.get("resultCnt");
        return new IBSheetListVO<BbsList>(result, cnt);
    }

    /**
     * 통계표 연결 추가 팝업 리스트 조회
     */
    @RequestMapping("/admin/bbs/popup/selectSttsTblPopList.do")
    @ResponseBody
    public IBSheetListVO<BbsList> selectSttsTblPopList(@ModelAttribute("searchVO") BbsList bbsList, ModelMap model) {
        //페이징 처리시 반드시 *IbPaging 메소드명을 사용해야함
        Map<String, Object> map = bbsListService.selectSttsTblPopIbPaging(bbsList);
        @SuppressWarnings("unchecked")
        List<BbsList> result = (List<BbsList>) map.get("resultList");
        int cnt = (Integer) map.get("resultCnt");
        return new IBSheetListVO<BbsList>(result, cnt);
    }

    /**
     * 통계표 연결 등록/수정
     */
    @RequestMapping("/admin/bbs/saveBbsTbl.do")
    @ResponseBody
    public IBSResultVO<BbsList> saveBbsTbl(@RequestBody bbsLists data, Locale locale) {
        ArrayList<BbsList> list = data.get("data");
        int result = bbsListService.bbsTblCUD(list, "S");
        String resmsg;
        if (result > 0) {
            result = 0;
            resmsg = message.getMessage("MSG.SAVE");
        } else {
            result = -1;
            resmsg = message.getMessage("ERR.SAVE");
        }

        return new IBSResultVO<BbsList>(result, resmsg, "tbl");
    }

    @RequestMapping("/admin/bbs/deleteBbsTbl.do")
    @ResponseBody
    public IBSResultVO<BbsList> deleteBbsTbl(@RequestBody bbsLists data, Locale locale) {
        ArrayList<BbsList> list = data.get("data");
        int result = bbsListService.bbsTblCUD(list, "D");
        String resmsg;
        if (result > 0) {
            result = 0;
            resmsg = message.getMessage("MSG.DEL");
        } else {
            result = -1;
            resmsg = "삭제에 실패하였습니다.";
        }

        return new IBSResultVO<BbsList>(result, resmsg, "tbl");
    }

    /**
     * 활용 갤러리 미리보기
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/admin/bbs/selectUtilGalleryPage.do")
    public String selectUtilGalleryPage(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        params.put("bbsCd", "GALLERY");

        selectBbsAdmin(params, model);
        return "/admin/bbs/popup/galleryPreviewPop";
    }

    /////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////// private method /////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////
    private void selectBbsAdmin(Params params, Model model) {
        debug("Request parameters: " + params);
        // 게시판 설정을 조회한다.
        Record result = portalBbsAdminService.selectBbsAdmin(params);
        debug("Processing results: " + result);
        // 모델에 객체를 추가한다.
        addObject(model, result);
    }

    /**
     * 게시판 내용을 조회한다.
     *
     * @param request HTTP 요청
     * @param model   모델
     * @return 뷰이름
     */
    @RequestMapping("/admin/bbs/gallery/selectGalleryPop.do")
    public String selectBulletin(HttpServletRequest request, Model model) {

        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        try {
            // 반환 URL
            String refererUri = new URI(request.getHeader("referer")).getPath();
            if (refererUri != null && refererUri.lastIndexOf("updateBulletinPage") > 0) {
                // update 수정인 경우 게시물을 조회하는데 조회수 증가하지 않기위해 상태값 추가
                params.set("updYN", "Y");
            }

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }


        // 갤러리 내용 조회.
        Object result = bbsListService.selectGalleryPop(params);

        debug("Processing results: " + result);


        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 게시판 첨부파일을 조회한다.
     *
     * @param request HTTP 요청
     * @param model   모델
     * @return 뷰이름
     */
    @RequestMapping("/admin/bbs/gallery/selectAttachFile.do")
    public String selectAttachFile(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);


        debug("Request parameters: " + params);

        // 게시판 첨부파일을 조회한다.
        Object result = portalBbsFileService.selectBbsFile(params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "imageView";
    }

}

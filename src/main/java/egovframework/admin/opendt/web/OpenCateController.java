package egovframework.admin.opendt.web;

/**
 * 분류정보 관리로 이동하는 클래스
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.07.16
 */

import java.io.File;
import java.io.PrintWriter;
import java.util.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import egovframework.admin.bbs.service.BbsList;
import egovframework.admin.opendt.service.OpenCate;
import egovframework.admin.opendt.service.OpenCateService;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.common.WiseOpenConfig;
import egovframework.common.code.service.CodeListService;
import egovframework.common.file.service.FileService;
import egovframework.common.file.service.FileVo;
import egovframework.common.grid.CommVo;
import egovframework.common.grid.IBSResultVO;
import egovframework.common.grid.IBSheetListVO;
import egovframework.common.helper.Messagehelper;
import egovframework.common.util.UtilJson;
import egovframework.common.util.UtilString;


@Controller
public class OpenCateController implements InitializingBean {

    protected static final Log logger = LogFactory.getLog(OpenCateController.class);

    //공통코드 사용시 선언
    @Resource
    private CodeListService commCodeListService;

    @Resource(name = "FileService")
    private FileService FileService;

    private ObjectMapper objectMapper = new ObjectMapper();

    @Resource(name = "OpenCateService")
    private OpenCateService openCateService;

    static class openCate extends HashMap<String, ArrayList<OpenCate>> {
    }

    //공통 메시지 사용시 선언
    @Resource
    Messagehelper messagehelper;

    @Resource
    EgovMessageSource message;


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
            codeMap.put("niaId", UtilJson.convertJsonString(commCodeListService.getCodeListIBS("D1025")));//분류정보 ibSheet
            codeMap.put("cateTop", openCateService.selectOpenCateTop());//분류정보 ibSheet

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return codeMap;
    }

    /**
     * 분류정보 관리 조회화면으로 이동한다..
     *
     * @param model
     * @return String
     * @throws Exception
     */
    @RequestMapping("/admin/opendt/openCatePage.do")
    public String openCatePage(ModelMap model) {
        //페이지 title을 가져오려면 반드시 *Page로 끝나야한다.
        //Interceptor(PageNavigationInterceptor)에서 조회함
        return "/admin/opendt/opencate";
    }


    /**
     * 분류정보를 전체 조회한다.
     *
     * @param openCate
     * @param model
     * @return IBSheetListVO<OpenCate>
     * @throws Exception
     */
    @RequestMapping("/admin/opendt/openCateListAllMainTree.do")
    @ResponseBody
    public IBSheetListVO<OpenCate> openCateListAllMainTreeIbPaging(OpenCate openCate, ModelMap model) {
        Map<String, Object> map = new HashMap<String, Object>();
        if (openCate != null) {
            //페이징 처리시 반드시 *IbPaging 메소드명을 사용해야함
            map = openCateService.selectOpenCateListAllMainTreeIbPaging(openCate);
        }
        @SuppressWarnings("unchecked")
        List<OpenCate> result = (List<OpenCate>) map.get("resultList");
        int cnt = Integer.parseInt((String) map.get("resultCnt"));
        return new IBSheetListVO<OpenCate>(result, cnt);
    }

    /**
     * 상세분류의 하위 트리를 전체 조회한다.
     *
     * @param openCate
     * @param model
     * @return IBSheetListVO<OpenCate>
     * @throws Exception
     */
    @RequestMapping("/admin/opendt/openCateListSubTree.do")
    @ResponseBody
    public IBSheetListVO<OpenCate> openCateListSubTreeIbPaging(OpenCate openCate, ModelMap model) {
        Map<String, Object> map = new HashMap<String, Object>();
        if (openCate != null) {
            //페이징 처리시 반드시 *IbPaging 메소드명을 사용해야함
            map = openCateService.selectOpenCateListSubTreeIbPaging(openCate);
        }
        @SuppressWarnings("unchecked")
        List<OpenCate> result = (List<OpenCate>) map.get("resultList");
        int cnt = Integer.parseInt((String) map.get("resultCnt"));
        return new IBSheetListVO<OpenCate>(result, cnt);
    }

    /**
     * 분류정보를 등록한다.
     *
     * @param openCate
     * @param model
     * @return IBSResultVO<OpenCate>
     * @throws Exception
     */
    @RequestMapping("/admin/opendt/openCateReg.do")
    @ResponseBody
    public IBSResultVO<OpenCate> openCateReg(OpenCate openCate, ModelMap model) {
        long result = 0;

        if (openCate != null && openCate.getCateCib() != null) {
            //등록, 변경, 삭제 처리시 등록자, 수정자 Id를 세션에서 가져올 경우 *CUD 메소드명을 사용해야함
            result = openCateService.saveOpenCateCUD(openCate, WiseOpenConfig.STATUS_I);
        }

        if (result < 0) {
            throw new ArithmeticException("Integer overflow");
        }
        return new IBSResultVO<OpenCate>((int) result, messagehelper.getSavaMessage((int) result));
    }


    /**
     * 분류정보를 단건 조회한다.
     * @param openCate
     * @param model
     * @return TABListVo<OpenCate>
     * @throws Exception
     */
    //@RequestMapping("/admin/opendt/OpenCateOne.do")
    //@ResponseBody
    //public TABListVo<OpenCate> OpenCateOne(@RequestBody OpenCate openCate, ModelMap model){
    //	return new TABListVo<OpenCate>(openCateService.selectOpenCateOne(openCate));
    //}

    /**
     * 분류정보를 단건 조회한다.
     *
     * @param openCate
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/opendt/OpenCateOne.do")
    @ResponseBody
    public Map<String, Object> OpenCateOne(OpenCate openCate, ModelMap model) {

        Map<String, Object> map = new HashMap<String, Object>();
        if (openCate != null) {
            map.put("DATA", openCateService.selectOpenCateOne(openCate));
        }
        return map;
    }


    /**
     * 분류정보 순서를 저장한다.
     *
     * @param data
     * @param locale
     * @return IBSResultVO<OpenCate>
     * @throws Exception
     */
    @RequestMapping("/admin/opendt/openCateOrderBySave.do")
    @ResponseBody
    public IBSResultVO<OpenCate> openCateOrderBySave(@RequestBody openCate data, Locale locale) {
        ArrayList<OpenCate> list = new ArrayList<OpenCate>();
        if (data != null) {
            list = data.get("data");
        }
        int result = 0;
        if (list != null) {
            result = openCateService.openCateOrderBySave(list);
        }
        return new IBSResultVO<OpenCate>(result, messagehelper.getSavaMessage(result));
    }

    /**
     * 분류정보의 코드항목을 중복체크한다.
     *
     * @param openCate
     * @param model
     * @return IBSResultVO<OpenCate>
     * @throws Exception
     */
    @RequestMapping("/admin/opendt/openCateCheckDup.do")
    @ResponseBody
    public IBSResultVO<OpenCate> openCateCheckDup(OpenCate openCate, ModelMap model) {
        int result = 0;
        if (openCate != null) {
            result = openCateService.openCateCheckDup(openCate);
        }
        return new IBSResultVO<OpenCate>(result, messagehelper.getSavaMessage(result));
    }


    /**
     * 분류정보를 삭제한다.
     *
     * @param openCate
     * @param model
     * @return IBSResultVO<OpenCate>
     * @throws Exception
     */
    @RequestMapping("/admin/opendt/openCateDel.do")
    @ResponseBody
    public IBSResultVO<OpenCate> openCateDel(OpenCate openCate, ModelMap model) {
        long result = 0;
        //등록, 변경, 삭제 처리시 등록자, 수정자 Id를 세션에서 가져올 경우 *CUD 메소드명을 사용해야함
        if (openCate != null) {
            result = openCateService.saveOpenCateCUD(openCate, WiseOpenConfig.STATUS_D);
        }
        if (result < 0) {
            throw new ArithmeticException("Integer overflow");
        }
        return new IBSResultVO<OpenCate>((int) result, messagehelper.getSavaMessage((int) result));
    }


    /**
     * 분류관리를 변경한다.
     *
     * @param openCate
     * @param model
     * @return IBSResultVO<OpenCate>
     * @throws Exception
     */
    @RequestMapping("/admin/opendt/openCateUpd.do")
    @ResponseBody
    public IBSResultVO<OpenCate> openCateUpd(OpenCate openCate, ModelMap model) throws Exception {
        long result = 0;
        //등록, 변경, 삭제 처리시 등록자, 수정자 Id를 세션에서 가져올 경우 *CUD 메소드명을 사용해야함
        if (openCate != null) {
            result = openCateService.saveOpenCateCUD(openCate, WiseOpenConfig.STATUS_U);
        }
        if (result < 0) {
            throw new ArithmeticException("Integer overflow");
        }
        return new IBSResultVO<OpenCate>((int) result, messagehelper.getSavaMessage((int) result));
    }

    /**
     * 상위분류 선택 팝업화면으로 이동한다.
     *
     * @param model
     * @return String
     * @throws Exception
     */
    @RequestMapping("/admin/opendt/openCateParListPopUp.do")
    public String openCateParIdPopUp(ModelMap model) {
        return "/admin/opendt/popup/opencateparlistpopup";
    }

    /**
     * 상위분류 목록을 조회한다.
     *
     * @param openCate
     * @param model
     * @return IBSheetListVO<OpenCate>
     * @throws Exception
     */
    @RequestMapping("/admin/opendt/openCateParListTree.do")
    @ResponseBody
    public IBSheetListVO<OpenCate> openCateParListTreeIbPaging(OpenCate openCate, ModelMap model) {
        Map<String, Object> map = new HashMap<String, Object>();
        if (openCate != null) {
            //페이징 처리시 반드시 *IbPaging 메소드명을 사용해야함
            map = openCateService.selectOpenCateParListTreeIbPaging(openCate);
        }
        @SuppressWarnings("unchecked")
        List<OpenCate> result = (List<OpenCate>) map.get("resultList");
        int cnt = (Integer) map.get("resultCnt");
        return new IBSheetListVO<OpenCate>(result, cnt);
    }

    /**
     * 첨부파일 파일 저장
     *
     * @param fileVo
     * @param request
     * @param opencate
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/opendt/saveBbsFile.do")
    @ResponseBody
    public void saveImgFile(FileVo fileVo, HttpServletRequest request, OpenCate opencate, ModelMap model, HttpServletResponse res) {
        int i = 0;
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
        try {
            FileService.setFileCuData(fileVo);//파일재정의(트랙잰션)
            logger.debug("========================before");
            successFileUpload = FileService.fileUpload(fileVo, i, EgovProperties.getProperty("Globals.OpenCateFilePath"), WiseOpenConfig.FILE_DATA_CATE);
            logger.debug("========================after," + successFileUpload);

            //UtilString.setQueryStringData을 사용하여 data를 list 형태로 반환다.
            //반드시 new 연산자를 사용하여 vo를 넘겨야한다..
            res.setContentType("text/html;charset=UTF-8");
            PrintWriter writer = res.getWriter();
            if (successFileUpload) {
                @SuppressWarnings("unchecked")
                List<OpenCate> list = (List<OpenCate>) UtilString.setQueryStringData(request, new OpenCate(), fileVo);
                if (opencate != null) {
                    rtnVal = objectMapper.writeValueAsString(saveImgFileListCUD((ArrayList<?>) list, opencate, model, fileVo));
                }
            } else {
                rtnVal = objectMapper.writeValueAsString(new IBSResultVO<OpenCate>(-2, messagehelper.getSavaMessage(-2)));    //저장실패
            }
            writer.println(rtnVal);
            writer.close();        //return type을 IBSResultVO 하면 IE에서 작업 완료시 다운로드 받는 문제가 생겨 변경..

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
    }

    /**
     * 첨부파일 데이터 저장
     *
     * @param list
     * @param opencate
     * @param model
     * @return
     * @throws Exception
     */
    private IBSResultVO<CommVo> saveImgFileListCUD(ArrayList<?> list, OpenCate opencate, ModelMap model, FileVo fileVo) {
        logger.debug("saveImgFileListCUD");
        int result = 0;
        if (opencate != null) {
            result = openCateService.saveImgFileListCUD(opencate, list, fileVo);
        }

        return new IBSResultVO<CommVo>(result, messagehelper.getSavaMessage(result), "File");
    }

    /**
     * 표준맵핑 선택 팝업화면으로 이동한다.
     *
     * @param model
     * @return String
     * @throws Exception
     */
    @RequestMapping("/admin/opendt/commCodeListPopUp.do")
    public String commCodeTitcIdPopUp(ModelMap model) {
        return "/admin/opendt/popup/commcodelistpopup";
    }

    /**
     * 개발중....
     *
     * @param
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/opendt/bbsImgDetailView.do")
    @ResponseBody
    public Map<String, Object> cateImgDetailView(OpenCate opencate, ModelMap model) {
        Map<String, Object> map = new HashMap<String, Object>();
        if (opencate != null) {
            map = openCateService.cateImgDetailView(opencate);
            map.put("resultImg", map.get("resultImg"));
        }
        //map.put("resultTopYn",  map.get("resultTopYn"));
        return map;
    }

    /**
     * 파일 다운로드(포탈)
     *
     * @param downCd
     * @param fileSeq
     * @param seq
     * @return
     */
    @RequestMapping("/admin/opendt/fileDownload.do")
    public ModelAndView download(@RequestParam("downCd") String downCd, @RequestParam("fileSeq") int fileSeq, @RequestParam("seq") String seq) {
        // 게시판의 경우에는 C:/DATA/upload/bbs/ 이후에 bbsCd별로 folder가 따로 생성되기 때문에 중간에 bbsCd folder를 가져오기 위해 다운로드폴더명을 굳이 나눴음 - 발로 짠거 인정 ㅠㅠ - 황미리 with 정호성
        String downloadFolder = UtilString.getDownloadRootFolder(downCd, seq);

        List<HashMap<String, Object>> map = FileService.getFileNameByFileSeq(downCd, fileSeq, seq);
        String fileName = (String) map.get(0).get("viewFileNm");                        //사용자에게 보여줄 파일명(출력파일명)
        String fileExtg = (String) map.get(0).get("fileExt");
        //사용자에게 보여줄 확장자명(출력확장자)

        String saveFileNm = (String) map.get(0).get("saveFileNm");

        String filePath = EgovWebUtil.folderPathReplaceAll(downloadFolder + File.separator);                //전체다운경로
        ModelAndView mav = new ModelAndView();
        mav.addObject("fileName", fileName + "." + fileExtg);
        mav.addObject("file", new File(filePath + EgovWebUtil.filePathReplaceAll(saveFileNm)));
        mav.setViewName("downloadView");    //viewResolver...
        return mav;
    }

    /**
     * 첨부이미지 완전 삭제 (개발중.....)
     *
     * @param opencate
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/opendt/deleteImgDtl.do")
    @ResponseBody
    public IBSResultVO<BbsList> deleteImgDtl(@ModelAttribute OpenCate opencate) {
        int result = 0;
        try {
            if (opencate != null) {
                result = openCateService.deleteImgDtlCUD(opencate);
            }
        } catch (DataAccessException e) {
            EgovWebUtil.exTransactionLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
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
}

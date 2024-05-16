package egovframework.admin.openinf.web;

/**
 * 분류정보 관리로 이동하는 클래스
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.07.16
 */

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.admin.bbs.service.BbsList;
import egovframework.admin.openinf.service.OpenPublish;
import egovframework.admin.openinf.service.OpenPublishService;
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
import egovframework.common.helper.TABListVo;
import egovframework.common.util.UtilString;


@Controller
public class OpenPublishController implements InitializingBean {

    protected static final Log logger = LogFactory.getLog(OpenPublishController.class);

    //공통코드 사용시 선언
    @Resource
    private CodeListService commCodeListService;

    @Resource(name = "FileService")
    private FileService FileService;

    @Resource(name = "OpenPublishService")
    private OpenPublishService openPublishService;

    static class openPublish extends HashMap<String, ArrayList<OpenPublish>> {
    }

    //공통 메시지 사용시 선언
    @Resource
    Messagehelper messagehelper;

    @Resource
    EgovMessageSource message;

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
        //codeMap.put("niaId", commCodeListService.getCodeList("D1025"));
        //codeMap.put("niaId", UtilJson.convertJsonString(commCodeListService.getCodeListIBS("D1025")));//분류정보 ibSheet
        return codeMap;
    }


    /**
     * 공표자료 관리 화면으로 이동
     *
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/openpub/openPublishPage.do")
    public String openPubPage(ModelMap model) {
        //페이지 title을 가져오려면 반드시 *Page로 끝나야한다.
        //Interceptor(PageNavigationInterceptor)에서 조회함
        return "/admin/openinf/openpub/openpublish";
    }

    /**
     * 공표자료 목록을 조회한다.
     *
     * @param OpenPubCfg
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/openpub/openPublishListAll.do")
    @ResponseBody
    public IBSheetListVO<OpenPublish> openPublishListAllIbPaging(OpenPublish openPublish, ModelMap model) {
        //페이징 처리시 반드시 *IbPaging 메소드명을 사용해야함
        Map<String, Object> map = openPublishService.openPublishListAllIbPaging(openPublish);
        @SuppressWarnings("unchecked")
        List<OpenPublish> result = (List<OpenPublish>) map.get("resultList");
        int cnt = Integer.parseInt((String) map.get("resultCnt"));
        return new IBSheetListVO<OpenPublish>(result, cnt);
    }

    /**
     * 공표자료를 단건 조회한다.
     *
     * @param openPublish
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/openpub/openPublishOne.do")
    @ResponseBody
    public TABListVo<OpenPublish> openPublishOne(@RequestBody OpenPublish openPublish, ModelMap model) {
        return new TABListVo<OpenPublish>(openPublishService.selectOpenPublishOne(openPublish));
    }


    /**
     * 공표자료의 파일리스트를 출력한다.
     *
     * @param openPublish
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/openpub/openPublishFileList.do")
    @ResponseBody
    public IBSheetListVO<OpenPublish> openPublishFileList(@ModelAttribute("searchVO") OpenPublish openPublish, ModelMap model) {
        Map<String, Object> map = openPublishService.openPublishFileList(openPublish);
        @SuppressWarnings("unchecked")
        List<OpenPublish> result = (List<OpenPublish>) map.get("resultList");
        int cnt = Integer.parseInt((String) map.get("resultCnt"));
        return new IBSheetListVO<OpenPublish>(result, cnt);
    }

    /**
     * 첨부파일 조회
     *
     * @param bbsList
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/openpub/openPublishFileList2.do")
    @ResponseBody
    public List<OpenPublish> openPublishFileList2(OpenPublish openPublish, ModelMap model) {
        //페이징 처리시 반드시 *IbPaging 메소드명을 사용해야함
        Map<String, Object> map = openPublishService.openPublishFileList(openPublish);
        @SuppressWarnings("unchecked")
        List<OpenPublish> result = (List<OpenPublish>) map.get("resultList");
        return result;
    }

    /**
     * 공표자료를 수정한다.
     *
     * @param OpenPublish
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/openpub/openPublishUpd.do")
    @ResponseBody
    public IBSResultVO<OpenPublish> openPubCfgUpd(OpenPublish openPublish, ModelMap model) {
        int result = 0;
        //등록, 변경, 삭제 처리시  등록자, 수정자 Id를 세션에서 가져올 경우 *CUD 메소드명을 사용해야함
        result = openPublishService.saveOpenPublishCUD(openPublish, WiseOpenConfig.STATUS_U);
        return new IBSResultVO<OpenPublish>(result, messagehelper.getSavaMessage(result));
    }


    /**
     * 공표자료에서 담당자 확인을 실행한다.
     *
     * @param OpenPublish
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/openpub/openPublishPubOk.do")
    @ResponseBody
    public IBSResultVO<OpenPublish> openPublishPubOk(OpenPublish openPublish, ModelMap model) {
        int result = 0;
        //등록, 변경, 삭제 처리시  등록자, 수정자 Id를 세션에서 가져올 경우 *CUD 메소드명을 사용해야함
        result = openPublishService.saveOpenPublishCUD(openPublish, WiseOpenConfig.STATUS_U2);
        return new IBSResultVO<OpenPublish>(result, messagehelper.getSavaMessage(result));
    }


    /**
     * 공표자료의 파일 업로드
     * @param fileVo
     * @param request
     * @param openInfSrv
     * @param model
     * @return
     * @throws Exception
     *//*
		@RequestMapping("/admin/service/openInfPublishFileSave.do")
		@ResponseBody
		public IBSResultVO<CommVo> openInfPublishFileSave(FileVo fileVo, HttpServletRequest request, OpenPublish openPublish, ModelMap model){
			boolean successFileUpload = false;
			
			//현재 파일 업로드가 안되고 있음 나중에 할 예정
			//파일 체크
			FileService.setFileCuData(fileVo);//파일재정의(트랙잰션)
			//if(FileService.fileTypeCkeck(fileVo, type)){ //타입이 정상인지 체크
				successFileUpload = FileService.fileUpload(fileVo, openPublish.getSeq(), EgovProperties.getProperty("Globals.PublishFilePath"), WiseOpenConfig.FILE_PUBLISH);
			//}else{
				
				//리턴 에러메시지 뿌려야함
			//}
			//UtilString.setQueryStringData을 사용하여 data를 list 형태로 반환다.
			//반드시 new 연산자를 사용하여 vo를 넘겨야한다.
				
				
				
			if ( successFileUpload ) {
				@SuppressWarnings("unchecked")
				List<OpenPublish> list = (List<OpenPublish>)UtilString.setQueryStringData(request, new OpenPublish(), fileVo);
				return openPublishFileSave((ArrayList<?>) list, openPublish, model);
			} else {
				return new IBSResultVO<CommVo>(-2, messagehelper.getSavaMessage(-2));		//저장실패
			}
		}
		
		
		
		public IBSResultVO<CommVo> openPublishFileSave(ArrayList<?> list, OpenPublish openPublish, ModelMap model){
			int result = openPublishService.saveOpenPublishFileCUD(openPublish,list);
			return new IBSResultVO<CommVo>(result, messagehelper.getSavaMessage(result));
		}
		*/


    /**
     * 첨부파일 파일 저장
     * @param fileVo
     * @param request
     * @param bbsList
     * @param model
     * @return
     * @throws Exception
     *//*
		@RequestMapping("/admin/bbs/saveBbsFile.do")
		@ResponseBody
		public void saveBbsFile(FileVo fileVo, HttpServletRequest request, BbsList bbsList, ModelMap model, HttpServletResponse res){
			boolean successFileUpload = false;
			String rtnVal = "";
			 파일 타입 체크시... 아래코드 주석 풀고 사용..
			String[] type = {"hwp,ppt"}; //파일 허용타입
			if(FileService.fileTypeCkeck(fileVo, type)){ //타입이 정상인지 체크
				successFileUpload = FileService.fileUpload(fileVo, openInfSrv.getMstSeq(), EgovProperties.getProperty("Globals.ServiceFilePath"), WiseOpenConfig.FILE_SERVICE);
			}else{
				//리턴 에러메시지 뿌려야함
			}
			 
			FileService.setFileCuData(fileVo);//파일재정의(트랙잰션)
			successFileUpload =	FileService.fileUpload(fileVo, bbsList.getMstSeq(), EgovProperties.getProperty("Globals.BbsFilePath"), WiseOpenConfig.FILE_BBS);
			//UtilString.setQueryStringData을 사용하여 data를 list 형태로 반환다.
			//반드시 new 연산자를 사용하여 vo를 넘겨야한다..
			res.setContentType("text/html;charset=UTF-8");
			PrintWriter writer = res.getWriter();
			if ( successFileUpload ) {
				@SuppressWarnings("unchecked")
				List<CommVo> list = (List<CommVo>)UtilString.setQueryStringData(request, new BbsList(), fileVo);
				rtnVal = objectMapper.writeValueAsString(saveBbsFileListCUD((ArrayList<?>) list, bbsList, model));
			} else {
				rtnVal = objectMapper.writeValueAsString(new IBSResultVO<CommVo>(-2, messagehelper.getSavaMessage(-2)));	//저장실패
			}
			writer.println(rtnVal);
			writer.close();		//return type을 IBSResultVO 하면 IE에서 작업 완료시 다운로드 받는 문제가 생겨 변경..
		}*/


    /**
     * 첨부파일 데이터 저장
     * @param list
     * @param bbsList
     * @param model
     * @return
     * @throws Exception
     *//*
		private IBSResultVO<CommVo> saveBbsFileListCUD(ArrayList<?> list, BbsList bbsList, ModelMap model){
			int result =  bbsListService.saveBbsFileListCUD(bbsList, list);
			int fileSeq = 0;
			if(((BbsList)list.get(0)).getStatus().equals("I")){
				fileSeq = ((BbsList)list.get(0)).getFileSeq();
			}else{
				fileSeq = ((BbsList)list.get(0)).getArrFileSeq();
			}
			return new IBSResultVO<CommVo>(result, messagehelper.getSavaMessage(result), "File", fileSeq);
		}*/


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
    @RequestMapping("/admin/service/openInfPublishFileSave.do")
    @ResponseBody
    public void openInfPublishFileSave(FileVo fileVo, HttpServletRequest request, OpenPublish openPublish, ModelMap model, HttpServletResponse res) {
        boolean successFileUpload = false;
        String rtnVal = "";
        //파일 타입 체크시... 아래코드 주석 풀고 사용..
        String[] type = {"hwp,ppt"}; //파일 허용타입
        if (FileService.fileTypeCkeck(fileVo, type)) { //타입이 정상인지 체크
            successFileUpload = FileService.fileUpload(fileVo, openPublish.getMstSeq(), EgovProperties.getProperty("Globals.ServiceFilePath"), WiseOpenConfig.FILE_PUBLISH);
        } else {
            //리턴 에러메시지 뿌려야함
        }
        try {
            FileService.setFileCuData(fileVo);//파일재정의(트랙잰션)
            successFileUpload = FileService.fileUpload(fileVo, openPublish.getMstSeq(), EgovProperties.getProperty("Globals.ServiceFilePath"), WiseOpenConfig.FILE_PUBLISH);
            //UtilString.setQueryStringData을 사용하여 data를 list 형태로 반환다.
            //반드시 new 연산자를 사용하여 vo를 넘겨야한다..
            res.setContentType("text/html;charset=UTF-8");
            PrintWriter writer = res.getWriter();
            if (successFileUpload) {
                @SuppressWarnings("unchecked")
                List<CommVo> list = (List<CommVo>) UtilString.setQueryStringData(request, new OpenPublish(), fileVo);
                rtnVal = objectMapper.writeValueAsString(saveOpenPublishFileListCUD((ArrayList<?>) list, openPublish, model));
            } else {
                rtnVal = objectMapper.writeValueAsString(new IBSResultVO<CommVo>(-2, messagehelper.getSavaMessage(-2)));    //저장실패
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
     * @param bbsList
     * @param model
     * @return
     * @throws Exception
     */
    private IBSResultVO<CommVo> saveOpenPublishFileListCUD(ArrayList<?> list, OpenPublish openPublish, ModelMap model) {
        int result = openPublishService.saveOpenPublishFileListCUD(openPublish, list);
        int fileSeq = 0;
        if (((OpenPublish) list.get(0)).getStatus().equals("I")) {
            fileSeq = ((OpenPublish) list.get(0)).getFileSeq();
        } else {
            fileSeq = ((OpenPublish) list.get(0)).getArrFileSeq();
        }
        return new IBSResultVO<CommVo>(result, messagehelper.getSavaMessage(result), "File", fileSeq);
    }


}

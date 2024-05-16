package egovframework.admin.openinf.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
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

import egovframework.admin.openinf.service.OpenDscol;
import egovframework.admin.openinf.service.OpenDt;
import egovframework.admin.openinf.service.OpenDtService;
import egovframework.admin.openinf.service.OpenDtbl;
import egovframework.admin.openinf.service.OpenOrgUsrRel;
import egovframework.admin.openinf.web.OpenDsController.openDscols;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.WiseOpenConfig;
import egovframework.common.code.service.CodeListService;
import egovframework.common.grid.IBSResultVO;
import egovframework.common.grid.IBSheetListVO;
import egovframework.common.helper.Messagehelper;
import egovframework.common.helper.TABListVo;
import egovframework.common.util.UtilJson;

@Controller
public class OpenDtController implements InitializingBean {

    protected static final Log logger = LogFactory.getLog(OpenDtController.class);

    //공통코드 사용시 선언
    @Resource
    private CodeListService commCodeListService;

    @Resource(name = "OpenDtService")
    private OpenDtService openDtService;

    //공통 메시지 사용시 선언
    @Resource
    Messagehelper messagehelper;

    @Resource
    EgovMessageSource message;

    static class openDtbls extends HashMap<String, ArrayList<OpenDtbl>> {
    }

    @Override
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
            codeMap.put("cateIdIbs", UtilJson.convertJsonString(commCodeListService.getCodeListIBS("D1025")));//분류정보 ibSheet
            codeMap.put("openCdIbs", UtilJson.convertJsonString(commCodeListService.getCodeListIBS("D1001")));//분류정보 ibSheet
            codeMap.put("srcTblCdIbs", UtilJson.convertJsonString(commCodeListService.getCodeListIBS("D1003")));//분류정보 ibSheet
            codeMap.put("linkCdIbs", UtilJson.convertJsonString(commCodeListService.getCodeListIBS("D1004")));//분류정보 ibSheet
            codeMap.put("prssCdIbs", UtilJson.convertJsonString(commCodeListService.getCodeListIBS("D1005")));//분류정보 ibSheet
            codeMap.put("loadCdIbs", UtilJson.convertJsonString(commCodeListService.getCodeListIBS("D1009")));//분류정보 ibSheet
//		codeMap.put("unitCdIbs", UtilJson.convertJsonString(commCodeListService.getCodeListIBS("D1013", true)));//
            codeMap.put("cateId", commCodeListService.getCodeList("D1025")); //분류정보 select box
            codeMap.put("openCd", commCodeListService.getCodeList("D1001")); //분류정보 select box
            codeMap.put("causeCd", commCodeListService.getCodeList("D1002")); //분류정보 select box
            codeMap.put("sysCd", commCodeListService.getCodeList("D1027")); //분류정보 select box
            codeMap.put("ownerCd", commCodeListService.getCodeList("D1006")); //OWNER코드 select box


        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return codeMap;
    }


    /**
     * 화면 조회
     *
     * @return String
     */
    @RequestMapping("/admin/openinf/opendt/openDtPage.do")
    public String openDtPage() {
        return "/admin/openinf/opendt/opendt";
    }


    /**
     * 보유데이터 목록 조회
     *
     * @param openDt
     * @param model
     * @return IBSheetListVO<OpenDt>
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/opendt/openDtList.do")
    @ResponseBody
    public IBSheetListVO<OpenDt> openDtList(@ModelAttribute("searchVO") OpenDt openDt, ModelMap model) {
        //페이징 처리시 반드시 *IbPaging 메소드명을 사용해야함
        Map<String, Object> map = openDtService.selectOpenDtIbPaging(openDt);
        @SuppressWarnings("unchecked")
        List<OpenDt> result = (List<OpenDt>) map.get("resultList");
        int cnt = Integer.parseInt((String) map.get("resultCnt"));
        return new IBSheetListVO<OpenDt>(result, cnt);
    }

    /**
     * 보유데이터 상세정보 단건 조회
     *
     * @param openDt
     * @param model
     * @return TABListVo<OpenDt>
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/opendt/openDtDetail.do")
    @ResponseBody
    public TABListVo<OpenDt> commUsrList(@RequestBody OpenDt openDt, ModelMap model) {
        return new TABListVo<OpenDt>(openDtService.selectOpenDtDtl(openDt));
    }

    /**
     * 보유데이터 테이블정보 목록 조회
     *
     * @param openDtbl
     * @param model
     * @return IBSheetListVO<OpenDtbl>
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/opendt/openDtblList.do")
    @ResponseBody
    public IBSheetListVO<OpenDtbl> openDtblList(@ModelAttribute("searchVO") OpenDtbl openDtbl, ModelMap model) {
        //페이징 처리시 반드시 *IbPaging 메소드명을 사용해야함
        Map<String, Object> map = openDtService.selectOpenDtblIbPaging(openDtbl);
        @SuppressWarnings("unchecked")
        List<OpenDtbl> result = (List<OpenDtbl>) map.get("resultList");
        int cnt = Integer.parseInt((String) map.get("resultCnt"));
        return new IBSheetListVO<OpenDtbl>(result, cnt);
    }

    /**
     * 관련데이터 팝업 화면
     *
     * @param sheetNm
     * @param dtId
     * @param model
     * @return String
     */
    @RequestMapping("/admin/openinf/opendt/popup/openDtSrc_pop.do")
    public String openDtSrcPop(String sheetNm, String dtId, ModelMap model) {
        model.addAttribute("sheetNm", sheetNm);
        model.addAttribute("dtId", dtId);
        return "/admin/openinf/opendt/popup/opendtSrc_pop";
    }

    /**
     * 관련데이터 팝업 화면 목록 조회
     *
     * @param openDtbl
     * @param model
     * @return IBSheetListVO<OpenDtbl>
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/opendt/popup/openDtSrcPopList.do")
    @ResponseBody
    public IBSheetListVO<OpenDtbl> openDtSrcPopList(@ModelAttribute("searchVO") OpenDtbl openDtbl, ModelMap model) {

        //페이징 처리시 반드시 *IbPaging 메소드명을 사용해야함
        Map<String, Object> map = openDtService.selectopenDtSrcPopPopIbPaging(openDtbl);
        @SuppressWarnings("unchecked")
        List<OpenDtbl> result = (List<OpenDtbl>) map.get("resultList");
        int cnt = Integer.parseInt((String) map.get("resultCnt"));
        return new IBSheetListVO<OpenDtbl>(result, cnt);

    }


    /**
     * 보유데이터 상세정보 저장
     *
     * @param data
     * @param saveVO
     * @param locale
     * @return IBSResultVO<OpenDtbl>
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/opendt/saveOpenDt.do")
    @ResponseBody
    public IBSResultVO<OpenDtbl> saveOpenDt(@RequestBody openDtbls data, Locale locale) {
        int result = 0;
        //등록, 변경, 삭제 처리시  등록자, 수정자 Id를 세션에서 가져올 경우 *CUD 메소드명을 사용해야함

        ArrayList<OpenDtbl> list = data.get("data");

        result = openDtService.saveOpenDtDtlCUD(list); //보유데이터 상세정보 저장.
        String resmsg;
        if (result > 0) {
            result = 0;
            resmsg = message.getMessage("MSG.SAVE");
        } else {
            result = -1;
            resmsg = message.getMessage("ERR.SAVE");
        }
        return new IBSResultVO<OpenDtbl>(result, resmsg);


//		ArrayList<OpenDtbl> list = data.get("data");
        //int result = openDtService.saveOpenDtCUD(saveVO, saveVO);
//		String resmsg;
//		if(result > 0) {
//			result = 0;
//			resmsg = message.getMessage("MSG.SAVE");
//		} else {
//			result = -1;
//			resmsg = message.getMessage("ERR.SAVE");
//		}
//		return new IBSResultVO<OpenDtbl>(saveVO, result, resmsg);
    }

    /**
     * 보유데이터 상세정보 수정  (사용안함 - 박일환)
     *
     * @param saveVO
     * @param model
     * @return IBSResultVO<OpenDtbl>
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/opendt/updateOpenDt.do")
    @ResponseBody
    public IBSResultVO<OpenDtbl> updateOpenDt(@ModelAttribute OpenDtbl saveVO, ModelMap model) {
        int result = 0;
        //등록, 변경, 삭제 처리시  등록자, 수정자 Id를 세션에서 가져올 경우 *CUD 메소드명을 사용해야함
//		result = openDtService.saveOpenDtDtlCUD(saveVO,WiseOpenConfig.STATUS_U);
        return new IBSResultVO<OpenDtbl>(result, messagehelper.getUpdateMessage(result));
    }

    /**
     * 보유데이터 테이블 목록 정보 수정
     *
     * @param data
     * @param locale
     * @return IBSResultVO<OpenDtbl>
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/opendt/updateOpenDtbl.do")
    @ResponseBody
    public IBSResultVO<OpenDtbl> updateOpenDtbl(@RequestBody openDtbls data, Locale locale) {
        ArrayList<OpenDtbl> list = data.get("data");
        int result = openDtService.updateOpenDtblCUD(list);
        String resmsg;
        if (result > 0) {
            result = 0;
            resmsg = message.getMessage("MSG.UPD");
        } else {
            result = -1;
            resmsg = message.getMessage("ERR.SAVE");
        }

        return new IBSResultVO<OpenDtbl>(result, resmsg);
    }

    /**
     * 보유데이터 삭제  (사용안함 - 박일환)
     *
     * @param saveVO
     * @param model
     * @return IBSResultVO<OpenDtbl>
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/opendt/deleteOpenDt.do")
    @ResponseBody
    public IBSResultVO<OpenDtbl> deleteOpenDt(@ModelAttribute OpenDtbl saveVO, ModelMap model) {
        String resmsg;
        int result = 0;

        int resultInf = openDtService.getUseDtInf(saveVO);
        if (resultInf > 0) {
            result = -1;
            resmsg = message.getMessage("ERR.INFCHK");
        } else {
//			result = openDtService.saveOpenDtDtlCUD(saveVO,WiseOpenConfig.STATUS_D);
            if (result == -1111) { //보유데이터 관리 삭제하려 했지만 데이터셋, 메타정보에서 사용하고 있어서 삭제못하도록 한다.
                result = -1;
                resmsg = "데이터셋 또는 메타정보에서 해당 보유데이터를 사용중입니다.";
            } else if (result > 0) {
                result = 0;
                resmsg = message.getMessage("MSG.DEL");
            } else {
                result = -1;
                resmsg = message.getMessage("ERR.SAVE");
            }
        }
        return new IBSResultVO<OpenDtbl>(result, resmsg);
    }

    /**
     * 보유데이터 테이블 목록 삭제
     *
     * @param data
     * @param locale
     * @return IBSResultVO<OpenDtbl>
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/opendt/deleteOpenDtbl.do")
    @ResponseBody
    public IBSResultVO<OpenDtbl> deleteOpenDtbl(@RequestBody openDtbls data, Locale locale) {
        ArrayList<OpenDtbl> list = data.get("data");
        int result = openDtService.deleteOpenDtblCUD(list);
        String resmsg;
        if (result > 0) {
            result = 0;
            resmsg = message.getMessage("MSG.DEL");
        } else {
            result = -1;
            resmsg = message.getMessage("ERR.SAVE");
        }
        return new IBSResultVO<OpenDtbl>(result, resmsg);
    }


}

package egovframework.admin.openinf.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egovframework.admin.openinf.service.OpenDs;
import egovframework.admin.openinf.service.OpenDsService;
import egovframework.admin.openinf.service.OpenDscol;
import egovframework.admin.openinf.service.OpenDtbl;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.WiseOpenConfig;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;
import egovframework.common.code.service.CodeListService;
import egovframework.common.grid.IBSResultVO;
import egovframework.common.grid.IBSheetListVO;
import egovframework.common.helper.Messagehelper;
import egovframework.common.util.UtilJson;

@Controller
public class OpenDsController extends BaseController implements InitializingBean {

    protected static final Log logger = LogFactory.getLog(OpenDsController.class);

    public static final String ACTION_STATUS = "Status";    //액션 상태
    public static final String ACTION_INS = "I";            //등록
    public static final String ACTION_UPD = "U";            //수정
    public static final String ACTION_DEL = "D";            //삭제

    //공통코드 사용시 선언
    @Resource
    private CodeListService commCodeListService;

    @Resource(name = "OpenDsService")
    private OpenDsService openDsService;

    //공통 메시지 사용시 선언
    @Resource
    Messagehelper messagehelper;

    @Resource
    EgovMessageSource message;

    @SuppressWarnings("serial")
    static class openDscols extends HashMap<String, ArrayList<OpenDscol>> {
    }

    @SuppressWarnings("serial")
    static class openDtbls extends HashMap<String, ArrayList<OpenDtbl>> {
    }

    @Override
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
            codeMap.put("ownerCdIbs", UtilJson.convertJsonString(commCodeListService.getCodeListIBS("D1006")));//OWNER코드 ibSheet
            codeMap.put("dsCdIbs", UtilJson.convertJsonString(commCodeListService.getCodeListIBS("D1024")));//데이터셋구분 ibSheet
            codeMap.put("unitCdIbs", UtilJson.convertJsonString(commCodeListService.getCodeListIBS("D1013", true, "")));//단위 ibSheet
            codeMap.put("ownerCd", commCodeListService.getCodeList("D1006")); //OWNER코드 select box
            //codeMap.put("dsCd", commCodeListService.getCodeList("D1024")); //데이터셋구분 select box
            codeMap.put("fsCd", commCodeListService.getCodeList("D1034")); //데이터셋 관서코드 select box

            codeMap.put("linkCd", UtilJson.convertJsonString(commCodeListService.getCodeListIBS("D1004")));//데이터셋구분 ibSheet
            codeMap.put("lodeCd", UtilJson.convertJsonString(commCodeListService.getCodeListIBS("D1009")));//데이터셋구분 ibSheet

            codeMap.put("jsCdIbs", UtilJson.convertJsonString(commCodeListService.getCodeListIBS("D1103", true, "")));//단위 ibSheet

            //2017.10.11/김정호 - 데이터셋 상세정보, 항목정보 추가
            codeMap.put("conntyCd", commCodeListService.getCodeList("D2002"));    //데이터셋 연계방식
            codeMap.put("loadCd", commCodeListService.getCodeList("D1009"));    //데이터셋 적재주기
            codeMap.put("ownerCd", commCodeListService.getCodeList("D2001"));    //데이터셋 OWNER코드
            codeMap.put("lddataCd", commCodeListService.getCodeList("D2008"));    //데이터셋 입력저장구분코드
            codeMap.put("coltyCd", UtilJson.convertJsonString(commCodeListService.getCodeListIBS("D2006")));    //데이터셋 컬럼형식코드
            codeMap.put("verifyCd", UtilJson.convertJsonString(commCodeListService.getCodeListIBS("D2007")));    //데이터셋 검증형식코드

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return codeMap;
    }

    /**
     * 화면을 조회한다
     *
     * @return String
     */
    @RequestMapping("/admin/openinf/opends/openDsPage.do")
    public String openDsPage() {
        //return "/admin/openinf/opends/opends";
        return "/admin/openinf/opends/newOpends";
    }

    /**
     * 데이터셋 화면 목록 조회
     *
     * @param openDs
     * @param model
     * @return IBSheetListVO<OpenDs>
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/opends/openDsList.do")
    @ResponseBody
    public IBSheetListVO<OpenDs> openDsList(@ModelAttribute("searchVO") OpenDs openDs, ModelMap model) {
        //페이징 처리시 반드시 *IbPaging 메소드명을 사용해야함
        Map<String, Object> map = openDsService.selectOpenDsIbPaging(openDs);
        @SuppressWarnings("unchecked")
        List<OpenDs> result = (List<OpenDs>) map.get("resultList");
        int cnt = Integer.parseInt((String) map.get("resultCnt"));
        return new IBSheetListVO<OpenDs>(result, cnt);

    }

    /**
     * 데이터셋 단건 조회
     * @param openDs
     * @param model
     * @return TABListVo<OpenDs>
     * @throws Exception
     */
	/*@RequestMapping("/admin/openinf/opends/openDsDetail.do")
	@ResponseBody
	public TABListVo<OpenDs> commUsrList(@RequestBody OpenDs openDs, ModelMap model, String dsId){
		return new TABListVo<OpenDs>(openDsService.selectOpenDsDtl(openDs));
	}*/

    /**
     * 데이터셋 단건조회
     *
     * @param openInf
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/opends/openDsDetail.do")
    @ResponseBody
    public Map<String, Object> commUsrList(OpenDs openDs, ModelMap model) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("DATA", openDsService.selectOpenDsDtl(openDs));
        return map;
    }

    /**
     * 데이터셋 컬럼 조회
     *
     * @param openDscol
     * @param model
     * @return IBSheetListVO<OpenDscol>
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/opends/openDsColList.do")
    @ResponseBody
    public IBSheetListVO<OpenDscol> openDsColList(@ModelAttribute("searchVO") OpenDscol openDscol, ModelMap model) {

        //페이징 처리시 반드시 *IbPaging 메소드명을 사용해야함
        Map<String, Object> map = openDsService.selectOpenDsColIbPaging(openDscol);
        @SuppressWarnings("unchecked")
        List<OpenDscol> result = (List<OpenDscol>) map.get("resultList");
        int cnt = Integer.parseInt((String) map.get("resultCnt"));
        return new IBSheetListVO<OpenDscol>(result, cnt);

    }

    /**
     * 데이터셋 DQ조회
     *
     * @param openDscol
     * @param model
     * @return IBSheetListVO<OpenDscol>
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/opends/openDsDQ.do")
    @ResponseBody
    public IBSheetListVO<OpenDscol> openDsDQ(@ModelAttribute("searchVO") OpenDscol openDscol, ModelMap model) {
		/*
		//페이징 처리시 반드시 *IbPaging 메소드명을 사용해야함
		Map<String, Object> map = openDsService.selectOpenDsDQ(openDscol);
		@SuppressWarnings("unchecked")
		List<OpenDscol> result = (List<OpenDscol>) map.get("resultList");
		int cnt = Integer.parseInt((String)map.get("resultCnt"));
		return new IBSheetListVO<OpenDscol>(result, cnt);
		*/
        return null;
    }


    /**
     * 원본 컬럼 항목 조회(불러오기)
     *
     * @param openDscol
     * @param model
     * @return IBSheetListVO<OpenDscol>
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/opends/openDsSrcColList.do")
    @ResponseBody
    public IBSheetListVO<OpenDscol> openDsSrcColList(@ModelAttribute("searchVO") OpenDscol openDscol, ModelMap model) {

        //페이징 처리시 반드시 *IbPaging 메소드명을 사용해야함
        Map<String, Object> map = openDsService.selectOpenDsSrcColIbPaging(openDscol);
        @SuppressWarnings("unchecked")
        List<OpenDscol> result = (List<OpenDscol>) map.get("resultList");
        int cnt = Integer.parseInt((String) map.get("resultCnt"));
        return new IBSheetListVO<OpenDscol>(result, cnt);

    }


    /**
     * 데이터셋 팝업 화면을 조회한다
     *
     * @return String
     */
    @RequestMapping("/admin/openinf/opends/popup/openDs_pop.do")
    public String openDsPop() {
        return "/admin/openinf/opends/popup/opends_pop";
    }

    /**
     * 데이터셋 팝업 화면 목록 조회
     *
     * @param openDs
     * @param model
     * @return IBSheetListVO<OpenDs>
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/opends/popup/openDsPopList.do")
    @ResponseBody
    public IBSheetListVO<OpenDs> openDsPopList(@ModelAttribute("searchVO") OpenDs openDs, ModelMap model) {

        //페이징 처리시 반드시 *IbPaging 메소드명을 사용해야함
        Map<String, Object> map = openDsService.selectOpenDsPopIbPaging(openDs);
        @SuppressWarnings("unchecked")
        List<OpenDs> result = (List<OpenDs>) map.get("resultList");
        int cnt = Integer.parseInt((String) map.get("resultCnt"));
        return new IBSheetListVO<OpenDs>(result, cnt);

    }

    /**
     * 백업테이블 팝업 화면을 조회한다
     *
     * @return String
     */
    @RequestMapping("/admin/openinf/opends/popup/backDs_pop.do")
    public String backDsPop() {
        return "/admin/openinf/opends/popup/backds_pop";
    }

    /**
     * 백업테이블 팝업 화면 목록 조회
     *
     * @param openDs
     * @param model
     * @return IBSheetListVO<OpenDs>
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/opends/popup/backDsPopList.do")
    @ResponseBody
    public IBSheetListVO<OpenDs> backDsPopList(@ModelAttribute("searchVO") OpenDs openDs, ModelMap model) {

        //페이징 처리시 반드시 *IbPaging 메소드명을 사용해야함
        Map<String, Object> map = openDsService.selectBackDsPopIbPaging(openDs);
        @SuppressWarnings("unchecked")
        List<OpenDs> result = (List<OpenDs>) map.get("resultList");
        int cnt = Integer.parseInt((String) map.get("resultCnt"));
        return new IBSheetListVO<OpenDs>(result, cnt);

    }

    /**
     * 보유데이터 팝업 화면
     *
     * @return String
     */
    @RequestMapping("/admin/openinf/opends/popup/openDt_pop.do")
    public String openDtPop(ModelMap model) {
        return "/admin/openinf/opends/popup/opendt_pop";
    }

    /**
     * 보유데이터 팝업 목록 조회
     *
     * @param openDs
     * @param model
     * @return IBSheetListVO<OpenDs>
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/opends/popup/openDtPopList.do")
    @ResponseBody
    public IBSheetListVO<OpenDs> openDtPopList(@ModelAttribute("searchVO") OpenDs openDs, ModelMap model) {

        //페이징 처리시 반드시 *IbPaging 메소드명을 사용해야함
        Map<String, Object> map = openDsService.selectOpenDtPopIbPaging(openDs);
        @SuppressWarnings("unchecked")
        List<OpenDs> result = (List<OpenDs>) map.get("resultList");
        int cnt = Integer.parseInt((String) map.get("resultCnt"));
        return new IBSheetListVO<OpenDs>(result, cnt);

    }
	
/*	@RequestMapping("/admin/openinf/opends/popup/opends_samplePop.do")
	public String openDsSamplePop (){
		return "/admin/openinf/opends/popup/opends_samplePop";
	}*/

    /**
     * 데이터샘플 팝업 화면
     *
     * @param openDscol
     * @param model
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/opends/popup/opends_samplePop.do")
    public ModelAndView openInfViewPopUp(OpenDscol openDscol, ModelMap model) {
        ModelAndView modelAndView = new ModelAndView();
        Map<String, Object> map = new HashMap<String, Object>();
        map = openDsService.selectSamplePop(openDscol);
        modelAndView.addObject("result", map.get("result"));
        modelAndView.setViewName("/admin/openinf/opends/popup/opends_samplePop");
        modelAndView.addObject("viewLang", openDscol.getViewLang());
        modelAndView.addObject("openDscol", openDscol);
        return modelAndView;
    }

    /**
     * 데이터샘플 컬럼 목록 조회
     *
     * @param openDscol
     * @param model
     * @return IBSheetListVO<OpenDscol>
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/opends/popup/samplePopList.do")
    @ResponseBody
    public IBSheetListVO<OpenDscol> samplePopList(@ModelAttribute("searchVO") OpenDscol openDscol, ModelMap model) {
        //페이징 처리시 반드시 *IbPaging 메소드명을 사용해야함
        Map<String, Object> map = openDsService.samplePopIbPaging(openDscol);
        model.addAttribute("viewLang", openDscol.getViewLang());
        @SuppressWarnings("unchecked")
        List<OpenDscol> result = (List<OpenDscol>) map.get("resultList");
        int cnt = Integer.parseInt((String) map.get("resultCnt"));
        return new IBSheetListVO<OpenDscol>(result, cnt);
    }


    /**
     * 데이터셋 상세정보, 컬럼 항목 동시 저장
     * @param data
     * @param locale
     * @return IBSResultVO<OpenDscol>
     * @throws Exception
     */
	/*@RequestMapping("/admin/openinf/opends/saveOpenDs.do")
	@ResponseBody
	public IBSResultVO<OpenDscol> saveOpenDsCol(@RequestBody openDscols data, @ModelAttribute OpenDscol saveVO, Locale locale) {
		ArrayList<OpenDscol> list = data.get("data");
		String resmsg;
		int result = 0;
		
		int resultInf = openDsService.dupDsId(saveVO);
		if(resultInf > 0){
			result = -1;
			resmsg = message.getMessage("DUP.SAVE");
		}else{
			result = openDsService.saveOpenDsCUD(list, saveVO);
			if(result > 0) {
				result = 0;
				resmsg = message.getMessage("MSG.SAVE");
			} else {
				result = -1;
				resmsg = message.getMessage("ERR.SAVE");
			}
		}
		return new IBSResultVO<OpenDscol>(saveVO, result, resmsg);
	}*/

    /**
     * DsId 중복확인
     *
     * @param openDscol
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/opends/dupDsId.do")
    @ResponseBody
    public Map<String, Object> dupDsId(OpenDscol openDscol, ModelMap model) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("resultCnt", openDsService.dupDsId(openDscol));
        return map;
    }


    /**
     * 데이터셋 상세정보 저장
     *
     * @param saveVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/opends/saveOpenDs.do")
    @ResponseBody
    public IBSResultVO<OpenDscol> saveOpenDs(@ModelAttribute OpenDscol saveVO, ModelMap model) {
        int result = 0;
        //등록, 변경, 삭제 처리시  등록자, 수정자 Id를 세션에서 가져올 경우 *CUD 메소드명을 사용해야함
        result = openDsService.saveOpenDsDtlCUD(saveVO, WiseOpenConfig.STATUS_I);
        return new IBSResultVO<OpenDscol>(result, messagehelper.getSavaMessage(result), saveVO.getDsId());
    }

    /**
     * 데이터셋 컬럼항목 저장
     *
     * @param data
     * @param locale
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/opends/saveOpenDscol.do")
    @ResponseBody
    public IBSResultVO<OpenDscol> saveOpenDscol(@RequestBody openDscols data, Locale locale) {
        ArrayList<OpenDscol> list = data.get("data");
        int result = openDsService.saveOpenDscolCUD(list);
        String resmsg;
        if (result > 0) {
            result = 0;
            resmsg = message.getMessage("MSG.SAVE");
        } else {
            result = -1;
            resmsg = message.getMessage("ERR.SAVE");
        }

        return new IBSResultVO<OpenDscol>(result, resmsg);

    }

    /**
     * 데이터셋 단건 수정
     *
     * @param openDscol
     * @param model
     * @return IBSResultVO<OpenDscol>
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/opends/updateOpenDs.do")
    @ResponseBody
    public IBSResultVO<OpenDscol> updateOpenDs(@ModelAttribute OpenDscol saveVO, ModelMap model) {
        int result = 0;
        //등록, 변경, 삭제 처리시  등록자, 수정자 Id를 세션에서 가져올 경우 *CUD 메소드명을 사용해야함
        result = openDsService.saveOpenDsDtlCUD(saveVO, WiseOpenConfig.STATUS_U);
        return new IBSResultVO<OpenDscol>(result, messagehelper.getSavaMessage(result));
    }

    /**
     * 데이터셋 컬럼 목록 수정
     *
     * @param data
     * @param locale
     * @return IBSResultVO<OpenDscol>
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/opends/updateOpenDscol.do")
    @ResponseBody
    public IBSResultVO<OpenDscol> updateOpenDscol(@RequestBody openDscols data, Locale locale) {
        ArrayList<OpenDscol> list = data.get("data");
        int result = openDsService.saveOpenDscolCUD(list);
        String resmsg;
        if (result == 100) {
            result = -1;
            resmsg = "테이블 전부 삭제후 다시 추가해 주세요." + "\n" + "중복되었습니다.";
        } else if (result > 0) {
            result = 0;
            resmsg = message.getMessage("MSG.SAVE");
        } else {
            result = -1;
            resmsg = message.getMessage("ERR.SAVE");
        }

        return new IBSResultVO<OpenDscol>(result, resmsg);

    }

    /**
     * 데이터셋 테이블 목록 수정
     *
     * @param data
     * @param locale
     * @return IBSResultVO<OpenDscol>
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/opends/updateOpenDstbl.do")
    @ResponseBody
    public IBSResultVO<OpenDscol> updateOpenDsTable(@RequestBody openDtbls data, Locale locale) {
        ArrayList<OpenDtbl> list = data.get("data");
        int result = openDsService.saveOpenDsTableListCUD(list);
        String resmsg;
        if (result > 0) {
            result = 0;
            resmsg = message.getMessage("MSG.SAVE");
        } else {
            result = -1;
            resmsg = message.getMessage("ERR.SAVE");
        }

        return new IBSResultVO<OpenDscol>(result, resmsg);

    }

    /**
     * 데이터셋 삭제
     *
     * @param saveVO
     * @param model
     * @return IBSResultVO<OpenDscol>
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/opends/deleteOpenDs.do")
    @ResponseBody
    public IBSResultVO<OpenDscol> deleteOpenDt(@ModelAttribute OpenDscol saveVO, ModelMap model) {
        String resmsg;
        int result = 0;

        int resultInf = openDsService.selectOpenCdCheck(saveVO);
        if (resultInf > 0) {
            result = -1;
            resmsg = message.getMessage("ERR.INFCHK");
        } else {
            result = openDsService.saveOpenDsDtlCUD(saveVO, WiseOpenConfig.STATUS_D);
            if (result > 0) {
                result = 0;
                resmsg = message.getMessage("MSG.SAVE");
            } else {
                result = -1;
                resmsg = message.getMessage("ERR.SAVE");
            }
        }
        return new IBSResultVO<OpenDscol>(result, resmsg);
    }

    /**
     * 데이터셋 컬럼 항목 삭제
     *
     * @param data
     * @param locale
     * @return IBSResultVO<OpenDscol>
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/opends/deleteOpenDscol.do")
    @ResponseBody
    public IBSResultVO<OpenDscol> deleteOpenDscol(@RequestBody openDscols data, Locale locale) {
        ArrayList<OpenDscol> list = data.get("data");
        int result = openDsService.saveOpenDscolCUD(list);
        String resmsg;
        if (result > 0) {
            result = 0;
            resmsg = message.getMessage("MSG.SAVE");
        } else {
            result = -1;
            resmsg = message.getMessage("ERR.SAVE");
        }

        return new IBSResultVO<OpenDscol>(result, resmsg);

    }

    /**
     * 데이터셋 테이블 목록 삭제
     *
     * @param data
     * @param locale
     * @return IBSResultVO<OpenDscol>
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/opends/deleteOpenDstbl.do")
    @ResponseBody
    public IBSResultVO<OpenDscol> deleteOpenDsTable(@RequestBody openDtbls data, Locale locale) {
        ArrayList<OpenDtbl> list = data.get("data");
        int result = openDsService.saveOpenDsTableListCUD(list);
        String resmsg;
        if (result > 0) {
            result = 0;
            resmsg = message.getMessage("MSG.SAVE");
        } else {
            result = -1;
            resmsg = message.getMessage("ERR.SAVE");
        }

        return new IBSResultVO<OpenDscol>(result, resmsg);

    }


    /**
     * 관련 데이터셋 팝업 화면을 조회한다.(공표기준등록 및 수정에서 사용)
     *
     * @return String
     */
    @RequestMapping("/admin/openinf/opends/popup/openPubCfgRefDsPopUp.do")
    public String openPubCfgRefDsPopUp() {
        return "/admin/openinf/openpub/popup/openpubcfgrefdspopup";
    }

    /**
     * 관련 데이터셋 리스트 조회(공표기준등록 및 수정에서 사용)
     *
     * @param openDs
     * @param model
     * @return IBSheetListVO<OpenDs>
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/opends/popup/openPubCfgRefDsPopUpList.do")
    @ResponseBody
    public IBSheetListVO<OpenDs> openPubCfgRefDsPopUpListIbPaging(@ModelAttribute("searchVO") OpenDs openDs, ModelMap model) {

        //페이징 처리시 반드시 *IbPaging 메소드명을 사용해야함
        Map<String, Object> map = openDsService.openPubCfgRefDsPopUpListIbPaging(openDs);
        @SuppressWarnings("unchecked")
        List<OpenDs> result = (List<OpenDs>) map.get("resultList");
        int cnt = Integer.parseInt((String) map.get("resultCnt"));
        return new IBSheetListVO<OpenDs>(result, cnt);
    }

    /**
     * 재정용어 팝업 화면
     *
     * @param openDs
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/opends/openDsTermPop.do")
    public ModelAndView openDsTermPop(String sheetNm, String toSeq, OpenDscol openDscol, ModelMap model) {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("/admin/openinf/opends/popup/opendsTermPop");
        modelAndView.addObject("sheetNm", sheetNm);
        modelAndView.addObject("toSeq", toSeq);
        return modelAndView;
    }

    /**
     * 재정용어 팝업 화면 목록 조회
     *
     * @param openDscol
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/opends/openDsTermPopList.do")
    @ResponseBody
    public IBSheetListVO<OpenDscol> openDsTermPopList(@ModelAttribute("searchVO") OpenDscol openDscol, ModelMap model) {
        //페이징 처리시 반드시 *IbPaging 메소드명을 사용해야함
        Map<String, Object> map = openDsService.selectOpenDsTermPopListIbPaging(openDscol);
        @SuppressWarnings("unchecked")
        List<OpenDscol> result = (List<OpenDscol>) map.get("resultList");
        int cnt = Integer.parseInt((String) map.get("resultCnt"));
        return new IBSheetListVO<OpenDscol>(result, cnt);
    }

    /**
     * 데이터 품질 모니터링 화면을 조회한다
     *
     * @return String
     */
    @RequestMapping("/admin/openinf/opends/openDQPage.do")
    public String openDqPage() {
        return "/admin/openinf/opends/opendq";
    }

    /**
     * 개인정보식별 모니터링 화면을 조회한다
     *
     * @return String
     */
    @RequestMapping("/admin/openinf/opends/openIdInfPage.do")
    public String openIdInfPage() {
        return "/admin/openinf/opends/openidinf";
    }


    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // 2017/10/11 - 김정호
    // 	 * 데이터셋 관리 화면 변경(신규 추가된 항목들) [시작]
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////

    /**
     * 데이터셋 컬럼유형정보 조회
     *
     * @param openDscol
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/opends/selectOpenDscoltyCd.do")
    @ResponseBody
    public Map<String, Object> selectOpenDscoltyCd(@ModelAttribute("searchVO") OpenDscol openDscol, ModelMap model) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("data", openDsService.selectOpenDscoltyCd());
        return map;
    }

    /**
     * 공공데이터 관리담당자 목록 조회
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/admin/openinf/opends/openDsUsrList.do")
    public @ResponseBody Map<String, Object> openDsUsrList(HttpServletRequest request) {
        Params params = getParams(request, true);
        Map<String, Object> map = new HashMap<String, Object>();

        List<Record> list = openDsService.selectOpenDsUsrList(params);
        map.put("data", list);
        return map;
    }

    /**
     * 공공데이터 데이터셋 수정
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/openinf/opends/saveOpenDsAll.do")
    public String saveOpenDsAll(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);

        params.set(ACTION_STATUS, ACTION_UPD);    //저장

        Result result = (Result) openDsService.saveOpenDsAll(params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        if (result.getSuccess()) {
            model.addAttribute("success", true);
            model.addAttribute("message", result.get("messages"));
        } else {
            model.addAttribute("error", false);
            model.addAttribute("message", result.get("messages"));
        }

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 공공데이터 데이터셋 신규등록
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/openinf/opends/insertOpenDsAll.do")
    public String insertOpenDsAll(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);

        params.set(ACTION_STATUS, ACTION_INS);    //입력

        Result result = (Result) openDsService.saveOpenDsAll(params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        if (result.getSuccess()) {
            model.addAttribute("success", true);
            model.addAttribute("message", result.get("messages"));
        } else {
            model.addAttribute("error", false);
            model.addAttribute("message", result.get("messages"));
        }

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 공공데이터 데이터셋 삭제
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/openinf/opends/deleteOpenDsAll.do")
    public String deleteOpenDsAll(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);

        params.set(ACTION_STATUS, ACTION_DEL);    //삭제

        Result result = (Result) openDsService.saveOpenDsAll(params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        if (result.getSuccess()) {
            model.addAttribute("success", true);
            model.addAttribute("message", result.get("messages"));
        } else {
            model.addAttribute("error", false);
            model.addAttribute("message", result.get("messages"));
        }

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 데이터셋 테이블이 실제 존재하는지 확인
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/openinf/opends/selectExistSrcDsId.do")
    public @ResponseBody Map<String, Integer> selectExistSrcDsId(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);
        return openDsService.selectExistSrcDsId(params);
    }

    //파라미터 받아서 map 객체에 넣는다
	/*
	private Map<?, ?> addTextParameter(HttpServletRequest request) {
		Map<?, ?> map = new HashMap();
        Enumeration<?> enumeration = request.getParameterNames();
        
        while (enumeration.hasMoreElements()) {
            String name = (String) enumeration.nextElement();
            //map.put(getParameterName(name), getTextParameter(request, name));
            setMapVal(map, getParameterName(name), getTextParameter(request, name));
            
        }
        return map;
    }
	private String getParameterName(String name) {
        if (name.endsWith("[]")) {
            return name.substring(0, name.lastIndexOf("[]"));
        }
        
        return name;
    }
	private String[] getTextParameter(HttpServletRequest request, String name) {
        return request.getParameterValues(name);
    }
	
	public Object setMapVal(Map map, Object key, Object value) {
        if (value instanceof Object[]) {
            Object[] values = (Object[]) value;
            
            if (values.length == 1) {
                return map.put(key, values[0]);
            }
        }
        
        return map.put(key, value);
    }*/
}

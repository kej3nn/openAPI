package egovframework.admin.openinf.web;

/**
 * 분류정보 관리로 이동하는 클래스
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.07.16
 */

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egovframework.admin.openinf.service.OpenPubCfg;
import egovframework.admin.openinf.service.OpenPubCfgService;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.common.WiseOpenConfig;
import egovframework.common.code.service.CodeListService;
import egovframework.common.grid.IBSResultVO;
import egovframework.common.grid.IBSheetListVO;
import egovframework.common.helper.Messagehelper;
import egovframework.common.helper.TABListVo;


@Controller
public class OpenPubCfgController implements InitializingBean {

    protected static final Log logger = LogFactory.getLog(OpenPubCfgController.class);

    //공통코드 사용시 선언
    @Resource
    private CodeListService commCodeListService;

    @Resource(name = "OpenPubCfgService")
    private OpenPubCfgService openPubCfgService;

    static class openPubCfg extends HashMap<String, ArrayList<OpenPubCfg>> {
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
     * 공표기준 설정 화면으로 이동
     *
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/openpub/openPubCfgPage.do")
    public String openPubPage(ModelMap model) {
        //페이지 title을 가져오려면 반드시 *Page로 끝나야한다.
        //Interceptor(PageNavigationInterceptor)에서 조회함
        return "/admin/openinf/openpub/openpubcfg";
    }

    /**
     * 공표기준 목록을 전체 조회한다.
     *
     * @param OpenPubCfg
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/openpub/openPubCfgListAll.do")
    @ResponseBody
    public IBSheetListVO<OpenPubCfg> openPubCfgListAllIbPaging(OpenPubCfg openPubCfg, ModelMap model) {
        //페이징 처리시 반드시 *IbPaging 메소드명을 사용해야함
        Map<String, Object> map = openPubCfgService.openPubCfgListAllIbPaging(openPubCfg);
        @SuppressWarnings("unchecked")
        List<OpenPubCfg> result = (List<OpenPubCfg>) map.get("resultList");
        int cnt = Integer.parseInt((String) map.get("resultCnt"));
        return new IBSheetListVO<OpenPubCfg>(result, cnt);
    }

    /**
     * 관련데이터셋 Id를 중복체크한다.
     *
     * @param openPubCfg
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/openpub/openPubCfgRefDsCheckDup.do")
    @ResponseBody
    public IBSResultVO<OpenPubCfg> openPubCfgRefDsCheckDup(OpenPubCfg openPubCfg, ModelMap model) {
        int result = 0;
        result = openPubCfgService.openPubCfgRefDsCheckDup(openPubCfg);
        return new IBSResultVO<OpenPubCfg>(result, messagehelper.getSavaMessage(result));
    }

    /**
     * 공표기준을 등록한다.
     *
     * @param OpenPubCfg
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/openpub/openPubCfgReg.do")
    @ResponseBody
    public IBSResultVO<OpenPubCfg> openPubCfgReg(OpenPubCfg openPubCfg, ModelMap model) {
        OpenPubCfg openpubcfg = new OpenPubCfg();
        int result = 0;
        //등록, 변경, 삭제 처리시  등록자, 수정자 Id를 세션에서 가져올 경우 *CUD 메소드명을 사용해야함
        openpubcfg = (OpenPubCfg) openPubCfgService.saveOpenPubCfgCUD(openPubCfg, WiseOpenConfig.STATUS_I);
        result = openpubcfg.getRes();
        String msg = openpubcfg.getRetmsg();
        return new IBSResultVO<OpenPubCfg>(result, messagehelper.getSavaMessage2(result, msg));
    }

    /**
     * 공표기준을 단건 조회한다.
     *
     * @param openPubCfg
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/openpub/openPubCfgOne.do")
    @ResponseBody
    public TABListVo<OpenPubCfg> openPubCfgOne(@RequestBody OpenPubCfg OpenPubCfg, ModelMap model) {
        return new TABListVo<OpenPubCfg>(openPubCfgService.selectOpenPubCfgOne(OpenPubCfg));
    }


    /**
     * 공표기준을 수정한다.
     *
     * @param OpenPubCfg
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/openpub/openPubCfgUpd.do")
    @ResponseBody
    public IBSResultVO<OpenPubCfg> openPubCfgUpd(OpenPubCfg openPubCfg, ModelMap model) {
        int result = 0;
        OpenPubCfg openpubcfg = new OpenPubCfg();
        //등록, 변경, 삭제 처리시  등록자, 수정자 Id를 세션에서 가져올 경우 *CUD 메소드명을 사용해야함
        openpubcfg = openPubCfgService.saveOpenPubCfgCUD(openPubCfg, WiseOpenConfig.STATUS_U);
        result = openpubcfg.getRes();
        return new IBSResultVO<OpenPubCfg>(result, messagehelper.getSavaMessage(result));
    }

    /**
     * 공표기준을 삭제한다
     *
     * @param OpenPubCfg
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/openpub/openPubCfgDel.do")
    @ResponseBody
    public IBSResultVO<OpenPubCfg> openPubCfgDel(OpenPubCfg openPubCfg, ModelMap model) {
        int result = 0;
        //등록, 변경, 삭제 처리시  등록자, 수정자 Id를 세션에서 가져올 경우 *CUD 메소드명을 사용해야함
        OpenPubCfg openpubcfg = new OpenPubCfg();
        openpubcfg = openPubCfgService.saveOpenPubCfgCUD(openPubCfg, WiseOpenConfig.STATUS_D);
        result = openpubcfg.getRes();
        return new IBSResultVO<OpenPubCfg>(result, messagehelper.getSavaMessage(result));
    }

    /**
     * 공표기준 컬럼 list를 조회한다.
     *
     * @param openPubCfg
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/openpub/selectRefColId.do")
    @ResponseBody
    public TABListVo<OpenPubCfg> selectRefColId(OpenPubCfg openPubCfg, ModelMap model) {
        return new TABListVo<OpenPubCfg>(openPubCfgService.selectRefColId(openPubCfg));
    }


}

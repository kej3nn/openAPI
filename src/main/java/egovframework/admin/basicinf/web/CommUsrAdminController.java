package egovframework.admin.basicinf.web;

/**
 * 담당자관리 Controller
 *
 * @author KJH
 * @since 2014.07.23
 */

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
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.admin.basicinf.service.CommCode;
import egovframework.admin.basicinf.service.CommUsrAdmin;
import egovframework.admin.basicinf.service.CommUsrAdminService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.WiseOpenConfig;
import egovframework.common.code.service.CodeListService;
import egovframework.common.grid.IBSResultVO;
import egovframework.common.grid.IBSheetListVO;
import egovframework.common.helper.Messagehelper;
import egovframework.common.helper.TABListVo;
import egovframework.common.util.UtilJson;


@Controller
public class CommUsrAdminController implements InitializingBean {

    protected static final Log logger = LogFactory.getLog(CommUsrAdminController.class);

    //공통코드 사용시 선언
    @Resource
    private CodeListService commCodeListService;

    @Resource(name = "CommUsrAdminService")
    private CommUsrAdminService commUsrAdminService;

    //공통 메시지 사용시 선언
    @Resource
    Messagehelper messagehelper;


    public void afterPropertiesSet() {

    }

    /**
     * 공통코드를 조회 한다.
     * @return
     * @throws Exception
     */
    @ModelAttribute("codeMap")
    public Map<String, Object> getcodeMap() {
        Map<String, Object> codeMap = new HashMap<String, Object>();
        try {
            codeMap.put("accCdIbs", UtilJson.convertJsonString(commCodeListService.getCodeListIBS("C1002")));//관리자권한 ibSheet
            codeMap.put("accCd", commCodeListService.getCodeList("C1002")); //관리자권한 select box
            codeMap.put("jobCd", commCodeListService.getCodeList("C1003")); //직원직책 select box

            codeMap.put("orgCdIbs", UtilJson.convertJsonString(commCodeListService.getEntityCodeListIBS("ORG_CD")));//조직코드 ibSheet

            codeMap.put("jobCdIbs", UtilJson.convertJsonString(commCodeListService.getCodeListIBS("C1003", true)));
            codeMap.put("notiHhCd", commCodeListService.getCodeList("C1025")); // 알림시간 select box

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return codeMap;
    }


    /**
     * 사용자 조회화면으로 이동한다.
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/basicinf/commUsrAdminPage.do")
    public String commUsrPage(ModelMap model) {
        //페이지 title을 가져오려면 반드시 *Page로 끝나야한다.
        //Interceptor(PageNavigationInterceptor)에서 조회함
        return "/admin/basicinf/commusrAdmin";
    }


    /**
     * 사용자를 전체 조회한다.
     * @param commUsr
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/basicinf/commUsrAdminListAll.do")
    @ResponseBody
    public IBSheetListVO<CommCode> commUsrListAll(@ModelAttribute("searchVO") CommUsrAdmin commUsrAdmin, ModelMap model) {
        //페이징 처리시 반드시 *IbPaging 메소드명을 사용해야함
        Map<String, Object> map = commUsrAdminService.selectCommUsrAdminAllIbPaging(commUsrAdmin);
        @SuppressWarnings("unchecked")
        List<CommCode> result = (List<CommCode>) map.get("resultList");
        int cnt = Integer.parseInt((String) map.get("resultCnt"));
        return new IBSheetListVO<CommCode>(result, cnt);
    }

    /**
     * 직원검색 팝업페이지이동
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/basicinf/popup/commUsr_pop.do")
    public String commUsr_popPage(ModelMap model) {
        return "/admin/basicinf/popup/commusr_pop";
    }

    /**
     * 직원검색(직책포함) 팝업페이지이동
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/basicinf/popup/commUsrPos_pop.do")
    public String commUsrPos_popPage(ModelMap model) {
        return "/admin/basicinf/popup/commusrPos_pop";
    }

    /**
     * 직원 팝업검색
     * @param commUsrAdmin
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/basicinf/popup/commUsrAdminPopList.do")
    @ResponseBody
    public IBSheetListVO<CommCode> commUsrPopList(@ModelAttribute("searchVO") CommUsrAdmin commUsrAdmin, ModelMap model) {
        //페이징 처리시 반드시 *IbPaging 메소드명을 사용해야함
        Map<String, Object> map = commUsrAdminService.selectCommUsrAdminPopIbPaging(commUsrAdmin);
        @SuppressWarnings("unchecked")
        List<CommCode> result = (List<CommCode>) map.get("resultList");
        return new IBSheetListVO<CommCode>(result, result.size());
    }

    /**
     * 직원 팝업검색(직책 포함) commusrPos_pop.jsp
     * @param commUsrAdmin
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/basicinf/popup/commUsrAdminPosPopList.do")
    @ResponseBody
    public IBSheetListVO<CommCode> commUsrPosPopList(@ModelAttribute("searchVO") CommUsrAdmin commUsrAdmin, ModelMap model) {
        //페이징 처리시 반드시 *IbPaging 메소드명을 사용해야함
        Map<String, Object> map = commUsrAdminService.selectCommUsrAdminPosPopIbPaging(commUsrAdmin);
        @SuppressWarnings("unchecked")
        List<CommCode> result = (List<CommCode>) map.get("resultList");
        return new IBSheetListVO<CommCode>(result, result.size());
    }

    /**
     * 사용자 단건 조회(폼 방식)
     * @param commUsrAdmin
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/basicinf/commUsrAdminDtlInfo.do")
    @ResponseBody
    public TABListVo<CommUsrAdmin> commUsrAdminDtlInfo(CommUsrAdmin commUsrAdmin, ModelMap model) {
        return new TABListVo<CommUsrAdmin>(commUsrAdminService.selectCommUsrAdminDtlInfo(commUsrAdmin));
    }

    /**
     * 사용자 단건 조회(Json방식)
     * @param commUsrAdmin
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/basicinf/commUsrAdminDtlTabInfo.do")
    @ResponseBody
    public TABListVo<CommUsrAdmin> commUsrAdminDtTablInfo(@RequestBody CommUsrAdmin commUsrAdmin, ModelMap model) {
        return new TABListVo<CommUsrAdmin>(commUsrAdminService.selectCommUsrAdminDtlInfo(commUsrAdmin));
    }

    /**
     * 담당자관리 신규입력(승인도 동시에 처리)
     * @param commUsrAdmin
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/basicinf/commUsrAdminSave.do")
    @ResponseBody
    public IBSResultVO<CommUsrAdmin> commUsrAdminInsSave(@ModelAttribute("regVO") CommUsrAdmin commUsrAdmin, ModelMap model) {
        int result = 0;

        if (commUsrAdmin != null && commUsrAdmin.getUsrPw() != null) {
            result = commUsrAdminService.saveCommUsrAdminCUD(commUsrAdmin, WiseOpenConfig.STATUS_I);
        }

        return new IBSResultVO<CommUsrAdmin>(result, messagehelper.getSavaMessage(result));
    }

    /**
     * 담당자관리 내용수정
     * @param commUsrAdmin
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/basicinf/commUsrAdminUpd.do")
    @ResponseBody
    public IBSResultVO<CommUsrAdmin> commUsrAdminInsUpd(@ModelAttribute("regVO") CommUsrAdmin commUsrAdmin, ModelMap model) {
        int result = 0;

        if (commUsrAdmin != null) {
            result = commUsrAdminService.saveCommUsrAdminCUD(commUsrAdmin, WiseOpenConfig.STATUS_U);
        }
        return new IBSResultVO<CommUsrAdmin>(result, messagehelper.getSavaMessage(result));
    }

    /**
     * 담당자 승인
     * @param commUsrAdmin
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/basicinf/commUsrAdminAppr.do")
    @ResponseBody
    public IBSResultVO<CommUsrAdmin> commUsrAdminAppr(@ModelAttribute("regVO") CommUsrAdmin commUsrAdmin, ModelMap model) {
        int result = 0;
        result = commUsrAdminService.commUsrAdminAppr(commUsrAdmin, "A");
        return new IBSResultVO<CommUsrAdmin>(result, messagehelper.getSavaMessage(result));
    }

    /**
     * 담당자 승인취소
     * @param commUsrAdmin
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/basicinf/commUsrAdminApprCancel.do")
    @ResponseBody
    public IBSResultVO<CommUsrAdmin> commUsrAdminApprCancel(@ModelAttribute("regVO") CommUsrAdmin commUsrAdmin, ModelMap model) {
        int result = 0;
        result = commUsrAdminService.commUsrAdminAppr(commUsrAdmin, "C");
        return new IBSResultVO<CommUsrAdmin>(result, messagehelper.getSavaMessage(result));
    }

    /**
     * 담당자ID 중복체크
     * @param commUsrAdmin
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/basicinf/commUsrAdminUsrIdDup.do")
    @ResponseBody
    public IBSResultVO<CommUsrAdmin> commUsrAdminUsrIdDup(CommUsrAdmin commUsrAdmin, ModelMap model) {
        int result = 0;
        result = commUsrAdminService.commUsrAdminUsrIdDup(commUsrAdmin);
        return new IBSResultVO<CommUsrAdmin>(result, messagehelper.getSavaMessage(result));
    }

    /**
     * 비밀번호 초기화
     * @param commUsrAdmin
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/basicinf/commUsrAdminInitialPw.do")
    @ResponseBody
    public TABListVo<CommUsrAdmin> commUsrAdminInitialPw(CommUsrAdmin commUsrAdmin, ModelMap model) {
        TABListVo<CommUsrAdmin> tmp = new TABListVo<CommUsrAdmin>(commUsrAdminService.commUsrAdminInitialPw(commUsrAdmin));
        //return new TABListVo<CommUsrAdmin>(commUsrAdminService.selectCommUsrAdminDtlInfo(commUsrAdmin));
        return tmp;
    }
}

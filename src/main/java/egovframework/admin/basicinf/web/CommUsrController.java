package egovframework.admin.basicinf.web;

/**
 * 사용자 페이지로 이동하는 클래스
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.admin.basicinf.service.CommCode;
import egovframework.admin.basicinf.service.CommUsr;
import egovframework.admin.basicinf.service.CommUsrService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.WiseOpenConfig;
import egovframework.common.code.service.CodeListService;
import egovframework.common.grid.IBSResultVO;
import egovframework.common.grid.IBSheetListVO;
import egovframework.common.helper.Messagehelper;
import egovframework.common.util.UtilJson;


@Controller
public class CommUsrController implements InitializingBean {

    protected static final Log logger = LogFactory.getLog(CommUsrController.class);

    //공통코드 사용시 선언
    @Resource
    private CodeListService commCodeListService;

    @Resource(name = "CommUsrService")
    private CommUsrService commUsrService;

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
            codeMap.put("usrTel", commCodeListService.getCodeList("C1008")); //전화번호(집)
            codeMap.put("usrHp", commCodeListService.getCodeList("C1007")); //휴대폰 연락처
            codeMap.put("notiHhCd", commCodeListService.getCodeList("C1025")); //알림시간 select box

            codeMap.put("orgCdIbs", UtilJson.convertJsonString(commCodeListService.getEntityCodeListIBS("ORG_CD")));//조직코드 ibSheet


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
    @RequestMapping("/admin/basicinf/commUsrPage.do")
    public String commUsrPage(ModelMap model) {
        //페이지 title을 가져오려면 반드시 *Page로 끝나야한다.
        //Interceptor(PageNavigationInterceptor)에서 조회함
        return "/admin/basicinf/commusr";
    }


    /**
     * 사용자를 전체 조회한다.
     * @param commUsr
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/basicinf/commUsrListAll.do")
    @ResponseBody
    public IBSheetListVO<CommCode> commUsrListAll(@ModelAttribute("searchVO") CommUsr commUsr, ModelMap model) {
        //페이징 처리시 반드시 *IbPaging 메소드명을 사용해야함
        Map<String, Object> map = commUsrService.selectCommUsrAllIbPaging(commUsr);
        @SuppressWarnings("unchecked")
        List<CommCode> result = (List<CommCode>) map.get("resultList");
        int cnt = Integer.parseInt((String) map.get("resultCnt"));
        return new IBSheetListVO<CommCode>(result, cnt); //막은이유는 sheet조회하여 우측하단부분에 총개수를 표현하는데 size()로 대체가능하다.
//		return new IBSheetListVO<CommCode>(result, result.size());
    }

    /**
     * 사용자를 단건 조회한다.
     * @param commUsr
     * @param model
     * @return
     * @throws Exception
     */
	/*@RequestMapping("/admin/basicinf/commUsrList.do")
	@ResponseBody
	public TABListVo<CommUsr> commUsrList(@RequestBody CommUsr commUsr, ModelMap model){
		return new TABListVo<CommUsr>(commUsrService.selectCommUsr(commUsr));
	}*/

    /**
     * 사용자를 단건 조회한다.
     * @param commUsr
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/basicinf/commUsrList.do")
    @ResponseBody
    public Map<String, Object> openInfList(CommUsr commUsr, ModelMap model) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("DATA", commUsrService.selectCommUsr(commUsr));
        return map;
    }

    /**
     * 사용자를  등록한다.
     * @param commUsr
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/basicinf/commUsrReg.do")
    @ResponseBody
    public IBSResultVO<CommUsr> commUsrReg(@ModelAttribute("regVO") CommUsr commUsr, ModelMap model) {
        int result = 0;
        logger.debug(commUsr.getUsrNm());
        result = commUsrService.saveCommUsrCUD(commUsr, WiseOpenConfig.STATUS_I);
        return new IBSResultVO<CommUsr>(result, messagehelper.getSavaMessage(result));
    }

    /**
     * 사용자를  수정한다.
     * @param commUsr
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/basicinf/commUsrUpd.do")
    @ResponseBody
    public IBSResultVO<CommUsr> commUsrUpd(@ModelAttribute("regVO") CommUsr commUsr, ModelMap model) {
        int result = 0;
        result = commUsrService.saveCommUsrCUD(commUsr, WiseOpenConfig.STATUS_U);
        return new IBSResultVO<CommUsr>(result, messagehelper.getSavaMessage(result));
    }

    /**
     * 사용자를  삭제한다.
     * @param commUsr
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/basicinf/commUsrDel.do")
    @ResponseBody
    public IBSResultVO<CommUsr> commUsrDel(@ModelAttribute("regVO") CommUsr commUsr, ModelMap model) {
        int result = 0;
        result = commUsrService.saveCommUsrCUD(commUsr, WiseOpenConfig.STATUS_D);
        //등록, 변경, 삭제 처리시  등록자, 수정자 Id를 세션에서 가져올 경우 *CUD 메소드명을 사용해야함
        return new IBSResultVO<CommUsr>(result, messagehelper.getSavaMessage(result));
    }

}

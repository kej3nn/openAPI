package egovframework.admin.basicinf.web;

/**
 * 코드 페이지로 이동하는 클래스
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */

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

import egovframework.admin.basicinf.service.CommCode;
import egovframework.admin.basicinf.service.CommCodeService;
import egovframework.admin.basicinf.service.CommMenuAcc;
import egovframework.admin.basicinf.service.CommMenuAccService;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.code.service.CodeListService;
import egovframework.common.grid.IBSResultVO;
import egovframework.common.grid.IBSheetListVO;
import egovframework.common.helper.Messagehelper;
import egovframework.common.util.UtilJson;


@Controller
public class CommMenuAccController implements InitializingBean {

    protected static final Log logger = LogFactory.getLog(CommMenuAccController.class);

    @Resource
    private CodeListService commCodeListService;

    @Resource(name = "CommCodeService")
    private CommCodeService commCodeService;

    @Resource(name = "CommMenuAccService")
    private CommMenuAccService commMenuAccService;

    //공통 메시지 사용시 선언
    @Resource
    Messagehelper messagehelper;

    @Resource
    EgovMessageSource message;

    static class commMenuAccs extends HashMap<String, ArrayList<CommMenuAcc>> {
    }


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
            // 메뉴 권한그룹
            //codeMap.put("menuGrpCdIbs", UtilJson.convertJsonString(commCodeListService.getCodeListIBS("C1002")));
            codeMap.put("menuGrpCd", commCodeListService.getCodeList("C1002")); //OWNER코드 select box

            codeMap.put("accCd", commCodeListService.getCodeList("C1019")); //권한코드 select box
            codeMap.put("accCdIbs", UtilJson.convertJsonString(commCodeListService.getCodeListIBS("C1019")));    //권한코드 IBS


        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return codeMap;
    }

    /**
     * 메뉴관리 화면으로 이동한다.
     */
    @RequestMapping("/admin/basicinf/commMenuAccPage.do")
    public String commcodePage(ModelMap model) {
        //return "admin/basicinf/commcode";
        CommCode commCode = new CommCode();
        commCode.setGrpCd("C1016");
        Map<String, Object> map = commCodeService.commCodeListAllIbPaging(commCode);
        List<CommCode> result = (List<CommCode>) map.get("resultList");

        model.addAttribute("commMenu", result);
        return "admin/basicinf/commmenuAcc";
    }


    /**
     * 리스트 조회
     * @param commMenuAcc
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/basicinf/commMenuAccRetr.do")
    @ResponseBody
    public IBSheetListVO<CommMenuAcc> commcodeList(@ModelAttribute("searchVO") CommMenuAcc commMenuAcc, ModelMap model) {
        Map<String, Object> map = commMenuAccService.selectMenuListIbPaging(commMenuAcc);
        @SuppressWarnings("unchecked")
        List<CommMenuAcc> result = (List<CommMenuAcc>) map.get("resultList");
        int cnt = Integer.parseInt((String) map.get("resultCnt"));
        return new IBSheetListVO<CommMenuAcc>(result, cnt);
    }


    /**
     * 목록 저장
     * @param data
     * @param locale
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/basicinf/updateCommMenuAcc.do")
    @ResponseBody
    public IBSResultVO<CommMenuAcc> updateCommMenuAcc(@RequestBody commMenuAccs data, Locale locale) {
        ArrayList<CommMenuAcc> list = data.get("data");
        int result = commMenuAccService.updateCommMenuAccCUD(list);
        String resmsg;

        if (result > 0) {
            result = 0;
            resmsg = message.getMessage("MSG.SAVE");
        } else {
            result = -1;
            resmsg = message.getMessage("ERR.SAVE");
        }

        return new IBSResultVO<CommMenuAcc>(result, resmsg);

    }

}

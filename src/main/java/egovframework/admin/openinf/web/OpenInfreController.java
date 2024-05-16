package egovframework.admin.openinf.web;

/**
 * 사용자 페이지로 이동하는 클래스
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
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egovframework.admin.basicinf.service.CommMenuService;
import egovframework.admin.opendt.service.OpenCate;
import egovframework.admin.openinf.service.OpenInf;
import egovframework.admin.openinf.service.OpenInfRe;
import egovframework.admin.openinf.service.OpenInfReService;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.common.WiseOpenConfig;
import egovframework.common.code.service.CodeListService;
import egovframework.common.grid.IBSResultVO;
import egovframework.common.grid.IBSheetListVO;
import egovframework.common.helper.Messagehelper;
import egovframework.common.helper.TABListVo;
import egovframework.common.util.UtilJson;


@Controller
public class OpenInfreController implements InitializingBean {

    protected static final Log logger = LogFactory.getLog(OpenInfreController.class);

    static class openInfRe extends HashMap<String, ArrayList<OpenInfRe>> {
    }

    //공통코드 사용시 선언
    @Resource
    private CodeListService commCodeListService;


    //공통 메시지 사용시 선언
    @Resource
    Messagehelper messagehelper;

    @Resource
    EgovMessageSource message;


    @Resource(name = "OpenInfReService")
    private OpenInfReService openInfReService;

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

        return codeMap;
    }


    /**
     * 댓글 조회화면으로 이동한다.
     *
     * @param model
     * @return String
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/openInfRePage.do")
    public String openInfRePage(ModelMap model) {
        //페이지 title을 가져오려면 반드시 *Page로 끝나야한다.
        //Interceptor(PageNavigationInterceptor)에서 조회함
        return "/admin/openinf/openinfre";
    }


    /**
     * 댓글을 전체 조회한다.
     *
     * @param openInf
     * @param model
     * @return IBSheetListVO<OpenInfRe>
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/openInfReListAll.do")
    @ResponseBody
    public IBSheetListVO<OpenInfRe> openInfListAll(OpenInfRe openInfRe, ModelMap model) {
        List<OpenInfRe> list = openInfReService.openInfReListAll(openInfRe);
        return new IBSheetListVO<OpenInfRe>(list, list.size());
    }

    /**
     * 댓글 사용 수정
     *
     * @param openInfRe
     * @param locale
     * @return IBSResultVO<OpenInfRe>
     * @throws Exception
     */
    @RequestMapping("/admin/user/updateOpenInfRe.do")
    @ResponseBody
    public IBSResultVO<OpenInfRe> updateOpenInfRe(@RequestBody openInfRe openInfRe, Locale locale) {
        ArrayList<OpenInfRe> list = openInfRe.get("data");
        int result = openInfReService.updateOpenInfReCUD(list);
        String resmsg;
        if (result > 0) {
            result = 0;
            resmsg = message.getMessage("MSG.SAVE");
        } else {
            result = -1;
            resmsg = message.getMessage("ERR.SAVE");
        }

        return new IBSResultVO<OpenInfRe>(result, resmsg);

    }

}

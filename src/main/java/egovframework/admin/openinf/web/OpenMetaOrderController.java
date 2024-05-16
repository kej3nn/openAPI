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

import egovframework.admin.opendt.service.OpenCateService;
import egovframework.admin.openinf.service.OpenMetaOrder;
import egovframework.admin.openinf.service.OpenMetaOrderService;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.code.service.CodeListService;
import egovframework.common.grid.IBSResultVO;
import egovframework.common.grid.IBSheetListVO;
import egovframework.common.helper.Messagehelper;


@Controller
public class OpenMetaOrderController implements InitializingBean {

    protected static final Log logger = LogFactory.getLog(OpenMetaOrderController.class);

    //공통코드 사용시 선언
    @Resource
    private CodeListService commCodeListService;

    @Resource(name = "OpenMetaOrderService")
    private OpenMetaOrderService openMetaOrderService;

    static class openMetaOrder extends HashMap<String, ArrayList<OpenMetaOrder>> {
    }

    //공통 메시지 사용시 선언
    @Resource
    Messagehelper messagehelper;

    @Resource
    EgovMessageSource message;


    public void afterPropertiesSet() {

    }

    @Resource(name = "OpenCateService")
    private OpenCateService openCateService;

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
            //codeMap.put("dsCd", commCodeListService.getCodeList("D1024")); //데이터셋구분 select box
            codeMap.put("cateTop", openCateService.selectOpenCateTop());//분류정보 ibSheet
            codeMap.put("themeCd", commCodeListService.getCodeList("D1105"));
            codeMap.put("saCd", commCodeListService.getCodeList("D1106"));

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return codeMap;
    }

    /**
     * 메타순서관리 조회화면으로 이동한다..
     *
     * @param model
     * @return String
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/openMetaOrderPage.do")
    public String openMetaOrderPage(ModelMap model) {
        //페이지 title을 가져오려면 반드시 *Page로 끝나야한다.
        //Interceptor(PageNavigationInterceptor)에서 조회함
        return "/admin/openinf/openmetaorder";
    }


    /**
     * 메타순서를 전체 조회한다.
     *
     * @param OpenMetaOrder
     * @param model
     * @return IBSheetListVO<OpenMetaOrder>
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/openMetaOrderPageListAllMainTree.do")
    @ResponseBody
    public IBSheetListVO<OpenMetaOrder> openMetaOrderPageListAllMainTreeIbPaging(OpenMetaOrder openMetaOrder, ModelMap model) {
        //페이징 처리시 반드시 *IbPaging 메소드명을 사용해야함
        Map<String, Object> map = openMetaOrderService.selectOpenMetaOrderPageListAllMainTreeIbPaging(openMetaOrder);
        @SuppressWarnings("unchecked")
        List<OpenMetaOrder> result = (List<OpenMetaOrder>) map.get("resultList");
        int cnt = Integer.parseInt((String) map.get("resultCnt"));
        return new IBSheetListVO<OpenMetaOrder>(result, cnt);
    }


    /**
     * 메타순서 변경을 저장한다.
     *
     * @param OpenMetaOrder
     * @param locale
     * @return IBSResultVO<OpenMetaOrder>
     * @throws Exception
     */
    @RequestMapping("/admin/openinf/openMetaOrderBySave.do")
    @ResponseBody
    public IBSResultVO<OpenMetaOrder> openMetaOrderBySave(@RequestBody openMetaOrder data, Locale locale) {
        ArrayList<OpenMetaOrder> list = data.get("data");
        int result = openMetaOrderService.openMetaOrderBySave(list);
        return new IBSResultVO<OpenMetaOrder>(result, messagehelper.getSavaMessage(result));
    }


}

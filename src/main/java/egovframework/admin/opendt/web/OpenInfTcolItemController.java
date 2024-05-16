package egovframework.admin.opendt.web;

/**
 * 통계황목 관리로 이동하는 클래스
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
import org.springframework.web.servlet.ModelAndView;

import egovframework.admin.opendt.service.OpenInfTcolItem;
import egovframework.admin.opendt.service.OpenInfTcolItemService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.WiseOpenConfig;
import egovframework.common.code.service.CodeListService;
import egovframework.common.grid.IBSResultVO;
import egovframework.common.grid.IBSheetListVO;
import egovframework.common.helper.Messagehelper;
import egovframework.common.helper.TABListVo;
import egovframework.common.util.UtilJson;


@Controller
public class OpenInfTcolItemController implements InitializingBean {

    protected static final Log logger = LogFactory.getLog(OpenInfTcolItemController.class);

    //공통코드 사용시 선언
    @Resource
    private CodeListService commCodeListService;

    @Resource(name = "OpenInfTcolItemService")
    private OpenInfTcolItemService openInfTcolItemService;

    static class openInfTcolItems extends HashMap<String, ArrayList<OpenInfTcolItem>> {
    }

    //공통 메시지 사용시 선언
    @Resource
    Messagehelper messagehelper;


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
            codeMap.put("unitCd", commCodeListService.getCodeList("D1031"));

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return codeMap;
    }

    /**
     * 통계항목 관리 조회화면으로 이동한다.
     *
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/opendt/openInfTcolItemPage.do")
    public String infTcolItemPage(ModelMap model) {
        //페이지 title을 가져오려면 반드시 *Page로 끝나야한다.
        //Interceptor(PageNavigationInterceptor)에서 조회함
        return "/admin/opendt/openinftcolitem";
    }


    /**
     * 통계항목 상위를 전체 조회한다.
     *
     * @param openInfTcolItem
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/opendt/openInfTcolItemParListAll.do")
    @ResponseBody
    public IBSheetListVO<OpenInfTcolItem> openInfTcolItemParListAll(OpenInfTcolItem openInfTcolItem, ModelMap model) {
        //페이징 처리시 반드시 *IbPaging 메소드명을 사용해야함
        Map<String, Object> map = openInfTcolItemService.selectInfTcolItemParAllIbPaging(openInfTcolItem);
        @SuppressWarnings("unchecked")
        List<OpenInfTcolItem> result = (List<OpenInfTcolItem>) map.get("resultList");
        int cnt = Integer.parseInt((String) map.get("resultCnt"));
        return new IBSheetListVO<OpenInfTcolItem>(result, cnt);
    }

    /**
     * 통계항목 상위를 저장한다.
     *
     * @param openInfTcolItems
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/opendt/openInfTcolItemParSave.do")
    @ResponseBody
    public IBSResultVO<OpenInfTcolItem> infTcolItemParSave(@RequestBody openInfTcolItems data, Locale locale) {
        ArrayList<OpenInfTcolItem> list = data.get("data");
        int result = openInfTcolItemService.infTcolItemParSaveCUD(list);
        return new IBSResultVO<OpenInfTcolItem>(result, messagehelper.getSavaMessage(result));
    }

    /**
     * 통계항목 상위를 삭제한다.
     *
     * @param openInfTcolItems
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/opendt/openInfTcolItemParDel.do")
    @ResponseBody
    public IBSResultVO<OpenInfTcolItem> infTcolItemParDelete(@RequestBody OpenInfTcolItem openInfTcolItem, Locale locale) {
        int result = openInfTcolItemService.infTcolItemParDeleteCUD(openInfTcolItem);
        return new IBSResultVO<OpenInfTcolItem>(result, messagehelper.getSavaMessage(result));
    }

    /**
     * 통계항목 트리를 조회한다.
     *
     * @param openInfTcolItem
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/opendt/openInfTcolItemListTree.do")
    @ResponseBody
    public IBSheetListVO<OpenInfTcolItem> openInfTcolItemListTree(OpenInfTcolItem openInfTcolItem, ModelMap model) {
        //페이징 처리시 반드시 *IbPaging 메소드명을 사용해야함
        Map<String, Object> map = openInfTcolItemService.openInfTcolItemListTree(openInfTcolItem);
        @SuppressWarnings("unchecked")
        List<OpenInfTcolItem> result = (List<OpenInfTcolItem>) map.get("resultList");
        return new IBSheetListVO<OpenInfTcolItem>(result, result.size());
    }

    /**
     * 통계항목 상위를 순서를 저장한다.
     *
     * @param openInfTcolItems
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/opendt/openInfTcolItemOrderBySave.do")
    @ResponseBody
    public IBSResultVO<OpenInfTcolItem> openInfTcolItemOrderBySave(@RequestBody openInfTcolItems data, Locale locale) {
        ArrayList<OpenInfTcolItem> list = data.get("data");
        int result = openInfTcolItemService.infTcolItemOrderBySaveCUD(list);
        return new IBSResultVO<OpenInfTcolItem>(result, messagehelper.getSavaMessage(result));
    }

    /**
     * 통계항목을 등록한다.
     *
     * @param openInfTcolItem
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/opendt/openInfTcolItemReg.do")
    @ResponseBody
    public IBSResultVO<OpenInfTcolItem> openInfTcolItemReg(OpenInfTcolItem openInfTcolItem, ModelMap model) {
        int result = 0;
        //등록, 변경, 삭제 처리시  등록자, 수정자 Id를 세션에서 가져올 경우 *CUD 메소드명을 사용해야함
        result = openInfTcolItemService.saveOpenInfTcolItemCUD(openInfTcolItem, WiseOpenConfig.STATUS_I);
        return new IBSResultVO<OpenInfTcolItem>(result, messagehelper.getSavaMessage(result));
    }

    /**
     * 통계항목를 단건 조회한다.
     *
     * @param openInfTcolItem
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/opendt/openInfTcolItemList.do")
    @ResponseBody
    public TABListVo<OpenInfTcolItem> openInfTcolItemList(@RequestBody OpenInfTcolItem openInfTcolItem, ModelMap model) {
        return new TABListVo<OpenInfTcolItem>(openInfTcolItemService.selectOpenInfTcolItem(openInfTcolItem));
    }

    /**
     * 통계항목을 변경한다.
     *
     * @param openInfTcolItem
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/opendt/openInfTcolItemUpd.do")
    @ResponseBody
    public IBSResultVO<OpenInfTcolItem> openInfTcolItemUpd(OpenInfTcolItem openInfTcolItem, ModelMap model) {
        int result = 0;
        //등록, 변경, 삭제 처리시  등록자, 수정자 Id를 세션에서 가져올 경우 *CUD 메소드명을 사용해야함
        result = openInfTcolItemService.saveOpenInfTcolItemCUD(openInfTcolItem, WiseOpenConfig.STATUS_U);
        return new IBSResultVO<OpenInfTcolItem>(result, messagehelper.getSavaMessage(result));
    }

    /**
     * 통계항목을 삭제한다.
     *
     * @param openInfTcolItem
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/opendt/openInfTcolItemDel.do")
    @ResponseBody
    public IBSResultVO<OpenInfTcolItem> openInfTcolItemDel(OpenInfTcolItem openInfTcolItem, ModelMap model) {
        int result = 0;
        //등록, 변경, 삭제 처리시  등록자, 수정자 Id를 세션에서 가져올 경우 *CUD 메소드명을 사용해야함
        result = openInfTcolItemService.saveOpenInfTcolItemCUD(openInfTcolItem, WiseOpenConfig.STATUS_D);
        return new IBSResultVO<OpenInfTcolItem>(result, messagehelper.getSavaMessage(result));
    }

    /**
     * 통계항목의 코드항목 중복 체크를한다.
     *
     * @param openInfTcolItem
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/opendt/openInfTcolItemDup.do")
    @ResponseBody
    public IBSResultVO<OpenInfTcolItem> openInfTcolItemDup(OpenInfTcolItem openInfTcolItem, ModelMap model) {
        int result = 0;
        result = openInfTcolItemService.openInfTcolItemDup(openInfTcolItem);
        return new IBSResultVO<OpenInfTcolItem>(result, messagehelper.getSavaMessage(result));
    }

    /**
     * 보유데이터 팝업화면으로 이동한다.
     *
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/opendt/openDtPopUp.do")
    public String openDtPopUp(ModelMap model) {
        return "/admin/opendt/popup/opendtpopup";
    }

    @RequestMapping("/admin/opendt/selectUnitCd.do")
    @ResponseBody
    public Map<String, Object> selectUnitCd(String unitCd) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            map.put("unitSubCd", commCodeListService.getEntityCodeList("UNIT_SUB_CD", unitCd));//기본값

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return map;
    }

    @RequestMapping("/admin/opendt/selectParUnitCd.do")
    @ResponseBody
    public TABListVo<OpenInfTcolItem> selectParUnitCd(OpenInfTcolItem openInfTcolItem) {
        openInfTcolItem.setItemCd(openInfTcolItem.getItemCdPar());
        return new TABListVo<OpenInfTcolItem>(openInfTcolItemService.selectOpenInfTcolItem(openInfTcolItem));
    }
}



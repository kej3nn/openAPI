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
import javax.servlet.http.HttpServletRequest;

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

import egovframework.admin.basicinf.service.CommCode;
import egovframework.admin.basicinf.service.CommCodeService;
import egovframework.admin.basicinf.service.CommMenu;
import egovframework.admin.basicinf.service.CommMenuService;
import egovframework.admin.basicinf.service.CommUsr;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.common.WiseOpenConfig;
import egovframework.common.code.service.CodeListService;
import egovframework.common.grid.IBSResultVO;
import egovframework.common.grid.IBSheetListVO;
import egovframework.common.helper.Messagehelper;
import egovframework.common.helper.TABListVo;


@Controller
public class CommMenuController implements InitializingBean {

    protected static final Log logger = LogFactory.getLog(CommMenuController.class);

    @Resource
    private CodeListService commCodeListService;

    @Resource(name = "CommCodeService")
    private CommCodeService commCodeService;

    @Resource(name = "CommMenuService")
    private CommMenuService commMenuService;

    //공통 메시지 사용시 선언
    @Resource
    Messagehelper messagehelper;

    @Resource
    EgovMessageSource message;

    static class commMenus extends HashMap<String, ArrayList<CommMenu>> {
    }


    public void afterPropertiesSet() {


    }

    /*
     *//**
     * 공통코드를 조회한다.
     * @return
     * @throws Exception
     *//*
	@ModelAttribute("codeMap")
	public Map<String, Object> getcodeMap(){

		codeMap = new HashMap<String, Object>();
		codeMap.put("A0000Ibs", UtilJson.convertJsonString(commCodeListService.getCodeListIBS("A0000")));
		return codeMap;
	}
	*/

    /**
     * 메뉴관리 화면으로 이동한다.
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/basicinf/commMenuPage.do")
    public String commcodePage(ModelMap model) {
        //return "admin/basicinf/commcode";
        CommCode commCode = new CommCode();
        commCode.setGrpCd("C1016");
        Map<String, Object> map = commCodeService.commCodeListAllIbPaging(commCode);
        List<CommCode> result = (List<CommCode>) map.get("resultList");

        model.addAttribute("commMenu", result);


        return "admin/basicinf/commmenu";
    }

    /*
     *//**
     * 메뉴관리 전체리스트를 조회한다.
     * @param commCode
     * @param model
     * @return
     * @throws Exception
     *//*
	@RequestMapping("/admin/basicinf/commMenuRetr.do")
	@ResponseBody
	public IBSheetListVO<CommCode> commcodeList(@ModelAttribute("searchVO") CommUsr commUsr, ModelMap model){
		 
		Map<String, Object> map = commCodeService.selectCommCode(commCode);
		@SuppressWarnings("unchecked")
		List<CommCode> result = (List<CommCode>) map.get("resultList");
		int cnt = Integer.parseInt((String)map.get("resultCnt"));
		return new IBSheetListVO<CommCode>(result, cnt);
		
		Map<String, Object> map = commMenuService.selectCommMenuTop1(commUsr);
		@SuppressWarnings("unchecked")
		List<CommCode> result = (List<CommCode>) map.get("resultList");
		int cnt = Integer.parseInt((String)map.get("resultCnt"));
		return new IBSheetListVO<CommCode>(result, cnt);
	}
	*/

    /*
     *//**
     * 공통코드 그리드에 내용을 저장한다.
     * @param data
     * @param locale
     * @return
     * @throws Exception
     *//*
	@RequestMapping("/admin/basicinf/commcodeexec.do")
	@ResponseBody
	public IBSResultVO<CommCode> commCodeSave(@RequestBody commCodes data, Locale locale) {
		ArrayList<CommCode> list = data.get("data");
		int result = commCodeService.saveCommCode(list);
		String resmsg;
		if(result > 0) {
			result = 0;
			resmsg = message.getMessage("MSG.SAVE");
		} else {
			result = -1;
			resmsg = message.getMessage("ERR.SAVE");
		}
		return new IBSResultVO<CommCode>(result, resmsg);
	}*/


    /**
     * 전체 리스트를 조회한다.
     * @param commMenu
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/basicinf/commMenuRetr.do")
    @ResponseBody
    public IBSheetListVO<CommMenu> commcodeList(@ModelAttribute("searchVO") CommMenu commMenu, ModelMap model) {

        Map<String, Object> map = commMenuService.selectMenuListIbPaging(commMenu);
        @SuppressWarnings("unchecked")
        List<CommMenu> result = (List<CommMenu>) map.get("resultList");
        //int cnt = Integer.parseInt((String)map.get("resultCnt"));
        return new IBSheetListVO<CommMenu>(result, result.size());
    }

    /**
     * 전체 리스트에서 키워드 조회한다.
     * @param commMenu
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/basicinf/commMenuRetrKeywd.do")
    @ResponseBody
    public IBSheetListVO<CommMenu> commCodeListKeywd(@ModelAttribute("searchVO") CommMenu commMenu, ModelMap model) {
        Map<String, Object> map = commMenuService.selectMenuListKeywdIbPaging(commMenu);
        @SuppressWarnings("unchecked")
        List<CommMenu> result = (List<CommMenu>) map.get("resultList");
        //int cnt = Integer.parseInt((String)map.get("resultCnt"));
        return new IBSheetListVO<CommMenu>(result, result.size());
    }

    /**
     * 한 건 상세조회한다.
     * @param commMenu
     * @param model
     * @param menuId
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/basicinf/commMenuRetrInfo.do")
    @ResponseBody
    public TABListVo<CommMenu> commcodeListInfo(@RequestBody CommMenu commMenu, ModelMap model, String menuId) {
        return new TABListVo<CommMenu>(commMenuService.selectMenuListInfo(commMenu));
    }

    /**
     * 단건 데이터 저장한다.
     * @param saveVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/basicinf/commMenuSave.do")
    @ResponseBody
    public IBSResultVO<CommMenu> saveCommMenu(@ModelAttribute CommMenu saveVO, ModelMap model) {
        int result = 0;
        result = commMenuService.saveCommMenuCUD(saveVO, WiseOpenConfig.STATUS_I);
        return new IBSResultVO<CommMenu>(result, messagehelper.getSavaMessage(result));
    }

    /**
     * 단건 데이터 수정한다
     * @param saveVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/basicinf/updateCommMenu.do")
    @ResponseBody
    public IBSResultVO<CommMenu> updateCommMenu(@ModelAttribute CommMenu saveVO, ModelMap model) {
        int result = 0;
        result = commMenuService.saveCommMenuCUD(saveVO, WiseOpenConfig.STATUS_U);
        return new IBSResultVO<CommMenu>(result, messagehelper.getSavaMessage(result));
    }

    /**
     * 단건 메뉴 삭제한다.
     * @param saveVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/basicinf/deleteCommMenu.do")
    @ResponseBody
    public IBSResultVO<CommMenu> deleteCommMenu(@ModelAttribute CommMenu saveVO, ModelMap model) {
        int result = 0;
        result = commMenuService.saveCommMenuCUD(saveVO, WiseOpenConfig.STATUS_D);
        return new IBSResultVO<CommMenu>(result, messagehelper.getSavaMessage(result));
    }

    /**
     * 선택한 행의 하위메뉴 조회한다.
     * @param commMenu
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/basicinf/commLowMenuList.do")
    @ResponseBody
    public IBSheetListVO<CommUsr> selectCommLowMenuList(@ModelAttribute("searchVO") CommMenu commMenu, ModelMap model) {
        Map<String, Object> map = commMenuService.selectCommLowMenuList(commMenu);
        @SuppressWarnings("unchecked")
        List<CommUsr> result = (List<CommUsr>) map.get("resultList");
        int cnt = Integer.parseInt((String) map.get("resultCnt"));
        return new IBSheetListVO<CommUsr>(result, cnt);
    }

    /**
     * 메뉴 검색 팝업창
     * @return
     */
    @RequestMapping("/admin/basicinf/popup/commmenu_pop.do")
    public String openDsPopList(HttpServletRequest request, ModelMap model) {
        model.addAttribute("commMenu", request.getParameter("menuSiteCd"));
        return "/admin/basicinf/popup/commmenu_pop";
    }

    /**
     * 메뉴 순위 저장
     * @param data
     * @param locale
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/basicinf/commMenuListUpdateTreeOrder.do")
    @ResponseBody
    public IBSResultVO<CommMenu> commMenuListUpdateTreeOrder(@RequestBody commMenus data, Locale locale) {
        ArrayList<CommMenu> list = data.get("data");
        int result = commMenuService.commMenuListUpdateTreeOrderCUD(list);
        return new IBSResultVO<CommMenu>(result, messagehelper.getSavaMessage(result));
    }


}

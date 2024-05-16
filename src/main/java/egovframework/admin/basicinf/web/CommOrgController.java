package egovframework.admin.basicinf.web;

import java.util.*;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.admin.basicinf.service.CommOrg;
import egovframework.admin.basicinf.service.CommOrgService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.WiseOpenConfig;
import egovframework.common.code.service.CodeListService;
import egovframework.common.grid.IBSResultVO;
import egovframework.common.grid.IBSheetListVO;
import egovframework.common.helper.Messagehelper;

/**
 * 조직정보 관리를 위한 Controller
 *
 * @author KJH
 * @since 2014.07.17
 */
@Controller
public class CommOrgController implements InitializingBean {

    protected static final Log logger = LogFactory.getLog(CommOrgController.class);

    @Resource
    private CodeListService commCodeListService;

    @Resource(name = "CommOrgService")
    private CommOrgService commOrgService;

    //공통 메시지 사용시 선언
    @Resource
    Messagehelper messagehelper;

    static class commOrgs extends HashMap<String, ArrayList<CommOrg>> {
    }

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
            codeMap.put("typeCd", commCodeListService.getCodeList("C1001"));
        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return codeMap;
    }

    /**
     * 공통코드 화면으로 이동한다.
     *
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/basicinf/popup/commOrg_pop.do")
    public String commorg_popPage(ModelMap model) {
        return "/admin/basicinf/popup/commorg_pop";
    }

    /**
     * 사용자를 전체 조회한다.
     *
     * @param commOrg
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/basicinf/popup/commOrgListAll.do")
    @ResponseBody
    public IBSheetListVO<CommOrg> commOrgListAll(@ModelAttribute("searchVO") CommOrg commOrg, ModelMap model) {
        List<CommOrg> list = new ArrayList<CommOrg>();
        if (commOrg != null) {
            list = commOrgService.selectCommOrgAll(commOrg);
        }
        return new IBSheetListVO<CommOrg>(list, list.size());
    }

    /**
     * 페이지 이동
     *
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/basicinf/commOrgPage.do")
    public String commOrgPage(ModelMap model) {
        //페이지 title을 가져오려면 반드시 *Page로 끝나야한다.
        //Interceptor(PageNavigationInterceptor)에서 조회함
        return "/admin/basicinf/commOrg";
    }

    /**
     * 조직정보 목록트리 조회.
     *
     * @param commOrg
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/basicinf/commOrgListTree.do")
    @ResponseBody
    public IBSheetListVO<CommOrg> commOrgListTree(CommOrg commOrg, ModelMap model) {
        Map<String, Object> map = new HashMap<String, Object>();
        if (commOrg != null) {
            //페이징 처리시 반드시 *IbPaging 메소드명을 사용해야함
            map = commOrgService.commOrgListTree(commOrg);
        }
        @SuppressWarnings("unchecked")
        List<CommOrg> result = (List<CommOrg>) map.get("resultList");
        return new IBSheetListVO<CommOrg>(result, result.size());
    }

    /**
     * 그룹코드 중복체크
     *
     * @param commOrg
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/basicinf/commOrgCdDup.do")
    @ResponseBody
    public IBSResultVO<CommOrg> commOrgCdDup(CommOrg commOrg, ModelMap model) {
        int result = 0;
        if (commOrg != null) {
            result = commOrgService.commOrgCdDup(commOrg);
        }
        return new IBSResultVO<CommOrg>(result, messagehelper.getSavaMessage(result));
    }

    /**
     * 신규등록
     *
     * @param commOrg
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/basicinf/commOrgReg.do")
    @ResponseBody
    public IBSResultVO<CommOrg> commOrgReg(CommOrg commOrg, ModelMap model) {
        int result = 0;
        if (commOrg != null) {
            //등록, 변경, 삭제 처리시  등록자, 수정자 Id를 세션에서 가져올 경우 *CUD 메소드명을 사용해야함
            result = commOrgService.saveCommOrgCUD(commOrg, WiseOpenConfig.STATUS_I);
        }
        return new IBSResultVO<CommOrg>(result, messagehelper.getSavaMessage(result));
    }

    /**
     * 조직정보 단건 조회
     * @param commOrg
     * @param model
     * @return
     * @throws Exception
     */
    //@RequestMapping("/admin/basicinf/commOrgRetr.do")
    //@ResponseBody
    //public TABListVo<CommOrg> commOrgRetv(@RequestBody CommOrg commOrg, ModelMap model){
    //	return new TABListVo<CommOrg>(commOrgService.commOrgRetr(commOrg));
    //}

    /**
     * 조직정보 단건 조회
     *
     * @param commOrg
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/basicinf/commOrgRetr.do")
    @ResponseBody
    public Map<String, Object> commOrgRetv(CommOrg commOrg, ModelMap model) {
        Map<String, Object> map = new HashMap<String, Object>();
        if (commOrg != null) {
            map.put("DATA", commOrgService.commOrgRetr(commOrg));
        }
        return map;
    }

    /**
     * 조직정보 삭제(하위구조 있을경우 동시처리)
     *
     * @param commOrg
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/basicinf/commOrgDel.do")
    @ResponseBody
    public IBSResultVO<CommOrg> commOrgDel(CommOrg commOrg, ModelMap model) {
        int result = 0;
        //등록, 변경, 삭제 처리시 등록자, 수정자 Id를 세션에서 가져올 경우 *CUD 메소드명을 사용해야함
        if (commOrg != null && commOrg.getUseYn() != null) {
            result = commOrgService.saveCommOrgCUD(commOrg, WiseOpenConfig.STATUS_D);
        }
        return new IBSResultVO<CommOrg>(result, messagehelper.getDeleteMessage(result));
    }

    /**
     * 조직정보 수정(미사용 체크시 하위조직도 같이 USE_YN = 'N' 으로 변경
     *
     * @param commOrg
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/basicinf/commOrgUpd.do")
    @ResponseBody
    public IBSResultVO<CommOrg> commOrgUpd(CommOrg commOrg, ModelMap model) {
        int result = 0;
        if (commOrg != null) {
            //등록, 변경, 삭제 처리시 등록자, 수정자 Id를 세션에서 가져올 경우 *CUD 메소드명을 사용해야함
            result = commOrgService.saveCommOrgCUD(commOrg, WiseOpenConfig.STATUS_U);
        }
        return new IBSResultVO<CommOrg>(result, messagehelper.getUpdateMessage(result));
    }

    /**
     * 조직정보의 항목 순서를 변경
     *
     * @param data
     * @param locale
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/basicinf/commOrgListUpdateTreeOrder.do")
    @ResponseBody
    public IBSResultVO<CommOrg> commOrgListUpdateTreeOrder(@RequestBody commOrgs data, Locale locale) {
        ArrayList<CommOrg> list = new ArrayList<CommOrg>();
        if (data != null) {
            list = data.get("data");
        }
        int result = commOrgService.commOrgListUpdateTreeOrderCUD(list);
        return new IBSResultVO<CommOrg>(result, messagehelper.getSavaMessage(result));
    }

}

package egovframework.admin.bbs.web;

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

import egovframework.admin.basicinf.web.CommOrgController;
import egovframework.admin.bbs.service.BbsAdmin;
import egovframework.admin.bbs.service.BbsAdminService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.WiseOpenConfig;
import egovframework.common.code.service.CodeListService;
import egovframework.common.grid.IBSResultVO;
import egovframework.common.grid.IBSheetListVO;
import egovframework.common.helper.Messagehelper;
import egovframework.common.helper.TABListVo;

@Controller
public class BbsAdminController implements InitializingBean {

    protected static final Log logger = LogFactory.getLog(CommOrgController.class);

    //서비스 사용시 선언
    @Resource(name = "BbsAdminService")
    private BbsAdminService bbsAdminService;

    //공통코드 사용시 선언
    @Resource
    private CodeListService commCodeListService;

    //공통 메시지 사용시 선언
    @Resource
    Messagehelper messagehelper;


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
            codeMap.put("typeCd", commCodeListService.getCodeList("C1010"));
            codeMap.put("langCd", commCodeListService.getCodeList("D1011"));
            codeMap.put("ditcCd", commCodeListService.getCodeList("C1004"));

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return codeMap;
    }

    /**
     * 게시판목록 페이지로 이동
     *
     * @param model
     * @return String
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/bbsAdminPage.do")
    public String bbsAdminPage(ModelMap model) {
        //페이지 title을 가져오려면 반드시 *Page로 끝나야한다.
        //Interceptor(PageNavigationInterceptor)에서 조회함
        return "/admin/bbs/bbsAdmin";
    }

    /**
     * 게시판 조회
     *
     * @param bbsAdmin
     * @param model
     * @return IBSheetListVO<BbsAdmin>
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/bbsAdminListAll.do")
    @ResponseBody
    public IBSheetListVO<BbsAdmin> bbsAdminListAll(BbsAdmin bbsAdmin, ModelMap model) {
        List<BbsAdmin> list = bbsAdminService.bbsAdminListAll(bbsAdmin);
        return new IBSheetListVO<BbsAdmin>(list, list.size());
    }

    /**
     * 게시판 상세 조회
     *
     * @param bbsAdmin
     * @param model
     * @return TABListVo<BbsAdmin>
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/selectBbsAdminList.do")
    @ResponseBody
    public TABListVo<BbsAdmin> selectBbsAdminList(@RequestBody BbsAdmin bbsAdmin, ModelMap model) {
        return new TABListVo<BbsAdmin>(bbsAdminService.selectBbsAdminList(bbsAdmin));
    }

    /**
     * 코드 중복 체크
     *
     * @param bbsAdmin
     * @param model
     * @return IBSResultVO<BbsAdmin>
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/bbsAdminCodeCheck.do")
    @ResponseBody
    public IBSResultVO<BbsAdmin> bbsAdminCodeCheck(BbsAdmin bbsAdmin, ModelMap model) {
        int result = 0;
        result = bbsAdminService.bbsAdminCodeCheck(bbsAdmin);
        return new IBSResultVO<BbsAdmin>(result, messagehelper.getSavaMessage(result));
    }

    /**
     * 게시판 등록
     *
     * @param bbsAdmin
     * @param model
     * @return IBSResultVO<BbsAdmin>
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/bbsAdminSave.do")
    @ResponseBody
    public IBSResultVO<BbsAdmin> bbsAdminSave(BbsAdmin bbsAdmin, ModelMap model) {
        int result = 0;
        result = bbsAdminService.bbsAdminRegCUD(bbsAdmin, WiseOpenConfig.STATUS_I);
        return new IBSResultVO<BbsAdmin>(result, messagehelper.getSavaMessage(result));
    }

    /**
     * 게시판 수정
     *
     * @param bbsAdmin
     * @param model
     * @return IBSResultVO<BbsAdmin>
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/bbsAdminUpdate.do")
    @ResponseBody
    public IBSResultVO<BbsAdmin> bbsAdminUpdate(BbsAdmin bbsAdmin, ModelMap model) {
        int result = 0;
        result = bbsAdminService.bbsAdminRegCUD(bbsAdmin, WiseOpenConfig.STATUS_U);
        return new IBSResultVO<BbsAdmin>(result, messagehelper.getSavaMessage(result));
    }

    /**
     * 게시판 삭제
     *
     * @param bbsAdmin
     * @param model
     * @return IBSResultVO<BbsAdmin>
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/bbsAdminDelete.do")
    @ResponseBody
    public IBSResultVO<BbsAdmin> bbsAdminDelete(BbsAdmin bbsAdmin, ModelMap model) {
        int result = 0;
        result = bbsAdminService.bbsAdminRegCUD(bbsAdmin, WiseOpenConfig.STATUS_D);
        return new IBSResultVO<BbsAdmin>(result, messagehelper.getSavaMessage(result));
    }

    /**
     * 라이브리 테스트 페이지로 이동
     *
     * @param model
     * @return String
     * @throws Exception
     */
    @RequestMapping("/admin/bbs/liverePage.do")
    public String liverePage(ModelMap model) {
        return "/admin/bbs/livereTest";
    }
}

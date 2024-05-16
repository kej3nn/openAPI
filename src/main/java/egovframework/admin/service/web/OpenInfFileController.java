package egovframework.admin.service.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.admin.basicinf.service.CommUsr;
import egovframework.admin.service.service.OpenInfFileService;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.helper.TABListVo;

/**
 * 공공데이터 파일서비스 등록 컨트롤러 클래스
 *
 * @version 1.0
 * @author JHKIM
 * @since 2020/01/06
 */
@Controller
public class OpenInfFileController extends BaseController {
    protected static final Log logger = LogFactory.getLog(OpenInfFileController.class);

    @Resource(name = "openInfFileService")
    private OpenInfFileService openInfFileService;

    /**
     * 파일서비스 첨부 등록 페이지 이동
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/openinf/openinfFilePage.do")
    public String openinfFilePage(HttpServletRequest request, Model model) {

        if (EgovUserDetailsHelper.isAuthenticated()) {
            CommUsr loginVO = null;
            EgovUserDetailsHelper.getAuthenticatedUser();
            loginVO = (CommUsr) EgovUserDetailsHelper.getAuthenticatedUser();
            model.addAttribute("accCd", loginVO.getAccCd());    // 권한코드
        }

        return "/admin/service/openinfFile";
    }

    /**
     * 서비스 목록 조회
     */
    @RequestMapping("/admin/openinf/selectOpenInfSrvList.do")
    public String selectOpenInfSrvList(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);

        Object result = openInfFileService.selectOpenInfSrvList(params);

        addObject(model, result);

        return "jsonView";
    }

    /**
     * 서비스 상세 조회
     */
    @RequestMapping("/admin/openinf/selectOpenInfSrvDtl.do")
    @ResponseBody
    public TABListVo<Record> selectOpenInfSrvDtl(@RequestBody Params params, HttpServletRequest request, ModelMap model) {
        return new TABListVo<Record>(openInfFileService.selectOpenInfSrvDtl(params));
    }

    /**
     * 서비스 파일목록 조회
     */
    @RequestMapping("/admin/openinf/selectOpenInfFileList.do")
    public String selectOpenInfFileList(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);

        Object result = openInfFileService.selectOpenInfFileList(params);

        addObject(model, result);

        return "jsonView";
    }

    /**
     * 서비스 파일 등록
     */
    @RequestMapping("/admin/openinf/insertOpeninfFile.do")
    public String insertOpeninfFile(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);

        Object result = openInfFileService.insertOpeninfFile(request, params);

        addObject(model, result);

        return "jsonView";
    }

    /**
     * 서비스 파일 수정
     */
    @RequestMapping("/admin/openinf/updateOpeninfFile.do")
    public String updateOpeninfFile(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);

        Object result = openInfFileService.updateOpeninfFile(params);

        addObject(model, result);

        return "jsonView";
    }

    /**
     * 서비스 파일 삭제
     */
    @RequestMapping("/admin/openinf/deleteOpeninfFile.do")
    public String deleteOpeninfFile(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);

        Object result = openInfFileService.deleteOpeninfFile(params);

        addObject(model, result);

        return "jsonView";
    }

    /**
     * 서비스 파일 다운로드
     */
    @RequestMapping("/admin/openinf/downloadOpeninfFile.do")
    public String downloadOpeninfFile(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);

        Object result = openInfFileService.downloadOpeninfFile(params);

        addObject(model, result);

        return "fileDownloadView";
    }

    /**
     * 파일서비스 순서저장
     */
    @RequestMapping("/admin/openinf/saveOpenInfFileOrder.do")
    public String saveOpenInfFileOrder(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);

        Object result = openInfFileService.saveOpenInfFileOrder(params);

        addObject(model, result);

        return "jsonView";
    }
}

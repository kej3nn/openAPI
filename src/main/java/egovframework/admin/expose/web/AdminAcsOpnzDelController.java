package egovframework.admin.expose.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.admin.expose.service.AdminAcsOpnzDelService;
import egovframework.admin.expose.service.AdminExposeInfoService;
import egovframework.common.base.constants.RequestAttribute;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;


/**
 * 정보공개청구 > 청구인정보 기록삭제 관리  클래스
 *
 * @author 최성빈
 * @version 1.0
 * @since 2020/09/16
 */
@Controller
public class AdminAcsOpnzDelController extends BaseController {

    @Resource(name = "adminAcsOpnzDelService")
    protected AdminAcsOpnzDelService adminAcsOpnzDelService;

    @Resource(name = "adminExposeInfoService")
    protected AdminExposeInfoService adminExposeInfoService;

    /**
     * 청구인정보 기록삭제 페이지 이동
     *
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/expose/acsOpnzDelPage.do")
    public String acsOpnzDelPage(HttpServletRequest request, ModelMap model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        //신청번호가 넘어오면 조회후 탭을 연다.
        model.addAttribute("openAplNo", params.get("aplNo"));

        // 청구대상기관
        model.addAttribute("instCodeList", adminExposeInfoService.selectNaboOrg(params));

        // 공개형태
        params.put("lclsCd", "A");
        model.addAttribute("lclsCodeList", adminExposeInfoService.selectComCode(params));

        // 수령방법
        params.put("lclsCd", "B");
        model.addAttribute("apitCodeList", adminExposeInfoService.selectComCode(params));

        // 감면여부
        params.put("lclsCd", "C");
        model.addAttribute("feerCodeList", adminExposeInfoService.selectComCode(params));


        // 처리상태
        params.put("lclsCd", "D");
        model.addAttribute("prgStatCodeList", adminExposeInfoService.selectComCode(params));

        return "/admin/expose/acsOpnzDel";
    }

    /**
     * 청구인정보 기록삭제 리스트 조회
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/expose/acsOpnzDelList.do")
    public String acsOpnzDelList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);

        Object result = adminAcsOpnzDelService.acsOpnzDelListPaging(params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 청구인정보 기록삭제 데이터 수정
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/admin/expose/saveAcsOpnzDel.do")
    public String saveAcsOpnzDel(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        String ip = StringUtils.defaultIfEmpty(request.getRemoteAddr(), "");

        if (StringUtils.equals("::1", ip)
                || StringUtils.equals("0:0:0:0:0:0:0:1", ip)) {
            // 로컬호스트 체크
            ip = "127.0.0.1";
        }

        params.put(RequestAttribute.USER_IP, ip);

        debug("Request parameters: " + params);

        Object result = adminAcsOpnzDelService.saveAcsOpnzDel(params);

        debug("Processing results: " + result);

        addObject(model, result);

        return "jsonView";
    }
}

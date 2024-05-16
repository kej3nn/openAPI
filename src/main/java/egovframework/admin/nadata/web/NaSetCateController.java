package egovframework.admin.nadata.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.admin.nadata.service.NaSetCateService;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.helper.TABListVo;

/**
 * 관리자 정보카달로그 분류 클래스
 *
 * @author
 * @version 1.0
 * @since 2019/09/18
 */

@Controller
public class NaSetCateController extends BaseController {

    @Resource(name = "naSetCateService")
    protected NaSetCateService naSetCateService;

    /**
     * 정보카달로그 분류 페이지 이동
     *
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/nadata/cate/naSetCatePage.do")
    public String naSetCatePage(HttpServletRequest request, ModelMap model) {
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        model.addAttribute("cateTag", params.get("cateTag"));

        return "/admin/nadata/cate/naSetCate";
    }

    /**
     * 정보카달로그 분류 메인 리스트 조회
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/nadata/cate/naSetCateList.do")
    public String naSetCateList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        Object result = naSetCateService.naSetCateList(params);

        addObject(model, result);    // 모델에 객체를 추가한다.

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 정보카달로그 분류 팝업 리스트 조회
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/nadata/cate/naSetCatePopList.do")
    public String naSetCatePopList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        Object result = naSetCateService.naSetCatePopList(params);

        addObject(model, result);    // 모델에 객체를 추가한다.

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 정보카달로그 분류 상세 조회
     *
     * @param params
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/nadata/cate/naSetCateDtl.do")
    @ResponseBody
    public TABListVo<Record> naSetCateDtl(@RequestBody Params params, HttpServletRequest request, ModelMap model) {
        return new TABListVo<Record>(naSetCateService.naSetCateDtl(params));
    }

    /**
     * 정보카달로그 분류 ID 중복체크
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/nadata/cate/naSetCateDupChk.do")
    public String naSetCateDupChk(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);

        Object result = naSetCateService.naSetCateDupChk(params);

        debug("Processing results: " + result);

        addObject(model, result);

        return "jsonView";
    }


    @RequestMapping("/admin/nadata/cate/popup/naSetCatePop.do")
    public String naSetUiPop(ModelMap model) {
        return "/admin/nadata/cate/popup/naSetCatePop";
    }

    /**
     * 정보카달로그 분류 등록/수정
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/nadata/cate/saveNaSetCate.do")
    public String saveNaSetCate(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);

        Object result = naSetCateService.saveNaSetCate(request, params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 정보카달로그 분류 삭제
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/nadata/cate/deleteNaSetCate.do")
    public String deleteStatSttsCate(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);

        Object result = naSetCateService.deleteNaSetCate(params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 정보카달로그 썸네일 불러오기
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/admin/nadata/cate/selectThumbnail.do")
    public String selectThumbnail(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        // 공공데이터 데이터셋 썸네일을 조회한다.
        Object result = naSetCateService.selectNaSetCateThumbnail(params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "imageView";
    }

    /**
     * 정보카달로그 분류 순서 저장
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/admin/nadata/cate/saveNaSetCateOrder.do")
    public String saveStatSttsCateOrder(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        // 공공데이터 데이터셋 썸네일을 조회한다.
        Object result = naSetCateService.saveNaSetCateOrder(params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }

}

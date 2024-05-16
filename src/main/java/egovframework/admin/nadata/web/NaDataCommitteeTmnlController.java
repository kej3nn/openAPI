package egovframework.admin.nadata.web;

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

import egovframework.admin.nadata.service.NaDataCommitteeThmlService;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.helper.TABListVo;

/**
 * 국회 정보 사이트맵을 관리하는 컨트롤러 클래스
 *
 * @version 1.0
 * @author 김재한
 * @since 2019/09/09
 */

@Controller
public class NaDataCommitteeTmnlController extends BaseController {

    protected static final Log logger = LogFactory.getLog(NaDataCommitteeTmnlController.class);

    @Resource(name = "naDataCommitteeThmlService")
    protected NaDataCommitteeThmlService naDataCommitteeThmlService;


    /**
     * 사이트맵 관리 화면으로 이동한다.
     *
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/nadata/CommitteeThml/naDataCommitteeThmlPage.do")
    public String infsetMgmtPage(ModelMap model) {

        Params params = new Params();

        model.addAttribute("orgList", naDataCommitteeThmlService.selectOrgList(params));

        return "/admin/nadata/naDataCommitteeThml";
    }

    /**
     * 메인 리스트 조회(페이징 처리)
     */
    @RequestMapping("/admin/nadata/CommitteeThml/CommitteeThmlMainListPaging.do")
    public String infSetMainListPaging(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);

        Object result = naDataCommitteeThmlService.selectCommitteeThmlMainListPaging(params);

        addObject(model, result);

        return "jsonView";
    }

    /**
     * 사이트맵 ID 중복체크
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/nadata/CommitteeThml/naDataCommitteeThmlDupChk.do")
    public String infSetCateDupChk(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);

        Object result = naDataCommitteeThmlService.naDataCommitteeThmlDupChk(params);

        debug("Processing results: " + result);

        addObject(model, result);

        return "jsonView";
    }

    /**
     * 사이트맵 등록/수정
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/nadata/CommitteeThml/saveNaDataCommitteeThml.do")
    public String saveInfSetCate(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);

        Object result = naDataCommitteeThmlService.saveNaDataCommitteeThml(request, params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 사이트맵 상세 조회
     *
     * @param params
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/nadata/CommitteeThml/naDataCommitteeThmlDtl.do")
    @ResponseBody
    public TABListVo<Record> infSetCateDtl(@RequestBody Params params, HttpServletRequest request, ModelMap model) {
        return new TABListVo<Record>(naDataCommitteeThmlService.naDataCommitteeThmlDtl(params));
    }

    /**
     * 사이트맵 썸네일 불러오기
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/admin/nadata/CommitteeThml/selectThumbnail.do")
    public String selectThumbnail(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        // 공공데이터 데이터셋 썸네일을 조회한다.
        Object result = naDataCommitteeThmlService.selectDataCommitteeThmlThumbnail(params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "imageView";
    }

    /**
     * 사이트맵 삭제
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/nadata/CommitteeThml/deleteNaDataCommitteeThml.do")
    public String deleteStatSttsCate(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);

        Object result = naDataCommitteeThmlService.deleteNaDataCommitteeThml(params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 사이트맵 순서 저장
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/admin/nadata/CommitteeThml/saveNaDataCommitteeThmlOrder.do")
    public String saveStatSttsCateOrder(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        // 공공데이터 데이터셋 썸네일을 조회한다.
        Object result = naDataCommitteeThmlService.saveNaDataCommitteeThmlOrder(params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }
}

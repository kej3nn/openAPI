package egovframework.admin.expose.web;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.gpki.gpkiapi.exception.GpkiApiException;

import egovframework.admin.expose.service.AdminExposeInfoService;
import egovframework.admin.expose.service.impl.AdminExposeInfoDao;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.common.GPKIClientSocket;
import egovframework.common.base.constants.RequestAttribute;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.helper.TABListVo;

/**
 * 정보공개관리  클래스
 *
 * @author 최성빈
 * @version 1.0
 * @since 2019/07/29
 */
@Controller
public class AdminExposeInfoController extends BaseController {

    @Resource(name = "adminExposeInfoService")
    protected AdminExposeInfoService adminExposeInfoService;

    @Resource(name = "adminExposeInfoDao")
    protected AdminExposeInfoDao adminExposeInfoDao;

    /**
     * 오프라인청구서 작성 페이지 이동
     *
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/expose/offlineWriteAccountPage.do")
    public String offlineWriteAccountPage(HttpServletRequest request, ModelMap model) {
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

        return "/admin/expose/offlineWriteAccount";
    }

    /**
     * 오프라인청구서 작성 페이지 이동 > 청구서 상세탭 오픈
     *
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/expose/offlineWriteAccountPage/{openAplNo}.do")
    public String offlineWriteAccountPage(@PathVariable("openAplNo") String openAplNo, ModelMap model) {
        model.addAttribute("openAplNo", openAplNo);
        // 파라메터를 가져온다.
        Params params = new Params();

        debug("Request parameters: " + params);

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

        return "/admin/expose/offlineWriteAccount";
    }

    /**
     * 청구조회  리스트 조회
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/expose/opnApplyList.do")
    public String opnApplyList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);

        Object result = adminExposeInfoService.opnApplyListPaging(params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 정보공개 청구서작성 데이터를 등록한다.
     *
     * @param request HTTP 요청
     * @param model   모델
     * @return 뷰이름
     */
    @RequestMapping("/admin/expose/insertOpnApply.do")
    public String insertOpnApply(HttpServletRequest request, Model model) {

        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        String ip = StringUtils.defaultIfEmpty(request.getRemoteAddr(), "");
        if (StringUtils.equals("::1", ip) || StringUtils.equals("0:0:0:0:0:0:0:1", ip)) {
            // 로컬호스트 체크
            ip = "127.0.0.1";
        }
        params.put(RequestAttribute.USER_IP, ip);

        // 청구서작성 데이터를 등록
        Object result = adminExposeInfoService.insertOpnApply(request, params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 청구서 상세 조회
     *
     * @param paramMap
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/expose/selectOpnApplyDtl.do")
    @ResponseBody
    public TABListVo<Map<String, Object>> selectOpnApplyDtl(@RequestBody Map<String, String> paramMap, HttpServletRequest request, ModelMap model) {

        Map<String, Object> map = adminExposeInfoService.selectOpnApplyDtl(paramMap);
        return new TABListVo<Map<String, Object>>(map.get("DATA"), map.get("DATA2"));
    }

    /**
     * 청구서 접수
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/expose/insertInfoRcp.do")
    public String insertInfoRcp(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);


        debug("Request parameters: " + params);

        Object result = adminExposeInfoService.saveInfoRcp(request, params);

        debug("Processing results: " + result);

        addObject(model, result);

        return "jsonView";
    }

    /**
     * 정보공개청구 이송처리
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/expose/insertTrsfOpnApl.do")
    public String insertTrsfOpnApl(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);


        debug("Request parameters: " + params);

        Object result = adminExposeInfoService.saveTrsfOpnApl(request, params);

        debug("Processing results: " + result);

        addObject(model, result);

        return "jsonView";
    }

    /**
     * 정보공개청구취하
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/expose/cancleOpnApl.do")
    public String cancleOpnApl(HttpServletRequest request, Model model) {

        // 파라메터를 가져온다.
        Params params = getParams(request, false);


        debug("Request parameters: " + params);

        Object result = adminExposeInfoService.updateInfoOpenApplyPrgStat(request, params);

        debug("Processing results: " + result);

        addObject(model, result);

        return "jsonView";
    }

    /**
     * 결정기한연장  팝업
     *
     * @param request
     * @param model
     * @param session
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/expose/popup/opnDcsProdPopup.do")
    public String opnDcsProdPopup(HttpServletRequest request, Model model, HttpSession session) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        Map<String, Object> opnRcpDo = adminExposeInfoService.getInfoOpnDcsSearch(params);

        model.addAttribute("opnRcpDo", opnRcpDo);

        return "/admin/expose/popup/opnDcsProdPopup";
    }

    /**
     * 첨부파일 다운로드
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/admin/expose/downloadOpnAplFile.do")
    public String downloadOpnAplFile(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);


        Object result = adminExposeInfoService.downloadOpnAplFile(params);
        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "fileDownloadView";
    }

    /**
     * 결정기한연장
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/expose/insertOpnDcsProd.do")
    public String insertOpnDcsProd(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);


        debug("Request parameters: " + params);

        Object result = adminExposeInfoService.saveOpnDcsProd(request, params);

        debug("Processing results: " + result);

        addObject(model, result);

        return "jsonView";
    }

    /**
     * 종결 팝업
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/admin/expose/popup/opnEndCnPopup.do")
    public String opnEndCnPopup(HttpServletRequest request, Model model) {

        return "/admin/expose/popup/opnEndCnPopup";
    }

    /**
     * 종결
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/expose/infoOpenUpdateEndCn.do")
    public String infoOpenUpdateEndCn(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);


        debug("Request parameters: " + params);

        Object result = adminExposeInfoService.saveOpenEndCn(request, params);

        debug("Processing results: " + result);

        addObject(model, result);

        return "jsonView";
    }

    /**
     * 결정기한연장  팝업
     *
     * @param request
     * @param model
     * @param session
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/expose/popup/writeOpnTrnPopup.do")
    public ModelAndView writeOpnTrnPopup(HttpServletRequest request, Model model, HttpSession session) {
        ModelAndView modelAndView = new ModelAndView();
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        Map<String, Object> opnRcpDo = adminExposeInfoService.getInfoOpnDcsSearch(params);

        modelAndView.addObject("opnRcpDo", opnRcpDo);

        modelAndView.setViewName("/admin/expose/popup/writeOpnTrnPopup");

        return modelAndView;
    }

    /**
     * 정보공개 청구 타기관 이송 등록.
     *
     * @param request HTTP 요청
     * @param model   모델
     * @return 뷰이름
     */
    @RequestMapping("/admin/expose/infoOpenTrnWrite.do")
    public String infoOpenTrnWrite(HttpServletRequest request, Model model) {

        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        // 정보공개 청고 타기관 이송 등록
        Object result = adminExposeInfoService.infoOpenTrnWrite(request, params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 청구내역 수정  팝업
     *
     * @param request
     * @param model
     * @param session
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/expose/popup/updateOpnAplPopup.do")
    public String updateOpnAplPopup(HttpServletRequest request, Model model, HttpSession session) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        //정보공개청구 정보
        Map<String, Object> opnRcpDo = adminExposeInfoService.getInfoOpnDcsSearch(params);

        model.addAttribute("opnRcpDo", opnRcpDo);

        // 공개형태
        params.put("lclsCd", "A");
        model.addAttribute("lclsCodeList", adminExposeInfoService.selectComCode(params));

        // 수령방법
        params.put("lclsCd", "B");
        model.addAttribute("apitCodeList", adminExposeInfoService.selectComCode(params));

        return "/admin/expose/popup/updateOpnAplPopup";
    }

    /**
     * 정보공개청구수정
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/expose/updateOpnApl.do")
    public String updateOpnApl(HttpServletRequest request, Model model) {

        // 파라메터를 가져온다.
        Params params = getParams(request, false);


        debug("Request parameters: " + params);

        Object result = adminExposeInfoService.updateOpnApl(params);

        debug("Processing results: " + result);

        addObject(model, result);

        return "jsonView";
    }

    /**
     * 리포트  출력(관리자)
     *
     * @param request HTTP 요청
     * @param model   모델
     * @return 뷰이름
     */
    @RequestMapping("/admin/expose/infoPrintPage/{printId}.do")
    public String reportingPage(@PathVariable("printId") String printId, HttpServletRequest request, Model model, HttpSession session) {
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        model.addAttribute("width", params.get("width"));
        model.addAttribute("height", params.get("height"));
        model.addAttribute("title", params.get("title"));
        model.addAttribute("mrdParam", params.get("mrdParam"));

        model.addAttribute("mrdPath", EgovProperties.getProperty("Globals." + printId));

        return "/admin/expose/adminRdCommon";
    }


    /**
     * 결정통보내역  팝업
     *
     * @param request
     * @param model
     * @param session
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/expose/popup/viewOpnDcsPopup.do")
    public String viewOpnDcsPopup(HttpServletRequest request, Model model, HttpSession session) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        //정보공개청구 정보
        Map<String, Object> opnDcsDo = adminExposeInfoService.getInfoOpnDcsDetail(params);

        model.addAttribute("opnDcsDo", opnDcsDo);

        return "/admin/expose/popup/viewOpnDcsPopup";
    }

    /**
     * 청구서상세  팝업
     *
     * @param request
     * @param model
     * @param session
     * @return
     * @throws DataAccessException
     * @throws Exception
     */
    @RequestMapping("/admin/expose/popup/viewOpnAplPopup.do")
    public String viewOpnAplPopup(HttpServletRequest request, Model model, HttpSession session) throws DataAccessException, Exception {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        Map<String, Object> opnAplDo = adminExposeInfoService.getInfoOpenApplyDetail(params);

        model.addAttribute("opnAplDo", opnAplDo);

        Map<String, String> paramMap = new HashMap<String, String>();
        paramMap.put("srcAplNo", (String) opnAplDo.get("srcAplNo"));
        paramMap.put("aplNo", (String) opnAplDo.get("aplNo"));

        if (opnAplDo.get("srcAplNo") != null && opnAplDo.get("srcAplNo") != "") {
            model.addAttribute("FROM_TRST", (List<Map<String, Object>>) adminExposeInfoDao.selectFromTrst(paramMap)); //이송받은정보 조회
        } else {
            model.addAttribute("FROM_TRST", "");
        }
        model.addAttribute("TO_TRST", (List<Map<String, Object>>) adminExposeInfoDao.selectToTrst(paramMap)); //이송보낸정보 조회

        return "/admin/expose/popup/viewOpnAplPopup";
    }

    /**
     * 이의신청접수  팝업
     *
     * @param request
     * @param model
     * @param session
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/expose/popup/viewOpnObjtnPopup.do")
    public String viewOpnObjtnPopup(HttpServletRequest request, Model model, HttpSession session) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        Map<String, Object> opnObjtnDo = adminExposeInfoService.getOpnObjtnInfoDetail(params);

        model.addAttribute("opnObjtnDo", opnObjtnDo);

        return "/admin/expose/popup/viewOpnObjtnPopup";
    }

    /**
     * 청구서 목록 팝업
     *
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/expose/popup/searchOpnAplPopup.do")
    public String searchOpnAplPopup(HttpServletRequest request, ModelMap model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);

        return "/admin/expose/popup/searchOpnAplPopup";
    }

    /**
     * 청구서 열람페이지
     *
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/expose/searchOpnAplReadPage.do")
    public String searchOpnAplReadPage(HttpServletRequest request, ModelMap model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);

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

        return "/admin/expose/searchOpnAplRead";
    }

    /**
     * 정보공개 실명인증 세션을 등록한다.
     *
     * @param request HTTP 요청
     * @param model   모델
     * @return 뷰이름
     * @throws IOException
     * @throws GpkiApiException
     */
    @RequestMapping("/admin/expose/openLogin.do")
    public String openLogin(HttpServletRequest request, Model model) throws GpkiApiException, IOException {

        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        HashMap paramMap = new HashMap();
        paramMap.put("signCertPath", EgovProperties.getProperty("Globals.signCertPath"));
        paramMap.put("signKeyPath", EgovProperties.getProperty("Globals.signKeyPath"));
        paramMap.put("kmCertPath", EgovProperties.getProperty("Globals.kmCertPath"));
        paramMap.put("kmKeyPath", EgovProperties.getProperty("Globals.kmKeyPath"));
        paramMap.put("certPasswd", EgovProperties.getProperty("Globals.certPasswd"));

        String instCd = (String) params.get("inst_cd");
        String certNo = (String) params.get("cert_cd");
        String loginRno1 = (String) params.get("login_rno1");
        String loginRno2 = (String) params.get("login_rno2");
        String loginName = (String) params.get("login_name");
        String sData = instCd + "|" + certNo + "|01|" + loginRno1 + loginRno2 + "|" + loginName;
        paramMap.put("sData", sData);

        String result = "";
        String success = "";
        String msg = "";

        if (request.getRequestURL().substring(0, 16).equals("http://localhost")
                || request.getRequestURL().substring(0, 30).equals("http://softon.iptime.org:18021")) {
            success = "1";
        } else {
            //success = "1";
            //해당 부분은 추후 도메인 변경 후 반영 필요
            if (!StringUtils.isEmpty(instCd)) {
                result = GPKIClientSocket.GPKILoginCert(paramMap);
                success = result.substring(result.lastIndexOf("|") - 1, result.lastIndexOf("|"));
            }
        }

        if ("1".equals(success)) {

            msg = "실명 인증이 정상적으로 확인되었습니다.";
            params.put("msg", msg);
            params.put("result", success);
            addObject(model, params);
        } else {
            msg = "실명인증에 실패하였습니다.";
            params.put("msg", msg);
            addObject(model, params);
        }

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 정보공개 담당자 정보를 수정한다.
     *
     * @param request HTTP 요청
     * @param model   모델
     * @return 뷰이름
     */
    @RequestMapping("/admin/expose/updateOpnAplDept.do")
    public String updateOpnAplDept(HttpServletRequest request, Model model) {

        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        // 청구서작성 데이터를 등록
        Object result = adminExposeInfoService.updateOpnAplDept(params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 담당부서 정보조회
     */
    @RequestMapping(value = "/admin/expose/selectOpnzDeptList.do")
    public String selectOpnzDeptList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);

        Object result = adminExposeInfoService.selectOpnzDeptList(params);

        debug("Processing results: " + result);

        addObject(model, result);

        return "jsonView";
    }

    /**
     * 청구인정보 열람 로그
     */
    @RequestMapping("/admin/expose/insertLogAcsOpnzApl.do")
    @ResponseBody
    public void insertLogAcsOpnzApl(HttpServletRequest request, Model model) {
        Params params = getParams(request, false);
        String ip = StringUtils.defaultIfEmpty(request.getRemoteAddr(), "");
        if (StringUtils.equals("::1", ip) || StringUtils.equals("0:0:0:0:0:0:0:1", ip)) {
            // 로컬호스트 체크
            ip = "127.0.0.1";
        }
        params.put(RequestAttribute.USER_IP, ip);
        adminExposeInfoService.insertLogAcsOpnzApl(params);
    }


    /**
     * 이송  팝업
     *
     * @param request
     * @param model
     * @param session
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/expose/popup/opnInfoTrsfPopup.do")
    public String opnInfoTrsfPopup(HttpServletRequest request, Model model, HttpSession session) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        Map<String, Object> opnRcpDo = adminExposeInfoService.getInfoOpnAplSearch(params);

        model.addAttribute("opnRcpDo", opnRcpDo);

        // 이송한 적이 없는 청구대상기관
        model.addAttribute("instCodeList", adminExposeInfoService.selectNotTrstNaboOrg(params));

        return "/admin/expose/popup/opnInfoTrsfPopup";
    }

    /**
     * 신청연계 코드 저장
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/admin/expose/updateAplConnCd.do")
    public String updateAplConnCd(HttpServletRequest request, Model model) {
        Params params = getParams(request, false);
        Object result = adminExposeInfoService.updateAplConnCd(params);

        addObject(model, result);
        return "jsonView";
    }
}

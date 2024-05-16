/*
 * @(#)PortalExposeInfoController.java 1.0 2019/07/19
 *
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.expose.web;

import java.io.IOException;
import java.security.*;
import java.security.spec.RSAPublicKeySpec;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.crypto.Cipher;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.gpki.gpkiapi.exception.GpkiApiException;
import com.nprotect.pluginfree.PluginFree;
import com.nprotect.pluginfree.PluginFreeException;
import com.nprotect.pluginfree.modules.PluginFreeRequest;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.common.GPKIClientSocket;
import egovframework.common.base.constants.SessionAttribute;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.kcb.domain.CertInfo;
import egovframework.common.kcb.domain.KCBClient;
import egovframework.common.kcb.util.KCBCert;
import egovframework.common.kmc.domain.KMCClient;
import egovframework.common.kmc.util.KMCCert;
import egovframework.common.nice.domain.CheckPlusClient;
import egovframework.common.nice.domain.NiceCertInfo;
import egovframework.common.nice.util.NiceCert;
import egovframework.common.util.UtilObject;
import egovframework.ggportal.expose.service.PortalExposeInfoService;

/**
 * 정보공개 요청을 관리하는 컨트롤러 클래스이다.
 *
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Controller("portalExposeInfoController")
public class PortalExposeInfoController extends BaseController {
    /**
     * 정보공개 요청을 관리하는 서비스
     */
    @Resource(name = "portalExposeInfoService")
    private PortalExposeInfoService portalExposeInfoService;

    private static String RSA_WEB_KEY = "_RSA_WEB_Key_";
    private static String RSA_INSTANCE = "RSA";

    /**
     * 정보공개안내 화면으로 이동한다.
     *
     * @param request HTTP 요청
     * @param model   모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/exposeInfo/guideOpnInfoPage.do")
    public ModelAndView guideOpnInfoPage(HttpServletRequest request, Model model) {
        ModelAndView modelAndView = new ModelAndView();

        modelAndView.setViewName("/soportal/expose/guideOpnInfo");

        return modelAndView;
    }

    /**
     * 정보공개안내 팝업화면으로 이동한다.
     *
     * @param request HTTP 요청
     * @param model   모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/exposeInfo/provisionPopupPage.do")
    public String provisionPopupPage(HttpServletRequest request, Model model) {
        // 뷰이름을 반환한다.
        return "soportal/expose/provisionPopup";
    }

    /**
     * 정보공개 실명인증 화면으로 이동한다.
     *
     * @param request HTTP 요청
     * @param model   모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/expose/opnLoginPage.do")
    public ModelAndView opnLoginPage(HttpServletRequest request, Model model) {
        ModelAndView modelAndView = new ModelAndView();

        initRsa(modelAndView, request); //RSA 키 생성

        modelAndView.addObject("URL", "/portal/expose/writeAccountPage.do");
        modelAndView.setViewName("/soportal/expose/opnLogin");

        return modelAndView;
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
    @RequestMapping("/portal/expose/openLogin.do")
    public String openLogin(HttpServletRequest request, Model model, HttpSession session) throws GpkiApiException, IOException, Exception {

        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        HashMap paramMap = new HashMap();
        paramMap.put("signCertPath", EgovProperties.getProperty("Globals.signCertPath"));
        paramMap.put("signKeyPath", EgovProperties.getProperty("Globals.signKeyPath"));
        paramMap.put("kmCertPath", EgovProperties.getProperty("Globals.kmCertPath"));
        paramMap.put("kmKeyPath", EgovProperties.getProperty("Globals.kmKeyPath"));
        paramMap.put("certPasswd", EgovProperties.getProperty("Globals.certPasswd"));

        //잉카인터넷 - 마우스입력 복호화
        try {
            PluginFree.verify(request, new String[]{});
        } catch (PluginFreeException e) {
            debug("키보드보안/마우스입력기 복호화 검증 오류가 발생하였습니다.");
        } catch (Exception e) {
            debug("키보드보안/마우스입력기 복호화 검증 오류가 발생하였습니다.");
        }
        ServletRequest pluginfreeRequest = new PluginFreeRequest(request);
        String loginRno2 = "";

        String idKeyPad = (String) params.get("idKeyPad");

        if (idKeyPad != null && idKeyPad.equals("Y")) { //마우스 입력 > 잉카인터넷 복호화 처리
            loginRno2 = pluginfreeRequest.getParameter("login_rno2");
        } else { //키보드 입력 > RSA 복호화 처리
            PrivateKey privateKey = (PrivateKey) session.getAttribute(PortalExposeInfoController.RSA_WEB_KEY);
            String login_rno2_RSA = (String) params.get("login_rno2_RSA");

            // 복호화
            loginRno2 = decryptRsa(privateKey, login_rno2_RSA);
            // 개인키 삭제
            session.removeAttribute(PortalExposeInfoController.RSA_WEB_KEY);
        }

        String instCd = (String) params.get("inst_cd");
        String certNo = (String) params.get("cert_cd");
        String loginDiv = (String) params.get("login_div");
        String loginRno1 = (String) params.get("login_rno1");
        String loginName = (String) params.get("login_name");
        String url = (String) params.get("url");
        String sData = instCd + "|" + certNo + "|01|" + loginRno1 + loginRno2 + "|" + loginName;
        paramMap.put("sData", sData);

        String result = "";
        String success = "";
        String msg = "";

        if (request.getRequestURL().substring(0, 16).equals("http://localhost")
                || request.getRequestURL().substring(0, 30).equals("http://softon.iptime.org:18021")
                || request.getRequestURL().substring(0, 24).equals("http://192.168.0.3:18024")) {
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
            session.setAttribute("loginDiv", loginDiv);
            session.setAttribute("loginName", loginName);
            session.setAttribute("loginRno1", loginRno1);
            session.setAttribute("loginRno2", loginRno2);
            session.setAttribute("openUserIp", request.getRemoteAddr());

            msg = "실명 인증이 정상적으로 확인되었습니다.";
            params.put("msg", msg);
            params.put("result", success);
            addObject(model, params);
        } else {
            msg = "실명인증에 실패하였습니다.";
            params.put("msg", msg);
            params.put("result", "0");
            addObject(model, params);
        }

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 인증해제
     */
    @RequestMapping(value = "/portal/expose/certout.do")
    public String certout(HttpServletRequest request, HttpServletResponse response, HttpSession session) {

        session.removeAttribute("loginDiv");
        session.removeAttribute("loginName");
        session.removeAttribute("loginRno1");
        /*session.removeAttribute("loginRno2");*/
        session.removeAttribute("openUserIp");
        session.removeAttribute("dupInfo");
        session.removeAttribute("rauthTag");

        return "redirect:/portal/expose/writeAccountPage.do";
    }

    /**
     * 정보공개 청구서작성 화면으로 이동한다.
     *
     * @param request HTTP 요청
     * @param model   모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/expose/writeAccountPage.do")
    public ModelAndView writeAccountPage(HttpServletRequest request, Model model, HttpSession session) {
        ModelAndView modelAndView = new ModelAndView();
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        params.put("userCd", session.getAttribute(SessionAttribute.USER_CD)); //로그인사용자 키값

        debug("writeAccountPage Request parameters: " + params);

//		setLoginSession(session, params);

        //세션 검증
        if (isOpnLogin(request)) {    //실명인증 세션을 확인한다. 아니라면 실명인증 화면으로 강제이동

            //로그인 사용자의 청구기본정보를 가져온다. > 없을경우 아래 메세지를 호출하고 청구서정보를 저장한다.
            //청구인 기본정보를 저장하시면, 다음번 청구시에 개인정보를 입력하지 않으셔도 됩니다.
            //청구인 기본정보를 저장하시겠습니까?


            // 모델에 객체를 추가한다.
            // 청구대상기관
            modelAndView.addObject("instCodeList", portalExposeInfoService.selectNaboOrg(params));
            // 공개형태
            params.put("lclsCd", "A");
            modelAndView.addObject("lclsCodeList", portalExposeInfoService.selectComCode(params));
            // 수령방법
            params.put("lclsCd", "B");
            modelAndView.addObject("apitCodeList", portalExposeInfoService.selectComCode(params));
            // 감면여부
            params.put("lclsCd", "C");
            modelAndView.addObject("feerCodeList", portalExposeInfoService.selectComCode(params));

            modelAndView.addObject("loginDiv", (String) session.getAttribute("loginDiv"));
            modelAndView.addObject("loginName", (String) session.getAttribute("loginName"));
            modelAndView.addObject("loginRno1", (String) session.getAttribute("loginRno1"));
            modelAndView.addObject("loginRno2", (String) session.getAttribute("loginRno2"));
            // 실명인증 DI 값
            modelAndView.addObject("dupInfo", (String) session.getAttribute("dupInfo"));

            if (!UtilObject.isNull(params.getString("apl_no")) && !params.getString("apl_no").equals("")) {
                params.put("aplNo", params.getString("apl_no"));
                params.put("apl_rno1", (String) session.getAttribute("loginRno1"));
                params.put("apl_rno2", (String) session.getAttribute("loginRno2"));
                Map<String, Object> opnAplMap = portalExposeInfoService.getInfoOpenApplyDetail(params);

                if (opnAplMap.size() > 0) {
                    if (opnAplMap.get("aplPno") != null) {
                        modelAndView.addObject("phone1", ((String) opnAplMap.get("aplPno")).split("-")[0]);
                        modelAndView.addObject("phone2", ((String) opnAplMap.get("aplPno")).split("-")[1]);
                        modelAndView.addObject("phone3", ((String) opnAplMap.get("aplPno")).split("-")[2]);
                    } else {
                        modelAndView.addObject("phone1", "000");
                    }

                    if (opnAplMap.get("aplMblPno") != null) {
                        modelAndView.addObject("mPhone1", ((String) opnAplMap.get("aplMblPno")).split("-")[0]);
                        modelAndView.addObject("mPhone2", ((String) opnAplMap.get("aplMblPno")).split("-")[1]);
                        modelAndView.addObject("mPhone3", ((String) opnAplMap.get("aplMblPno")).split("-")[2]);
                    } else {
                        modelAndView.addObject("mPhone1", "000");
                    }

                    if (opnAplMap.get("aplFaxNo") != null) {
                        modelAndView.addObject("fax1", ((String) opnAplMap.get("aplFaxNo")).split("-")[0]);
                        modelAndView.addObject("fax2", ((String) opnAplMap.get("aplFaxNo")).split("-")[1]);
                        modelAndView.addObject("fax3", ((String) opnAplMap.get("aplFaxNo")).split("-")[2]);
                    } else {
                        modelAndView.addObject("fax1", "000");
                    }

                    if (opnAplMap.get("aplEmailAddr") != null) {
                        modelAndView.addObject("email1", ((String) opnAplMap.get("aplEmailAddr")).split("@")[0]);
                        modelAndView.addObject("email2", ((String) opnAplMap.get("aplEmailAddr")).split("@")[1]);
                    }
                    modelAndView.addObject("post", opnAplMap.get("aplZpno"));
                }
                modelAndView.addObject("opnAplDo", opnAplMap);
            }

            modelAndView.setViewName("/soportal/expose/writeAccount");
        } else {

            initRsa(modelAndView, request); //RSA 키 생성

            modelAndView.addObject("URL", "/portal/expose/writeAccountPage.do");
            modelAndView.setViewName("/soportal/expose/opnLogin");
        }
        return modelAndView;
    }

    /**
     * 정보공개 청구서작성 > 우편번호[도로명주소] 팝업화면으로 이동한다.
     *
     * @param request HTTP 요청
     * @param model   모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/expose/roadSearchAddrPage.do")
    public String zpnoPage(HttpServletRequest request, Model model) {
        // 뷰이름을 반환한다.
        return "portal/popup/jusoApiPop";
    }

    /**
     * 정보공개 청구서작성 > 우편번호[지번주소] 팝업화면으로 이동한다.
     *
     * @param request HTTP 요청
     * @param model   모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/expose/searchAddrPage.do")
    public String zpnoroadPage(HttpServletRequest request, Model model) {
        // 뷰이름을 반환한다.
        return "soportal/expose/searchAddress";
    }

    /**
     * 정보공개 청구서작성 데이터를 등록한다.
     *
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
//    @RequestMapping("/portal/expose/insertAccount.do")
//    public String insertAccount(HttpServletRequest request, Model model, HttpSession session) {
//
//		//세션 검증
//		if( isOpnLogin(request) ) {	//세션을 확인한다.
//			// 파라메터를 가져온다.
//	        Params params = getParams(request, false);
//
//	        debug("insertAccount parameters: " + params);
//
//	        //세션에서 정보를 가져와서 params에 담는다.
//	        params.put("aplNtfrDiv", (String) session.getAttribute("loginDiv"));
//	        params.put("aplPn", (String) session.getAttribute("loginName"));
//	        params.put("aplRno1", (String) session.getAttribute("loginRno1"));
//	        params.put("aplRno2", (String) session.getAttribute("loginRno2"));
//	        
//	        if ( StringUtils.isNotEmpty(params.getString("apl_no")) ) {//수정일 경우
//				//세션 검증 > 보안취약점 점검
//				String chkAplNo = (String) session.getAttribute("apl_no");
//				if(chkAplNo.equals(params.getString("apl_no"))) {	//세션을 확인한다. 아니라면 실명인증 화면으로 강제이동
//			        // 청구서작성 데이터를 등록
//			        Object result = portalExposeInfoService.insertAccount(request, params);
//			        debug("Processing results: " + result);
//			        // 모델에 객체를 추가한다.
//			        addObject(model, result);
//				}else{
//					addObject(model, "처리가 불가능한 청구서입니다.");
//				}
//	        }else{
//		        // 청구서작성 데이터를 등록
//		        Object result = portalExposeInfoService.insertAccount(request, params);
//		        debug("Processing results: " + result);
//		        // 모델에 객체를 추가한다.
//		        addObject(model, result);
//	        }
//		}else{
//			addObject(model, "Login is required");
//		}
//
//		// 뷰이름을 반환한다.
//        return "jsonView";
//    }

    /**
     * 정보공개 청구서작성 데이터를 등록한다.
     *
     * @param request HTTP 요청
     * @param model   모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/expose/insertAccount.do")
    public String insertAccount(HttpServletRequest request, Model model, HttpSession session) {

        //세션 검증
        if (isOpnLogin(request)) {    //세션을 확인한다.
            // 파라메터를 가져온다.
            Params params = getParams(request, false);

            debug("insertAccount parameters: " + params);

            //세션에서 정보를 가져와서 params에 담는다.
            params.put("aplNtfrDiv", (String) session.getAttribute("loginDiv"));
            params.put("aplPn", (String) session.getAttribute("loginName"));
            params.put("aplRno1", (String) session.getAttribute("loginRno1"));
            //params.put("aplRno2", (String) session.getAttribute("loginRno2"));
            params.put("aplDi", (String) session.getAttribute("dupInfo"));

            // 청구서작성 데이터를 등록
            Object result = portalExposeInfoService.insertAccount(request, params);

            debug("Processing results: " + result);

            // 모델에 객체를 추가한다.
            addObject(model, result);
        } else {
            addObject(model, "Login is required");
        }

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 정보공개 청구서처리현황 화면으로 이동한다.
     *
     * @param request HTTP 요청
     * @param model   모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/expose/searchAccountPage.do")
    public ModelAndView searchAccountPage(HttpServletRequest request, Model model, HttpSession session) {
        ModelAndView modelAndView = new ModelAndView();
        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

//        setLoginSession(session, params);

        //세션 검증
        if (isOpnLogin(request)) {    //세션을 확인한다. 아니라면 실명인증 화면으로 강제이동

            // 모델에 객체를 추가한다.
            // 청구대상기관
            modelAndView.addObject("instCodeList", portalExposeInfoService.selectNaboOrg(params));
            // 처리상태
            params.put("lclsCd", "D");
            modelAndView.addObject("pStateCodeList", portalExposeInfoService.selectComCode(params));
            // 공개여부
            params.put("lclsCd", "A");
            modelAndView.addObject("lclsCodeList", portalExposeInfoService.selectComCode(params));

            modelAndView.setViewName("/soportal/expose/searchAccount");
        } else {

            initRsa(modelAndView, request); //RSA 키 생성

            modelAndView.addObject("URL", "/portal/expose/searchAccountPage.do");
            modelAndView.setViewName("/soportal/expose/opnLogin");
        }
        return modelAndView;
    }

    /**
     * 정보공개 청구서처리현황 내역을 검색한다.
     *
     * @param request HTTP 요청
     * @param model   모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/expose/searchAccount.do")
    public String searchAccount(HttpServletRequest request, Model model, HttpSession session) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        //세션 검증
        if ((String) session.getAttribute("dupInfo") != null) {    //세션을 확인한다. 아니라면 실명인증 화면으로 강제이동

            //세션정보 params에 담아 [본인]의 데이터를 호출한다.
            params.put("aplPn", (String) session.getAttribute("loginName"));
            params.put("aplRno1", (String) session.getAttribute("loginRno1"));
            params.put("aplRno2", (String) session.getAttribute("loginRno2"));
            params.put("aplDi", (String) session.getAttribute("dupInfo"));

            debug("Request parameters: " + params);

            // 내용을 검색한다.
            Object result = portalExposeInfoService.searchAccount(params);

            debug("Processing results: " + result);

            // 모델에 객체를 추가한다.
            addObject(model, result);
        } else {
            addObject(model, "Login is required");
        }
        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 정보공개 청구서처리현황 내용을 조회하는 화면으로 이동한다.
     *
     * @param request HTTP 요청
     * @param model   모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/expose/selectAccountPage.do")
    public ModelAndView selectAccountPage(HttpServletRequest request, Model model, HttpSession session) {
        ModelAndView modelAndView = new ModelAndView();

        //세션 검증
        if ((String) session.getAttribute("dupInfo") != null) {    //세션을 확인한다. 아니라면 실명인증 화면으로 강제이동
            // 파라메터를 가져온다.
            Params params = getParams(request, false);

            debug("Request parameters: " + params);

            if (params.getString("apl_no") != null) {
                params.put("aplNo", params.getString("apl_no"));
                session.setAttribute("apl_no", params.getString("apl_no")); //보안취약점 처리를 위해 세션 저장
                params.put("apl_rno1", (String) session.getAttribute("loginRno1"));
                params.put("apl_rno2", (String) session.getAttribute("loginRno2"));
                List<?> opnHistList = portalExposeInfoService.getInfoOpenApplyHist(params);
                Map<String, Object> opnAplMap = portalExposeInfoService.getInfoOpenApplyDetail(params);

                modelAndView.addObject("opnHistList", opnHistList);
                modelAndView.addObject("opnAplDo", opnAplMap);
            }

            modelAndView.setViewName("/soportal/expose/selectAccount");
        } else {

            initRsa(modelAndView, request); //RSA 키 생성

            modelAndView.addObject("URL", "/portal/expose/searchAccountPage.do");
            modelAndView.setViewName("/soportal/expose/opnLogin");
        }
        return modelAndView;
    }

    /**
     * 정보공개 청구취하한다.
     *
     * @param request HTTP 요청
     * @param model   모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/expose/withdrawAccount.do")
    public String withdrawAccount(HttpServletRequest request, Model model, HttpSession session) {

        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        //세션 검증
        if ((String) session.getAttribute("dupInfo") != null) {    //세션을 확인한다. 아니라면 실명인증 화면으로 강제이동

            //세션 검증 > 보안취약점 점검
            //String chkAplNo = (String) session.getAttribute("apl_no");
            //if(chkAplNo != null && chkAplNo.equals(params.getString("apl_no"))) {	//세션을 확인한다. 아니라면 실명인증 화면으로 강제이동
            //세션정보 params에 담아 [본인]의 데이터를 호출한다.
            params.put("apl_pn", (String) session.getAttribute("loginName"));
            params.put("apl_rno1", (String) session.getAttribute("loginRno1"));
            params.put("apl_rno2", (String) session.getAttribute("loginRno2"));

            debug("withdrawAccount parameters: " + params);

            String prgStatCd = portalExposeInfoService.getPrgStatCd((String) params.getString("apl_no"));
            if (prgStatCd.equals("01") || prgStatCd.equals("02") || prgStatCd.equals("03")) {
                // 청구취하한다.
                Object result = portalExposeInfoService.withdrawAccount(request, params);

                debug("Processing results: " + result);

                // 모델에 객체를 추가한다.
                addObject(model, result);
            } else {
                addObject(model, "처리가 불가능한 청구서입니다.");
            }
        } else {
            addObject(model, "처리가 불가능한 청구서입니다.");
        }

//		}else{
//			addObject(model, "Login is required");
//		}

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 정보공개 이의신청서 화면으로 이동한다.
     *
     * @param request HTTP 요청
     * @param model   모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/expose/targetObjectionPage.do")
    public ModelAndView targetObjectionPage(HttpServletRequest request, Model model, HttpSession session) {
        ModelAndView modelAndView = new ModelAndView();
        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

//        setLoginSession(session, params);

        //세션 검증
        if (isOpnLogin(request)) {    //세션을 확인한다. 아니라면 실명인증 화면으로 강제이동

            // 모델에 객체를 추가한다.
            // 청구대상기관
            modelAndView.addObject("instCodeList", portalExposeInfoService.selectNaboOrg(params));
            // 처리상태
            params.put("lclsCd", "D");
            modelAndView.addObject("pStateCodeList", portalExposeInfoService.selectComCode(params));

            modelAndView.setViewName("/soportal/expose/targetObjection");
        } else {

            initRsa(modelAndView, request); //RSA 키 생성

            modelAndView.addObject("URL", "/portal/expose/targetObjectionPage.do");
            modelAndView.setViewName("/soportal/expose/opnLogin");
        }
        return modelAndView;
    }

    /**
     * 정보공개 이의신청서 대상 내역을 검색한다.
     *
     * @param request HTTP 요청
     * @param model   모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/expose/targetObjection.do")
    public String targetObjection(HttpServletRequest request, Model model, HttpSession session) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        //세션 검증
        if ((String) session.getAttribute("dupInfo") != null) {    //세션을 확인한다. 아니라면 실명인증 화면으로 강제이동

            //세션정보 params에 담아 [본인]의 데이터를 호출한다.
            params.put("aplPn", (String) session.getAttribute("loginName"));
            params.put("aplRno1", (String) session.getAttribute("loginRno1"));
            params.put("aplRno2", (String) session.getAttribute("loginRno2"));
            params.put("aplDi", (String) session.getAttribute("dupInfo"));

            debug("targetObjection parameters: " + params);

            // 내용을 검색한다.
            Object result = portalExposeInfoService.targetObjection(params);

            debug("Processing results: " + result);

            // 모델에 객체를 추가한다.
            addObject(model, result);
        } else {
            addObject(model, "Login is required");
        }

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 이의신청서 작성 화면으로 이동한다.
     *
     * @param request HTTP 요청
     * @param model   모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/expose/writeObjectionPage.do")
    public ModelAndView writeObjectionPage(HttpServletRequest request, Model model, HttpSession session) {
        ModelAndView modelAndView = new ModelAndView();

        //세션 검증
        if ((String) session.getAttribute("dupInfo") != null) {    //세션을 확인한다. 아니라면 실명인증 화면으로 강제이동
            // 파라메터를 가져온다.
            Params params = getParams(request, false);

            debug("writeObjectionPage Request parameters: " + params);

            // 모델에 객체를 추가한다.
            modelAndView.addObject("loginDiv", (String) session.getAttribute("loginDiv"));
            modelAndView.addObject("loginName", (String) session.getAttribute("loginName"));
            modelAndView.addObject("loginRno", (String) session.getAttribute("loginRno1") + session.getAttribute("loginRno2"));
            modelAndView.addObject("dupInfo", (String) session.getAttribute("dupInfo")); // 실명인증 DI 값

            if (!UtilObject.isNull(params.getString("apl_no")) && !params.getString("apl_no").equals("")) {
                params.put("aplNo", params.getString("apl_no"));
                params.put("apl_rno1", (String) session.getAttribute("loginRno1"));
                params.put("apl_rno2", (String) session.getAttribute("loginRno2"));

                Map<String, Object> opnObjtnMap = portalExposeInfoService.getWriteBaseInfo(params);
                modelAndView.addObject("opnObjtnDo", opnObjtnMap);
                List<?> clsdList = portalExposeInfoService.selectOpnDcsClsd(params);
                modelAndView.addObject("clsdList", clsdList);
            }
            modelAndView.setViewName("/soportal/expose/writeObjection");
        } else {

            initRsa(modelAndView, request); //RSA 키 생성

            modelAndView.addObject("URL", "/portal/expose/targetObjectionPage.do");
            modelAndView.setViewName("/soportal/expose/opnLogin");
        }
        return modelAndView;
    }

    /**
     * 이의신청서 수정 화면으로 이동한다.
     *
     * @param request HTTP 요청
     * @param model   모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/expose/updateObjectionPage.do")
    public ModelAndView updateObjectionPage(HttpServletRequest request, Model model, HttpSession session) {
        ModelAndView modelAndView = new ModelAndView();

        //세션 검증
        if ((String) session.getAttribute("dupInfo") != null) {    //세션을 확인한다. 아니라면 실명인증 화면으로 강제이동
            // 파라메터를 가져온다.
            Params params = getParams(request, false);
            if (request.getParameter("apl_attch_delete") == null) params.put("apl_attch_delete", "");

            debug("writeObjectionPage Request parameters: " + params);

            // 모델에 객체를 추가한다.
            modelAndView.addObject("loginDiv", (String) session.getAttribute("loginDiv"));
            modelAndView.addObject("loginName", (String) session.getAttribute("loginName"));
            modelAndView.addObject("loginRno", (String) session.getAttribute("loginRno1") + session.getAttribute("loginRno2"));
            modelAndView.addObject("dupInfo", (String) session.getAttribute("dupInfo")); // 실명인증 DI 값

            if (!UtilObject.isNull(params.getString("apl_no")) && !params.getString("apl_no").equals("")) {
                params.put("aplNo", params.getString("apl_no"));
                params.put("apl_rno1", (String) session.getAttribute("loginRno1"));
                params.put("apl_rno2", (String) session.getAttribute("loginRno2"));
                params.put("aplDi", (String) session.getAttribute("dupInfo")); // 실명인증 DI 값

                Map<String, Object> opnObjtnMap = portalExposeInfoService.getUpdateBaseInfo(params);
                modelAndView.addObject("opnObjtnDo", opnObjtnMap);
                List<?> clsdList = portalExposeInfoService.selectOpnDcsClsd(params);
                modelAndView.addObject("clsdList", clsdList);
                List<?> clsdChkList = portalExposeInfoService.selectOpnDcsChkClsd(params);
                modelAndView.addObject("clsdChkList", clsdChkList);
            }
            modelAndView.setViewName("/soportal/expose/writeObjection");
        } else {

            initRsa(modelAndView, request); //RSA 키 생성

            modelAndView.addObject("URL", "/portal/expose/targetObjectionPage.do");
            modelAndView.setViewName("/soportal/expose/opnLogin");
        }
        return modelAndView;
    }

    /**
     * 정보공개 이의신청서 처리현황 화면으로 이동한다.
     *
     * @param request HTTP 요청
     * @param model   모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/expose/searchObjectionPage.do")
    public ModelAndView searchObjectionPage(HttpServletRequest request, Model model, HttpSession session) {
        ModelAndView modelAndView = new ModelAndView();
        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

//        setLoginSession(session, params);

        //세션 검증
        if (isOpnLogin(request)) {    //세션을 확인한다. 아니라면 실명인증 화면으로 강제이동


            // 모델에 객체를 추가한다.
            // 청구대상기관
            modelAndView.addObject("instCodeList", portalExposeInfoService.selectNaboOrg(params));
            // 처리상태
            params.put("lclsCd", "D");
            modelAndView.addObject("pStateCodeList", portalExposeInfoService.selectComCode(params));

            modelAndView.setViewName("/soportal/expose/searchObjection");
        } else {

            initRsa(modelAndView, request); //RSA 키 생성

            modelAndView.addObject("URL", "/portal/expose/searchObjectionPage.do");
            modelAndView.setViewName("/soportal/expose/opnLogin");
        }
        return modelAndView;
    }

    /**
     * 정보공개 이의신청서 작성 데이터를 등록한다.
     *
     * @param request HTTP 요청
     * @param model   모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/expose/insertObjection.do")
    public String insertObjection(HttpServletRequest request, Model model, HttpSession session) {

        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        //세션에서 정보를 가져와서 params에 담는다.
        params.put("aplNtfrDiv", (String) session.getAttribute("loginDiv"));
        params.put("aplPn", (String) session.getAttribute("loginName"));
        params.put("aplRno1", (String) session.getAttribute("loginRno1"));
        params.put("aplRno2", (String) session.getAttribute("loginRno2"));
        params.put("aplDi", (String) session.getAttribute("dupInfo")); // 실명인증 DI 값

        //  이의신청서작성 데이터를 등록
        Object result = portalExposeInfoService.insertObjection(request, params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 정보공개 이의신청서 작성 데이터를 수정한다.
     *
     * @param request HTTP 요청
     * @param model   모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/expose/updateObjection.do")
    public String updateObjection(HttpServletRequest request, Model model, HttpSession session) {

        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        //세션에서 정보를 가져와서 params에 담는다.
        params.put("aplNtfrDiv", (String) session.getAttribute("loginDiv"));
        params.put("aplPn", (String) session.getAttribute("loginName"));
        params.put("aplRno1", (String) session.getAttribute("loginRno1"));
        params.put("aplRno2", (String) session.getAttribute("loginRno2"));
        params.put("aplDi", (String) session.getAttribute("dupInfo")); // 실명인증 DI 값

        //  이의신청서작성 데이터를 수정
        Object result = portalExposeInfoService.updateObjection(request, params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 정보공개 이의신청서 처리현황 내역을 검색한다.
     *
     * @param request HTTP 요청
     * @param model   모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/expose/searchObjection.do")
    public String searchObjection(HttpServletRequest request, Model model, HttpSession session) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        //세션정보 params에 담아 [본인]의 데이터를 호출한다.
        params.put("aplPn", (String) session.getAttribute("loginName"));
        params.put("aplRno1", (String) session.getAttribute("loginRno1"));
        params.put("aplRno2", (String) session.getAttribute("loginRno2"));
        params.put("aplRno", (String) session.getAttribute("loginRno1") + (String) session.getAttribute("loginRno2"));
        params.put("aplDi", (String) session.getAttribute("dupInfo")); // 실명인증 DI 값

        debug("Request parameters: " + params);

        // 내용을 검색한다.
        Object result = portalExposeInfoService.searchObjection(params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 정보공개 이의신청서 내용을 조회하는 화면으로 이동한다.
     *
     * @param request HTTP 요청
     * @param model   모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/expose/selectObjectionPage.do")
    public ModelAndView selectObjectionPage(HttpServletRequest request, Model model, HttpSession session) {
        ModelAndView modelAndView = new ModelAndView();

        //세션 검증
        if ((String) session.getAttribute("dupInfo") != null) {    //세션을 확인한다. 아니라면 실명인증 화면으로 강제이동
            // 파라메터를 가져온다.
            Params params = getParams(request, false);

            debug("Request parameters: " + params);

            if (params.getString("apl_no") != null) {
                params.put("aplNo", params.getString("apl_no"));
                params.put("apl_rno1", (String) session.getAttribute("loginRno1"));
                params.put("apl_rno2", (String) session.getAttribute("loginRno2"));

                List<?> objtnHist = portalExposeInfoService.getObjtnHist(params);
                Map<String, Object> objtnInfoMap = portalExposeInfoService.getOpnObjtnDetail(params);

                modelAndView.addObject("opnObjtnHist", objtnHist);
                modelAndView.addObject("opnObjtnDo", objtnInfoMap);
            }

            modelAndView.setViewName("/soportal/expose/selectObjection");
        } else {

            initRsa(modelAndView, request); //RSA 키 생성

            modelAndView.addObject("URL", "/portal/expose/searchObjectionPage.do");
            modelAndView.setViewName("/soportal/expose/opnLogin");
        }
        return modelAndView;
    }

    /**
     * 정보공개 이의신청서를 이의취하한다.
     *
     * @param request HTTP 요청
     * @param model   모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/expose/withdrawObjection.do")
    public String withdrawObjection(HttpServletRequest request, Model model, HttpSession session) {

        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        //세션에서 정보를 가져와서 params에 담는다.
        params.put("aplNtfrDiv", (String) session.getAttribute("loginDiv"));
        params.put("aplPn", (String) session.getAttribute("loginName"));
        params.put("aplRno1", (String) session.getAttribute("loginRno1"));
        params.put("aplRno2", (String) session.getAttribute("loginRno2"));
        params.put("aplDi", (String) session.getAttribute("dupInfo")); // 실명인증 DI 값

        //  이의신청서작성 데이터를 이의취하한다.
        Object result = portalExposeInfoService.withdrawObjection(request, params);

        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 정보공개 청구/이의신청  출력
     *
     * @param request HTTP 요청
     * @param model   모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/expose/reportingPage/{printId}.do")
    public ModelAndView printObjtn(@PathVariable("printId") String printId, HttpServletRequest request, Model model, HttpSession session) {
        ModelAndView modelAndView = new ModelAndView();

        //세션 검증
        if ((String) session.getAttribute("dupInfo") != null) {    //세션을 확인한다. 아니라면 실명인증 화면으로 강제이동
            // 파라메터를 가져온다.
            Params params = getParams(request, false);

            debug("Request parameters: " + params);

            if (params.getString("apl_no") != null && !params.get("mrdParam").equals("")) {

                params.put("aplNo", params.getString("apl_no"));
                params.put("apl_rno1", (String) session.getAttribute("loginRno1"));
                params.put("apl_rno2", (String) session.getAttribute("loginRno2"));

                modelAndView.addObject("width", params.get("width"));
                modelAndView.addObject("height", params.get("height"));
                modelAndView.addObject("title", params.get("title"));
                modelAndView.addObject("mrdParam", params.get("mrdParam"));

                modelAndView.addObject("mrdPath", EgovProperties.getProperty("Globals." + printId));
            } else {
                String msg = "비정상적 접근입니다.";
                modelAndView.addObject("msg", msg);
            }

            modelAndView.setViewName("/soportal/expose/rdCommon");
        }
        return modelAndView;
    }

    /**
     * 첨부파일 다운로드
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/portal/expose/downloadOpnAplFile.do")
    public String downloadOpnAplFile(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);


        Object result = portalExposeInfoService.downloadOpnAplFile(params);
        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "fileDownloadView";
    }

    /**
     * 양식파일 다운로드
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/portal/exposeInfo/downloadBasicFile.do")
    public String downloadBasicFile(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);


        Object result = portalExposeInfoService.downloadBasicFile(params);
        debug("Processing results: " + result);

        // 모델에 객체를 추가한다.
        addObject(model, result);

        // 뷰이름을 반환한다.
        return "fileDownloadView";
    }

    /**
     * nProtect sample
     *
     * @param request HTTP 요청
     * @param model   모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/expose/examples1.do")
    public ModelAndView examples1(HttpServletRequest request, Model model) {
        ModelAndView modelAndView = new ModelAndView();

        modelAndView.setViewName("/soportal/expose/examples/index");

        return modelAndView;
    }

    /**
     * 정보공개 업무추진비 화면으로 이동한다.
     *
     * @param request HTTP 요청
     * @param model   모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/expose/searchWorkPayPage.do")
    public ModelAndView searchWorkPayPage(HttpServletRequest request, Model model, HttpSession session) {
        ModelAndView modelAndView = new ModelAndView();

        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        // 모델에 객체를 추가한다.
        // 담당기관
        modelAndView.addObject("instCodeList", portalExposeInfoService.selectNaboOrg(params));

        modelAndView.setViewName("/soportal/expose/searchWorkPay");

        return modelAndView;
    }

    /**
     * 정보공개 세입·세출예산운용 화면으로 이동한다.
     *
     * @param request HTTP 요청
     * @param model   모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/expose/searchBudgetFundPage.do")
    public ModelAndView searchBudgetFundPage(HttpServletRequest request, Model model, HttpSession session) {
        ModelAndView modelAndView = new ModelAndView();

        // 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        modelAndView.setViewName("/soportal/expose/searchBudgetFund");

        return modelAndView;
    }

    /**
     * 청구 기본정보(사용자정보) 입력
     */
    @RequestMapping("/portal/expose/updateExposeDefaultInfo.do")
    public String updateExposeDefaultInfo(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);
        Object result = portalExposeInfoService.updateExposeDefaultInfo(params);

        addObject(model, result);
        return "jsonView";
    }

    /**
     * 정보공개 로그인 여부 체크
     */
    public boolean isOpnLogin(HttpServletRequest request) {
        boolean result = false;

        HttpSession session = request.getSession();
        if (StringUtils.isNotEmpty((String) session.getAttribute("dupInfo"))) {
            result = true;
        }

        return result;
    }

    /**
     * rsa 공개키, 개인키 생성
     *
     * @param request
     */
    public void initRsa(ModelAndView modelAndView, HttpServletRequest request) {
        HttpSession session = request.getSession();

        KeyPairGenerator generator;
        try {
            generator = KeyPairGenerator.getInstance(PortalExposeInfoController.RSA_INSTANCE);
            generator.initialize(1024);

            KeyPair keyPair = generator.genKeyPair();
            KeyFactory keyFactory = KeyFactory.getInstance(PortalExposeInfoController.RSA_INSTANCE);
            PublicKey publicKey = keyPair.getPublic();
            PrivateKey privateKey = keyPair.getPrivate();

            session.setAttribute(PortalExposeInfoController.RSA_WEB_KEY, privateKey); // session에 RSA 개인키를 세션에 저장

            RSAPublicKeySpec publicSpec = (RSAPublicKeySpec) keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);
            String publicKeyModulus = publicSpec.getModulus().toString(16);
            String publicKeyExponent = publicSpec.getPublicExponent().toString(16);

            modelAndView.addObject("RSAModulus", publicKeyModulus);
            modelAndView.addObject("RSAExponent", publicKeyExponent);

        } catch (Exception e) {
            debug("rsa 공개키, 개인키 생성에 실패하였습니다.");
        }
    }

    /**
     * rsa 복호화
     *
     * @param privateKey
     * @param securedValue
     * @return
     * @throws Exception
     */
    private String decryptRsa(PrivateKey privateKey, String securedValue) throws Exception {
        Cipher cipher = Cipher.getInstance(PortalExposeInfoController.RSA_INSTANCE);
        byte[] encryptedBytes = hexToByteArray(securedValue);
        cipher.init(Cipher.DECRYPT_MODE, privateKey);
        byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
        String decryptedValue = new String(decryptedBytes, "utf-8"); // 문자 인코딩 주의.
        return decryptedValue;
    }

    /**
     * 16진 문자열을 byte 배열로 변환한다.
     *
     * @param hex
     * @return
     */
    public static byte[] hexToByteArray(String hex) {
        if (hex == null || hex.length() % 2 != 0) {
            return new byte[]{};
        }

        byte[] bytes = new byte[hex.length() / 2];
        for (int i = 0; i < hex.length(); i += 2) {
            byte value = (byte) Integer.parseInt(hex.substring(i, i + 2), 16);
            bytes[(int) Math.floor(i / 2)] = value;
        }
        return bytes;
    }

    /**
     * KCB 휴대전화 인증
     *
     * @param kcbClient
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("/portal/expose/kcb/selectCertPlus.do")
    public ResponseEntity<?> selectCertPlusForm(@ModelAttribute("kcbVO") KCBClient kcbClient, HttpServletRequest request, HttpServletResponse response) throws Exception {

        KCBCert.getCheckPlusForm(kcbClient);

//        String resultCd = kcbClient.getResultCd();
//        String resultMsg = kcbClient.getResultMsg();
//        String mdlTkn = kcbClient.getMdlToken();

        return new ResponseEntity<KCBClient>(kcbClient, HttpStatus.OK);
    }

    /**
     * KCB 휴대전화 인증 결과 값
     *
     * @param kcbClient
     * @param request
     * @param response
     * @param session
     * @throws Exception
     */
    @RequestMapping("/portal/expose/kcb/certPlusResult.do")
    public void certPlusResult(@ModelAttribute("kcbVO") KCBClient kcbClient, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

        kcbClient.setMdlToken(request.getParameter("mdl_tkn"));
        KCBCert.getCheckPlusResult(kcbClient);
        String resultCode = kcbClient.getResultCd();
        String alertMessage;
        CertInfo certInfo = new CertInfo();
        if (resultCode.equals("B000")) {

            certInfo.setName(kcbClient.getName());
            certInfo.setDupInfo(kcbClient.getDupInfo());
            certInfo.setBirthDate(kcbClient.getBirthDate());
            certInfo.setGender(kcbClient.getGenderCode());
            certInfo.setNationalInfo(kcbClient.getNationalInfo());

            String loginDiv = (kcbClient.getNationalInfo()).equals("L") ? "1" : "0"; // 청구인 구분 : 내국인(1), 외국인 (0)  

            session.setAttribute("loginDiv", loginDiv);
            session.setAttribute("loginName", kcbClient.getName());
            session.setAttribute("loginRno1", kcbClient.getBirthDate());
            session.setAttribute("dupInfo", kcbClient.getDupInfo());
            session.setAttribute("openUserIp", request.getRemoteAddr());
            session.setAttribute("rauthTag", "H"); // 본인인증구분 #없음(N), I-PIN(P), 휴대폰인증(H)

            alertMessage = "인증되었습니다.";
        } else {
            alertMessage = "인증에 실패하였습니다.";
        }

        Gson gson = new Gson();
        String jsonCertInfo = gson.toJson(certInfo);


        StringBuilder builder = new StringBuilder();
        builder.append("<html>");
        builder.append("<head>");
        builder.append("<meta charset=\"utf-8\">");
        builder.append("<script type=\"text/javascript\">");
        builder.append("alert(\"").append(alertMessage).append("\");");
        if (resultCode.equals("B000")) {
            builder.append("window.opener.fnKcbCallBack(");
            builder.append(jsonCertInfo).append(");");
        }
        builder.append("window.close();");
        builder.append("</script>");
        builder.append("</head>");
        builder.append("</html>");

        response.setContentType("text/html;charset=UTF-8");
        response.getWriter().write(builder.toString());
    }

    /**
     * KMC 본인인증 요청
     *
     * @param kmcClient
     * @return
     * @throws Exception
     */
    @RequestMapping("/portal/expose/kmc/selectKmcCert.do")
    public ResponseEntity<?> selectKmcCertForm(@ModelAttribute("kmcVO") KMCClient kmcClient) throws Exception {

        KMCCert.getCheckPlusForm(kmcClient);

        return new ResponseEntity<KMCClient>(kmcClient, HttpStatus.OK);
    }

    /**
     * KMC 본인 인증 결과 값
     *
     * @param kmcClient
     * @param request
     * @param response
     * @param session
     * @throws Exception
     */
    @RequestMapping("/portal/expose/kmc/kmcCertResult.do")
    public void kmcCertResult(@ModelAttribute("kmcVO") KMCClient kmcClient, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

        KMCCert.getCheckPlusResult(kmcClient);

        String result = kmcClient.getResult();
        String alertMessage;
        CertInfo certInfo = new CertInfo();

        if (result.equals("Y")) {
            certInfo.setName(kmcClient.getName());
            certInfo.setDupInfo(kmcClient.getDI());
            certInfo.setBirthDate(kmcClient.getBirthDay());
            certInfo.setGender(kmcClient.getGender().equals("0") ? "M" : "F");
            certInfo.setNationalInfo(kmcClient.getNation().equals("0") ? "L" : "F");

            String loginDiv = certInfo.getNationalInfo().equals("L") ? "1" : "0"; // 청구인 구분 : 내국인(1), 외국인 (0)

            session.setAttribute("loginDiv", loginDiv);
            session.setAttribute("loginName", kmcClient.getName());
            session.setAttribute("loginRno1", kmcClient.getBirthDay());
            session.setAttribute("dupInfo", kmcClient.getDI());
            session.setAttribute("openUserIp", request.getRemoteAddr());
//			session.setAttribute("rauthTag", "H"); // 본인인증구분 #없음(N), I-PIN(P), 휴대폰인증(H)
            session.setAttribute("rauthTag", kmcClient.getCertMet()); // 본인인증구분 : 휴대폰인증(M), 공동인증서(P

            alertMessage = "인증되었습니다.";
        } else {
            alertMessage = "인증에 실패하였습니다.";
        }

        Gson gson = new Gson();
        String jsonCertInfo = gson.toJson(certInfo);

        StringBuilder builder = new StringBuilder();
        builder.append("<html>");
        builder.append("<head>");
        builder.append("<meta charset=\"utf-8\">");
        builder.append("<script type=\"text/javascript\">");
        builder.append("alert(\"").append(alertMessage).append("\");");
        if (result.equals("Y")) {
            builder.append("window.opener.fnKcbCallBack(");
            builder.append(jsonCertInfo).append(");");
        }
        builder.append("window.close();");
        builder.append("</script>");
        builder.append("</head>");
        builder.append("</html>");

        response.setContentType("text/html;charset=UTF-8");
        response.getWriter().write(builder.toString());
    }

    /**
     * KCB 아이핀 인증
     *
     * @param kcbClient
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("/portal/expose/kcb/selectIPin.do")
    public ResponseEntity<?> selectIPinForm(@ModelAttribute("kcbVO") KCBClient kcbClient, HttpServletRequest request, HttpServletResponse response) throws Exception {

        KCBCert.getIPinForm(kcbClient);

//        String resultCd = kcbClient.getResultCd();
//        String resultMsg = kcbClient.getResultMsg();
//        String mdlTkn = kcbClient.getMdlToken();

        return new ResponseEntity<KCBClient>(kcbClient, HttpStatus.OK);
    }

    /**
     * KCB 아이핀 인증 결과 값
     *
     * @param kcbClient
     * @param request
     * @param response
     * @param session
     * @throws Exception
     */
    @RequestMapping("/portal/expose/kcb/certIPinResult.do")
    public void certIPinResult(@ModelAttribute("kcbVO") KCBClient kcbClient, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

        kcbClient.setMdlToken(request.getParameter("MDL_TKN"));
        KCBCert.getIPinResult(kcbClient);

        String resultCode = kcbClient.getResultCd();
        String alertMessage;
        CertInfo certInfo = new CertInfo();

        if (resultCode.equals("T000")) {

            certInfo.setName(kcbClient.getName());
            certInfo.setBirthDate(kcbClient.getBirthDate());
            certInfo.setGender(kcbClient.getGenderCode());
            certInfo.setNationalInfo(kcbClient.getNationalInfo());
            certInfo.setDupInfo(kcbClient.getDupInfo());

            String loginDiv = (kcbClient.getNationalInfo()).equals("L") ? "1" : "0"; // 청구인 구분 : 내국인(1), 외국인 (0)  

            session.setAttribute("loginDiv", loginDiv);
            session.setAttribute("loginName", kcbClient.getName());
            session.setAttribute("loginRno1", kcbClient.getBirthDate());
            session.setAttribute("dupInfo", kcbClient.getDupInfo());
            session.setAttribute("openUserIp", request.getRemoteAddr());
            session.setAttribute("rauthTag", "P"); // 본인인증구분 #없음(N), I-PIN(P), 휴대폰인증(H)

            alertMessage = "인증되었습니다.";
        } else {
            alertMessage = "인증에 실패하였습니다.";
        }

        Gson gson = new Gson();
        String jsonCertInfo = gson.toJson(certInfo);

        StringBuilder builder = new StringBuilder();
        builder.append("<html>");
        builder.append("<head>");
        builder.append("<meta charset=\"utf-8\">");
        builder.append("<script type=\"text/javascript\">");
        builder.append("alert(\"").append(alertMessage).append("\");");
        if (resultCode.equals("T000")) {
            builder.append("window.opener.fnKcbCallBack(");
            builder.append(jsonCertInfo).append(");");
        }
        builder.append("window.close();");
        builder.append("</script>");
        builder.append("</head>");
        builder.append("</html>");

        response.setContentType("text/html;charset=UTF-8");
        response.getWriter().write(builder.toString());
    }

    /**
     * NICE 본인인증 요청
     */
    @RequestMapping(value = "/portal/expose/nice/selectNiceCertPlus.do")
    public ResponseEntity<?> selectNiceCertPlusForm(@ModelAttribute("niceVO") CheckPlusClient checkPlusClient, HttpServletRequest request) throws Exception {

        NiceCert.getCheckPlusForm(checkPlusClient, request);

        log.debug("REQ_SEQ          : [" + request.getSession().getAttribute("REQ_SEQ") + "]");
        log.debug("Return Code      : [" + checkPlusClient.getIReturn() + "]");
        log.debug("Return Message   : [" + checkPlusClient.getSMessage() + "]");
        log.debug("Enc Data         : [" + checkPlusClient.getSEncData() + "]");

        return new ResponseEntity<CheckPlusClient>(checkPlusClient, HttpStatus.OK);
    }

    /**
     * NICE 본인인증 결과 실패
     */
    @RequestMapping(value = "/portal/expose/nice/niceCertPlusFail.do")
    public void niceCertPlusFail(@ModelAttribute("niceVO") CheckPlusClient checkPlusClient, HttpServletResponse response) throws Exception {

        StringBuilder builder = new StringBuilder();
        builder.append("<html>");
        builder.append("<head>");
        builder.append("<meta charset=\"utf-8\">");
        builder.append("<script type=\"text/javascript\">");
        builder.append("alert(\"인증에 실패하였습니다.\");");
        builder.append("window.close();");
        builder.append("</script>");
        builder.append("</head>");
        builder.append("</html>");

        log.debug(builder.toString());

        response.setContentType("text/html;charset=UTF-8");
        response.getWriter().write(builder.toString());
    }

    /**
     * NICE 본인인증 결과 성공
     */
    @RequestMapping(value = "/portal/expose/nice/niceCertPlusResult.do")
    public void niceCertPlusResult(@ModelAttribute("niceVO") CheckPlusClient checkPlusClient, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

        checkPlusClient.setSEncodeData(request.getParameter("EncodeData"));
        NiceCert.getCheckPlusResult(checkPlusClient);

        log.debug("Return Code      : [" + checkPlusClient.getIReturn() + "]");
        log.debug("Return Message   : [" + checkPlusClient.getSMessage() + "]");
        log.debug("DI               : [" + checkPlusClient.getDi() + "]");
        log.debug("CI               : [" + checkPlusClient.getCi() + "]");
        log.debug("Name             : [" + checkPlusClient.getName() + "]");
        log.debug("Birth Date       : [" + checkPlusClient.getBirthdate() + "]");
        log.debug("Gender           : [" + checkPlusClient.getGender() + "]");
        log.debug("National Info    : [" + checkPlusClient.getNationainfo() + "]");
        log.debug("CheckPlusClient  : [" + checkPlusClient + "]");

        int iRtnCode = checkPlusClient.getIReturn();
        String alertMessage;
        NiceCertInfo certInfo = new NiceCertInfo();

        if (iRtnCode == 0) {
            certInfo.setName(checkPlusClient.getName());
            certInfo.setBirthDate(checkPlusClient.getBirthdate());
            certInfo.setGender(checkPlusClient.getGender().equals("0") ? "F" : "M");
            certInfo.setNationalInfo(checkPlusClient.getNationainfo().equals("0") ? "L" : "F");
            certInfo.setDupInfo(StringUtils.defaultString(checkPlusClient.getDi(), ""));
            // DI 값이 없어 임시 처리
//            certInfo.setDupInfo(StringUtils.defaultString(checkPlusClient.getCi(), ""));
            certInfo.setCoInfo(StringUtils.defaultString(checkPlusClient.getCi(), ""));

            String loginDiv = (certInfo.getNationalInfo()).equals("L") ? "1" : "0"; // 청구인 구분 : 내국인(1), 외국인 (0)

            session.setAttribute("loginDiv", loginDiv);
            session.setAttribute("loginName", certInfo.getName());
            session.setAttribute("loginRno1", certInfo.getBirthDate());
            session.setAttribute("dupInfo", certInfo.getDupInfo());
            session.setAttribute("coInfo", certInfo.getCoInfo());
            session.setAttribute("openUserIp", request.getRemoteAddr());
            session.setAttribute("rauthTag", "X"); // 본인인증구분 #없음(N), I-PIN(P), 휴대폰인증(H), 공동인증서(X)

            alertMessage = "인증되었습니다.";
        } else {
            alertMessage = "인증에 실패하였습니다.";
        }

        Gson gson = new Gson();
        String jsonCertInfo = gson.toJson(certInfo);

        log.debug("jsonCertInfo : [" + jsonCertInfo + "]");

        StringBuilder builder = new StringBuilder();
        builder.append("<html>");
        builder.append("<head>");
        builder.append("<meta charset=\"utf-8\">");
        builder.append("<script type=\"text/javascript\">");
        builder.append("alert(\"").append(alertMessage).append("\");");
        if (iRtnCode == 0) {
            builder.append("window.opener.fnKcbCallBack(");
            builder.append(jsonCertInfo).append(");");
        }
        builder.append("window.close();");
        builder.append("</script>");
        builder.append("</head>");
        builder.append("</html>");

        log.debug(builder.toString());

        response.setContentType("text/html;charset=UTF-8");
        response.getWriter().write(builder.toString());
    }

    /**
     * 청구 본인 인증정보 업데이트
     */
    @RequestMapping("/portal/expose/updateUserRauth.do")
    public String updateUserRauth(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);
        Object result = portalExposeInfoService.updateUserRauth(params);

        addObject(model, result);
        return "jsonView";
    }
}
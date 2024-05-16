package egovframework.admin.openinf.web;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egovframework.admin.basicinf.service.CommUsr;
import egovframework.admin.openinf.service.OpenDsInputService;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.helper.TABListVo;

/**
 * 공공데이터 입력을 관리하는 클래스
 *
 * @author 김정호
 * @version 1.0
 * @since 2017/10/18
 */
@Controller
public class OpenDsInputController extends BaseController {

    @Resource(name = "openDsInputService")
    protected OpenDsInputService openDsInputService;

    /**
     * 공공데이터 입력 페이지 이동
     *
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/openinf/opends/openDsInputPage.do")
    public String openDsInputPage(ModelMap model, @RequestParam(value = "valueCd", required = false) String valueCd) {
        Params params = new Params();
        params.set("grpCd", "D1009");
        model.addAttribute("loadCdList", openDsInputService.selectOption(params));        //입력주기
        params.set("grpCd", "D2005");
        params.set("valueCd", valueCd);    //입력상태 코드 파라미터로 전달받음(메뉴관리에 VALUE_CD로 코드 정의되어있음)
        model.addAttribute("ldstateCdList", openDsInputService.selectOption(params));    //입력상태

        if (EgovUserDetailsHelper.isAuthenticated()) {
            CommUsr loginVO = null;
            EgovUserDetailsHelper.getAuthenticatedUser();
            loginVO = (CommUsr) EgovUserDetailsHelper.getAuthenticatedUser();
            model.addAttribute("accCd", loginVO.getAccCd());    // 권한코드
        }

        return "/admin/openinf/opends/openDsInput";
    }

    /**
     * 공공데이터 메인 입력 스케쥴 리스트 조회
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/openinf/opends/openDsInputList.do")
    public String openDsInputList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        Object result = openDsInputService.openDsInputList(params);

        addObject(model, result);    // 모델에 객체를 추가한다.

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 공공데이터 입력 상세 조회
     *
     * @param params
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/openinf/opends/openDsInputDtl.do")
    @ResponseBody
    public TABListVo<Record> openDsInputDtl(@RequestBody Params params, HttpServletRequest request, ModelMap model) {
        Record record = openDsInputService.openDsInputDtl(params);
        return new TABListVo<Record>(record.get("DATA"), record.get("DATA2"));
    }

    /**
     * 공공데이터 입력 데이터셋 컬럼 조회
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/openinf/opends/openDsInputCol.do")
    public String openDsInputCol(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        Object result = openDsInputService.openDsInputCol(params);

        addObject(model, result);    // 모델에 객체를 추가한다.

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 공공데이터 입력 시트 조회
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/openinf/opends/openDsInputData.do")
    public String openDsInputData(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        Object result = openDsInputService.openDsInputData(params);

        addObject(model, result);    // 모델에 객체를 추가한다.

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 공공데이터 입력 양식 다운로드
     *
     * @param request
     * @param response
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/openinf/opends/down2OpenDsInputForm.do")
    public ModelAndView down2OpenDsInputForm(HttpServletRequest request, HttpServletResponse response, Model model) {
        Params params = getParams(request, true);
        LinkedList<LinkedList<String>> list = openDsInputService.down2OpenDsInputForm(params);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("params", params);
        map.put("list", list);
        return new ModelAndView("excelOpenInputFormView", "map", map);
    }

    /**
     * 공공데이터 입력 양식 다운로드
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/openinf/opends/saveOpenInputData.do")
    public String saveOpenInputData(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        Object result = openDsInputService.saveOpenInputData(params);

        addObject(model, result);    // 모델에 객체를 추가한다.

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 공공데이터 엑셀 파일 검증 및 저장
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/openinf/opends/saveOpenInputExcelData.do")
    public String saveOpenInputExcelData(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        Object result = openDsInputService.saveOpenInputExcelData(params);

        addObject(model, result);    // 모델에 객체를 추가한다.

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 공공데이터 입력 검증 실패 데이터 조회
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/openinf/opends/openDsInputVerifyData.do")
    public String openDsInputVerifyData(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        Object result = openDsInputService.openDsInputVerifyData(params);

        addObject(model, result);    // 모델에 객체를 추가한다.

        // 뷰이름을 반환한다.
        return "jsonView";
    }

    /**
     * 데이터 입력 상태 변경
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/openinf/opends/updateOpenLdlistCd.do")
    public String updateOpenLdlistCd(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);

        Object result = openDsInputService.updateOpenLdlistCd(params);

        addObject(model, result);    // 모델에 객체를 추가한다.

        // 뷰이름을 반환한다.
        return "jsonView";
    }
}

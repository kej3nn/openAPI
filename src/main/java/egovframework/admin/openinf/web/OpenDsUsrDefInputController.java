package egovframework.admin.openinf.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import egovframework.common.base.model.Paging;
import egovframework.common.util.UtilString;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.admin.openinf.service.OpenDsUsrDefInput;
import egovframework.admin.stat.service.StatsMgmtService;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 데이터셋 사용자정의 입력 컨트롤러 클래스
 *
 * @author JHKIM
 * @version 1.0
 * @since 2019/09/26
 */
@Controller
public class OpenDsUsrDefInputController extends BaseController {
    protected static final Log logger = LogFactory.getLog(OpenDsUsrDefInputController.class);

    @Resource(name = "openDsUsrDefInput")
    private OpenDsUsrDefInput openDsUsrDefInput;

    @Resource(name = "statsMgmtService")
    protected StatsMgmtService statsMgmtService;

    @RequestMapping(value = "/admin/openinf/opends/openDsUsrDefInputPage.do")
    public String openDsUsrDefInputPage(Model model, @RequestParam(value = "dsId", required = true) String dsId) {

        // 접근가능한지 확인
        if (openDsUsrDefInput.selectOpenDsUsrDefExist(dsId) == 0) {
            return "redirect:/admin/adminMain.do";
        }
        model.addAttribute("dsId", dsId);
        model.addAttribute("isUTF8", StringUtils.equals("UTF8", StringUtils.defaultString(EgovProperties.getProperty("Globals.DbCharset"), "WIN949").toUpperCase()) ? "Y" : "N");

        Params params = new Params();
        params.put("dsId", dsId);

        // 데이터 컬럼 리스트
        List<Record> colList = openDsUsrDefInput.selectOpenDsUsrDefColList(params);
        model.addAttribute("colList", colList);

        // 데이터 컬럼중 공통코드와 연결된 컬럼리스트는 공통코드 조회
        Map<String, List<Record>> colRefMap = new HashMap<String, List<Record>>();

        for (Record record : colList) {

            if (StringUtils.isNotBlank(record.getString("colRefCd"))) {
                Params codeParam = new Params();
                codeParam.put("grpCd", record.getString("colRefCd"));

                colRefMap.put(record.getString("colRefCd"), statsMgmtService.selectOption(codeParam));
            }
        }
        model.addAttribute("colRefMap", colRefMap);

        return "/admin/openinf/opends/openDsUsrDefInput";
    }

    /**
     * 헤더정보 로드
     */
    @RequestMapping("/admin/openinf/opends/openDsUsrDefHeaderData.do")
    public String openDsUsrDefHeaderData(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);

        Object result = openDsUsrDefInput.selectOpenDsUsrDefHeaderData(params);

        addObject(model, result);

        return "jsonView";
    }

    /**
     * 시트 데이터 로드
     */
    @RequestMapping("/admin/openinf/opends/openDsUsrDefData.do")
    public String openDsUsrDefData(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);

        Object result = openDsUsrDefInput.selectOpenDsUsrDefData(params);

        // HTML Entity 표출 처리
        ArrayList<Record> arrPag = (ArrayList<Record>) ((Paging) result).getData();
        for (int i = 0; i < arrPag.size(); i++) {
            String opbFlNm = arrPag.get(i).getString("OPB_FL_NM");

            opbFlNm = UtilString.reverse2AMP(opbFlNm);
            opbFlNm = UtilString.reverse2MIDDOT(opbFlNm);
            opbFlNm = UtilString.reverse2GT(opbFlNm);
            opbFlNm = UtilString.reverse2LT(opbFlNm);
            opbFlNm = UtilString.reverse2APOS(opbFlNm);
            opbFlNm = UtilString.reverse2QUOT(opbFlNm);

            arrPag.get(i).put("OPB_FL_NM", opbFlNm);
        }

        addObject(model, result);

        return "jsonView";
    }

    /**
     * 데이터 등록
     */
    @RequestMapping("/admin/openinf/opends/insertOpenDsUsrDef.do")
    public String insertOpenDsUsrDef(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);

        Object result = openDsUsrDefInput.insertOpenDsUsrDef(params);

        addObject(model, result);

        return "jsonView";
    }

    /**
     * 데이터 수정
     */
    @RequestMapping("/admin/openinf/opends/updateOpenDsUsrDef.do")
    public String updateOpenDsUsrDef(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);

        Object result = openDsUsrDefInput.updateOpenDsUsrDef(params);

        addObject(model, result);

        return "jsonView";
    }

    /**
     * 첨부파일 등록
     */
    @RequestMapping("/admin/openinf/opends/insertOpenUsrDefFile.do")
    public String insertOpenDsUsrDefFile(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);

        Object result = openDsUsrDefInput.insertOpenUsrDefFile(request, params);

        addObject(model, result);

        return "jsonView";
    }

    /**
     * 첨부파일 조회
     */
    @RequestMapping("/admin/openinf/opends/selectOpenUsrDefFile.do")
    public String selectOpenUsrDefFile(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);

        Object result = openDsUsrDefInput.selectOpenUsrDefFile(params);

        addObject(model, result);

        return "jsonView";
    }

    /**
     * 첨부파일 삭제
     */
    @RequestMapping("/admin/openinf/opends/deleteOpenDsUsrDef.do")
    public String deleteOpenDsUsrDef(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);

        Object result = openDsUsrDefInput.deleteOpenDsUsrDef(params);

        addObject(model, result);

        return "jsonView";
    }

    /**
     * 첨부 파일 다운로드
     */
    @RequestMapping("/admin/openinf/opends/downloadOpenUsrDefFile.do")
    public String downloadOpenUsrDefFile(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);

        Object result = openDsUsrDefInput.downloadOpenUsrDefFile(params);

        addObject(model, result);

        return "fileDownloadView";
    }

    /**
     * 첨부파일 순서저장
     */
    @RequestMapping("/admin/openinf/opends/saveOpenUsrDefFileOrder.do")
    public String saveOpenUsrDefFileOrder(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);

        Object result = openDsUsrDefInput.saveOpenUsrDefFileOrder(params);

        addObject(model, result);

        return "jsonView";
    }

    /**
     * 첨부파일 삭제
     */
    @RequestMapping("/admin/openinf/opends/deleteOpenUsrDefFile.do")
    public String deleteOpenUsrDefFile(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);

        Object result = openDsUsrDefInput.deleteOpenUsrDefFile(params);

        addObject(model, result);

        return "jsonView";
    }
}

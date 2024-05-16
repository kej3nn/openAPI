package egovframework.admin.stat.web;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egovframework.admin.basicinf.service.CommUsr;
import egovframework.admin.stat.service.StatInputService;
import egovframework.admin.stat.service.StatsMgmtService;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.grid.IBSheetListVO;
import egovframework.common.helper.TABListVo;

/**
 * 통계표 입력을 관리하는 클래스
 * 
 * @author	김정호
 * @version 1.0
 * @since   2017/06/02
 */
@Controller
public class StatInputController extends BaseController {
	
	@Resource(name="statInputService")
	protected StatInputService statInputService;
	
	@Resource(name="statsMgmtService")
	private StatsMgmtService statsMgmtService;
	
	@RequestMapping(value="/admin/stat/statInputPage.do")
	public String statInputPage(ModelMap model, @RequestParam(value="valueCd", required=false) String valueCd) {
		Params params = new Params();
		params.set("grpCd", "S1006");
		params.set("valueCd", valueCd);
		model.addAttribute("inputStatusList", statsMgmtService.selectOption(params));	//통계 입력상태
		
		if(EgovUserDetailsHelper.isAuthenticated()) {
			CommUsr loginVO = null;
    		EgovUserDetailsHelper.getAuthenticatedUser();
    		loginVO = (CommUsr)EgovUserDetailsHelper.getAuthenticatedUser();
    		model.addAttribute("accCd", loginVO.getAccCd());	//로그인 된 유저 권환 획득
        }
		
		return "/admin/stat/input/statInput";
	}
	
	/**
	 * 통게표 메인 리스트 조회
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/stat/statInputMainList.do")
	public String statInputMainList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        debug("Request parameters: " + params);
        
        Object result = statInputService.statInputMainListPaging(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 통계표 상세 조회
	 * 
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/stat/statInputDtl.do")
	@ResponseBody
	public TABListVo<Map<String, Object>> selectStatsMgmtDtl(@RequestBody Map<String, String> paramMap, HttpServletRequest request, ModelMap model) {
		Params params = getParams(request, true);
		Map<String, Object> map = statInputService.statInputDtl(paramMap);
		return new TABListVo<Map<String, Object>>(map.get("DATA"), map.get("DATA2"));
	}
	
	/**
	 * 통계표 분류/항목 조회
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/stat/statInputItm.do")
	public String statInputItm(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);
        
        Map<String, Object> result = statInputService.selectStatInputItm(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        return "jsonView";
	}
	
	/**
	 * 통계표 입력 시트 조회
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/stat/statInputList.do")
	@ResponseBody
	public IBSheetListVO<Map<String, Object>> statInputList(HttpServletRequest request, ModelMap model){
		// 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        List<Map<String, Object>> list = statInputService.statInputList(params);
        
		//List<Map<String, Object>> list = statsMgmtService.statsUsrListPaging(params);
		return new IBSheetListVO<Map<String, Object>>(list, list == null?0:list.size());
	}
	
	/**
	 * 통계표 데이터 조회(검증 데이터만)
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/stat/statInputVerifyData.do")
	public String statInputVerifyData(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);
        
        List<Map<String, Object>> result = statInputService.statInputVerifyData(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        return "jsonView";
	}
	
	/**
	 * 통계데이터 주석 조회
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/stat/statInputCmmtList.do")
	public String statInputCmmtList(HttpServletRequest request, Model model){
		// 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        List<Map<String, Object>> result = statInputService.statInputCmmtListPaging(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        return "jsonView";
	}
	
	/**
	 * 통계표 입력 검증 및 저장
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/stat/insertStatInputData.do")
	public String insertStatInputData(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        Object result = statInputService.saveStatInputData(params);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 통계표 입력 엑셀 양식을 읽어 저장한다.
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/stat/insertStatInputExcelData.do")
	public String insertStatInputExcelData(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        debug("Request parameters: " + params);
        
        Object result = statInputService.saveStatInputExcelData(params);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        return "jsonView";
        
	}
	
	/**
	 * 통계표 입력 엑셀 양식을 다운로드 한다.
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/stat/down2ExcelForm.do")
	public ModelAndView down2ExcelForm(HttpServletRequest request, Model model) {
		Params params = getParams(request, true);
		Map<String, Object> head = statInputService.selectStatInputItm(params);
		ArrayList<ArrayList<String>> data = statInputService.getStatInputSheetFormData(params);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("params", params);
		map.put("head", head);		//헤더 부분 데이터
		map.put("data", data);		//내용 부분 데이터
		return new ModelAndView("excelInputFormView", "map", map);
	} 
	
	/**
	 * 자료작성상태코드 변경 처리
	 * @param requeststatInputCmmtPop
	 * @param model
	 * @return
	 */
	@RequestMapping("/admin/stat/updateWrtstate.do")
	public String updateWrtstate(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);
        
        Object result = statInputService.updateWrtstate(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        return "jsonView";
	}
	
	/**
	 * 통계기호 입력 팝업
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/stat/popup/statInputMarkPop.do")
	public String statInputMarkPop(HttpServletRequest request, Model model){
		Params params = getParams(request, true);
		model.addAttribute("data", params);
		return "/admin/stat/input/popup/statInputMarkPop";
	}
	
	/**
	 * 통계기호 저장
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/stat/saveStatInputMark.do")
	public String saveStatInputMark(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        Object result = statInputService.saveStatInputMark(params);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 통계값 주석 팝업창 이동
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/stat/popup/statInputCmmtPop.do")
	public String statInputCmmtPop(HttpServletRequest request, Model model){
		Params params = getParams(request, true);
		model.addAttribute("data", params);
		return "/admin/stat/input/popup/statInputCmmtPop";
	}
	
	/**
	 * 통계값 주석 저장
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/stat/saveStatInputCmmtData.do")
	public String saveStatInputCmmtData(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        Object result = statInputService.saveStatInputCmmtData(params);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 자료시점 주석 팝업창 이동
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/stat/popup/statInputDifPop.do")
	public String statInputDifPop(HttpServletRequest request, Model model){
		Params params = getParams(request, true);
		model.addAttribute("data", params);
		return "/admin/stat/input/popup/statInputDifPop";
	}
	
	/**
	 * 자료시점 주석 머지처리
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/stat/selectSttsTblDif.do")
	public String searchSttsTblDif(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        Object result = statInputService.selectSttsTblDif(params);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 자료시점 주석 머지처리
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/stat/saveStatInputDifData.do")
	public String saveStatInputDifData(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        Object result = statInputService.saveStatInputDifData(params);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	
	/**
	 * 통계자료작성 처리기록 팝업 리스트 이동
	 */
	@RequestMapping("/admin/stat/statLogSttsWrtListPopup.do")
	public String statLogSttsWrtListPopup(HttpServletRequest request, Model model){
		Params params = getParams(request, true);
		model.addAttribute("statblId", params.getString("statblId"));
		model.addAttribute("wrttimeIdtfrId", new ArrayList<String>(Arrays.asList(params.getStringArray("wrttimeIdtfrId"))));
		return "/admin/stat/input/popup/statLogSttsWrtListPopup";
	}
	
	/**
	 * 통계자료작성 처리기록 팝업 리스트 조회
	 */
	@RequestMapping(value="/admin/stat/popup/selectStatLogSttsWrtList.do")
	public String selectStatLogSttsWrtList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        Object result = statInputService.selectStatLogSttsWrtList(params);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	
	/*
	@RequestMapping(value="/admin/stat/down2StatInputForm.do")
	public void down2StatInputForm(HttpServletRequest request, HttpServletResponse response, Model model) {
		Params params = getParams(request, true);
		//String sContext = request.getContextPath();
		//String sForwardPath = sContext + "/combine/obj/sheet/jsp/DirectDown2Excel.jsp";
		
		List<Map<String, Object>> list = statInputService.statInputList(params);
		request.setAttribute("SHEETDATA", list);
		
		//RequestDispatcher rd = request.getRequestDispatcher(sForwardPath);
		//rd.forward(request, response);
		
		DirectDown2Excel ibExcel = new DirectDown2Excel();
		ibExcel.setService(request, response);
		ibExcel.setDefaultFontName("맑은고딕");
		ibExcel.setDefaultFontSize((short)10);
		
		String data = request.getParameter("Data");
		
		ibExcel.setData(data);

		// 엑셀 워크북을 생성
		Workbook workbook = ibExcel.makeDirectExcel();

		// 다운로드 1. 생성된 엑셀 문서를 바로 다운로드 받음
		ServletOutputStream out2 = response.getOutputStream();
		workbook.write(out2);
		out2.flush();
	}
	*/
	
   
    
}


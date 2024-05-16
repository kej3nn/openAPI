package egovframework.admin.stat.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import egovframework.admin.stat.service.StatsMgmtService;
import egovframework.admin.stat.service.StatsStddTblItm;
import egovframework.common.base.constants.ModelAttribute;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.grid.IBSResultVO;
import egovframework.common.grid.IBSheetListVO;
import egovframework.common.helper.Messagehelper;
import egovframework.common.helper.TABListVo;

/**
 * 통계표를 관리하는 컨트롤러 클래스
 * @author	김정호
 * @version 1.0
 * @since   2017/05/25
 */

@Controller
public class StatsMgmtController extends BaseController { 
//implements ApplicationContextAware ,InitializingBean {
	
	protected static final Log logger = LogFactory.getLog(StatsMgmtController.class);
	
	//공통 메시지 사용시 선언
	@Resource
	Messagehelper messagehelper;
	
	@Resource(name="statsMgmtService")
	protected StatsMgmtService statsMgmtService;
	
	static class statsStddTblItmRecv extends HashMap<String, List<StatsStddTblItm>> { }
	
	/**
	 * 통계표 생성 및 수정화면으로 이동한다.
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/stat/statsMgmtPage.do")
	public String statsMgmtPage(ModelMap model) {
		
		Params params = new Params();
		params.set("grpCd", "S1103");
		model.addAttribute("dtacycleList", statsMgmtService.selectOption(params));	//작성주기
		
		params.set("grpCd", "S1010");
		model.addAttribute("systemList", statsMgmtService.selectOption(params));	//시스템
		
		params.set("grpCd", "S1009");
		model.addAttribute("openStateList", statsMgmtService.selectOption(params));	//공개상태
		
		params.set("grpCd", "ZE102");
		model.addAttribute("dscnList", statsMgmtService.selectSTTSOption(params));	//연계정보
		
		return "/admin/stat/stats/statsMgmt";
	}
	
	/**
	 * 공통코드 값을 조회한다.
	 */
	@RequestMapping("/admin/stat/ajaxOption.do")
    public String ajaxOption(HttpServletRequest request, Model model) {
    	// 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);
        
        Object result = statsMgmtService.selectOption(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 통계 공통코드 값을 조회한다.
	 */
	@RequestMapping("/admin/stat/ajaxSTTSOption.do")
    public String ajaxSTTSOption(HttpServletRequest request, Model model) {
    	// 파라메터를 가져온다.
        Params params = getParams(request, true);

        debug("Request parameters: " + params);
        
        Object result = statsMgmtService.selectSTTSOption(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        return "jsonView";
    }
	
	/**
	 * 통계메타명 팝업으로 이동(iframe)
	 */
	@RequestMapping("/admin/stat/popup/statsMetaPopup.do")
	public String statsMetaPopup(HttpServletRequest request, Model model){
		return "/admin/stat/stats/popup/statsMetaPopup";
	}  
	
	/**
	 * 통계메타명 팝업 데이터 리스트 조회
	 */
	@RequestMapping("/admin/stat/popup/selectStatMetaPopup.do")
	@ResponseBody
	public IBSheetListVO<Map<String, Object>> selectStatMetaPopup(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, true);
        
		List<Map<String, Object>> list = statsMgmtService.selectStatMetaPopup(params);
		return new IBSheetListVO<Map<String, Object>>(list, list == null?0:list.size());
	}
	
	/**
	 * 분류체계 팝업으로 이동(iframe)
	 */
	@RequestMapping("/admin/stat/popup/statsCatePopup.do")
	public String statsCatePopup(HttpServletRequest request, Model model){
		return "/admin/stat/stats/popup/statsCatePopup";
	}
	
	/**
	 * 분류체계 팝업 데이터 리스트 조회
	 */
	@RequestMapping("/admin/stat/popup/selectStatCatePopup.do")
	@ResponseBody
	public IBSheetListVO<Map<String, Object>> selectStatCatePopup(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, true);
        
		List<Map<String, Object>> list = statsMgmtService.selectStatCatePopup(params);
		return new IBSheetListVO<Map<String, Object>>(list, list == null?0:list.size());
	}
	
	/**
	 * 통계표 분류체계 조회
	 */
	@RequestMapping(value="/admin/stat/statSttsTblCateList.do")
	public String statSttsTblCateList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        debug("Request parameters: " + params);
        
        Object result = statsMgmtService.statSttsTblCateList(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 통계표 목록 조회 
	 */
	@RequestMapping(value="/admin/stat/statsMgmtList.do")
	public String statsMgmtList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        debug("Request parameters: " + params);
        
        Object result = statsMgmtService.statsMgmtListPaging(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 통계표 목록 상세조회
	 */
	@RequestMapping(value="/admin/stat/selectStatsMgmtDtl.do")
	@ResponseBody
	public TABListVo<Map<String, Object>> selectStatsMgmtDtl(@RequestBody Map<String, String> paramMap, HttpServletRequest request, ModelMap model) {
		// 파라메터를 가져온다.
		Params params = getParams(request, true);
		Map<String, Object> map = statsMgmtService.selectStatsMgmtDtl(paramMap);
		//return new TABListVo<Map<String, Object>>(map);
		return new TABListVo<Map<String, Object>>(map.get("DATA"), map.get("DATA2"));
	}
	
	/**
	 * 통계표 등록 
	 */
	@RequestMapping(value="/admin/stat/insertStatsMgmt.do")
	public String insertStatsMgmt(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        //데이터 처리 진행 코드(입력)
        params.set(ModelAttribute.ACTION_STATUS, ModelAttribute.ACTION_INS);
        
        debug("Request parameters: " + params);
        
        Object result = statsMgmtService.saveStatsMgmt(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 통계표 수정
	 */
	@RequestMapping(value="/admin/stat/updateStatsMgmt.do")
	public String updateStatsMgmt(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        //데이터 처리 진행 코드(수정)
        params.set(ModelAttribute.ACTION_STATUS, ModelAttribute.ACTION_UPD);
        
        debug("Request parameters: " + params);
        
        Object result = statsMgmtService.saveStatsMgmt(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	@RequestMapping(value="/admin/stat/deleteStatsMgmt.do")
	public String deleteStatsMgmt(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        //데이터 처리 진행 코드(삭제)
        params.set(ModelAttribute.ACTION_STATUS, ModelAttribute.ACTION_DEL);
        
        debug("Request parameters: " + params);
        
        Object result = statsMgmtService.deleteStatsMgmt(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 통계표 관리담당자 목록 조회
	 */
	@RequestMapping("/admin/stat/statsUsrList.do")
	@ResponseBody
	public IBSheetListVO<Record> statsUsrList(HttpServletRequest request, ModelMap model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, true);
        
		List<Record> list = statsMgmtService.statsUsrListPaging(params);
		return new IBSheetListVO<Record>(list, list == null?0:list.size());
	}
	
	
	/**
	 * 표준항목분류정보 팝업으로 이동(iframe)
	 */
	@RequestMapping("/admin/stat/popup/statsStddItmPopup.do")
	public String statsStddItmPopup(HttpServletRequest request, Model model){
		return "/admin/stat/stats/popup/statsStddItmPopup";
	}
	
	/**
	 * 표준항목분류정보 계층 조회
	 */
	@RequestMapping(value="/admin/stat/popup/selectStatStddItmPopup.do")
	public String statSttsCateList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        params.put("useYn", "Y");	//사용중인 항목만 표시
        Object result = statsMgmtService.selectStatStddItmPopup(params);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }

	/**
	 * 표준항목단위정보 팝업 화면이동 
	 */
	@RequestMapping("/admin/stat/opends/popup/statsStddUiPopup.do")
	public String statsStddUiPopup (ModelMap model){
		return "/admin/stat/stats/popup/statsStddUiPopup";
	}
	/**
	 * 표준항목단위정보 팝업 조회 
	 */
	@RequestMapping("/admin/stat/popup/selectStatsStddUiPopup.do")
	@ResponseBody
	public IBSheetListVO<Map<String, Object>> selectStatsStddUiPopup(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, true);
        
		List<Map<String, Object>> list = statsMgmtService.selectStatsStddUiPopup(params);
		return new IBSheetListVO<Map<String, Object>>(list, list == null?0:list.size());
	}
	
	/**
	 * 통계표 항목분류 리스트 조회
	 */
	@RequestMapping("/admin/stat/selectStatsTblItmList.do")
	@ResponseBody
	public IBSheetListVO<Map<String, Object>> selectStatsTblItmListPaging(HttpServletRequest request, ModelMap model){
		// 파라메터를 가져온다.
        Params params = getParams(request, true);
        
		List<Map<String, Object>> list = statsMgmtService.statsTblItmListPaging(params);
		return new IBSheetListVO<Map<String, Object>>(list, list == null?0:list.size());
	}
	
	/**
	 * 통계표 항목분류 입력/수정
	 */
	@RequestMapping("/admin/stat/saveStddTblItm.do")
	@ResponseBody
	public IBSResultVO<StatsStddTblItm> saveStddTblItm(@RequestBody statsStddTblItmRecv datas, HttpServletRequest request) {
        Params params = getParams(request, true);
		
		List<StatsStddTblItm> list = datas.get("data");
        Object result = statsMgmtService.saveStddTblItmCUD(list, params);
        
        return new IBSResultVO<StatsStddTblItm>(1, messagehelper.getSavaMessage(1));
    }
	
	/**
	 * 통계표 항목 분류 순서저장
	 */
	@RequestMapping("/admin/stat/saveStddTblItmOrder.do")
	@ResponseBody
	public IBSResultVO<StatsStddTblItm> saveStddTblItmOrder(@RequestBody statsStddTblItmRecv datas, HttpServletRequest request) {
        Params params = getParams(request, true);
		
		List<StatsStddTblItm> list = datas.get("data");
        Object result = statsMgmtService.saveStddTblItmOrder(list, params);
        
        return new IBSResultVO<StatsStddTblItm>(1, messagehelper.getSavaMessage(1));
    }
	
	/**
	 * 통계표 메인 순서저장
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/stat/saveStatsMgmtOrder.do")
	public String saveSttsStatOrder(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        debug("Request parameters: " + params);
        
        Object result = statsMgmtService.saveStatsMgmtOrder(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 통계표 공개상태를 공개/취소 한다.
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/stat/updateOpenState.do")
	public String updateOpenState(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        debug("Request parameters: " + params);
        
        Object result = statsMgmtService.updateOpenState(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 통계분석자료 일괄생성
	 */
	@RequestMapping(value="/admin/stat/execSttsAnlsAll.do")
	public String execSttsAnalsAll(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        debug("Request parameters: " + params);
        
        Object result = statsMgmtService.execSttsAnlsAll(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 통계표 복사
	 */
	@RequestMapping(value="/admin/stat/execCopySttsTbl.do")
	public String execCopySttsTbl(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        debug("Request parameters: " + params);
        
        Object result = statsMgmtService.execCopySttsTbl(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	@RequestMapping(value="/admin/stat/selectSttsTblPop.do")
	public String selectSttsTblPopt(HttpServletRequest request, Model model) {
        return "/admin/stat/stats/popup/statsTblPopup";
    }
	
	/**
	 * 연관 통계표 팝업 조회
	 */
	@RequestMapping(value="/admin/stat/selectSttsTblPopList.do")
	public String selectSttsTblPopList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        debug("Request parameters: " + params);
        
        Object result = statsMgmtService.selectSttsTblPopList(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 연관 통계표 리스트 조회
	 */
	@RequestMapping(value="/admin/stat/selectSttsTblList.do")
	public String selectSttsTblList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        debug("Request parameters: " + params);
        
        Object result = statsMgmtService.selectSttsTblList(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 항목/분류 팝업(항목 부모번호 변경시 사용)
	 */
	@RequestMapping("/admin/stat/popup/statsParItmPopup.do")
	public String statsParItmPopup (ModelMap model){
		return "/admin/stat/stats/popup/statsParItmPopup";
	}
	
	
	/**
	 * 통계표 분류정보 목록 조회
	 */
	@RequestMapping("/admin/stat/selectStatsCateInfoList.do")
	public String selectStatsCateInfoList(HttpServletRequest request, Model model) {
		// 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        debug("Request parameters: " + params);
        
        Object result = statsMgmtService.selectStatsCateInfoList(params);
        
        debug("Processing results: " + result);
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
	}
	

	/**
	 * 통계표 정보분류체계 팝업으로 이동(iframe)
	 */
	@RequestMapping("/admin/stat/popup/statsCateInfoPop.do")
	public String statsCateInfoPop(HttpServletRequest request, Model model){
		return "/admin/stat/stats/popup/statsCateInfoPop";
	}

	/**
	 * 통계표 정보분류체계 팝업 데이터 리스트 조회
	 */
	@RequestMapping("/admin/stat/popup/selectStatCateInfoPop.do")
	public String selectDocInfCatePop(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        Object result = statsMgmtService.selectStatCateInfoPop(params);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 내부직원용 공공데이터 메타관리 조회화면으로 이동한다.
	 * 
	 * @param model
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/admin/stat/stfStatsMgmtPage.do")
	public String stfOpenInfPage(ModelMap model) {
		// 페이지 title을 가져오려면 반드시 *Page로 끝나야한다.
		// Interceptor(PageNavigationInterceptor)에서 조회함
		return "/admin/stat/stats/stfStatsMgmt";
	}
	
	/**
	 * 내부직원용 통계데이터 메타관리 조회(페이징 처리)
	 */
	@RequestMapping("/admin/stat/selectStfStatsMgmtListPaging.do")
	public String selectStfStatsMgmtListPaging(HttpServletRequest request, Model model) {
        Params params = getParams(request, true);
        
        Object result = statsMgmtService.selectStfStatsMgmtListPaging(params);
        
        addObject(model, result);
        
        return "jsonView";
    }
	
	/**
	 * 내부직원용 통계데이터  메타관리 상세 조회
	 * @param params
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/stat/stfStatsMgmtDtl.do")
	@ResponseBody
	public TABListVo<Record> stfStatsMgmtDtl(@RequestBody Params params, HttpServletRequest request, ModelMap model) {
		return new TABListVo<Record>(statsMgmtService.stfStatsMgmtDtl(params));
	}
	
	/**
	 * 내부직원용 통계데이터 메타관리 등록/수정
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/stat/saveStfStatsMgmt.do")
	public String saveStfStatsMgmt(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        debug("Request parameters: " + params);
        
        //데이터 처리 진행 코드(입력)
        params.set(ModelAttribute.ACTION_STATUS, ModelAttribute.ACTION_UPD);
        Object result = statsMgmtService.saveStfStatsMgmt(request, params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
}

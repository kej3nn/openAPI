package egovframework.admin.stat.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.admin.stat.service.StatSttsStatService;
import egovframework.admin.stat.service.StatsMgmtService;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.helper.TABListVo;

/**
 * 통계표를 관리하는 컨트롤러 클래스
 * @author	김정호
 * @version 1.0
 * @since   2017/08/07
 */

@Controller
public class StatSttsStatController extends BaseController {

	@Resource(name="statSttsStatService")
	private StatSttsStatService statSttsStatService;
	
	@Resource(name="statsMgmtService")
	private StatsMgmtService statsMgmtService;
	
	/**
	 * 통계 메타 화면 이동
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/stat/statSttsStatPage.do")
	public String statSttsStatPage(ModelMap model) {
		Params params = new Params();
		params.set("grpCd", "S1008");
		model.addAttribute("searchSttsCdList", statsMgmtService.selectOption(params));	//통계 구분코드
		return "/admin/stat/stat/statSttsStat";
	}
	
	/**
	 * 통계 메타 리스트 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/stat/statSttsStatList.do")
	public String statSttsStatList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        Object result = statSttsStatService.statSttsStatList(params);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 통계 메타 관리 입력
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/stat/insertStatSttsStat.do")
	public String insertStatSttsStat(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        Object result = statSttsStatService.insertStatSttsStat(params);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 통계 메타 관리 상세
	 * @param params
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/stat/statSttsStatDtl.do")
	@ResponseBody
	public TABListVo<Record> statSttsStatDtl(@RequestBody Params params, HttpServletRequest request, ModelMap model) {
		return new TABListVo<Record>(statSttsStatService.statSttsStatDtl(params));
	}
	
	/**
	 * 통계 설명 메타정보 메타입력 유형코드 조회(실 데이터 확인 후)
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/stat/statSttsStatExistMetaCd.do")
	public String statSttsStatExistMetaCd(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        debug("Request parameters: " + params);
        
        Object result = statSttsStatService.statSttsStatExistMetaCd(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 통계설명 메타정보 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/stat/statSttsStddMeta.do")
	public String statSttsStddMeta(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        debug("Request parameters: " + params);
        
        Object result = statSttsStatService.statSttsStddMeta(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 통계설명 메타정보 저장
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/admin/stat/saveStatSttsStatMeta.do")
	public String saveStatSttsStatMeta(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        debug("Request parameters: " + params);
        
        Object result = statSttsStatService.saveStatSttsStatMeta(request, params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 통계 설명 관리 담당자 리스트 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/stat/statSttsStatUsrList.do")
	public String statSttsStatUsrList(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        debug("Request parameters: " + params);
        
        Object result = statSttsStatService.statSttsStatUsrList(params);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 통계설명 정보 삭제(메타정보, 유저 포함)
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/stat/deleteStatSttsStat.do")
	public String deleteStatSttsStat(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        debug("Request parameters: " + params);
        
        Object result = statSttsStatService.deleteStatSttsStat(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 순서 저장
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/stat/saveSttsStatOrder.do")
	public String saveSttsStatOrder(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        debug("Request parameters: " + params);
        
        Object result = statSttsStatService.saveSttsStatOrder(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
	
	/**
	 * 통계설명 ID를 사용하는 공개된 통계표 갯수 확인
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/admin/stat/statSttsOpenStateTblCnt.do")
	public String statSttsOpenStateTblCnt(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, true);
        
        debug("Request parameters: " + params);
        
        Object result = statSttsStatService.statSttsOpenStateTblCnt(params);
        
        debug("Processing results: " + result);
        
        addObject(model, result);	// 모델에 객체를 추가한다.
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
}

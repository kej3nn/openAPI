package egovframework.soportal.stat.web;

import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egovframework.common.base.constants.ModelAttribute;
import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.grid.IBSheetListVO;
import egovframework.common.helper.Messagehelper;
import egovframework.soportal.stat.service.ChartListService;
import egovframework.soportal.stat.service.StatListService;
import egovframework.soportal.stat.service.ThemeListService;

/**
 * 테마통계 정보 클래스
 * 테마통계는 호출되는 Page에 따라서 노출되는 화면이 달라진다.
 * @author 	위세아이텍
 * @version	1.0
 * @since	2018/01/15
 */

@Controller
public class ThemeListController extends BaseController {

	protected static final Log logger = LogFactory.getLog(ThemeListController.class);
	
	//공통 메시지 사용시 선언
	@Resource
	Messagehelper messagehelper;
	
	@Resource(name="themeListService")
	protected ThemeListService themeListService;

	@Resource(name="statListService")
	protected StatListService statListService;
	
	/**
	 * 한눈에 보는 주택금융 페이지 이동
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/portal/theme/lookStatPage.do")
	public String lookStatPage(ModelMap model, @RequestParam(value="usrTblSeq", required=false) String usrTblSeq) {
		//테마통계 > 주택금융지수 화면을 호출한다.
		return "/hfportal/theme/lookStat";
	}	
	
	/**
	 * 한눈에 보는 주택금융 통계정보를 JSON으로 전달
	 * 통계표 ID를 받아서 처리한다.
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/portal/theme/lookStatList.do")
	public String lookStatList(HttpServletRequest request, Model model) {
		
		// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        Object result = themeListService.statThemeLookList(params);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
	}
	
	/**
	 * 인기통계 페이지 이동
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/portal/theme/hitStatPage.do")
	public String hitStatPage(ModelMap model, @RequestParam(value="usrTblSeq", required=false) String usrTblSeq) {
		//테마통계 > 주택금융지수 화면을 호출한다.
		return "/hfportal/theme/hitStat";
	}
	
	/**
	 * 최신통계 페이지 이동
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/portal/theme/newStatPage.do")
	public String newStatPage(ModelMap model, @RequestParam(value="usrTblSeq", required=false) String usrTblSeq) {
		//테마통계 > 주택금융지수 화면을 호출한다.
		return "/hfportal/theme/newStat";
	}	
	
	/**
	 * 인기통계 통계정보를 JSON으로 전달
	 * 통계표 ID를 받아서 처리한다.
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/portal/theme/hitStatList.do")
	public String hitStatList(HttpServletRequest request, Model model) {
		
		// 파라메터를 가져온다. 
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        Object result = statListService.statHitList(params);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
	}
	
	/**
	 * 인기통계 통계정보를 JSON으로 전달
	 * 통계표 ID를 받아서 처리한다.
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/portal/theme/newStatList.do")
	public String newStatList(HttpServletRequest request, Model model) {
		
		// 파라메터를 가져온다. 
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        Object result = statListService.statNewList(params);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
	}
	
	/**
	 * 지도통계 페이지 이동
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/portal/theme/indexStatMap.do")
	public String indexStatMap(ModelMap model, @RequestParam(value="usrTblSeq", required=false) String usrTblSeq) {
		//테마통계 > 주택금융지수 지도(MAP)화면을 호출한다.
		return "/hfportal/theme/indexStatMap";
	}

	/**
	 * 지도통계 페이지 이동
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/portal/theme/mapStatPage.do")
	public String mapStatPage(ModelMap model) {
		//테마통계 > 지도통계 화면을 호출한다.
		return "/hfportal/theme/mapStat";
	}	
	
	/**
	 * 지도통계를 위한 통계정보를 JSON으로 전달
	 * 통계표 ID를 받아서 처리한다.
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/portal/theme/mapStatDataList.do")
	public String mapStatDataList(HttpServletRequest request, Model model) {
		
		// 파라메터를 가져온다.
        Params params = getParams(request, false);

        debug("Request parameters: " + params);

        Map<String, Object> map = themeListService.mapStatDataList(params);
        // 모델에 객체를 추가한다.
        addObject(model, map);

		return "jsonView";
	}
	
	/**
	 * 지도통계 > 지도(MAP) 페이지 이동
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/portal/theme/mapStatDetail/{statblId}.do")
	public String mapStatDetail(@PathVariable("statblId") String statblId, ModelMap model) {
		  
		Params params = new Params();
		//통계표 자료 조회시점
		params.put("statblId", statblId);
		if(statblId.equals("T186503126543136")){ //주택구입부담지수
			params.put("dtacycleCd", "QY");
			params.put("sortDirection", "ASC");
		}else{ //주택구입물량지수
			params.put("dtacycleCd", "YY");
			params.put("sortDirection", "ASC");
		}
		
		model.addAttribute("wrttime", statListService.statWrtTimeOption(params));
	
		return "/hfportal/theme/mapStatDetail";
	}
	
	/**
	 * 주택금융지수 페이지 이동(영문)
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/portal/theme/indexStatEngPage.do")
	public String indexStatEngPage(ModelMap model, @RequestParam(value="usrTblSeq", required=false) String usrTblSeq) {
		//테마통계 > 주택금융지수 화면을 호출한다.
		return "/hfportal/theme/indexStatEng";
	}
	
	/**
	 * 한눈에 보는 주택금융 페이지 이동(영문)
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/portal/theme/lookStatEngPage.do")
	public String lookStatEngPage(ModelMap model, @RequestParam(value="usrTblSeq", required=false) String usrTblSeq) {
		//테마통계 > 주택금융지수 화면을 호출한다.
		return "/hfportal/theme/lookStatEng";
	}	
	
	/**
	 * 지도통계 페이지 이동(영문)
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/portal/theme/mapStatEngPage.do")
	public String mapStatEngPage(ModelMap model) {
		//테마통계 > 지도통계 화면을 호출한다.
		return "/hfportal/theme/mapStatEng";
	}
	
	/**
	 * 지도통계 > 지도(MAP) 페이지 이동(영문)
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/portal/theme/mapStatDetailEng/{statblId}.do")
	public String mapStatDetailEng(@PathVariable("statblId") String statblId, ModelMap model) {
		  
		Params params = new Params();
		//통계표 자료 조회시점
		params.put("statblId", statblId);
		if(statblId.equals("T186503126543136")){ //주택구입부담지수
			params.put("dtacycleCd", "QY");
			params.put("sortDirection", "ASC");
		}else{ //주택구입물량지수
			params.put("dtacycleCd", "YY");
			params.put("sortDirection", "ASC");
		}

		model.addAttribute("wrttime", statListService.statWrtTimeOption(params));
	
		return "/hfportal/theme/mapStatDetailEng";
	}
	
	/**
	 * 인기통계 페이지 이동(영문)
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/portal/theme/hitStatEngPage.do")
	public String hitStatEngPage(ModelMap model, @RequestParam(value="usrTblSeq", required=false) String usrTblSeq) {
		//테마통계 > 주택금융지수 화면을 호출한다.
		return "/hfportal/theme/hitStatEng";
	}
}
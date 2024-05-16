package egovframework.admin.stat.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egovframework.admin.stat.service.StatOpenStats;
import egovframework.admin.stat.service.StatOpenStatsService;
import egovframework.common.code.service.CodeListService;
import egovframework.common.grid.IBSheetListVO;
import egovframework.common.helper.Csvdownheler;
import egovframework.common.helper.Exceldownheler;
import egovframework.common.helper.Jsondownheler;
import egovframework.common.helper.Messagehelper;

@Controller
public class StatOpenStatsController implements InitializingBean {

	protected static final Log logger = LogFactory.getLog(StatOpenStatsController.class);
	
	//공통코드 사용시 선언
	@Resource
	private CodeListService commCodeListService;
	
	//공통 메시지 사용시 선언
	@Resource
	Messagehelper messagehelper;

	@Resource(name="StatOpenStatsService")
	private StatOpenStatsService statOpenStatsService;

	@Autowired
	Jsondownheler jsondownheler;

	@Autowired
	Csvdownheler csvdownheler;

	@Autowired
	Exceldownheler exceldownheler;

	@Override
	public void afterPropertiesSet() {


	}

	/**
	 * 공통코드를 조회 한다.
	 * @return
	 * @throws Exception
	 */
	@ModelAttribute("codeMap")
	public Map<String, Object> getcodeMap(String viewLang){
		Map<String, Object> codeMap = new HashMap<String, Object>();
		/*codeMap = new HashMap<String, Object>();
		codeMap.put("infStateIbs", UtilJson.convertJsonString(commCodeListService.getEntityCodeListIBS("INF_STATS",false,viewLang)));//관리자권한 ibSheet
		codeMap.put("filtCd", commCodeListService.getCodeList("D1014"));//관리자권한 ibSheet
		codeMap.put("viewCdIbs", UtilJson.convertJsonString(commCodeListService.getCodeListIBS("D1015",false,viewLang)));
		codeMap.put("colCdIbs", UtilJson.convertJsonString(commCodeListService.getCodeListIBS("D1021",false,viewLang)));
		codeMap.put("markerCd", commCodeListService.getCodeList("D1019"));
		codeMap.put("condOp", commCodeListService.getEntityCodeList("OP","",viewLang));//연산자
		codeMap.put("filtCode", commCodeListService.getEntityCodeList("FILT_CODE","CODELIST",viewLang));//대상코드
		codeMap.put("carryPeriodCd", commCodeListService.getEntityCodeList("FILT_CODE","D1009",viewLang));//적재주기(안전행정부표준코드)
		codeMap.put("useAgreeCd", commCodeListService.getEntityCodeList("FILT_CODE","D1008",viewLang));//이용허락 조건
		codeMap.put("cateNm", commCodeListService.getEntityCodeList("CATE_NM","",viewLang));//분류정보
		codeMap.put("tColCd", commCodeListService.getCodeList("D1029"));//컬럼속성
		codeMap.put("xlnCd", commCodeListService.getCodeList("D1016"));	//축선색상코드
		codeMap.put("ylnCd", commCodeListService.getCodeList("D1017"));	//격자색상코드
		codeMap.put("sgrpCd", commCodeListService.getCodeList("D1018"));	//시리즈그룹코드
		codeMap.put("seriesCd", commCodeListService.getCodeList("D1020"));	//시리즈유형코드
		codeMap.put("seriesCdIbs", UtilJson.convertJsonString(commCodeListService.getCodeListIBS("D1020", true,viewLang)));
		codeMap.put("convCd", commCodeListService.getCodeList("S1002"));//원자료
		codeMap.put("fileCd", commCodeListService.getCodeList("D1022"));//파일종류
		*/
		return codeMap;
	}

	/**
	 * 개방 및 활용 통계 초기 페이지
	 * @param model
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/admin/stat/stats/statOpenStatsPage.do")
	public ModelAndView statOpenStatsPage(ModelMap model){
		//페이지 title을 가져오려면 반드시 *Page로 끝나야한다.
		//Interceptor(PageNavigationInterceptor)에서 조회함

		ModelAndView mv=new ModelAndView();
		mv.addObject( "CNT", statOpenStatsService.selectStatsCnt() ); //통계 건수 구한다.
		mv.setViewName("/admin/stat/stats/statopenstats");
		return mv;
	}

	/**
	 * 개방 및 활용 통계 sheet 조회
	 * @param statOpenStats
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/stat/stats/getStatsSheetAll.do")
	@ResponseBody
	public IBSheetListVO<StatOpenStats> getStatsSheetAll(@ModelAttribute("searchVO") StatOpenStats statOpenStats, ModelMap model){
		List<StatOpenStats> list =  new ArrayList<StatOpenStats>();
		if (statOpenStats != null) {
			list = statOpenStatsService.getStatsSheetAll(statOpenStats);
		}
		return new IBSheetListVO<StatOpenStats>(list, list.size());
	}
}

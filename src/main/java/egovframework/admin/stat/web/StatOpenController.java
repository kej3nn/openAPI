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
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.admin.stat.service.StatOpen;
import egovframework.admin.stat.service.StatOpenService;
import egovframework.common.code.service.CodeListService;
import egovframework.common.grid.IBSheetListVO;
import egovframework.common.helper.Csvdownheler;
import egovframework.common.helper.Exceldownheler;
import egovframework.common.helper.Jsondownheler;
import egovframework.common.helper.Messagehelper;

@Controller
public class StatOpenController implements InitializingBean {

	protected static final Log logger = LogFactory.getLog(StatOpenController.class);
	
	//공통코드 사용시 선언
	@Resource
	private CodeListService commCodeListService;
	
	//공통 메시지 사용시 선언
	@Resource
	Messagehelper messagehelper;

	@Resource(name="StatOpenService")
	private StatOpenService statOpenService;

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
	 * 분류별 개방 통계 조회화면으로 이동한다.
	 * @param model
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/admin/stat/open/statOpenCatePage.do")
	public String statOpenCatePage(ModelMap model){
		//페이지 title을 가져오려면 반드시 *Page로 끝나야한다.
		//Interceptor(PageNavigationInterceptor)에서 조회함
		return "/admin/stat/open/statopencate";
	}

	/**
	 * 분류별 개방 통계 Sheet형 자료 조회한디.
	 * @param model
	 * @param statOpen
	 * @return List<StatOpen>
	 * @throws Exception
	 */
	@RequestMapping("/admin/stat/open/getOpenStatCateSheetAll.do")
	@ResponseBody
	public IBSheetListVO<StatOpen> getOpenStatCateSheetAll(StatOpen statOpen, Model model){
		List<StatOpen> list =  new ArrayList<StatOpen>();
		if (statOpen != null) {
			list = statOpenService.getOpenStatCateSheetAll(statOpen);
		}
		return new IBSheetListVO<StatOpen>(list, list.size());
	}

	/**
	 * 분류별 개방 통계 Chart형 자료 조회한다.
	 * @param statOpen
	 * @return Map<String, Object>
	 * @throws Exception
	 */
	@RequestMapping("/admin/stat/open/getOpenStatCateChartAll.do")
	@ResponseBody
	public Map<String, Object> getOpenStatCateChartAll(StatOpen statOpen){
		Map<String, Object> map = new HashMap<String, Object>();
		if (statOpen != null) {
			map = statOpenService.getOpenStatCateChartAll(statOpen);
			map.put("seriesResult",map.get("seriesResult"));
			map.put("chartDataX",map.get("chartDataX"));
			map.put("chartDataY",map.get("chartDataY"));
		}
		return map;
	}

	/**
	 * 기관별 개방 통계 조회화면으로 이동한다.
	 * @param model
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/admin/stat/open/statOpenOrgPage.do")
	public String statOpenOrgPage(ModelMap model){
		//페이지 title을 가져오려면 반드시 *Page로 끝나야한다.
		//Interceptor(PageNavigationInterceptor)에서 조회함
		return "/admin/stat/open/statopenorg";
	}

	/**
	 * 기관별 개방 통계 Sheet형 자료 조회한디.
	 * @param model
	 * @param statOpen
	 * @return List<StatOpen>
	 * @throws Exception
	 */
	@RequestMapping("/admin/stat/open/getOpenStatOrgSheetAll.do")
	@ResponseBody
	public IBSheetListVO<StatOpen> getOpenStatOrgSheetAll(StatOpen statOpen, Model model){
		List<StatOpen> list =  new ArrayList<StatOpen>();
		if (statOpen != null) {
			list = statOpenService.getOpenStatOrgSheetAll(statOpen);
		}
		return new IBSheetListVO<StatOpen>(list, list.size());
	}

	/**
	 * 기관별 개방 통계 Chart형 자료 조회한다.
	 * @param statOpen
	 * @return Map<String, Object>
	 * @throws Exception
	 */
	@RequestMapping("/admin/stat/open/getOpenStatOrgChartAll.do")
	@ResponseBody
	public Map<String, Object> getOpenStatOrgChartAll(StatOpen statOpen){
		Map<String, Object> map = new HashMap<String, Object>();
		if (statOpen != null) {
			map = statOpenService.getOpenStatOrgChartAll(statOpen);
			//map.put("seriesResult",map.get("seriesResult"));
			map.put("chartDataX",map.get("chartDataX"));
			map.put("chartDataY",map.get("chartDataY"));
		}
		return map;
	}

	/**
	 * 보유데이터별 개방 통계 조회화면으로 이동한다.
	 * @param model
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/admin/stat/open/statOpenDtPage.do")
	public String statOpenDtPage(ModelMap model){
		//페이지 title을 가져오려면 반드시 *Page로 끝나야한다.
		//Interceptor(PageNavigationInterceptor)에서 조회함
		return "/admin/stat/open/statopendt";
	}

	/**
	 * 보유데이터별 개방 통계 Sheet형 자료 조회한디.
	 * @param model
	 * @param statOpen
	 * @return List<StatOpen>
	 * @throws Exception
	 */
	@RequestMapping("/admin/stat/open/getOpenStatDtSheetAll.do")
	@ResponseBody
	public IBSheetListVO<StatOpen> getOpenStatDtSheetAll(StatOpen statOpen, Model model){
		List<StatOpen> list =  new ArrayList<StatOpen>();
		if (statOpen != null) {
			list = statOpenService.getOpenStatDtSheetAll(statOpen);
		}
		return new IBSheetListVO<StatOpen>(list, list.size());
	}

	/**
	 * 보유데이터별 개방 통계 Chart형 자료 조회한다.
	 * @param statOpen
	 * @return Map<String, Object>
	 * @throws Exception
	 */
	@RequestMapping("/admin/stat/open/getOpenStatDtChartAll")
	@ResponseBody
	public Map<String, Object> getOpenStatDtChartAll(StatOpen statOpen){
		Map<String, Object> map = new HashMap<String, Object>();
		if (statOpen != null) {
			map = statOpenService.getOpenStatDtChartAll(statOpen);
			map.put("seriesResult",map.get("seriesResult"));
			map.put("chartDataX",map.get("chartDataX"));
			map.put("chartDataY",map.get("chartDataY"));
		}
		return map;
	}
}

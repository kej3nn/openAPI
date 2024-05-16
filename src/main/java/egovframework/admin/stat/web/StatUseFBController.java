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

import egovframework.admin.stat.service.StatUseFB;
import egovframework.admin.stat.service.StatUseFBService;
import egovframework.common.code.service.CodeListService;
import egovframework.common.grid.IBSheetListVO;
import egovframework.common.helper.Csvdownheler;
import egovframework.common.helper.Exceldownheler;
import egovframework.common.helper.Jsondownheler;
import egovframework.common.helper.Messagehelper;

@Controller
public class StatUseFBController implements InitializingBean {

	protected static final Log logger = LogFactory.getLog(StatUseFBController.class);
	
	//공통코드 사용시 선언
	@Resource
	private CodeListService commCodeListService;
	
	//공통 메시지 사용시 선언
	@Resource
	Messagehelper messagehelper;
	
	@Resource(name="StatUseFBService")
	private StatUseFBService statUseFBService;
	
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
		return codeMap;
	}    
	
	/**
	 * 분류별 활용 통계 조회화면으로 이동한다.
	 * @param model
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/admin/stat/feedback/statUseFBPage.do")
	public String statUseFBPage(ModelMap model){
		return "/admin/stat/feedback/statusefeedback";  
	}
	
	/**
	 * 분류별 활용 통계 Sheet형 자료 조회한디.
	 * @param model
	 * @param statUseFB
	 * @return List<StatUse>
	 * @throws Exception
	 */
	@RequestMapping("/admin/stat/feedback/getUseFBStatSheetAll.do")
	@ResponseBody
	public IBSheetListVO<StatUseFB> getUseFBStatSheetAll(StatUseFB statUseFB, Model model){
		List<StatUseFB> list = new ArrayList<StatUseFB>();
		if (statUseFB != null) {
			list = statUseFBService.getUseFBStatSheetAll(statUseFB);
		}
		return new IBSheetListVO<StatUseFB>(list, list.size());
	}
	
	/**
	 * 분류별 활용 통계 Chart형 자료 조회한다.
	 * @param statUseFB
	 * @return Map<String, Object>
	 * @throws Exception
	 */
	@RequestMapping("/admin/stat/feedback/getUseFBStatChartAll.do")
	@ResponseBody
	public Map<String, Object> getUseFBStatChartAll(StatUseFB statUseFB){
		Map<String, Object> map = new HashMap<String, Object>();
		if (statUseFB != null) {
			map = statUseFBService.getUseFBStatChartAll(statUseFB);
			map.put("seriesResult",map.get("seriesResult"));
			map.put("chartDataX",map.get("chartDataX"));
			map.put("chartDataY",map.get("chartDataY"));
		}
		return map;
	}
}

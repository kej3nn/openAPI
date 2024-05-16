package egovframework.ggportal.data.web;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.ggportal.data.service.PortalOpenDsService;
import egovframework.ggportal.data.service.PortalOpenInfSrvService;
import egovframework.ggportal.data.service.PortalOpenInfVillageService;

/**
 * 우리 지역 데이터 찾기 컨트롤러
 * @author 장홍식
 *
 */
@Controller("ggportalOpenInfVillageController")
public class PortalOpenInfVillageController extends BaseController {
    /**
     * 조회 뷰이름
     */
    public static final Map<String, String> selectViewNames = new HashMap<String, String>();
    
    /*
     * 클래스 변수를 초기화한다.
     */
    static {
        // 조회 뷰이름
        selectViewNames.put(PortalOpenInfSrvService.SERVICE_TYPE_SHEET,   "ggportal/data/village/service/selectSheet");
        selectViewNames.put(PortalOpenInfSrvService.SERVICE_TYPE_CHART,   "ggportal/data/village/service/selectChart");
        selectViewNames.put(PortalOpenInfSrvService.SERVICE_TYPE_MAP,     "ggportal/data/village/service/selectMap");
        selectViewNames.put(PortalOpenInfSrvService.SERVICE_TYPE_FILE,    "ggportal/data/village/service/selectFile");
        selectViewNames.put(PortalOpenInfSrvService.SERVICE_TYPE_OPENAPI, "ggportal/data/village/service/selectOpenApi");
        selectViewNames.put(PortalOpenInfSrvService.SERVICE_TYPE_LINK,    "ggportal/data/village/service/selectLink");
    }
    

	// 우리 지역 데이터 찾기 서비스
	@Resource(name="ggportalOpenInfVillageService")
	private PortalOpenInfVillageService portalOpenInfVillageService;
	
     // 공공데이터 서비스를 관리하는 서비스
    @Resource(name="ggportalOpenInfSrvService")
    private PortalOpenInfSrvService portalOpenInfSrvService;
    
    @Resource(name="ggportalOpenDsService")
    private PortalOpenDsService portalOpenDsService;
    
    /**
     * 우리 지역 데이터 찾기 화면으로 이동.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/data/village/searchVillagePage.do")
    public String searchVillagePage(HttpServletRequest request, Model model) {
        // 뷰이름을 반환한다.
        return "ggportal/data/village/searchVillage";
    }

    /**
     * 시 목록 데이터를 조회.
     * 
     * @param request HTTP 요청
     * @param model 모델
     * @return 뷰이름
     */
    @RequestMapping("/portal/data/village/selectListCity.do")
    public String getCityListData(HttpServletRequest request, Model model) {
    	
    	Object result = portalOpenInfVillageService.selectListCityData();
        
    	addObject(model, result);
    	
    	return "jsonView";
    }

    /**
     * 공공데이터 서비스 조회 화면
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/portal/data/village/selectServicePage.do")
    public String selectServicePage(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 공공데이터 서비스 메타정보를 조회한다.
        Record result = portalOpenInfSrvService.selectOpenInfSrvMetaCUD(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return selectViewNames.get(result.getString("srvCd"));
    }
}

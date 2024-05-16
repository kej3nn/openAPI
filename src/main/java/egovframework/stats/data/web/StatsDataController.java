package egovframework.stats.data.web;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.common.base.controller.BaseController;
import egovframework.common.base.model.Params;
import egovframework.stats.data.service.StatsDataService;

@Controller(value="statsDataController")
public class StatsDataController extends BaseController {
	/**
     * 조회 뷰이름
     */
    public static final Map<String, String> selectViewNames = new HashMap<String, String>();
    
    @Resource(name="statsDataService")
    private StatsDataService statsDataService;
    
    /*
     * 클래스 변수를 초기화한다.
     */
    static {
        // 조회 뷰이름
        selectViewNames.put(StatsDataService.STATS_DATA,   "stat/data/selectStats");
    }
    
    
    @RequestMapping("/stats/data/searchStatsPage.do")
    public String searchStatsPage(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 공공데이터 데이터셋 카테고리를 검색한다.
        //Object result = statsDataService.search(params);
        
        //debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        //addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "stats/data/searchStats";
    }
    
    @RequestMapping("/stats/data/searchStatsTree.do")
    public String searchStatsTree(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 공공데이터 데이터셋 인기순위를 검색한다.
        Object result = statsDataService.searchStatsTree(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
    
    
    @RequestMapping("/stats/data/searchStatsTreeTest.do")
    public String searchStatsTreeTest(HttpServletRequest request, Model model) {
        // 파라메터를 가져온다.
        Params params = getParams(request, false);
        
        debug("Request parameters: " + params);
        
        // 공공데이터 데이터셋 인기순위를 검색한다.
        Object result = statsDataService.searchStatsTreeTest(params);
        
        debug("Processing results: " + result);
        
        // 모델에 객체를 추가한다.
        addObject(model, result);
        
        // 뷰이름을 반환한다.
        return "jsonView";
    }
}

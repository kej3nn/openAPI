package egovframework.admin.basicinf.web;

/**
 * 직원정보 조회 Controller
 *
 * @author KJH
 * @since 2014.07.23
 */

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.admin.basicinf.service.CommUsrSearch;
import egovframework.admin.basicinf.service.CommUsrSearchService;
import egovframework.common.code.service.CodeListService;
import egovframework.common.grid.IBSheetListVO;
import egovframework.common.helper.Messagehelper;


@Controller
public class CommUsrSearchController implements InitializingBean {

    protected static final Log logger = LogFactory.getLog(CommUsrSearchController.class);

    //공통코드 사용시 선언
    @Resource
    private CodeListService commCodeListService;

    @Resource(name = "CommUsrSearchService")
    private CommUsrSearchService commUsrSearchService;

    //공통 메시지 사용시 선언
    @Resource
    Messagehelper messagehelper;


    public void afterPropertiesSet() {

    }

    /**
     * 사용자 조회화면으로 이동한다.
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/basicinf/commUsrSearchPage.do")
    public String commUsrPage(ModelMap model) {
        //페이지 title을 가져오려면 반드시 *Page로 끝나야한다.
        //Interceptor(PageNavigationInterceptor)에서 조회함
        return "/admin/basicinf/commusrSearch";
    }

    /**
     * 조직 조회
     * @param commUsrSearch
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/basicinf/commOrgSearcList.do")
    @ResponseBody
    public IBSheetListVO<CommUsrSearch> commOrgListAll(@ModelAttribute("searchVO") CommUsrSearch commUsrSearch, ModelMap model) {
        //페이징 처리시 반드시 *IbPaging 메소드명을 사용해야함
        Map<String, Object> map = commUsrSearchService.selectCommOrgSearchAllIbPaging(commUsrSearch);
        @SuppressWarnings("unchecked")
        List<CommUsrSearch> result = (List<CommUsrSearch>) map.get("resultList");
        return new IBSheetListVO<CommUsrSearch>(result, result.size());
    }

    /**
     * 직원 조회
     * @param commUsrSearch
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/basicinf/commUsrSearchList.do")
    @ResponseBody
    public IBSheetListVO<CommUsrSearch> commUsrListAll(@ModelAttribute("searchVO") CommUsrSearch commUsrSearch, ModelMap model) {
        //페이징 처리시 반드시 *IbPaging 메소드명을 사용해야함
        Map<String, Object> map = commUsrSearchService.selectCommUsrSearchAllIbPaging(commUsrSearch);
        @SuppressWarnings("unchecked")
        List<CommUsrSearch> result = (List<CommUsrSearch>) map.get("resultList");
        return new IBSheetListVO<CommUsrSearch>(result, result.size());
    }
}

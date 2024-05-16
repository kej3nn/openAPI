
package egovframework.com.cmm.interceptor;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import egovframework.hub.service.Hub;
import egovframework.hub.service.impl.HubDAO;

/**
 * Page 인터셉터 처리 class
 * 성능관련해서 마지막 insert 하는 class
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */
public class LogInterceptor extends HandlerInterceptorAdapter {

    Logger logger = LoggerFactory.getLogger(getClass());
    @Resource(name = "HubDAO")
    private HubDAO hubDao;
    long startTime = 0;
    long endTime = 0;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        this.startTime = System.currentTimeMillis();
        //logger.debug("시작");
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request,
                           HttpServletResponse response, Object handler, ModelAndView modelAndView) {

    }

    @Override
    public void afterCompletion(
            HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {
        //logger.debug("끝");
        this.endTime = System.currentTimeMillis();
        //logger.debug(new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(startTime));
        //logger.debug(new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(endTime));
        Hub hub = (Hub) request.getAttribute("Log");
        if (hub != null) {

            //hub.setOutSize(0);
            hub.setLeadTime(Float.toString((endTime - startTime) / 1000.0f));
            hubDao.insertLog(hub);
        }
    }
}

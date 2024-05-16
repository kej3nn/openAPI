
package egovframework.common.aspect;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import egovframework.com.cmm.SessionLocaleResolver;
import egovframework.common.grid.CommVo;

/**
 * 다국어 처리 class
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */
public class AspectLocale {

    Logger logger = LoggerFactory.getLogger(getClass());
    @Autowired
    private SessionLocaleResolver sessionLocaleResolver;

    /**
     * 다국어 언어를 확인한다.
     *
     * @param Vo
     */
    @SuppressWarnings("unchecked")
    public void setLocale(Object Vo) {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        Locale locale = sessionLocaleResolver.getLocaleNew(request);
        String localeSt = "";
        if (locale == null) {
            localeSt = null;
        } else {
            if (locale.toString().equals("ko_KR") || locale.toString().equals("ko")) {
                localeSt = null;
            } else {
                localeSt = "E";
            }
        }
        if (Vo instanceof ArrayList) {
            ((ArrayList<CommVo>) Vo).get(0).setViewLang(localeSt);
        } else if (Vo instanceof List) {
            ((List<CommVo>) Vo).get(0).setViewLang(localeSt);
        } else if (Vo instanceof CommVo) {
            ((CommVo) Vo).setViewLang(localeSt);
        } else {//class 아닌건 setting 안함
            //logger.debug("아님");
        }
    }
}

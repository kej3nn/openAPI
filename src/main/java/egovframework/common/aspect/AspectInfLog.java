
package egovframework.common.aspect;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import egovframework.com.cmm.SessionLocaleResolver;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.portal.service.service.OpenInfLog;
import egovframework.portal.model.User;

/**
 * 로그 처리하는 class
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */
public class AspectInfLog {

    Logger logger = LoggerFactory.getLogger(getClass());

    @Autowired
    private SessionLocaleResolver sessionLocaleResolver;

    /**
     * 사용자 정보를 구한다.
     *
     * @param Vo
     * @param requset
     */
    public void setUserInfo(OpenInfLog Vo, HttpServletRequest requset) {

        logger.debug("INF LOG AOP 동작중");
        if (EgovUserDetailsHelper.isAuthenticatedPortal()) {
            EgovUserDetailsHelper.getAuthenticatedUserPortal();
            User resultVO = (User) EgovUserDetailsHelper.getAuthenticatedUserPortal();
            Vo.setUserCd(resultVO.getUserCd() + ""); // 나중에 세션으로 처리할 예정//USER_CD -- AOP 주입
        } else {
            Vo.setUserCd("");
        }
        Vo.setSysTag(getSysTag(requset));//SYS_TAG(K,E,M)
        Vo.setUserIp(getUserIp(requset));
    }

    /**
     * 사용자의 언어를 구한다.
     *
     * @param requset
     * @return
     */
    public String getSysTag(HttpServletRequest requset) {
        String userAgent = requset.getHeader("user-agent");
        boolean mobile1 = userAgent.matches(".*(iPhone|iPod|Android|Windows CE|BlackBerry|Symbian|Windows Phone|webOs|Opera Mini|Opera Mobi|POLARIS|IEMobile|lgtelecom|nokis|SynyEricsson).*");
        boolean mobile2 = userAgent.matches(".*(LG|SAMSUNG|Samsung).*");
        if (mobile1 || mobile2) { //모바일
            return "M";
        }
        Locale locale = sessionLocaleResolver.getLocaleNew(requset);
        if (locale == null) {//한글
            return "K";
        } else {
            if (locale.toString().equals("ko_KR") || locale.toString().equals("ko")) {
                return "K";//한글
            } else {
                return "E";//영문
            }
        }
    }

    /**
     * ip를 구한다.
     *
     * @param requset
     * @return
     */
    public String getUserIp(HttpServletRequest requset) {
        String local_ip = "";
        local_ip = requset.getRemoteAddr();
        return local_ip;
    }
}

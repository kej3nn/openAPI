package egovframework.com.cmm.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import egovframework.com.cmm.service.EgovUserDetailsService;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * @author 공통서비스 개발팀 서준식
 * @version 1.0
 * @see <pre>
 * 개정이력(Modification Information)
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2011. 8. 12.    서준식        최초생성
 *
 *  </pre>
 * @since 2011. 8. 12.
 */

public class EgovTestUserDetailsServiceImpl extends AbstractServiceImpl implements
        EgovUserDetailsService {

    public Object getAuthenticatedUser() {
        return RequestContextHolder.getRequestAttributes().getAttribute("loginVO", RequestAttributes.SCOPE_SESSION);
    }

    public Object getAuthenticatedUserPortal() {
        return RequestContextHolder.getRequestAttributes().getAttribute("PortalLoginVO", RequestAttributes.SCOPE_SESSION);
    }

    public List<String> getAuthorities() {
        // 권한 설정을 리턴한다.
        List<String> listAuth = new ArrayList<String>();

        return listAuth;
    }

    public Boolean isAuthenticated() {
        // 인증된 유저인지 확인한다.

        if (RequestContextHolder.getRequestAttributes() == null) {
            return false;
        } else {

            if (RequestContextHolder.getRequestAttributes().getAttribute(
                    "loginVO", RequestAttributes.SCOPE_SESSION) == null) {
                return false;
            } else {
                return true;
            }
        }
    }

    public Boolean isAuthenticatedPortal() {
        // 인증된 유저인지 확인한다.

        if (RequestContextHolder.getRequestAttributes() == null) {
            return false;
        } else {

            if (RequestContextHolder.getRequestAttributes().getAttribute(
                    "PortalLoginVO", RequestAttributes.SCOPE_SESSION) == null) {
                return false;
            } else {
                return true;
            }
        }
    }

}

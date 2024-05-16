package egovframework.com.cmm;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.dao.DataAccessException;

import egovframework.rte.fdl.cmmn.exception.handler.ExceptionHandler;

/**
 * @author 공통 서비스 개발팀 이삼섭
 * @Class Name : EgovComExcepHndlr.java
 * @Description : 공통서비스의 exception 처리 클래스
 * @Modification Information
 * <p>
 * 수정일       수정자         수정내용
 * -------        -------     -------------------
 * 2009. 3. 13.     이삼섭
 * @see
 * @since 2009. 3. 13.
 */
public class EgovComExcepHndlr implements ExceptionHandler {

    protected Log log = LogFactory.getLog(this.getClass());

    /**
     * 발생된 Exception을 처리한다.
     */
    public void occur(Exception ex, String packageName) {
        try {
            log.error(packageName, ex);
        } catch (DataAccessException dae) {
            log.fatal(packageName, dae);
        } catch (Exception e) {
            log.fatal(packageName, ex);// 2011.10.10 보안점검 후속조치
        }
    }
}

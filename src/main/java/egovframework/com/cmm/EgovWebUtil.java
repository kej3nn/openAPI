package egovframework.com.cmm;

import java.util.regex.Pattern;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.exception.SessionException;
import egovframework.common.base.exception.SystemException;
import egovframework.common.util.UtilString;

/**
 * 교차접속 스크립트 공격 취약성 방지(파라미터 문자열 교체)
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    	--------    ---------------------------
 *   2011.10.10  한성곤          최초 생성
 *
 * </pre>
 */

public class EgovWebUtil {
    // 로그
    public static Log log = LogFactory.getLog(EgovWebUtil.class);

    public static String clearXSSMinimum(String value) {
        if (value == null || value.trim().equals("")) {
            return "";
        }

        String returnValue = value;

        returnValue = returnValue.replaceAll("&", "&amp;");
        returnValue = returnValue.replaceAll("<", "&lt;");
        returnValue = returnValue.replaceAll(">", "&gt;");
        returnValue = returnValue.replaceAll("\"", "&#34;");
        returnValue = returnValue.replaceAll("\'", "&#39;");
        return returnValue;
    }

    public static String clearXSSMaximum(String value) {
        String returnValue = value;
        returnValue = clearXSSMinimum(returnValue);

        returnValue = returnValue.replaceAll("%00", null);

        returnValue = returnValue.replaceAll("%", "&#37;");

        // \\. => .

        returnValue = returnValue.replaceAll("\\.\\./", ""); // ../
        returnValue = returnValue.replaceAll("\\.\\.\\\\", ""); // ..\
        returnValue = returnValue.replaceAll("\\./", ""); // ./
        returnValue = returnValue.replaceAll("%2F", "");

        return returnValue;
    }

    public static String filePathBlackList(String value) {
        String returnValue = value;
        if (returnValue == null || returnValue.trim().equals("")) {
            return "";
        }

        returnValue = returnValue.replaceAll("\\.\\./", ""); // ../
        returnValue = returnValue.replaceAll("\\.\\.\\\\", ""); // ..\

        return returnValue;
    }

    /**
     * 행안부 보안취약점 점검 조치 방안.
     *
     * @param value
     * @return
     */
    public static String filePathReplaceAll(String value) {
        String returnValue = value;
        if (returnValue == null || returnValue.trim().equals("")) {
            return "";
        }
        returnValue = returnValue.replaceAll("/", "");
        returnValue = UtilString.replace(returnValue, "\\", "");
        returnValue = returnValue.replaceAll("\\.\\.", ""); // ..
        returnValue = returnValue.replaceAll("&", "");

        return returnValue;
    }

    public static String folderPathReplaceAll(String value) {
        String returnValue = value;
        if (returnValue == null || returnValue.trim().equals("")) {
            return "";
        }
        returnValue = returnValue.replaceAll("&", "");
        return returnValue;
    }

    public static String filePathWhiteList(String value) {
        return value;
    }

    public static boolean isIPAddress(String str) {
        Pattern ipPattern = Pattern.compile("\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}");

        return ipPattern.matcher(str).matches();
    }

    public static String removeCRLF(String parameter) {
        return parameter.replaceAll("\r", "").replaceAll("\n", "");
    }

    public static String removeSQLInjectionRisk(String parameter) {
        return parameter.replaceAll("\\p{Space}", "").replaceAll("\\*", "").replaceAll("%", "").replaceAll(";", "").replaceAll("-", "").replaceAll("\\+", "").replaceAll(",", "");
    }

    public static String removeOSCmdRisk(String parameter) {
        return parameter.replaceAll("\\p{Space}", "").replaceAll("\\*", "").replaceAll("|", "").replaceAll(";", "");
    }

    /**
     * 로그 에러처리
     */
    public static final void exLogging(Object obj) {
        if (obj instanceof ServiceException) {
            log.error("exLogging ServiceException : " + ((ServiceException) obj).getMessage());
            throw new ServiceException(((ServiceException) obj).getMessage());
        } else if (obj instanceof SystemException) {
            log.error("exLogging SystemException : " + ((SystemException) obj).getMessage());
            throw new ServiceException(((SystemException) obj).getMessage());
        } else if (obj instanceof SessionException) {
            log.error("exLogging SessionException : " + ((SessionException) obj).getMessage());
            throw new SessionException(((SessionException) obj).getMessage());
        } else if (obj instanceof java.lang.Exception) {
            ((java.lang.Exception) obj).printStackTrace();
            log.error("exLogging Exception : " + ((Exception) obj).getMessage());
        }
    }

    /**
     * 로그 에러처리(트랜젝션 롤백 포함)
     */
    public static final void exTransactionLogging(Object obj) {
        if (obj instanceof ServiceException) {
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            log.error("exTransactionLogging ServiceException : " + ((ServiceException) obj).getMessage());
            throw new ServiceException(((ServiceException) obj).getMessage());
        } else if (obj instanceof SystemException) {
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            log.error("exTransactionLogging SystemException : " + ((SystemException) obj).getMessage());
            throw new ServiceException(((SystemException) obj).getMessage());
        } else if (obj instanceof SessionException) {
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            log.error("exTransactionLogging SessionException : " + ((SessionException) obj).getMessage());
            throw new SessionException(((SessionException) obj).getMessage());
        } else if (obj instanceof java.lang.Exception) {
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            log.error("exTransactionLogging Exception : " + ((Exception) obj).getMessage());
        }
    }

}
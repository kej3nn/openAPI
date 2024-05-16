package egovframework.common.util;

/**
 * Number 관련 util
 *
 * @author wiseopen
 * @version 1.0
 * @see wiseitech
 * @since 2014.04.17
 */
public class UtilNumber {
    /**
     * int 경우 true 아닐 경우 false를 반환한다.
     *
     * @param str
     * @return boolean
     */
    public static boolean isInt(String str) {
        if (UtilString.isBlank(str))
            return false;

        try {
            Integer.parseInt(str);
            return true;
        } catch (NumberFormatException nfe) {
            return false;
        }
    }


}
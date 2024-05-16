package egovframework.common.util;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.lang.reflect.Array;
import java.lang.reflect.Field;
import java.util.Enumeration;
import java.util.Vector;


/**
 * @version 1.0<br>
 * 클래스 설명 ------------------------------------------------------------------------<br>
 * Object 관련 기능성 Method를 제공하는 Util Class<br>
 * <br>
 * ----------------------------------------------------------------------------------<br>
 */
public class UtilObject {
    /**
     * Caller Class <code>CALL_CLASS</code>
     */
    public static final int CALL_CLASS = 1;
    /**
     * Caller Method <code>CALL_METHOD</code>
     */
    public static final int CALL_METHOD = 2;
    /**
     * Caller LineNumber <code>CALL_LINENUM</code>
     */
    public static final int CALL_LINENUM = 4;

    /**
     * 생성자
     */
    public UtilObject() {
    }

    /**
     * Object의 Null Check
     *
     * @param tmpObject Null Check할 Object
     * @return Object가 null이면 true, instance화 되어 있으면 false
     */
    public static boolean isNull(Object tmpObject) {
        if (tmpObject == null)
            return true;
        else
            return false;
    }

    /**
     * Object 배열의 Null Check
     *
     * @param tmpObject Null Check할 Object 배열
     * @return Object배열이 null이면 true, instance화 되어 있으면 false
     */
    public static boolean isArrayNull(Object[] tmpObject) {
        if (tmpObject == null || tmpObject.length < 1)
            return true;
        else
            return false;
    }


    /**
     * 현재 Object를 호출한 Class를 반환한다.
     *
     * @return Caller 리스트 문자열
     */
    public static String getCallerClass() {
        return getCaller(2, CALL_CLASS);
    }

    /**
     * 현재 Object를 호출한 Method를 반환한다.
     *
     * @return Caller 리스트 문자열
     */
    public static String getCallerMethod() {
        return getCaller(2, CALL_METHOD);
    }

    /**
     * 현재 Object를 호출한 Line Num을 반환한다.
     *
     * @return Caller 리스트 문자
     */
    public static String getCallerLine() {
        return getCaller(2, CALL_LINENUM);
    }

    /**
     * 현재 Object를 호출한 class 및 method, linenum을 주어진 Depth만큼 List한다.
     *
     * @param depth 확인코저 하는 caller depth
     * @return caller 리스트 문자열
     */
    public static String getCaller(int depth) {
        return getCaller(depth + 1, CALL_CLASS + CALL_METHOD + CALL_LINENUM);
    }

    /**
     * 현재 Object를 호출한 주어진 Depth만큼 List한다.
     * Type에 따라 CLASS/METHOD/LINENUM
     *
     * @param depth 확인고자 하는 caller depth
     * @param type  확인하고자 하는 타입(CLASS/METHOD/LINENUM)
     * @return caller 리스트 문자열
     */
    public static String getCaller(int depth, int type) {
        StringBuffer sb = new StringBuffer();

        Throwable tmpThrowable = new Throwable();
        tmpThrowable.fillInStackTrace();
        StackTraceElement[] tmpElement = tmpThrowable.getStackTrace();

        if (!isArrayNull(tmpElement)) {
            if ((type & CALL_CLASS) == CALL_CLASS)
                sb.append("CLASS[" + tmpElement[depth].getClassName() + "]");

            if ((type & CALL_METHOD) == CALL_METHOD)
                sb.append(" METHOD[" + tmpElement[depth].getMethodName() + "]");

            if ((type & CALL_LINENUM) == CALL_LINENUM)
                sb.append(" LINE[" + tmpElement[depth].getLineNumber() + "]");


            return sb.toString();
        }

        return null;
    }
}

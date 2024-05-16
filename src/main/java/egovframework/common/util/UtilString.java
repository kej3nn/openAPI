
package egovframework.common.util;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.ObjectOutputStream;
import java.lang.reflect.Method;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.StringTokenizer;
import java.util.Vector;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.dao.DataAccessException;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.common.file.service.FileVo;

/**
 * @version 1.0<br>
 * 클래스 설명 ------------------------------------------------------------------------<br>
 * String 관련 기능성 Method를 제공하는 Util Class<br>
 * <br>
 * ----------------------------------------------------------------------------------<br>
 */
public class UtilString {
    /**
     * null을 다른 문자로 변환해 준다.
     *
     * @param nullStr
     * @param rplStr
     * @return String
     */
    public static final String replaceNull(String nullStr, String rplStr) {
        String result = "";
        if (nullStr == null || nullStr.trim().length() < 1) {
            result = rplStr;
        } else {
            result = nullStr;
        }
        return result;
    }

    /**
     * String의 Null Check
     *
     * @param tmpString
     * @return null일 경우 true, null이 아닐경우 false
     */
    public static boolean isNull(String tmpString) {
        return UtilObject.isNull(tmpString);
    }

    /**
     * String[]의 Null Check
     *
     * @param tmpString String 배열
     * @return null일 경우 true, null이 아닐경우 false
     */
    public static boolean isNull(String[] tmpString) {
        return UtilObject.isArrayNull(tmpString);
    }

    /**
     * String의 Blank여부 체크
     *
     * @param tmpString
     * @return null, "" 일 경우 true, null이 아니며, Blank String일 경우 false
     */
    public static boolean isBlank(String tmpString) {
        if (isNull(tmpString))
            return true;
        else {
            if (tmpString.equals(""))
                return true;
            else
                return false;
        }
    }


    /**
     * String[]의 Blank여부 체크
     *
     * @param tmpString Stirng 배열
     * @return null, "" 일 경우 true, null이 아니며, Blank String일 경우 false
     */
    public static boolean isBlank(String[] tmpString) {
        if (isNull(tmpString))
            return true;
        else {
            if (tmpString.length > 0)
                return false;
            else
                return true;
        }
    }


    /**
     * Object가 null일 경우 Blank String으로 반환한다.
     *
     * @param obj
     * @return String 입력 Object가 null일 경우 "" 반환, 이외의 경우에는 입력 Object의 toString() 반환
     */
    public static String null2Blank(Object obj) {
        if (!UtilObject.isNull(obj))
            return (obj.toString());
        else
            return "";
    }


    /**
     * 특정문자를 변환한다.
     *
     * @param source  source 문자열
     * @param pattern 바꿀 문자패턴
     * @param replace 적용할 문자패턴
     * @return 변환된 문자
     */
    public static String replace(String source, String pattern, String replace) {
        if (source != null) {
            final int len = pattern.length();
            StringBuffer sb = new StringBuffer();
            int found = -1;
            int start = 0;

            while ((found = source.indexOf(pattern, start)) != -1) {
                sb.append(source.substring(start, found));
                sb.append(replace);
                start = found + len;
            }

            sb.append(source.substring(start));

            return sb.toString();
        } else
            return "";
    }

    /**
     * 스트링을 우측을 기준으로 size크기의 String을 반환한다.
     *
     * @param str  입력String
     * @param size 획득코저하는 사이즈
     * @return 우측을 기준으로 size 만큼의 String
     */
    public static String getRight(String str, int size) {
        int tmpStringLength = str.length();

        if (size >= tmpStringLength)
            return str;
        else
            return str.substring(tmpStringLength - size, str.length());
    }

    /**
     * String을 좌측을 기준으로 size크기의 String을 반환한다.
     *
     * @param str  입력String
     * @param size 획득코저하는 사이즈
     * @return 좌측을 기준으로 size 만큼의 String
     */
    public static String getLeft(String str, int size) {
        int tmpStringLength = str.length();

        if (size >= tmpStringLength)
            return str;
        else
            return str.substring(0, size);
    }


    /**
     * String을 XML로 변환하기 위해 특수문자를 XML 형식으로 변환
     *
     * @param strString 변환할 문자열
     * @return 변화된 문자열
     */
    public static String str2XML(String strString) {
        String result = convert2APOS(convert2QUOT(convert2GT(convert2LT(convert2AMP(strString)))));
        return result;
    }

    /**
     * XML형식으로 변환되어 있는 특수문자를 원본으로 변환
     *
     * @param strString 변환할 문자열
     * @return 변화된 문자열
     */
    public static String xml2Str(String strString) {
        String result = reverse2APOS(reverse2QUOT(reverse2GT(reverse2LT(reverse2AMP(strString)))));
        return result;
    }


    /**
     * 특수문자를 XML에 맞도록 변환해주는 메소드
     *
     * @param srcText 변환할 문자열
     * @return 변화된 문자열
     */
    public static String str2Html(String srcText) {
        if (isBlank(srcText))
            return "";
        else {
            String strip = "";
            strip = "&";
            srcText = replace(srcText, strip, "&amp;");
            strip = "<";
            srcText = replace(srcText, strip, "&lt;");
            strip = ">";
            srcText = replace(srcText, strip, "&gt;");
            strip = "\\n";
            srcText = replace(srcText, strip, "<br>");
            strip = "\"";
            srcText = replace(srcText, strip, "&quot;");
            strip = "'";
            srcText = replace(srcText, strip, "&apos;");
            strip = " ";
            srcText = replace(srcText, strip, "&nbsp;");
            return srcText;
        }
    }


    /**
     * '<' 를 &lt; 로 변환
     *
     * @param strString String
     * @return String
     */
    public static String convert2LT(String strString) {
        if (isBlank(strString))
            return "";
        else
            return replace(strString, "<", "&lt;");
    }

    /**
     * '&lt'를 '<'로 변환
     *
     * @param strString 변환할 문자열
     * @return 변화된 문자열
     */
    public static String reverse2LT(String strString) {
        if (isBlank(strString))
            return "";
        else
            return replace(strString, "&lt;", "<");
    }

    /**
     * >를 &gt;로 변환
     *
     * @param strString
     * @return String
     */
    public static String convert2GT(String strString) {
        if (isBlank(strString))
            return "";
        else
            return replace(strString, ">", "&gt;");
    }

    /**
     * '&gt;'를 '>'로 변환
     *
     * @param strString 변환할 문자열
     * @return 변화된 문자열
     */
    public static String reverse2GT(String strString) {
        if (isBlank(strString))
            return "";
        else
            return replace(strString, "&gt;", ">");
    }

    /**
     * & 를 HTML &amp; 로 변환
     *
     * @param strString 변환할 문자열
     * @return String 변화된 문자열
     */
    public static String convert2AMP(String strString) {
        if (isBlank(strString))
            return "";
        else
            return replace(strString, "&", "&amp;");
    }

    /**
     * '&amp;'를 '&'로 변환
     *
     * @param strString 변환할 문자열
     * @return 변화된 문자열
     */
    public static String reverse2AMP(String strString) {
        if (isBlank(strString))
            return "";
        else
            return replace(strString, "&amp;", "&");

    }

    /**
     * '&middot;'를 '·'로 변환
     *
     * @param strString 변환할 문자열
     * @return 변화된 문자열
     */
    public static String reverse2MIDDOT(String strString) {
        if (isBlank(strString))
            return "";
        else
            return replace(strString, "&middot;", "·");
    }

    /**
     * '\r'을 <br> 로 변환해주는 메소드
     *
     * @param strString String
     * @return String
     */
    public static String convert2BR(String strString) {
        if (isBlank(strString))
            return "";
        else
            return replace(strString, "\\n", "<br>");
    }

    /**
     * ' 를 &apos; 로 변환
     *
     * @param strString
     * @return String
     */
    public static String convert2APOS(String strString) {
        if (isBlank(strString))
            return "";
        else
            return replace(strString, "'", "&apos;");
    }

    /**
     * '&apos;'를 '''로 변환
     *
     * @param strString 변환할 문자열
     * @return 변화된 문자열
     */
    public static String reverse2APOS(String strString) {
        if (isBlank(strString))
            return "";
        else
            return replace(strString, "&apos;", "'");
    }

    /**
     * '"' 를 &quot; 로 변환
     *
     * @param strString
     * @return String
     */
    public static String convert2QUOT(String strString) {
        if (isBlank(strString))
            return "";
        else
            return replace(strString, "\"", "&quot;");
    }


    /**
     * '&quot;'를 '\"'로 변환
     *
     * @param strString 변환할 문자열
     * @return 변화된 문자열
     */
    public static String reverse2QUOT(String strString) {
        if (isBlank(strString))
            return "";
        else
            return replace(strString, "&quot;", "\"");
    }


///////////////////////////////////////////////////////////

    /**
     * 스트링을 특정 문자를 기준으로 나누어 Vector형태로 반환한다.
     *
     * @param strString    : input string
     * @param strDelimeter : delimeter character
     * @return Vector : result string
     */
    public static Vector getSplitVector(String strString, String strDelimeter) {
        Vector vResult = new Vector();
        int nCount = 0, nLastIndex = 0;
        try {
            nLastIndex = strString.indexOf(strDelimeter);

            if (nLastIndex == -1) {
                vResult.add(0, strString);
            } else {
                while ((strString.indexOf(strDelimeter) > -1)) {
                    nLastIndex = strString.indexOf(strDelimeter);
                    vResult.add(nCount, strString.substring(0, nLastIndex));
                    strString = strString.substring(nLastIndex + strDelimeter.length(), strString.length());
                    nCount++;
                }
                vResult.add(nCount, strString);
            }
        } catch (ArrayIndexOutOfBoundsException e) {
            vResult.add(0, strString);
            return vResult;
        } catch (Exception e) {
            vResult.add(0, strString);
            return vResult;
        } finally {

        }
        return vResult;
    }

    /**
     * String을 특정 문자를 기준으로 나누어 배열형태로 반환한다.
     *
     * @param strString    : input string
     * @param strDelimeter : delimeter character
     * @return String[]
     */
    public static String[] getSplitArray(String strString, String strDelimeter) {
//	    StringTokenizer strToken = new StringTokenizer(strString, strDelimeter );
//
//	    String arrStr[] = new String[ strToken.countTokens() ];
//	    int i=0;
//	    while(strToken.hasMoreTokens())
//	    {
//	        arrStr[i] = strToken.nextToken();
//	        i++;
//	    }
//	    return arrStr;

        return (String[]) (getSplitVector(strString, strDelimeter).toArray(new String[0]));
    }

    /**
     * 입력 String에 있는 특정문자를 삭제해준다.
     *
     * @param strString input String
     * @param strChar   special character
     * @return String 특정문자를 제거한 문자
     */
    public static String deleteChar(String strString, char strChar) {
		/* 시큐어코딩에 걸려서 수정함
    	if ( isBlank(strString) )
    		return "";

    	strString = strString.trim();
    	byte[] source = strString.getBytes();
    	byte[] result = new byte[source.length];
    	int j = 0;
    	for (int i = 0; i < source.length; i++)
    	{
    		if (source[i] != (byte)strChar )
    			result[j++] = source[i];
    	}
    	return new String(result).trim();
    	*/
        strString = strString.trim();
        char[] result = new char[strString.length()];
        int j = 0;
        for (int i = 0; i < result.length; i++) {
            if (strChar != strString.charAt(i)) {
                result[j++] = strString.charAt(i);
            }
        }
        return new String(result).trim();
    }


    /**
     * 바꾸고자 하는 스트링의 인덱스 모음을 구한다.
     *
     * @param str  String
     * @param word String
     * @return Vector tempindexArray
     */
    public static Vector getSelectedTextIndex(String str, String word) {
        int index = 0;
        int fromIndex = 0;
        Vector tempIndexArray = new Vector();
        do {
            index = str.indexOf(word, fromIndex);
            if (index != -1) {
                tempIndexArray.add(new Integer(index));
                fromIndex = index + word.length();
            }
        }
        while (index != -1);
        return tempIndexArray;
    }


    /**
     * 왼쪽(Left)에 문자열을 끼어 넣는다.
     * width는 문자열의 전체 길이를 나타내며 chPad는 끼어 넣을 char
     *
     * @param str   적용할 문자열
     * @param width 전체 문자열 크기
     * @param chPad pad 적용할 char
     * @return leftpad된 String
     */
    public static String setLeftPad(String str, int width, char chPad) {
        StringBuffer paddedValue = new StringBuffer();

        for (int i = str.length(); i < width; i++)
            paddedValue.append(chPad);

        paddedValue.append(str);

        return (paddedValue.toString()).substring(0, width);
    }

    /**
     * 오른쪽(right)에 문자열을 끼어 넣는다.
     * width는 문자열의 전체 길이를 나타내며, chPad는 끼어 넣을 char
     *
     * @param str   적용할 문자열
     * @param width 전체 길이
     * @param chPad 삽입할 char
     * @return String
     */
    public static String setRightPad(String str, int width, char chPad) {
        if (str.length() >= width)
            return str.substring(0, width);

        StringBuffer paddingValue = new StringBuffer();
        for (int i = str.length(); i < width; i++)
            paddingValue.append(chPad);

        return str + paddingValue.toString();
    }

    /**
     * 한글이 포함되어 있는지 여부를 확인하여, 한글 포함 갯수를 반환한다.
     *
     * @param str 한글 포함여부를 확인하고자 하는 String
     * @return 포함 한글 갯수
     */
    public static int checkHangul(String str) {
        int cnt = 0;

        if (isBlank(str))
            return 0;

        int index = 0;

        while (index < str.length()) {
            if (str.charAt(index++) >= 256)
                cnt++;
        }

        return cnt;
    }

    public static String byteSubString(String src, int beginIndex, int endIndex) {

        if (UtilString.isBlank(src))
            return "";
        byte[] value = src.getBytes();

        try {
            if (beginIndex < 0)
                throw new StringIndexOutOfBoundsException(beginIndex);

            if (endIndex > value.length)
                throw new StringIndexOutOfBoundsException(endIndex);

            if (beginIndex > endIndex)
                throw new StringIndexOutOfBoundsException(endIndex - beginIndex);

        } catch (StringIndexOutOfBoundsException si) {
            EgovWebUtil.exLogging(si);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        byte[] tmpByte = new byte[endIndex - beginIndex];
        System.arraycopy(value, beginIndex, tmpByte, 0, tmpByte.length);

        return new String(tmpByte);

    }

    public static String[] getSplit(String strString, String strDelimeter) {
        StringTokenizer strToken = new StringTokenizer(strString, strDelimeter);

        String arrStr[] = new String[strToken.countTokens()];
        int i = 0;
        while (strToken.hasMoreTokens()) {
            arrStr[i] = strToken.nextToken();
            i++;
        }
        return arrStr;
    }


    /**
     * 특정문자를 인텍스 기준으로 하여  해당 문자 갯수만큼 검색하여 인덱스값을 리턴한다.
     *
     * @param str index값을 확인하고자하는  String
     *            targetIndex 인덱스로 쓰기 위한 문자
     *            count 인덱스로 사용하는 문자를 검색할 수
     * @return strIndex 특정문자 인덱스에 해당하는 인덱스값
     */
    public static int getStrIndex(String str, char targetIndex, int count) {
        int targetIndexCnt = 0; //타겟 문자의 검색 갯수
        int strIndex = 0; // String index값
        int strLen = str.length() - 1;
        for (int i = 0; i <= strLen; i++) {
            if (str.charAt(i) == targetIndex) {
                targetIndexCnt++;
            }
            if (targetIndexCnt == count) {
                break;
            }
            strIndex++;
        }
        return strIndex;
    }

    public static int checkSpChar(String str) {
        int cnt = 0;

        if (isBlank(str))
            return 0;

        int index = 0;

        while (index < str.length()) {
            if ((str.charAt(index) >= 32 && str.charAt(index) <= 64) || (str.charAt(index) >= 91 && str.charAt(index) <= 96))
                cnt++;
            index++;
        }

        return cnt;
    }

    /**
     * DataSet의 해당 key 값에 저장되어 있는 값이 String형을 경우
     * String으로 변환하여 돌려 준다.
     * 저장 값이 null이 거나, String이 아니면 빈 문자를 돌려 준다.
     *
     * @param key key값
     * @return key값에 해당하는 String형 값
     */
    public static String getString(Object key) {
        Object strObj = key;
        if (strObj == null) {
            return "";
        }

        if (strObj instanceof String) {
            return (String) strObj;
        }

        if (strObj == null || !(strObj instanceof String)) {
            return String.valueOf(strObj);
        }

        return "";
    }

    /**
     * DataSet의 해당 key 값에 저장되어 있는 값이 String 배열 일 경우
     * String 배열로로 변환하여 돌려 준다. 단, String일 경우 크기가 1인
     * String배열을 생성하여 돌려 둔다.
     * 저장 값이 null이 거나, String배열 또는 String 형이 아니면 null을 돌려 준다.
     *
     * @param key
     * @return
     */
    public static String[] getStrings(String key) {
        String[] strs;
        Object strObj = key;
        if (strObj == null) {
            return null;
        } else {
            if (strObj instanceof String) {
                strs = new String[1];
                strs[0] = (String) strObj;
            } else if (strObj instanceof String[]) {
                strs = (String[]) strObj;
            } else {
                return null;
            }

            return strs;
        }
    }


    /**
     * 더블 형태로 리턴한다.
     *
     * @param key
     * @return
     */
    public static double getDouble(Object key) {
        Object dblObj = key;
        if (dblObj instanceof Float) {
            return ((Float) dblObj).doubleValue();
        } else if (dblObj instanceof Double) {
            return ((Double) dblObj).doubleValue();
        } else if (dblObj instanceof String) {
            return Double.parseDouble((String) dblObj);
        } else if (dblObj instanceof Integer) {
            return ((Integer) dblObj).doubleValue();
        } else if (dblObj instanceof Long) {
            return ((Long) dblObj).doubleValue();
        } else return -1;
    }

    /**
     * 롱형태로 리턴한다.
     *
     * @param key
     * @return
     */
    public static long getLong(Object key) {
        Object lngObj = key;

        if (lngObj instanceof Integer) {
            return ((Integer) lngObj).longValue();
        } else if (lngObj instanceof Long) {
            return ((Long) lngObj).longValue();
        } else if (lngObj instanceof Float) {
            return ((Float) lngObj).longValue();
        } else if (lngObj instanceof Double) {
            return ((Double) lngObj).longValue();
        } else if (lngObj instanceof String) {
            return Long.parseLong((String) lngObj);
        } else {
            return -1;                     // 데이타 컨버전 에러
        }
    }

    /**
     * 정수형태로 리턴한다.
     *
     * @param key
     * @return
     */
    public static int getInteger(Object key) {
        Object intObj = key;
        try {
            if (intObj instanceof String) {
                return Integer.parseInt((String) intObj);
            } else if (intObj instanceof Integer) {
                return ((Integer) intObj).intValue();
            } else if (intObj instanceof Long) {
                return ((Long) intObj).intValue();
            } else if (intObj instanceof Float) {
                return ((Float) intObj).intValue();
            } else if (intObj instanceof Double) {
                return ((Double) intObj).intValue();
            } else {
                throw new NumberFormatException();
            }
        } catch (NumberFormatException nfe) {
            EgovWebUtil.exLogging(nfe);
            throw new NumberFormatException();
        }
    }

    /**
     * 실수형태로 조회한다.
     *
     * @param key
     * @return
     */
    public static float getFloat(Object key) {
        Object fltObj = key;

        if (fltObj instanceof Float) {
            return ((Float) fltObj).floatValue();
        } else if (fltObj instanceof Double) {
            return ((Double) fltObj).floatValue();
        } else if (fltObj instanceof String) {
            return Float.parseFloat((String) fltObj);
        } else if (fltObj instanceof Integer) {
            return ((Integer) fltObj).floatValue();
        } else if (fltObj instanceof Long) {
            return ((Long) fltObj).floatValue();
        } else {
            return -1;                     // 데이타 컨버전 에러
        }
    }

    /**
     * 10 미만에 0 숫자를 붙여준다.
     *
     * @param value
     * @return
     */
    public static String getZeroDate(int value) {
        if (value < 10) {
            return "0" + value;
        }
        return "" + value;
    }

    /**
     * 브라우져의 parameter를 파싱한다.
     *
     * @param request
     * @param obj
     * @param fileVo
     * @return
     * @throws Exception
     */
    public static List<?> setQueryStringData(HttpServletRequest request, Object obj, FileVo fileVo) {
        List<Object> list = new ArrayList<Object>();
        try {

            String queryString = request.getQueryString();
            if (queryString != null) {    //서비스 여부만 수정하는경우 null 처리
                queryString = URLDecoder.decode(request.getQueryString(), "UTF-8").replaceAll("\\|", "%20").replaceAll("\\+", "%20");        //한글 문제로 decode하여 가져온다.
            } else {
                return list;
            }/* 시큐어코딩에 걸려 수정함
		Class<?> classObj = Class.forName(obj.getClass().getName());
    		 */
            Class<?> classObj = obj.getClass();
            Method[] m = obj.getClass().getMethods();
            int dataCnt = 0;
            String firstNm = "";
            Object newObj = classObj.newInstance();

            //신규 파일인경우 파일명과 파일사이즈 파일에서 추출하기 위해

            if (!UtilString.null2Blank(queryString).equals("")) {
                String[] arrString = UtilString.getSplitArray(queryString, "&");        //queryString으로 온 텍스트 split하여 배열에 담는다.
                int fileCnt = 0;        //파일갯수
                int fileSeqCnt = 0;        //파일순번 갯수
                int saveFileCnt = 0;    //저장파일 갯수
                for (int i = 0; i < arrString.length; i++) {
                    String[] arrParam = UtilString.getSplitArray(arrString[i], "=");
                    if (firstNm.equals(arrParam[0]) && dataCnt != 0) { //첫번째 이름과 같으면서 데이터가 있으면 list 추가 한다.
                        list.add(newObj);
                        newObj = classObj.newInstance();
                        dataCnt = 0;
                    }

                    //Setter..
                    for (int j = 0; j < m.length; j++) {
                        if (m[j].getName().substring(0, 3).equals("set")) { //setter 메소드만 가져온다.
                            String paramNm = arrParam[0].toUpperCase();
                            String mNm = m[j].getName().substring(3, m[j].getName().length()).toUpperCase();
                            if (paramNm.equals(mNm)) { // setter 메소드와 같으면 데이터를 setting한다.
                                if (paramNm.equals("FILESIZE")) {                        //파일사이즈 입력
                                    if (arrParam[1].equals("")) {
                                        m[j].invoke(newObj, (int) fileVo.getSaveFile()[fileCnt++].getSize());
                                    } else {
                                        m[j].invoke(newObj, Integer.parseInt(arrParam[1]));
                                    }
                                    dataCnt++;
                                } else if (paramNm.equals("SAVEFILENM")) {    //파일명 저장
                                    if (arrParam[1].equals("")) {                                                //신규 등록이면
                                        m[j].invoke(newObj, fileVo.getSaveFileNm()[saveFileCnt++]);                //픔으로 넘어온 파일정보의 파일명 사용(순서맞게)
                                    } else {
                                        m[j].invoke(newObj, arrParam[1]);
                                    }
                                    dataCnt++;
                                } else if (paramNm.equals("FILESEQ")) {
                                    if (arrParam[1].equals("")) {        //file seq는 무조건 integer
                                        m[j].invoke(newObj, Integer.parseInt(getFileNm(fileVo.getSaveFileNm()[fileSeqCnt++])));
                                    } else {
                                        m[j].invoke(newObj, Integer.parseInt(arrParam[1]));    //일반적인 경우
                                    }
                                    dataCnt++;
                                } else {

                                    String type = m[j].getParameterTypes()[0].getName();
                                    if (arrParam.length == 2) {
                                        if (type.equals("int") || type.equals("java.lang.Integer")) { // 타입이 숫자면 숫자타입으로
                                            m[j].invoke(newObj, Integer.parseInt(arrParam[1]));
                                        } else {//날짜 타입 고려하지않았음
                                            //m[j].invoke(newObj, new String(arrParam[1].getBytes("8859_1"), "UTF-8"));
                                            m[j].invoke(newObj, arrParam[1]);
                                        }
                                    } else {
                                        m[j].invoke(newObj, null);
                                    }
                                    dataCnt++;
                                }
                            }
                        }
                    }

                    if (i == 0) { //첫번째 이름을 넣는다.
                        firstNm = arrParam[0];
                    }

                }
                if (dataCnt != 0) {
                    list.add(newObj);
                }
            }
        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return list;
    }

    /**
     * 파일명만 추출(확장자 제외)
     *
     * @param fileNm
     * @return
     * @throws Exception
     */
    public static String getFileNm(String fileNm) {
        if (fileNm.lastIndexOf(".") > 0) {
            return fileNm.substring(0, fileNm.indexOf("."));
        } else {
            return fileNm;
        }
    }

    /**
     * 파일에 대해 생성한 폴더 경로 조회
     *
     * @param seq
     * @param filePath
     * @return
     */
    public static String getFolderPath(int seq, String filePath) {
        String strSeq = String.valueOf(seq);
        String createfolderPath = "";

        if (strSeq.length() < 3) {        // 100이하 숫자는 폴더 1로 정의
            createfolderPath = File.separator + "1" + File.separator + strSeq;
        } else {
            //INF_ID의 SEQ가 기준이 되어 100번대로 폴더 분할
            //ex) 755 => 700폴더 생성 후 하위 755 폴더 생성(/700/755), 2232 => 2000폴더 생성 후 하위 2232 폴더 생성(/2000/2232)
            createfolderPath = File.separator + strSeq.substring(0, strSeq.length() - 2) + "00" + File.separator + strSeq;
        }
        return createfolderPath;
    }

    /**
     * 서비스별 폴더 조회
     *
     * @param downCd
     * @return
     */
    public static String getServiceFolder(String downCd) {
        String rtnVal = "";
        if (downCd.equals("S")) {        //서비스(파일)
            rtnVal = EgovProperties.getProperty("Globals.ServiceFilePath");
        } else if (downCd.equals("B")) {
            rtnVal = EgovProperties.getProperty("Globals.BbsFilePath");
        } else if (downCd.equals("P")) {
            rtnVal = EgovProperties.getProperty("Globals.PublishFilePath");
        } else if (downCd.equals("D")) {
            rtnVal = EgovProperties.getProperty("Globals.DataCombineFilePath");
        } else if (downCd.equals("C")) {
            rtnVal = EgovProperties.getProperty("Globals.OpenCateFilePath");
        } else if (downCd.equals("L")) {
            rtnVal = EgovProperties.getProperty("Globals.ServiceFilePath");
        } else if (downCd.equals("LT")) {    // 링크서비스 썸네일
            rtnVal = EgovProperties.getProperty("Globals.OpenlinkImg");
        } else if (downCd.equals("MT")) {
            rtnVal = EgovProperties.getProperty("Globals.MediaFilePath");
        } else if (downCd.equals("F")) {
            rtnVal = EgovProperties.getProperty("Globals.OpenfileImg");
        } else if (downCd.equals("H")) {
            rtnVal = EgovProperties.getProperty("Globals.MainMngImgFilePath");
        } else if (downCd.equals("DF")) {    // 문서관리 첨부파일
            rtnVal = EgovProperties.getProperty("Globals.docInfFilePath");
        } else if (downCd.equals("V")) {    // 시각화서비스
            rtnVal = EgovProperties.getProperty("Globals.MediaFilePath");
        } else if (downCd.equals("SH")) {    // 시트서비스 썸네일
            rtnVal = EgovProperties.getProperty("Globals.OpensheetImg");
        } else if (downCd.equals("UDF")) {    // 사용자정의 단일등록 파일경로
            rtnVal = EgovProperties.getProperty("Globals.openUsrDefFilePath");
        }

        return rtnVal;
    }

    /**
     * 실제 다운로드 폴더 추출
     *
     * @param downCd
     * @param seq
     * @return
     */
    public static String getDownloadFolder(String downCd, String seq) {
        String rootFolder = getServiceFolder(downCd);    //프로퍼티에 설정한 폴더

        String createFolder = "";    //seq로 생성한 폴더
        if (downCd.equals("F") || downCd.equals("SH") || StringUtils.equals(downCd, "LT")) {
            return rootFolder;
        } else if (downCd.equals("UDF")) {
            return rootFolder + seq;
        } else {
            createFolder = getFolderPath(Integer.parseInt(seq), rootFolder);    //seq로 생성한 폴더
            return rootFolder + createFolder;
        }

    }

    /**
     * 실제 다운로드 폴더 추출
     *
     * @param downCd
     * @param seq
     * @return
     */
    public static String getDownloadRootFolder(String downCd, String seq) {
        String rootFolder = getServiceFolder(downCd);    //프로퍼티에 설정한 폴더
        return rootFolder;

    }

    /**
     * 실제 다운로드 폴더 추출
     *
     * @param downCd
     * @param seq
     * @return
     */
    public static String getDownloadCreateFolder(String downCd, String seq) {
        String rootFolder = getServiceFolder(downCd);    //프로퍼티에 설정한 폴더
        String createFolder = getFolderPath(Integer.parseInt(seq), rootFolder);    //seq로 생성한 폴더
        return createFolder;

    }


    /**
     * 저장된 파일 형식을 가져온다.
     *
     * @param downType
     * @return
     */
    public static String getSaveExt(String downType) {
        if (downType.equals("E")) {
            return "excel";
        } else if (downType.equals("C")) {
            return "csv";
        } else if (downType.equals("X")) {
            return "xml";
        } else if (downType.equals("T")) {
            return "txt";
        } else {
            return "json";
        }
    }

    /**
     * DB에서 조회되는 사이즈를 구한다.
     *
     * @param data
     * @return long
     * @throws IOException
     */
    public static long getDataSize(List<LinkedHashMap<String, ?>> data) throws IOException {
        if (data == null) {
            return 0;
        }
        ByteArrayOutputStream bo = null;
        ObjectOutputStream oo = null;
        try {
            bo = new ByteArrayOutputStream();
            oo = new ObjectOutputStream(bo);
            oo.writeObject(data);
            oo.flush();
            return bo.size();
        } catch (IOException e) {
            return -1;
        } catch (Exception e) {
            return -1;
        } finally {
            bo.close();
            oo.close();
        }
    }

    /**
     * 사용자의 브라우저를 확인하여 코드를 반환한다.
     *
     * @param requset
     * @return
     */
    public static String getBrowser(HttpServletRequest requset) {
        String browser = "";
        String userAgent = requset.getHeader("User-Agent").toUpperCase();
        if (userAgent.indexOf("TRIDENT") > 0 || userAgent.indexOf("MSIE") > 0) {
            browser = "I";
        } else if (userAgent.indexOf("OPERA") > 0 || userAgent.lastIndexOf("OPR") > 0) {
            browser = "O";
        } else if (userAgent.indexOf("FIREFOX") > 0) {
            browser = "F";
        } else if (userAgent.indexOf("SAFARI") > 0) {
            if (userAgent.indexOf("CHROME") > 0) {
                browser = "C";
            } else {
                browser = "S";
            }
        } else {
            browser = "I";
        }
        return browser;
    }

    /**
     * 사용자의 브라우저를 확인하여 명칭을 반환한다.
     *
     * @param requset
     * @return
     */
    public static String getBrowserName(HttpServletRequest requset) {
        String browser = "";
        String userAgent = requset.getHeader("User-Agent").toUpperCase();
        if (userAgent.indexOf("TRIDENT") > 0 || userAgent.indexOf("MSIE") > 0) {
            browser = "Internet Explorer";
        } else if (userAgent.indexOf("OPERA") > 0 || userAgent.lastIndexOf("OPR") > 0) {
            browser = "Opera";
        } else if (userAgent.indexOf("FIREFOX") > 0) {
            browser = "Firefox";
        } else if (userAgent.indexOf("SAFARI") > 0) {
            if (userAgent.indexOf("CHROME") > 0) {
                browser = "Chrome";
            } else {
                browser = "Safari";
            }
        } else {
            browser = "Internet Explorer";
        }
        return browser;
    }

    /**
     * 세션에서 정보를 가져온다.(blank 처리)
     *
     * @param session
     * @param attrName
     * @return
     */
    public static String getSessionVal(HttpSession session, String attrName) {
        return session.getAttribute(attrName) != null ? (String) session.getAttribute(attrName) : "";
    }

    /**
     * GPIN 인증 세션을 초기화 한다.
     *
     * @param session
     */
    public static void clearGPINSessionVal(HttpSession session) {
        session.setAttribute("dupInfo", null);
        session.setAttribute("virtualNo", null);
        session.setAttribute("realName", null);
        session.setAttribute("sex", null);
        session.setAttribute("age", null);
        session.setAttribute("birthDate", null);
        session.setAttribute("nationalInfo", null);
        session.setAttribute("authInfo", null);
        session.setAttribute("GPIN_AQ_SERVICE_SITE_USER_CONFIRM", null);
    }

    public static String SQLInjectionFilter(String value) {
		/*if(UtilString.null2Blank(value).equals("")){ //공백, null경우 체크 안함
			return "";
		}
		Pattern evilChars = Pattern.compile("['\"\\-#()@;=*///+]");
		/*value = evilChars.matcher(value).replaceAll("");

		String valueLow  = value .toLowerCase();
		//탭 제거, 엔터제거
		//컬럼명, 테이블명에 해당 예약어가 있을수 있으므로 
		//예약어 + 공백
		valueLow = UtilString.replace(valueLow,"\t"," ");
		valueLow = UtilString.replace(valueLow,"\n"," ");
		
		if(valueLow.contains("union ") ||
			valueLow.contains("select ") ||
			valueLow.contains("insert ") ||
			valueLow.contains("drop ") ||
			valueLow.contains("update ") ||
			valueLow.contains("delete ") ||
			valueLow.contains("join ") ||
			valueLow.contains("from ") ||
			valueLow.contains("where ") ||
			valueLow.contains("substr ") ||
			valueLow.contains("user_tables ") ||
			valueLow.contains("user_tab_columns ")
		){
			value = valueLow ;
			value = value.replaceAll("union ","q-union "); 
			value = value.replaceAll("select ","q-select "); 
			value = value.replaceAll("insert ","q-insert "); 
			value = value.replaceAll("drop ","q-drop "); 
			value = value.replaceAll("update ","q-update "); 
			value = value.replaceAll("delete ","q-delete "); 
			value = value.replaceAll("join ","q-join "); 
			value = value.replaceAll("from ","q-from "); 
			value = value.replaceAll("where ","q-where "); 
			value = value.replaceAll("substr ","q-substr "); 
			value = value.replaceAll("user_tables ","user_tables "); 
			value = value.replaceAll("user_tab_columns ","q-user_tab_columns "); 
			
		}*/
        return value;
    }

    public static String SQLInjectionFilter2(String value) {
        if (UtilString.null2Blank(value).equals("")) { //공백, null경우 체크 안함
            return "";
        }
        Pattern evilChars = Pattern.compile("[\"\\-#()@;*///+]");
        //Pattern evilChars = Pattern.compile("['\"\\-#()@;=*///+]");
        value = evilChars.matcher(value).replaceAll("");

        String valueLow = value.toLowerCase();
        //탭 제거, 엔터제거
        //컬럼명, 테이블명에 해당 예약어가 있을수 있으므로
        //예약어 + 공백
        valueLow = UtilString.replace(valueLow, "\t", " ");
        valueLow = UtilString.replace(valueLow, "\n", " ");

        if (valueLow.contains("union ") ||
                valueLow.contains("select ") ||
                valueLow.contains("insert ") ||
                valueLow.contains("drop ") ||
                valueLow.contains("update ") ||
                valueLow.contains("delete ") ||
                valueLow.contains("join ") ||
                valueLow.contains("from ") ||
                valueLow.contains("where ") ||
                valueLow.contains("substr ") ||
                valueLow.contains("user_tables ") ||
                valueLow.contains("user_tab_columns ")
        ) {
            value = valueLow;
            value = value.replaceAll("union ", "q-union ");
            value = value.replaceAll("select ", "q-select ");
            value = value.replaceAll("insert ", "q-insert ");
            value = value.replaceAll("drop ", "q-drop ");
            value = value.replaceAll("update ", "q-update ");
            value = value.replaceAll("delete ", "q-delete ");
            value = value.replaceAll("join ", "q-join ");
            value = value.replaceAll("from ", "q-from ");
            value = value.replaceAll("where ", "q-where ");
            value = value.replaceAll("substr ", "q-substr ");
            value = value.replaceAll("user_tables ", "user_tables ");
            value = value.replaceAll("user_tab_columns ", "q-user_tab_columns ");

        }
        return value;
    }

    public static String xssRepalce(String value) {
        String value2 = value;
        value2 = UtilString.replace(value2, "<\t", "&lt;\t");
        value2 = UtilString.replace(value2, "<\n", "&lt;\n");
        value2 = UtilString.replace(value2, "<\r", "&lt;\r");
        value2 = UtilString.replace(value2, "< ", "&lt; ");
        if (value2.toLowerCase().indexOf("<script") > -1) {
            value2 = value2.replaceAll("(?i)<script", "&lt;script");
        }
        if (value2.toLowerCase().indexOf("<a") > -1) {
            value2 = value2.replaceAll("(?i)<a", "&lt;a");
        }
        if (value2.toLowerCase().indexOf("<img") > -1) {
            value2 = value2.replaceAll("(?i)<img", "&lt;img");
        }
        if (value2.toLowerCase().indexOf("script>") > -1) {
            value2 = value2.replaceAll("(?i)script>", "script&gt;");
        }
        if (value2.toLowerCase().indexOf("<iframe") > -1) {
            value2 = value2.replaceAll("(?i)<iframe", "&lt;iframe");
        }
        if (value2.toLowerCase().indexOf("<object") > -1) {
            value2 = value2.replaceAll("(?i)<object", "&lt;object");
        }
        if (value2.toLowerCase().indexOf("<embed") > -1) {
            value2 = value2.replaceAll("(?i)<embed", "&lt;embed");
        }
        if (value2.toLowerCase().indexOf("onload") > -1) {
            value2 = value2.replaceAll("(?i)onload", "no_onload");
        }
        if (value2.toLowerCase().indexOf("expressin") > -1) {
            value2 = value2.replaceAll("(?i)expressin", "no_expressin");
        }
        if (value2.toLowerCase().indexOf("onmouseover") > -1) {
            value2 = value2.replaceAll("(?i)onmouseover", "no_onmouseover");
        }
        if (value2.toLowerCase().indexOf("onmouseout") > -1) {
            value2 = value2.replaceAll("(?i)onmouseout", "no_onmouseout");
        }
        if (value2.toLowerCase().indexOf("onclick") > -1) {
            value2 = value2.replaceAll("(?i)onclick", "no_onclick");
        }
        if (value2.toLowerCase().indexOf("onchange") > -1) {
            value2 = value2.replaceAll("(?i)onchange", "no_onchange");
        }
        if (value2.toLowerCase().indexOf("onerror") > -1) {
            value2 = value2.replaceAll("(?i)onerror", "no_onerror");
        }

        if (value2.toLowerCase().indexOf("document.cookie") > -1) {
            value2 = value2.replaceAll("(?i)document.cookie", "");
        }
        value2 = value2.replaceAll("eval\\((.*)\\)", "");
        value2 = value2.replaceAll("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']", "\"\"");
        return value2;
    }
}

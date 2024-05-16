package egovframework.common.file.service.impl;

import java.util.Vector;

public class CStringUtil {
    public static String null2Blank(Object obj) {
        if (obj == null) {
            return "";
        } else {
            return (String) obj;
        }
    }

    public static String null2Sing(Object obj) {
        if (obj == null) {
            return "''";
        } else {
            return (String) obj;
        }
    }

    public static String[] getSplitArray(String strString, String strDelimeter) {
        return (String[]) (getSplitVector(strString, strDelimeter).toArray(new String[0]));
    }

    public static Vector<String> getSplitVector(String strString, String strDelimeter) {
        Vector<String> vResult = new Vector<String>();
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
        } catch (IndexOutOfBoundsException e) {
            return null;
        } catch (Exception e) {
            return null;
        }
        return vResult;
    }
}

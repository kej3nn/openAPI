/*
 * @(#)Record.java 1.0 2015/06/01
 *
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.common.base.model;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.Clob;
import java.sql.SQLException;

/**
 * 레코드 모델 클래스이다.
 *
 * @author 김은삼
 * @version 1.0 2015/06/01
 */
public class Record extends BaseModel {
    /**
     * 시리얼 버전 아이디
     */
    private static final long serialVersionUID = 1L;

    /**
     * 디폴트 생성자이다.
     */
    public Record() {
        super();
    }

    /**
     * 바이트 배열을 처리한다.
     *
     * @param byteArray 바이트 배열
     * @return 문자열
     */
    private String handleByteArray(byte[] byteArray) {
        try {
            return new String(byteArray, "UTF-8");
        } catch (UnsupportedEncodingException uee) {
            error("Detected exception: ", uee);

            throw new RuntimeException(uee);
        }
    }

    /**
     * 캐릭터 배열을 처리한다.
     *
     * @param charArray 바이트 배열
     * @return 문자열
     */
    private String handleCharArray(char[] charArray) {
        return new String(charArray);
    }

    /**
     * CLOB을 처리한다.
     *
     * @param clob CLOB
     * @return 문자열
     */
    private String handleClob(Clob clob) {
        BufferedReader reader = null;

        try {
            reader = new BufferedReader(clob.getCharacterStream());

            StringBuffer buffer = new StringBuffer();

            while (true) {
                String line = reader.readLine();

                if (line == null) {
                    break;
                }

                if (buffer.length() > 0) {
                    buffer.append(System.getProperty("line.separator"));
                }

                buffer.append(line);
            }

            return buffer.toString();
        } catch (SQLException sqle) {
            error("Detected exception: ", sqle);

            throw new RuntimeException(sqle);
        } catch (IOException ioe) {
            error("Detected exception: ", ioe);

            throw new RuntimeException(ioe);
        } finally {
            if (reader != null) {
                try {
                    reader.close();
                } catch (IOException ioe) {
                    warn("Detected exception: ", ioe);
                }
            }
        }
    }

    /*
     * (non-Javadoc)
     * @see java.util.HashMap#put(java.lang.Object, java.lang.Object)
     */
    public Object put(Object key, Object value) {
        if (value instanceof byte[]) {
            return super.put(key, handleByteArray((byte[]) value));
        }
        if (value instanceof char[]) {
            return super.put(key, handleCharArray((char[]) value));
        }
        if (value instanceof Clob) {
            return super.put(key, handleClob((Clob) value));
        }

        return super.put(key, value);
    }
}
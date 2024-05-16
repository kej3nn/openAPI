package egovframework.common.util;

import java.io.UnsupportedEncodingException;

import org.apache.xmlbeans.impl.util.Base64;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.crypto.KISA_SEED_ECB;

/**
 * KISA SEED 양방향 암호화 유틸 클래스
 *
 * @author jhkim
 * @version 1.0
 * @since 2019.12.02
 */
public class UtilSeedEncryption {

    public static String SEED_CHARSET = "utf-8";

    /**
     * KISA 암호화 알고리즘을 이용한 암호화
     *
     * @param key 키값
     * @param str 암호화 텍스트
     */
    public static byte[] seedEncrypt(String key, String str) {

        byte[] enc = null;
        try {
            //암호화 함수 호출
            enc = KISA_SEED_ECB.SEED_ECB_Encrypt(key.getBytes(SEED_CHARSET), str.getBytes(SEED_CHARSET), 0, str.getBytes(SEED_CHARSET).length);
        } catch (UnsupportedEncodingException e) {
            //e.printStackTrace();
            EgovWebUtil.exLogging(e);
        }

        /**JDK1.8 일 때 사용
         Encoder encoder = Base64.getEncoder();
         byte[] encArray = encoder.encode(enc);
         */
        byte[] encArray = Base64.encode(enc);

        return encArray;
    }

    /**
     * KISA 암호화 알고리즘을 이용한 복호화
     *
     * @param key 키값
     * @param str 암호화 텍스트
     */
    public static String seedDecrypt(String key, byte[] str) {

        /**JDK1.8 일 때 사용
         Decoder decoder = Base64.getDecoder();
         byte[] enc = decoder.decode(str);
         */
        byte[] enc = Base64.decode(str);

        String result = "";
        byte[] dec = null;

        try {
            //복호화 함수 호출
            dec = KISA_SEED_ECB.SEED_ECB_Decrypt(key.getBytes(SEED_CHARSET), enc, 0, enc.length);
            result = new String(dec, SEED_CHARSET);

        } catch (UnsupportedEncodingException e) {
            //e.printStackTrace();
            EgovWebUtil.exLogging(e);
        }

        return result;
    }
}

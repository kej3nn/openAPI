package egovframework.common.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;


import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.exception.ServiceException;

public class UtilEncryption {

    public static String SEED_CHARSET = "utf-8";

    // 단방향 암호화
    public String encryptSha256(String planText, byte[] salt) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.reset();
            md.update(salt);
            byte byteData[] = md.digest(planText.getBytes("UTF-8"));

            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < byteData.length; i++) {
                sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
            }

            StringBuffer hexString = new StringBuffer();
            for (int i = 0; i < byteData.length; i++) {
                String hex = Integer.toHexString(0xff & byteData[i]);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }

            return hexString.toString();
        } catch (ServiceException sve) {
            EgovWebUtil.exLogging(sve);
            throw new RuntimeException();
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
            throw new RuntimeException();
        }
    }

    public String encSHA256(String str) {
        String SHA = "";
        try {
            MessageDigest sh = MessageDigest.getInstance("SHA-256");
            sh.update(str.getBytes());
            byte byteData[] = sh.digest();
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < byteData.length; i++) {
                sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
            }
            SHA = sb.toString();

        } catch (NoSuchAlgorithmException e) {
            EgovWebUtil.exLogging(e);
            SHA = null;
        }
        return SHA;
    }
    
    /*
    private String iv;
    private Key keySpec;
    private static String KEY_VALUE = null;
    */
    /**
     * 16자리의 키값을 입력하여 객체를 생성한다.
     * @throws UnsupportedEncodingException 키값의 길이가 16이하일 경우 발생
     */
    /*
    public UtilEncryption() throws UnsupportedEncodingException {
    	KEY_VALUE = EgovProperties.getProperty("Globals.encryptionkey");
        this.iv = KEY_VALUE.substring(0, 16);
        byte[] keyBytes = new byte[16];
        byte[] b = KEY_VALUE.getBytes("UTF-8");
        int len = b.length;
        if(len > keyBytes.length){
            len = keyBytes.length;
        }
        System.arraycopy(b, 0, keyBytes, 0, len);
        SecretKeySpec keySpec = new SecretKeySpec(keyBytes, "AES");

        this.keySpec = keySpec;
    }*/

    /**
     * AES256 으로 암호화 한다.
     * @param str 암호화할 문자열
     * @return
     * @throws NoSuchAlgorithmException
     * @throws GeneralSecurityException
     * @throws UnsupportedEncodingException
     */
    /*
    public String encrypt(String str) throws NoSuchAlgorithmException, GeneralSecurityException, UnsupportedEncodingException{
        Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
        c.init(Cipher.ENCRYPT_MODE, keySpec, new IvParameterSpec(iv.getBytes()));
        byte[] encrypted = c.doFinal(str.getBytes("UTF-8"));
        String enStr = new String(Base64.encodeBase64(encrypted));
        return enStr;
    }*/

    /**
     * AES256으로 암호화된 txt 를 복호화한다.
     * @param str 복호화할 문자열
     * @return
     * @throws NoSuchAlgorithmException
     * @throws GeneralSecurityException
     * @throws UnsupportedEncodingException
     */
    /*
    public String decrypt(String str) throws NoSuchAlgorithmException, GeneralSecurityException, UnsupportedEncodingException {
    	if(str == null) {
    		return null;
    	}
        Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
        c.init(Cipher.DECRYPT_MODE, keySpec, new IvParameterSpec(iv.getBytes()));
        byte[] byteStr = Base64.decodeBase64(str.getBytes());
        return new String(c.doFinal(byteStr), "UTF-8");
    }*/
}

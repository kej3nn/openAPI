package egovframework.common.util;


import com.sun.crypto.provider.SunJCE;

import java.io.IOException;
import java.security.*;
import javax.crypto.*;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import egovframework.com.cmm.EgovWebUtil;

public class HashEncrypt {

    public HashEncrypt() {
    }

    public static byte[] makeHashByte(String inputString) {
        byte result[] = (byte[]) null;
        try {
            byte inputByteArray[] = encode(inputString);
            MessageDigest md5 = MessageDigest.getInstance("MD5");
            md5.update(inputByteArray);
            result = md5.digest();
        } catch (NoSuchAlgorithmException nae) {
            EgovWebUtil.exLogging(nae);
        } catch (Exception e) {
            //System.err.println(e.getMessage());
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    public static String makeHashString(String inputString) {
        String result = null;
        try {
            byte hashbyte[] = makeHashByte(inputString);
            result = encode64(hashbyte);
        } catch (IOException ioe) {
            EgovWebUtil.exLogging(ioe);
        } catch (Exception e) {
            //System.err.println(e.getMessage());
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    public static String encrypt(byte key[], String value) {
        String result = null;
        try {
            Security.addProvider(new SunJCE());
            byte cryptokey[] = new byte[8];
            System.arraycopy(key, 0, cryptokey, 0, 8);
            SecretKeySpec keyspec = new SecretKeySpec(cryptokey, "DES");
            javax.crypto.SecretKey secretKey = keyspec;
            IvParameterSpec ivSpec = new IvParameterSpec(cryptokey);
            Cipher cipher = Cipher.getInstance("DES/CBC/PKCS5Padding");
            cipher.init(1, secretKey, ivSpec);
            byte enc[] = cipher.doFinal(encode(value));
            result = encode64(enc);
        } catch (InvalidKeyException e) {
            //System.err.println(e.getMessage());
            EgovWebUtil.exLogging(e);
        } catch (NoSuchAlgorithmException e) {
            //System.err.println(e.getMessage());
            EgovWebUtil.exLogging(e);
        } catch (NoSuchPaddingException e) {
            //System.err.println(e.getMessage());
            EgovWebUtil.exLogging(e);
        } catch (InvalidAlgorithmParameterException e) {
            //System.err.println(e.getMessage());
            EgovWebUtil.exLogging(e);
        } catch (IllegalStateException e) {
            //System.err.println(e.getMessage());
            EgovWebUtil.exLogging(e);
        } catch (IllegalBlockSizeException e) {
            //System.err.println(e.getMessage());
            EgovWebUtil.exLogging(e);
        } catch (BadPaddingException e) {
            //System.err.println(e.getMessage());
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            //System.err.println(e.getMessage());
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    public static String decrypt(byte key[], String value) {
        byte input[] = (byte[]) null;
        String result = "";
        try {
            input = decode64(value);
            Security.addProvider(new SunJCE());
            byte cryptokey[] = new byte[8];
            System.arraycopy(key, 0, cryptokey, 0, 8);
            SecretKeySpec keyspec = new SecretKeySpec(cryptokey, "DES");
            javax.crypto.SecretKey secretKey = keyspec;
            IvParameterSpec ivSpec = new IvParameterSpec(cryptokey);
            Cipher cipher = Cipher.getInstance("DES/CBC/PKCS5Padding");
            cipher.init(2, secretKey, ivSpec);
            byte enc[] = cipher.doFinal(input);
            result = new String(enc);
        } catch (InvalidKeyException e) {
            //System.err.println(e.getMessage());
            EgovWebUtil.exLogging(e);
        } catch (NoSuchAlgorithmException e) {
            //System.err.println(e.getMessage());
            EgovWebUtil.exLogging(e);
        } catch (NoSuchPaddingException e) {
            //System.err.println(e.getMessage());
            EgovWebUtil.exLogging(e);
        } catch (InvalidAlgorithmParameterException e) {
            //System.err.println(e.getMessage());
            EgovWebUtil.exLogging(e);
        } catch (IllegalStateException e) {
            //System.err.println(e.getMessage());
            EgovWebUtil.exLogging(e);
        } catch (IllegalBlockSizeException e) {
            //System.err.println(e.getMessage());
            EgovWebUtil.exLogging(e);
        } catch (BadPaddingException e) {
            //System.err.println(e.getMessage());
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            //System.err.println(e.getMessage());
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    public static byte[] encode(String inputString) throws IOException {
        byte result[] = (byte[]) null;
        result = inputString.getBytes();

        return result;
    }

    public static String encode64(byte inputByteArray[])
            throws IOException {
        String result = null;
        result = (new BASE64Encoder()).encode(inputByteArray);
        return result;
    }

    public static byte[] decode64(String inputString)
            throws IOException {
        byte result[] = (byte[]) null;
        result = (new BASE64Decoder()).decodeBuffer(inputString);
        return result;
    }


    public static String PassEncode(String src) {

        //암호화하기 위해 sun.misc.BASE64Encoder 를 사용한다

        sun.misc.BASE64Encoder b64e = new sun.misc.BASE64Encoder();
        java.security.MessageDigest md;
        String md5Passwd = "";

        try {

            md = java.security.MessageDigest.getInstance("MD5");
            md.update(src.getBytes());
            byte[] raw = md.digest();

            md5Passwd = b64e.encode(raw);

            return md5Passwd;

        } catch (java.security.NoSuchAlgorithmException e) {

            //e.printStackTrace();
            EgovWebUtil.exLogging(e);
        }

        return md5Passwd;

    }
}

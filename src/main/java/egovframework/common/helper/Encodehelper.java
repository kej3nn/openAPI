
package egovframework.common.helper;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.RSAPublicKeySpec;

import javax.crypto.Cipher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.ui.ModelMap;

import egovframework.admin.basicinf.service.CommUsr;
import egovframework.common.WiseOpenConfig;
import egovframework.common.util.UtilString;

public class Encodehelper {
    // 2015.09.05 김은삼 [1] 신익진 주임이 코딩한 한글파일 다운로드 인코딩 메소드 추가 BEGIN

    /**
     * 브라우저 종류
     *
     * @param request
     * @return
     */
    public static String getBrowser(HttpServletRequest request) {
        String header = request.getHeader("User-Agent");
        if (header.indexOf("MSIE") > -1 || header.indexOf("Trident") > -1) {
            return "MSIE";
        } else if (header.indexOf("Chrome") > -1) {
            return "Chrome";
        } else if (header.indexOf("Safari") > -1) {
            return "Safari";
        } else if (header.indexOf("Opera") > -1) {
            return "Opera";
        }
        return "Firefox";
    }

    /**
     * 다국어 파일명 처리
     *
     * @param filename
     * @param browser
     * @return
     * @throws UnsupportedEncodingException
     */
    public static String getDisposition(String filename, String browser) throws UnsupportedEncodingException {
        String dispositionPrefix = "attachment;filename=";
        String encodedFilename = null;
        if (browser.equals("MSIE")) {
            encodedFilename = URLEncoder.encode(filename, "utf-8").replace("+", "%20").replaceAll("\\+", "%20");
        } else if (browser.equals("Firefox")) {
            StringBuffer sb = new StringBuffer();
            sb.append('"');
            for (int i = 0; i < filename.length(); i++) {
                char c = filename.charAt(i);
                sb.append(c);
            }
            sb.append('"');
            encodedFilename = sb.toString();
        } else if (browser.equals("Opera")) {
            encodedFilename = "" + new String(filename.getBytes("UTF-8"), "8859_1") + "";
        } else if (browser.equals("Chrome")) {
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < filename.length(); i++) {
                char c = filename.charAt(i);
                if (c > '~') {
                    sb.append(URLEncoder.encode("" + c, "UTF-8"));
                } else {
                    sb.append(c);
                }
            }
            encodedFilename = sb.toString();
        } else if (browser.equals("Safari")) {
            encodedFilename = "" + new String(filename.getBytes("UTF-8"), "8859_1") + "";
        } else {
            throw new RuntimeException("Not supported browser");
        }

        return dispositionPrefix + "\"" + encodedFilename + "\"";
    }

    /**
     * 다국어 파일명 처리(접근성 처리)
     *
     * @param request
     * @param browser
     * @return
     * @throws UnsupportedEncodingException
     */
    public static String getDispositionCompatibility(HttpServletRequest request, String fileName) throws UnsupportedEncodingException {

        String userAgent = request.getHeader("User-Agent");
        StringBuffer fileParameter = new StringBuffer("attachment; ");

        // < MSIE 10
        if (userAgent.contains("MSIE") || userAgent.contains("Trident")) {
            fileParameter.append("filename=")
                    .append("\"")
                    .append(URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "\\ "))
                    .append("\"");
        }
        // 나머지
        else {
            fileParameter.append("filename*=")
                    .append("UTF-8")
                    .append("''")
                    .append(URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20"));
        }

        return fileParameter.toString();
    }


    // 2015.09.05 김은삼 [1] 신익진 주임이 코딩한 한글파일 다운로드 인코딩 메소드 추가 END

    /**
     * 공개키 개인키를 생성한다. 시큐어 코딩에 잡혀서 쓰지 않는 소스라 주석처리함
     * @param request
     * @param model
     * @throws Exception
     */
//		public void getKey(HttpServletRequest request,ModelMap model)throws Exception{
//			KeyPairGenerator generator = KeyPairGenerator.getInstance("RSA");
//			generator.initialize(1024);
//
//			KeyPair keyPair = generator.genKeyPair();
//			KeyFactory keyFactory = KeyFactory.getInstance("RSA");
//
//			PublicKey publicKey = keyPair.getPublic();
//			PrivateKey privateKey = keyPair.getPrivate();           
//
//			HttpSession session = request.getSession();
//			// 세션에 공개키의 문자열을 키로하여 개인키를 저장한다.
//			session.setAttribute(WiseOpenConfig.LOG_KEY, privateKey);
//			
//			// 공개키를 문자열로 변환하여 JavaScript RSA 라이브러리 넘겨준다.
//			RSAPublicKeySpec publicSpec = (RSAPublicKeySpec) keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);
//
//			String publicKeyModulus = publicSpec.getModulus().toString(16);
//			String publicKeyExponent = publicSpec.getPublicExponent().toString(16);
//			model.addAttribute("publicKeyModulus", publicKeyModulus);
//			model.addAttribute("publicKeyExponent", publicKeyExponent);
//		}

    /* 시큐어 코딩에 잡혀서 쓰지 않는 소스라 주석처리함
     *//**
     *암호화된 비밀번호를 복호화 한다.
     * @param request
     * @param commUsr
     * @throws Exception
     *//*
	    public void processRequest(HttpServletRequest request,CommUsr commUsr)throws Exception{
	        String securedUsername = commUsr.getUsrId();
	        String securedPassword = commUsr.getUsrPw();

	        HttpSession session = request.getSession();
	        PrivateKey privateKey = (PrivateKey) session.getAttribute(WiseOpenConfig.LOG_KEY);
	        session.removeAttribute(WiseOpenConfig.LOG_KEY); // 키의 재사용을 막는다. 항상 새로운 키를 받도록 강제.
                        
	        if (privateKey == null) {
	            throw new RuntimeException("암호화 비밀키 정보를 찾을 수 없습니다.");
	        }
	        commUsr.setUsrId(decryptRsa(privateKey, securedUsername));
	        commUsr.setUsrPw(decryptRsa(privateKey, securedPassword));
	    }               

	    private String decryptRsa(PrivateKey privateKey, String securedValue) {
	    	
	        
	        //Cipher cipher = Cipher.getInstance("RSA/ECB/NoPadding");
	    	//Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");
	    	//Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");
	    	Cipher cipher = Cipher.getInstance("RSA");
	        byte[] encryptedBytes = hexToByteArray(securedValue);
	        cipher.init(Cipher.DECRYPT_MODE, privateKey);
	        byte[] decryptedBytes = cipher.doFinal(encryptedBytes);               
	        String decryptedValue = new String(decryptedBytes, "utf-8"); // 문자 인코딩 주의.
	        return UtilString.deleteChar(decryptedValue, ' ');
	    }                     
*/

    /**
     * 암호회된 비밀번호를 복원화 한다.
     *
     * @param hex
     * @return
     */
    public static byte[] hexToByteArray(String hex) {
        if (hex == null || hex.length() % 2 != 0) {
            return new byte[]{};
        }

        byte[] bytes = new byte[hex.length() / 2];
        for (int i = 0; i < hex.length(); i += 2) {
            byte value = (byte) Integer.parseInt(hex.substring(i, i + 2), 16);
            bytes[(int) Math.floor(i / 2)] = value;
        }
        return bytes;
    }

}

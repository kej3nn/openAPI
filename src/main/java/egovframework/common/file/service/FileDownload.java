package egovframework.common.file.service;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.dao.DataAccessException;
import org.springframework.web.servlet.view.AbstractView;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.util.UtilString;

public class FileDownload extends AbstractView {

    @Override
    protected void renderMergedOutputModel(Map<String, Object> map,
                                           HttpServletRequest req, HttpServletResponse res) {

        String fileName = (String) map.get("fileName");        //사용자에게 보여질 저장파일명
        File file = (File) map.get("file");
        boolean bEncode = (Boolean) map.get("bEncode") == null ? true : false;
        res.setContentType("application/download;");
        int length = (int) file.length();
        res.setContentLength(length);

        String userAgent = req.getHeader("User-Agent").toUpperCase();
        boolean ie = userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("TRIDENT") > -1;

        String browser = getBrowser(req);

        //브라우저 체크   --------- 기존 기재부 (로컬용)
//		if ( true ) {
//			if ( ie ) {
//				fileName = URLEncoder.encode(fileName, "utf-8").replace("+", "%20").replaceAll("\\+", "%20");
//			} else {
//				fileName = new String(fileName.getBytes("utf-8"), "iso-8859-1").replace("+", "%20").replaceAll("\\+", "%20");
//			}
//		}


        res.setHeader("Content-Type", "application/octet-stream; charset=utf-8");
//		res.setHeader("Content-Disposition", "attachment;" + "filename=\"" + fileName + "\";");
        try {
            res.setHeader("Content-Disposition", getDisposition(fileName, browser));

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        res.setHeader("Content-Transfer-Encoding", "binary;");
        res.setHeader("pragma", "no-cache;");
        FileInputStream fis = null;
        BufferedInputStream fin = null;
        BufferedOutputStream outs = null;
        try {
		/*	int temp;
			fis = new FileInputStream(file);
			while ( (temp = fis.read()) != -1 ) {
				out.write(temp);
			}*/
            byte[] buffer = new byte[1024];
            fis = new FileInputStream(file);
            fin = new BufferedInputStream(fis);
            outs = new BufferedOutputStream(res.getOutputStream());
            int read = 0;
            while ((read = fin.read(buffer)) != -1) {
                outs.write(buffer, 0, read);
            }
        } catch (FileNotFoundException fne) {
            EgovWebUtil.exLogging(fne);
            handleErrorMessage(res, "파일을 찾을 수 없습니다.");
        } catch (IOException ioe) {
            EgovWebUtil.exLogging(ioe);
            handleErrorMessage(res, "파일을 다운로드 할 수 없습니다.");
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
            handleErrorMessage(res, "파일을 다운로드 할 수 없습니다.");
        } finally {
            try {
                if (fis != null) {
                    fis.close();
                }
            } catch (IOException ioe) {
                EgovWebUtil.exLogging(ioe);
            }

            try {
                if (fin != null) {
                    fin.close();
                }
            } catch (IOException ioe) {
                EgovWebUtil.exLogging(ioe);
            }
            try {
                if (outs != null) {
                    outs.close();
                }
            } catch (IOException ioe) {
                EgovWebUtil.exLogging(ioe);
            }
        }
    }

    /*----------------- 경기도청 서버용 인코딩 -------------------------*/

    /**
     * 브라우저 종류
     *
     * @param request
     * @return
     */
    public String getBrowser(HttpServletRequest request) {
        String header = request.getHeader("User-Agent");
        if (header.indexOf("MSIE") > -1 || header.indexOf("TRIDENT") > -1) {
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
    public String getDisposition(String filename, String browser) throws UnsupportedEncodingException {
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
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < filename.length(); i++) {
                char c = filename.charAt(i);
                sb.append(c);
            }
            encodedFilename = sb.toString();
        } else {
            throw new RuntimeException("Not supported browser");
        }
        return dispositionPrefix + encodedFilename;
    }

    /*----------------- 경기도청 서버용 인코딩 -------------------------*/

    protected void handleErrorMessage(HttpServletResponse response, String message) {
        try {
            // setContentType("text/html; charset=UTF-8");

            response.reset();

            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);
            // response.setContentType(getContentType());
            response.setContentType("text/html; charset=UTF-8");

            PrintWriter writer = response.getWriter();

            writer.println("<script type=\"text/javascript\">");
            writer.println("(function() {");
            writer.println("    alert(\"" + message + "\");");
            writer.println("})();");
            writer.println("</script>");
        } catch (IOException ioe) {
            EgovWebUtil.exLogging(ioe);
        }
    }
}

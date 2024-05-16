/*
 * @(#)FileDownloadView.java 1.0 2015/06/01
 *
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.common.base.view;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;

import egovframework.common.base.constants.ModelAttribute;
import egovframework.common.base.model.Record;

/**
 * 파일 다운로드 뷰 클래스이다.
 *
 * @author 김은삼
 * @version 1.0 2015/06/01
 */
public class FileDownloadView extends BaseView {
    /**
     * 파일 경로
     */
    public static final String FILE_PATH = "filePath";

    /**
     * 파일 이름
     */
    public static final String FILE_NAME = "fileName";

    /**
     * 파일 크기
     */
    public static final String FILE_SIZE = "fileSize";

    /**
     * 디폴트 생성자이다.
     */
    public FileDownloadView() {
        super();
    }

    /**
     * 파일 경로를 반환한다.
     *
     * @param model 모델
     * @return 파일 경로
     */
    private String getFilePath(Map<String, Object> model) {
        Record data = (Record) model.get(ModelAttribute.DATA);

        String path = data.getString(FILE_PATH);

        return path.replaceAll("\\\\", "/");
    }

    /**
     * 파일 이름을 반환한다.
     *
     * @param request HTTP 요청
     * @param model   모델
     * @return 파일 이름
     */
    private String getFileName(HttpServletRequest request, Map<String, Object> model) {
        Record data = (Record) model.get(ModelAttribute.DATA);

        String name = data.getString(FILE_NAME);

        String userAgent = request.getHeader("User-Agent");
        StringBuffer fileParameter = new StringBuffer("attachment; ");

        try {
            // < MSIE 10
            if (userAgent.contains("MSIE") || userAgent.contains("Trident")) {
                fileParameter.append("filename=")
                        .append("\"")
                        .append(URLEncoder.encode(name, "UTF-8").replaceAll("\\+", "\\ "))
                        .append("\"");
            }
            // 나머지
            else {
                fileParameter.append("filename*=")
                        .append("UTF-8")
                        .append("''")
                        .append(URLEncoder.encode(name, "UTF-8").replaceAll("\\+", "%20"));
            }

            return fileParameter.toString();
        } catch (UnsupportedEncodingException uee) {
            return name;
        }


        // try {
        //     if (UtilString.getBrowser(request).equals("I")) {
        //         name = URLEncoder.encode(name, "UTF-8").replaceAll("\\+", "%20");
        //     }
        //     else {
        //         name = new String(name.getBytes("UTF-8"), "ISO-8859-1");
        //     }
        //     
        //     return name;
        // }
        // catch (UnsupportedEncodingException uee) {
        //     warn("Detected exception: ", uee);
        //     
        //     return name;
        // }
//        return name;
    }

    /**
     * 파일 크기를 반환한다.
     *
     * @param model 모델
     * @return 파일 크기
     */
    private int getFileSize(Map<String, Object> model) {
        Record data = (Record) model.get(ModelAttribute.DATA);

        int size = data.getInt(FILE_SIZE);

        return size;
    }

    /**
     * 오류 메시지를 처리한다.
     *
     * @param response HTTP 응답
     * @param message  메시지
     */
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
            warn("Detected exception: ", ioe);
        }
    }

    /*
     * (non-Javadoc)
     * @see org.springframework.web.servlet.view.AbstractView#renderMergedOutputModel(java.util.Map, javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
     */
    @SuppressWarnings("deprecation")
    protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) {
        InputStream is = null;

        try {

            is = new FileInputStream(getFilePath(model));

            response.setContentType("application/octet-stream; charset=UTF-8");
            response.setContentLength(getFileSize(model));
            response.setHeader("Content-Transfer-Encoding", "binary");

            String filename = getFileName(request, model);
            response.setHeader("Content-Disposition", filename);

            OutputStream os = response.getOutputStream();

            FileCopyUtils.copy(is, os);
        } catch (FileNotFoundException fnfe) {
            error("Detected exception: ", fnfe);

            handleErrorMessage(response, getMessage("portal.error.000027"));
        } catch (IOException ioe) {
            error("Detected exception: ", ioe);

            handleErrorMessage(response, getMessage("portal.error.000028"));
        } finally {
            if (is != null) {
                try {
                    is.close();
                } catch (IOException ioe) {
                    warn("Detected exception: ", ioe);
                }
            }
        }
    }

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

}
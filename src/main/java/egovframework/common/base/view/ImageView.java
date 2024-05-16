/*
 * @(#)ImageView.java 1.0 2015/06/01
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
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;

import egovframework.common.base.constants.ModelAttribute;
import egovframework.common.base.model.Record;
import egovframework.common.helper.Encodehelper;

/**
 * 이미지 뷰 클래스이다.
 *
 * @author 김은삼
 * @version 1.0 2015/06/01
 */
public class ImageView extends BaseView {
    /**
     * 파일 경로
     */
    public static final String FILE_PATH = "filePath";

    /**
     * 파일 이름
     */
    public static final String FILE_NAME = "fileName";

    /**
     * 디폴트 생성자이다.
     */
    public ImageView() {
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

        return path.replaceAll("\\\\", "/").replaceAll("\\.\\.", "");
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
        return name;
    }

    /**
     * MIME 유형을 반환한다.
     *
     * @param model 모델
     * @return MIME 유형
     */
    private String getMimeType(Map<String, Object> model) {
        Record data = (Record) model.get(ModelAttribute.DATA);

        String name = data.getString(FILE_NAME).toLowerCase();

        if (name.endsWith(".gif")) {
            return "image/gif; charset=UTF-8";
        } else if (name.endsWith(".ief")) {
            return "image/ief; charset=UTF-8";
        } else if (name.endsWith(".jpe") || name.endsWith(".jpeg") || name.endsWith(".jpg")) {
            return "image/jpeg; charset=UTF-8";
        } else if (name.endsWith(".png")) {
            return "image/png; charset=UTF-8";
        } else if (name.endsWith(".tif") || name.endsWith(".tiff")) {
            return "image/tiff; charset=UTF-8";
        } else {
            return "application/octet-stream; charset=UTF-8";
        }
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
    protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) {
        InputStream is = null;

        try {
            is = new FileInputStream(getFilePath(model));

            // setContentType(getMimeType(model));

            // response.setContentType(getContentType());
            response.setContentType(getMimeType(model));
            response.setContentLength(is.available());
            response.setHeader("Content-Transfer-Encoding", "binary");
            // response.setHeader("Content-Disposition", "attachment; filename=\"" + getFileName(request, model) + "\";");
            response.setHeader("Content-Disposition", Encodehelper.getDisposition(getFileName(request, model), Encodehelper.getBrowser(request)));

            OutputStream os = response.getOutputStream();

            FileCopyUtils.copy(is, os);
        } catch (FileNotFoundException fnfe) {
            error("Detected exception: ", fnfe);

            handleErrorMessage(response, getMessage("portal.error.000029"));
        } catch (IOException ioe) {
            error("Detected exception: ", ioe);

            handleErrorMessage(response, getMessage("portal.error.000030"));
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
}
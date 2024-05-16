package egovframework.common.view;


import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.view.AbstractView;

import egovframework.com.cmm.EgovWebUtil;

/**
 * return 값을 String로 보여주기 위한 view class
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */
public class StringView extends AbstractView {

    private static final Log logger = LogFactory.getLog(StringView.class);

    public static final String DEFAULT_CONTENT_TYPE = "text/html;charset=UTF-8";

    @Override
    protected void renderMergedOutputModel(Map model, HttpServletRequest request, HttpServletResponse response) {
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setContentType(DEFAULT_CONTENT_TYPE);
        PrintWriter writer = null;
        try {
            writer = response.getWriter();
        } catch (IOException e) {
            EgovWebUtil.exLogging(e);
        }
        Iterator<?> iterator = model.entrySet().iterator();
        while (iterator.hasNext()) {
            Entry<?, ?> entry = (Entry<?, ?>) iterator.next();
            if (((String) entry.getKey()).indexOf(".") == -1) {
                model.get((String) entry.getKey());
                writer.println(model.get((String) entry.getKey()));
            }
        }
        writer.close();
    }
}

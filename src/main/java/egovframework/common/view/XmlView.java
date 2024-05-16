package egovframework.common.view;


import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.XMLWriter;
import org.springframework.web.servlet.view.AbstractView;

import egovframework.com.cmm.EgovWebUtil;

/**
 * return 값을 xml로 보여주기 위한 view class
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */
public class XmlView extends AbstractView {

    private static final Log logger = LogFactory.getLog(XmlView.class);

    public static final String DEFAULT_CONTENT_TYPE = "application/xml;charset=UTF-8";

    @Override
    protected void renderMergedOutputModel(Map model, HttpServletRequest request, HttpServletResponse response) {
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setContentType(DEFAULT_CONTENT_TYPE);
        OutputFormat format = OutputFormat.createPrettyPrint();
        StringWriter str = new StringWriter();
        XMLWriter w = new XMLWriter(str, format);
        PrintWriter writer = null;
        try {
            Iterator<?> iterator = model.entrySet().iterator();
            while (iterator.hasNext()) {
                Entry<?, ?> entry = (Entry<?, ?>) iterator.next();
                if (((String) entry.getKey()).indexOf(".") == -1) {
                    w.write(model.get((String) entry.getKey()));
                }
            }
            writer = response.getWriter();
        } catch (IOException e) {
            EgovWebUtil.exLogging(e);
        } finally {
            try {
                if (w != null) {
                    w.close();
                }
            } catch (IOException e) {
                EgovWebUtil.exLogging(e);
            }
        }


        writer.println(str.toString());
        writer.close();
    }
}

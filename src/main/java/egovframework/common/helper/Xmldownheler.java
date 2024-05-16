package egovframework.common.helper;


import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.XMLWriter;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.AbstractView;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.util.UtilString;

/**
 * return 값을 xml로 보여주기 위한 view class
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */
@Component
public class Xmldownheler extends AbstractView {

    public static final String DEFAULT_CONTENT_TYPE = "application/xml;charset=UTF-8";

    /**
     * Xml형태로 다운로드 한다.
     *
     * @param result
     * @param head
     * @param infNm
     * @param response
     * @param requset
     * @throws Exception
     */
    public Element download(List<LinkedHashMap<String, ?>> result, LinkedHashMap<String, ?> head, String infNm, int i, Element root) {


        if (head != null && i == 0) {
            result.add(0, head);
        }
        Element data;
        for (LinkedHashMap<String, ?> map : result) {
            Iterator<?> iterator = map.entrySet().iterator();
            data = root.addElement("row");
            while (iterator.hasNext()) {
                Entry<?, ?> entry = (Entry<?, ?>) iterator.next();
                if (((String) entry.getKey()).equals("ITEM_CD1") ||
                        ((String) entry.getKey()).equals("ITEM_CD2") ||
                        ((String) entry.getKey()).equals("V_ORDER") ||
                        ((String) entry.getKey()).equals("YYYYMQ") ||
                        ((String) entry.getKey()).equals("RN") ||
                        ((String) entry.getKey()).equals("CONV_CD_1") ||
                        ((String) entry.getKey()).equals("WISEOPEN_CNT")) {
                    continue;
                }
                if (entry.getValue() == null) {
                    data.addElement((String) entry.getKey()).addText("");
                } else {
                    data.addElement((String) entry.getKey()).addText(entry.getValue() + "");
                }
            }
        }
        return root;
    }

    public void dataPrintln(String infNm, HttpServletResponse response, HttpServletRequest request, Document doc) {
        try {

            response.setHeader("Access-Control-Allow-Origin", "*");
            response.setContentType(DEFAULT_CONTENT_TYPE);
            String fileNm = UtilString.replace(infNm, " ", "") + ".xml";
            // 2015.09.05 김은삼 [1] 한글파일 다운로드 인코딩 변경 BEGIN
            // if(UtilString.getBrowser(requset).equals("I")){
            // 	fileNm = URLEncoder.encode(fileNm,"UTF-8").replaceAll("\\|", "%20").replaceAll("\\+", "%20");
            // }else{
            // 	fileNm = new String(fileNm.getBytes("UTF-8"),"ISO-8859-1");
            // }
            // response.setHeader("Content-Disposition", "attachment;filename="+"\""+fileNm+"\"");
            response.setHeader("Content-Disposition", Encodehelper.getDispositionCompatibility(request, fileNm));
            // 2015.09.05 김은삼 [1] 한글파일 다운로드 인코딩 변경 END

            // 2015.12 장홍식 파일 다운로드 lib 관련
            Cookie fileDownload = new Cookie("fileDownload", "true");
            fileDownload.setPath("/");
            fileDownload.setSecure(true);
            response.addCookie(fileDownload);
            // -- 2015.12 장홍식 파일 다운로드 lib 관련

            OutputFormat format = OutputFormat.createPrettyPrint();
            StringWriter str = new StringWriter();
            XMLWriter w = new XMLWriter(str, format);
            w.write(doc);
            w.close();
            PrintWriter writer = response.getWriter();
            writer.println(str.toString());
            writer.close();
        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
    }

    /* (non-Javadoc)
     * @see org.springframework.web.servlet.view.AbstractView#renderMergedOutputModel(java.util.Map, javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
     */
    @Override
    protected void renderMergedOutputModel(Map model, HttpServletRequest request, HttpServletResponse response) {
    }
}

package egovframework.common.helper;

/**
 * Txt 형태로 다운로드 하는 Class
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */

import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.AbstractView;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.util.UtilString;

@Component
public class Rdfdownheler extends AbstractView {

    /**
     * 텍스트 형태로 파싱을 한다.
     * @param result
     * @return
     * @throws Exception
     */
    public String download(List<LinkedHashMap<String, ?>> result, LinkedHashMap<String, ?> head, int i) {
        StringBuffer sb = new StringBuffer();

        for (LinkedHashMap<String, ?> map : result) {

            sb.append("\t<rdf:row>\n");

            for (Entry<String, ?> entry : map.entrySet()) {
/*				if(
						((String)entry.getKey()).equals("ITEM_CD1_SEQ") ||
						((String)entry.getKey()).equals("UNIT_CD"))
				{
						continue;
				}*/
                sb.append("\t\t<rdf:" + entry.getKey() + ">" + entry.getValue() + "</rdf:" + entry.getKey() + ">\n");
            }

            sb.append("\t</rdf:row>\n");
        }

        return sb.toString();
    }

    /**
     * 텍스트 형태로 다운로드 한다.
     * @param result
     * @param head
     * @param infNm
     * @param response
     * @param requset
     * @throws Exception
     */
    public void dataPrintln(String infNm, HttpServletResponse response, HttpServletRequest requset, String doc) {
        try {
            String fileNm = UtilString.replace(infNm, " ", "") + ".rdf";
			/*if(UtilString.getBrowser(requset).equals("I")){
			fileNm = URLEncoder.encode(fileNm,"UTF-8").replaceAll("\\|", "%20").replaceAll("\\+", "%20");
		}else{
			fileNm = new String(fileNm.getBytes("UTF-8"),"ISO-8859-1");
		}*/

            response.setHeader("Access-Control-Allow-Origin", "*");
            response.setContentType("text/html;charset=UTF-8");
            response.setHeader("Content-Disposition", Encodehelper.getDispositionCompatibility(requset, fileNm));

            Cookie fileDownload = new Cookie("fileDownload", "true");
            fileDownload.setPath("/");
            fileDownload.setSecure(true);
            response.addCookie(fileDownload);

            PrintWriter printwriter = response.getWriter();
            printwriter.println(doc);
            printwriter.flush();
            printwriter.close();

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
    }

    @Override
    protected void renderMergedOutputModel(Map<String, Object> model,
                                           HttpServletRequest request, HttpServletResponse response) {


    }

}

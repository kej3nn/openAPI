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
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Component;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.util.UtilString;

@Component
public class TTxtdownheler implements InitializingBean {

    protected static final Log logger = LogFactory.getLog(TTxtdownheler.class);

    private ObjectMapper objectMapper = new ObjectMapper();

    public void afterPropertiesSet() {

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
    public void download(List<LinkedHashMap<String, ?>> result, LinkedHashMap<String, ?> head, String infNm, HttpServletResponse response, HttpServletRequest requset) {
        try {

            if (head != null) {
                result.add(0, head);
            }
            String value = "";
            value = txtParsing(result);        //mapper가 없나???

            String fileNm = UtilString.replace(infNm, " ", "") + ".txt";
            if (UtilString.getBrowser(requset).equals("I")) {
                fileNm = URLEncoder.encode(fileNm, "UTF-8").replaceAll("\\|", "%20").replaceAll("\\+", "%20");
            } else {
                fileNm = new String(fileNm.getBytes("UTF-8"), "ISO-8859-1");
            }
            response.setHeader("Access-Control-Allow-Origin", "*");
            response.setContentType("text/html;charset=UTF-8");
            response.setHeader("Content-Disposition", "attachment;filename=" + "\"" + fileNm + "\"");
            PrintWriter printwriter = response.getWriter();
            printwriter.println(value);
            printwriter.flush();
            printwriter.close();
        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
    }

    /**
     * 텍스트 형태로 파싱을 한다.
     * @param result
     * @return
     * @throws Exception
     */
    private String txtParsing(List<LinkedHashMap<String, ?>> result) {
        StringBuffer sb = new StringBuffer();
		
		/*inkedHashMap<String,?> headMap = result.get(0); //head정보
		for(Entry<String,?> entry: headMap.entrySet()){
			sb.append(entry.getKey()+"\t");
		}
		sb.delete(sb.length()-1, sb.length());
		sb.append("\r\n");*/

        for (LinkedHashMap<String, ?> map : result) {
            for (Entry<String, ?> entry : map.entrySet()) {
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
                    sb.append("" + "\t");
                } else {
                    sb.append(entry.getValue() + "\t");
                }

            }
            sb.delete(sb.length() - 1, sb.length());
            sb.append("\r\n");
        }
        return sb.toString();
    }
}

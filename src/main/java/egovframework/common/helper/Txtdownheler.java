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
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map.Entry;

import javax.servlet.http.Cookie;
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
public class Txtdownheler implements InitializingBean {

    protected static final Log logger = LogFactory.getLog(Txtdownheler.class);

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
    public String download(List<LinkedHashMap<String, ?>> result, LinkedHashMap<String, ?> head, int i) {
        if (head != null) {
            result.add(0, head);
        }
        return txtParsing(result);        //mapper가 없나???
    }


    /**
     * 텍스트 형태로 파싱을 한다.
     * @param result
     * @return
     * @throws Exception
     */
    private String txtParsing(List<LinkedHashMap<String, ?>> result) {
        StringBuffer sb = new StringBuffer();
		
		/*LinkedHashMap<String,?> headMap = result.get(0); //head정보
		for(Entry<String,?> entry: headMap.entrySet()){
			sb.append(entry.getKey()+"\t");
		}
		sb.delete(sb.length()-1, sb.length());
		sb.append("\r\n");*/

        String line = System.getProperty("line.separator");

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
                    // // 2015.09.22 김은삼 [1] CSV 포맷 처리 BEGIN
                    sb.append(entry.getValue() + "\t");
                    // String value = entry.getValue().toString();
                    //
                    // if (value.indexOf("\r") >= 0 || value.indexOf("\n") >= 0) {
                    //     value = value.replaceAll("\\r", "").replaceAll("\\n", " ");
                    // }
                    //
                    // sb.append(value + "\t");
                    // 2015.09.22 김은삼 [1] CSV 포맷 처리 END
                }
            }
            sb.delete(sb.length() - 1, sb.length());
            sb.append(line);
        }
        return sb.toString();
    }


    public void dataPrintln(String infNm, HttpServletResponse response, HttpServletRequest requset, String value) {
        try {

            String fileNm = UtilString.replace(infNm, " ", "") + ".txt";
            // 2015.09.05 김은삼 [1] 한글파일 다운로드 인코딩 변경 BEGIN
            // if(UtilString.getBrowser(requset).equals("I")){
            // 	fileNm = URLEncoder.encode(fileNm,"UTF-8").replaceAll("\\|", "%20").replaceAll("\\+", "%20");
            // }else{
            // 	fileNm = new String(fileNm.getBytes("UTF-8"),"ISO-8859-1");
            // }
            // 2015.09.05 김은삼 [1] 한글파일 다운로드 인코딩 변경 END
            response.setHeader("Access-Control-Allow-Origin", "*");
            response.setContentType("text/html;charset=UTF-8");
            // 2015.09.05 김은삼 [1] 한글파일 다운로드 인코딩 변경 BEGIN
            // response.setHeader("Content-Disposition", "attachment;filename="+"\""+fileNm+"\"");
            response.setHeader("Content-Disposition", Encodehelper.getDispositionCompatibility(requset, fileNm));
            // 2015.09.05 김은삼 [1] 한글파일 다운로드 인코딩 변경 END
            // 2015.12 장홍식 파일 다운로드 lib 관련
            Cookie fileDownload = new Cookie("fileDownload", "true");
            fileDownload.setPath("/");
            fileDownload.setSecure(true);
            response.addCookie(fileDownload);
            // -- 2015.12 장홍식 파일 다운로드 lib 관련

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
}

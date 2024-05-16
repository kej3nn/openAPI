package egovframework.common.helper;

/**
 * Cvs 형태로 다운로드 하는 VIew
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map.Entry;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.util.UtilString;

@Component
public class Csvdownheler implements InitializingBean {

    protected static final Log logger = LogFactory.getLog(Csvdownheler.class);

    private ApplicationContext applicationContext;


    public void afterPropertiesSet() {


    }

    /**
     * Cvs형태로 다운로드한다.
     * @param result
     * @param head
     * @param infNm
     * @param response
     * @param requset
     * @throws Exception
     */
    public String download(List<LinkedHashMap<String, ?>> result, LinkedHashMap<String, ?> head, int i) {
        if (head != null && i == 0) {
            result.add(0, head);
        }
        String value = "";
        return csvParsing(result, i);        //mapper가 없나???
    }

    /**
     * Cvs형태로 파싱을 한다
     * @param result
     * @return
     * @throws Exception
     */
    private String csvParsing(List<LinkedHashMap<String, ?>> result, int i) {
        StringBuffer sb = new StringBuffer();
		
		/*if(i == 0){
			LinkedHashMap<String,?> headMap = result.get(0); //head정보
			for(Entry<String,?> entry: headMap.entrySet()){
				sb.append(entry.getKey()+", ");
			}
			sb.delete(sb.length()-1, sb.length());
			sb.append("\r\n");
		}*/


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
                    // 2015.09.22 김은삼 [1] CSV 포맷 처리 BEGIN
                    // sb.append(""+", ");
                    sb.append("" + ",");
                    // 2015.09.22 김은삼 [1] CSV 포맷 처리 END
                } else {
                    // 2015.09.22 김은삼 [1] CSV 포맷 처리 BEGIN
                    // sb.append(entry.getValue()+", ");
                    String value = entry.getValue().toString();

                    if (value.indexOf("\r") >= 0 || value.indexOf("\n") >= 0) {
                        value = value.replaceAll("\\r", "").replaceAll("\\n", " ");
                    }

                    if (value.indexOf("\"") >= 0 || value.indexOf(",") >= 0) {
                        value = "\"" + value.replaceAll("\\\"", "\"\"") + "\"";
                    }

                    sb.append(value + ",");
                    // 2015.09.22 김은삼 [1] CSV 포맷 처리 END
                }

            }
            sb.delete(sb.length() - 1, sb.length());
            sb.append("\r\n");
        }
        return sb.toString();
    }

    public void dataPrintln(String infNm, HttpServletResponse response, HttpServletRequest request, String value) {
        String fileNm = UtilString.replace(infNm, " ", "") + ".csv";
        // 2015.09.05 김은삼 [1] 한글파일 다운로드 인코딩 변경 BEGIN
        // if(UtilString.getBrowser(requset).equals("I")){
        // 	fileNm = URLEncoder.encode(fileNm,"UTF-8").replaceAll("\\|", "%20").replaceAll("\\+", "%20");
        // }else{
        // 	fileNm = new String(fileNm.getBytes("UTF-8"),"ISO-8859-1");
        // }
        // 2015.09.05 김은삼 [1] 한글파일 다운로드 인코딩 변경 END
        response.setContentType("text/csv;charset=MS949");
        response.setHeader("Access-Control-Allow-Origin", "*");
        // 2015.09.05 김은삼 [1] 한글파일 다운로드 인코딩 변경 BEGIN
        // response.setHeader("Content-Disposition", "attachment;filename="+"\""+fileNm+"\"");
        PrintWriter printwriter = null;
        try {
            response.setHeader("Content-Disposition", Encodehelper.getDispositionCompatibility(request, fileNm));
            // 2015.09.05 김은삼 [1] 한글파일 다운로드 인코딩 변경 END
            // 2015.12 장홍식 파일 다운로드 lib 관련
            Cookie fileDownload = new Cookie("fileDownload", "true");
            fileDownload.setPath("/");
            fileDownload.setSecure(true);
            response.addCookie(fileDownload);
            // -- 2015.12 장홍식 파일 다운로드 lib 관련

            printwriter = response.getWriter();
            printwriter.println(value);
        } catch (UnsupportedEncodingException e) {
            EgovWebUtil.exLogging(e);
        } catch (IOException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        } finally {
            if (printwriter != null) {
                printwriter.flush();
                printwriter.close();
            }

        }
    }
}

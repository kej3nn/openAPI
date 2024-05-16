package egovframework.common.helper;

/**
 * Json 형태로 다운로드하는 Class
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */

import java.io.PrintWriter;
import java.util.ArrayList;
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
import egovframework.common.base.exception.ServiceException;
import egovframework.common.util.UtilString;

@Component
public class Jsondownheler implements InitializingBean {

    protected static final Log logger = LogFactory.getLog(Jsondownheler.class);


    private ObjectMapper objectMapper = new ObjectMapper();


    public void afterPropertiesSet() {

    }

    /**
     * Json 형태로 다운로드한다.
     * @param result
     * @param head
     * @param infNm
     * @param response
     * @param requset
     * @throws Exception
     */
    public List<LinkedHashMap<String, String>> download(List<LinkedHashMap<String, ?>> result, LinkedHashMap<String, ?> head, int i) {
        if (head != null && i == 0) {
            result.add(0, head);
        }
        List<LinkedHashMap<String, String>> newResult = new ArrayList<LinkedHashMap<String, String>>();
        for (LinkedHashMap<String, ?> map : result) {
            LinkedHashMap<String, String> map2 = new LinkedHashMap<String, String>();
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
                    map2.put((String) entry.getKey(), "");
                } else {
                    map2.put((String) entry.getKey(), (entry.getValue() + ""));
                }

            }
            try {
                newResult.add(map2);
            } catch (ServiceException sve) {
                EgovWebUtil.exLogging(sve);
            } catch (Exception e) {
                EgovWebUtil.exLogging(e);
            }

        }
        return newResult;

    }


    public void dataPrintln(String infNm, HttpServletResponse response, HttpServletRequest request, List<LinkedHashMap<String, String>> newResult) {
        try {

            String value = objectMapper.writeValueAsString(newResult);
            String fileNm = UtilString.replace(infNm, " ", "") + ".json";
            // 2015.09.05 김은삼 [1] 한글파일 다운로드 인코딩 변경 BEGIN
            // if(UtilString.getBrowser(requset).equals("I")){
            // 	fileNm = URLEncoder.encode(fileNm,"UTF-8").replaceAll("\\|", "%20").replaceAll("\\+", "%20");
            // }else{
            // 	fileNm = new String(fileNm.getBytes("UTF-8"),"ISO-8859-1");
            // }
            // 2015.09.05 김은삼 [1] 한글파일 다운로드 인코딩 변경 END
            response.setHeader("Access-Control-Allow-Origin", "*");
            response.setContentType("application/json;charset=UTF-8");
            // 2015.09.05 김은삼 [1] 한글파일 다운로드 인코딩 변경 BEGIN
            // response.setHeader("Content-Disposition", "attachment;filename="+"\""+fileNm+"\"");
            response.setHeader("Content-Disposition", Encodehelper.getDispositionCompatibility(request, fileNm));
            // 2015.12 장홍식 파일 다운로드 lib 관련
            Cookie fileDownload = new Cookie("fileDownload", "true");
            fileDownload.setPath("/");
            fileDownload.setSecure(true);
            response.addCookie(fileDownload);
            // -- 2015.12 장홍식 파일 다운로드 lib 관련

            // 2015.09.05 김은삼 [1] 한글파일 다운로드 인코딩 변경 END
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

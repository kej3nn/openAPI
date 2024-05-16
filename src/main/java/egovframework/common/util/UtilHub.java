
package egovframework.common.util;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectOutputStream;
import java.net.InetAddress;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.dao.DataAccessException;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.HubConfig;


/**
 * hub 관련 util
 *
 * @author wiseopen
 * @version 1.0
 * @see cheon
 * @since 2014.04.17
 */
public class UtilHub {
    protected static final Log logger = LogFactory.getLog(UtilHub.class);


    /**
     * contexType이 json 형태이면 String JSON을 반환하고, xml 형태이면 String XML를 반환한다.
     *
     * @param request
     * @param queryMap
     * @return String
     */
    public static String setContextType(HttpServletRequest request, HashMap<String, String> queryMap) {

        String contextType = UtilString.null2Blank(queryMap.get("TYPE"));
        logger.debug(contextType);
        if (UtilString.null2Blank(request.getContentType()).equalsIgnoreCase("APPLICATION/JSON") || contextType.equalsIgnoreCase("JSON")) {
            return HubConfig.HUB_JSON;
        } else if (UtilString.null2Blank(request.getContentType()).equalsIgnoreCase("APPLICATION/JSONP") || contextType.equalsIgnoreCase("JSONP")) {
            return HubConfig.HUB_JSON;
        } else {
            return HubConfig.HUB_XML;
        }
    }

    /**
     * DB에서 조회되는 사이즈를 구한다.
     *
     * @param data
     * @return long
     */
    public static long getDataSize(List<LinkedHashMap<?, ?>> data) {
        if (data == null)
            return 0;

        ByteArrayOutputStream bo = new ByteArrayOutputStream();
        try {
            ObjectOutputStream oo = new ObjectOutputStream(bo);
            oo.writeObject(data);
            oo.flush();

        } catch (DataAccessException dae) {
            EgovWebUtil.exLogging(dae);
            return -1;
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
            return -1;
        } finally {
            try {
                if (bo != null) {
                    bo.close();
                }
            } catch (IOException e) {
                EgovWebUtil.exLogging(e);
            }
        }
        return bo.size();
    }


    /**
     * 클라이언트 ip주소를 리턴한다.
     *
     * @param request
     * @return String
     * @throws Exception
     */
    public static String getUserIp(HttpServletRequest request) {
        String local_ip = "";
        local_ip = request.getRemoteAddr();
        return local_ip;
    }

    /**
     * 조회되는 첫번째 데이터 번호를 구한다.
     *
     * @param page
     * @param pageRow
     * @return int
     */
    public static int startPageNum(int page, int pageRow) {
        if (page == 0) {
            return 0;
        }
        return ((page - 1) * pageRow) + 1;
    }

    /**
     * 조회되는 마지막 데이터 번호를 구한다.
     *
     * @param page
     * @param pageRow
     * @return int
     */
    public static int EndPageNum(int page, int pageRow) {
        if (page == 0) {
            return 0;
        }
        return page * pageRow;
    }

}

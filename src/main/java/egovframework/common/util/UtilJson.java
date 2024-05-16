
package egovframework.common.util;

import java.io.IOException;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.JsonMappingException;
import com.fasterxml.jackson.core.JsonGenerationException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * json형태로 변환하는 class
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */
public class UtilJson {

    Logger logger = LoggerFactory.getLogger(getClass());

    /**
     * json을 형식으로 가공한다.
     *
     * @param obj
     * @return
     */
    public static String convertJsonString(Object obj) {

        String result = null;

        ObjectMapper om = new ObjectMapper();

        try {
            result = om.writeValueAsString(obj);
        } catch (JsonGenerationException e) {
            return "파싱에러";
        } catch (JsonMappingException e) {
            return "JSON매핑에러";
        } catch (IOException e) {
            return "파일에러";
        }
        return result;
    }

}


package egovframework.common.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.providers.encoding.ShaPasswordEncoder;

import egovframework.common.WiseOpenConfig;
import egovframework.rte.fdl.cryptography.EgovPasswordEncoder;

/**
 * 암호화 class class
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */
public class UtilEncode {

    Logger logger = LoggerFactory.getLogger(getClass());

    /**
     * @param pw
     * @return
     */
    public static String getEncodeDbPw(String pw) {

        ShaPasswordEncoder encoder = new ShaPasswordEncoder(256);
        String encodePw = encoder.encodePassword(pw, WiseOpenConfig.DIGESTED_PASSWORD);
        return encodePw;
    }

    /**
     *
     */
    public static void getPwPrint() {
        EgovPasswordEncoder encoder = new EgovPasswordEncoder();
        encoder.setAlgorithm("SHA-256");
    }

}

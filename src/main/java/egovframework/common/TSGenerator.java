package egovframework.common;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import etiming.astdts.apl3161.TSSPdfTSGenerator;
import etiming.astdts.imprt.EnvImprt;

/**
 * PDF 문서에 TIMESTAMP를 발급해준다
 *
 * @version 1.0
 * @author JHKIM
 * @since 2020/01/20
 */
public class TSGenerator {

    public static boolean generate(String newPdfFilePath, String srcPdfFilePath) throws Exception {

        String tsPkiPath = EgovProperties.getProperty("Globals.tsPkiPath");
        String signCertPath = EgovProperties.getProperty("Globals.signCertPath");
        String signKeyPath = EgovProperties.getProperty("Globals.signKeyPath");
        String certPasswd = EgovProperties.getProperty("Globals.certPasswd");

        TSSPdfTSGenerator.setPKIEnv(tsPkiPath, signCertPath, signKeyPath, certPasswd);
        TSSPdfTSGenerator.setImprintShape(EnvImprt.CIRCULAR);
        TSSPdfTSGenerator.setPosition(10.0, 10.0);

        TSSPdfTSGenerator.generateFile(newPdfFilePath, srcPdfFilePath);
        return true;
    }


}

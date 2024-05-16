package egovframework.common;

import java.io.File;
import java.io.IOException;

import com.unidocs.workflow.client.ConfigNotFoundException;
import com.unidocs.workflow.client.ConnectionFailedException;
import com.unidocs.workflow.client.InvalidRequestException;
import com.unidocs.workflow.client.WFJob;
import com.unidocs.workflow.common.FileEx;
import com.unidocs.workflow.common.JobResult;

import egovframework.com.cmm.EgovWebUtil;

/**
 * 문서를 PDF로 변환해주는 클래스(외부 모듈 사용)
 *
 * @version 1.0
 * @author JHKIM
 * @since 2020/01/20
 */
public class DocToPdfGenerator {

    public static boolean generate(String filePath, String fileName, String fileExt) throws ConnectionFailedException, IOException, ConfigNotFoundException, InvalidRequestException {
        WFJob job = null;

        job = new WFJob();
        job.setJobBatch(true);

        FileEx srcPath = new FileEx(filePath + fileName + "." + fileExt);

        JobResult jr = job.generatePDF(srcPath, (fileName + ".pdf"), 0);

        if (jr.getStatus() == JobResult.JOB_OK) {
            jr = job.getJobResult();

            FileEx[] out = jr.getOutFile();

            for (int j = 0; j < out.length; j++) {
                out[j].saveToByStream(new File(filePath + out[j].getFileName()), true);
            }

            return true;
        } else {
            return false;
        }
    }

}

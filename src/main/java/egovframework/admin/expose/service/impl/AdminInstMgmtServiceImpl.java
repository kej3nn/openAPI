package egovframework.admin.expose.service.impl;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FilenameUtils;
import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.admin.expose.service.AdminInstMgmtService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.common.base.exception.SystemException;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.service.BaseService;
import egovframework.common.base.view.ImageView;

/**
 * 기관관리 관리를 위한 ServiceImpl 클래스
 *
 * @author 정인선
 * @since 2019.08.27
 */

@Service("AdminInstMgmtService")
public class AdminInstMgmtServiceImpl extends BaseService implements AdminInstMgmtService {

    public static final int BUFF_SIZE = 2048;

    @Resource(name = "AdminInstMgmtDao")
    private AdminInstMgmtDao instMgmtDao;

    private static final Logger logger = Logger.getLogger(AdminInstMgmtServiceImpl.class.getClass());

    /**
     * 기관관리 전체조회
     */
    @SuppressWarnings("unchecked")
    @Override
    public List<Record> instMgmtListTree(Params params) {
        List<Record> search = null;
        try {
            search = (List<Record>) instMgmtDao.selectInstMgmtListTree(params);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return search;
    }

    /**
     * 기관관리 CUD
     */
    @Override
    public Object saveInstMgmt(HttpServletRequest request, Params params) {
        final MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
        String instCd = params.getString("instCd");

        FileOutputStream fis = null;

        try {
            MultipartFile file = multiRequest.getFile("instOfslFlPhNm"); //이미지
            if (file.getSize() > 0) {
                String instOfSlFlNm = file.getOriginalFilename();
                String fileExt = FilenameUtils.getExtension(instOfSlFlNm);
                String instOfslFlPhNm = instCd + "." + fileExt;
                params.put("instOfslFlNm", instOfSlFlNm);
                params.put("instOfslFlPhNm", instOfslFlPhNm);

                //저장 디렉토리
                String directory = EgovProperties.getProperty("Globals.OpnzAplFilePath") + File.separator + params.getString("instCd") + File.separator;
                directory = EgovWebUtil.folderPathReplaceAll(directory);

                File directoryPath = new File(directory);
                // 수정 : 권한 설정
                directoryPath.setExecutable(true, true);
                directoryPath.setReadable(true);
                directoryPath.setWritable(true, true);

                if (!directoryPath.exists()) {
                    directoryPath.mkdirs();
                }

                fis = new FileOutputStream(EgovWebUtil.filePathBlackList(directoryPath + File.separator + instOfslFlPhNm));
                InputStream stream = file.getInputStream();
                int bytesRead = 0;
                byte[] buffer = new byte[BUFF_SIZE];

                while ((bytesRead = stream.read(buffer, 0, BUFF_SIZE)) != -1) {
                    fis.write(buffer, 0, bytesRead);
                }
            } else {
                params.put("instOfslFlNm", "");
                params.put("instOfslFlPhNm", "");
            }

            /*데이터 저장*/
            instMgmtDao.insertInstMgmt(params);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
            throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
        } finally {
            try {
                if (fis != null) {
                    fis.close();
                }
            } catch (Exception e) {
                EgovWebUtil.exLogging(e);
            }
        }

        return success(getMessage("admin.message.000006"));
    }

    /**
     * 정보 썸네일 불러오기
     */
    @Override
    public Record selectInstMgmtThumbnail(Params params) {
        Record thumbnail = new Record();

        Record file = (Record) instMgmtDao.instMgmtRetr(params);

        thumbnail.put("instCd", params.getString("instCd"));
        thumbnail.put("instOfslFlPhNm", params.getString("instOfslFlPhNm"));

        thumbnail.put(ImageView.FILE_PATH, getFilePath(file));
        thumbnail.put(ImageView.FILE_NAME, params.getString("instOfslFlPhNm"));

        return thumbnail;
    }

    /**
     * 기관관리 단건 조회
     *
     * @param params
     * @return
     */

    public Record instMgmtRetr(Params params) {
        Record data = (Record) instMgmtDao.instMgmtRetr(params);
        return data;
    }

    /**
     * 정보 분류 파일 정보 가져오기
     *
     * @param file
     * @return
     */
    private String getFilePath(Record file) {
        StringBuffer buffer = new StringBuffer();

        buffer.append(EgovProperties.getProperty("Globals.OpnzAplFilePath"));
        buffer.append(file.getString("instCd"));
        buffer.append(File.separator);
        buffer.append(EgovWebUtil.filePathReplaceAll(file.getString("instOfslFlPhNm")));

        return buffer.toString();
    }

}

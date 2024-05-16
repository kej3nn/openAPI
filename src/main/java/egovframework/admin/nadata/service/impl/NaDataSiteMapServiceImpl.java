package egovframework.admin.nadata.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.admin.basicinf.service.CommUsr;
import egovframework.admin.nadata.service.NaDataSiteMapService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.common.base.constants.GlobalConstants;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.exception.SystemException;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;
import egovframework.common.base.service.BaseService;
import egovframework.common.base.view.ImageView;


@Service(value = "naDataSiteMapService")
public class NaDataSiteMapServiceImpl extends BaseService implements NaDataSiteMapService {
    public static final int BUFF_SIZE = 2048;

    @Resource(name = "naDataSiteMapDao")
    protected NaDataSiteMapDao naDataSiteMapDao;

    /**
     * 메인 리스트 조회(페이징 처리)
     */
    @Override
    public Paging selectSiteMapMainListPaging(Params params) {
        if (EgovUserDetailsHelper.isAuthenticated()) {
            CommUsr loginVO = null;
            EgovUserDetailsHelper.getAuthenticatedUser();
            loginVO = (CommUsr) EgovUserDetailsHelper.getAuthenticatedUser();
            params.put("accCd", loginVO.getAccCd());    //로그인 된 유저 권환 획득
            // 유저 입력 권한(부서별 or 개인별)
            params.put("SysInpGbn", GlobalConstants.SYSTEM_INPUT_GBN);
            params.put("inpOrgCd", loginVO.getOrgCd());    // 로그인 된 부서코드
            params.put("inpUsrCd", loginVO.getUsrCd());    //로그인 된 유저 코드
        }

        Paging list = naDataSiteMapDao.selectMainList(params, params.getPage(), params.getRows());
        return list;
    }

    /**
     * 기관정보 리스트 조회
     */
    @Override
    public List<Record> selectOrgList(Params params) {
        if (EgovUserDetailsHelper.isAuthenticated()) {
            CommUsr loginVO = null;
            EgovUserDetailsHelper.getAuthenticatedUser();
            loginVO = (CommUsr) EgovUserDetailsHelper.getAuthenticatedUser();
            params.put("accCd", loginVO.getAccCd());    //로그인 된 유저 권환 획득
            // 유저 입력 권한(부서별 or 개인별)
            params.put("SysInpGbn", GlobalConstants.SYSTEM_INPUT_GBN);
            params.put("inpOrgCd", loginVO.getOrgCd());    // 로그인 된 부서코드
            params.put("inpUsrCd", loginVO.getUsrCd());    //로그인 된 유저 코드
        }
        List<Record> result = new ArrayList<Record>();

        try {
            result = naDataSiteMapDao.selectOrgList(params);
        } catch (DataAccessException dae) {
            EgovWebUtil.exLogging(dae);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    /**
     * 사이트맵 ID중복체크
     */
    @Override
    public Record naDataSiteMapDupChk(Params params) {
        Record result = new Record();

        try {
            result = (Record) naDataSiteMapDao.selectNaDataSiteMapDupChk(params);
        } catch (DataAccessException dae) {
            EgovWebUtil.exLogging(dae);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    /**
     * 사이트맵 데이터 저장
     */
    @Override
    public Object saveNaDataSiteMap(HttpServletRequest request, Params params) {
        final MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
        String srvmId = params.getString("srvmId");
        FileOutputStream fos = null;
        try {

            MultipartFile file1 = multiRequest.getFile("tmnlImgFile");    //미리보기 이미지
            MultipartFile file2 = multiRequest.getFile("tmnl2ImgFile");    //사이트맵 이미지

            if (file1.getSize() > 0) {
                String srcFileNm = file1.getOriginalFilename();                    //원본 파일명
                String fileExt = FilenameUtils.getExtension(srcFileNm);            //파일 확장자
                String saveFileNm = srvmId + "preView." + fileExt;    //저장파일명(파라미터 값)
                params.put("tmnlImgFileNm", saveFileNm);

                //저장 디렉토리(properties + ID)
                String directoryPath = EgovProperties.getProperty("Globals.NaDataSiteMapFilePath");
                directoryPath = EgovWebUtil.folderPathReplaceAll(directoryPath);
                File directory = new File(directoryPath);
                // 수정 : 권한 설정
                directory.setExecutable(true, true);
                directory.setReadable(true);
                directory.setWritable(true, true);

                if (!directory.isDirectory()) {
                    directory.mkdir();
                }

                if (saveFileNm != null && !"".equals(saveFileNm)) {
                    fos = new FileOutputStream(EgovWebUtil.filePathBlackList(directoryPath + File.separator + saveFileNm));
                    InputStream stream = file1.getInputStream();
                    int bytesRead = 0;
                    byte[] buffer = new byte[BUFF_SIZE];

                    while ((bytesRead = stream.read(buffer, 0, BUFF_SIZE)) != -1) {
                        fos.write(buffer, 0, bytesRead);
                    }
                }
            }

            if (file2.getSize() > 0) {
                String srcFileNm = file2.getOriginalFilename();                    //원본 파일명
                String fileExt = FilenameUtils.getExtension(srcFileNm);            //파일 확장자
                String saveFileNm = srvmId + "siteMap." + fileExt;    //저장파일명(파라미터 값)
                params.put("tmnl2ImgFileNm", saveFileNm);

                //저장 디렉토리(properties + ID)
                String directoryPath = EgovProperties.getProperty("Globals.NaDataSiteMapFilePath");
                directoryPath = EgovWebUtil.folderPathReplaceAll(directoryPath);
                File directory = new File(directoryPath);
                // 수정 : 권한 설정
                directory.setExecutable(true, true);
                directory.setReadable(true);
                directory.setWritable(true, true);

                if (!directory.isDirectory()) {
                    directory.mkdir();
                }

                if (saveFileNm != null && !"".equals(saveFileNm)) {
                    fos = new FileOutputStream(EgovWebUtil.filePathBlackList(directoryPath + File.separator + saveFileNm));
                    InputStream stream = file2.getInputStream();
                    int bytesRead = 0;
                    byte[] buffer = new byte[BUFF_SIZE];

                    while ((bytesRead = stream.read(buffer, 0, BUFF_SIZE)) != -1) {
                        fos.write(buffer, 0, bytesRead);
                    }
                }
            }
            /* 데이터 저장 */
            naDataSiteMapDao.saveNaDataSiteMap(params);

            // 데이터 수정시 사용여부 N처리 될 경우 N처리된 하위 항목들은 모두 동일하게 사용여부 N처리 한다.
            if (StringUtils.equals("N", params.getString("useYn"))) {
                // infSetCateDao.updateInfoCateChildUseN(params);  // 보류
            }


        } catch (IOException ioe) {
            EgovWebUtil.exTransactionLogging(ioe);
            throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
            throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
        } finally {
            try {
                if (fos != null) {
                    fos.close();
                }
            } catch (DataAccessException dae) {
                EgovWebUtil.exTransactionLogging(dae);
            } catch (Exception e) {
                EgovWebUtil.exTransactionLogging(e);
            }
        }

        return success(getMessage("admin.message.000006"));
    }

    /**
     * 사이트맵 상세 조회
     */
    @Override
    public Record naDataSiteMapDtl(Params params) {
        Record result = new Record();

        try {
            result = (Record) naDataSiteMapDao.selectNaDataSiteMapDtl(params);
        } catch (DataAccessException dae) {
            EgovWebUtil.exLogging(dae);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    /**
     * 사이트맵 이미지 썸네일 조회
     */
    @Override
    public Record selectDataSiteMapThumbnail(Params params) {
        Record file = (Record) naDataSiteMapDao.selectNaDataSiteMapDtl(params);

        Record thumbnail = new Record();
        thumbnail.put("srvmId", params.getString("srvmId"));
        thumbnail.put("tmnlImgFile", file.getString("tmnlImgFileNm"));
        thumbnail.put("tmnl2ImgFile", file.getString("tmnl2ImgFileNm"));

        thumbnail.put(ImageView.FILE_PATH, getFilePath(file, params.getString("thumbKind")));
        if (params.getString("thumbKind").equals("preView")) {
            thumbnail.put(ImageView.FILE_NAME, file.getString("tmnlImgFileNm"));
        } else if (params.getString("thumbKind").equals("siteMap")) {
            thumbnail.put(ImageView.FILE_NAME, file.getString("tmnl2ImgFileNm"));
        } else {
            thumbnail.put(ImageView.FILE_NAME, "");
        }


        return thumbnail;
    }


    @Override
    public Object deleteNaDataSiteMap(Params params) {
        try {
            naDataSiteMapDao.deleteNaDataSiteMap(params);
        } catch (DataAccessException dae) {
            EgovWebUtil.exTransactionLogging(dae);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
        return success(getMessage("admin.message.000005"));
    }

    /**
     * 사이트맵 순서 저장
     */
    @Override
    public Result saveNaDataSiteMapOrder(Params params) {
        Record rec = null;
        try {
            Params[] data = params.getJsonArray(Params.SHEET_DATA);
            for (int i = 0; i < data.length; i++) {
                rec = new Record();
                rec.put("srvmId", data[i].getString("srvmId"));
                rec.put("vOrder", data[i].getInt("vOrder"));
                naDataSiteMapDao.saveNaDataSiteMapOrder(rec);
            }
        } catch (DataAccessException dae) {
            error("Exception : ", dae);
            EgovWebUtil.exTransactionLogging(dae);
            throw new ServiceException("admin.error.000003", getMessage("admin.error.000003"));
        } catch (Exception e) {
            error("Exception : ", e);
            EgovWebUtil.exTransactionLogging(e);
            throw new ServiceException("admin.error.000003", getMessage("admin.error.000003"));
        }
        return success(getMessage("admin.message.000004"));
    }

    /**
     * 사이트맵 파일 정보 가져오기
     *
     * @param file
     * @return
     */
    private String getFilePath(Record file, String thumbKind) {
        StringBuffer buffer = new StringBuffer();

        buffer.append(EgovProperties.getProperty("Globals.NaDataSiteMapFilePath"));
        if (thumbKind.equals("preView")) {
            buffer.append(EgovWebUtil.filePathReplaceAll(file.getString("tmnlImgFileNm")));
        } else if (thumbKind.equals("siteMap")) {
            buffer.append(EgovWebUtil.filePathReplaceAll(file.getString("tmnl2ImgFileNm")));
        }

        return buffer.toString();
    }
}

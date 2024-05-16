package egovframework.admin.nadata.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Arrays;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.admin.basicinf.service.CommUsr;
import egovframework.admin.nadata.service.NaCmpsService;
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

@Service(value = "naCmpsService")
public class NaCmpsServiceImpl extends BaseService implements NaCmpsService {

    public static final int BUFF_SIZE = 2048;

    @Resource(name = "naCmpsDao")
    protected NaCmpsDao naCmpsDao;

    /**
     * 메인 리스트 조회(페이징 처리)
     */
    @Override
    public Paging selectNaCmpsListPaging(Params params) {

        // 분류체계 여러개 검색(IN 절)
        if (StringUtils.isNotEmpty(params.getString("cateIds"))) {
            ArrayList<String> iterCateId = new ArrayList<String>(Arrays.asList(params.getString("cateIds").split(",")));
            params.set("iterCateId", iterCateId);
        }
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


        Paging list = naCmpsDao.selectNaCmpsList(params, params.getPage(), params.getRows());

        return list;
    }


    /**
     * 정보카달로그 ID중복체크
     */
    @Override
    public Record naCmpsDupChk(Params params) {
        Record result = null;
        try {
            result = (Record) naCmpsDao.selectNaCmpsDupChk(params);
        } catch (DataAccessException dae) {
            EgovWebUtil.exLogging(dae);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    /**
     * 정보카달로그 데이터 저장
     */
    @Override
    public Object saveNaCmps(HttpServletRequest request, Params params) {
        final MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
        String infoId = params.getString("infoId");
        FileOutputStream fos = null;
        try {

            MultipartFile file = multiRequest.getFile("tmnlImgFile");    //미리보기 이미지

            if (file.getSize() > 0) {
                String srcFileNm = file.getOriginalFilename();                    //원본 파일명
                String fileExt = FilenameUtils.getExtension(srcFileNm);            //파일 확장자
                String saveFileNm = infoId + "." + fileExt;    //저장파일명(파라미터 값)
                params.put("tmnlImgFileNm", saveFileNm);

                //저장 디렉토리(properties + ID)
                String directoryPath = EgovProperties.getProperty("Globals.NaCmpsFilePath");
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
                    InputStream stream = file.getInputStream();
                    int bytesRead = 0;
                    byte[] buffer = new byte[BUFF_SIZE];

                    while ((bytesRead = stream.read(buffer, 0, BUFF_SIZE)) != -1) {
                        fos.write(buffer, 0, bytesRead);
                    }
                }
            }


            /* 데이터 저장 */
            naCmpsDao.saveNaCmps(params);

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
            } catch (IOException ioe) {
                EgovWebUtil.exTransactionLogging(ioe);
            }
        }

        return success(getMessage("admin.message.000006"));
    }

    /**
     * 정보카달로그 상세 조회
     */
    @Override
    public Record naCmpsDtl(Params params) {
        Record result = null;
        try {
            result = (Record) naCmpsDao.selectNaCmpsDtl(params);
        } catch (DataAccessException dae) {
            EgovWebUtil.exLogging(dae);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    /**
     * 정보카달로그 이미지 썸네일 조회
     */
    @Override
    public Record selectNaCmpsThumbnail(Params params) {
        Record file = (Record) naCmpsDao.selectNaCmpsDtl(params);

        Record thumbnail = new Record();
        thumbnail.put("infoId", params.getString("infoId"));
        thumbnail.put("tmnlImgFile", file.getString("tmnlImgFileNm"));

        thumbnail.put(ImageView.FILE_PATH, getFilePath(file));
        thumbnail.put(ImageView.FILE_NAME, file.getString("tmnlImgFileNm"));

        return thumbnail;
    }


    @Override
    public Object deleteNaCmps(Params params) {
        try {
            naCmpsDao.deleteNaCmps(params);
        } catch (DataAccessException dae) {
            EgovWebUtil.exTransactionLogging(dae);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
        return success(getMessage("admin.message.000005"));
    }

    /**
     * 정보카달로그 순서 저장
     */
    @Override
    public Result saveNaCmpsOrder(Params params) {
        Record rec = null;
        try {
            Params[] data = params.getJsonArray(Params.SHEET_DATA);
            for (int i = 0; i < data.length; i++) {
                rec = new Record();
                rec.put("infoId", data[i].getString("infoId"));
                rec.put("vOrder", data[i].getInt("vOrder"));
                naCmpsDao.saveNaDataSiteMapOrder(rec);
            }
        } catch (ServiceException sve) {
            EgovWebUtil.exTransactionLogging(sve);
            throw new ServiceException("admin.error.000003", getMessage("admin.error.000003"));
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
            throw new ServiceException("admin.error.000003", getMessage("admin.error.000003"));
        }
        return success(getMessage("admin.message.000004"));
    }

    /**
     * 정보카달로그 파일 정보 가져오기
     *
     * @param file
     * @return
     */
    private String getFilePath(Record file) {
        StringBuffer buffer = new StringBuffer();

        buffer.append(EgovProperties.getProperty("Globals.NaCmpsFilePath"));

        buffer.append(EgovWebUtil.filePathReplaceAll(file.getString("tmnlImgFileNm")));

        return buffer.toString();
    }

}

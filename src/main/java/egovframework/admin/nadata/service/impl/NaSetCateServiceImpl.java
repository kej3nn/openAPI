package egovframework.admin.nadata.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.admin.nadata.service.NaSetCateService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.exception.SystemException;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;
import egovframework.common.base.service.BaseService;
import egovframework.common.base.view.ImageView;

@Service(value = "naSetCateService")
public class NaSetCateServiceImpl extends BaseService implements NaSetCateService {

    public static final int BUFF_SIZE = 2048;

    @Resource(name = "naSetCateDao")
    protected NaSetCateDao naSetCateDao;

    /**
     * 정보카달로그 분류 메인 리스트 조회
     */
    @Override
    public List<Record> naSetCateList(Params params) {
        return (List<Record>) naSetCateDao.selectNaSetCateList(params);
    }

    /**
     * 정보카달로그 분류 팝업 리스트 조회
     */
    @Override
    public List<Record> naSetCatePopList(Params params) {
        return (List<Record>) naSetCateDao.selectNaSetCatePopList(params);
    }

    /**
     * 정보카달로그 분류 상세 조회
     */
    @Override
    public Record naSetCateDtl(Params params) {
        return (Record) naSetCateDao.selectNaSetCateDtl(params);
    }

    /**
     * 정보카달로그 분류 ID 중복체크
     */
    @Override
    public Record naSetCateDupChk(Params params) {
        return (Record) naSetCateDao.selectNaSetCateDupChk(params);
    }

    /**
     * 정보카달로그 분류 등록/수정
     */
    @Override
    public Object saveNaSetCate(HttpServletRequest request, Params params) {
        final MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
        String cateId = params.getString("cateId");
        FileOutputStream fos = null;
        try {

            MultipartFile file = multiRequest.getFile("cateFile");    //정보카달로그 분류 이미지
            if (file.getSize() > 0) {
                String srcFileNm = file.getOriginalFilename();                    //원본 파일명
                String fileExt = FilenameUtils.getExtension(srcFileNm);            //파일 확장자
                String saveFileNm = cateId + "." + fileExt;    //저장파일명(파라미터 값)
                params.put("srcFileNm", srcFileNm);
                params.put("saveFileNm", saveFileNm);
                params.put("viewFileNm", saveFileNm);

                //저장 디렉토리(properties + ID)
                String directoryPath = EgovProperties.getProperty("Globals.NaSetCateFilePath");
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
            naSetCateDao.saveNaSetCate(params);

            // 데이터 수정시 사용여부 N처리 될 경우 N처리된 하위 항목들은 모두 동일하게 사용여부 N처리 한다.
            if (StringUtils.equals("N", params.getString("useYn"))) {
                // naSetCateDao.updateNaoCateChildUseN(params);  // 보류
            }

            //관련된 분류 전체명, 분류 레벨 일괄 업데이트 처리
            naSetCateDao.updateNaSetCateFullnm(params);

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
            } catch (IOException e) {
                EgovWebUtil.exTransactionLogging(e);
            } catch (Exception e) {
                EgovWebUtil.exTransactionLogging(e);
            }
        }

        return success(getMessage("admin.message.000006"));
    }

    /**
     * 정보카달로그 썸네일 불러오기
     */
    @Override
    public Record selectNaSetCateThumbnail(Params params) {
        Record file = (Record) naSetCateDao.selectNaSetCateDtl(params);

        Record thumbnail = new Record();
        thumbnail.put("cateId", params.getString("cateId"));
        thumbnail.put("saveFileNm", params.getString("saveFileNm"));

        thumbnail.put(ImageView.FILE_PATH, getFilePath(file));
        thumbnail.put(ImageView.FILE_NAME, params.getString("saveFileNm"));

        return thumbnail;
    }

    /**
     * 정보카달로그 분류 삭제
     */
    @Override
    public Object deleteNaSetCate(Params params) {
        try {
            Record child = naSetCateDao.selectNaSetCateHaveChild(params);
            String haveChild = child.getString("haveChild");
            if ("N".equals(haveChild)) {
                naSetCateDao.deleteNaSetCate(params);
            } else {
                //삭제 하려는 행에 자식분류가 존재 합니다.\n자식분류 먼저 삭제 하여 주시기 바랍니다.
                throw new ServiceException(getMessage("admin.message.000008"));
            }
        } catch (DataAccessException dae) {
            EgovWebUtil.exTransactionLogging(dae);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
        return success(getMessage("admin.message.000005"));
    }

    /**
     * 정보카달로그 분류 순서 저장
     */
    @Override
    public Result saveNaSetCateOrder(Params params) {
        Record rec = null;
        try {

            Params[] data = params.getJsonArray(Params.SHEET_DATA);
            for (int i = 0; i < data.length; i++) {
                rec = new Record();
                rec.put("cateId", data[i].getString("cateId"));
                rec.put("vOrder", data[i].getInt("vOrder"));
                naSetCateDao.saveNaSetCateOrder(rec);
            }
        } catch (DataAccessException e) {
            EgovWebUtil.exTransactionLogging(e);
        } catch (Exception e) {
            error("Exception : ", e);
            EgovWebUtil.exTransactionLogging(e);
            throw new ServiceException("admin.error.000003", getMessage("admin.error.000003"));
        }
        return success(getMessage("admin.message.000004"));
    }

    /**
     * 정보카달로그 분류 파일 정보 가져오기
     *
     * @param file
     * @return
     */
    private String getFilePath(Record file) {
        StringBuffer buffer = new StringBuffer();

        buffer.append(EgovProperties.getProperty("Globals.NaSetCateFilePath"));
        buffer.append(EgovWebUtil.filePathReplaceAll(file.getString("saveFileNm")));

        return buffer.toString();
    }
}

package egovframework.admin.service.service.impl;

import java.io.File;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import egovframework.admin.basicinf.service.CommUsr;
import egovframework.admin.service.service.OpenInfFileService;
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
import egovframework.common.base.view.FileDownloadView;
import egovframework.common.file.service.impl.FileDAO;
import egovframework.common.util.UtilString;

@Service(value = "openInfFileService")
public class OpenInfFileServiceImpl extends BaseService implements OpenInfFileService {

    @Resource(name = "openInfFileDao")
    private OpenInfFileDao openInfFileDao;

    @Resource(name = "FileDAO")
    private FileDAO FileDao;

    /**
     * 서비스 목록 조회
     */
    @Override
    public Paging selectOpenInfSrvList(Params params) {
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

        return openInfFileDao.selectOpenInfSrvList(params, params.getPage(), params.getRows());
    }

    /**
     * 서비스 상세 조회
     */
    @Override
    public Record selectOpenInfSrvDtl(Params params) {

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

        return openInfFileDao.selectOpenInfSrvDtl(params);
    }

    /**
     * 서비스 파일 목록 조회
     */
    @Override
    public List<Record> selectOpenInfFileList(Params params) {
        return openInfFileDao.selectOpenInfFileList(params);
    }

    /**
     * 서비스 파일 등록
     */
    @Override
    public Result insertOpeninfFile(HttpServletRequest request, Params params) {
        int fileSeq = 0;

        try {

            MultipartFile file = params.getFile("atchFile");

            if (file.getSize() > 0) {
                // 디렉토리 생성
                String dirFilePath = makeFilePath(params);

                // 파일정보
                String srcFile = file.getOriginalFilename();                // 원본 파일
                String srcFileNm = FilenameUtils.getName(srcFile);            // 원본 파일명
                String fileExt = FilenameUtils.getExtension(srcFile);        // 파일 확장자
                long fileSize = file.getSize();                                // 파일사이즈

                if (!allowFileCheck(fileExt)) {
                    throw new ServiceException("파일 업로드를 허용하지 않는 확장자 입니다.");
                }

                // 신규 파일번호 생성
                fileSeq = FileDao.fileSeq();
                String fileName = EgovWebUtil.filePathReplaceAll(Integer.toString(fileSeq)) + "." + fileExt;

                String sFile = dirFilePath + File.separator + fileName;
                File savedFile = new File(sFile);
                file.transferTo(savedFile);

                params.put("fileSeq", fileSeq);
                params.put("srcFileNm", srcFileNm);
                params.put("saveFileNm", fileName);
//				params.put("viewFileNm", params.getString("viewFileNm"));
                params.put("fileExt", fileExt);
                params.put("fileSize", fileSize);

                openInfFileDao.insertOpeninfFile(params);

            } else {
                throw new ServiceException("파일을 확인해 주십시오.");
            }
        } catch (SystemException e) {
            EgovWebUtil.exLogging(e);
            //throw new SystemException(e.getMessage());
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
            throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
        }

        return success("정상적으로 파일을 추가하였습니다.");
    }

    /**
     * 서비스 파일 수정(파일이 있는 경우만 파일 변경)
     */
    @Override
    public Result updateOpeninfFile(Params params) {

        MultipartFile file = params.getFile("atchFile");

        try {

            if (file.getSize() > 0) {
                // 디렉토리 정보
                String dirFilePath = makeFilePath(params);

                // 파일정보
                String srcFile = file.getOriginalFilename();                // 원본 파일
                String srcFileNm = FilenameUtils.getName(srcFile);            // 원본 파일명
                String fileExt = FilenameUtils.getExtension(srcFile);        // 파일 확장자
                long fileSize = file.getSize();                                // 파일사이즈

                if (!allowFileCheck(fileExt)) {
                    throw new ServiceException("파일 업로드를 허용하지 않는 확장자 입니다.");
                }

                // 기존에 사용중인 파일번호 사용
                int fileSeq = params.getInt("fileSeq");
                String fileName = EgovWebUtil.filePathReplaceAll(Integer.toString(fileSeq)) + "." + fileExt;

                String sFile = dirFilePath + File.separator + fileName;
                File savedFile = new File(sFile);
                file.transferTo(savedFile);

                params.put("isFileUpd", "Y");
                params.put("srcFileNm", srcFileNm);
                params.put("saveFileNm", fileName);
//				params.put("viewFileNm", params.getString("viewFileNm"));
                params.put("fileExt", fileExt);
                params.put("fileSize", fileSize);
            }

            // 파일이 없는경우 데이터만 수정
            openInfFileDao.updateOpeninfFile(params);

        } catch (SystemException e) {
            EgovWebUtil.exLogging(e);
            //throw new SystemException(e.getMessage());
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
            throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
        }

        return success(getMessage("admin.message.000004"));
    }

    /**
     * 서비스 파일 삭제
     */
    @Override
    public Result deleteOpeninfFile(Params params) {
        openInfFileDao.deleteOpeninfFile(params);

        return success(getMessage("admin.message.000005"));
    }

    /**
     * 서비스 폴더 생성
     */
    private String makeFilePath(Params params) {

        // 디렉토리 생성
        String serviceFilePath = EgovProperties.getProperty("Globals.ServiceFilePath");
        String dirFilePath = serviceFilePath + UtilString.getFolderPath(params.getInt("seq"), serviceFilePath);    //Directory 전체경로

        File dir = new File(dirFilePath);

        // 수정 : 권한 설정
        dir.setExecutable(true, true);
        dir.setReadable(true);
        dir.setWritable(true, true);

        if (!dir.exists()) {
            dir.mkdirs();
        }

        return dirFilePath;
    }

    /**
     * 서비스 파일 업로드시 허용파일 체크
     */
    private boolean allowFileCheck(String fileExt) {
        String[] types = {"hwp", "ppt", "pptx", "xls", "xlsx", "doc", "txt", "docx", "zip", "pdf"}; //파일 허용타입
        boolean bTypeChk = false;
        for (String type : types) {
            if (StringUtils.indexOf(fileExt, type) > -1) {
                bTypeChk = true;
                break;
            }
        }

        return bTypeChk;
    }

    /**
     * 서비스 파일 다운로드
     */
    @Override
    public Record downloadOpeninfFile(Params params) {
        Record fileMap = openInfFileDao.selectOpenInfDownFile(params);

        // 디렉토리 생성
        String serviceFilePath = EgovProperties.getProperty("Globals.ServiceFilePath");
        String dirFilePath = serviceFilePath + UtilString.getFolderPath(fileMap.getInt("seq"), serviceFilePath);
        String sFile = dirFilePath + File.separator + fileMap.getString("saveFileNm");

        Record file = new Record();
        file.put(FileDownloadView.FILE_PATH, sFile);
        file.put(FileDownloadView.FILE_NAME, fileMap.getString("dpViewFileNm"));
        file.put(FileDownloadView.FILE_SIZE, params.getString("fileSize"));

        return file;
    }

    /**
     * 파일서비스 순서 저장
     */
    @Override
    public Result saveOpenInfFileOrder(Params params) {
        Params[] data = params.getJsonArray(Params.SHEET_DATA);
        try {
            for (int i = 0; i < data.length; i++) {
                if (StringUtils.equals(Params.STATUS_UPDATE, data[i].getString("Status"))) {
                    openInfFileDao.saveOpenInfFileOrder(data[i]);
                }
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
}

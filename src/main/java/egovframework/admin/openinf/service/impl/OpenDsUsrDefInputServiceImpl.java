package egovframework.admin.openinf.service.impl;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.rmi.CORBA.Util;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import egovframework.admin.basicinf.service.CommUsr;
import egovframework.admin.openinf.service.OpenDsUsrDefInput;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.common.base.constants.GlobalConstants;
import egovframework.common.base.constants.ModelAttribute;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.exception.SystemException;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;
import egovframework.common.base.service.BaseService;
import egovframework.common.base.view.FileDownloadView;
import egovframework.common.util.UtilString;

/**
 * 데이터셋 사용자정의 입력 서비스 구현 클래스
 *
 * @author JHKIM
 * @version 1.0
 * @since 2019/09/26
 */
@Service(value = "openDsUsrDefInput")
public class OpenDsUsrDefInputServiceImpl extends BaseService implements OpenDsUsrDefInput {

    @Resource(name = "openDsUsrDefInputDao")
    private OpenDsUsrDefInputDao openDsUsrDefInputDao;

    /**
     * 연계유형이 사용자건별입력로 지정한 데이터셋이 맞는지 체크
     */
    @Override
    public int selectOpenDsUsrDefExist(String dsId) {
        return openDsUsrDefInputDao.selectOpenDsUsrDefExist(dsId);
    }

    /**
     * 컬럼 리스트 조회
     */
    @Override
    public List<Record> selectOpenDsUsrDefColList(Params params) {
        return (List<Record>) openDsUsrDefInputDao.selectOpenDsUsrDefColList(params);
    }

    /**
     * 시트 헤더정보 조회(컬럼정보)
     */
    @Override
    public List<Record> selectOpenDsUsrDefHeaderData(Params params) {
        return (List<Record>) openDsUsrDefInputDao.selectOpenDsUsrDefHeaderData(params);
    }

    /**
     * 데이터 로드(테이블 RAW 데이터)
     */
    @Override
    public Paging selectOpenDsUsrDefData(Params params) {

        Params tableParam = new Params();
        tableParam.put("dsId", params.getString("dsId"));

        // sql 삽입 보안취약점 처리
        // 스키마 조회
        tableParam.put("ownerCd", UtilString.SQLInjectionFilter2(openDsUsrDefInputDao.selectOpenDsUsrOwnerCd(tableParam)));

        // 테이블명 조회
        tableParam.put("tableName", UtilString.SQLInjectionFilter2(openDsUsrDefInputDao.selectOpenDsUsrTableName(tableParam)));

        // 컬럼명 조회
        tableParam.put("defDataCol", "Y");    // 기본컬럼 포함여부

        tableParam.put("searchVal", params.getString("searchVal"));
        List<Record> colList = selectOpenDsUsrDefColList(params);
        if (colList.size() > 0) {
            tableParam.put("searchGubun", colList.get(0).getString("srcColId"));
        }

        List<Record> columnNames = (List<Record>) openDsUsrDefInputDao.selectOpenDsUsrColumnNames(tableParam);
        ArrayList<String> arrColumnNames = new ArrayList<String>();

        // sql 삽입 보안취약점 처리
        for (Record r : columnNames) {
            arrColumnNames.add(UtilString.SQLInjectionFilter2(r.getString("columnName")));
        }
        tableParam.put("columnNames", arrColumnNames);

        // 자기 부서만 조회되도록 수정
        if (EgovUserDetailsHelper.isAuthenticated()) {
            CommUsr loginVO = (CommUsr) EgovUserDetailsHelper.getAuthenticatedUser();
            tableParam.put("accCd", loginVO.getAccCd());    //로그인 된 유저 권환 획득
            tableParam.put("inpOrgCd", loginVO.getOrgCd());    // 로그인 된 부서코드
        }

        return openDsUsrDefInputDao.selectOpenDsUsrDefData(tableParam, params.getPage(), params.getRows());
    }

    /**
     * 데이터 저장
     */
    @Override
    public Result insertOpenDsUsrDef(Params params) {

        Params tableParam = new Params();
        tableParam.put("dsId", params.getString("dsId"));

        List<Record> columnDataList = new ArrayList<Record>();
        Record columnData = null;

        try {

            //sql 삽입 보안취약점
            // 스키마 조회
            tableParam.put("ownerCd", UtilString.SQLInjectionFilter2(openDsUsrDefInputDao.selectOpenDsUsrOwnerCd(tableParam)));

            // 테이블명 조회
            tableParam.put("tableName", UtilString.SQLInjectionFilter2(openDsUsrDefInputDao.selectOpenDsUsrTableName(tableParam)));

            // 컬럼명 조회
            List<Record> columnNames = (List<Record>) openDsUsrDefInputDao.selectOpenDsUsrColumnNames(params);
            ArrayList<String> arrColumnNames = new ArrayList<String>();
            for (Record r : columnNames) {
                arrColumnNames.add(UtilString.SQLInjectionFilter2(r.getString("columnName")));
            }

            // 날짜 컬럼 조회
            List<Record> dateColumns = (List<Record>) openDsUsrDefInputDao.selectOpenDsDateCol(params);

            // 컬럼데이터 FOR LOOP.. 하여 데이터 조회
            for (String col : arrColumnNames) {

                columnData = new Record();

                if (dateColumns.size() > 0) {
                    // 날짜 컬럼인지 확인
                    for (Record date : dateColumns) {
                        if (StringUtils.equals(col, date.getString("srcColId"))) {
                            columnData.put("isDate", "Y");
                        } else {
                            columnData.put("isDate", "N");
                        }
                    }
                } else {
                    columnData.put("isDate", "N");
                }

                columnData.put("value", params.getString(col));

                columnDataList.add(columnData);
            }

            tableParam.put("columnNames", arrColumnNames);    // 컬럼정보

            tableParam.put("dataValues", columnDataList);    // 데이터 정보

            // 입력시 자기가 속한부서 입력
            if (EgovUserDetailsHelper.isAuthenticated()) {
                CommUsr loginVO = (CommUsr) EgovUserDetailsHelper.getAuthenticatedUser();
                tableParam.put("inpOrgCd", loginVO.getOrgCd());    // 로그인 된 부서코드
            }

            tableParam.put("regId", params.getInt("regId"));

            openDsUsrDefInputDao.insertOpenDsUsrDef(tableParam);

            params.put("dataSeqceNo", tableParam.getInt("dataSeqceNo"));
            saveOpenUsrDefFile(params);

        } catch (SystemException e) {
            EgovWebUtil.exTransactionLogging(e);
            throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
            throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
        }

        return success(getMessage("admin.message.000003"));
    }

    /**
     * 파일 데이터 저장
     *
     * @param params
     */
    public void saveOpenUsrDefFile(Params params) {

        Record record = null;

        try {

            String dsId = params.getString("dsId");
            String ownerCd = openDsUsrDefInputDao.selectOpenDsUsrOwnerCd(params);
            int dataSeqceNo = params.getInt("dataSeqceNo");


            JSONArray jsonArray = new JSONObject(params.getJsonObject("ibsSaveJson")).getJSONArray("data");

            if (jsonArray.length() > 0) {

                for (int i = 0; i < jsonArray.length(); i++) {
                    JSONObject jsonObj = (JSONObject) jsonArray.get(i);

                    String status = jsonObj.getString(ModelAttribute.ACTION_STATUS);

                    record = new Record();
                    record.put("dsId", dsId);
                    // sql 삽입 보안취약점
                    record.put("ownerCd", UtilString.SQLInjectionFilter2(ownerCd));
                    record.put("dataSeqceNo", jsonObj.getInt("dataSeqceNo"));
                    record.put("regId", params.getString("regId"));
                    record.put("srcFileNm", jsonObj.getString("srcFileNm"));
                    record.put("saveFileNm", jsonObj.getString("saveFileNm"));
                    record.put("viewFileNm", jsonObj.getString("viewFileNm"));
                    record.put("fileSize", jsonObj.getInt("fileSize"));
                    record.put("fileExt", jsonObj.getString("fileExt"));

                    // temp 폴더에 있는파일을 dataSeqceNo 폴더로 복사
                    if (StringUtils.equals(status, ModelAttribute.ACTION_INS) && record.getInt("dataSeqceNo") == 0) {
                        // 마스터 데이터가 등록되지 않았을때 추가한경우 dataSeqceNo가 params로 데이터가 넘어온다.(데이터 신규등록인경우)
                        copyAtchFile(dataSeqceNo, record);

                        openDsUsrDefInputDao.insertOpenDsUsrDefFile(record);
                    } else if (StringUtils.equals(status, ModelAttribute.ACTION_INS)) {
                        // 데이터 수정인경우 시트에 dataSeqceNo 사용
                        copyAtchFile(jsonObj.getInt("dataSeqceNo"), record);

                        openDsUsrDefInputDao.insertOpenDsUsrDefFile(record);
                    } else if (StringUtils.equals(status, ModelAttribute.ACTION_UPD)) {
                        record.put("fileSeq", jsonObj.getInt("fileSeq"));
                        openDsUsrDefInputDao.updateOpenDsUsrDefFile(record);
                    } else if (StringUtils.equals(status, ModelAttribute.ACTION_DEL)) {
                        record.put("fileSeq", jsonObj.getInt("fileSeq"));
                        openDsUsrDefInputDao.deleteOpenDsUsrDefFile(record);
                    }
                }
            }

        } catch (DataAccessException dae) {
            EgovWebUtil.exTransactionLogging(dae);
            throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
            throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
        }
    }

    /**
     * temp 폴더에 있는파일을 dataSeqceNo 폴더로 복사
     *
     * @param dataSeqceNo 데이터 시퀀스 번호
     * @param record      반환될 레코드
     */
    private void copyAtchFile(int dataSeqceNo, Record record) {

//		String srcFilePath = makeFilePath(String.valueOf(dataSeqceNo));
        String srcFilePath = makeFilePath(record.getString("dsId"));
        String destFilePath = makeFilePath("");

        // 데이터 파일번호를 획득한다.(MAX+1)
        // sql 삽입 보안취약점
        Params fileSeqParam = new Params();
        fileSeqParam.put("ownerCd", UtilString.SQLInjectionFilter2(record.getString("ownerCd")));
        fileSeqParam.put("dataSeqceNo", dataSeqceNo);
        int fileSeq = openDsUsrDefInputDao.selectOpenDsUsrDefFileSeq(fileSeqParam);

        StringBuffer saveFileNmBuff = new StringBuffer();
        saveFileNmBuff.append(dataSeqceNo).append("_").append(String.valueOf(fileSeq));
        saveFileNmBuff.append(".").append(record.getString("fileExt"));

        String destFile = EgovWebUtil.folderPathReplaceAll(srcFilePath + File.separator + saveFileNmBuff.toString());
        String srcFile = EgovWebUtil.folderPathReplaceAll(destFilePath + File.separator + record.getString("saveFileNm"));    // temp 폴더에 있는 복사될 파일(원본파일)

        try {
            // 파일 복사
            FileUtils.copyFile(new File(srcFile), new File(destFile));

        } catch (IOException e) {
            EgovWebUtil.exLogging(e);
            throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
            throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
        }

        record.put("dataSeqceNo", dataSeqceNo);
        record.put("fileSeq", fileSeq);
        record.put("saveFileNm", saveFileNmBuff.toString());
    }

    /**
     * 데이터 저장
     */
    @Override
    public Result updateOpenDsUsrDef(Params params) {
        List<Record> updList = new ArrayList<Record>();
        Record updMap = null;

        Params tableParam = new Params();
        tableParam.put("dsId", params.getString("dsId"));
        tableParam.put("dataSeqceNo", params.getString("dataSeqceNo"));

        try {
            //sql 삽입 보안취약점
            // 스키마 조회
            tableParam.put("ownerCd", UtilString.SQLInjectionFilter2(openDsUsrDefInputDao.selectOpenDsUsrOwnerCd(tableParam)));

            // 테이블명 조회
            tableParam.put("tableName", UtilString.SQLInjectionFilter2(openDsUsrDefInputDao.selectOpenDsUsrTableName(tableParam)));

            // 컬럼명 조회
            List<Record> columnNames = (List<Record>) openDsUsrDefInputDao.selectOpenDsUsrColumnNames(params);

            // 날짜 컬럼 조회
            List<Record> dateColumns = (List<Record>) openDsUsrDefInputDao.selectOpenDsDateCol(params);

            ArrayList<String> arrColumnNames = new ArrayList<String>();

            // 컬럼데이터 FOR LOOP.. 하여 데이터 등록
            for (Record r : columnNames) {
                arrColumnNames.add(UtilString.SQLInjectionFilter2(r.getString("columnName")));

                updMap = new Record();    // 레코드 한개씩 생성

                // 컬럼명
                String columnName = r.getString("columnName");

                //날짜 컬럼이 아예 없을경우 default 값
                updMap.put("isDate", "N");

                // 날짜 컬럼 있는지 확인
                for (Record date : dateColumns) {
                    if (StringUtils.equals(columnName, date.getString("srcColId"))) {
                        updMap.put("isDate", "Y");
                    } else {
                        updMap.put("isDate", "N");
                    }
                }

                updMap.put("colNm", UtilString.SQLInjectionFilter2(columnName));
                updMap.put("value", params.getString(columnName));
                updList.add(updMap);    // 리스트에 담는다.
            }

            tableParam.put("updList", updList);

            tableParam.put("regId", params.getInt("regId"));

            openDsUsrDefInputDao.updateOpenDsUsrDef(tableParam);

            // 파일 저장
            saveOpenUsrDefFile(params);

        } catch (SystemException e) {
            EgovWebUtil.exTransactionLogging(e);
            throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
            throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
        }

        return success(getMessage("admin.message.000004"));
    }

    /**
     * 데이터를 삭제한다.
     */
    @Override
    public Result deleteOpenDsUsrDef(Params params) {
        try {

            // sql 삽입 보안취약점
            params.put("ownerCd", UtilString.SQLInjectionFilter2(openDsUsrDefInputDao.selectOpenDsUsrOwnerCd(params)));
            params.put("tableName", UtilString.SQLInjectionFilter2(openDsUsrDefInputDao.selectOpenDsUsrTableName(params)));

            openDsUsrDefInputDao.deleteOpenDsUsrDef(params);

            openDsUsrDefInputDao.deleteOpenDsUsrDefFileAll(params);

        } catch (SystemException e) {
            EgovWebUtil.exTransactionLogging(e);
            throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
            throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
        }

        return success(getMessage("admin.message.000005"));
    }

    /**
     * 파일 저장
     */
    public Object insertOpenUsrDefFile(HttpServletRequest request, Params params) {
        Record result = new Record();
        FileOutputStream fis = null;
        String saveFileNm = "";

        try {

            MultipartFile file = params.getFile("atchFile");

            if (file.getSize() > 0) {

                // 디렉토리 정보
//				String directoryPath = makeFilePath(dataSeqceNo);
                String directoryPath = makeFilePath("");

                // 파일정보
                String srcFileNm = file.getOriginalFilename();                // 원본 파일명
                String fileExt = FilenameUtils.getExtension(srcFileNm);        // 파일 확장자
                long fileSize = file.getSize();                                // 파일사이즈

                String uuid = UUID.randomUUID().toString().replaceAll("-", "");        // UNIQUE ID
                saveFileNm = uuid + "." + fileExt;                    // 저장파일명(고유ID)

                fis = new FileOutputStream(EgovWebUtil.filePathBlackList(directoryPath + File.separator + saveFileNm));
                InputStream stream = file.getInputStream();
                int bytesRead = 0;
                byte[] buffer = new byte[2048];

                while ((bytesRead = stream.read(buffer, 0, 2048)) != -1) {
                    fis.write(buffer, 0, bytesRead);
                }

                result.put("RESULT", 1);
                result.put("srcFileNm", srcFileNm);
                result.put("saveFileNm", saveFileNm);
                result.put("viewFileNm", params.getString("viewFileNm") + "." + fileExt);
                result.put("fileExt", fileExt);
                result.put("fileSize", fileSize);
//			    result.put("fileSize", FileUtils.byteCountToDisplaySize(fileSize));
            } else {
                result.put("RESULT", -1);
            }

        } catch (SystemException e) {
            EgovWebUtil.exLogging(e);
            throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
            throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
        } finally {
            try {
                if (fis != null) {
                    fis.close();
                }
            } catch (FileNotFoundException e) {
                EgovWebUtil.exLogging(e);
            } catch (Exception e) {
                EgovWebUtil.exLogging(e);
            }
        }

        return result;
    }

    /**
     * 파일 저장시 폴더 생성
     *
     * @param dataSeqceNo ==> dsId로 변경
     * @param dsId
     * @return
     */
//	private String makeFilePath(String dataSeqceNo) {
    private String makeFilePath(String dsId) {

        try {

            String directoryPath = EgovProperties.getProperty("Globals.openUsrDefFilePath");
            directoryPath = EgovWebUtil.folderPathReplaceAll(directoryPath);


            if (StringUtils.isNotBlank(dsId)) {
                directoryPath = EgovWebUtil.folderPathReplaceAll(directoryPath + dsId);
                File directory = new File(directoryPath);
                // 수정 : 권한 설정
                directory.setExecutable(true, true);
                directory.setReadable(true);
                directory.setWritable(true, true);

                if (!directory.exists()) {
                    directory.mkdirs();
                }
            }
            // 데이터 고유번호가 없는경우 temp 폴더에 먼저 저장한뒤 데이터 등록 액션에 왔을경우 temp폴더에 있는 dataSeqceNo 폴더로 파일을 옮겨준다.
            else {
                directoryPath = EgovWebUtil.folderPathReplaceAll(directoryPath + "temp");
                File directory = new File(directoryPath);
                // 수정 : 권한 설정
                directory.setExecutable(true, true);
                directory.setReadable(true);
                directory.setWritable(true, true);

                if (!directory.exists()) {
                    directory.mkdirs();
                }
            }

            return directoryPath;
        } catch (SystemException e) {
            EgovWebUtil.exLogging(e);
            throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
            throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
        }

    }

    /**
     * 데이터 첨부파일을 조회한다.
     */
    @Override
    public List<Record> selectOpenUsrDefFile(Params params) {
        // sql 삽입 보안취약점
        params.put("ownerCd", UtilString.SQLInjectionFilter2(openDsUsrDefInputDao.selectOpenDsUsrOwnerCd(params)));
        return (List<Record>) openDsUsrDefInputDao.selectOpenDsUsrDefFile(params);

    }

    /**
     * 첨부 파일 다운로드
     */
    @Override
    public Record downloadOpenUsrDefFile(Params params) {

        // DB 사용자 분류 조회(데이터 스키마)
        params.put("valueCd", "OD");
        String ownerCd = openDsUsrDefInputDao.selectOpenDsUsrOwnerCdByCommCd(params);
        params.put("ownerCd", ownerCd);

        // validation
        String fileSeq = params.getString("fileSeq");

        if (StringUtils.isEmpty(ownerCd) && StringUtils.isEmpty(fileSeq)) {
            throw new SystemException("잘못된 요청입니다.");
        }

        // 파일 정보 확인
        List<Record> fileList = (List<Record>) openDsUsrDefInputDao.selectOpenDsUsrDefFile(params);
        if (fileList.size() == 0) {
            throw new SystemException("파일이 존재하지 않습니다.");
        }

        Record record = fileList.get(0);

        // 디렉토리 확인
        String directoryPath = EgovProperties.getProperty("Globals.openUsrDefFilePath");
        directoryPath = EgovWebUtil.folderPathReplaceAll(directoryPath);
        StringBuffer fileBuffer = new StringBuffer(directoryPath);
        fileBuffer.append(File.separator).append(record.getString("dsId"));
        fileBuffer.append(File.separator).append(record.getString("saveFileNm"));

        // 파일 다운로드뷰 파라미터 생성
        Record file = new Record();
        file.put(FileDownloadView.FILE_PATH, fileBuffer.toString());
        file.put(FileDownloadView.FILE_NAME, record.getString("viewFileNm"));
        file.put(FileDownloadView.FILE_SIZE, record.getString("fileSize"));

        return file;
    }

    /**
     * 첨부파일 순서저장
     */
    @Override
    public Result saveOpenUsrDefFileOrder(Params params) {
        Params[] data = params.getJsonArray(Params.SHEET_DATA);
        try {
            // DB 사용자 분류 조회(데이터 스키마)
            params.put("valueCd", "OD");
            String ownerCd = openDsUsrDefInputDao.selectOpenDsUsrOwnerCdByCommCd(params);

            for (int i = 0; i < data.length; i++) {
                if (StringUtils.equals(Params.STATUS_UPDATE, data[i].getString("Status"))) {
                    data[i].put("ownerCd", ownerCd);
                    openDsUsrDefInputDao.saveOpenUsrDefFileOrder(data[i]);
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

    /**
     * 첨부파일 삭제
     */
    @Override
    public Result deleteOpenUsrDefFile(Params params) {
        Params[] data = params.getJsonArray(Params.SHEET_DATA);
        Record fileData = null;

        try {
            // DB 사용자 분류 조회(데이터 스키마)
            params.put("valueCd", "OD");
            String ownerCd = openDsUsrDefInputDao.selectOpenDsUsrOwnerCdByCommCd(params);

            for (int i = 0; i < data.length; i++) {
                if (StringUtils.equals(Params.STATUS_DELETE, data[i].getString("Status"))) {
                    fileData = new Record();
                    fileData.put("ownerCd", ownerCd);
                    fileData.put("dataSeqceNo", data[i].getString("dataSeqceNo"));
                    fileData.put("fileSeq", data[i].getString("fileSeq"));
                    openDsUsrDefInputDao.deleteOpenDsUsrDefFile(fileData);
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

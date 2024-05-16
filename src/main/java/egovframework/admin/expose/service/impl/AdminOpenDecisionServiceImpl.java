package egovframework.admin.expose.service.impl;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.admin.expose.service.AdminExposeInfoService;
import egovframework.admin.expose.service.AdminOpenDecisionService;
import egovframework.admin.expose.service.AdminNasSendInfoService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.common.DocToPdfGenerator;
import egovframework.common.TSGenerator;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.exception.SystemException;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Result;
import egovframework.common.base.service.BaseService;
import egovframework.common.util.UtilString;

/**
 * 정보공개관리하는 서비스
 *
 * @author 최성빈
 * @version 1.0
 * @since 2019/07/29
 */

@Service(value = "adminOpenDecisionService")
public class AdminOpenDecisionServiceImpl extends BaseService implements AdminOpenDecisionService {

    public static final int BUFF_SIZE = 2048;

    @Resource(name = "adminExposeInfoService")
    protected AdminExposeInfoService adminExposeInfoService;

    @Resource(name = "adminOpenDecisionDao")
    protected AdminOpenDecisionDao adminOpenDecisionDao;

    @Resource(name = "adminNasSendInfoService")
    protected AdminNasSendInfoService adminNasSendInfoService;

    @Resource(name = "adminExposeInfoDao")
    protected AdminExposeInfoDao adminExposeInfoDao;

    /**
     * 공개결정내역  리스트 조회
     */
    @Override
    public Paging searchOpnDcsPaging(Params params) {

        return adminOpenDecisionDao.searchOpnDcsPaging(params, params.getPage(), params.getRows());
    }

    /**
     * 공개결정내역 > 정보공개접수 조회
     */
    @Override
    public Map<String, Object> writeOpnDcs(Map<String, String> paramMap) {
        Map<String, Object> rMap = new HashMap<String, Object>();
        Map<String, Object> dataMap = new HashMap<String, Object>();

        Params params = new Params();
        dataMap.put("prgStatCd", paramMap.get("prgStatCd")); //상태값을 넘겨 화면을 컨트롤한다.

        try {
            params.put("lclsCd", "F"); // 비공개사유
            dataMap.put("clsdRsonCodeList", adminExposeInfoService.selectComCode(params));
            params.put("lclsCd", "A"); // 공개방법
            dataMap.put("opbFomCodeList", adminExposeInfoService.selectComCode(params));
            params.put("lclsCd", "B"); // 교부방법
            dataMap.put("giveMthCodeList", adminExposeInfoService.selectComCode(params));

            paramMap.put("apl_no", paramMap.get("aplNo"));

            dataMap.put("OPNZ_HIST", (List<Map<String, Object>>) adminExposeInfoDao.selectOpnzHist(paramMap)); //청구상태이력조회

            if (paramMap.get("srcAplNo") != null && paramMap.get("srcAplNo") != "") {
                dataMap.put("FROM_TRST", (List<Map<String, Object>>) adminExposeInfoDao.selectFromTrst(paramMap)); //이송받은정보 조회
            } else {
                dataMap.put("FROM_TRST", "");
            }
            dataMap.put("TO_TRST", (List<Map<String, Object>>) adminExposeInfoDao.selectToTrst(paramMap)); //이송보낸정보 조회

            //정보공개 결정내역 상세 > 비공개사유 정보
            dataMap.put("clsdList", adminOpenDecisionDao.selectOpnDcsClsd(params));

            rMap.put("DATA", adminOpenDecisionDao.writeOpnDcs(paramMap));
            rMap.put("DATA2", dataMap);

        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return rMap;
    }

    /**
     * 공개결정내역 상세 조회
     */
    @Override
    public Map<String, Object> detailOpnDcs(Map<String, String> paramMap) {
        Map<String, Object> rMap = new HashMap<String, Object>();
        Map<String, Object> dataMap = new HashMap<String, Object>();

        Params params = new Params();
        dataMap.put("prgStatCd", paramMap.get("prgStatCd")); //상태값을 넘겨 화면을 컨트롤한다.
        try {
            params.put("lclsCd", "F"); // 비공개사유
            dataMap.put("clsdRsonCodeList", adminExposeInfoService.selectComCode(params));
            params.put("lclsCd", "A"); // 공개방법
            dataMap.put("opbFomCodeList", adminExposeInfoService.selectComCode(params));
            params.put("lclsCd", "B"); // 교부방법
            dataMap.put("giveMthCodeList", adminExposeInfoService.selectComCode(params));

            dataMap.put("OPNZ_HIST", (List<Map<String, Object>>) adminExposeInfoDao.selectOpnzHist(paramMap)); //청구상태이력조회

            if (paramMap.get("srcAplNo") != null && paramMap.get("srcAplNo") != "") {
                dataMap.put("FROM_TRST", (List<Map<String, Object>>) adminExposeInfoDao.selectFromTrst(paramMap)); //이송받은정보 조회
            } else {
                dataMap.put("FROM_TRST", "");
            }
            dataMap.put("TO_TRST", (List<Map<String, Object>>) adminExposeInfoDao.selectToTrst(paramMap)); //이송보낸정보 조회

            paramMap.put("apl_no", paramMap.get("aplNo"));
            params.put("apl_no", paramMap.get("aplNo"));

            rMap.put("DATA", adminOpenDecisionDao.detailOpnDcs(paramMap));
            dataMap.put("clsdList", adminOpenDecisionDao.selectOpnDcsClsd(params));
            rMap.put("DATA2", dataMap);

        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return rMap;
    }

    /**
     * 공개결정내역 데이터를 등록한다.
     *
     * @param params 파라메터
     * @return 등록결과
     */
    @Override
    public Object saveOpnDcs(HttpServletRequest request, Params params) {
        final MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
        String msg = "";

        try {
            //저장 디렉토리
            String directoryPath = EgovProperties.getProperty("Globals.OpnzAplFilePath");
            directoryPath = EgovWebUtil.folderPathReplaceAll(directoryPath);

            File dir = new File(directoryPath);
            // 수정 : 권한 설정
            dir.setExecutable(true, true);
            dir.setReadable(true);
            dir.setWritable(true, true);

            if (!dir.isDirectory()) {
                dir.mkdir();
            }

            // 저장 파일 맵
            Map<String, MultipartFile> fileMap = multiRequest.getFileMap();
            // saveKey에 맞게 파일이 있을경우 해당 파일 저장
            for (String saveKey : fileMap.keySet()) {

                MultipartFile file = fileMap.get(saveKey);

                if (file.getSize() > 0) {
                    String srcFileNm = file.getOriginalFilename();                            //원본 파일명
                    String srcFileNmCut = FilenameUtils.getBaseName(srcFileNm);            // 확장자 제외한 파일명
                    String fileExt = FilenameUtils.getExtension(srcFileNm);                //파일 확장자

                    String uniqFileNm = Long.toString((new Date()).getTime());
                    String filePhNm = uniqFileNm + "." + fileExt;///저장파일명

                    if (StringUtils.equals(fileExt, "xls") || StringUtils.equals(fileExt, "xlsx") || StringUtils.equals(fileExt, "doc") || StringUtils.equals(fileExt, "docx")
                            || StringUtils.equals(fileExt, "hwp") || StringUtils.equals(fileExt, "txt") || StringUtils.equals(fileExt, "ppt") || StringUtils.equals(fileExt, "pptx")
                            || StringUtils.equals(fileExt, "pdf") || StringUtils.equals(fileExt, "zip") || StringUtils.equals(fileExt, "rar")) {
                        // PASS
                    } else {
                        throw new SystemException("업로드가 제한된 확장자 입니다.");
                    }

                    if (saveKey.equals("file")) { //제3자의견등록 첨부파일
                        params.set("third_opn_flnm", srcFileNm);
                        params.set("third_opn_flph", filePhNm);
                    }

                    if (saveKey.equals("file1")) { //심의회 관리 첨부파일
                        params.set("dbrt_inst_flnm", srcFileNm);
                        params.set("dbrt_inst_flph", filePhNm);
                    }

                    if (saveKey.equals("clsdFile")) { //비공개 첨부파일 > PDF변환? timestamp발급?
                        params.set("clsd_attch_fl_nm", srcFileNm);
                        params.set("clsd_attch_fl_ph_nm", filePhNm);
                    }

                    if (saveKey.equals("imd_file")) { //즉시처리 첨부파일 > PDF변환? timestamp발급?
                        params.set("imd_fl_nm", srcFileNm);
                        params.set("imd_fl_ph", filePhNm);
                    }

                    if (saveKey.equals("non_file")) { // 부존재 첨부파일 > PDF변환? timestamp발급?
                        params.set("non_fl_nm", srcFileNm);
                        params.set("non_fl_ph", filePhNm);
                    }

                    params.set(saveKey, filePhNm);

                    if (!"".equals(filePhNm)) {
                        OutputStream bos = null;
                        try {
                            bos = new FileOutputStream(EgovWebUtil.filePathBlackList(directoryPath + File.separator + filePhNm));
                            InputStream stream = file.getInputStream();
                            int bytesRead = 0;
                            byte[] buffer = new byte[BUFF_SIZE];

                            while ((bytesRead = stream.read(buffer, 0, BUFF_SIZE)) != -1) {
                                bos.write(buffer, 0, bytesRead);
                            }

                            if (StringUtils.equals(fileExt, "xls") || StringUtils.equals(fileExt, "xlsx") || StringUtils.equals(fileExt, "doc") || StringUtils.equals(fileExt, "docx")
                                    || StringUtils.equals(fileExt, "hwp") || StringUtils.equals(fileExt, "txt") || StringUtils.equals(fileExt, "ppt") || StringUtils.equals(fileExt, "pptx")) {

                                if (saveKey.equals("clsdFile") || saveKey.equals("imd_file") || saveKey.equals("non_file")) {
                                    boolean pdfResult = DocToPdfGenerator.generate(EgovWebUtil.filePathBlackList(directoryPath), uniqFileNm, fileExt);

                                    if (!pdfResult) {
                                        throw new SystemException("PDF 파일 변환중 오류가 발생하였습니다.");
                                    }

                                    String tsFile = EgovWebUtil.filePathBlackList(directoryPath) + uniqFileNm + ".pdf";

                                    boolean tsResult = TSGenerator.generate(tsFile, tsFile);
                                    if (!tsResult) {
                                        throw new SystemException("TIMESTAMP 발급도중 오류가 발생하였습니다.");
                                    }

                                    // DB 저장값 재정의
                                    if (saveKey.equals("clsdFile")) { //비공개 첨부파일
                                        params.set("clsd_attch_fl_nm", srcFileNmCut + ".pdf");
                                        params.set("clsd_attch_fl_ph_nm", uniqFileNm + ".pdf");
                                    }

                                    if (saveKey.equals("imd_file")) { //즉시처리 첨부파일
                                        params.set("imd_fl_nm", srcFileNmCut + ".pdf");
                                        params.set("imd_fl_ph", uniqFileNm + ".pdf");
                                    }

                                    if (saveKey.equals("non_file")) { // 부존재 첨부파일
                                        params.set("non_fl_nm", srcFileNmCut + ".pdf");
                                        params.set("non_fl_ph", uniqFileNm + ".pdf");
                                    }
                                }
                            } else if (StringUtils.equals(fileExt, "pdf")) {
                                String tsFile = EgovWebUtil.filePathBlackList(directoryPath + File.separator + filePhNm);

                                boolean tsResult = TSGenerator.generate(tsFile, tsFile);
                                if (!tsResult) {
                                    throw new SystemException("TIMESTAMP 발급도중 오류가 발생하였습니다.");
                                }

                                // DB 저장값 재정의
                                if (saveKey.equals("clsdFile")) { //비공개 첨부파일
                                    params.set("clsd_attch_fl_nm", srcFileNmCut + ".pdf");
                                    params.set("clsd_attch_fl_ph_nm", uniqFileNm + ".pdf");
                                }

                                if (saveKey.equals("imd_file")) { //즉시처리 첨부파일
                                    params.set("imd_fl_nm", srcFileNmCut + ".pdf");
                                    params.set("imd_fl_ph", uniqFileNm + ".pdf");
                                }

                                if (saveKey.equals("non_file")) { // 부존재 첨부파일
                                    params.set("non_fl_nm", srcFileNmCut + ".pdf");
                                    params.set("non_fl_ph", uniqFileNm + ".pdf");
                                }
                            }
                        } catch (SystemException | IOException se) {
                            EgovWebUtil.exLogging(se);
                        } finally {
                            try {
                                if (bos != null) bos.close();
                            } catch (IOException ioe) {
                                EgovWebUtil.exLogging(ioe);
                            }
                        }
                    }
                } else {
                    // 파일이 없는 경우 DB값 null 처리
                    params.set(saveKey, "");
                }
            }

            //즉시처리 일 경우
            if (params.getString("imd_deal_div").equals("1")) {
                params.put("opb_fom", ""); //공개방법의 공개형태
                params.put("give_mth", ""); //공개방법의 교부방법

                //결정권자 정보 없앤다.
                params.put("inst_pno", "");
                params.put("inst_fax_no", "");
                params.put("inst_chrg_dept_nm", "");
                params.put("inst_chrg_cent_cgp_1_nm", "");
                params.put("inst_chrg_cent_cgp_2_nm", "");
                params.put("inst_chrg_cent_cgp_3_nm", "");
            }

            //공개일자의 -값을 없앤다.
            params.put("opb_dtm", params.getString("opb_dtm").replaceAll("-", ""));

            String count = adminOpenDecisionDao.getInfoOpenDcsSeqCount(params);
            params.put("processCnt", count); //기등록 여부 확인
            if (Integer.parseInt(count) > 0) { //테이블에 있으면 수정
                adminOpenDecisionDao.updateInfoOpnDcsWrite(params);
                msg = "결정통지가 수정되었습니다.";
            } else { //테이블에 없으면 등록
                adminOpenDecisionDao.insertInfoOpnDcsWrite(params);
                msg = "결정통지가 등록되었습니다.";

                //정보공개청구 결정통지를 청구인에게 SMS/메일 발송 (수정시 발송X)
                //공통 발송을 위해 설정값을 전달한다.
                params.put("typeNm", "결정통지");
                params.put("typeNum", 0);
                params.put("aplNo", params.getString("apl_no"));
                adminNasSendInfoService.exposeProcSend(request, params);
            }

            //비공개 내용 및 사유를 확인하여 저장한다.
            String[] clsdRmks = params.getStringArray("clsd_rmk");
            String[] clsdRsonCds = params.getStringArray("clsd_rson_cd");
            String[] clsdRsons = params.getStringArray("clsd_rson");

            if (clsdRmks.length > 0) {
                adminOpenDecisionDao.deleteOpnDcsClsd(params);

                for (int i = 0; i < clsdRmks.length; i++) {
                    params.put("clsdNo", i + 1);
                    params.put("clsdRmk", clsdRmks[i]);
                    params.put("clsdRsonCd", clsdRsonCds[i]);
                    params.put("clsdRson", clsdRsons[i]);

                    adminOpenDecisionDao.insertOpnDcsClsd(params);
                }
            }

        } catch (ServiceException sve) {
            EgovWebUtil.exTransactionLogging(sve);
            throw new SystemException("admin.error.000001", getMessage("admin.error.000001"));
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
            throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
        }


        return success(msg);
    }

    /**
     * 공개결정통보내역 공개실시
     *
     * @param params 파라메터
     * @return 등록결과
     */
    @Override
    public Object openStartOpnDcs(HttpServletRequest request, Params params) {
        final MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;

        try {
            //저장 디렉토리
            String directoryPath = EgovProperties.getProperty("Globals.OpnzAplFilePath");
            directoryPath = EgovWebUtil.folderPathReplaceAll(directoryPath);

            File dir = new File(directoryPath);
            // 수정 : 권한 설정
            dir.setExecutable(true, true);
            dir.setReadable(true);
            dir.setWritable(true, true);

            if (!dir.isDirectory()) {
                dir.mkdir();
            }

            // 저장 파일 맵
            Map<String, MultipartFile> fileMap = multiRequest.getFileMap();
            // saveKey에 맞게 파일이 있을경우 해당 파일 저장
            for (String saveKey : fileMap.keySet()) {

                MultipartFile file = fileMap.get(saveKey);

                if (file.getSize() > 0) {
                    String srcFileNm = file.getOriginalFilename();                            //원본 파일명
                    String srcFileNmCut = FilenameUtils.getBaseName(srcFileNm);                // 확장자 제외한 파일명

                    String uniqFileNm = Long.toString((new Date()).getTime());
                    String fileExt = FilenameUtils.getExtension(srcFileNm);                //파일 확장자
                    String filePhNm = uniqFileNm + "." + fileExt;            ///저장파일명


                    if (StringUtils.equals(fileExt, "xls") || StringUtils.equals(fileExt, "xlsx") || StringUtils.equals(fileExt, "doc") || StringUtils.equals(fileExt, "docx")
                            || StringUtils.equals(fileExt, "hwp") || StringUtils.equals(fileExt, "txt") || StringUtils.equals(fileExt, "ppt") || StringUtils.equals(fileExt, "pptx")
                            || StringUtils.equals(fileExt, "pdf") || StringUtils.equals(fileExt, "zip") || StringUtils.equals(fileExt, "rar")) {
                        // PASS
                    } else {
                        throw new SystemException("업로드가 제한된 확장자 입니다.");
                    }

                    if (saveKey.equals("resultFile1")) { //공개결정 파일1 > PDF변환? timestamp발급?
                        params.set("opb_flnm", srcFileNm);
                        params.set("opb_flph", filePhNm);
                    }

                    if (saveKey.equals("resultFile2")) { //공개결정 파일2 > PDF변환? timestamp발급?
                        params.set("opb_flnm2", srcFileNm);
                        params.set("opb_flph2", filePhNm);
                    }

                    if (saveKey.equals("resultFile3")) { // 공개결정 파일3 > PDF변환? timestamp발급?
                        params.set("opb_flnm3", srcFileNm);
                        params.set("opb_flph3", filePhNm);
                    }

                    params.set(saveKey, filePhNm);

                    OutputStream bos = null;
                    try {
                        bos = new FileOutputStream(EgovWebUtil.filePathBlackList(directoryPath + File.separator + filePhNm));
                        InputStream stream = file.getInputStream();
                        int bytesRead = 0;
                        byte[] buffer = new byte[BUFF_SIZE];

                        while ((bytesRead = stream.read(buffer, 0, BUFF_SIZE)) != -1) {
                            bos.write(buffer, 0, bytesRead);
                        }


                        if (StringUtils.equals(fileExt, "xls") || StringUtils.equals(fileExt, "xlsx") || StringUtils.equals(fileExt, "doc") || StringUtils.equals(fileExt, "docx")
                                || StringUtils.equals(fileExt, "hwp") || StringUtils.equals(fileExt, "txt") || StringUtils.equals(fileExt, "ppt") || StringUtils.equals(fileExt, "pptx")) {

                            // 한글파일 PDF 변환
                            boolean pdfResult = DocToPdfGenerator.generate(EgovWebUtil.filePathBlackList(directoryPath), uniqFileNm, fileExt);
                            if (!pdfResult) {
                                throw new SystemException("PDF 파일 변환중 오류가 발생하였습니다.");
                            }

                            String tsFile = EgovWebUtil.filePathBlackList(directoryPath) + uniqFileNm + ".pdf";

                            boolean tsResult = TSGenerator.generate(tsFile, tsFile);
                            if (!tsResult) {
                                throw new SystemException("TIMESTAMP 발급도중 오류가 발생하였습니다.");
                            }

                            // DB 저장값 재정의
                            if (saveKey.equals("resultFile1")) { //공개결정 파일1
                                params.set("opb_flnm", srcFileNmCut + ".pdf");
                                params.set("opb_flph", uniqFileNm + ".pdf");
                            }
                            if (saveKey.equals("resultFile2")) { //공개결정 파일2
                                params.set("opb_flnm2", srcFileNmCut + ".pdf");
                                params.set("opb_flph2", uniqFileNm + ".pdf");
                            }
                            if (saveKey.equals("resultFile3")) { // 공개결정 파일3
                                params.set("opb_flnm3", srcFileNmCut + ".pdf");
                                params.set("opb_flph3", uniqFileNm + ".pdf");
                            }
                        } else if (StringUtils.equals(fileExt, "pdf")) {
                            String tsFile = EgovWebUtil.filePathBlackList(directoryPath + File.separator + filePhNm);

                            boolean tsResult = TSGenerator.generate(tsFile, tsFile);
                            if (!tsResult) {
                                throw new SystemException("TIMESTAMP 발급도중 오류가 발생하였습니다.");
                            }

                            // DB 저장값 재정의
                            if (saveKey.equals("resultFile1")) { //공개결정 파일1
                                params.set("opb_flnm", srcFileNmCut + ".pdf");
                                params.set("opb_flph", uniqFileNm + ".pdf");
                            }
                            if (saveKey.equals("resultFile2")) { //공개결정 파일2
                                params.set("opb_flnm2", srcFileNmCut + ".pdf");
                                params.set("opb_flph2", uniqFileNm + ".pdf");
                            }
                            if (saveKey.equals("resultFile3")) { // 공개결정 파일3
                                params.set("opb_flnm3", srcFileNmCut + ".pdf");
                                params.set("opb_flph3", uniqFileNm + ".pdf");
                            }
                        }
                    } catch (SystemException sve) {
                        EgovWebUtil.exLogging(sve);
                        throw new SystemException(sve.getMessage());
                    } catch (IOException ioe) {
                        EgovWebUtil.exLogging(ioe);
                    } finally {
                        try {
                            if (bos != null) bos.close();
                        } catch (IOException ioe) {
                            EgovWebUtil.exLogging(ioe);
                        }
                    }
                } else {
                    // 파일이 없는 경우 DB값 null 처리
                    params.set(saveKey, "");
                }
            }

            //공개실시정보 업데이트(파일포함)
            adminOpenDecisionDao.openStartOpnDcs(params);

            if (StringUtils.isEmpty(params.getString("fileUpdateYn"))) {
                //상태 및 이력정보 업데이트
                adminOpenDecisionDao.updateOpnPrgHist(params);

                //정보공개청구 공개실시를 청구인에게 SMS/메일 발송
                //공통 발송을 위해 설정값을 전달한다.
                params.put("typeNm", "자료 등록");
                params.put("typeNum", 15);
                params.put("aplNo", params.getString("apl_no"));
                adminNasSendInfoService.exposeProcSend(request, params);
            }

        } catch (ServiceException sve) {
            EgovWebUtil.exTransactionLogging(sve);
            throw new SystemException("admin.error.000001", getMessage("admin.error.000001"));
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
            throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
        }

        String msg = "공개 되었습니다.";
        return success(msg);
    }

    /**
     * 이의신청내역  리스트 조회
     */
    @Override
    public Paging searchOpnObjtnProcPaging(Params params) {

        return adminOpenDecisionDao.searchOpnObjtnProcPaging(params, params.getPage(), params.getRows());
    }

    /**
     * 오프라인 이의신청시 기본적인 청구인정보
     */
    @Override
    public Map<String, Object> getWriteBaseInfo(Map<String, String> paramMap) {
        Map<String, Object> rMap = new HashMap<String, Object>();
        Map<String, Object> dataMap = new HashMap<String, Object>();

        rMap.put("DATA", adminOpenDecisionDao.getWriteBaseInfo(paramMap));
        rMap.put("DATA2", dataMap);
        return rMap;
    }

    /**
     * 이의신청 수정 (온, 오프라인 이의신청건에 대한 수정 전 신청서 정보)
     */
    @Override
    public Map<String, Object> getUpdateBaseInfo(Map<String, String> paramMap) {
        Map<String, Object> rMap = new HashMap<String, Object>();
        Map<String, Object> dataMap = new HashMap<String, Object>();

        rMap.put("DATA", adminOpenDecisionDao.getUpdateBaseInfo(paramMap));
        rMap.put("DATA2", dataMap);
        return rMap;
    }

    /**
     * 이의신청내역 상세 조회
     */
    @Override
    public Map<String, Object> detailOpnObjtnProc(Map<String, String> paramMap) {
        Map<String, Object> rMap = new HashMap<String, Object>();
        Map<String, Object> dataMap = new HashMap<String, Object>();

        rMap.put("DATA", adminOpenDecisionDao.detailOpnObjtnProc(paramMap));
        rMap.put("DATA2", dataMap);
        return rMap;
    }

    /**
     * 데이터 이전으로 돌리기
     */
    @Override
    public Result cancelOpnProd(HttpServletRequest request, Params params) {
        boolean result = false;

        try {

            String cType = params.getString("cType"); //취소 구분 DCS:결정통지취소, END:통지완료취소
            String imdDealDiv = params.getString("imdDealDiv"); //즉시처리여부

            params.set("apl_no", params.getString("aplNo"));

            String typeNm = "";
            if (cType.equals("DCS")) typeNm = "결정통지취소";
            else typeNm = "통지완료취소";

            if (cType.equals("DCS") || (cType.equals("END") && imdDealDiv.equals("1"))) { //처리중 상태로 보낸다.
                params.put("histDiv", "03");
                params.put("prg_stat_cd", "03"); //03:처리중, 04:결정통지
                params.put("histCn", "관리자에 의해 " + typeNm + " 되었습니다.");
            } else { //결정통지 상태로 보낸다.
                params.put("histDiv", "04");
                params.put("prg_stat_cd", "04"); //03:처리중, 04:결정통지
                params.put("histCn", "관리자에 의해 " + typeNm + " 되었습니다.");
            }

            adminOpenDecisionDao.cancelOpnProd(params);  //취소 처리
            result = true;

            //취소 처리하면 청구인+담당자에게 SMS/메일 발송
            //공통 발송을 위해 설정값을 전달한다.
            params.put("typeNm", typeNm);
            params.put("typeNum", 30);
            if (UtilString.isNull(params.getString("A1"))) params.put("A1", "");
            if (UtilString.isNull(params.getString("A2"))) params.put("A2", "");
            if (UtilString.isNull(params.getString("B1"))) params.put("B1", "");

            if (!params.getString("A1").equals("") || !params.getString("A2").equals("") || !params.getString("B1").equals("")) {
                adminNasSendInfoService.cancelProcSend(request, params);
            }

        } catch (ServiceException sve) {
            EgovWebUtil.exTransactionLogging(sve);
            throw new SystemException("admin.error.000001", getMessage("admin.error.000001"));
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
            throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
        }

        return success(getMessage("admin.message.000007"));    //처리가 완료되었습니다
    }

}

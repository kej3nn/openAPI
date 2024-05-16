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
import egovframework.admin.expose.service.AdminOpenObjectionService;
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

/**
 * 이의신청관리하는 서비스
 *
 * @author SoftOn
 * @version 1.0
 * @since 2019/07/29
 */

@Service(value = "adminOpenObjectionService")
public class AdminOpenObjectionServiceImpl extends BaseService implements AdminOpenObjectionService {

    public static final int BUFF_SIZE = 2048;

    @Resource(name = "adminOpenObjectionDao")
    protected AdminOpenObjectionDao adminOpenObjectionDao;

    @Resource(name = "adminExposeInfoService")
    protected AdminExposeInfoService adminExposeInfoService;

    @Resource(name = "adminNasSendInfoService")
    protected AdminNasSendInfoService adminNasSendInfoService;

    @Resource(name = "adminExposeInfoDao")
    protected AdminExposeInfoDao adminExposeInfoDao;

    @Resource(name = "adminOpenDecisionDao")
    protected AdminOpenDecisionDao adminOpenDecisionDao;

    /**
     * 오프라인 이의신청 가능내역 리스트 조회
     */
    @Override
    public Paging searchOpnObjtnPaging(Params params) {
        Paging list = adminOpenObjectionDao.searchOpnObjtnPaging(params, params.getPage(), params.getRows());

        return list;
    }

    /**
     * 오프라인 이의신청 작성 기본정보 호출
     */
    @Override
    public Map<String, Object> writeOpnObjtn(Map<String, String> paramMap) {
        Map<String, Object> rMap = new HashMap<String, Object>();
        Map<String, Object> dataMap = new HashMap<String, Object>();
        dataMap.put("OPNZ_HIST", (List<Map<String, Object>>) adminOpenObjectionDao.selectOpnzHist(paramMap)); //이의상태이력조회 2020.04.06 김재한

        Params params = new Params();
        params.put("apl_no", paramMap.get("aplNo"));
        //정보공개 결정내역 상세 > 비공개사유 정보
        dataMap.put("clsdList", adminOpenDecisionDao.selectOpnDcsClsd(params));

        rMap.put("DATA", adminOpenObjectionDao.writeOpnObjtn(paramMap));
        rMap.put("DATA2", dataMap);
        return rMap;
    }

    /**
     * 오프라인 이의신청 데이터를 등록한다.
     *
     * @param params 파라메터
     * @return 등록결과
     */
    @Override
    public Object saveOpnObjtn(HttpServletRequest request, Params params) {
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
                    String fileExt = FilenameUtils.getExtension(srcFileNm);                //파일 확장자
                    String filePhNm = (new Date()).getTime() + "." + fileExt;///저장파일명

                    if (saveKey.equals("file")) { //제3자의견등록 첨부파일
                        params.set("objtnAplFlnm", srcFileNm);
                        params.set("objtnAplFlph", filePhNm);
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
                        } catch (IOException ioe) {
                            EgovWebUtil.exLogging(ioe);
                        } finally {
                            try {
                                if (bos != null) bos.close();
                            } catch (IOException ioe) {
                                EgovWebUtil.exLogging(ioe);
                            }
                        }
                    }

                    params.put("apl_attch_delete", "");
                } else {
                    // 파일이 없는 경우 DB값 null 처리
                    params.set(saveKey, "");
                    params.put("apl_attch_delete", "Y");
                }
            }

            //이의신청 다음순번 확인
            String nextObjtnSno = adminOpenObjectionDao.getInfoOpenObjtnSnoNext(params);
            params.put("objtnSno", nextObjtnSno);

            String dcsNtcDt = null;
            if (StringUtils.isEmpty(params.getString("dcsNtcDt"))) {
                dcsNtcDt = params.getString("firstDcsDt").replaceAll("-", "");
            } else {
                dcsNtcDt = params.getString("dcsNtcDt").replaceAll("-", "");
            }
            params.put("dcsNtcDt", dcsNtcDt);

            params.put("objtnRson", "");
            params.put("objtnStatCd", "01");
            params.put("histDiv", "21");
            params.put("histCn", "");

            adminOpenObjectionDao.writeObjtn(params);
            msg = "오프라인 이의신청이 등록되었습니다.";

            //오프라인 이의신청 처리를 청구인에게 SMS/메일 발송
            //공통 발송을 위해 설정값을 전달한다.
            params.put("typeNm", "이의신청");
            params.put("typeNum", 18);
            adminNasSendInfoService.exposeProcSend(request, params);

            //이의신청의 취지 및 이유를 확인하여 저장한다.
            String[] clsdNo = params.getStringArray("clsd_no");
            String[] objtnRson = params.getStringArray("objtn_rson");

            if (clsdNo.length > 0) {

                for (int i = 0; i < clsdNo.length; i++) {
                    params.put("clsdNo", clsdNo[i]);
                    params.put("objtnRson", objtnRson[i]);

                    adminOpenDecisionDao.updateOpnDcsClsd(params);
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
     * 이의신청내역 리스트 조회
     */
    @Override
    public Paging searchOpnObjtnProcPaging(Params params) {
        Paging list = adminOpenObjectionDao.searchOpnObjtnProcPaging(params, params.getPage(), params.getRows());

        return list;
    }

    /**
     * 이의신청내역 > 조회
     */
    @Override
    public Map<String, Object> detailOpnObjtnProc(Map<String, String> paramMap) {

        Map<String, Object> rMap = new HashMap<String, Object>();
        Map<String, Object> dataMap = new HashMap<String, Object>();
        Params params = new Params();

        paramMap.put("objSno", paramMap.get("objtnSno"));

        try {
            dataMap.put("objtnStatCd", paramMap.get("objtnStatCd")); //상태값을 넘겨 화면을 컨트롤한다.
            dataMap.put("rcpNo", adminOpenObjectionDao.getObjtnRcpNo()); //이의신청 접수번호
            dataMap.put("nextRcpNo", adminOpenObjectionDao.getNextRcpNo()); //이의신청 실제 접수번호
            dataMap.put("OPNZ_HIST", (List<Map<String, Object>>) adminOpenObjectionDao.selectOpnzHist(paramMap)); //이의상태이력조회 2020.04.06 김재한

            dataMap.put("OBJTN_CLSD_LIST", (List<Map<String, Object>>) adminOpenObjectionDao.selectOpnDcsObjtn(paramMap));

            params.put("lclsCd", "G"); // 이의신청 결정
            dataMap.put("objtnDealCodeList", adminExposeInfoService.selectComCode(params));
            params.put("lclsCd", "A"); // 공개방법
            dataMap.put("opbFomCodeList", adminExposeInfoService.selectComCode(params));
            params.put("lclsCd", "B"); // 교부방법
            dataMap.put("giveMthCodeList", adminExposeInfoService.selectComCode(params));


            rMap.put("DATA", adminOpenObjectionDao.detailOpnObjtnProc(paramMap));
            rMap.put("DATA2", dataMap);

        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return rMap;
    }

    /**
     * 이의신청 데이터를 처리한다.(R:접수, C:취하)
     *
     * @param params 파라메터
     * @return 등록결과
     */
    @Override
    public Object comOpnObjtnProc(HttpServletRequest request, Params params) {
        String msg = "";

        try {

            if (params.getString("actionTy").equals("R")) { //접수일때
                params.put("objtnStatCd", "02");
                params.put("histDiv", "22");
                params.put("histCn", "");

                //접수번호 중복확인
                String rcp_dts_no_ck = adminOpenObjectionDao.getRcpDtsNocheck(params);

                if (Integer.parseInt(rcp_dts_no_ck) > 0) {
                    //중복된 접수번호가 있다면, 새로운 접수번호를 부여한다.
                    params.put("rcpDtsNo", adminOpenObjectionDao.getNextRcpNo());
                }

                adminOpenObjectionDao.receiptObjtnProc(params);
                msg = "이의신청을 접수하였습니다.";

                //이의신청서를 접수 처리하면 청구인에게 SMS/메일 발송
                //공통 발송을 위해 설정값을 전달한다.
                params.put("typeNm", "이의신청 접수");
                params.put("typeNum", 19);
                adminNasSendInfoService.exposeProcSend(request, params);

                //opnObjtnProcReceiptSendMail(params);
            }

            if (params.getString("actionTy").equals("C")) { //이의취하일때
                params.put("objtnStatCd", "99");
                params.put("objtnDealRslt", "99");
                params.put("histDiv", "29");
                params.put("histCn", "");

                adminOpenObjectionDao.cancelObjtnProc(params);
                msg = "이의신청 오프라인 취하 되었습니다.";

                //이의신청서를 취하 처리하면 청구인에게 SMS/메일 발송
                //공통 발송을 위해 설정값을 전달한다.
                params.put("typeNm", "이의신청 취하");
                params.put("typeNum", 20);
                adminNasSendInfoService.exposeProcSend(request, params);


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
     * 이의신청 데이터를 처리한다.(S:저장) > 이의신청 결과등록
     *
     * @param params 파라메터
     * @return 등록결과
     */
    @Override
    public Object saveOpnObjtnProc(HttpServletRequest request, Params params) {
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
                    String srcFileNm = file.getOriginalFilename();               //원본 파일명
                    String srcFileNmCut = FilenameUtils.getBaseName(srcFileNm);                // 확장자 제외한 파일명

                    String uniqFileNm = Long.toString((new Date()).getTime());
                    String fileExt = FilenameUtils.getExtension(srcFileNm);       //파일 확장자
                    String filePhNm = uniqFileNm + "." + fileExt;            ///저장파일명

                    if (StringUtils.equals(fileExt, "xls") || StringUtils.equals(fileExt, "xlsx") || StringUtils.equals(fileExt, "doc") || StringUtils.equals(fileExt, "docx")
                            || StringUtils.equals(fileExt, "hwp") || StringUtils.equals(fileExt, "txt") || StringUtils.equals(fileExt, "ppt") || StringUtils.equals(fileExt, "pptx")
                            || StringUtils.equals(fileExt, "pdf") || StringUtils.equals(fileExt, "zip") || StringUtils.equals(fileExt, "rar")) {
                        // PASS
                    } else {
                        throw new SystemException("업로드가 제한된 확장자 입니다.");
                    }


                    if (saveKey.equals("attchfile")) {
                        params.set("attch_fl_nm", srcFileNm);
                        params.set("attch_fl_ph_nm", filePhNm);
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

                                if (saveKey.equals("attchfile")) {
                                    params.set("attch_fl_nm", srcFileNmCut + ".pdf");
                                    params.set("attch_fl_ph_nm", uniqFileNm + ".pdf");
                                }

                            } else if (StringUtils.equals(fileExt, "pdf")) {
                                String tsFile = EgovWebUtil.filePathBlackList(directoryPath + File.separator + filePhNm);

                                boolean tsResult = TSGenerator.generate(tsFile, tsFile);
                                if (!tsResult) {
                                    throw new SystemException("TIMESTAMP 발급도중 오류가 발생하였습니다.");
                                }

                                if (saveKey.equals("attchfile")) {
                                    params.set("attch_fl_nm", srcFileNmCut + ".pdf");
                                    params.set("attch_fl_ph_nm", uniqFileNm + ".pdf");
                                }
                            }
                        } catch (ServiceException sve) {
                            EgovWebUtil.exLogging(sve);
                            throw new ServiceException(sve.getMessage());
                        } catch (IOException ioe) {
                            EgovWebUtil.exTransactionLogging(ioe);
                        } finally {
                            try {
                                if (bos != null) bos.close();
                            } catch (IOException ioe) {
                                EgovWebUtil.exTransactionLogging(ioe);
                            }
                        }
                    }

                } else {
                    // 파일이 없는 경우 DB값 null 처리
                    params.set(saveKey, "");
                }
            }

            //JSP form변수와 DB 입력변수 명이 상이하므로 다시 담아준다.
            params.put("objtnDealRslt", params.get("objtn_deal_rslt"));
            params.put("objtnStatCd", "03");

            if (StringUtils.isNotEmpty(params.getString("opb_dtm"))) {
                params.put("opb_dtm", params.getString("opb_dtm").replaceAll("-", ""));
            }

            //이의신청 결정
            if (params.getString("objtn_deal_rslt").equals("02")) { //각하
                params.put("histCn", "각하");
                params.put("histDiv", "23");
            } else if (params.getString("objtn_deal_rslt").equals("03")) { //기각
                params.put("histCn", "기각");
                params.put("histDiv", "23");
            } else if (params.getString("objtn_deal_rslt").equals("04")) { //인용
                params.put("histCn", "");
                params.put("histDiv", "25");
                params.put("objtnStatCd", "05");
            } else if (params.getString("objtn_deal_rslt").equals("05")) { //부분인용
                params.put("histCn", "");
                params.put("histDiv", "25");
                params.put("objtnStatCd", "05");
            }

            adminOpenObjectionDao.writeObjtnProc(params);
            msg = "이의신청 결과가 등록되었습니다.";
            //이의신청서를 결과등록 처리하면 청구인에게 SMS/메일 발송
            //공통 발송을 위해 설정값을 전달한다.
            params.put("typeNm", " 이의신청 결과등록");
            params.put("typeNum", 22);
            adminNasSendInfoService.exposeProcSend(request, params);

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
     * 이의신청 결정기한연장을 위한 정보조회
     */
    public Map<String, Object> searchObjtnDcsProd(Params params) {
        return (Map<String, Object>) adminOpenObjectionDao.searchObjtnDcsProd(params);
    }

    /**
     * 이의신청 결정기한연장
     */
    @Override
    public Result insertOpnObjtnProd(HttpServletRequest request, Params params) {
        boolean result = false;

        try {

            params.put("histDiv", "24");
            params.put("objtnStatCd", "04");
            params.put("histCn", params.get("dcsprodEtDt") + " 로 연장되었습니다.");

            adminOpenObjectionDao.insertOpnObjtnProd(params);  //결정기한연장
            result = true;

            //이의신청서를 결정기한연장 처리하면 청구인에게 SMS/메일 발송
            //공통 발송을 위해 설정값을 전달한다.
            params.put("typeNm", "이의신청 결정기한연장");
            params.put("typeNum", 21);
            adminNasSendInfoService.exposeProcSend(request, params);

        } catch (ServiceException sve) {
            EgovWebUtil.exTransactionLogging(sve);
            throw new SystemException("admin.error.000001", getMessage("admin.error.000001"));
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
            throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
        }

        if (result) {
            return success(getMessage("admin.message.000007"));    //처리가 완료되었습니다
        } else {
            return failure(getMessage("admin.error.000003"));    //저장에 실패하였습니다.
        }
    }

    /**
     * 이의신청 결과 공개실시
     *
     * @param params 파라메터
     * @return 등록결과
     */
    @Override
    public Object openStartOpnObjtn(HttpServletRequest request, Params params) {
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

                    if (saveKey.equals("file1")) { //공개결정 파일1 > PDF변환? timestamp발급?
                        params.set("opb_flnm", srcFileNm);
                        params.set("opb_flph", filePhNm);
                    }

                    if (saveKey.equals("file2")) { //공개결정 파일2 > PDF변환? timestamp발급?
                        params.set("opb_flnm2", srcFileNm);
                        params.set("opb_flph2", filePhNm);
                    }

                    if (saveKey.equals("file3")) { // 공개결정 파일3 > PDF변환? timestamp발급?
                        params.set("opb_flnm3", srcFileNm);
                        params.set("opb_flph3", filePhNm);
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

                                // PDF 한글변환
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

                        } catch (ServiceException sve) {
                            EgovWebUtil.exLogging(sve);
                            throw new ServiceException(sve.getMessage());
                        } catch (IOException ioe) {
                            EgovWebUtil.exLogging(ioe);
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

            if (params.getString("objtn_deal_rslt").equals("04")) params.put("histCn", "인용");
            if (params.getString("objtn_deal_rslt").equals("05")) params.put("histCn", "부분인용");
            params.put("objtn_stat_cd", "03");    // 통지완료
            params.put("histDiv", "23");            // 이의신청결정통지완료

            //공개실시정보 업데이트(파일포함)
            adminOpenObjectionDao.openStartOpnObjtn(params);

            //이의신청서를 공개 처리하면 청구인에게 SMS/메일 발송
            //공통 발송을 위해 설정값을 전달한다.
            params.put("typeNm", " 이의신청 공개");
            params.put("typeNum", 23);
            adminNasSendInfoService.exposeProcSend(request, params);

        } catch (ServiceException sve) {
            EgovWebUtil.exLogging(sve);
            throw new SystemException("admin.error.000001", getMessage("admin.error.000001"));
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
            throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
        }

        String msg = "공개 되었습니다.";
        return success(msg);
    }

}

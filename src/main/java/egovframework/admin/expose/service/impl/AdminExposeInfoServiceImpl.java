package egovframework.admin.expose.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.admin.expose.service.AdminExposeInfoService;
import egovframework.admin.expose.service.AdminNasSendInfoService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.exception.SystemException;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;
import egovframework.common.base.service.BaseService;
import egovframework.common.base.view.FileDownloadView;

/**
 * 정보공개관리하는 서비스
 *
 * @author 최성빈
 * @version 1.0
 * @since 2019/07/29
 */

@Service(value = "adminExposeInfoService")
public class AdminExposeInfoServiceImpl extends BaseService implements AdminExposeInfoService {

    public static final int BUFF_SIZE = 2048;
    //최대 파일 크기
    private static final long MAX_FILE_SIZE = 1024 * 1024 * 10;

    @Resource(name = "adminExposeInfoDao")
    protected AdminExposeInfoDao adminExposeInfoDao;

    @Resource(name = "adminNasSendInfoService")
    protected AdminNasSendInfoService adminNasSendInfoService;

    @Resource(name = "adminNasSendInfoDao")
    protected AdminNasSendInfoDao adminNasSendInfoDao;

    //청구대상기관을 조회한다.
    @SuppressWarnings("unchecked")
    @Override
    public List<Record> selectNaboOrg(Params params) {
        return (List<Record>) adminExposeInfoDao.selectNaboOrg(params);
    }

    //청구서 작성 공통코드를 조회한다.
    @SuppressWarnings("unchecked")
    @Override
    public List<Record> selectComCode(Params params) {
        List<Record> result = new ArrayList<Record>();
        try {
            result = (List<Record>) adminExposeInfoDao.selectComCode(params);

        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    /**
     * 청구조회  리스트 조회
     */
    @Override
    public Paging opnApplyListPaging(Params params) {
        Paging list = new Paging();
        try {
            list = adminExposeInfoDao.selectOpnApplyList(params, params.getPage(), params.getRows());
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        return list;
    }

    /**
     * 정보공개 청구서작성 데이터를 등록한다.
     *
     * @param params 파라메터
     * @return 등록결과
     */
    @Override
    public Result insertOpnApply(HttpServletRequest request, Params params) {
        boolean result = false;

        final MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
        try {
            //신청번호
            if (StringUtils.isEmpty(params.getString("aplNo"))) {
                String aplNo = adminExposeInfoDao.selectNextAplNo();
                params.set("aplNo", String.valueOf(aplNo));
            }

        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

        //신청일자
        DateFormat sdFormat = new SimpleDateFormat("yyyyMMdd");
        Date nowDate = new Date();
        params.set("aplDt", String.valueOf(sdFormat.format(nowDate)));


        //진행상태 > 접수중 01
        params.set("prgStatCd", "01");

        String aplPno = getInserValue(params.getString("aplPno1"), params.getString("aplPno2"), params.getString("aplPno3"), "-");
        String aplMblPno = getInserValue(params.getString("aplMblPno1"), params.getString("aplMblPno2"), params.getString("aplMblPno3"), "-");
        String aplFaxNo = getInserValue(params.getString("aplFaxNo1"), params.getString("aplFaxNo2"), params.getString("aplFaxNo3"), "-");
        String aplEmailAddr = getInserValue(params.getString("aplEmailAddr1"), params.getString("aplEmailAddr2"), "", "@");
        String aplBno = getInserValue(params.getString("aplBno1"), params.getString("aplBno2"), params.getString("aplBno3"), "-");

        //온라인 등록에서는 반드시 청구기관 정보를 처리기관에 넣어준다.
        params.set("aplDealInstCd", params.get("aplInstCd")); //처리기관코드

        params.set("aplPno", aplPno); //신청전화번호
        params.set("aplMblPno", aplMblPno); //신청휴대전화번호
        params.set("aplFaxNo", aplFaxNo); //신청팩스번호
        params.set("aplEmailAddr", aplEmailAddr); //신청이메일주소
        params.set("aplBno", aplBno); //사업자등록번호
        params.set("sysRegId", params.getString("usrId")); //등록자ID?
        params.set("sysUpdId", params.getString("usrId")); //수정자ID?

        //등록구분 0.온라인, 1.오프라인
        params.set("rgDiv", "1");

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
                    String srcFileNm = file.getOriginalFilename(); //원본 파일명
                    String fileExt = FilenameUtils.getExtension(srcFileNm); //확장자
                    String filePhNm = (new Date()).getTime() + "." + fileExt; ///저장파일명

                    if (file.getSize() > MAX_FILE_SIZE) {
                        throw new ServiceException("업로드 파일의 크기는 " + MAX_FILE_SIZE + "바이트를 초과할 수 없습니다.");
                    }

                    if (saveKey.equals("file")) {
                        params.set("attchFlNm", srcFileNm); //첨부파일명
                        params.set("attchFlPhNm", filePhNm); //저장파일명
                    }

                    if (saveKey.equals("file1")) {
                        params.set("feeAttchFlNm", srcFileNm); //수수료첨부파일명
                        params.set("feeAttchFlPh", filePhNm); //저장파일명
                    }

                    params.set(saveKey, filePhNm);

                    if (filePhNm != null && !"".equals(filePhNm)) {
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
                } else {
                    // 파일이 없는 경우 DB값 null 처리
                    params.set(saveKey, "");
                }
            }

            adminExposeInfoDao.saveOpnApply(params);

            params.set("histCn", "오프라인 청구서");
            adminExposeInfoDao.insertOpnHist(params);

            params.set("acsCd", "CS114"); //접근구분코드 
            params.set("acsPrssCd", "PR202");//접근처리코드 

            adminExposeInfoDao.insertLogAcsOpnzApl(params);  //정보공개 청구서 접근기록  

            result = true;
        } catch (ServiceException sve) {
            EgovWebUtil.exTransactionLogging(sve);
            throw new ServiceException(sve.getMessage());
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
            throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
        }

        if (result) {
            return success(getMessage("admin.message.000007")); //처리가 완료되었습니다
        } else {
            return failure(getMessage("admin.error.000003")); //저장에 실패하였습니다.
        }
    }

    /**
     * 전화번호, 우편번호, 이메일 Sum
     *
     * @param val1
     * @param val2
     * @param val3
     * @param val
     * @return String
     */
    public String getInserValue(String val1, String val2, String val3, String val) {
        String rtnVal = "";
        if (!"".equals(val2)) {
            if (!"".equals(val3)) {
                rtnVal = val1 + val + val2 + val + val3;
            } else {
                rtnVal = val1 + val + val2;
            }
        }
        return rtnVal;
    }

    /**
     * 청구서 상세 조회
     */
    @Override
    public Map<String, Object> selectOpnApplyDtl(Map<String, String> paramMap) {
        Map<String, Object> rMap = new HashMap<String, Object>();
        Map<String, Object> dataMap = new HashMap<String, Object>();

        try {
            dataMap.put("RCP_NO", (List<Map<String, Object>>) adminExposeInfoDao.selectRcpNo(paramMap)); // 접수번호
            dataMap.put("NEXT_RCP_NO", (List<Map<String, Object>>) adminExposeInfoDao.selectNextRcpNo(paramMap)); // 접수 다음번호
            dataMap.put("RCP_DTS_NO", (List<Map<String, Object>>) adminExposeInfoDao.selectRcpDtsNo(paramMap)); //접수 상세번호
            dataMap.put("OPNZ_HIST", (List<Map<String, Object>>) adminExposeInfoDao.selectOpnzHist(paramMap)); //청구상태이력조회
            dataMap.put("OPNZ_DEPT", (List<Map<String, Object>>) adminExposeInfoDao.selectOpnzDept(paramMap)); //담당부서 정보 조회

            if (paramMap.get("srcAplNo") != null && paramMap.get("srcAplNo") != "") {
                dataMap.put("FROM_TRST", (List<Map<String, Object>>) adminExposeInfoDao.selectFromTrst(paramMap)); //이송받은정보 조회
            } else {
                dataMap.put("FROM_TRST", "");
            }
            dataMap.put("TO_TRST", (List<Map<String, Object>>) adminExposeInfoDao.selectToTrst(paramMap)); //이송보낸정보 조회

            rMap.put("DATA", adminExposeInfoDao.selectOpnApplyDtl(paramMap)); //청구서조회
            rMap.put("DATA2", dataMap);


        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return rMap;
    }

    @Override
    public Map<String, Object> opnApplyDtl(Map<String, String> paramMap) {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            result = adminExposeInfoDao.opnApplyDtl(paramMap);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;

    }

    /**
     * 청구서 접수
     */
    @Override
    public Result saveInfoRcp(HttpServletRequest request, Params params) {
        boolean result = false;
        Map<String, String> paramMap = new HashMap<String, String>();
        Map<String, Object> dtlMap = new HashMap<String, Object>();

        try {
            int cnt = (Integer) adminExposeInfoDao.updateOpnApply(params);
            if (cnt > 0) {

                int rcpNoCnt = adminExposeInfoDao.getInfoOpnRcpnoCheck(params);
                if (rcpNoCnt > 0) {
                    throw new ServiceException("중복된 접수번호 입니다.");
                }
                paramMap.put("aplNo", params.getString("aplNo"));
                dtlMap = opnApplyDtl(paramMap);


                if (StringUtils.isEmpty(params.getString("instTrsfYn"))) {
                    dtlMap.put("instTrsfYn", "1"); //기관이송여부 
                }
//                기존 시스템의  아래 조건이 있으나 현재는 안쓰는거 같아 주석처리함. (이송통지에서 사용되는 것으로 사료됨)
//                					
//				if ("0".equals(params.getString("instTrsfYn"))) {
//					dtlMap.put("prgStatCd", "08");
//				} else {
//					dtlMap.put("prgStatCd", "03");
//				}


                dtlMap.put("usrId", params.getString("usrId"));
                dtlMap.put("rcpDtsNo", params.getString("rcpDtsNo"));
                dtlMap.put("rcpNo", params.getString("rcpNo"));
                dtlMap.put("dealDlnDt", params.getString("dealDlnDt"));
                dtlMap.put("prgStatCd", "03"); //처리중 
                dtlMap.put("aplDeptCd", params.getString("aplDeptCd"));

                int opnRcpCnt = (Integer) adminExposeInfoDao.insertOpnRcp(dtlMap); //정보공개 접수등록

                if (opnRcpCnt > 0) {
                    params.set("prgStatCd", "03"); //처리중
                    int prgStatCnt = (Integer) adminExposeInfoDao.updateOpnApplyPrgStat(params); //정보공개청구 처리구분 변경

                    if (prgStatCnt > 0) {

                        //정보공개청구서를 접수하면 청구인에게 SMS, EMAIL발송
                        //공통 발송을 위해 설정값을 전달한다.
                        params.put("typeNm", "접수");
                        params.put("typeNum", 17);
                        result = adminNasSendInfoService.exposeProcSend(request, params);

                        params.set("histDiv", "03");
                        params.put("histCn", "청구 접수");
                        adminExposeInfoDao.insertOpnHist(params); //정보공개 이력등록

                        result = true;
                    }
                }

            }
        } catch (ServiceException sve) {
            EgovWebUtil.exTransactionLogging(sve);
            throw new ServiceException(sve.getMessage());
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
            throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
        }

        if (result) {
            return success(getMessage("admin.message.000007")); //처리가 완료되었습니다
        } else {
            return failure(getMessage("admin.error.000003")); //저장에 실패하였습니다.
        }
    }

    /**
     * 청구서 이송
     */
    @SuppressWarnings({"unchecked"})
    @Override
    public Result saveTrsfOpnApl(HttpServletRequest request, Params params) {
        boolean result = false;
        String msg = "";
        try {
            String relAplInstCd = params.getString("relAplInstCd"); //이송전 기관
            //이송전 기관 정보 조회
            List<Record> relAplInstList = (List<Record>) adminNasSendInfoDao.getOpnzInstInfo(relAplInstCd);
            String relAplInstNm = (String) relAplInstList.get(0).getString("INST_NM");
            String aplDealInstCd = params.getString("aplDealInstCdArr"); //이송대상기관
            String[] aplDealInstCdArr = aplDealInstCd.split(",");

            String beforeAplNo = params.getString("aplNo");
            int tranCheck = 0;
            Record record = adminExposeInfoDao.selectOpnAplDtl(params); // 정보공개청구 데이터 조회(상세) 
            for (String inst : aplDealInstCdArr) {
                if (relAplInstCd.equals(inst)) {
                    tranCheck = 1;
                } else {
                    Thread.yield();
                }
            }
            for (String inst : aplDealInstCdArr) { //이송기관 수만큼

                if (!relAplInstCd.equals(inst)) { //이송전 기관 제외

                    record.put("aplDealInstCd", inst); //이송 처리기관
                    record.put("trsfCn", (String) params.getString("trsfCn" + inst));
                    record.put("srcAplNo", beforeAplNo);
                    //이송 처리기관 정보 조회
                    List<Record> instList = (List<Record>) adminNasSendInfoDao.getOpnzInstInfo(inst);
                    String instNm = (String) instList.get(0).getString("INST_NM");

                    //int trsCnt = adminExposeInfoDao.selectTrsOpnAplDup(record); // 중복체크

                    //if (trsCnt > 0) {
                    //	msg = "이송할 기관이 중복되었습니다.";
                    //}else{
                    if (tranCheck == 0) {
                        params.set("aplNo", beforeAplNo);
                        params.set("aplDealInstCd", inst);

                        adminExposeInfoDao.updateTrsOpnApl(params); // 신청기관이 미포함일 경우 최초 한번은 Update 해야함.

                        params.set("prgStatCd", "09"); //이력구분 (이송)
                        params.set("histCn", "[" + relAplInstNm + "]에서 이송되었습니다.");

                        adminExposeInfoDao.insertOpnHist(params); //정보공개 이력등록

                        tranCheck++;
                    } else {
                        String aplNo = adminExposeInfoDao.selectNextAplNo();
                        record.put("aplNo", aplNo);


                        int cnt = (Integer) adminExposeInfoDao.insertTrsOpnApl(record);

                        if (cnt > 0) {
                            params.set("prgStatCd", "09"); //이력구분 (이송)
                            params.set("aplNo", aplNo);
                            params.set("histCn", "[" + relAplInstNm + "]에서 이송되었습니다.");
                            adminExposeInfoDao.insertOpnHist(params); //정보공개 이력등록  (이송후 청구서)

                            params.set("aplNo", beforeAplNo);
                            params.set("histCn", "[" + instNm + "]에 이송 처리 하였습니다.");
                            adminExposeInfoDao.insertOpnHist(params); //정보공개 이력등록 (이송전 청구서)

                        }
                    }

                    //정보공개청구서를 다른 기관으로 이송시
                    //이송받은 기관담당자에게 SMS 발송
                    //청구인에게 SMS, EMAIL발송
                    //공통 발송을 위해 설정값을 전달한다.
                    params.put("typeNm", "이송");
                    params.put("typeNum", 99);
                    params.put("instCd", inst);
                    params.put("instNm", instNm);
                    adminNasSendInfoService.exposeProcSend(request, params);
                    //}
                }
            }
            result = true;

        } catch (ServiceException sve) {
            EgovWebUtil.exTransactionLogging(sve);
            throw new SystemException("admin.error.000001", getMessage("admin.error.000001"));
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
            throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
        }
        return success(getMessage("admin.message.000007")); //처리가 완료되었습니다
    }

    /**
     * 정보공개청구취하
     */
    @Override
    public Result updateInfoOpenApplyPrgStat(HttpServletRequest request, Params params) {
        boolean result = false;

        try {
            params.put("prgStatCd", "99"); //청구취하
            int prgStatCnt = (Integer) adminExposeInfoDao.updateOpnApplyPrgStat(params);
            if (prgStatCnt > 0) {
                if ("1".equals(params.getString("aplCancel"))) {
                    adminExposeInfoDao.updateOpnRcpPrgStat(params); //신청상태가 아닐때는 신청접수의 진행상태코드 업데이트
                }

                //정보공개청구 취하 결과를 청구인에게 SMS/메일 발송
                //공통 발송을 위해 설정값을 전달한다.
                params.put("typeNm", "취하");
                params.put("typeNum", 10);
                adminNasSendInfoService.exposeProcSend(request, params);

                params.put("histCn", "관리자에 의한 청구 취하"); //이력내용 등록
                adminExposeInfoDao.insertOpnHist(params); //정보공개 이력등록 

                result = true;
            }
        } catch (ServiceException sve) {
            EgovWebUtil.exTransactionLogging(sve);
            throw new SystemException("admin.error.000001", getMessage("admin.error.000001"));
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
            throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
        }

        if (result) {
            return success(getMessage("admin.message.000007")); //처리가 완료되었습니다
        } else {
            return failure(getMessage("admin.error.000003")); //저장에 실패하였습니다.
        }
    }

    /**
     * 정보공개접수조회
     */
    public Map<String, Object> getInfoOpnDcsSearch(Params params) {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            result = (Map<String, Object>) adminExposeInfoDao.getInfoOpnDcsSearch(params);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    /**
     * 첨부파일 다운로드
     */
    @Override
    public Record downloadOpnAplFile(Params params) {
        Record file = new Record();

        params.set("fileNm", params.getString("fileNm").replaceAll("nbsp", " "));
        params.set("fileNm", params.getString("fileNm").replaceAll("sharp", "#"));

        file.put(FileDownloadView.FILE_NAME, params.get("fileNm"));
        file.put(FileDownloadView.FILE_PATH, getMtiFilePath(params));
        file.put(FileDownloadView.FILE_SIZE, getFileSize(file));

        return file;
    }

    /**
     * 파일 크기를 반환한다.
     *
     * @param file
     * @return
     */
    private int getFileSize(Record file) {
        byte[] bytes = null;
        FileInputStream fileInputStream = null;

        try {
            fileInputStream = new FileInputStream(file.getString("filePath"));
            bytes = IOUtils.toByteArray(fileInputStream);
        } catch (IOException ioe) {
            EgovWebUtil.exLogging(ioe);
            throw new ServiceException("시스템 오류가 발생하였습니다.");
        } finally {
            try {
                if (fileInputStream != null) fileInputStream.close();
            } catch (IOException ioe) {
                EgovWebUtil.exLogging(ioe);
                throw new ServiceException("시스템 오류가 발생하였습니다.");
            }
        }

        return bytes.length;
    }

    /**
     * 파일경로 가져오기
     *
     * @param params
     * @return
     */
    private String getMtiFilePath(Params params) {


        return EgovProperties.getProperty("Globals.OpnzAplFilePath") +
                File.separator +
                EgovWebUtil.filePathReplaceAll(params.getString("filePath"));
    }

    /**
     * 결정기한연장
     */
    @Override
    public Result saveOpnDcsProd(HttpServletRequest request, Params params) {
        boolean result = false;

        try {

            params.put("fee", "0");
            params.put("zipFar", "0");
            params.put("feeRdtnAmt", "0");

            int cnt = (Integer) adminExposeInfoDao.insertOpnDcsProd(params); //결정기한연장

            params.put("prgStatCd", "05"); //결정연장

            if (cnt > 0) {
                adminExposeInfoDao.updateOpnRcpPrgStat(params); //정보공개접수 처리구분변경

                //정보공개청구 처리기간 연장 안내를 청구인에게 SMS/메일 발송
                //공통 발송을 위해 설정값을 전달한다.
                params.put("typeNm", "연장");
                params.put("typeNum", 11);
                adminNasSendInfoService.exposeProcSend(request, params);

                params.put("histCn", "청구 결정기한 연장");
                adminExposeInfoDao.insertOpnHist(params);
                result = true;
            }

        } catch (ServiceException sve) {
            EgovWebUtil.exTransactionLogging(sve);
            throw new SystemException("admin.error.000001", getMessage("admin.error.000001"));
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
            throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
        }

        if (result) {
            return success(getMessage("admin.message.000007")); //처리가 완료되었습니다
        } else {
            return failure(getMessage("admin.error.000003")); //저장에 실패하였습니다.
        }
    }

    /**
     * 종결
     */
    @Override
    public Result saveOpenEndCn(HttpServletRequest request, Params params) {
        boolean result = false;

        try {

            params.put("prgStatCd", "08"); //통지완료(종결)
            params.put("histCn", "종결처리");

            int cnt = (Integer) adminExposeInfoDao.updateOpnApplyPrgStat(params); //정보공개청구 진행상황코드 종결 update

            if (cnt > 0) {
                adminExposeInfoDao.updateOpnEndCn(params); //정보공개접수  진행상황코드, 종결내용 update

                //정보공개청구 종결을 청구인에게 SMS/메일 발송
                //공통 발송을 위해 설정값을 전달한다.
                params.put("typeNm", "종결 처리");
                params.put("typeNum", 28);
                adminNasSendInfoService.exposeProcSend(request, params);

                adminExposeInfoDao.insertOpnHist(params); ////정보공개 이력등록
                result = true;
            }

        } catch (ServiceException sve) {
            EgovWebUtil.exTransactionLogging(sve);
            throw new SystemException("admin.error.000001", getMessage("admin.error.000001"));
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
            throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
        }

        if (result) {
            return success(getMessage("admin.message.000007")); //처리가 완료되었습니다
        } else {
            return failure(getMessage("admin.error.000003")); //저장에 실패하였습니다.
        }
    }

    /**
     * 정보공개 청구 타기관 이송 등록
     *
     * @param params 파라메터
     * @return
     */
    @Override
    public Result infoOpenTrnWrite(HttpServletRequest request, Params params) {
        boolean result = false;

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
                    String srcFileNm = file.getOriginalFilename(); //원본 파일명
                    String fileExt = FilenameUtils.getExtension(srcFileNm); //파일 확장자
                    String filePhNm = (new Date()).getTime() + "." + fileExt; //저장파일명

                    if (file.getSize() > MAX_FILE_SIZE) {
                        throw new ServiceException("업로드 파일의 크기는 " + MAX_FILE_SIZE + "바이트를 초과할 수 없습니다.");
                    }

                    params.set("trsfFlNm", srcFileNm); //첨부파일명
                    params.set("trsfFlPh", filePhNm); //저장파일명


                    params.set(saveKey, filePhNm);

                    if (filePhNm != null && !"".equals(filePhNm)) {
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
                } else {
                    // 파일이 없는 경우 DB값 null 처리
                    params.set(saveKey, "");
                }
            }

            params.put("histCn", "이송통지");
            params.put("prgStatCd", "11");
            params.put("instTrsfYn", "0");

            adminExposeInfoDao.updateTrsf(params); //정보공개청구 타기관 이송 update

            adminExposeInfoDao.updateOpnApplyPrgStat(params); //정보공개청구 진행상황코드 종결 update

            //정보공개청구 이송통지를 청구인에게 SMS/메일 발송
            //공통 발송을 위해 설정값을 전달한다.
            params.put("typeNm", "이송통지");
            params.put("typeNum", 27);
            adminNasSendInfoService.exposeProcSend(request, params);

            adminExposeInfoDao.insertOpnHist(params); //정보공개 이력등록

            result = true;

        } catch (ServiceException sve) {
            EgovWebUtil.exTransactionLogging(sve);
            throw new ServiceException(sve.getMessage());
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
            throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
        }

        return success(getMessage("admin.message.000007")); //처리가 완료되었습니다
    }

    /**
     * 정보공개청구수정
     */
    @Override
    public Result updateOpnApl(Params params) {
        boolean result = false;

        try {
            adminExposeInfoDao.updateOpnzRcp(params); //정보공개접수 수정

            int cnt = (Integer) adminExposeInfoDao.updateOpnzApl(params); //정보공개청구 수정

            if (cnt > 0) result = true;

        } catch (ServiceException sve) {
            EgovWebUtil.exTransactionLogging(sve);
            throw new SystemException("admin.error.000001", getMessage("admin.error.000001"));
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
            throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
        }

        if (result) {
            return success(getMessage("admin.message.000007")); //처리가 완료되었습니다
        } else {
            return failure(getMessage("admin.error.000003")); //저장에 실패하였습니다.
        }
    }

    /**
     * 결정통보 상세 (팝업)
     */
    public Map<String, Object> getInfoOpnDcsDetail(Params params) {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            result = (Map<String, Object>) adminExposeInfoDao.getInfoOpnDcsDetail(params);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    /**
     * 청구서 상세(팝업)
     */
    public Map<String, Object> getInfoOpenApplyDetail(Params params) {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            result = (Map<String, Object>) adminExposeInfoDao.getInfoOpenApplyDetail(params);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    /**
     * 이의신청 내역 상세(팝업)
     */
    public Map<String, Object> getOpnObjtnInfoDetail(Params params) {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            result = (Map<String, Object>) adminExposeInfoDao.getOpnObjtnInfoDetail(params);

        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    /**
     * 부서정보 팝업 리스트 조회
     */
    @Override
    public List<Record> infoOrgPopList(Params params) {
        return (List<Record>) adminExposeInfoDao.infoOrgPopList(params);
    }

    /**
     * 정보공개 담당자 정보를 수정한다.
     */
    @Override
    public Result updateOpnAplDept(Params params) {
        boolean result = false;

        try {
            String aplDeptCds = params.getString("aplDeptCds");
            String[] deptCdArr = aplDeptCds.split(",");
            String aplNo = params.getString("aplNo");

            adminExposeInfoDao.deleteOpnAplDept(params); // 담당부서 정보삭제

            for (String deptCd : deptCdArr) {
                params.set("aplNo", aplNo);
                params.set("deptCd", deptCd);

                adminExposeInfoDao.insertOpnAplDept(params); // 담당부서 정보 입력

            }

            result = true;
        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (ServiceException sve) {
            EgovWebUtil.exTransactionLogging(sve);
            throw new SystemException("admin.error.000001", getMessage("admin.error.000001"));
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
            throw new SystemException("admin.error.000003", getMessage("admin.error.000003"));
        }

        if (result) {
            return success(getMessage("admin.message.000007")); //처리가 완료되었습니다
        } else {
            return failure(getMessage("admin.error.000003")); //저장에 실패하였습니다.
        }
    }

    /**
     * 담당부서 정보조회
     */
    @Override
    public List<Record> selectOpnzDeptList(Params params) {
        return adminExposeInfoDao.selectOpnzDeptList(params);
    }

    /**
     * 청구인정보 열람 로그
     */
    @Override
    public void insertLogAcsOpnzApl(Params params) {
        try {
            adminExposeInfoDao.insertLogAcsOpnzApl(params);
        } catch (Exception e) {
            EgovWebUtil.exTransactionLogging(e);
        }
    }

    /**
     * 이송을 위해 정보공개접수 정보 조회
     */
    public Map<String, Object> getInfoOpnAplSearch(Params params) {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            result = (Map<String, Object>) adminExposeInfoDao.getInfoOpnAplSearch(params);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result;
    }

    //이송한 적이 없는 청구대상기관을 조회한다.
    @SuppressWarnings("unchecked")
    @Override
    public List<Record> selectNotTrstNaboOrg(Params params) {
        return (List<Record>) adminExposeInfoDao.selectNotTrstNaboOrg(params);
    }

    // 신청연계 코드 수정
    @Override
    public Result updateAplConnCd(Params params) {
        try {

            adminExposeInfoDao.updateAplConnCd(params);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return success(getMessage("신청연계 코드가 저장 되었습니다."));

    }
}
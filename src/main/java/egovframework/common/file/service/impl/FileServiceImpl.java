package egovframework.common.file.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import egovframework.admin.service.service.OpenInfLcol;
import egovframework.admin.service.service.OpenInfScol;
import egovframework.admin.service.service.OpenInfVcol;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.common.WiseOpenConfig;
import egovframework.common.file.service.FileService;
import egovframework.common.file.service.FileVo;
import egovframework.common.util.ImageUtil;
import egovframework.common.util.RuntimeUtil;
import egovframework.common.util.SFTPSyncManager;
import egovframework.common.util.UtilDate;
import egovframework.common.util.UtilString;


/**
 * 메뉴를 관리를 위한 서비스 구현 클래스
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */

@Service("FileService")
public class FileServiceImpl implements FileService {

    private static final Logger logger = Logger.getLogger(FileServiceImpl.class);

    @Resource(name = "FileDAO")
    private FileDAO FileDao;

    /**
     * 파일 업로드
     */
    public boolean fileUpload(FileVo fileVo, int seq, String filePath, String fileCd) {
        return fileUpload(fileVo, seq, filePath, fileCd, "");
    }


    /**
     * 파일 업로드
     */
    public boolean fileUpload(FileVo fileVo, int seq, String filePath, String fileCd, String etcString) {
        int fileSeq = 0;
        String etc = "";
        String createFileDir = "";

        SFTPSyncManager sftp = new SFTPSyncManager();

        try {
            if (fileVo.getSaveFile() != null) {    //파일이 있다면
                if (fileCd.equals(WiseOpenConfig.FILE_BBS2)) {    //국문,영문 보도자료일때는 Directory를 Seq별로 관리하지 않고 bbsCd에다가 몰아넣음

                    createFileDir = filePath;    //Directory 전체경로
                } else if (fileCd.equals(WiseOpenConfig.FILE_DATA_CATE)) {

                    createFileDir = filePath;    //Directory 전체경로
                } else {

                    createFileDir = filePath + UtilString.getFolderPath(seq, filePath);    //Directory 전체경로
                }
                if (
                        createFolder(createFileDir)) {                            //폴더 생성이 되면

                    logger.debug("createFIleDir : " + createFileDir);
                    String[] arrSaveFileNm = new String[fileVo.getSaveFile().length];
                    logger.debug("length : " + fileVo.getSaveFile().length);
                    for (int i = 0; i < fileVo.getSaveFile().length; i++) {
                        if (fileVo.getFileStatus()[i].equals("C")) {    // 신규 생성일 경우 번호 채번
                            if (fileCd.equals(WiseOpenConfig.FILE_SERVICE)) {
                                fileSeq = FileDao.fileSeq();
                            } else if (fileCd.equals(WiseOpenConfig.MEDIA_SERVICE)) {
                                fileSeq = FileDao.fileMultiSeq();
                            } else if (fileCd.equals(WiseOpenConfig.LINK_SERVICE)) {
                                Calendar date = Calendar.getInstance();
                                etc = getRnd(8) + UtilDate.timestamp2StrOnly(date.getTime());
                            } else if (fileCd.equals(WiseOpenConfig.FILE_BBS)) {
                                fileSeq = FileDao.fileBbsSeq() + i;
                            } else if (fileCd.equals(WiseOpenConfig.FILE_BBS2)) {
                                fileSeq = FileDao.fileBbsSeq() + i;
                            } else if (fileCd.equals(WiseOpenConfig.FILE_PUBLISH)) {
                                fileSeq = FileDao.filePublishSeq() + i;
                            } else if (fileCd.equals(WiseOpenConfig.FILE_DATA_CATE)) {
                                Calendar date = Calendar.getInstance();
                                etc = getRnd(8) + UtilDate.timestamp2StrOnly(date.getTime());
                            } else if (fileCd.equals(WiseOpenConfig.MEDIA_TMNL_IMG)) {
                                Calendar date = Calendar.getInstance();
                                etc = getRnd(8) + UtilDate.timestamp2StrOnly(date.getTime());
                            }

                        } else {                                        // U이거나 나머지는 기존번호 사용
                            fileSeq = Integer.parseInt(fileVo.getArrFileSeq()[i]);
                        }
                        String fileType = getFileType(fileVo.getSaveFile()[i].getOriginalFilename());        //파일확장자
                        fileType = fileType.equals("") ? "" : "." + fileType;                                        //확장자 앞에 .붙이기

                        if (fileCd.equals(WiseOpenConfig.FILE_DATA_CATE)) {
                            arrSaveFileNm[i] = etc + fileType;    //파일명은 seq로
                        } else if (fileCd.equals(WiseOpenConfig.LINK_SERVICE)) {
                            arrSaveFileNm[i] = etc + fileType;    //파일명은 seq로
                        } else if (fileCd.equals(WiseOpenConfig.MEDIA_TMNL_IMG)) {
                            arrSaveFileNm[i] = etc + fileType;    //파일명은 seq로
                        } else {
                            arrSaveFileNm[i] = Integer.toString(fileSeq) + fileType;    //파일명은 seq로
                        }
                        logger.debug("arrSaveFileNm : " + arrSaveFileNm[i]);

                        String pathName = "";
                        if (fileCd.equals(WiseOpenConfig.FILE_DATA_COMBINE)) {        //자료취합 업로드는 파일명 저장..
                            /*실서버 인코딩*/
                            //pathName = createFileDir + File.separator + fileVo.getSaveFileNm()[i];
                            //arrSaveFileNm[i] = fileVo.getSaveFileNm()[i];	//재정의.. validation 통과하도록.
                            String saveFileName = fileVo.getSaveFileNm()[i];
                            saveFileName = new String(saveFileName.getBytes("utf-8"), "iso-8859-1").replace("+", "%20").replaceAll("\\+", "%20");

                            pathName = createFileDir + File.separator + EgovWebUtil.filePathReplaceAll(saveFileName);
                            arrSaveFileNm[i] = saveFileName;    //재정의.. validation 통과하도록.
                        } else if (fileCd.equals(WiseOpenConfig.FILE_DATA_CATE)) {
                            pathName = createFileDir + File.separator + EgovWebUtil.filePathReplaceAll(etc) + fileType;
                        } else if (fileCd.equals(WiseOpenConfig.LINK_SERVICE)) {
                            pathName = createFileDir + File.separator + EgovWebUtil.filePathReplaceAll(etc) + fileType;
                        } else if (fileCd.equals(WiseOpenConfig.MEDIA_TMNL_IMG)) {
                            pathName = createFileDir + File.separator + EgovWebUtil.filePathReplaceAll(etc) + fileType;
                        } else {
                            pathName = createFileDir + File.separator + EgovWebUtil.filePathReplaceAll(Integer.toString(fileSeq)) + fileType;
                        }

                        if (fileCd.equals(WiseOpenConfig.MEDIA_SERVICE)) {        //멀티미디어의 경우 썸네일 경로 생성
                            etc = createFileDir + File.separator + "thumb_" + EgovWebUtil.filePathReplaceAll(Integer.toString(fileSeq)) + fileType;
                        }
//        			RefAddrChk refAddrChk = new RefAddrChk();
//        			refAddrChk.setPathName(pathName); 
                        logger.debug("pathName : " + pathName);
                        File file = new File(pathName);        //파일생성
                        //타입 체크 로직 추가

                        fileVo.getSaveFile()[i].transferTo(file);    //데이터 전송

                        if (file.createNewFile() || fileUploadCheck(arrSaveFileNm[i], createFileDir)) {    //업로드 확인
                            fileVo.setSaveFileNm(arrSaveFileNm);    //성공시 이름입력

                            //skkim
                            if (EgovProperties.getProperty("sftp.option").equals("on")) {
                                sftp.runsftp("U", createFileDir, createFileDir);
                            }

                            // zip 압축 전송 START
							/*
        			    String sendDir = "";
      					UtilZip utilZip = new UtilZip();
        				if("on".equals(EgovProperties.getProperty("FileNetConn.option"))) {
        					sendDir = EgovWebUtil.folderPathReplaceAll(EgovProperties.getProperty("FileNetConn.sendDir"));
        					File _sendDir = new File(sendDir);
        					// 수정 : 권한 설정
        					_sendDir.setExecutable(false, true);
        					_sendDir.setReadable(true);
        					_sendDir.setWritable(false, true);
        					
        					if(!_sendDir.exists()) {
        						_sendDir.mkdirs();
        					}
        					String resultPath = utilZip.zipByEtl(createFileDir, sendDir);
        					logger.debug("***** send zip file : " + resultPath + " *****");
        				}*/
                            // zip 압축 전송 END

                            logger.debug("-----------------------------------------------------------");
                            for (int i1 = 0; i1 < arrSaveFileNm.length; i1++) {
                                logger.debug(fileVo.getSaveFileNm()[i]);
                            }
                            if (fileCd.equals(WiseOpenConfig.FILE_SERVICE)) {                //파일서비스의 경우 HTML 컨버터 동작
                                String convertFilePath = EgovWebUtil.folderPathReplaceAll(EgovProperties.getProperty("Globals.ConvertFilePath"));
                                String createConvertFileDir = EgovWebUtil.folderPathReplaceAll(convertFilePath + UtilString.getFolderPath(seq, convertFilePath));
                                if (createFolder(createConvertFileDir)) {        //경로 생성
                                    ArrayList<String> args = new ArrayList<String>();
                                    args.add(EgovProperties.getProperty("Globals.ConvertorPath") + File.separator + EgovProperties.getProperty("Globals.ConvertFile"));
                                    args.add("-mod_path");
                                    args.add(EgovProperties.getProperty("Globals.ConvertorPath") + File.separator + "modules");
                                    args.add("-t");
                                    args.add(EgovProperties.getProperty("Globals.ConvertorPath") + File.separator + "template");
                                    args.add(pathName);
                                    args.add(createConvertFileDir);

                                    RuntimeUtil.execCmd(args);

                                    //skkim
                                    // 원본 폴더가 여기임     createConvertFileDir
                                    if (EgovProperties.getProperty("sftp.option").equals("on")) {
                                        sftp.runsftp("U", createConvertFileDir, createConvertFileDir);
                                    }

                                    // zip 압축 전송 START
									/*
		        				if("on".equals(EgovProperties.getProperty("FileNetConn.option"))) {
		        					String resultPath = utilZip.zipByEtl(createConvertFileDir, sendDir);
		        					logger.debug("***** send zip file : " + resultPath + " *****");
		        				}*/
                                    // zip 압축 전송 END

                                } else {
                                    return false;
                                }
                            } else if (fileCd.equals(WiseOpenConfig.MEDIA_SERVICE)) {
                                logger.debug("------------------createThumbnail Start--------------------------");
                                logger.debug("------------------pathName:" + pathName);
                                logger.debug("------------------etc:" + etc);

                                logger.debug("------------------fileType:" + fileType.substring(1, fileType.length()));
                                ImageUtil.createThumbnail(pathName, etc, fileType.substring(1, fileType.length()), 76, 76);
                                logger.debug("------------------createThumbnail End--------------------------");

                                if (EgovProperties.getProperty("sftp.option").equals("on")) {
                                    sftp.runsftp("U", createFileDir, createFileDir);
                                }
                            }

                        } else {
                            return false;
                        }
                    }
                } else {
                    return false;
                }

            }

        } catch (DataAccessException dae) {
            EgovWebUtil.exLogging(dae);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }


        return true;
    }

    private String getRnd(int cnt) {
        int rnd;
        String text = "";
        if (cnt <= 0) {
            return "";
        }
        Random r = new Random();
        r.setSeed(new Date().getTime());
        for (int i = 0; i < cnt; i++) {
		   /* 시큐어코딩 권고로 수정함
		   rnd = (int)(Math.random() * 10);
		   */
            rnd = r.nextInt(10);
            text = text + Integer.toString(rnd);
        }
        return text;
    }


    /**
     * 업로드 확인(해당 폴더에 파일리스트 가져오는 방식으로 구현......)
     *
     * @param makefile
     * @param createFileDir
     * @return
     */
    private boolean fileUploadCheck(String makefile, String createFileDir) {
        File fileDir = new File(createFileDir);
        String[] fileList = fileDir.list();
        if (fileList != null) {
            for (String arr : fileList) {
                if (arr.equals(makefile)) {
                    return true;
                }
            }
            return false; //for문 끝나도 일치하는 것이 없으면 false
        }

        return true;

    }

    /**
     * 파일 타입 체크
     */
    public boolean fileTypeCkeck(FileVo fileVo, String[] type) {
        try {
            if (fileVo.getSaveFile() != null) {//파일이 있다면
                for (int i = 0; i < fileVo.getSaveFile().length; i++) {
                    String fileNm = fileVo.getSaveFile()[i].getOriginalFilename(); //파일명
                    String fileType = getFileType(fileNm);
                    if (!fileType.equals("")) {
                        int fileCnt = 0;
                        for (int j = 0; j < type.length; j++) {
                            if (fileType.toUpperCase().equals(type[j].toUpperCase())) {
                                fileCnt++;
                            }
                        }
                        if (fileCnt == 0) {
                            return false;
                        }
                    } else {
                        return false;
                    }
                }
            } else {
                return true;
            }

        } catch (DataAccessException dae) {
            EgovWebUtil.exLogging(dae);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return true;
    }

    /**
     * 파일에 대한 폴더 경로 조회
     * @param seq
     * @param filePath
     * @return
     */
    /*
    public String getFolderPath(int seq, String filePath) {
    	String strSeq = String.valueOf(seq);
    	String createfolderPath = "";
    	
    	if ( strSeq.length() < 2  ) {		// 100이하 숫자는 폴더 1로 정의
    		createfolderPath = File.separator + "1" + File.separator + strSeq;
    	} else {
    		//INF_ID의 SEQ가 기준이 되어 100번대로 폴더 분할
    		//ex) 755 => 700폴더 생성 후 하위 755 폴더 생성(/700/755), 2232 => 2000폴더 생성 후 하위 2232 폴더 생성(/2000/2232)
    		createfolderPath = File.separator + strSeq.substring(0, strSeq.length()-2) + "00" + File.separator + strSeq;
    	}
    	return createfolderPath;
    }
    */

    /**
     * 폴더 생성
     *
     * @param fileDir
     * @return
     */
    private boolean createFolder(String fileDir) {
        File dir = new File(fileDir);

        // 수정 : 권한 설정
        dir.setExecutable(true, true);
        dir.setReadable(true);
        dir.setWritable(true, true);

        if (!dir.exists()) {
            if (dir.mkdirs()) {        //상위폴더 없는경우도 폴더생성
                return true;
            } else {
                return false;
            }
        }

        return true;
    }

    /**
     * 파일명 확인
     *
     * @param fileNm
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unused")
    private String getFileOrginalNm(String fileNm) {
        if (fileNm.lastIndexOf(".") > 0) {
            return fileNm.substring(0, fileNm.indexOf("."));
        } else {
            return "";
        }
    }

    /**
     * 파일 타입 확인
     *
     * @param fileNm
     * @return
     * @throws Exception
     */
    private String getFileType(String fileNm) {
        if (fileNm.lastIndexOf(".") > 0) {
            return fileNm.substring(fileNm.lastIndexOf(".") + 1, fileNm.length());
        } else {
            return "";
        }
    }

    /**
     * 파일 존재여부 확인
     *
     * @param fileVo
     * @return
     * @throws Exception
     */
    private boolean fileObjExits(FileVo fileVo) {
        if (fileVo != null & fileVo.getFile() != null) {
            return true;
        } else {
            return false;
        }
    }

    private boolean fileObjExits1(FileVo fileVo) {
        if (fileVo != null & fileVo.getFile1() != null) {
            return true;
        } else {
            return false;
        }
    }

    private boolean fileObjExits2(FileVo fileVo) {
        if (fileVo != null & fileVo.getFile2() != null) {
            return true;
        } else {
            return false;
        }
    }

    private boolean fileObjExits3(FileVo fileVo) {
        if (fileVo != null & fileVo.getFile3() != null) {
            return true;
        } else {
            return false;
        }
    }

    private boolean fileObjExits4(FileVo fileVo) {
        if (fileVo != null & fileVo.getFile4() != null) {
            return true;
        } else {
            return false;
        }
    }


    /**
     * 파일 체크
     *
     * @param check
     * @return
     * @throws Exception
     */
    private boolean fileCUCheck(String check) {
        if (check.equals("") || check.equals("X")) {
            return true;
        } else {
            return false;
        }
    }

    //파일 재정의
    public void setFileCuData(FileVo fileVo) {
        try {
            if (fileObjExits(fileVo)) {//파일이 있다면
                int statusCnt = 0;
                for (int i = 0; i < fileVo.getFile().length; i++) {
                    if (!fileCUCheck(fileVo.getFileStatus()[i]) && fileVo.getFile()[i].getSize() > 0) {
                        ++statusCnt;
                    }
                }
                //실제 세이브할 파일들...
                MultipartFile saveFile[] = new MultipartFile[statusCnt];
                String arrFileSeq[] = new String[statusCnt];
                String arrFileStatus[] = new String[statusCnt];
                int cnt = 0;
                for (int i = 0; i < fileVo.getFile().length; i++) {
                    if (!fileCUCheck(fileVo.getFileStatus()[i]) && fileVo.getFile()[i].getSize() > 0) {
                        saveFile[cnt] = fileVo.getFile()[i];
                        if (fileVo.getFileStatus()[i].equals("C")) {
                            arrFileSeq[cnt] = "";
                        } else {
                            arrFileSeq[cnt] = fileVo.getArrFileSeq()[i];
                        }
                        arrFileStatus[cnt++] = fileVo.getFileStatus()[i];
                    }
                }
                fileVo.setSaveFile(saveFile);
                fileVo.setArrFileSeq(arrFileSeq);
                fileVo.setFileStatus(arrFileStatus);
            }

            if (fileObjExits1(fileVo)) {//파일이 있다면
                int statusCnt = 0;
                for (int i = 0; i < fileVo.getFile1().length; i++) {
                    if (!fileCUCheck(fileVo.getFileStatus()[i]) && fileVo.getFile1()[i].getSize() > 0) {
                        ++statusCnt;
                    }
                }
                if (statusCnt != 0) {
                    //실제 세이브할 파일들...
                    MultipartFile saveFile[] = new MultipartFile[statusCnt];
                    String arrFileSeq[] = new String[statusCnt];
                    String arrFileStatus[] = new String[statusCnt];
                    int cnt = 0;
                    for (int i = 0; i < fileVo.getFile1().length; i++) {
                        if (!fileCUCheck(fileVo.getFileStatus()[i]) && fileVo.getFile1()[i].getSize() > 0) {
                            saveFile[cnt] = fileVo.getFile1()[i];
                            if (fileVo.getFileStatus()[i].equals("C")) {
                                arrFileSeq[cnt] = "";
                            } else {
                                arrFileSeq[cnt] = fileVo.getArrFileSeq()[i];
                            }
                            arrFileStatus[cnt++] = fileVo.getFileStatus()[i];
                        }
                    }
                    fileVo.setSaveFile(saveFile);
                    fileVo.setArrFileSeq(arrFileSeq);
                    fileVo.setFileStatus(arrFileStatus);
                }
            }

            if (fileObjExits2(fileVo)) {//파일이 있다면
                int statusCnt = 0;
                for (int i = 0; i < fileVo.getFile2().length; i++) {
                    if (!fileCUCheck(fileVo.getFileStatus()[i]) && fileVo.getFile2()[i].getSize() > 0) {
                        ++statusCnt;
                    }
                }
                if (statusCnt != 0) {
                    //실제 세이브할 파일들...
                    MultipartFile saveFile[] = new MultipartFile[statusCnt];
                    String arrFileSeq[] = new String[statusCnt];
                    String arrFileStatus[] = new String[statusCnt];
                    int cnt = 0;
                    for (int i = 0; i < fileVo.getFile2().length; i++) {
                        if (!fileCUCheck(fileVo.getFileStatus()[i]) && fileVo.getFile2()[i].getSize() > 0) {
                            saveFile[cnt] = fileVo.getFile2()[i];
                            if (fileVo.getFileStatus()[i].equals("C")) {
                                arrFileSeq[cnt] = "";
                            } else {
                                arrFileSeq[cnt] = fileVo.getArrFileSeq()[i];
                            }
                            arrFileStatus[cnt++] = fileVo.getFileStatus()[i];
                        }
                    }
                    fileVo.setSaveFile(saveFile);
                    fileVo.setArrFileSeq(arrFileSeq);
                    fileVo.setFileStatus(arrFileStatus);
                }
            }

            if (fileObjExits3(fileVo)) {//파일이 있다면
                int statusCnt = 0;
                for (int i = 0; i < fileVo.getFile3().length; i++) {
                    if (!fileCUCheck(fileVo.getFileStatus()[i]) && fileVo.getFile3()[i].getSize() > 0) {
                        ++statusCnt;
                    }
                }
                if (statusCnt != 0) {
                    //실제 세이브할 파일들...
                    MultipartFile saveFile[] = new MultipartFile[statusCnt];
                    String arrFileSeq[] = new String[statusCnt];
                    String arrFileStatus[] = new String[statusCnt];
                    int cnt = 0;
                    for (int i = 0; i < fileVo.getFile3().length; i++) {
                        if (!fileCUCheck(fileVo.getFileStatus()[i]) && fileVo.getFile3()[i].getSize() > 0) {
                            saveFile[cnt] = fileVo.getFile3()[i];
                            if (fileVo.getFileStatus()[i].equals("C")) {
                                arrFileSeq[cnt] = "";
                            } else {
                                arrFileSeq[cnt] = fileVo.getArrFileSeq()[i];
                            }
                            arrFileStatus[cnt++] = fileVo.getFileStatus()[i];
                        }
                    }
                    fileVo.setSaveFile(saveFile);
                    fileVo.setArrFileSeq(arrFileSeq);
                    fileVo.setFileStatus(arrFileStatus);
                }
            }

            if (fileObjExits4(fileVo)) {//파일이 있다면
                int statusCnt = 0;
                for (int i = 0; i < fileVo.getFile4().length; i++) {
                    if (!fileCUCheck(fileVo.getFileStatus()[i]) && fileVo.getFile4()[i].getSize() > 0) {
                        ++statusCnt;
                    }
                }
                if (statusCnt != 0) {
                    //실제 세이브할 파일들...
                    MultipartFile saveFile[] = new MultipartFile[statusCnt];
                    String arrFileSeq[] = new String[statusCnt];
                    String arrFileStatus[] = new String[statusCnt];
                    int cnt = 0;
                    for (int i = 0; i < fileVo.getFile4().length; i++) {
                        if (!fileCUCheck(fileVo.getFileStatus()[i]) && fileVo.getFile4()[i].getSize() > 0) {
                            saveFile[cnt] = fileVo.getFile4()[i];
                            if (fileVo.getFileStatus()[i].equals("C")) {
                                arrFileSeq[cnt] = "";
                            } else {
                                arrFileSeq[cnt] = fileVo.getArrFileSeq()[i];
                            }
                            arrFileStatus[cnt++] = fileVo.getFileStatus()[i];
                        }
                    }
                    fileVo.setSaveFile(saveFile);
                    fileVo.setArrFileSeq(arrFileSeq);
                    fileVo.setFileStatus(arrFileStatus);
                }
            }

        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }


    }

    public List<HashMap<String, Object>> getFileNameByFileSeq(String downCd, int fileSeq) {
        return getFileNameByFileSeq(downCd, fileSeq, "");
    }

    public List<HashMap<String, Object>> getFileNameByFileSeq(String downCd, int fileSeq, String etc) {
        List<HashMap<String, Object>> rtnVal = new ArrayList<HashMap<String, Object>>();
        try {
            if (downCd.equals("S")) {        //서비스인경우..
                rtnVal = FileDao.getFileNameByFileSeq(fileSeq);
            } else if (downCd.equals("B")) {        //게시판....
                rtnVal = FileDao.getFileNameByBbsFileSeq(fileSeq);
            } else if (downCd.equals("P")) {        //공표자료....
                rtnVal = FileDao.getFileNameByPublishFileSeq(fileSeq);
            } else if (downCd.equals("C")) {        //분류 썸네일
                rtnVal = FileDao.getFileNameByCateId(etc);
            } else if (downCd.equals("L")) {        //링크서비스
                OpenInfLcol openInfLcol = new OpenInfLcol();
                openInfLcol.setInfId(etc);
                openInfLcol.setLinkSeq(fileSeq);
                rtnVal = FileDao.getFileNameByLinkSeq(openInfLcol);
            } else if (downCd.equals("MT")) {        //미디어서비스 썸네일
                OpenInfVcol openInfVcol = new OpenInfVcol();
                openInfVcol.setInfId(etc);
                openInfVcol.setMediaNo(fileSeq);
                rtnVal = FileDao.getFileNameByMediaNo(openInfVcol);
            } else if (downCd.equals("V")) {        //링크서비스
                OpenInfVcol openInfVcol = new OpenInfVcol();
                openInfVcol.setInfId(etc);
                openInfVcol.setVistnSeq(fileSeq);
                rtnVal = FileDao.getFileNameByVistnSeq(openInfVcol);
            } else if (downCd.equals("F")) {        //파일서비스
                OpenInfScol openInfScol = new OpenInfScol();
                openInfScol.setInfId(etc);
                rtnVal = FileDao.getFileNameByOpenFileSeq(openInfScol);
            } else if (downCd.equals("SH")) {        //시트서비스 썸네일
                OpenInfScol openInfScol = new OpenInfScol();
                openInfScol.setInfId(etc);
                rtnVal = FileDao.getFileNameByOpenSheetSeq(openInfScol);
            } else if (downCd.equals("LT")) {        //링크서비스 썸네일
                OpenInfScol openInfScol = new OpenInfScol();
                openInfScol.setInfId(etc);
                rtnVal = FileDao.getFileNameByOpenLinkSeq(openInfScol);
            }

        } catch (DataAccessException dae) {
            EgovWebUtil.exLogging(dae);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return rtnVal;

    }
}
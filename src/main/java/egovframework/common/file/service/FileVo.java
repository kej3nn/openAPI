package egovframework.common.file.service;

import java.io.File;

import org.springframework.web.multipart.MultipartFile;


/**
 * 파일로 사용하는 데이터 처리 모델
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */
public class FileVo {


    MultipartFile file[];
    MultipartFile file1[];

    public int getStartExc() {
        return startExc;
    }

    public void setStartExc(int startExc) {
        this.startExc = startExc;
    }


    MultipartFile file2[];

    MultipartFile file3[];
    MultipartFile file4[];
    MultipartFile saveFile[];
    MultipartFile excelFileNm[];

    String[] saveFileNm;
    String[] fileStatus;
    String[] arrFileSeq;

    int weight;
    int height;
    int startExc;


    public int getWeight() {
        return weight;
    }

    public void setWeight(int weight) {
        this.weight = weight;
    }

    public int getHeight() {
        return height;
    }

    public void setHeight(int height) {
        this.height = height;
    }


    File exFile;

    public File getExFile() {
        return exFile;
    }

    public void setExFile(File exFile) {
        this.exFile = exFile;
    }


    String gubun;

    public String[] getArrFileSeq() {
        return arrFileSeq;
    }

    public void setArrFileSeq(String[] arrFileSeq) {
//		this.arrFileSeq = arrFileSeq;
        this.arrFileSeq = new String[arrFileSeq.length];
        for (int i = 0; i < arrFileSeq.length; i++) {
            this.arrFileSeq[i] = arrFileSeq[i];
        }
    }

    public MultipartFile[] getFile() {
        return file;
    }

    public void setFile(MultipartFile[] file) {
//		this.file = file;
        this.file = new MultipartFile[file.length];
        for (int i = 0; i < file.length; i++) {
            this.file[i] = file[i];
        }
    }

    public String[] getSaveFileNm() {
        return saveFileNm;
    }

    public void setSaveFileNm(String[] saveFileNm) {
//		this.saveFileNm = saveFileNm;
        this.saveFileNm = new String[saveFileNm.length];
        for (int i = 0; i < saveFileNm.length; i++) {
            this.saveFileNm[i] = saveFileNm[i];
        }
    }

    public String[] getFileStatus() {
        return fileStatus;
    }

    public void setFileStatus(String[] fileStatus) {
//		this.fileStatus = fileStatus;
        this.fileStatus = new String[fileStatus.length];
        for (int i = 0; i < fileStatus.length; i++) {
            this.fileStatus[i] = fileStatus[i];
        }
    }

    public MultipartFile[] getSaveFile() {
        return saveFile;
    }

    public void setSaveFile(MultipartFile[] saveFile) {
//		this.saveFile = saveFile;
        this.saveFile = new MultipartFile[saveFile.length];
        for (int i = 0; i < saveFile.length; i++) {
            this.saveFile[i] = saveFile[i];
        }
    }

    public MultipartFile[] getFile1() {
        return file1;
    }

    public void setFile1(MultipartFile[] file1) {
//		this.file1 = file1;
        this.file1 = new MultipartFile[file1.length];
        for (int i = 0; i < file1.length; i++) {
            this.file1[i] = file1[i];
        }
    }

    public MultipartFile[] getFile2() {
        return file2;
    }

    public void setFile2(MultipartFile[] file2) {
//		this.file2 = file2;
        this.file2 = new MultipartFile[file2.length];
        for (int i = 0; i < file2.length; i++) {
            this.file2[i] = file2[i];
        }
    }

    public MultipartFile[] getFile3() {
        return file3;
    }

    public void setFile3(MultipartFile[] file3) {
//		this.file3 = file3;
        this.file3 = new MultipartFile[file3.length];
        for (int i = 0; i < file3.length; i++) {
            this.file3[i] = file3[i];
        }
    }

    public MultipartFile[] getFile4() {
        return file4;
    }

    public void setFile4(MultipartFile[] file4) {
//		this.file4 = file4;
        this.file4 = new MultipartFile[file4.length];
        for (int i = 0; i < file4.length; i++) {
            this.file4[i] = file4[i];
        }
    }

    public MultipartFile[] getExcelFileNm() {
        return excelFileNm;
    }

    public void setExcelFileNm(MultipartFile[] excelFileNm) {
//		this.excelFileNm = excelFileNm;
        this.excelFileNm = new MultipartFile[excelFileNm.length];
        for (int i = 0; i < excelFileNm.length; i++) {
            this.excelFileNm[i] = excelFileNm[i];
        }
    }

    public String getGubun() {
        return gubun;
    }

    public void setGubun(String gubun) {
        this.gubun = gubun;
    }
}

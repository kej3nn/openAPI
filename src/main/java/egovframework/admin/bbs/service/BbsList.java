package egovframework.admin.bbs.service;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import egovframework.admin.basicinf.service.CommCode;

@SuppressWarnings("serial")
public class BbsList extends BbsAdmin implements Serializable {

    private int rn;
    private int rnSeq;
    private Integer pSeq;
    private String bbsTit;
    private String delYn;
    private String oldTit;
    private Integer viewCnt;
    private Integer fileCnt;
    private Integer linkCnt;
    private Integer infCnt;
    private Integer hlCnt;
    private String userId;
    private String userNm;
    private int userCd;
    private String userDttm;
    private int keySeq;
    private String userPw;
    private String userEmail;
    private String userTel;
    private String bbsCont;
    private String orgCd;
    private String orgNm;
    private String ansState;
    private String ansCont;
    private String acptId;
    private String acptDttm;
    private String apprId;
    private String apprNm;
    private String apprTel;
    private String apprDttm;
    private Integer linkSeq;
    private String linkNm;
    private String url;
    private String infNm;
    private String infId;
    private Integer bSeq;
    private String goUrl;
    private String searchWord;
    private String searchWd;
    private String searchWd2;
    private String ansStateNm;
    private String ditcCode;
    private String deptYn;
    private String deptNm;
    private String deptCd;
    private Integer fileSeq;
    private Integer fileSize;
    private String viewFileNm;
    private String fileExt;
    private String topYn;
    private int mstSeq;
    private String srcFileNm;
    private String saveFileNm;
    private String ditcNm1;
    private String ditcNm2;
    private String ditcNm3;
    private String ditcNm4;
    private String ditcNm5;
    private String ditcNm6;
    private String ditcNm7;
    private int fileSizeKb;
    private String tel1;
    private String tel2;
    private String tel3;
    private String email1;
    private String email2;
    private int arrFileSeq;
    private int seq2;
    private String[] _url;
    private String[] _linkNm;
    private String linkNm1;
    private String linkNm2;
    private String linkNm3;
    private String url1;
    private String url2;
    private String url3;
    private int linkSeq1;
    private int linkSeq2;
    private int linkSeq3;
    private int linkCount;
    private String currdate;
    private int topYnSeq;
    private String delYnVal;
    private String delYnVal2;
    private Integer delYn0;
    private Integer delYn1;
    private Integer delYn2;
    private Integer delYn3;
    private Integer delYn4;
    private Integer delYn5;
    private Integer delYn6;
    private Integer delYn7;
    private Integer delCount;
    private String subCd;
    private String leftCd;
    private String code;
    private String portalUserNm;
    private String listSubCd;
    private String listSubCd2;
    private String sUserId;
    private String useNm;
    private String actKey;
    private String linksSeq;
    private String gubun;
    private int tmpSeq;

    private String chosung;
    private String choval1;
    private String choval2;

    private int fileSeqLength;

    private String sysTag;
    private String userIp;
    private String regDttm;

    private List<MultipartFile> files;

    //private String listSubCd;
    private String siteUrl;
    private String continent;
    private String nation;
    private String ctCd;

    private String fileGubun;

    private String popupYn;
    private String weightSize;
    private String heightSize;
    private String popupStartDate;
    private String popupStartHh;
    private String popupStartMi;
    private String popupEndDate;
    private String popupEndHh;
    private String popupEndMi;
    private String siteNm;

    private int prevSeq;
    private int nextSeq;

    private String prevTit;
    private String nextTit;
    private String preSeq;
    private String nexSeq;

    private String tblYn;
    private int rowCnt;
    private String statblId;
    private String statblNm;
    private String searchGubun;
    private String searchVal;

    private String fileCont;
    private String tmpFileCont;
    private String tblLinkTag;

    private String list1SubCd;
    private String list2SubCd;
    private String list3SubCd;
    private String list4SubCd;
    private String ditc1Code;
    private String ditc2Code;
    private String ditc3Code;
    private String ditc4Code;

    private String statblNmExp;
    private Double apprVal;
    private String regStartDtts;
    private String regEndDtts;


    public String getRegStartDtts() {
        return regStartDtts;
    }

    public void setRegStartDtts(String regStartDtts) {
        this.regStartDtts = regStartDtts;
    }

    public String getRegEndDtts() {
        return regEndDtts;
    }

    public void setRegEndDtts(String regEndDtts) {
        this.regEndDtts = regEndDtts;
    }

    public Double getApprVal() {
        return apprVal;
    }

    public void setApprVal(Double apprVal) {
        this.apprVal = apprVal;
    }

    public int getRn() {
        return rn;
    }

    public void setRn(int rn) {
        this.rn = rn;
    }

    public Integer getpSeq() {
        return pSeq;
    }

    public void setpSeq(Integer pSeq) {
        this.pSeq = pSeq;
    }

    public int getRnSeq() {
        return rnSeq;
    }

    public void setRnSeq(int rnSeq) {
        this.rnSeq = rnSeq;
    }

    public String getBbsTit() {
        return bbsTit;
    }

    public void setBbsTit(String bbsTit) {
        this.bbsTit = bbsTit;
    }

    public String getDelYn() {
        return delYn;
    }

    public void setDelYn(String delYn) {
        this.delYn = delYn;
    }

    public String getOldTit() {
        return oldTit;
    }

    public void setOldTit(String oldTit) {
        this.oldTit = oldTit;
    }

    public Integer getViewCnt() {
        return viewCnt;
    }

    public void setViewCnt(Integer viewCnt) {
        this.viewCnt = viewCnt;
    }

    public Integer getFileCnt() {
        return fileCnt;
    }

    public void setFileCnt(Integer fileCnt) {
        this.fileCnt = fileCnt;
    }

    public Integer getLinkCnt() {
        return linkCnt;
    }

    public void setLinkCnt(Integer linkCnt) {
        this.linkCnt = linkCnt;
    }

    public Integer getInfCnt() {
        return infCnt;
    }

    public void setInfCnt(Integer infCnt) {
        this.infCnt = infCnt;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserNm() {
        return userNm;
    }

    public void setUserNm(String userNm) {
        this.userNm = userNm;
    }

    public String getUserDttm() {
        return userDttm;
    }

    public void setUserDttm(String userDttm) {
        this.userDttm = userDttm;
    }

    public int getKeySeq() {
        return keySeq;
    }

    public void setKeySeq(int keySeq) {
        this.keySeq = keySeq;
    }

    public String getUserPw() {
        return userPw;
    }

    public void setUserPw(String userPw) {
        this.userPw = userPw;
    }

    public String getBbsCont() {
        return bbsCont;
    }

    public void setBbsCont(String bbsCont) {
        this.bbsCont = bbsCont;
    }

    public String getOrgCd() {
        return orgCd;
    }

    public void setOrgCd(String orgCd) {
        this.orgCd = orgCd;
    }

    public String getOrgNm() {
        return orgNm;
    }

    public void setOrgNm(String orgNm) {
        this.orgNm = orgNm;
    }

    public String getAnsState() {
        return ansState;
    }

    public void setAnsState(String ansState) {
        this.ansState = ansState;
    }

    public String getAnsCont() {
        return ansCont;
    }

    public void setAnsCont(String ansCont) {
        this.ansCont = ansCont;
    }

    public String getAcptId() {
        return acptId;
    }

    public void setAcptId(String acptId) {
        this.acptId = acptId;
    }

    public String getAcptDttm() {
        return acptDttm;
    }

    public void setAcptDttm(String acptDttm) {
        this.acptDttm = acptDttm;
    }

    public String getApprId() {
        return apprId;
    }

    public void setApprId(String apprId) {
        this.apprId = apprId;
    }

    public String getApprNm() {
        return apprNm;
    }

    public void setApprNm(String apprNm) {
        this.apprNm = apprNm;
    }

    public String getApprTel() {
        return apprTel;
    }

    public void setApprTel(String apprTel) {
        this.apprTel = apprTel;
    }

    public String getApprDttm() {
        return apprDttm;
    }

    public void setApprDttm(String apprDttm) {
        this.apprDttm = apprDttm;
    }

    public Integer getLinkSeq() {
        return linkSeq;
    }

    public void setLinkSeq(Integer linkSeq) {
        this.linkSeq = linkSeq;
    }

    public String getLinkNm() {
        return linkNm;
    }

    public void setLinkNm(String linkNm) {
        this.linkNm = linkNm;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getInfNm() {
        return infNm;
    }

    public void setInfNm(String infNm) {
        this.infNm = infNm;
    }

    public String getInfId() {
        return infId;
    }

    public void setInfId(String infId) {
        this.infId = infId;
    }

    public Integer getbSeq() {
        return bSeq;
    }

    public void setbSeq(Integer bSeq) {
        this.bSeq = bSeq;
    }

    public String getGoUrl() {
        return goUrl;
    }

    public void setGoUrl(String goUrl) {
        this.goUrl = goUrl;
    }

    public String getSearchWord() {
        return searchWord;
    }

    public void setSearchWord(String searchWord) {
        this.searchWord = searchWord;
    }

    public String getSearchWd() {
        return searchWd;
    }

    public void setSearchWd(String searchWd) {
        this.searchWd = searchWd;
    }

    public String getSearchWd2() {
        return searchWd2;
    }

    public void setSearchWd2(String searchWd2) {
        this.searchWd2 = searchWd2;
    }

    public String getAnsStateNm() {
        return ansStateNm;
    }

    public void setAnsStateNm(String ansStateNm) {
        this.ansStateNm = ansStateNm;
    }

    public String getDitcCode() {
        return ditcCode;
    }

    public void setDitcCode(String ditcCode) {
        this.ditcCode = ditcCode;
    }

    public String getDeptYn() {
        return deptYn;
    }

    public void setDeptYn(String deptYn) {
        this.deptYn = deptYn;
    }

    public String getDeptNm() {
        return deptNm;
    }

    public void setDeptNm(String deptNm) {
        this.deptNm = deptNm;
    }

    public String getDeptCd() {
        return deptCd;
    }

    public void setDeptCd(String deptCd) {
        this.deptCd = deptCd;
    }

    public Integer getFileSeq() {
        return fileSeq;
    }

    public void setFileSeq(Integer fileSeq) {
        this.fileSeq = fileSeq;
    }

    public Integer getFileSize() {
        return fileSize;
    }

    public void setFileSize(Integer fileSize) {
        this.fileSize = fileSize;
    }

    public String getViewFileNm() {
        return viewFileNm;
    }

    public void setViewFileNm(String viewFileNm) {
        this.viewFileNm = viewFileNm;
    }

    public String getFileExt() {
        return fileExt;
    }

    public void setFileExt(String fileExt) {
        this.fileExt = fileExt;
    }

    public String getTopYn() {
        return topYn;
    }

    public void setTopYn(String topYn) {
        this.topYn = topYn;
    }

    public String getSrcFileNm() {
        return srcFileNm;
    }

    public void setSrcFileNm(String srcFileNm) {
        this.srcFileNm = srcFileNm;
    }

    public String getSaveFileNm() {
        return saveFileNm;
    }

    public void setSaveFileNm(String saveFileNm) {
        this.saveFileNm = saveFileNm;
    }

    public int getMstSeq() {
        return mstSeq;
    }

    public void setMstSeq(int mstSeq) {
        this.mstSeq = mstSeq;
    }

    public String getDitcNm1() {
        return ditcNm1;
    }

    public void setDitcNm1(String ditcNm1) {
        this.ditcNm1 = ditcNm1;
    }

    public String getDitcNm2() {
        return ditcNm2;
    }

    public void setDitcNm2(String ditcNm2) {
        this.ditcNm2 = ditcNm2;
    }

    public String getDitcNm3() {
        return ditcNm3;
    }

    public void setDitcNm3(String ditcNm3) {
        this.ditcNm3 = ditcNm3;
    }

    public String getChosung() {
        return chosung;
    }

    public void setChosung(String chosung) {
        this.chosung = chosung;
    }

    public String getChoval1() {
        return choval1;
    }

    public void setChoval1(String choval1) {
        this.choval1 = choval1;
    }

    public String getChoval2() {
        return choval2;
    }

    public void setChoval2(String choval2) {
        this.choval2 = choval2;
    }

    public Integer getHlCnt() {
        return hlCnt;
    }

    public void setHlCnt(Integer hlCnt) {
        this.hlCnt = hlCnt;
    }

    public int getFileSizeKb() {
        return fileSizeKb;
    }

    public void setFileSizeKb(int fileSizeKb) {
        this.fileSizeKb = fileSizeKb;
    }

    public int getFileSeqLength() {
        return fileSeqLength;
    }

    public void setFileSeqLength(int fileSeqLength) {
        this.fileSeqLength = fileSeqLength;
    }

    public String getDitcNm4() {
        return ditcNm4;
    }

    public void setDitcNm4(String ditcNm4) {
        this.ditcNm4 = ditcNm4;
    }

    public String getDitcNm5() {
        return ditcNm5;
    }

    public void setDitcNm5(String ditcNm5) {
        this.ditcNm5 = ditcNm5;
    }

    public String getDitcNm6() {
        return ditcNm6;
    }

    public void setDitcNm6(String ditcNm6) {
        this.ditcNm6 = ditcNm6;
    }

    public String getDitcNm7() {
        return ditcNm7;
    }

    public void setDitcNm7(String ditcNm7) {
        this.ditcNm7 = ditcNm7;
    }

    public String getTel1() {
        return tel1;
    }

    public void setTel1(String tel1) {
        this.tel1 = tel1;
    }

    public String getTel2() {
        return tel2;
    }

    public void setTel2(String tel2) {
        this.tel2 = tel2;
    }

    public String getTel3() {
        return tel3;
    }

    public void setTel3(String tel3) {
        this.tel3 = tel3;
    }

    public String getEmail1() {
        return email1;
    }

    public void setEmail1(String email1) {
        this.email1 = email1;
    }

    public String getEmail2() {
        return email2;
    }

    public void setEmail2(String email2) {
        this.email2 = email2;
    }

    public int getArrFileSeq() {
        return arrFileSeq;
    }

    public void setArrFileSeq(int arrFileSeq) {
        this.arrFileSeq = arrFileSeq;
    }

    public int getSeq2() {
        return seq2;
    }

    public void setSeq2(int seq2) {
        this.seq2 = seq2;
    }

    public String getLinkNm1() {
        return linkNm1;
    }

    public void setLinkNm1(String linkNm1) {
        this.linkNm1 = linkNm1;
    }

    public String getLinkNm2() {
        return linkNm2;
    }

    public void setLinkNm2(String linkNm2) {
        this.linkNm2 = linkNm2;
    }

    public String getLinkNm3() {
        return linkNm3;
    }

    public void setLinkNm3(String linkNm3) {
        this.linkNm3 = linkNm3;
    }

    public String getUrl1() {
        return url1;
    }

    public void setUrl1(String url1) {
        this.url1 = url1;
    }

    public String getUrl2() {
        return url2;
    }

    public void setUrl2(String url2) {
        this.url2 = url2;
    }

    public String getUrl3() {
        return url3;
    }

    public void setUrl3(String url3) {
        this.url3 = url3;
    }

    public int getLinkSeq1() {
        return linkSeq1;
    }

    public void setLinkSeq1(int linkSeq1) {
        this.linkSeq1 = linkSeq1;
    }

    public int getLinkSeq2() {
        return linkSeq2;
    }

    public void setLinkSeq2(int linkSeq2) {
        this.linkSeq2 = linkSeq2;
    }

    public int getLinkSeq3() {
        return linkSeq3;
    }

    public void setLinkSeq3(int linkSeq3) {
        this.linkSeq3 = linkSeq3;
    }

    public String[] get_url() {
        String[] ret = null;
        if (this._url != null) {
            ret = new String[this._url.length];
            for (int i = 0; i < this._url.length; i++) {
                ret[i] = this._url[i];
            }
        }
        return ret;
    }

    public void set_url(String[] _url) {
        this._url = new String[_url.length];
        for (int i = 0; i < _url.length; i++) {
            this._url[i] = _url[i];
        }
    }

    public String[] get_linkNm() {
        String[] ret = null;
        if (this._linkNm != null) {
            ret = new String[this._linkNm.length];
            for (int i = 0; i < this._linkNm.length; i++) {
                ret[i] = this._linkNm[i];
            }
        }
        return ret;
    }

    public void set_linkNm(String[] _linkNm) {
        this._linkNm = new String[_linkNm.length];
        for (int i = 0; i < _linkNm.length; i++) {
            this._linkNm[i] = _linkNm[i];
        }
    }

    public int getLinkCount() {
        return linkCount;
    }

    public void setLinkCount(int linkCount) {
        this.linkCount = linkCount;
    }

    public String getCurrdate() {
        return currdate;
    }

    public void setCurrdate(String currdate) {
        this.currdate = currdate;
    }

    public int getTopYnSeq() {
        return topYnSeq;
    }

    public void setTopYnSeq(int topYnSeq) {
        this.topYnSeq = topYnSeq;
    }

    public String getDelYnVal() {
        return delYnVal;
    }

    public void setDelYnVal(String delYnVal) {
        this.delYnVal = delYnVal;
    }

    public String getDelYnVal2() {
        return delYnVal2;
    }

    public void setDelYnVal2(String delYnVal2) {
        this.delYnVal2 = delYnVal2;
    }

    public Integer getDelYn1() {
        return delYn1;
    }

    public void setDelYn1(Integer delYn1) {
        this.delYn1 = delYn1;
    }

    public Integer getDelYn2() {
        return delYn2;
    }

    public void setDelYn2(Integer delYn2) {
        this.delYn2 = delYn2;
    }

    public Integer getDelYn3() {
        return delYn3;
    }

    public void setDelYn3(Integer delYn3) {
        this.delYn3 = delYn3;
    }

    public Integer getDelYn4() {
        return delYn4;
    }

    public void setDelYn4(Integer delYn4) {
        this.delYn4 = delYn4;
    }

    public Integer getDelYn5() {
        return delYn5;
    }

    public void setDelYn5(Integer delYn5) {
        this.delYn5 = delYn5;
    }

    public Integer getDelYn6() {
        return delYn6;
    }

    public void setDelYn6(Integer delYn6) {
        this.delYn6 = delYn6;
    }

    public Integer getDelYn7() {
        return delYn7;
    }

    public void setDelYn7(Integer delYn7) {
        this.delYn7 = delYn7;
    }

    public Integer getDelYn0() {
        return delYn0;
    }

    public void setDelYn0(Integer delYn0) {
        this.delYn0 = delYn0;
    }

    public Integer getDelCount() {
        return delCount;
    }

    public void setDelCount(Integer delCount) {
        this.delCount = delCount;
    }

    public String getSubCd() {
        return subCd;
    }

    public void setSubCd(String subCd) {
        this.subCd = subCd;
    }

    public String getLeftCd() {
        return leftCd;
    }

    public void setLeftCd(String leftCd) {
        this.leftCd = leftCd;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getPortalUserNm() {
        return portalUserNm;
    }

    public void setPortalUserNm(String portalUserNm) {
        this.portalUserNm = portalUserNm;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getUserTel() {
        return userTel;
    }

    public void setUserTel(String userTel) {
        this.userTel = userTel;
    }

    public String getListSubCd() {
        return listSubCd;
    }

    public void setListSubCd(String listSubCd) {
        this.listSubCd = listSubCd;
    }

    public String getListSubCd2() {
        return listSubCd2;
    }

    public void setListSubCd2(String listSubCd2) {
        this.listSubCd2 = listSubCd2;
    }

    public String getSysTag() {
        return sysTag;
    }

    public void setSysTag(String sysTag) {
        this.sysTag = sysTag;
    }

    public String getUserIp() {
        return userIp;
    }

    public void setUserIp(String userIp) {
        this.userIp = userIp;
    }

    public String getRegDttm() {
        return regDttm;
    }

    public void setRegDttm(String regDttm) {
        this.regDttm = regDttm;
    }

    public String getsUserId() {
        return sUserId;
    }

    public void setsUserId(String sUserId) {
        this.sUserId = sUserId;
    }

    public String getUseNm() {
        return useNm;
    }

    public void setUseNm(String useNm) {
        this.useNm = useNm;
    }

    public String getActKey() {
        return actKey;
    }

    public void setActKey(String actKey) {
        this.actKey = actKey;
    }

    public int getUserCd() {
        return userCd;
    }

    public void setUserCd(int userCd) {
        this.userCd = userCd;
    }

    public String getLinksSeq() {
        return linksSeq;
    }

    public void setLinksSeq(String linksSeq) {
        this.linksSeq = linksSeq;
    }

    public String getGubun() {
        return gubun;
    }

    public void setGubun(String gubun) {
        this.gubun = gubun;
    }

    public List<MultipartFile> getFiles() {
        List<MultipartFile> aliFiles;
        if (files != null && files.size() > 0) {
            aliFiles = new ArrayList<MultipartFile>();
            for (MultipartFile m : files) {
                aliFiles.add(m);
            }
            return aliFiles;
        } else {
            return null;
        }
    }

    public void setFiles(List<MultipartFile> files) {
        if (files != null && files.size() > 0) {
            for (int i = 0; i < files.size(); i++) {
                this.files = new ArrayList<MultipartFile>();
                this.files.add(files.get(i));
            }
        } else {
            this.files = null;
        }
    }

    public int getTmpSeq() {
        return tmpSeq;
    }

    public void setTmpSeq(int tmpSeq) {
        this.tmpSeq = tmpSeq;
    }

    public String getSiteNm() {
        return siteNm;
    }

    public void setSiteNm(String siteNm) {
        this.siteNm = siteNm;
    }

    public String getSiteUrl() {
        return siteUrl;
    }

    public void setSiteUrl(String siteUrl) {
        this.siteUrl = siteUrl;
    }

    public String getContinent() {
        return continent;
    }

    public void setContinent(String continent) {
        this.continent = continent;
    }

    public String getNation() {
        return nation;
    }

    public void setNation(String nation) {
        this.nation = nation;
    }

    public String getCtCd() {
        return ctCd;
    }

    public void setCtCd(String ctCd) {
        this.ctCd = ctCd;
    }

    public String getFileGubun() {
        return fileGubun;
    }

    public void setFileGubun(String fileGubun) {
        this.fileGubun = fileGubun;
    }

    public void setPopupStartHh(String popupStartHh) {
        this.popupStartHh = popupStartHh;
    }

    public String getPopupStartMi() {
        return popupStartMi;
    }

    public void setPopupStartMi(String popupStartMi) {
        this.popupStartMi = popupStartMi;
    }

    public String getPopupEndDate() {
        return popupEndDate;
    }

    public void setPopupEndDate(String popupEndDate) {
        this.popupEndDate = popupEndDate;
    }

    public String getPopupEndHh() {
        return popupEndHh;
    }

    public void setPopupEndHh(String popupEndHh) {
        this.popupEndHh = popupEndHh;
    }

    public String getPopupEndMi() {
        return popupEndMi;
    }

    public void setPopupEndMi(String popupEndMi) {
        this.popupEndMi = popupEndMi;
    }

    public String getPopupYn() {
        return popupYn;
    }

    public void setPopupYn(String popupYn) {
        this.popupYn = popupYn;
    }

    public String getWeightSize() {
        return weightSize;
    }

    public void setWeightSize(String weightSize) {
        this.weightSize = weightSize;
    }

    public String getHeightSize() {
        return heightSize;
    }

    public void setHeightSize(String heightSize) {
        this.heightSize = heightSize;
    }

    public String getPopupStartDate() {
        return popupStartDate;
    }

    public void setPopupStartDate(String popupStartDate) {
        this.popupStartDate = popupStartDate;
    }

    public String getPopupStartHh() {
        return popupStartHh;
    }

    public int getPrevSeq() {
        return prevSeq;
    }

    public void setPrevSeq(int prevSeq) {
        this.prevSeq = prevSeq;
    }

    public int getNextSeq() {
        return nextSeq;
    }

    public void setNextSeq(int nextSeq) {
        this.nextSeq = nextSeq;
    }

    public String getPrevTit() {
        return prevTit;
    }

    public void setPrevTit(String prevTit) {
        this.prevTit = prevTit;
    }

    public String getNextTit() {
        return nextTit;
    }

    public void setNextTit(String nextTit) {
        this.nextTit = nextTit;
    }

    public String getPreSeq() {
        return preSeq;
    }

    public void setPreSeq(String preSeq) {
        this.preSeq = preSeq;
    }

    public String getNexSeq() {
        return nexSeq;
    }

    public void setNexSeq(String nexSeq) {
        this.nexSeq = nexSeq;
    }

    public String getTblYn() {
        return tblYn;
    }

    public void setTblYn(String tblYn) {
        this.tblYn = tblYn;
    }

    public int getRowCnt() {
        return rowCnt;
    }

    public void setRowCnt(int rowCnt) {
        this.rowCnt = rowCnt;
    }

    public String getStatblId() {
        return statblId;
    }

    public void setStatblId(String statblId) {
        this.statblId = statblId;
    }

    public String getStatblNm() {
        return statblNm;
    }

    public void setStatblNm(String statblNm) {
        this.statblNm = statblNm;
    }

    public String getSearchGubun() {
        return searchGubun;
    }

    public void setSearchGubun(String searchGubun) {
        this.searchGubun = searchGubun;
    }

    public String getSearchVal() {
        return searchVal;
    }

    public void setSearchVal(String searchVal) {
        this.searchVal = searchVal;
    }

    public String getFileCont() {
        return fileCont;
    }

    public void setFileCont(String fileCont) {
        this.fileCont = fileCont;
    }

    public String getTmpFileCont() {
        return tmpFileCont;
    }

    public void setTmpFileCont(String tmpFileCont) {
        this.tmpFileCont = tmpFileCont;
    }

    public String getTblLinkTag() {
        return tblLinkTag;
    }

    public void setTblLinkTag(String tblLinkTag) {
        this.tblLinkTag = tblLinkTag;
    }

    public String getList1SubCd() {
        return list1SubCd;
    }

    public void setList1SubCd(String list1SubCd) {
        this.list1SubCd = list1SubCd;
    }

    public String getList2SubCd() {
        return list2SubCd;
    }

    public void setList2SubCd(String list2SubCd) {
        this.list2SubCd = list2SubCd;
    }

    public String getList3SubCd() {
        return list3SubCd;
    }

    public void setList3SubCd(String list3SubCd) {
        this.list3SubCd = list3SubCd;
    }

    public String getList4SubCd() {
        return list4SubCd;
    }

    public void setList4SubCd(String list4SubCd) {
        this.list4SubCd = list4SubCd;
    }

    public String getDitc1Code() {
        return ditc1Code;
    }

    public void setDitc1Code(String ditc1Code) {
        this.ditc1Code = ditc1Code;
    }

    public String getDitc2Code() {
        return ditc2Code;
    }

    public void setDitc2Code(String ditc2Code) {
        this.ditc2Code = ditc2Code;
    }

    public String getDitc3Code() {
        return ditc3Code;
    }

    public void setDitc3Code(String ditc3Code) {
        this.ditc3Code = ditc3Code;
    }

    public String getDitc4Code() {
        return ditc4Code;
    }

    public void setDitc4Code(String ditc4Code) {
        this.ditc4Code = ditc4Code;
    }

    public String getStatblNmExp() {
        return statblNmExp;
    }

    public void setStatblNmExp(String statblNmExp) {
        this.statblNmExp = statblNmExp;
    }

}

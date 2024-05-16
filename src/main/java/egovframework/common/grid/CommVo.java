package egovframework.common.grid;


/**
 * 콩통으로 사용하는 데이터 처리 모델
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */
public class CommVo {

    private Integer seq;
    private String status;
    private String delChk;
    private String sessionUsrId;
    private int ibpage;
    private int onepagerow;
    private int startPage;
    private int endPage;
    private int currPage;
    private int currFilePage;
    private int pageSize;
    public int Level; // get, set사용못함( 반드시 public 사용해야함)
    private String currPageGubun;
    private String iborderby;//IbSheet 정렬
    private String iOrderBy;
    private String fileDownType;

    private String serSel; //조회조건
    private String serVal;
    private String orgNm;
    private String cateNm;
    private String openDttmFrom;
    private String openDttmTo;
    private String regDttmFrom;
    private String regDttmTo;
    private String infState;
    private String treeData;
    private String treeData2;
    private String viewLang;
    private String portalYn;
    private int sessionUsrCd;
    private String sessionUsrNm;
    private String sessionOrgCd;
    private String sessionOrgNm;
    private String sessionSysTag;
    private String[] arrTreeData;
    private String[] arrTreeData2;
    private String[] arrConvCd;
    private String sessionAccCd;

    public Integer getSeq() {
        return seq;
    }

    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDelChk() {
        return delChk;
    }

    public void setDelChk(String delChk) {
        this.delChk = delChk;
    }

    public int getIbpage() {
        return ibpage;
    }

    public void setIbpage(int ibpage) {
        this.ibpage = ibpage;
    }

    public int getOnepagerow() {
        return onepagerow;
    }

    public void setOnepagerow(int onepagerow) {
        this.onepagerow = onepagerow;
    }

    public int getStartPage() {
        return startPage;
    }

    public void setStartPage(int startPage) {
        this.startPage = startPage;
    }

    public int getEndPage() {
        return endPage;
    }

    public void setEndPage(int endPage) {
        this.endPage = endPage;
    }

    public String getSessionUsrId() {
        return sessionUsrId;
    }

    public void setSessionUsrId(String sessionUsrId) {
        this.sessionUsrId = sessionUsrId;
    }

    public String getIborderby() {
        return iborderby;
    }

    public void setIborderby(String iborderby) {
        this.iborderby = iborderby;
    }

    public String getiOrderBy() {
        return iOrderBy;
    }

    public void setiOrderBy(String iOrderBy) {
        this.iOrderBy = iOrderBy;
    }

    public String getFileDownType() {
        return fileDownType;
    }

    public void setFileDownType(String fileDownType) {
        this.fileDownType = fileDownType;
    }

    public String getSerSel() {
        return serSel;
    }

    public void setSerSel(String serSel) {
        this.serSel = serSel;
    }

    public String getSerVal() {
        return serVal;
    }

    public void setSerVal(String serVal) {
        this.serVal = serVal;
    }

    public String getOrgNm() {
        return orgNm;
    }

    public void setOrgNm(String orgNm) {
        this.orgNm = orgNm;
    }

    public String getCateNm() {
        return cateNm;
    }

    public void setCateNm(String cateNm) {
        this.cateNm = cateNm;
    }

    public String getOpenDttmFrom() {
        return openDttmFrom;
    }

    public void setOpenDttmFrom(String openDttmFrom) {
        this.openDttmFrom = openDttmFrom;
    }

    public String getOpenDttmTo() {
        return openDttmTo;
    }

    public void setOpenDttmTo(String openDttmTo) {
        this.openDttmTo = openDttmTo;
    }

    public String getInfState() {
        return infState;
    }

    public void setInfState(String infState) {
        this.infState = infState;
    }

    public String getTreeData() {
        return treeData;
    }

    public void setTreeData(String treeData) {
        this.treeData = treeData;
    }

    public String getTreeData2() {
        return treeData2;
    }

    public void setTreeData2(String treeData2) {
        this.treeData2 = treeData2;
    }

    public int getLevel() {
        return Level;
    }

    public void setLevel(int level) {
        Level = level;
    }

    public String getRegDttmFrom() {
        return regDttmFrom;
    }

    public void setRegDttmFrom(String regDttmFrom) {
        this.regDttmFrom = regDttmFrom;
    }

    public String getRegDttmTo() {
        return regDttmTo;
    }

    public void setRegDttmTo(String regDttmTo) {
        this.regDttmTo = regDttmTo;
    }

    public String getViewLang() {
        return viewLang;
    }

    public void setViewLang(String viewLang) {
        this.viewLang = viewLang;
    }

    public int getCurrPage() {
        return currPage;
    }

    public void setCurrPage(int currPage) {
        this.currPage = currPage;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public String getCurrPageGubun() {
        return currPageGubun;
    }

    public void setCurrPageGubun(String currPageGubun) {
        this.currPageGubun = currPageGubun;
    }

    public int getCurrFilePage() {
        return currFilePage;
    }

    public void setCurrFilePage(int currFilePage) {
        this.currFilePage = currFilePage;
    }

    public String getPortalYn() {
        return portalYn;
    }

    public void setPortalYn(String portalYn) {
        this.portalYn = portalYn;
    }

    public int getSessionUsrCd() {
        return sessionUsrCd;
    }

    public void setSessionUsrCd(int sessionUsrCd) {
        this.sessionUsrCd = sessionUsrCd;
    }

    public String getSessionUsrNm() {
        return sessionUsrNm;
    }

    public void setSessionUsrNm(String sessionUsrNm) {
        this.sessionUsrNm = sessionUsrNm;
    }

    public String getSessionOrgCd() {
        return sessionOrgCd;
    }

    public void setSessionOrgCd(String sessionOrgCd) {
        this.sessionOrgCd = sessionOrgCd;
    }

    public String getSessionOrgNm() {
        return sessionOrgNm;
    }

    public void setSessionOrgNm(String sessionOrgNm) {
        this.sessionOrgNm = sessionOrgNm;
    }

    public String getSessionSysTag() {
        return sessionSysTag;
    }

    public void setSessionSysTag(String sessionSysTag) {
        this.sessionSysTag = sessionSysTag;
    }

    public String[] getArrTreeData() {
        String[] ret = null;
        if (this.arrTreeData != null) {
            ret = new String[this.arrTreeData.length];
            for (int i = 0; i < this.arrTreeData.length; i++) {
                ret[i] = this.arrTreeData[i];
            }
        }
        return ret;
    }

    public void setArrTreeData(String[] arrTreeData) {
        this.arrTreeData = new String[arrTreeData.length];
        for (int i = 0; i < arrTreeData.length; i++) {
            this.arrTreeData[i] = arrTreeData[i];
        }
    }

    public String[] getArrTreeData2() {
        String[] ret = null;
        if (this.arrTreeData2 != null) {
            ret = new String[this.arrTreeData2.length];
            for (int i = 0; i < this.arrTreeData2.length; i++) {
                ret[i] = this.arrTreeData2[i];
            }
        }
        return ret;
    }

    public void setArrTreeData2(String[] arrTreeData2) {
        this.arrTreeData2 = new String[arrTreeData2.length];
        for (int i = 0; i < arrTreeData2.length; i++) {
            this.arrTreeData2[i] = arrTreeData2[i];
        }
    }

    public String[] getArrConvCd() {
        String[] ret = null;
        if (this.arrConvCd != null) {
            ret = new String[this.arrConvCd.length];
            for (int i = 0; i < this.arrConvCd.length; i++) {
                ret[i] = this.arrConvCd[i];
            }
        }
        return ret;
    }

    public void setArrConvCd(String[] arrConvCd) {
        this.arrConvCd = new String[arrConvCd.length];
        for (int i = 0; i < arrConvCd.length; i++) {
            this.arrConvCd[i] = arrConvCd[i];
        }
    }

    public String getSessionAccCd() {
        return sessionAccCd;
    }

    public void setSessionAccCd(String sessionAccCd) {
        this.sessionAccCd = sessionAccCd;
    }
}

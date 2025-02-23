package egovframework.admin.service.service;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import egovframework.common.grid.CommVo;
import egovframework.common.util.UtilString;

@SuppressWarnings("serial")
public class OpenInfSrv extends CommVo implements Serializable {

    private String infId;


    private int infSeq;
    private int colSeq;
    private int MstSeq;
    private String dtNm;
    private String infNm;
    private String cateNm;
    private String orgNm;
    private String usrNm;
    private String openDttm;
    private String infState;
    private String ownerCd;
    private String dsId;
    private String dsNm;
    private String srvYn;
    private String srvCd;
    private String srvDttm;
    private int viewCnt;
    private String apiEp;
    private String apiType;
    private String apiRes;
    private int apiTrf;
    private String apiExp;
    private String apiExpEng;
    private String markerCd;
    private String viewTag;
    private String sgrpCd;
    private String lytitNm;
    private String rytitNm;
    private String lytitNmEng;
    private String rytitNmEng;
    private String seriesPosx;
    private String seriesPosy;
    private String seriesOrd;
    private String seriesFyn;
    private String xlnCd;
    private String ylnCd;
    private String srcColId;
    private String queryString;
    private String selectQuery;
    private String tableNm;
    private String whereQuery;
    private String orderByQuery;
    private String condQuery;
    private String titleQuery;
    private String viewLang;
    private String fileDownYn;
    private String dtId;
    private String yColQuery;
    private String ryColQuery;
    private String xColQuery;
    private String yyStYy;
    private String yyEnYy;
    private String mmStYy;
    private String mmEnYy;
    private String mmStMq;
    private String mmEnMq;
    private String qqStYy;
    private String qqEnYy;
    private String qqStMq;
    private String qqEnMq;
    private String itemCnt;
    private String tsQuery;
    private String firstYn;
    private String dataOrder;
    private String convCd;
    private String numWgCd;
    private String pointCd;
    private String numNm;
    private String groupByQuery;
    private String dataModified;
    private String popupUse;
    private String openSrv;
    private String cancelSrv;
    private String tsSelect;
    private String tsInputSearch;
    private String itemInputSearch;
    private String item1InputSearch;
    private String item2InputSearch;
    private String bunryu;
    private String searchId;
    private String searchGubun;
    private int replyCurrPage;
    private String tblId;
    private String sortBy;
    private String popupSerach;
    private String searchWord;
    private String ditcCd;
    private String pubDttmQuery;
    private String pubYn;
    private String infExp;
    private String gridItem;
    private String popColId;
    private String fsclYy;
    private String fsclCd;
    private String fscl2Cd;
    private String fldCd;
    private String sectCd;
    private String pgmCd;
    private String gofDivCd;
    private String markerVal;
    private String ryposYn;
    private String cateFullnm;
    private String orgCd;
    private String cateId;
    private String offcCd;
    private String acctCd;
    private String fsYn;
    private String fsCd;
    private String ikwanCd;
    private String ihangCd;
    private String citmCd;
    private String gssYn;
    private String xPos;
    private String yPos;
    private String mapLevel;
    private List<MultipartFile> files;
    private String mpbFsclCd;
    private String connWhere;
    private int fColCurrPage;
    private String tselectQuery;
    private String accCd;
    private String prssAccCd;
    private String cclCd;
    private String cclNm;
    private String tmnlImgFile;
    private String wrtNm;
 
    
    //2023-11, api version list
    private String openInfIds = "";
    
    public String getOpenInfIds() {
        return openInfIds;
    }

    public void setOpenInfIds(String openInfIds) {
        this.openInfIds = openInfIds;
    }
    

    public String getWrtNm() {
        return wrtNm;
    }

    public void setWrtNm(String wrtNm) {
        this.wrtNm = wrtNm;
    }

    //2018.01.04 추가
    private String infSrv; //서비스 유형
    private String fvtDataYn; //추천여부
    private String fvtDataOrder; // 추천순위

    private String wgsQuery;

    public String getInfId() {
        return infId;
    }

    public String getTmnlImgFile() {
        return tmnlImgFile;
    }

    public void setTmnlImgFile(String tmnlImgFile) {
        this.tmnlImgFile = tmnlImgFile;
    }

    public void setInfId(String infId) {
        this.infId = infId;
    }

    public String getDtNm() {
        return dtNm;
    }

    public void setDtNm(String dtNm) {
        this.dtNm = dtNm;
    }

    public String getInfNm() {
        return infNm;
    }

    public void setInfNm(String infNm) {
        this.infNm = infNm;
    }

    public String getCateNm() {
        return cateNm;
    }

    public void setCateNm(String cateNm) {
        this.cateNm = cateNm;
    }

    public String getOrgNm() {
        return orgNm;
    }

    public void setOrgNm(String orgNm) {
        this.orgNm = orgNm;
    }

    public String getUsrNm() {
        return usrNm;
    }

    public void setUsrNm(String usrNm) {
        this.usrNm = usrNm;
    }

    public String getOpenDttm() {
        return openDttm;
    }

    public void setOpenDttm(String openDttm) {
        this.openDttm = openDttm;
    }

    public String getInfState() {
        return infState;
    }

    public void setInfState(String infState) {
        this.infState = infState;
    }

    public int getInfSeq() {
        return infSeq;
    }

    public void setInfSeq(int infSeq) {
        this.infSeq = infSeq;
    }

    public String getOwnerCd() {
        return ownerCd;
    }

    public void setOwnerCd(String ownerCd) {
        this.ownerCd = ownerCd;
    }

    public String getDsId() {
        return dsId;
    }

    public void setDsId(String dsId) {
        this.dsId = dsId;
    }

    public String getDsNm() {
        return dsNm;
    }

    public void setDsNm(String dsNm) {
        this.dsNm = dsNm;
    }

    public String getSrvCd() {
        return srvCd;
    }

    public void setSrvCd(String srvCd) {
        this.srvCd = srvCd;
    }

    public String getSrvYn() {
        return srvYn;
    }

    public void setSrvYn(String srvYn) {
        this.srvYn = srvYn;
    }

    public String getSrvDttm() {
        return srvDttm;
    }

    public void setSrvDttm(String srvDttm) {
        this.srvDttm = srvDttm;
    }

    public int getViewCnt() {
        return viewCnt;
    }

    public void setViewCnt(int viewCnt) {
        this.viewCnt = viewCnt;
    }

    public String getApiEp() {
        return apiEp;
    }

    public void setApiEp(String apiEp) {
        this.apiEp = apiEp;
    }

    public String getApiType() {
        return apiType;
    }

    public void setApiType(String apiType) {
        this.apiType = apiType;
    }

    public String getApiRes() {
        return apiRes;
    }

    public void setApiRes(String apiRes) {
        this.apiRes = apiRes;
    }

    public int getApiTrf() {
        return apiTrf;
    }

    public void setApiTrf(int apiTrf) {
        //this.apiTrf = Integer.parseInt(apiTrf);
        this.apiTrf = apiTrf;
    }

    public String getApiExp() {
        return apiExp;
    }

    public void setApiExp(String apiExp) {
        this.apiExp = apiExp;
    }

    public String getApiExpEng() {
        return apiExpEng;
    }

    public void setApiExpEng(String apiExpEng) {
        this.apiExpEng = apiExpEng;
    }

    public String getMarkerCd() {
        return markerCd;
    }

    public void setMarkerCd(String markerCd) {
        this.markerCd = markerCd;
    }

    public String getViewTag() {
        return viewTag;
    }

    public void setViewTag(String viewTag) {
        this.viewTag = viewTag;
    }

    public String getSgrpCd() {
        return sgrpCd;
    }

    public void setSgrpCd(String sgrpCd) {
        this.sgrpCd = sgrpCd;
    }

    public String getLytitNm() {
        return lytitNm;
    }

    public void setLytitNm(String lytitNm) {
        this.lytitNm = lytitNm;
    }

    public String getRytitNm() {
        return rytitNm;
    }

    public void setRytitNm(String rytitNm) {
        this.rytitNm = rytitNm;
    }

    public String getLytitNmEng() {
        return lytitNmEng;
    }

    public void setLytitNmEng(String lytitNmEng) {
        this.lytitNmEng = lytitNmEng;
    }

    public String getRytitNmEng() {
        return rytitNmEng;
    }

    public void setRytitNmEng(String rytitNmEng) {
        this.rytitNmEng = rytitNmEng;
    }

    public String getSeriesPosx() {
        return seriesPosx;
    }

    public void setSeriesPosx(String seriesPosx) {
        this.seriesPosx = seriesPosx;
    }

    public String getSeriesPosy() {
        return seriesPosy;
    }

    public void setSeriesPosy(String seriesPosy) {
        this.seriesPosy = seriesPosy;
    }

    public String getSeriesOrd() {
        return seriesOrd;
    }

    public void setSeriesOrd(String seriesOrd) {
        this.seriesOrd = seriesOrd;
    }

    public String getSeriesFyn() {
        return seriesFyn;
    }

    public void setSeriesFyn(String seriesFyn) {
        this.seriesFyn = seriesFyn;
    }

    public String getXlnCd() {
        return xlnCd;
    }

    public void setXlnCd(String xlnCd) {
        this.xlnCd = xlnCd;
    }

    public String getYlnCd() {
        return ylnCd;
    }

    public void setYlnCd(String ylnCd) {
        this.ylnCd = ylnCd;
    }

    public int getColSeq() {
        return colSeq;
    }

    public void setColSeq(int colSeq) {
        this.colSeq = colSeq;
    }

    public String getSrcColId() {
        return srcColId;
    }

    public void setSrcColId(String srcColId) {
        this.srcColId = UtilString.SQLInjectionFilter2(srcColId);
    }

    public String getQueryString() {
        return queryString;
    }

    public void setQueryString(String queryString) {
        if (!UtilString.null2Blank(queryString).equals("")) {
            this.queryString = UtilString.replace(UtilString.replace(queryString, "~!@", "&"), "@!~", "=");
        } else {
            this.queryString = queryString;
        }
    }

    public String getSelectQuery() {
        return selectQuery;
    }

    public void setSelectQuery(String selectQuery) {
        this.selectQuery = UtilString.SQLInjectionFilter2(selectQuery);
    }

    public String getTableNm() {
        return tableNm;
    }

    public void setTableNm(String tableNm) {
        this.tableNm = UtilString.SQLInjectionFilter2(tableNm);
    }

    public String getWhereQuery() {
        return whereQuery;
    }

    public void setWhereQuery(String whereQuery) {
        this.whereQuery = whereQuery;
    }

    public String getOrderByQuery() {
        return orderByQuery;
    }

    public void setOrderByQuery(String orderByQuery) {
        this.orderByQuery = UtilString.SQLInjectionFilter2(orderByQuery);
    }

    public String getCondQuery() {
        return condQuery;
    }

    public void setCondQuery(String condQuery) {
        this.condQuery = UtilString.SQLInjectionFilter2(condQuery);
    }

    public String getViewLang() {
        return viewLang;
    }

    public void setViewLang(String viewLang) {
        this.viewLang = viewLang;
    }

    public String getFileDownYn() {
        return fileDownYn;
    }

    public void setFileDownYn(String fileDownYn) {
        this.fileDownYn = fileDownYn;
    }

    public String getTitleQuery() {
        return titleQuery;
    }

    public void setTitleQuery(String titleQuery) {
        this.titleQuery = titleQuery;
    }

    public String getDtId() {
        return dtId;
    }

    public void setDtId(String dtId) {
        this.dtId = dtId;
    }

    public String getyColQuery() {
        return yColQuery;
    }

    public void setyColQuery(String yColQuery) {
        this.yColQuery = UtilString.SQLInjectionFilter2(yColQuery);
    }

    public String getRyColQuery() {
        return ryColQuery;
    }

    public void setRyColQuery(String ryColQuery) {
        this.ryColQuery = UtilString.SQLInjectionFilter2(ryColQuery);
    }

    public String getxColQuery() {
        return xColQuery;
    }

    public void setxColQuery(String xColQuery) {
        this.xColQuery = UtilString.SQLInjectionFilter2(xColQuery);
    }

    public String getYyStYy() {
        return yyStYy;
    }

    public void setYyStYy(String yyStYy) {
        this.yyStYy = yyStYy;
    }

    public String getYyEnYy() {
        return yyEnYy;
    }

    public void setYyEnYy(String yyEnYy) {
        this.yyEnYy = yyEnYy;
    }

    public String getMmStYy() {
        return mmStYy;
    }

    public void setMmStYy(String mmStYy) {
        this.mmStYy = mmStYy;
    }

    public String getMmEnYy() {
        return mmEnYy;
    }

    public void setMmEnYy(String mmEnYy) {
        this.mmEnYy = mmEnYy;
    }

    public String getMmStMq() {
        return mmStMq;
    }

    public void setMmStMq(String mmStMq) {
        this.mmStMq = mmStMq;
    }

    public String getMmEnMq() {
        return mmEnMq;
    }

    public void setMmEnMq(String mmEnMq) {
        this.mmEnMq = mmEnMq;
    }

    public String getQqStYy() {
        return qqStYy;
    }

    public void setQqStYy(String qqStYy) {
        this.qqStYy = qqStYy;
    }

    public String getQqEnYy() {
        return qqEnYy;
    }

    public void setQqEnYy(String qqEnYy) {
        this.qqEnYy = qqEnYy;
    }

    public String getQqStMq() {
        return qqStMq;
    }

    public void setQqStMq(String qqStMq) {
        this.qqStMq = qqStMq;
    }

    public String getQqEnMq() {
        return qqEnMq;
    }

    public void setQqEnMq(String qqEnMq) {
        this.qqEnMq = qqEnMq;
    }

    public String getItemCnt() {
        return itemCnt;
    }

    public void setItemCnt(String itemCnt) {
        this.itemCnt = itemCnt;
    }

    public String getTsQuery() {
        return tsQuery;
    }

    public void setTsQuery(String tsQuery) {
        this.tsQuery = tsQuery;
    }

    public String getFirstYn() {
        return firstYn;
    }

    public void setFirstYn(String firstYn) {
        this.firstYn = firstYn;
    }

    public String getDataOrder() {
        return dataOrder;
    }

    public void setDataOrder(String dataOrder) {
        this.dataOrder = dataOrder;
    }

    public String getConvCd() {
        return convCd;
    }

    public void setConvCd(String convCd) {
        this.convCd = convCd;
    }

    public String getNumWgCd() {
        return numWgCd;
    }

    public void setNumWgCd(String numWgCd) {
        this.numWgCd = numWgCd;
    }

    public String getPointCd() {
        return pointCd;
    }

    public void setPointCd(String pointCd) {
        this.pointCd = pointCd;
    }

    public String getNumNm() {
        return numNm;
    }

    public void setNumNm(String numNm) {
        this.numNm = numNm;
    }

    public String getGroupByQuery() {
        return groupByQuery;
    }

    public void setGroupByQuery(String groupByQuery) {
        this.groupByQuery = groupByQuery;
    }

    public String getDataModified() {
        return dataModified;
    }

    public void setDataModified(String dataModified) {
        this.dataModified = dataModified;
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
        //this.files = files;
        if (files.size() > 0) {
            this.files = new ArrayList<MultipartFile>();
            for (MultipartFile file : files) {
                this.files.add(file);
            }
        } else {
            this.files = null;
        }

    }

    public String getPopupUse() {
        return popupUse;
    }

    public void setPopupUse(String popupUse) {
        this.popupUse = popupUse;
    }

    public int getMstSeq() {
        return MstSeq;
    }

    public void setMstSeq(int mstSeq) {
        MstSeq = mstSeq;
    }

    public String getOpenSrv() {
        return openSrv;
    }

    public void setOpenSrv(String openSrv) {
        this.openSrv = openSrv;
    }

    public String getCancelSrv() {
        return cancelSrv;
    }

    public void setCancelSrv(String cancelSrv) {
        this.cancelSrv = cancelSrv;
    }

    public String getTsSelect() {
        return tsSelect;
    }

    public void setTsSelect(String tsSelect) {
        this.tsSelect = tsSelect;
    }

    public String getTsInputSearch() {
        return tsInputSearch;
    }

    public void setTsInputSearch(String tsInputSearch) {
        this.tsInputSearch = tsInputSearch;
    }

    public String getItemInputSearch() {
        return itemInputSearch;
    }

    public void setItemInputSearch(String itemInputSearch) {
        this.itemInputSearch = itemInputSearch;
    }

    public String getItem1InputSearch() {
        return item1InputSearch;
    }

    public void setItem1InputSearch(String item1InputSearch) {
        this.item1InputSearch = item1InputSearch;
    }

    public String getItem2InputSearch() {
        return item2InputSearch;
    }

    public void setItem2InputSearch(String item2InputSearch) {
        this.item2InputSearch = item2InputSearch;
    }

    public String getBunryu() {
        return bunryu;
    }

    public void setBunryu(String bunryu) {
        this.bunryu = bunryu;
    }

    public String getSearchId() {
        return searchId;
    }

    public void setSearchId(String searchId) {
        this.searchId = searchId;
    }

    public String getSearchGubun() {
        return searchGubun;
    }

    public void setSearchGubun(String searchGubun) {
        this.searchGubun = searchGubun;
    }

    public int getReplyCurrPage() {
        return replyCurrPage;
    }

    public void setReplyCurrPage(int replyCurrPage) {
        this.replyCurrPage = replyCurrPage;
    }

    public String getTblId() {
        return tblId;
    }

    public void setTblId(String tblId) {
        this.tblId = UtilString.SQLInjectionFilter2(tblId);
    }

    public String getSortBy() {
        return sortBy;
    }

    public void setSortBy(String sortBy) {
        this.sortBy = sortBy;
    }

    public String getPopupSerach() {
        return popupSerach;
    }

    public void setPopupSerach(String popupSerach) {
        this.popupSerach = popupSerach;
    }

    public String getSearchWord() {
        return searchWord;
    }

    public void setSearchWord(String searchWord) {
        this.searchWord = searchWord;
    }

    public String getDitcCd() {
        return ditcCd;
    }

    public void setDitcCd(String ditcCd) {
        this.ditcCd = ditcCd;
    }

    public String getPubDttmQuery() {
        return pubDttmQuery;
    }

    public void setPubDttmQuery(String pubDttmQuery) {
        this.pubDttmQuery = UtilString.SQLInjectionFilter2(pubDttmQuery);
    }

    public String getPubYn() {
        return pubYn;
    }

    public void setPubYn(String pubYn) {
        this.pubYn = pubYn;
    }

    public String getInfExp() {
        return infExp;
    }

    public void setInfExp(String infExp) {
        this.infExp = infExp;
    }

    public String getGridItem() {
        return gridItem;
    }

    public void setGridItem(String gridItem) {
        this.gridItem = gridItem;
    }

    public String getPopColId() {
        return popColId;
    }

    public void setPopColId(String popColId) {
        this.popColId = popColId;
    }

    public String getFsclYy() {
        return fsclYy;
    }

    public void setFsclYy(String fsclYy) {
        this.fsclYy = fsclYy;
    }

    public String getFsclCd() {
        return fsclCd;
    }

    public void setFsclCd(String fsclCd) {
        this.fsclCd = fsclCd;
    }

    public String getFldCd() {
        return fldCd;
    }

    public void setFldCd(String fldCd) {
        this.fldCd = fldCd;
    }

    public String getSectCd() {
        return sectCd;
    }

    public void setSectCd(String sectCd) {
        this.sectCd = sectCd;
    }

    public String getPgmCd() {
        return pgmCd;
    }

    public void setPgmCd(String pgmCd) {
        this.pgmCd = pgmCd;
    }

    public String getGofDivCd() {
        return gofDivCd;
    }

    public void setGofDivCd(String gofDivCd) {
        this.gofDivCd = gofDivCd;
    }

    public String getMarkerVal() {
        return markerVal;
    }

    public void setMarkerVal(String markerVal) {
        this.markerVal = markerVal;
    }

    public String getRyposYn() {
        return ryposYn;
    }

    public void setRyposYn(String ryposYn) {
        this.ryposYn = ryposYn;
    }

    public String getCateFullnm() {
        return cateFullnm;
    }

    public void setCateFullnm(String cateFullnm) {
        this.cateFullnm = cateFullnm;
    }

    public String getOrgCd() {
        return orgCd;
    }

    public void setOrgCd(String orgCd) {
        this.orgCd = orgCd;
    }

    public String getCateId() {
        return cateId;
    }

    public void setCateId(String cateId) {
        this.cateId = cateId;
    }

    public String getOffcCd() {
        return offcCd;
    }

    public void setOffcCd(String offcCd) {
        this.offcCd = offcCd;
    }

    public String getAcctCd() {
        return acctCd;
    }

    public void setAcctCd(String acctCd) {
        this.acctCd = acctCd;
    }

    public String getFsYn() {
        return fsYn;
    }

    public void setFsYn(String fsYn) {
        this.fsYn = fsYn;
    }

    public String getFsCd() {
        return fsCd;
    }

    public void setFsCd(String fsCd) {
        this.fsCd = fsCd;
    }

    public String getIkwanCd() {
        return ikwanCd;
    }

    public void setIkwanCd(String ikwanCd) {
        this.ikwanCd = ikwanCd;
    }

    public String getIhangCd() {
        return ihangCd;
    }

    public void setIhangCd(String ihangCd) {
        this.ihangCd = ihangCd;
    }

    public String getCitmCd() {
        return citmCd;
    }

    public void setCitmCd(String citmCd) {
        this.citmCd = citmCd;
    }

    public String getGssYn() {
        return gssYn;
    }

    public void setGssYn(String gssYn) {
        this.gssYn = gssYn;
    }

    public String getxPos() {
        return xPos;
    }

    public void setxPos(String xPos) {
        this.xPos = xPos;
    }

    public String getyPos() {
        return yPos;
    }

    public void setyPos(String yPos) {
        this.yPos = yPos;
    }

    public String getMapLevel() {
        return mapLevel;
    }

    public void setMapLevel(String mapLevel) {
        this.mapLevel = mapLevel;
    }

    public String getMpbFsclCd() {
        return mpbFsclCd;
    }

    public void setMpbFsclCd(String mpbFsclCd) {
        this.mpbFsclCd = mpbFsclCd;
    }

    public String getConnWhere() {
        return connWhere;
    }

    public void setConnWhere(String connWhere) {
        this.connWhere = connWhere;
    }

    public int getfColCurrPage() {
        return fColCurrPage;
    }

    public void setfColCurrPage(int fColCurrPage) {
        this.fColCurrPage = fColCurrPage;
    }

    public String getFscl2Cd() {
        return fscl2Cd;
    }

    public void setFscl2Cd(String fscl2Cd) {
        this.fscl2Cd = fscl2Cd;
    }

    public String getTselectQuery() {
        return tselectQuery;
    }

    public void setTselectQuery(String tselectQuery) {
        this.tselectQuery = tselectQuery;
    }

    public String getAccCd() {
        return accCd;
    }

    public void setAccCd(String accCd) {
        this.accCd = accCd;
    }

    public String getPrssAccCd() {
        return prssAccCd;
    }

    public void setPrssAccCd(String prssAccCd) {
        this.prssAccCd = prssAccCd;
    }

    public String getCclCd() {
        return cclCd;
    }

    public void setCclCd(String cclCd) {
        this.cclCd = cclCd;
    }

    public String getCclNm() {
        return cclNm;
    }

    public void setCclNm(String cclNm) {
        this.cclNm = cclNm;
    }

    public String getInfSrv() {
        return infSrv;
    }

    public void setInfSrv(String infSrv) {
        this.infSrv = infSrv;
    }

    public String getFvtDataYn() {
        return fvtDataYn;
    }

    public void setFvtDataYn(String fvtDataYn) {
        this.fvtDataYn = fvtDataYn;
    }

    public String getFvtDataOrder() {
        return fvtDataOrder;
    }

    public void setFvtDataOrder(String fvtDataOrder) {
        this.fvtDataOrder = fvtDataOrder;
    }

    public String getWgsQuery() {
        return wgsQuery;
    }

    public void setWgsQuery(String wgsQuery) {
        this.wgsQuery = wgsQuery;
    }
    
    

}
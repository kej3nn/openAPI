package egovframework.admin.basicinf.service;

import java.io.Serializable;
import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

import egovframework.common.grid.CommVo;

/**
 * 코드에 대한 데이터 처리 모델
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */
@SuppressWarnings("serial")
public class CommOrg extends CommVo implements Serializable {


    private String orgCd;
    private String orgCdUpd;
    private String orgNm;
    private String orgNmEng;
    private String orgCdTop;
    private String orgCdPar;
    private String orgCdParCd;
    private String orgCdParNm;
    private String orgLvl;                // 그룹레벨
    private String useYn;                // 사용여부
    private String orgTypeCd;            // 조직구분코드
    private String orgTypeNm;            // 조직구분명
    private String orgCdTopCd;            // 상위조직코드
    private String orgCdTopNm;            // 상위조직코드명
    private String orgFullNm;            // 전체한글조직명
    private String orgFullNmEng;        // 전체영문조직명
    private String orgType;
    private String orgUrl;                // 홈페이지
    private String orgAddr;                // 한글주소
    private String orgAddrEng;            // 영문주소
    private String mngId;                // 공공데이터포털ID
    private String searchWd;            // 검색어유형
    private String searchWord;            // 검색어
    private String vOrder;                // 트리순서
    private String grpCd;               // 그룹코드
    private String orgTel;                // 조직대표번호


    public String getOrgTel() {
        return orgTel;
    }


    public void setOrgTel(String orgTel) {
        this.orgTel = orgTel;
    }


    public String getGrpCd() {
        return grpCd;
    }


    public void setGrpCd(String grpCd) {
        this.grpCd = grpCd;
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


    public String getOrgNmEng() {
        return orgNmEng;
    }


    public void setOrgNmEng(String orgNmEng) {
        this.orgNmEng = orgNmEng;
    }


    public String getOrgCdTop() {
        return orgCdTop;
    }


    public void setOrgCdTop(String orgCdTop) {
        this.orgCdTop = orgCdTop;
    }


    public String getOrgCdPar() {
        return orgCdPar;
    }


    public void setOrgCdPar(String orgCdPar) {
        this.orgCdPar = orgCdPar;
    }


    public String getOrgLvl() {
        return orgLvl;
    }


    public void setOrgLvl(String orgLvl) {
        this.orgLvl = orgLvl;
    }


    public String getUseYn() {
        return useYn;
    }


    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }


    public String getOrgTypeCd() {
        return orgTypeCd;
    }


    public void setOrgTypeCd(String orgTypeCd) {
        this.orgTypeCd = orgTypeCd;
    }


    public String getOrgTypeNm() {
        return orgTypeNm;
    }

    public void setOrgTypeNm(String orgTypeNm) {
        this.orgTypeNm = orgTypeNm;
    }


    public String getOrgCdTopCd() {
        return orgCdTopCd;
    }


    public void setOrgCdTopCd(String orgCdTopCd) {
        this.orgCdTopCd = orgCdTopCd;
    }


    public String getOrgCdTopNm() {
        return orgCdTopNm;
    }


    public void setOrgCdTopNm(String orgCdTopNm) {
        this.orgCdTopNm = orgCdTopNm;
    }


    public String getOrgFullNm() {
        return orgFullNm;
    }


    public void setOrgFullNm(String orgFullNm) {
        this.orgFullNm = orgFullNm;
    }


    public String getOrgFullNmEng() {
        return orgFullNmEng;
    }


    public void setOrgFullNmEng(String orgFullNmEng) {
        this.orgFullNmEng = orgFullNmEng;
    }


    public String getOrgType() {
        return orgType;
    }


    public void setOrgType(String orgType) {
        this.orgType = orgType;
    }


    public String getOrgUrl() {
        return orgUrl;
    }


    public void setOrgHomePage(String orgUrl) {
        this.orgUrl = orgUrl;
    }


    public String getOrgAddr() {
        return orgAddr;
    }


    public void setOrgAddr(String orgAddr) {
        this.orgAddr = orgAddr;
    }


    public String getOrgAddrEng() {
        return orgAddrEng;
    }


    public void setOrgAddrEng(String orgAddrEng) {
        this.orgAddrEng = orgAddrEng;
    }


    public String getMngId() {
        return mngId;
    }


    public void setGovPotId(String mngId) {
        this.mngId = mngId;
    }


    public String getSearchWd() {
        return searchWd;
    }


    public void setSearchWd(String searchWd) {
        this.searchWd = searchWd;
    }


    public String getOrgCdParNm() {
        return orgCdParNm;
    }


    public void setOrgCdParNm(String orgCdParNm) {
        this.orgCdParNm = orgCdParNm;
    }


    public void setOrgUrl(String orgUrl) {
        this.orgUrl = orgUrl;
    }


    public String getOrgCdParCd() {
        return orgCdParCd;
    }


    public void setOrgCdParCd(String orgCdParCd) {
        this.orgCdParCd = orgCdParCd;
    }


    public void setMngId(String mngId) {
        this.mngId = mngId;
    }

    public String getOrgCdUpd() {
        return orgCdUpd;
    }


    public void setOrgCdUpd(String orgCdUpd) {
        this.orgCdUpd = orgCdUpd;
    }


    public String getSearchWord() {
        return searchWord;
    }


    public void setSearchWord(String searchWord) {
        this.searchWord = searchWord;
    }

    public String getvOrder() {
        return vOrder;
    }

    public void setvOrder(String vOrder) {
        this.vOrder = vOrder;
    }


    /**
     * toString 메소드를 대치한다.
     */
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
}

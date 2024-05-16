package egovframework.admin.basicinf.service;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

import egovframework.common.grid.CommVo;

@SuppressWarnings("serial")
public class CommMenuAcc extends CommVo implements Serializable {


    private int menuId;
    private String menuNm;
    private int menuIdPar;
    private int reCnt;
    private String menuTitle;
    private String menuUrl;
    private String menuParam;
    private String menuDesc;
    private int vOrder;
    private String useYn;
    private String regId;
    private String regDttm;
    private String updId;
    private String updDttm;
    private int level;
    private String menuNav;
    private int menuAcc;
    private String accCd;
    private int menuLv;
    private String menuIdParDesc;
    private String searchWd;
    private String searchWord;
    private String menuGrpCd;
    private String menuSiteCd;


    public String getMenuSiteCd() {
        return menuSiteCd;
    }


    public void setMenuSiteCd(String menuSiteCd) {
        this.menuSiteCd = menuSiteCd;
    }


    public int getMenuId() {
        return menuId;
    }


    public void setMenuId(int menuId) {
        this.menuId = menuId;
    }


    public String getMenuNm() {
        return menuNm;
    }


    public void setMenuNm(String menuNm) {
        this.menuNm = menuNm;
    }


    public int getMenuIdPar() {
        return menuIdPar;
    }


    public void setMenuIdPar(int menuIdPar) {
        this.menuIdPar = menuIdPar;
    }


    public String getMenuUrl() {
        return menuUrl;
    }


    public void setMenuUrl(String menuUrl) {
        this.menuUrl = menuUrl;
    }


    public String getMenuParam() {
        return menuParam;
    }


    public void setMenuParam(String menuParam) {
        this.menuParam = menuParam;
    }


    public String getMenuDesc() {
        return menuDesc;
    }


    public void setMenuDesc(String menuDesc) {
        this.menuDesc = menuDesc;
    }


    public int getvOrder() {
        return vOrder;
    }


    public void setvOrder(int vOrder) {
        this.vOrder = vOrder;
    }


    public String getUseYn() {
        return useYn;
    }


    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }


    public String getRegId() {
        return regId;
    }


    public void setRegId(String regId) {
        this.regId = regId;
    }


    public String getRegDttm() {
        return regDttm;
    }


    public void setRegDttm(String regDttm) {
        this.regDttm = regDttm;
    }


    public String getUpdId() {
        return updId;
    }


    public void setUpdId(String updId) {
        this.updId = updId;
    }


    public String getUpdDttm() {
        return updDttm;
    }


    public void setUpdDttm(String updDttm) {
        this.updDttm = updDttm;
    }


    public int getLevel() {
        return level;
    }


    public void setLevel(int level) {
        this.level = level;
    }


    public String getMenuNav() {
        return menuNav;
    }


    public void setMenuNav(String menuNav) {
        this.menuNav = menuNav;
    }

    public int getReCnt() {
        return reCnt;
    }


    public void setReCnt(int reCnt) {
        this.reCnt = reCnt;
    }


    public String getMenuTitle() {
        return menuTitle;
    }


    public void setMenuTitle(String menuTitle) {
        this.menuTitle = menuTitle;
    }


    public int getMenuAcc() {
        return menuAcc;
    }


    public void setMenuAcc(String menuAcc) {
        this.menuAcc = Integer.parseInt(menuAcc);
    }


    public int getMenuLv() {
        return menuLv;
    }


    public void setMenuLv(int menuLv) {
        this.menuLv = menuLv;
    }


    public String getMenuIdParDesc() {
        return menuIdParDesc;
    }


    public void setMenuIdParDesc(String menuIdParDesc) {
        this.menuIdParDesc = menuIdParDesc;
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


    public String getAccCd() {
        return accCd;
    }


    public void setAccCd(String accCd) {
        this.accCd = accCd;
    }


    public String getMenuGrpCd() {
        return menuGrpCd;
    }


    public void setMenuGrpCd(String menuGrpCd) {
        this.menuGrpCd = menuGrpCd;
    }


    /**
     * toString 메소드를 대치한다.
     */
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
}

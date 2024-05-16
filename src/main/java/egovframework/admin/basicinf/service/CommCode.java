package egovframework.admin.basicinf.service;

import java.io.Serializable;
import java.util.ArrayList;
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
public class CommCode extends CommVo implements Serializable {


    private String grpCd;            //그룹코드
    private String ditcCd;
    private String ditcNm;
    private String ditcNmEng;
    private String refCd;
    private String useYn;
    private String vOrder;
    private String valueCd;

    private String grpNm;
    private String valueCd2;
    private String cdExp;
    private String cdExpEng;
    private String lockYn;
    private String grpIs;        // 그룹코드인지 여부
    private String grpCib;        // 서브코드가 존재하는지 여부
    private String preGrpCd;
    private String preDitcCd;

    private List<CommCode> commCodeLists;


    public String getGrpCd() {
        return grpCd;
    }


    public void setGrpCd(String grpCd) {
        this.grpCd = grpCd;
    }


    public String getDitcCd() {
        return ditcCd;
    }


    public void setDitcCd(String ditcCd) {
        this.ditcCd = ditcCd;
    }


    public String getDitcNm() {
        return ditcNm;
    }


    public void setDitcNm(String ditcNm) {
        this.ditcNm = ditcNm;
    }


    public String getDitcNmEng() {
        return ditcNmEng;
    }


    public void setDitcNmEng(String ditcNmEng) {
        this.ditcNmEng = ditcNmEng;
    }


    public String getRefCd() {
        return refCd;
    }


    public void setRefCd(String refCd) {
        this.refCd = refCd;
    }


    public String getUseYn() {
        return useYn;
    }


    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }


    public String getvOrder() {
        return vOrder;
    }


    public void setvOrder(String vOrder) {
        this.vOrder = vOrder;
    }


    public String getValueCd() {
        return valueCd;
    }


    public void setValueCd(String valueCd) {
        this.valueCd = valueCd;
    }


    public String getGrpNm() {
        return grpNm;
    }


    public void setGrpNm(String grpNm) {
        this.grpNm = grpNm;
    }


    public String getValueCd2() {
        return valueCd2;
    }


    public void setValueCd2(String valueCd2) {
        this.valueCd2 = valueCd2;
    }


    public String getCdExp() {
        return cdExp;
    }


    public void setCdExp(String cdExp) {
        this.cdExp = cdExp;
    }


    public String getCdExpEng() {
        return cdExpEng;
    }


    public void setCdExpEng(String cdExpEng) {
        this.cdExpEng = cdExpEng;
    }


    public String getLockYn() {
        return lockYn;
    }


    public void setLockYn(String lockYn) {
        this.lockYn = lockYn;
    }


    public String getGrpIs() {
        return grpIs;
    }


    public void setGrpIs(String grpIs) {
        this.grpIs = grpIs;
    }


    public String getPreGrpCd() {
        return preGrpCd;
    }


    public void setPreGrpCd(String preGrpCd) {
        this.preGrpCd = preGrpCd;
    }


    public String getPreDitcCd() {
        return preDitcCd;
    }


    public void setPreDitcCd(String preDitcCd) {
        this.preDitcCd = preDitcCd;
    }


    public List<CommCode> getCommCodeLists() {
        List<CommCode> aliCommCodeLists;
        if (commCodeLists != null && commCodeLists.size() > 0) {
            aliCommCodeLists = new ArrayList<CommCode>();
            for (CommCode c : commCodeLists) {
                aliCommCodeLists.add(c);
            }
            return aliCommCodeLists;
        } else {
            return null;
        }
    }

    public void setCommCodeLists(List<CommCode> commCodeLists) {
        if (commCodeLists != null && commCodeLists.size() > 0) {
            this.commCodeLists = new ArrayList<CommCode>();
            for (int i = 0; i < commCodeLists.size(); i++) {
                if (commCodeLists.get(i) != null) {
                    this.commCodeLists.add(commCodeLists.get(i));
                }
            }
        } else {
            this.commCodeLists = null;
        }
    }


    public String getGrpCib() {
        return grpCib;
    }


    public void setGrpCib(String grpCib) {
        this.grpCib = grpCib;
    }


    /**
     * toString 메소드를 대치한다.
     */
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

}
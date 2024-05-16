package egovframework.admin.expose.service;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;
import org.apache.commons.lang.builder.ToStringBuilder;

import egovframework.common.grid.CommVo;

/**
 * 코드에 대한 데이터 처리 모델
 *
 * @author JIS
 * @version 1.0
 * @see
 * @since 2019.08.27
 */
@Setter
@Getter
@SuppressWarnings("serial")
public class AdminInstMgmt extends CommVo implements Serializable {


    private String instCd;                //기관코드
    private String instNm;                //기관명
    private String instRdt;                //기관등록일자
    private String instBankNm;            //기관은행명
    private String instAccNm;            //기관계좌명
    private String instAccNo;            //기관계좌번호
    private String instOrd;                //기관순서
    private String instPno;                //기관전화번호
    private String instOfslFlNm;        //기관직인파일명
    private String instOfslFlPhNm;        //기관직인실제파일명
    private String inscfNm;                //기관장명
    private String instChrgDeptNm;        //담당부서
    private String instChrgCentCgp1Nm;    //결재권자1
    private String instChrgCentCgp2Nm;    //결재권자2
    private String instChrgCentCgp3Nm;    //결재권자3
    private String instFaxNo;            //기관팩스번호

    private String instCdUpd;
    private String useYn;                // 사용여부


    /**
     * toString 메소드를 대치한다.
     */
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
}

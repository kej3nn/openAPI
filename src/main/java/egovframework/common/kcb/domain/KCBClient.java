package egovframework.common.kcb.domain;

import java.io.Serializable;

@SuppressWarnings("serial")
public class KCBClient implements Serializable {
    private String cpCd;        // 회원사 코드 (V45640000000)
    private String returnUrl;   // 인증 완료 후 이동될 full URL - 페이지 절대 URL
    private String reqCauseCd;  // 인증 요청 사유 코드
    private String channelCd;   // 채널 코드 (공백 가능, 정산 등의 이유로 채널 구분이 필요한 경우 입력)

    private String txSeqNo;     // KCB 모듈에서 채번된 거래 일련번호 (최대 20 글자)
    private String mdlToken;    // KCB 로부터 받은 토큰, 인증결과 요청 시 전달해야 함 (UUID 32byte)

    private String resultCd;    // 인증결과 코드
    private String resultMsg;   // 인증결과 메시지
    private String returnMsg;   // 리턴메시지 (공백 가능. 최종 결과요청에서 같이 전달받고자 하는 값이 있다면 설정.)

    // 인증 거래 결과
    private String name;        // 이름
    private String birthDate;   // 생년월일 (YYYYMMDD)
    private String genderCode;  // 성별 코드 (남성:M, 여성:F)
    private String nationalInfo;// 내/외국인 코드 (내국인:L, 외국인:F)
    private String dupInfo;     // 중복가입 확인값 (DI값, 64byte)
    private String coInfo1;     // 연계정보 확인값 (CI값, 88byte)
    private String coInfo2;     // 연계정보 확인값 (현재는 빈값, 추후 CI_UPDATE 가 변경될 경우 전 버전의 CI가 입력됨)
    private String ciUpdate;    // CI 갱신 횟수
    // phone only
    private String telComCd;    // 통신사 구분 (01:SKT, 02:KT, 03:LGU+, 04:알뜰폰 SKT, 04:알뜰폰 KT, 04:알뜰폰 LGU+)
    private String telNo;       // 휴대폰 번호 (ex:01012345678)
    // ipin only
    private String vssn;        // 아이핀에 매핑되는 가상의 13자리 숫자

    public String getCpCd() {
        return cpCd;
    }

    public void setCpCd(String cpCd) {
        this.cpCd = cpCd;
    }

    public String getReturnUrl() {
        return returnUrl;
    }

    public void setReturnUrl(String returnUrl) {
        this.returnUrl = returnUrl;
    }

    public String getReqCauseCd() {
        return reqCauseCd;
    }

    public void setReqCauseCd(String reqCauseCd) {
        this.reqCauseCd = reqCauseCd;
    }

    public String getChannelCd() {
        return channelCd;
    }

    public void setChannelCd(String channelCd) {
        this.channelCd = channelCd;
    }

    public String getTxSeqNo() {
        return txSeqNo;
    }

    public void setTxSeqNo(String txSeqNo) {
        this.txSeqNo = txSeqNo;
    }

    public String getMdlToken() {
        return mdlToken;
    }

    public void setMdlToken(String mdlToken) {
        this.mdlToken = mdlToken;
    }

    public String getResultCd() {
        return resultCd;
    }

    public void setResultCd(String resultCd) {
        this.resultCd = resultCd;
    }

    public String getResultMsg() {
        return resultMsg;
    }

    public void setResultMsg(String resultMsg) {
        this.resultMsg = resultMsg;
    }

    public String getReturnMsg() {
        return returnMsg;
    }

    public void setReturnMsg(String returnMsg) {
        this.returnMsg = returnMsg;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(String birthDate) {
        this.birthDate = birthDate;
    }

    public String getGenderCode() {
        return genderCode;
    }

    public void setGenderCode(String genderCode) {
        this.genderCode = genderCode;
    }

    public String getNationalInfo() {
        return nationalInfo;
    }

    public void setNationalInfo(String nationalInfo) {
        this.nationalInfo = nationalInfo;
    }

    public String getDupInfo() {
        return dupInfo;
    }

    public void setDupInfo(String dupInfo) {
        this.dupInfo = dupInfo;
    }

    public String getCoInfo1() {
        return coInfo1;
    }

    public void setCoInfo1(String coInfo1) {
        this.coInfo1 = coInfo1;
    }

    public String getCoInfo2() {
        return coInfo2;
    }

    public void setCoInfo2(String coInfo2) {
        this.coInfo2 = coInfo2;
    }

    public String getCiUpdate() {
        return ciUpdate;
    }

    public void setCiUpdate(String ciUpdate) {
        this.ciUpdate = ciUpdate;
    }

    public String getTelComCd() {
        return telComCd;
    }

    public void setTelComCd(String telComCd) {
        this.telComCd = telComCd;
    }

    public String getTelNo() {
        return telNo;
    }

    public void setTelNo(String telNo) {
        this.telNo = telNo;
    }

    public String getVssn() {
        return vssn;
    }

    public void setVssn(String vssn) {
        this.vssn = vssn;
    }

}

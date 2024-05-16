package egovframework.common.kcb.domain;

import java.io.Serializable;

@SuppressWarnings("serial")
public class CertInfo implements Serializable {
    private String name;           // 이름
    private String gender;         // 성별 코드
    private String birthDate;      // 생년월일 (YYYYMMDD)
    private String dupInfo;        // 중복가입 확인값 (DI값)
    private String coInfo;         // 연계정보 확인값 (CI값, 88byte)
    private String nationalInfo;   // 내외국인구분
    private String authInfo;       // 본인확인수단

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(String birthDate) {
        this.birthDate = birthDate;
    }

    public String getDupInfo() {
        return dupInfo;
    }

    public void setDupInfo(String dupInfo) {
        this.dupInfo = dupInfo;
    }

    public String getCoInfo() {
        return coInfo;
    }

    public void setCoInfo(String coInfo) {
        this.coInfo = coInfo;
    }

    public String getNationalInfo() {
        return nationalInfo;
    }

    public void setNationalInfo(String nationalInfo) {
        this.nationalInfo = nationalInfo;
    }

    public String getAuthInfo() {
        return authInfo;
    }

    public void setAuthInfo(String authInfo) {
        this.authInfo = authInfo;
    }
}

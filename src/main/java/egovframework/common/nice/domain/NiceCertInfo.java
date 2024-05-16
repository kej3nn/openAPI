package egovframework.common.nice.domain;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class NiceCertInfo {
    private String name;           // 이름
    private String gender;         // 성별 코드
    private String birthDate;      // 생년월일 (YYYYMMDD)
    private String dupInfo;        // 중복가입 확인값 (DI값)
    private String coInfo;         // 연계정보 확인값 (CI값, 88byte)
    private String nationalInfo;   // 내외국인구분
    private String authInfo;       // 본인확인수단
}

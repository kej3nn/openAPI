package egovframework.common.nice.domain;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class NiceClient {
    private String sReturnUrl;  // 성공시 이동될 full URL - success 페이지 절대 URL
    private String sErrorUrl;   // 실패시 이동될 full URL - fail 페이지 절대 URL
    private String sEncData;    // 업체정보 암호화 데이타 (사이트코드 외 설정사항에 대한 정보)

    private String param_r1;    // 업체 추가설정 파라미터 1
    private String param_r2;    // 업체 추가설정 파라미터 2
    private String param_r3;    // 업체 추가설정 파라미터 3

    private String sEncodeData;     // NICE 평가정보로부터 받은 암호화된 사용자 결과 데이터
    private String sPlainData;      // 암호화된 결과 데이터의 복호화 (키의길이:키:값의길이:값)
    private String sCipherTime;     // 복호화한 시간
    private String sRequestNumber;  // 요청 번호
    private String sResponseNumber; // 인증 고유번호
    private String sAuthType;       // 인증 수단

    private String sMessage;    // 인증결과메시지
    private int iReturn;        // 인증결과코드
}

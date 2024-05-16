package egovframework.common.nice.domain;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class CheckPlusClient extends NiceClient {
    private String reqSeq;          // 최대 30 Byte (생성/임의값)
    private String authType;        // M: 휴대폰 C: 카드 X: 인증서 P: 삼성패스
    private String resSeq;          // 24 Byte
    private String name;            // 50 Byte, EUC-KR
    private String utf8Name;        // 50 Byte, UTF-8, URLDecode 처리 필요
    private String birthdate;       // YYYYMMDD
    private String gender;          // 0: 여성, 1: 남성
    private String nationainfo;     // 0: 내국인, 1: 외국인
    private String di;              // 64 Byte, 카드-생년월일 인증 시 리턴X
    private String ci;              // 88 Byte, 카드-생년월일 인증 시 리턴X
    private String mobileCo;        // 3 Byte, 핸드폰 인증 전용
    private String mobileNo;        // 24 Byte, 핸드폰 인증 전용
    private String errCode;         // 4 Byte, 응답코드 문서 참조
}

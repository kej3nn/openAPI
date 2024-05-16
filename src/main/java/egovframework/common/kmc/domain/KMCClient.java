package egovframework.common.kmc.domain;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class KMCClient {
    // 서비스 호출 시 전송 데이터
    private String cpId;        // 회원사 ID. 한국모바일인증㈜에서 발급한 CP ID 정보 (ASBT1001)
    private String urlCode;     // URL 코드. 서비스 호출 웹 페이지마다 등록된 코드 정보 (V45640000000)
    private String certNum;     // 요청 번호. 서비스 호출 시 Unique한 값을 생성하여 전송 (결과 수신 시 복호화 KEY로 사용함)
    private String date;        // 요청 일시. 요청년도+월+일+시+분+초(YYYYMMDDhhmmss)
    private String certMet;     // 본인 확인 방법. 인증방식(T:?, M:휴대폰, P:공동인증서)
    private String plusInfo;    // 추가 DATA 정보. 최대 5개까지 추가요청 정보 지원 (Var1, Var2, Var3, Var4, Var5) – 리턴정보
    // 추가 요청정보가 여러 개인 경우 구분자 "/" , "|" , "&" 를 제외한 특수 기호를 이용하여 구분
    private String extendVar;   // 확장 변수. 데이터 복호화를 위한 확장필드 (“0000000000000000”)

    private String tr_cert;     // 요청 전송 데이터(구분자:"/", 대소문자 구분, data 순서)
    private String tr_url;      // 결과 수신 URL
    private String tr_add;      // 결과 수신 URL

    // 서비스 결과 수신 데이터
    private String CI;          // 연계정보. (CI값, 88byte)
    private String phoneNo;     // 휴대폰 번호
    private String phoneCorp;   // 이동통신사. SKT:SK텔레콤, KTF:KT, LGT:LGU+, SKM:SKT알뜰폰, KTM:KT알뜰폰, LGM:LGU+알뜰폰
    private String birthDay;    // 생년월일 (YYYYMMDD)
    private String gender;      // 성별 코드 (0:남성, 1:여성)
    private String Nation;      // 내/외국인 코드 (0:내국인, 1:외국인)
    private String Name;        // 이름
    private String Result;      // 본인인증 결과값 (Y:성공, N:실패, F:오류)
    private String Ip;          // 이용자 ip 주소
    private String DI;          // 중복가입 확인값. 웹사이트 기준 (DI값, 64byte)

    private String M_name;      // 14세 미만 정보(입력정보 리턴). 이름
    private String M_birthDay;  // 14세 미만 정보(입력정보 리턴). 생년월일 (YYYYMMDD)
    private String M_Gender;    // 14세 미만 정보(입력정보 리턴). 성별 코드 (0:남성, 1:여성)
    private String M_nation;    // 14세 미만 정보(입력정보 리턴). 내/외국인 코드 (0:내국인, 1:외국인)

    private String rec_cert;    // 결과 수신 데이터(구분자:"/", 대소문자 구분, data 순서)
}

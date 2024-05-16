package egovframework.common;

/**
 * 공통환경변수
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */
public class WiseOpenConfig {

    //게시물 페이지 처리 - 페이지당 게시물수
    public static final int PAGEUNIT = 10;
    //게시물 페이지 처리 - 페이지 리스트 수
    public static final int PAGESIZE = 10;
    //IBSHEET페이지 조회건수
    public static final int IBSHEETPAGENOW = 50;
    //암호화 password
    public static final String DIGESTED_PASSWORD = "WISEOPEN";
    //등록 페이지 구분(신규)
    public static final String STATUS_I = "INSERT";
    //등록 페이지 구분(변경)
    public static final String STATUS_U = "UPDATE";
    //등록 페이지 구분(변경2)
    public static final String STATUS_U2 = "UPDATE2";
    //등록 페이지 구분(삭제)
    public static final String STATUS_D = "DELETE";
    //파일 업로드 구분(파일서비스)
    public static final String FILE_SERVICE = "FS";
    //파일 업로드 구분(링크서비스)
    public static final String LINK_SERVICE = "LS";
    //파일 업로드 구분(게시판)
    public static final String FILE_BBS = "FB";
    //파일 업로드 구분(게시판)	보도자료만 사용
    public static final String FILE_BBS2 = "FB2";
    //파일 업로드 구분(공표자료)
    public static final String FILE_PUBLISH = "FP";
    //파일 업로드 구분(자료취합)
    public static final String FILE_DATA_COMBINE = "DC";
    //파일 업로드 구분(파일서비스)
    public static final String MEDIA_SERVICE = "MS";
    //파일 업로드 구분(파일서비스)
    public static final String MEDIA_TMNL_IMG = "MT";
    //파일 업로드 구분(분류정보섬네일)
    public static final String FILE_DATA_CATE = "OC";

    //등록 페이지 상태 에러
    public static final int STATUS_ERR = -100;
    //등록 페이지 상태 에러
    public static final int AJAX_AUTHENTIC_ERR_CODE = 9999;
    //등록 페이지 상태 에러
    public static final String LOG_KEY = "__WiseOpenKey__";
    //공백상태(SMS전송시 휴대전화가 없는경우)
    public static final int STATUS_EMPTY = 9998;

    //DS_CD => RAW
    public static final String DS_CD_RAW = "RAW";
    //DS_CD => TS
    public static final String DS_CD_TS = "TS";

    public static final int PAGE_BLOCK = 5;
    public static final int PAGE_SIZE = 10;

    public static final int PWD_CHANGE_PERIOD = 90;        //비밀번호 변경기간(90일)
    public static final int AGREE_YN_PERIOD = 550;        //약관 재동의 기간(약 1년 6개월)

    public static String SMS_RCV_HP = "15448822";    //SMS 송신 전화번호

    //public static String DATASET_OWNER = "GGOPENGOV";
    public static String DATASET_OWNER = "GGOPENCLT";
}

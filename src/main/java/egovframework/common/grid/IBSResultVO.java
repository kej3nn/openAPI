package egovframework.common.grid;


/**
 * ibsheet 실행 결과를 리턴하는 class
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */

public class IBSResultVO<T> {

    public T resultVO;

    public IBSRes RESULT = new IBSRes();

    public class IBSRes {
        public int CODE;
        public String MESSAGE;
        public int SEQ;
        public int SEQ2;
        public String GUBUN;
    }

    public IBSResultVO() {
    }

    public IBSResultVO(T resultvo, int code, String message) {
        this.resultVO = resultvo;
        this.RESULT.CODE = code;
        this.RESULT.MESSAGE = message;
    }

    public IBSResultVO(int code, String message) {
        this.RESULT.CODE = code;
        this.RESULT.MESSAGE = message;
    }

    public IBSResultVO(int code, String message, int bbsSeq) {
        this.RESULT.CODE = code;
        this.RESULT.MESSAGE = message;
        this.RESULT.SEQ = bbsSeq;
    }

    public IBSResultVO(int code, String message, String gubun) {
        this.RESULT.CODE = code;
        this.RESULT.MESSAGE = message;
        this.RESULT.GUBUN = gubun;
    }

    public IBSResultVO(int code, String message, int bbsSeq, int seq2) {
        this.RESULT.CODE = code;
        this.RESULT.MESSAGE = message;
        this.RESULT.SEQ = bbsSeq;
        this.RESULT.SEQ2 = seq2;
    }

    public IBSResultVO(int code, String message, String gubun, int fileSeq) {
        this.RESULT.CODE = code;
        this.RESULT.MESSAGE = message;
        this.RESULT.GUBUN = gubun;
        this.RESULT.SEQ = fileSeq;
    }

}

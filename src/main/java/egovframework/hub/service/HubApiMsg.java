package egovframework.hub.service;
/**
 * OPEN API MSG getting,setting class
 * @author wiseopen
 * @since 2014.04.17
 * @version 1.0
 * @see cheon
 *
 */
public class HubApiMsg {
	private String infoOk = "";				//INFO-000 : 정상 처리되었습니다.
	private String errMdt = "";				//ERROR-300 : 필수 값이 누락되어 있습니다.\n요청인자를 참고 하십시오.
	private String errKey = "";				//ERROR-290 : 인증키가 유효하지 않습니다.\n인증키가 없는 경우, 열린 데이터 광장 홈페이지에서 인증키를 신청하십시오.
	private String errService = "";			//ERROR-310 : 해당하는 서비스를 찾을 수 없습니다.\n요청인자 중 SERVICE를 확인하십시오.
	private String errCntType = "";			//ERROR-333 : 요청위치 값의 타입이 유효하지 않습니다.\n요청위치 값은 정수를 입력하세요.
	private String errCntTypeKey = "";		//ERROR-336 : 데이터요청은 한번에 최대 1,000건을 넘을 수 없습니다.\n요청종료위치에서 요청시작위치를 뺀 값이 1000을 넘지 않도록 수정하세요.
	private String errServer = "";			//ERROR-500 : 서버 오류입니다.\n지속적으로 발생시 열린 데이터 광장으로 문의(Q&A) 바랍니다.
	private String errDBCon = "";			//ERROR-600 : 데이터베이스 연결 오류입니다.\n지속적으로 발생시 열린 데이터 광장으로 문의(Q&A) 바랍니다.
	private String errSql = "";				//ERROR-601 : SQL 문장 오류 입니다.\n지속적으로 발생시 열린 데이터 광장으로 문의(Q&A) 바랍니다.
	private String infoData = "";			//INFO-200 : 해당하는 데이터가 없습니다.
	private String errLimit = "";			//ERROR-980 : 사용자정의 메시지 TB_USER_KEY.LIMIT_MSG
	private String errPause = "";			//ERROR-990 : 사용자정의 메시지 TB_USER_KEY.PAUSE_MSG
	private String msgString;
	private String infoUseKeyLimits;
	private String errApiTrf;
	
	public String getInfoOk() {
		return infoOk;
	}
	public void setInfoOk(String infoOk) {
		this.infoOk = infoOk;
	}
	public String getErrMdt() {
		return errMdt;
	}
	public void setErrMdt(String errMdt) {
		this.errMdt = errMdt;
	}
	public String getErrKey() {
		return errKey;
	}
	public void setErrKey(String errKey) {
		this.errKey = errKey;
	}
	public String getErrService() {
		return errService;
	}
	public void setErrService(String errService) {
		this.errService = errService;
	}
	public String getErrCntType() {
		return errCntType;
	}
	public void setErrCntType(String errCntType) {
		this.errCntType = errCntType;
	}
	public String getErrCntTypeKey() {
		return errCntTypeKey;
	}
	public void setErrCntTypeKey(String errCntTypeKey) {
		this.errCntTypeKey = errCntTypeKey;
	}
	public String getErrServer() {
		return errServer;
	}
	public void setErrServer(String errServer) {
		this.errServer = errServer;
	}
	public String getErrDBCon() {
		return errDBCon;
	}
	public void setErrDBCon(String errDBCon) {
		this.errDBCon = errDBCon;
	}
	public String getErrSql() {
		return errSql;
	}
	public void setErrSql(String errSql) {
		this.errSql = errSql;
	}
	public String getInfoData() {
		return infoData;
	}
	public void setInfoData(String infoData) {
		this.infoData = infoData;
	}
	public String getErrLimit() {
		return errLimit;
	}
	public void setErrLimit(String errLimit) {
		this.errLimit = errLimit;
	}
	public String getErrPause() {
		return errPause;
	}
	public void setErrPause(String errPause) {
		this.errPause = errPause;
	}
	public String getMsgString() {
		return msgString;
	}
	public void setMsgString(String msgString) {
		this.msgString = msgString;
	}
	public String getInfoUseKeyLimits() {
		return infoUseKeyLimits;
	}
	public void setInfoUseKeyLimits(String infoUseKeyLimits) {
		this.infoUseKeyLimits = infoUseKeyLimits;
	}
	public String getErrApiTrf() {
		return errApiTrf;
	}
	public void setErrApiTrf(String errApiTrf) {
		this.errApiTrf = errApiTrf;
	}
}

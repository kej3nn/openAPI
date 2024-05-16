package egovframework.ggportal.data.service;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 데이터 시각화 서비스
 * @author hsJang
 *
 */
public interface PortalOpenVisualService {

	/**
	 * 데이터 시각화 목록 조회
	 * @param params
	 * @return
	 */
	public Paging searchListVisual(Params params);
	
	// 2015.09.13 김은삼 [1] 메타정보 조회 SQL 추가 BEGIN
	/**
	 * 데이터 시각화 메타정보를 조회한다.
	 * 
	 * @param params 파라메터
	 * @return 조회결과
	 */
	public Record selectVisualMeta(Params params);
	// 2015.09.13 김은삼 [1] 메타정보 조회 SQL 추가 END
	
	/**
	 * 데이터 시각화 상세 정보 조회
	 * @param params
	 * @return
	 */
	public Object selectVisualData(Params params);
	

}

package egovframework.admin.infset.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;
import egovframework.common.grid.IBSheetListVO;

/**
 * 정보공개 문서를 관리하는 인터페이스
 * @author	JHKIM
 * @version 1.0
 * @since   2019/08/05
 */
public interface DocInfMgmtService {
	
	public Paging selectDocInfMainListPaging(Params params);
	
	public Record selectDtl(Params params);
	
	Result saveDocInf(Params params);
	
	Result deleteDocInf(Params params);
	
	List<Record> selectDocInfCatePop(Params params);
	
	List<Record> selectDocInfCate(Params params);
	
	List<Record> selectDocInfUsr(Params params);
	
	Result updateDocInfOpenState(Params params);
	
	List<Record> selectDocInfFile(Params params);
	
	Result saveDocInfFile(HttpServletRequest request, Params params);
	
	Result deleteDocInfFile(Params params);
	
	List<Record> selectDocInfFileSrcFileSeq(Params params);
	
	Result saveDocInfFileOrder(Params params);
	
	Record selectDocInfFileThumbnail(Params params);
	
}

package egovframework.soportal.stat.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 통계표를 관리하는 DAO 클래스
 * @author	소프트온
 * @version 1.0
 * @since   2017/09/22
 */

@Repository(value="directStatListDao")
public class DirectStatListDao extends BaseDao {
	
	/**
	 * 게시판 통계표 컨텐츠를 가져온다.
	 * @param params
	 * @return
	 */
	public Record selectContBbsTbl(Params params) {
		return (Record) select("statListDao.selectContBbsTbl", params);
	}
	
	/**
	 * 게시판 통계표 컨텐츠 목록을 가져온다(용어설명)
	 * @param params
	 * @return
	 */
	public List<Record> selectContBbsTblList(Params params) {
		return (List<Record>) list("statListDao.selectContBbsTblList", params);
	}
	
	/**
	 * 게시판 통계표 컨텐츠 파일목록을 가져온다.
	 * @param params
	 * @return
	 */
	public List<Record> selectContBbsFileList(Params params) {
		return (List<Record>) list("statListDao.selectContBbsFileList", params);
	}
	
	/**
	 * 게시판 통계표 컨텐츠 링크목록을 가져온다.
	 * @param params
	 * @return
	 */
	public List<Record> selectContBbsLinkList(Params params) {
		return (List<Record>) list("statListDao.selectContBbsLinkList", params);
	}
	
}

package egovframework.soportal.stat.service.impl;

import java.util.List;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.service.BaseService;
import egovframework.soportal.stat.service.DirectStatListService;

/**
 * 통계표를 관리하는 서비스 클래스
 * @author	김정호
 * @version 1.0
 * @since   2017/05/25
 */

@Service(value="directStatListService")
public class DirectStatListServiceImpl extends BaseService implements DirectStatListService {

	@Resource(name="directStatListDao")
	protected DirectStatListDao directStatListDao;
	
	
	/**
	 * 게시판 통계표 컨텐츠를 가져온다.
	 */
	public Record selectContBbsTbl(Params params) {
		return directStatListDao.selectContBbsTbl(params);
	}
	
	/**
	 * 게시판 통계표 컨텐츠 목록을 가져온다(용어설명)
	 */
	public List<Record> selectContBbsTblList(Params params) {
		return (List<Record>) directStatListDao.selectContBbsTblList(params);
	}

	/**
	 * 게시판 통계표 컨텐츠 파일목록을 가져온다.
	 */
	@Override
	public List<Record> selectContBbsFileList(Params params) {
		return (List<Record>) directStatListDao.selectContBbsFileList(params);
	}

	/**
	 * 게시판 통계표 컨텐츠 링크목록을 가져온다.
	 */
	@Override
	public List<Record> selectContBbsLinkList(Params params) {
		return (List<Record>) directStatListDao.selectContBbsLinkList(params);
	}
}

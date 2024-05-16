package egovframework.admin.stat.service.impl;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.admin.stat.service.StatOpenStats;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository("StatOpenStatsDao")
public class StatOpenStatsDao extends EgovComAbstractDAO{

	/**
	 * 공공데이터 개방 총 건수 구한다.
	 * @return
	 * @throws DataAccessException, Exception
	 */
	public int openInfTotalCnt() throws DataAccessException, Exception{
		return (Integer)getSqlMapClientTemplate().queryForObject("StatOpenStatsDao.openInfTotalCnt");
	}

	/**
	 * 공공데이터 개방기관 건수
	 * @return
	 * @throws DataAccessException, Exception
	 */
	public int openOrgCnt() throws DataAccessException, Exception{
		return (Integer)getSqlMapClientTemplate().queryForObject("StatOpenStatsDao.openOrgCnt");
	}

	/**
	 * 개방서비스 유형.. 개방한 서비스에서 총유형들의 sum
	 * @return
	 * @throws DataAccessException, Exception
	 */
	public int openSrvCnt() throws DataAccessException, Exception{
		return (Integer)getSqlMapClientTemplate().queryForObject("StatOpenStatsDao.openSrvCnt");
	}

	/**
	 * 사용중인? 보유데이터 총 건수
	 * @return
	 * @throws DataAccessException, Exception
	 */
	public int openDtCnt() throws DataAccessException, Exception{
		return (Integer)getSqlMapClientTemplate().queryForObject("StatOpenStatsDao.openDtCnt");
	}

	/**
	 * 공공데이터 활용 총 건수 (통계)
	 * @return
	 * @throws DataAccessException, Exception
	 */
	public int openStatUseDtCnt() throws DataAccessException, Exception{
		return (Integer)getSqlMapClientTemplate().queryForObject("StatOpenStatsDao.openStatUseDtCnt");
	}

	/**
	 * 활용 피드백 총 건수 (통계)
	 * @return
	 * @throws DataAccessException, Exception
	 */
	public int openFeedBackCnt() throws DataAccessException, Exception{
		return (Integer)getSqlMapClientTemplate().queryForObject("StatOpenStatsDao.openFeedBackCnt");
	}

	/**
	 * 개방 및 활용 통계 sheet 조회
	 * @param statOpenStats
	 * @return
	 * @throws DataAccessException, Exception
	 */
	public List<StatOpenStats> getStatsSheetAll(StatOpenStats statOpenStats) throws DataAccessException, Exception{
		return (List<StatOpenStats>) list("StatOpenStatsDao.getStatsSheetAll",statOpenStats);
	}

}

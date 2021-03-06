package mcommercelab.cntsr.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Service;

import com.ibatis.sqlmap.client.SqlMapClient;

public class CommonDaoImpl extends SqlMapClientDaoSupport {
	
	protected Log logger = LogFactory.getLog(getClass());
	
	public CommonDaoImpl() {
		super();
	}
	
	/**
	 * <pre>
	 * μ²λ¦¬?΄?© : ?Έ?? ? λ°°μΉ / ??
	 * </pre>
	 * @Date	:	2012. 10. 24.	
	 * @Return	:	void
	 */
	public void startTransaction() throws Exception{
		try {
			getSqlMapClient().startTransaction();
			getSqlMapClient().getCurrentConnection().setAutoCommit(false);
			getSqlMapClient().startBatch();
		} catch (Exception e) {
			throw new Exception(e);
		}
	}
	
	/**
	 * <pre>
	 * μ²λ¦¬?΄?© : ?Έ??­? λ°°μΉ?€? / ?
	 * </pre>
	 * @Date	:	2012. 10. 24.	
	 * @Return	:	void
	 */
	public void endTransaction() throws Exception{
		try{
			getSqlMapClient().executeBatch();
			getSqlMapClient().getCurrentConnection().commit();
		}catch (Exception e) {
			throw new Exception(e);
		}finally{
			getSqlMapClient().endTransaction();
		}
	}
	
	/**
	 * <pre>
	 * μ²λ¦¬?΄?© : ?Έ??­? ?
	 * </pre>
	 * @Date	:	2012. 10. 24.	
	 * @Return	:	void
	 */
	public void confirmTransaction() throws Exception{
		getSqlMapClient().endTransaction();
	}
	
	/**
	 * <pre>
	 * μ²λ¦¬?΄?© : db list λ¦¬ν΄ 
	 * </pre>
	 * @Date	:	2012. 10. 24.	
	 * @Return	:	List
	 */
	@SuppressWarnings("rawtypes")
	public List getListDao(String xmlName) throws Exception{
		return getSqlMapClientTemplate().queryForList(xmlName);
	}
	
	/**
	 * <pre>
	 * μ²λ¦¬?΄?© : db list λ¦¬ν΄ 
	 * </pre>
	 * @Date	:	2012. 10. 24.	
	 * @Return	:	List
	 */
	@SuppressWarnings("rawtypes")
	public List getListDao(String xmlName, String parameter) throws Exception{
		return getSqlMapClientTemplate().queryForList(xmlName,parameter);
	}
	
	/**
	 * <pre>
	 * μ²λ¦¬?΄?© : 
	 * </pre>
	 * @Date	:	2012. 10. 24.	
	 * @Return	:	List
	 */
	@SuppressWarnings("rawtypes")
	public List getListDao(String xmlName, HashMap parameter) throws Exception{
		return getSqlMapClientTemplate().queryForList(xmlName,parameter);
	}
	
	/**
	 * <pre>
	 * μ²λ¦¬?΄?© : 
	 * </pre>
	 * @Date	:	2012. 10. 24.	
	 * @Return	:	Integer
	 */
	public Integer getIntDao(String xmlName) throws Exception{
		return (Integer)getSqlMapClientTemplate().queryForObject(xmlName);
	}
	
	/**
	 * <pre>
	 * μ²λ¦¬?΄?© : 
	 * </pre>
	 * @Date	:	2012. 10. 24.	
	 * @Return	:	Integer
	 */
	public Integer getIntDao(String xmlName, String parameter) throws Exception{
		return (Integer)getSqlMapClientTemplate().queryForObject(xmlName, parameter);
	}
	
	/**
	 * <pre>
	 * μ²λ¦¬?΄?© : 
	 * </pre>
	 * @Date	:	2012. 10. 24.	
	 * @Return	:	Integer
	 */
	@SuppressWarnings("rawtypes")
	public Integer getIntDao(String xmlName, HashMap parameter) throws Exception{
		return (Integer)getSqlMapClientTemplate().queryForObject(xmlName, parameter);
	}
	
	/**
	 * <pre>
	 * μ²λ¦¬?΄?© : db list λ¦¬ν΄ 
	 * </pre>
	 * @Date	:	2012. 10. 24.	
	 * @Return	:	List
	 */
	public String getStringDao(String xmlName) throws Exception{
		return (String)getSqlMapClientTemplate().queryForObject(xmlName);
	}
	
	/**
	 * <pre>
	 * μ²λ¦¬?΄?© : db string λ¦¬ν΄ 
	 * </pre>
	 * @Date	:	2012. 10. 24.	
	 * @Return	:	List
	 */
	public String getStringDao(String xmlName, String parameter) throws Exception{
		return (String)getSqlMapClientTemplate().queryForObject(xmlName,parameter);
	}
	
	/**
	 * <pre>
	 * μ²λ¦¬?΄?© : db string λ¦¬ν΄ 
	 * </pre>
	 * @Date	:	2012. 10. 24.	
	 * @Return	:	List
	 */
	@SuppressWarnings("rawtypes")
	public String getStringDao(String xmlName, HashMap parameter) throws Exception{
		return (String)getSqlMapClientTemplate().queryForObject(xmlName,parameter);
	}
	
	/**
	 * <pre>
	 * μ²λ¦¬?΄?© : db string λ¦¬ν΄ 
	 * </pre>
	 * @Date	:	2012. 10. 24.	
	 * @Return	:	List
	 */
	@SuppressWarnings("rawtypes")
	public Map getMapDao(String xmlName) throws Exception{
		return (Map) getSqlMapClient().queryForObject(xmlName);
	}
	
	/**
	 * <pre>
	 * μ²λ¦¬?΄?© : db map λ¦¬ν΄ 
	 * </pre>
	 * @Date	:	2012. 10. 24.	
	 * @Return	:	List
	 */
	@SuppressWarnings("rawtypes")
	public Map getMapDao(String xmlName, String parameter) throws Exception{
		return (Map) getSqlMapClient().queryForObject(xmlName, parameter);
	}
	
	/**
	 * <pre>
	 * μ²λ¦¬?΄?© : db map λ¦¬ν΄ 
	 * </pre>
	 * @Date	:	2012. 10. 24.	
	 * @Return	:	List
	 */
	@SuppressWarnings("rawtypes")
	public Map getMapDao(String xmlName, HashMap parameter) throws Exception{
		return (Map) getSqlMapClient().queryForObject(xmlName, parameter);
	}
	
	/**
	 * <pre>
	 * μ²λ¦¬?΄?© : db insert ?€? λ¦¬ν΄κ°μ? xml?? select ?΄ μ£Όμ΄?Ό ?¨. ??Όλ©? null λ¦¬ν΄ 
	 * </pre>
	 * @Date	:	2012. 10. 24.	
	 * @Return	:	Object
	 */
	public Object insertDao(String xmlName) throws Exception{
		return getSqlMapClient().insert(xmlName);
	}
	
	/**
	 * <pre>
	 * μ²λ¦¬?΄?© : db insert ?€? λ¦¬ν΄κ°μ? xml?? select ?΄ μ£Όμ΄?Ό ?¨. ??Όλ©? null λ¦¬ν΄ 
	 * </pre>
	 * @Date	:	2012. 10. 24.	
	 * @Return	:	Object
	 */
	public Object insertDao(String xmlName, String parameter) throws Exception{
		return getSqlMapClient().insert(xmlName, parameter);
	}
	
	/**
	 * <pre>
	 * μ²λ¦¬?΄?© : db insert ?€? λ¦¬ν΄κ°μ? xml?? select ?΄ μ£Όμ΄?Ό ?¨. ??Όλ©? null λ¦¬ν΄ 
	 * </pre>
	 * @Date	:	2012. 10. 24.	
	 * @Return	:	Object
	 */
	@SuppressWarnings("rawtypes")
	public Object insertDao(String xmlName, HashMap parameter) throws Exception{
		return getSqlMapClient().insert(xmlName, parameter);
	}
	
	/**
	 * <pre>
	 * μ²λ¦¬?΄?© : db update ?€? λ¦¬ν΄κ°μ? updateκ°? ? κ°?? (ex: ??°?΄?Έκ°? 1κ°? ???€λ©? 1 λ¦¬ν΄. ??°?΄?Έκ°? ? ???Όλ©? 0 λ¦¬ν΄)
	 * </pre>
	 * @Date	:	2012. 10. 24.	
	 * @Return	:	int
	 */
	public int updateDao(String xmlName) throws Exception{
		return Math.abs(getSqlMapClient().update(xmlName));
	}
	
	/**
	 * <pre>
	 * μ²λ¦¬?΄?© : db update ?€? λ¦¬ν΄κ°μ? updateκ°? ? κ°?? (ex: ??°?΄?Έκ°? 1κ°? ???€λ©? 1 λ¦¬ν΄. ??°?΄?Έκ°? ? ???Όλ©? 0 λ¦¬ν΄)
	 * </pre>
	 * @Date	:	2012. 10. 24.	
	 * @Return	:	int
	 */
	public int updateDao(String xmlName, String parameter) throws Exception{
		return Math.abs(getSqlMapClient().update(xmlName, parameter));
	}
	
	/**
	 * <pre>
	 * μ²λ¦¬?΄?© : db update ?€? λ¦¬ν΄κ°μ? updateκ°? ? κ°?? (ex: ??°?΄?Έκ°? 1κ°? ???€λ©? 1 λ¦¬ν΄. ??°?΄?Έκ°? ? ???Όλ©? 0 λ¦¬ν΄)
	 * </pre>
	 * @Date	:	2012. 10. 24.	
	 * @Return	:	int
	 */
	@SuppressWarnings("rawtypes")
	public int updateDao(String xmlName, HashMap parameter) throws Exception{
		return Math.abs(getSqlMapClient().update(xmlName, parameter));
	}
	
	/**
	 * <pre>
	 * μ²λ¦¬?΄?© : db delete ?€? λ¦¬ν΄κ°μ? delete ? κ°?? (ex: ?­? κ°? 1κ°? ???€λ©? 1 λ¦¬ν΄. ?­? κ°? ? ???Όλ©? 0 λ¦¬ν΄)
	 * </pre>
	 * @Date	:	2012. 10. 24.	
	 * @Return	:	int
	 */
	public int deleteDao(String xmlName) throws Exception{
		return Math.abs(getSqlMapClient().delete(xmlName));
	}
	
	/**
	 * <pre>
	 * μ²λ¦¬?΄?© : db delete ?€? λ¦¬ν΄κ°μ? delete ? κ°?? (ex: ?­? κ°? 1κ°? ???€λ©? 1 λ¦¬ν΄. ?­? κ°? ? ???Όλ©? 0 λ¦¬ν΄)
	 * </pre>
	 * @Date	:	2012. 10. 24.	
	 * @Return	:	int
	 */
	public int deleteDao(String xmlName, String parameter) throws Exception{
		return Math.abs(getSqlMapClient().delete(xmlName, parameter));
	}
	
	/**
	 * <pre>
	 * μ²λ¦¬?΄?© : db delete ?€? λ¦¬ν΄κ°μ? delete ? κ°?? (ex: ?­? κ°? 1κ°? ???€λ©? 1 λ¦¬ν΄. ?­? κ°? ? ???Όλ©? 0 λ¦¬ν΄)
	 * </pre>
	 * @Date	:	2012. 10. 24.	
	 * @Return	:	int
	 */
	@SuppressWarnings("rawtypes")
	public int deleteDao(String xmlName, HashMap parameter) throws Exception{
		return getSqlMapClient().delete(xmlName, parameter);
	}
}

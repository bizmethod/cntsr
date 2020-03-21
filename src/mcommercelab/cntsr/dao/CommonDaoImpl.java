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
	 * Ï≤òÎ¶¨?Ç¥?ö© : ?ä∏?ûú?†ù?Öò Î∞∞Ïπò / ?ãú?ûë
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
	 * Ï≤òÎ¶¨?Ç¥?ö© : ?ä∏?ûú?û≠?Öò Î∞∞Ïπò?ã§?ñâ / ?Åù
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
	 * Ï≤òÎ¶¨?Ç¥?ö© : ?ä∏?ûú?û≠?Öò ?Åù
	 * </pre>
	 * @Date	:	2012. 10. 24.	
	 * @Return	:	void
	 */
	public void confirmTransaction() throws Exception{
		getSqlMapClient().endTransaction();
	}
	
	/**
	 * <pre>
	 * Ï≤òÎ¶¨?Ç¥?ö© : db list Î¶¨ÌÑ¥ 
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
	 * Ï≤òÎ¶¨?Ç¥?ö© : db list Î¶¨ÌÑ¥ 
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
	 * Ï≤òÎ¶¨?Ç¥?ö© : 
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
	 * Ï≤òÎ¶¨?Ç¥?ö© : 
	 * </pre>
	 * @Date	:	2012. 10. 24.	
	 * @Return	:	Integer
	 */
	public Integer getIntDao(String xmlName) throws Exception{
		return (Integer)getSqlMapClientTemplate().queryForObject(xmlName);
	}
	
	/**
	 * <pre>
	 * Ï≤òÎ¶¨?Ç¥?ö© : 
	 * </pre>
	 * @Date	:	2012. 10. 24.	
	 * @Return	:	Integer
	 */
	public Integer getIntDao(String xmlName, String parameter) throws Exception{
		return (Integer)getSqlMapClientTemplate().queryForObject(xmlName, parameter);
	}
	
	/**
	 * <pre>
	 * Ï≤òÎ¶¨?Ç¥?ö© : 
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
	 * Ï≤òÎ¶¨?Ç¥?ö© : db list Î¶¨ÌÑ¥ 
	 * </pre>
	 * @Date	:	2012. 10. 24.	
	 * @Return	:	List
	 */
	public String getStringDao(String xmlName) throws Exception{
		return (String)getSqlMapClientTemplate().queryForObject(xmlName);
	}
	
	/**
	 * <pre>
	 * Ï≤òÎ¶¨?Ç¥?ö© : db string Î¶¨ÌÑ¥ 
	 * </pre>
	 * @Date	:	2012. 10. 24.	
	 * @Return	:	List
	 */
	public String getStringDao(String xmlName, String parameter) throws Exception{
		return (String)getSqlMapClientTemplate().queryForObject(xmlName,parameter);
	}
	
	/**
	 * <pre>
	 * Ï≤òÎ¶¨?Ç¥?ö© : db string Î¶¨ÌÑ¥ 
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
	 * Ï≤òÎ¶¨?Ç¥?ö© : db string Î¶¨ÌÑ¥ 
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
	 * Ï≤òÎ¶¨?Ç¥?ö© : db map Î¶¨ÌÑ¥ 
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
	 * Ï≤òÎ¶¨?Ç¥?ö© : db map Î¶¨ÌÑ¥ 
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
	 * Ï≤òÎ¶¨?Ç¥?ö© : db insert ?ã§?ñâ Î¶¨ÌÑ¥Í∞íÏ? xml?óê?Ñú select ?ï¥ Ï£ºÏñ¥?ïº ?ï®. ?óÜ?úºÎ©? null Î¶¨ÌÑ¥ 
	 * </pre>
	 * @Date	:	2012. 10. 24.	
	 * @Return	:	Object
	 */
	public Object insertDao(String xmlName) throws Exception{
		return getSqlMapClient().insert(xmlName);
	}
	
	/**
	 * <pre>
	 * Ï≤òÎ¶¨?Ç¥?ö© : db insert ?ã§?ñâ Î¶¨ÌÑ¥Í∞íÏ? xml?óê?Ñú select ?ï¥ Ï£ºÏñ¥?ïº ?ï®. ?óÜ?úºÎ©? null Î¶¨ÌÑ¥ 
	 * </pre>
	 * @Date	:	2012. 10. 24.	
	 * @Return	:	Object
	 */
	public Object insertDao(String xmlName, String parameter) throws Exception{
		return getSqlMapClient().insert(xmlName, parameter);
	}
	
	/**
	 * <pre>
	 * Ï≤òÎ¶¨?Ç¥?ö© : db insert ?ã§?ñâ Î¶¨ÌÑ¥Í∞íÏ? xml?óê?Ñú select ?ï¥ Ï£ºÏñ¥?ïº ?ï®. ?óÜ?úºÎ©? null Î¶¨ÌÑ¥ 
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
	 * Ï≤òÎ¶¨?Ç¥?ö© : db update ?ã§?ñâ Î¶¨ÌÑ¥Í∞íÏ? updateÍ∞? ?êú Í∞??àò (ex: ?óÖ?ç∞?ù¥?ä∏Í∞? 1Í∞? ?êò?óà?ã§Î©? 1 Î¶¨ÌÑ¥. ?óÖ?ç∞?ù¥?ä∏Í∞? ?ïà ?êò?óà?úºÎ©? 0 Î¶¨ÌÑ¥)
	 * </pre>
	 * @Date	:	2012. 10. 24.	
	 * @Return	:	int
	 */
	public int updateDao(String xmlName) throws Exception{
		return Math.abs(getSqlMapClient().update(xmlName));
	}
	
	/**
	 * <pre>
	 * Ï≤òÎ¶¨?Ç¥?ö© : db update ?ã§?ñâ Î¶¨ÌÑ¥Í∞íÏ? updateÍ∞? ?êú Í∞??àò (ex: ?óÖ?ç∞?ù¥?ä∏Í∞? 1Í∞? ?êò?óà?ã§Î©? 1 Î¶¨ÌÑ¥. ?óÖ?ç∞?ù¥?ä∏Í∞? ?ïà ?êò?óà?úºÎ©? 0 Î¶¨ÌÑ¥)
	 * </pre>
	 * @Date	:	2012. 10. 24.	
	 * @Return	:	int
	 */
	public int updateDao(String xmlName, String parameter) throws Exception{
		return Math.abs(getSqlMapClient().update(xmlName, parameter));
	}
	
	/**
	 * <pre>
	 * Ï≤òÎ¶¨?Ç¥?ö© : db update ?ã§?ñâ Î¶¨ÌÑ¥Í∞íÏ? updateÍ∞? ?êú Í∞??àò (ex: ?óÖ?ç∞?ù¥?ä∏Í∞? 1Í∞? ?êò?óà?ã§Î©? 1 Î¶¨ÌÑ¥. ?óÖ?ç∞?ù¥?ä∏Í∞? ?ïà ?êò?óà?úºÎ©? 0 Î¶¨ÌÑ¥)
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
	 * Ï≤òÎ¶¨?Ç¥?ö© : db delete ?ã§?ñâ Î¶¨ÌÑ¥Í∞íÏ? delete ?êú Í∞??àò (ex: ?Ç≠?†úÍ∞? 1Í∞? ?êò?óà?ã§Î©? 1 Î¶¨ÌÑ¥. ?Ç≠?†úÍ∞? ?ïà ?êò?óà?úºÎ©? 0 Î¶¨ÌÑ¥)
	 * </pre>
	 * @Date	:	2012. 10. 24.	
	 * @Return	:	int
	 */
	public int deleteDao(String xmlName) throws Exception{
		return Math.abs(getSqlMapClient().delete(xmlName));
	}
	
	/**
	 * <pre>
	 * Ï≤òÎ¶¨?Ç¥?ö© : db delete ?ã§?ñâ Î¶¨ÌÑ¥Í∞íÏ? delete ?êú Í∞??àò (ex: ?Ç≠?†úÍ∞? 1Í∞? ?êò?óà?ã§Î©? 1 Î¶¨ÌÑ¥. ?Ç≠?†úÍ∞? ?ïà ?êò?óà?úºÎ©? 0 Î¶¨ÌÑ¥)
	 * </pre>
	 * @Date	:	2012. 10. 24.	
	 * @Return	:	int
	 */
	public int deleteDao(String xmlName, String parameter) throws Exception{
		return Math.abs(getSqlMapClient().delete(xmlName, parameter));
	}
	
	/**
	 * <pre>
	 * Ï≤òÎ¶¨?Ç¥?ö© : db delete ?ã§?ñâ Î¶¨ÌÑ¥Í∞íÏ? delete ?êú Í∞??àò (ex: ?Ç≠?†úÍ∞? 1Í∞? ?êò?óà?ã§Î©? 1 Î¶¨ÌÑ¥. ?Ç≠?†úÍ∞? ?ïà ?êò?óà?úºÎ©? 0 Î¶¨ÌÑ¥)
	 * </pre>
	 * @Date	:	2012. 10. 24.	
	 * @Return	:	int
	 */
	@SuppressWarnings("rawtypes")
	public int deleteDao(String xmlName, HashMap parameter) throws Exception{
		return getSqlMapClient().delete(xmlName, parameter);
	}
}

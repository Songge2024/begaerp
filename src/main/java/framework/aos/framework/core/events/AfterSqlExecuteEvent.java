package aos.framework.core.events;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;
import java.util.Queue;

import org.springframework.context.ApplicationEvent;
/**
 * 
 * @author Administrator
 *
 */
public class AfterSqlExecuteEvent extends ApplicationEvent {
	public Map sqlMap=new HashMap();
	private String sqlpath;
	private String sqlid;
	private String sqltype;
	
	public String getSqltype() {
		return sqltype;
	}

	public void setSqltype(String sqltype) {
		this.sqltype = sqltype;
	}

	public String getSqlpath() {
		return sqlpath;
	}

	public String getSqlid() {
		return sqlid;
	}

	public void setSqlpath(String sqlpath) {
		this.sqlpath = sqlpath;
	}

	public void setSqlid(String sqlid) {
		this.sqlid = sqlid;
	}

	public AfterSqlExecuteEvent(String sqlpath, String sqlid) {
		super(sqlid);
		this.sqlid=sqlid;
		this.sqlpath=sqlpath;
	}
}
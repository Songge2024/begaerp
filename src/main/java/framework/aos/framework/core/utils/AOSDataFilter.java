package aos.framework.core.utils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;

import aos.framework.core.typewrap.Dto;
import aos.framework.core.typewrap.Dtos;
import aos.system.common.model.UserModel;
import aos.system.modules.datafilter.DataFilterService;

/**
 * 拦截所有ibatis 执行语句 增加过滤条件
 * 
 * @author remexs
 *
 */
public class AOSDataFilter {
	public static List<Dto> sqlFilterList = new ArrayList<Dto>();
	public static List<String> ignoreList = new ArrayList<String>();
	static {
		ignoreList.add("Id.nextValue");
		ignoreList.add("DateFilter.queryUserDataFilters");
		ignoreList.add("aos.system.dao.AosDataFilterDao.rows");
	}

	/**
	 * sql执行前过滤
	 * 
	 * @param sqlType
	 *            sql 类型 （update,insert ,delete, select, call,）
	 * @param sqlpath
	 *            sql 文件路径
	 * @param sqlid
	 *            sql 识别编码
	 * @param inSql
	 *            mybatis原sql
	 */
	public static String beforeFilter(String sqlType, String sqlpath, String sqlid, String inSql, Object params) {
		if (ignoreList.contains(sqlid)) {
			return inSql;
		}
		sqlpath = StringUtils.substringAfter(sqlpath, "classes\\");
		sqlpath = StringUtils.substring(sqlpath, 0, sqlpath.length() - 1);
		Dto sqlDto = Dtos.newDto();
		sqlDto.put("sqlid", sqlid);
		sqlDto.put("sqltype", sqlType);
		sqlDto.put("path", sqlpath);
		if (!sqlFilterList.contains(sqlDto)) {
			sqlFilterList.add(sqlDto);
			DataFilterService aosDataFilterService = (DataFilterService) AOSCxt.getBean("dataFilterService");
			if (!aosDataFilterService.exist(sqlDto.getString("sqlid"))) {
				aosDataFilterService.insert(sqlDto);
			}
		}
		switch (sqlType) {
		case "UPDATE":
			return updateBeforeFilter(sqlpath, sqlid, inSql);
		case "INSERT":
			return insertBeforeFilter(sqlpath, sqlid, inSql);
		case "DELETE":
			return deleteBeforeFilter(sqlpath, sqlid, inSql);
		case "CALL":
			return callBeforeFilter(sqlpath, sqlid, inSql);
		default:
			return selectBeforeFilter(sqlpath, sqlid, inSql, params);
		}
	}

	/**
	 * 修改拦截
	 * 
	 * @param sqlpath
	 *            sql 文件路径
	 * @param sqlid
	 *            sql 识别编码
	 * @param inSql
	 *            mybatis原sql
	 * @return
	 */
	public static String updateBeforeFilter(String sqlPath, String sqlid, String inSql) {
		return inSql;
	}

	/**
	 * 新增拦截
	 * 
	 * @param sqlpath
	 *            sql 文件路径
	 * @param sqlid
	 *            sql 识别编码
	 * @param inSql
	 *            mybatis原sql
	 * @return
	 */
	public static String insertBeforeFilter(String sqlPath, String sqlid, String inSql) {
		return inSql;
	}

	/**
	 * 删除拦截
	 * 
	 * @param sqlpath
	 *            sql 文件路径
	 * @param sqlid
	 *            sql 识别编码
	 * @param inSql
	 *            mybatis原sql
	 * @return
	 */
	public static String deleteBeforeFilter(String sqlPath, String sqlid, String inSql) {
		return inSql;
	}

	/**
	 * 调用存储过程/函数拦截
	 * 
	 * @param sqlpath
	 *            sql 文件路径
	 * @param sqlid
	 *            sql 识别编码
	 * @param inSql
	 *            mybatis原sql
	 * @return
	 */
	public static String callBeforeFilter(String sqlPath, String sqlid, String inSql) {
		return inSql;
	}

	/**
	 * 行级数据过滤 添加条件
	 * 
	 * @param sqlpath
	 *            sql 文件路径
	 * @param sqlid
	 *            sql 识别编码
	 * @param inSql
	 *            mybatis原sql
	 * @return
	 */
	public static String selectBeforeFilter(String sqlPath, String sqlid, String inSql, Object params) {
		String juid = "";
		if (params instanceof Map && null != params && ((Map) params).containsKey("juid")) {
			juid = ((Map) params).get("juid").toString();
		}
		String append = getAppendStr(sqlid, juid);
		boolean isEmptyAppend = AOSUtils.isEmpty(append);
		if (isEmptyAppend) return inSql;// 没有配置条件直接返回原sql
		// 获得最外层查询sql语句 并将条件拼接到最外层 where 之后
		int whereIndex = StringUtils.indexOfIgnoreCase(inSql, "WHERE");
		int orderIndex = StringUtils.indexOfIgnoreCase(inSql, "ORDER");

		if (whereIndex == -1) {// where 0
			if (orderIndex == -1) {// where 0, order 0
				inSql = inSql + " where " + append;
			} else {// where 0 ,order 1
				String orderBeforeStr = StringUtils.substring(inSql, 0, orderIndex);
				String orderStr = StringUtils.substring(inSql, orderIndex);
				inSql = orderBeforeStr + " where " + append + " " + orderStr;
			}
			return inSql;
		} else {// where 1
			String whereBeforeStr = StringUtils.substring(inSql, 0, whereIndex + 5);
			String whereStr = StringUtils.substring(inSql, whereIndex + 5);
			if (orderIndex == -1) {// where 1, order 0
				inSql = whereBeforeStr + " " + append + " and " + whereStr;
			} else {// where 1 ,order 1
				orderIndex = StringUtils.indexOfIgnoreCase(whereStr, "ORDER");
				String orderBeforeStr = StringUtils.substring(whereStr, 0, orderIndex);
				String orderStr = StringUtils.substring(whereStr, orderIndex);
				inSql = whereBeforeStr + " " + append + " and " + orderBeforeStr + " " + orderStr;
			}
			return inSql;
		}
	}

	/**
	 * 根据用户序列号获得用户指定sqlid 的配置条件
	 * 
	 * @param sqlid
	 * @param juid
	 * @return
	 */
	private static String getAppendStr(String sqlid, String juid) {
		String append = "";
		if (AOSUtils.isEmpty(juid)) return append;
		UserModel userModel = AOSCxt.getUserModel(juid);
		Integer userid = userModel.getId();
		DataFilterService dataFilterService = (DataFilterService) AOSCxt.getBean("dataFilterService");
		List<Dto> filters = dataFilterService.queryUserRowsFilter(userid, sqlid);
		for (Dto filter : filters) {
			append += filter.getString("filter");
		}
		return append;
	}
}

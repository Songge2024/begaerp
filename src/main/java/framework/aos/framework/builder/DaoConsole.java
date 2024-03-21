package aos.framework.builder;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.SQLException;
import java.util.List;

import aos.framework.builder.asset.DriverManagerOpt;
import aos.framework.builder.metainfo.DBMetaInfoUtils;
import aos.framework.builder.metainfo.vo.ColumnVO;
import aos.framework.builder.metainfo.vo.TableVO;
import aos.framework.builder.resources.DaoBuilder;
import aos.framework.core.dao.asset.DBType;
import aos.framework.core.exception.AOSException;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.typewrap.Dtos;
import aos.framework.core.utils.AOSUtils;

/**
 * 数据访问层代码生成器
 * 
 * 
 * @author xiongchun
 * @throws SQLException 
 */
public class DaoConsole {

	public static void main(String[] args) throws SQLException {
		//===================
		DriverManagerOpt driverOpt = new DriverManagerOpt();
		//当前版本支持mysql、oracle、sqlserver2005+、H2
		driverOpt.setDataBaseType(DBType.MYSQL); 
		driverOpt.setIp("127.0.0.1");
		driverOpt.setPort("3306");
		//数据库名或数据库实例名
		driverOpt.setCatalog("aosuite");
		driverOpt.setUserName("root");
		driverOpt.setPassword("root");
		//===================
		Dto dto = Dtos.newDto();
		//改为自己存放相关文件的磁盘文件路径
		dto.put("outPath", "D://test");
		//改为自己相关文件的包路径
		//dto.put("package", "com.system.dao");
		//dto.put("package", "aos.system.dao");
		
        dto.put("package", "com.bl3.pm.quality");
        dto.put("author", "hanjin");
		//指定多张表请用逗号分隔；
		//!!表名区分大小写的喔
		//dto.put("tables", "aos_button,aos_role_button,aos_rows_filter,aos_role_rows_filter");
		dto.put("tables", "qa_bug_manage");
		dto.put("prefix", "qa_");
		
		dto.put("views",
						"columns.jsp.vm,"+ 
						"docked.jsp.vm," + 
						"fields.jsp.vm," + 
						"grid.jsp.vm," + 
						"handler.jsp.vm," + 
						"menu.jsp.vm," + 
						"layout.jsp.vm," + 
						"win.jsp.vm"
		);
		//dto.put("tables", "aos_cmp, aos_icon, aos_module, aos_org, aos_role, aos_role_module, aos_sequence, aos_user_role");
		//===================
		
		
		
		
		Connection connection = DBMetaInfoUtils.newConnection(driverOpt);
		DaoBuilder.build(connection, dto);
		DatabaseMetaData databaseMetaData = connection.getMetaData();
		String tablesString = AOSUtils.trimAll(dto.getString("tables"));
		
		// ,号分隔的多张表
		String[] tables = tablesString.split(",");
		for (String tableName : tables) {
			TableVO tableVO = DBMetaInfoUtils.getTableVO(databaseMetaData, tableName);
			if (AOSUtils.isEmpty(tableVO)) {
				throw new AOSException("表[" + tableName + "]不存在。");
			}
			dto.put("tableVO", tableVO);
			List<ColumnVO> columnVOs = DBMetaInfoUtils.listColumnVOs(databaseMetaData, tableName);
			// 仅生成XMLMapper时需要
			List<ColumnVO> pkeyColumnVOs = DBMetaInfoUtils.getPKColumnVOs(columnVOs);
			dto.put("columnVOs", columnVOs);
			dto.put("pkeyColumnVOs", pkeyColumnVOs);
			DaoBuilder.buildPO(dto);
			DaoBuilder.buildJavaDao(dto);
			DaoBuilder.buildXmlDao(dto);
			DaoBuilder.buildJavaService(dto);
			DaoBuilder.buildView(dto);
		}
		connection.close();
	}

}

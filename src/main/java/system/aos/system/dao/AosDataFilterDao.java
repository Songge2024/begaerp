package aos.system.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import aos.framework.core.annotation.Dao;
import aos.framework.core.typewrap.Dto;
import aos.system.dao.po.AosDataFilterPO;

/**
 * <b>aos_data_filter[aos_data_filter]数据访问接口</b>
 * 
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改
 * </p>
 * 
 * @author Remexs
 * @date 2017-11-25 17:21:38
 */
@Dao("aosDataFilterDao")
public interface AosDataFilterDao {

	/**
	 * 插入一个数据持久化对象(插入字段为传入PO实体的非空属性)
	 * <p> 防止DB字段缺省值需要程序中再次赋值
	 *
	 * @param aos_data_filterPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insert(AosDataFilterPO aosDataFilterPO);
	
	/**
	 * 插入一个数据持久化对象(含所有字段)
	 * 
	 * @param AosDataFilterPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insertAll(AosDataFilterPO aosDataFilterPO);

	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param AosDataFilterPO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateByKey(AosDataFilterPO aosDataFilterPO);

	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return AosDataFilterPO
	 */
	AosDataFilterPO selectByKey(@Param(value = "id") Integer id);

	/**
	 * 根据唯一组合条件查询并返回数据持久化对象
	 * 
	 * @return AosDataFilterPO
	 */
	AosDataFilterPO selectOne(Dto pDto);

	/**
	 * 根据Dto查询并返回数据持久化对象集合
	 * 
	 * @return List<AosDataFilterPO>
	 */
	List<AosDataFilterPO> list(Dto pDto);

	/**
	 * 根据Dto查询并返回分页数据持久化对象集合
	 * 
	 * @return List<AosDataFilterPO>
	 */
	List<AosDataFilterPO> listPage(Dto pDto);
		
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--交集
	 * 
	 * @return List<AosDataFilterPO>
	 */
	List<AosDataFilterPO> like(Dto pDto);
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<AosDataFilterPO>
	 */
	List<AosDataFilterPO> likeOr(Dto pDto);

	/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<AosDataFilterPO>
	 */
	List<AosDataFilterPO> likePage(Dto pDto);
		/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<AosDataFilterPO>
	 */
	List<AosDataFilterPO> likeOrPage(Dto pDto);

	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteByKey(@Param(value = "id") Integer id);
	
	/**
	 * 根据Dto统计行数
	 * 
	 * @param pDto
	 * @return
	 */
	Integer rows(Dto pDto);
	
	/**
	 * 根据数学表达式进行数学运算
	 * 
	 * @param pDto
	 * @return String
	 */
	String calc(Dto pDto);
	
}

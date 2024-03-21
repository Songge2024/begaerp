package aos.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import aos.demo.dao.po.AosUploadPO;
import aos.framework.core.annotation.Dao;
import aos.framework.core.typewrap.Dto;

/**
 * <b>aos_upload[aos_upload]数据访问接口</b>
 * 
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改
 * </p>
 * 
 * @author z
 * @date 2018-01-21 15:53:01
 */
@Dao("aosUploadDao")
public interface AosUploadDao {

	/**
	 * 插入一个数据持久化对象(插入字段为传入PO实体的非空属性)
	 * <p> 防止DB字段缺省值需要程序中再次赋值
	 *
	 * @param aos_uploadPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insert(AosUploadPO aosUploadPO);
	
	/**
	 * 插入一个数据持久化对象(含所有字段)
	 * 
	 * @param AosUploadPO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insertAll(AosUploadPO aosUploadPO);

	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param AosUploadPO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateByKey(AosUploadPO aosUploadPO);

	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return AosUploadPO
	 */
	AosUploadPO selectByKey(@Param(value = "fileid") Integer fileid);

	/**
	 * 根据唯一组合条件查询并返回数据持久化对象
	 * 
	 * @return AosUploadPO
	 */
	AosUploadPO selectOne(Dto pDto);

	/**
	 * 根据Dto查询并返回数据持久化对象集合
	 * 
	 * @return List<AosUploadPO>
	 */
	List<AosUploadPO> list(Dto pDto);

	/**
	 * 根据Dto查询并返回分页数据持久化对象集合
	 * 
	 * @return List<AosUploadPO>
	 */
	List<AosUploadPO> listPage(Dto pDto);
		
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--交集
	 * 
	 * @return List<AosUploadPO>
	 */
	List<AosUploadPO> like(Dto pDto);
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<AosUploadPO>
	 */
	List<AosUploadPO> likeOr(Dto pDto);

	/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<AosUploadPO>
	 */
	List<AosUploadPO> likePage(Dto pDto);
		/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<AosUploadPO>
	 */
	List<AosUploadPO> likeOrPage(Dto pDto);

	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteByKey(@Param(value = "fileid") Integer fileid);
	
	/**
	 * 根据Dto统计行数
	 * 
	 * @param pDto
	 * @return
	 */
	int rows(Dto pDto);
	
	/**
	 * 根据数学表达式进行数学运算
	 * 
	 * @param pDto
	 * @return String
	 */
	String calc(Dto pDto);
	
}

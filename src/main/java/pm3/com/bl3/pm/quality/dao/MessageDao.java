package com.bl3.pm.quality.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import aos.framework.core.annotation.Dao;
import aos.framework.core.typewrap.Dto;
import com.bl3.pm.quality.dao.po.MessagePO;

/**
 * <b>qa_message[qa_message]数据访问接口</b>
 * 
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改
 * </p>
 * 
 * @author z
 * @date 2018-01-31 15:43:01
 */
@Dao("messageDao")
public interface MessageDao {

	/**
	 * 插入一个数据持久化对象(插入字段为传入PO实体的非空属性)
	 * <p> 防止DB字段缺省值需要程序中再次赋值
	 *
	 * @param qa_messagePO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insert(MessagePO messagePO);
	
	/**
	 * 插入一个数据持久化对象(含所有字段)
	 * 
	 * @param MessagePO
	 *            要插入的数据持久化对象
	 * @return 返回影响行数
	 */
	int insertAll(MessagePO messagePO);

	/**
	 * 根据主键修改数据持久化对象
	 * 
	 * @param MessagePO
	 *            要修改的数据持久化对象
	 * @return int 返回影响行数
	 */
	int updateByKey(MessagePO messagePO);

	/**
	 * 根据主键查询并返回数据持久化对象
	 * 
	 * @return MessagePO
	 */
	MessagePO selectByKey(@Param(value = "msg_id") Integer msg_id);

	/**
	 * 根据唯一组合条件查询并返回数据持久化对象
	 * 
	 * @return MessagePO
	 */
	MessagePO selectOne(Dto pDto);

	/**
	 * 根据Dto查询并返回数据持久化对象集合
	 * 
	 * @return List<MessagePO>
	 */
	List<MessagePO> list(Dto pDto);

	/**
	 * 根据Dto查询并返回分页数据持久化对象集合
	 * 
	 * @return List<MessagePO>
	 */
	List<MessagePO> listPage(Dto pDto);
		
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--交集
	 * 
	 * @return List<MessagePO>
	 */
	List<MessagePO> like(Dto pDto);
	/**
	 * 根据Dto模糊查询并返回数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<MessagePO>
	 */
	List<MessagePO> likeOr(Dto pDto);

	/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<MessagePO>
	 */
	List<MessagePO> likePage(Dto pDto);
		/**
	 * 根据Dto模糊查询并返回分页数据持久化对象集合(字符型字段模糊匹配，其余字段精确匹配)--并集
	 * 
	 * @return List<MessagePO>
	 */
	List<MessagePO> likeOrPage(Dto pDto);

	/**
	 * 根据主键删除数据持久化对象
	 *
	 * @return 影响行数
	 */
	int deleteByKey(@Param(value = "msg_id") Integer msg_id);
	
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

package com.bl3.pm.quality.dao.po;

import aos.framework.core.typewrap.PO;
import java.util.Date;

/**
 * <b>qa_test_example[qa_test_example]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author wangjl
 * @date 2018-02-26 09:34:38
 */
public class TestExamplePO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 测试用例ID
	 */
	private Integer standard_id;
	
	/**
	 * 测试用例编码
	 */
	private String standard_code;
	
	/**
	 * 测试用例名称
	 */
	private String standard_name;
	
	/**
	 * 执行序号
	 */
	private Integer execute_code;
	
	/**
	 * 项目ID
	 */
	private Integer proj_id;
	
	/**
	 * 模块ID
	 */
	private String stand_id;
	
	/**
	 * 测试环境
	 */
	private String test_environment;
	
	/**
	 * 对应的需求id
	 */
	private String demand_id;
	
	/**
	 * 测试数据sql
	 */
	private String data_sql;
	
	/**
	 * 前置条件
	 */
	private String precondition;
	
	/**
	 * 执行步骤
	 */
	private String standard_detail;
	
	/**
	 * 期望结果
	 */
	private String expected_results;
	
	/**
	 * 实际结果
	 */
	private String actual_results;
	
	/**
	 * 状态（0执行通过，1执行未通过，-1执行）
	 */
	private Integer pass_or_fail;
	
	/**
	 * 新增人
	 */
	private String create_name;
	
	/**
	 * 新增人
	 */
	private int create_id;
	
	/**
	 * 新增时间
	 */
	private Date create_time;
	
	/**
	 * 修改人
	 */
	private String update_name;
	
	/**
	 * 修改人
	 */
	private int update_id;
	
	/**
	 * 修改时间
	 */
	private Date update_time;
	
	/**
	 * 通过时间
	 */
	private Date pass_time;
	
	/**
	 * 执行次数
	 */
	private Integer execute_number;
	

	/**
	 * 执行人
	 */
	private String tester_name;
	
	/**
	 * 执行人
	 */
	private String tester_id;
	
	/**
	 * 执行时间
	 */
	private Date test_time;
	
	
	/**
	 * 版本
	 */
	private String version;
	
	/**
	 * 优先级
	 */
	private String priority;
	
	/**
	 * 功能模块
	 */
	private String function_module;
	
	/**
	 * 测试前提
	 */
	private String test_premise;
	
	/**
	 * 来源模板项目ID
	 */
	private Integer from_templete_proj_id;
	
	/**
	 * 来源测试用例版本号
	 */
	private Integer from_test_version_id;
	
	/**
	 * 来源测试用例ID
	 */
	private Integer from_standard_id;
	
	/**
	 * 测试版本号
	 */
	private Integer test_version_id;
	
	private Integer all_example;
	
	private Integer pass_example;
	
	private String pass_rate;
	
	private String stard_name;
	
	
	
	
	
	
	
	public Integer getAll_example() {
		return all_example;
	}

	public void setAll_example(Integer all_example) {
		this.all_example = all_example;
	}

	public Integer getPass_example() {
		return pass_example;
	}

	public void setPass_example(Integer pass_example) {
		this.pass_example = pass_example;
	}

	public String getPass_rate() {
		return pass_rate;
	}

	public void setPass_rate(String pass_rate) {
		this.pass_rate = pass_rate;
	}

	public String getStard_name() {
		return stard_name;
	}

	public void setStard_name(String stard_name) {
		this.stard_name = stard_name;
	}

	public Integer getFrom_templete_proj_id() {
		return from_templete_proj_id;
	}

	public void setFrom_templete_proj_id(Integer from_templete_proj_id) {
		this.from_templete_proj_id = from_templete_proj_id;
	}

	public Integer getFrom_test_version_id() {
		return from_test_version_id;
	}

	public void setFrom_test_version_id(Integer from_test_version_id) {
		this.from_test_version_id = from_test_version_id;
	}

	public Integer getFrom_standard_id() {
		return from_standard_id;
	}

	public void setFrom_standard_id(Integer from_standard_id) {
		this.from_standard_id = from_standard_id;
	}

	public Integer getTest_version_id() {
		return test_version_id;
	}

	public void setTest_version_id(Integer test_version_id) {
		this.test_version_id = test_version_id;
	}

	
	/**
	 * 测试用例ID
	 * 
	 * @return standard_id
	 */
	public Integer getStandard_id() {
		return standard_id;
	}
	
	/**
	 * 测试用例编码
	 * 
	 * @return standard_code
	 */
	public String getStandard_code() {
		return standard_code;
	}
	
	/**
	 * 测试用例名称
	 * 
	 * @return standard_name
	 */
	public String getStandard_name() {
		return standard_name;
	}
	
	/**
	 * 执行序号
	 * 
	 * @return execute_code
	 */
	public Integer getExecute_code() {
		return execute_code;
	}
	
	/**
	 * 项目ID
	 * 
	 * @return proj_id
	 */
	public Integer getProj_id() {
		return proj_id;
	}
	
	/**
	 * 模块ID
	 * 
	 * @return stand_id
	 */
	public String getStand_id() {
		return stand_id;
	}
	
	/**
	 * 测试环境
	 * 
	 * @return test_environment
	 */
	public String getTest_environment() {
		return test_environment;
	}
	
	/**
	 * 对应的需求id
	 * 
	 * @return demand_id
	 */
	public String getDemand_id() {
		return demand_id;
	}
	
	/**
	 * 测试数据sql
	 * 
	 * @return data_sql
	 */
	public String getData_sql() {
		return data_sql;
	}
	
	/**
	 * 前置条件
	 * 
	 * @return precondition
	 */
	public String getPrecondition() {
		return precondition;
	}
	
	/**
	 * 执行步骤
	 * 
	 * @return standard_detail
	 */
	public String getStandard_detail() {
		return standard_detail;
	}
	
	/**
	 * 期望结果
	 * 
	 * @return expected_results
	 */
	public String getExpected_results() {
		return expected_results;
	}
	
	/**
	 * 实际结果
	 * 
	 * @return actual_results
	 */
	public String getActual_results() {
		return actual_results;
	}
	
	/**
	 * 状态（0执行通过，1执行未通过，-1执行）
	 * 
	 * @return pass_or_fail
	 */
	public Integer getPass_or_fail() {
		return pass_or_fail;
	}
	
	/**
	 * 新增人
	 * 
	 * @return create_name
	 */
	public String getCreate_name() {
		return create_name;
	}
	
	/**
	 * 新增时间
	 * 
	 * @return create_time
	 */
	public Date getCreate_time() {
		return create_time;
	}
	
	/**
	 * 修改人
	 * 
	 * @return update_name
	 */
	public String getUpdate_name() {
		return update_name;
	}
	
	/**
	 * 修改时间
	 * 
	 * @return update_time
	 */
	public Date getUpdate_time() {
		return update_time;
	}
	
	/**
	 * 通过时间
	 * 
	 * @return pass_time
	 */
	public Date getPass_time() {
		return pass_time;
	}
	
	/**
	 * 执行次数
	 * 
	 * @return execute_number
	 */
	public Integer getExecute_number() {
		return execute_number;
	}
	

	/**
	 * 测试用例ID
	 * 
	 * @param standard_id
	 */
	public void setStandard_id(Integer standard_id) {
		this.standard_id = standard_id;
	}
	
	/**
	 * 测试用例编码
	 * 
	 * @param standard_code
	 */
	public void setStandard_code(String standard_code) {
		this.standard_code = standard_code;
	}
	
	/**
	 * 测试用例名称
	 * 
	 * @param standard_name
	 */
	public void setStandard_name(String standard_name) {
		this.standard_name = standard_name;
	}
	
	/**
	 * 执行序号
	 * 
	 * @param execute_code
	 */
	public void setExecute_code(Integer execute_code) {
		this.execute_code = execute_code;
	}
	
	/**
	 * 项目ID
	 * 
	 * @param proj_id
	 */
	public void setProj_id(Integer proj_id) {
		this.proj_id = proj_id;
	}
	
	/**
	 * 模块ID
	 * 
	 * @param stand_id
	 */
	public void setStand_id(String stand_id) {
		this.stand_id = stand_id;
	}
	
	/**
	 * 测试环境
	 * 
	 * @param test_environment
	 */
	public void setTest_environment(String test_environment) {
		this.test_environment = test_environment;
	}
	
	/**
	 * 对应的需求id
	 * 
	 * @param demand_id
	 */
	public void setDemand_id(String demand_id) {
		this.demand_id = demand_id;
	}
	
	/**
	 * 测试数据sql
	 * 
	 * @param data_sql
	 */
	public void setData_sql(String data_sql) {
		this.data_sql = data_sql;
	}
	
	/**
	 * 前置条件
	 * 
	 * @param precondition
	 */
	public void setPrecondition(String precondition) {
		this.precondition = precondition;
	}
	
	/**
	 * 执行步骤
	 * 
	 * @param standard_detail
	 */
	public void setStandard_detail(String standard_detail) {
		this.standard_detail = standard_detail;
	}
	
	/**
	 * 期望结果
	 * 
	 * @param expected_results
	 */
	public void setExpected_results(String expected_results) {
		this.expected_results = expected_results;
	}
	
	/**
	 * 实际结果
	 * 
	 * @param actual_results
	 */
	public void setActual_results(String actual_results) {
		this.actual_results = actual_results;
	}
	
	/**
	 * 状态（0执行通过，1执行未通过，-1执行）
	 * 
	 * @param pass_or_fail
	 */
	public void setPass_or_fail(Integer pass_or_fail) {
		this.pass_or_fail = pass_or_fail;
	}
	
	/**
	 * 新增人
	 * 
	 * @param create_name
	 */
	public void setCreate_name(String create_name) {
		this.create_name = create_name;
	}
	
	/**
	 * 新增时间
	 * 
	 * @param create_time
	 */
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	
	/**
	 * 修改人
	 * 
	 * @param update_name
	 */
	public void setUpdate_name(String update_name) {
		this.update_name = update_name;
	}
	
	/**
	 * 修改时间
	 * 
	 * @param update_time
	 */
	public void setUpdate_time(Date update_time) {
		this.update_time = update_time;
	}
	
	/**
	 * 通过时间
	 * 
	 * @param pass_time
	 */
	public void setPass_time(Date pass_time) {
		this.pass_time = pass_time;
	}
	
	/**
	 * 执行次数
	 * 
	 * @param execute_number
	 */
	public void setExecute_number(Integer execute_number) {
		this.execute_number = execute_number;
	}

	public String getTester_name() {
		return tester_name;
	}

	public void setTester_name(String tester_name) {
		this.tester_name = tester_name;
	}

	public Date getTest_time() {
		return test_time;
	}

	public void setTest_time(Date test_time) {
		this.test_time = test_time;
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}

	public int getCreate_id() {
		return create_id;
	}

	public void setCreate_id(int create_id) {
		this.create_id = create_id;
	}

	public int getUpdate_id() {
		return update_id;
	}

	public void setUpdate_id(int update_id) {
		this.update_id = update_id;
	}

	public String getTester_id() {
		return tester_id;
	}

	public void setTester_id(String tester_id) {
		this.tester_id = tester_id;
	}
	
	public String getPriority() {
		return priority;
	}

	public void setPriority(String priority) {
		this.priority = priority;
	}

	public String getFunction_module() {
		return function_module;
	}

	public void setFunction_module(String function_module) {
		this.function_module = function_module;
	}

	public String getTest_premise() {
		return test_premise;
	}

	public void setTest_premise(String test_premise) {
		this.test_premise = test_premise;
	}
}
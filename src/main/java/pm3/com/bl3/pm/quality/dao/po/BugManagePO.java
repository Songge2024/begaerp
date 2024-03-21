package com.bl3.pm.quality.dao.po;

import java.math.BigDecimal;
import java.util.Date;

import aos.framework.core.typewrap.PO;

/**
 * <b>qa_bug_manage[qa_bug_manage]数据持久化对象</b>
 * <p>
 * 注意:此文件由AOS平台自动生成-禁止手工修改。
 * </p>
 * 
 * @author yiping
 * @date 2017-12-08 11:13:48
 */
public class BugManagePO extends PO {

	private static final long serialVersionUID = 1L;

	/**
	 * 缺陷ID
	 */
	private String bug_id;
	/**
	 * 缺陷编码
	 */
	private String bug_code;
	//项目名称
	private String proj_name;
	//模块名称
	private String dm_name;
	//当前处理人
	private String deal_man_name;
	//需求名称
	private String demand_name;
	//新增人
	private String bug_create_name;
	/**
	 * 测试用例ID
	 */
	private String standard_id;
	/**
	 * 测试用例名称
	 */
	private String standard_name;
	
	/**
	 * 需求ID
	 */
	private String demand_id;
	
	/**
	 * 消息记录ID
	 */
	private String log_id;
	
	/**
	 * 项目ID
	 */
	private String proj_id;
	
	/**
	 * 模块ID
	 */
	private String stand_id;
	
	/**
	 * 缺陷名称
	 */
	private String bug_name;
	
	/**
	 * 缺陷详情
	 */
	private String bug_detail;
	
	/**
	 * 当前状态
	 */
	private String state;
	
	/**
	 * 优先级
	 */
	private String priority;
	
	/**
	 * 严重程度
	 */
	private String severity;
	
	/**
	 * bug位置(问题类别)
	 */
	private String bug_addr;
	
	/**
	 * 出现频率
	 */
	private String rate;
	
	/**
	 * 来源方
	 */
	private String source;
	
	/**
	 * 发现时间
	 */
	private Date find_time;
	
	/**
	 * 发现时间
	 */
	private String find_newtime;
	
	/**
	 * 发现人
	 */
	private String find_name;
	
	/**
	 * 类型(是否缺陷)
	 */
	private String bug_type;
	
	/**
	 * 新增人
	 */
	private String create_name;
	
	/**
	 * 新增时间
	 */
	private Date create_time;
	
	/**
	 * 新增时间
	 */
	private String create_newtime;
	
	/**
	 * 修改人
	 */
	private String update_name;
	
	/**
	 * 修改时间
	 */
	private Date update_time;
	
	/**
	 * 问题关闭人
	 */
	private String close_name;
	
	/**
	 * 关闭时间
	 */
	private Date close_time;
	
	/**
	 * 关闭时间
	 */
	private String close_newtime;
	
	private Date deal_time;
	
	public Date getDeal_time() {
		return deal_time;
	}
	public void setDeal_time(Date deal_time) {
		this.deal_time = deal_time;
	}
	/**
	 * 当前处置人
	 */
	private String deal_man;
	/**
	 * 版本号ID
	 */
	private Integer version_id;
	
	/**
	 * 代码版本号ID
	 */
	private Integer code_version_id;
	/**
	 * 测试版本号ID
	 */
	private Integer test_version_id;
	/**
	 * 版本号
	 */
	private String version_number;
	/**
	 * 代码版本号
	 */
	private String code_version_number;
	/**
	 * 测试版本号
	 */
	private String test_version_number;
	//上级模块名称
	private String dm_parent_name;
	
	/**
	 * bug修改人姓名
	 * @return
	 */
	private String bug_update_name;
	
	/**
	 * 相关缺陷编码
	 * @return
	 */
	private String relate_bug_code;
	
	/**
	 * 计划消耗天数
	 */
	private BigDecimal plan_wastage;
	
	/**
	 * 实际消耗天数
	 */
	private BigDecimal real_wastage;
	
	/**
	 * 是否管理用户人员
	 */
	private int manager_user_count;
	
	private Integer slight;
	private Integer general;
	private Integer severitys;
	private Integer deadly;
	private Integer subtotal;
	private Integer open;
	private Integer postpone;
	private Integer resolved;
	private String deal_name;
	
	private String dic_descs;
	private int bug_total;
	private int solved;
	private int tobesolve;
	private int other;
	private String resolution;
	private int solve_severitys;
	
	private String final_deal_man;
	private Date final_deal_time;
	
	
	
	
	public String getFinal_deal_man() {
		return final_deal_man;
	}
	public void setFinal_deal_man(String final_deal_man) {
		this.final_deal_man = final_deal_man;
	}
	public Date getFinal_deal_time() {
		return final_deal_time;
	}
	public void setFinal_deal_time(Date final_deal_time) {
		this.final_deal_time = final_deal_time;
	}
	public int getSolve_severitys() {
		return solve_severitys;
	}
	public void setSolve_severitys(int solve_severitys) {
		this.solve_severitys = solve_severitys;
	}
	public String getDic_descs() {
		return dic_descs;
	}
	public void setDic_descs(String dic_descs) {
		this.dic_descs = dic_descs;
	}
	public int getBug_total() {
		return bug_total;
	}
	public void setBug_total(int bug_total) {
		this.bug_total = bug_total;
	}
	public int getSolved() {
		return solved;
	}
	public void setSolved(int solved) {
		this.solved = solved;
	}
	public int getTobesolve() {
		return tobesolve;
	}
	public void setTobesolve(int tobesolve) {
		this.tobesolve = tobesolve;
	}
	public int getOther() {
		return other;
	}
	public void setOther(int other) {
		this.other = other;
	}
	public String getResolution() {
		return resolution;
	}
	public void setResolution(String resolution) {
		this.resolution = resolution;
	}
	public String getDeal_name() {
		return deal_name;
	}
	public void setDeal_name(String deal_name) {
		this.deal_name = deal_name;
	}
	public Integer getSlight() {
		return slight;
	}
	public void setSlight(Integer slight) {
		this.slight = slight;
	}
	public Integer getGeneral() {
		return general;
	}
	public void setGeneral(Integer general) {
		this.general = general;
	}
	public Integer getSeveritys() {
		return severitys;
	}
	public void setSeveritys(Integer severitys) {
		this.severitys = severitys;
	}
	public Integer getDeadly() {
		return deadly;
	}
	public void setDeadly(Integer deadly) {
		this.deadly = deadly;
	}
	public Integer getSubtotal() {
		return subtotal;
	}
	public void setSubtotal(Integer subtotal) {
		this.subtotal = subtotal;
	}
	public Integer getOpen() {
		return open;
	}
	public void setOpen(Integer open) {
		this.open = open;
	}
	public Integer getPostpone() {
		return postpone;
	}
	public void setPostpone(Integer postpone) {
		this.postpone = postpone;
	}
	public Integer getResolved() {
		return resolved;
	}
	public void setResolved(Integer resolved) {
		this.resolved = resolved;
	}
	public Integer getClose() {
		return close;
	}
	public void setClose(Integer close) {
		this.close = close;
	}
	public Integer getRefuse() {
		return refuse;
	}
	public void setRefuse(Integer refuse) {
		this.refuse = refuse;
	}
	public Integer getReappear() {
		return reappear;
	}
	public void setReappear(Integer reappear) {
		this.reappear = reappear;
	}
	public String getStard_name() {
		return stard_name;
	}
	public void setStard_name(String stard_name) {
		this.stard_name = stard_name;
	}
	private Integer close;
	private Integer refuse;
	private Integer reappear;
	private String stard_name;
	
	
	
	
	
	public String getRelate_bug_code() {
		return relate_bug_code;
	}
	public void setRelate_bug_code(String relate_bug_code) {
		this.relate_bug_code = relate_bug_code;
	}
	public String getDm_parent_name() {
		return dm_parent_name;
	}
	public void setDm_parent_name(String dm_parent_name) {
		this.dm_parent_name = dm_parent_name;
	}
	public String getBug_update_name() {
		return bug_update_name;
	}
	public void setBug_update_name(String bug_update_name) {
		this.bug_update_name = bug_update_name;
	}
	public String getVersion_number() {
		return version_number;
	}
	public void setVersion_number(String version_number) {
		this.version_number = version_number;
	}
	public String getCode_version_number() {
		return code_version_number;
	}
	public void setCode_version_number(String code_version_number) {
		this.code_version_number = code_version_number;
	}
	
	/**
	 * 缺陷ID
	 * 
	 * @return bug_id
	 */
	public String getBug_id() {
		return bug_id;
	}
	/**
	 * 缺陷编码
	 * 
	 * @return bug_code
	 */
	public String getBug_code() {
		return bug_code;
	}
	
	/**
	 * 缺陷编码
	 * 
	 * @return proj_name
	 */
	public String getProj_name() {
		return proj_name;
	}
	/**
	 * 缺陷编码
	 * 
	 * @return dm_name
	 */
	public String getDm_name() {
		return dm_name;
	}
	
	/**
	 * 需求名称
	 * 
	 * @return demand_name
	 */
	public String getDemand_name() {
		return demand_name;
	}
	
	/**
	 * 新增人
	 * 
	 * @return bug_create_name
	 */
	public String getBug_create_name() {
		return bug_create_name;
	}
	/**
	 * 当前处理人
	 * 
	 * @return deal_man_name
	 */
	public String getDeal_man_name() {
		return deal_man_name;
	}

	/**
	 * 测试用例ID
	 * 
	 * @return standard_id
	 */
	public String getStandard_id() {
		return standard_id;
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
	 * 需求ID
	 * 
	 * @return demand_id
	 */
	public String getDemand_id() {
		return demand_id;
	}
	
	/**
	 * 消息记录ID
	 * 
	 * @return log_id
	 */
	public String getLog_id() {
		return log_id;
	}
	
	/**
	 * 项目ID
	 * 
	 * @return proj_id
	 */
	public String getProj_id() {
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
	 * 缺陷名称
	 * 
	 * @return bug_name
	 */
	public String getBug_name() {
		return bug_name;
	}
	
	/**
	 * 缺陷详情
	 * 
	 * @return bug_detail
	 */
	public String getBug_detail() {
		return bug_detail;
	}
	
	/**
	 * 当前状态
	 * 
	 * @return state
	 */
	public String getState() {
		return state;
	}
	
	/**
	 * 优先级
	 * 
	 * @return priority
	 */
	public String getPriority() {
		return priority;
	}
	
	/**
	 * 严重程度
	 * 
	 * @return severity
	 */
	public String getSeverity() {
		return severity;
	}
	
	/**
	 * bug位置(问题类别)
	 * 
	 * @return bug_addr
	 */
	public String getBug_addr() {
		return bug_addr;
	}
	
	/**
	 * 出现频率
	 * 
	 * @return rate
	 */
	public String getRate() {
		return rate;
	}
	
	/**
	 * 来源方
	 * 
	 * @return source
	 */
	public String getSource() {
		return source;
	}
	
	/**
	 * 发现时间
	 * 
	 * @return find_time
	 */
	public Date getFind_time() {
		return find_time;
	}
	
	/**
	 * 发现时间
	 * 
	 * @return find_newtime
	 */
	public String getFind_newtime() {
		return find_newtime;
	}
	
	/**
	 * 发现时间
	 * 
	 * @return find_name
	 */
	public String getFind_name() {
		return find_name;
	}
	
	/**
	 * 类型(是否缺陷)
	 * 
	 * @return bug_type
	 */
	public String getBug_type() {
		return bug_type;
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
	 * 新增时间
	 * 
	 * @return create_newtime
	 */
	public String getCreate_newtime() {
		return create_newtime;
	}
	/**
	 * 新增人
	 * 
	 * @return update_name
	 */
	public String getUpdate_name() {
		return update_name;
	}
	
	/**
	 * 新增时间
	 * 
	 * @return update_time
	 */
	public Date getUpdate_time() {
		return update_time;
	}
	
	/**
	 * 问题关闭人
	 * 
	 * @return close_name
	 */
	public String getClose_name() {
		return close_name;
	}
	
	/**
	 * 关闭时间
	 * 
	 * @return close_time
	 */
	public Date getClose_time() {
		return close_time;
	}
	/**
	 * 关闭时间
	 * 
	 * @return close_newtime
	 */
	public String getClose_newtime() {
		return close_newtime;
	}
	
	/**
	 * 当前处置人
	 * 
	 * @return deal_man
	 */
	public String getDeal_man() {
		return deal_man;
	}
	/**
	 * 版本号
	 * 
	 * @return version_number
	 */
	public Integer getVersion_id() {
		return version_id;
	}
	
	/**
	 * 代码版本号
	 * 
	 * @return code_version_number
	 */
	public Integer getCode_version_id() {
		return code_version_id;
	}
	

	/**
	 * 缺陷ID
	 * 
	 * @param bug_id
	 */
	public void setBug_id(String bug_id) {
		this.bug_id = bug_id;
	}
	/**
	 * 缺陷编码
	 * 
	 * @param bug_code
	 */
	public void setBug_code(String bug_code) {
		this.bug_code = bug_code;
	}
	/**
	 * 缺陷编码
	 * 
	 * @param proj_name
	 */
	public void setProj_name(String proj_name) {
		this.proj_name = proj_name;
	}
	/**
	 * 缺陷编码
	 * 
	 * @param dm_name
	 */
	public void setDm_name(String dm_name) {
		this.dm_name = dm_name;
	}
	/**
	 * 需求名称
	 * 
	 * @param demand_name
	 */
	public void setDemand_name(String demand_name) {
		this.demand_name = demand_name;
	}
	
	/**
	 * 新增人
	 * 
	 * @param bug_create_name
	 */
	public void setBug_create_name(String bug_create_name) {
		this.bug_create_name = bug_create_name;
	}
	/**
	 * 当前处理人
	 * 
	 * @param deal_man_name
	 */
	public void setDeal_man_name(String deal_man_name) {
		this.deal_man_name = deal_man_name;
	}
	/**
	 * 测试用例ID
	 * 
	 * @param standard_id
	 */
	public void setStandard_id(String standard_id) {
		this.standard_id = standard_id;
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
	 * 需求ID
	 * 
	 * @param demand_id
	 */
	public void setDemand_id(String demand_id) {
		this.demand_id = demand_id;
	}
	
	/**
	 * 消息记录ID
	 * 
	 * @param log_id
	 */
	public void setLog_id(String log_id) {
		this.log_id = log_id;
	}
	
	/**
	 * 项目ID
	 * 
	 * @param proj_id
	 */
	public void setProj_id(String proj_id) {
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
	 * 缺陷名称
	 * 
	 * @param bug_name
	 */
	public void setBug_name(String bug_name) {
		this.bug_name = bug_name;
	}
	
	/**
	 * 缺陷详情
	 * 
	 * @param bug_detail
	 */
	public void setBug_detail(String bug_detail) {
		this.bug_detail = bug_detail;
	}
	
	/**
	 * 当前状态
	 * 
	 * @param state
	 */
	public void setState(String state) {
		this.state = state;
	}
	
	/**
	 * 优先级
	 * 
	 * @param priority
	 */
	public void setPriority(String priority) {
		this.priority = priority;
	}
	
	/**
	 * 严重程度
	 * 
	 * @param severity
	 */
	public void setSeverity(String severity) {
		this.severity = severity;
	}
	
	/**
	 * bug位置(问题类别)
	 * 
	 * @param bug_addr
	 */
	public void setBug_addr(String bug_addr) {
		this.bug_addr = bug_addr;
	}
	
	/**
	 * 出现频率
	 * 
	 * @param rate
	 */
	public void setRate(String rate) {
		this.rate = rate;
	}
	
	/**
	 * 来源方
	 * 
	 * @param source Integer
	 */
	public void setSource(String source) {
		this.source = source;
	}
	
	/**
	 * 发现人
	 * 
	 * @param find_name
	 */
	public void setFind_name(String find_name) {
		this.find_name = find_name;
	}
	/**
	 * 发现时间
	 * 
	 * @param find_time
	 */
	public void setFind_time(Date find_time) {
		this.find_time = find_time;
	}
	
	/**
	 * 发现时间
	 * 
	 * @param find_newtime
	 */
	public void setFind_newtime(String find_newtime) {
		this.find_newtime = find_newtime;
	}
	
	/**
	 * 类型(是否缺陷)
	 * 
	 * @param bug_type
	 */
	public void setBug_type(String bug_type) {
		this.bug_type = bug_type;
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
	 * 新增时间
	 * 
	 * @param create_newtime
	 */
	public void setCreate_newtime(String create_newtime) {
		this.create_newtime = create_newtime;
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
	 *  修改时间
	 * 
	 * @param update_time
	 */
	public void setUpdate_time(Date update_time) {
		this.update_time = update_time;
	}
	
	/**
	 * 问题关闭人
	 * 
	 * @param close_name
	 */
	public void setClose_name(String close_name) {
		this.close_name = close_name;
	}
	
	/**
	 * 关闭时间
	 * 
	 * @param close_time
	 */
	public void setClose_time(Date close_time) {
		this.close_time = close_time;
	}
	
	/**
	 * 关闭时间
	 * 
	 * @param close_newtime
	 */
	public void setClose_newtime(String close_newtime) {
		this.close_newtime = close_newtime;
	}
	/**
	 * 当前处置人
	 * 
	 * @param deal_man
	 */
	public void setDeal_man(String deal_man) {
		this.deal_man = deal_man;
	}
	
	/**
	 * 版本号
	 * 
	 * @param version_number
	 */
	public void setVersion_id(Integer version_id) {
		this.version_id = version_id;
	}
	
	/**
	 * 代码版本号
	 * 
	 * @param code_version_number
	 */
	public void setCode_version_id(Integer code_version_id) {
		this.code_version_id = code_version_id;
	}
	public Integer getTest_version_id() {
		return test_version_id;
	}
	public void setTest_version_id(Integer test_version_id) {
		this.test_version_id = test_version_id;
	}
	public String getTest_version_number() {
		return test_version_number;
	}
	public void setTest_version_number(String test_version_number) {
		this.test_version_number = test_version_number;
	}
	public BigDecimal getReal_wastage() {
		return real_wastage;
	}
	public void setReal_wastage(BigDecimal real_wastage) {
		this.real_wastage = real_wastage;
	}
	public BigDecimal getPlan_wastage() {
		return plan_wastage;
	}
	public void setPlan_wastage(BigDecimal plan_wastage) {
		this.plan_wastage = plan_wastage;
	}
	public int getManager_user_count() {
		return manager_user_count;
	}
	public void setManager_user_count(int manager_user_count) {
		this.manager_user_count = manager_user_count;
	}
	
	
}
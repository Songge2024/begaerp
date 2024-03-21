package com.bl3.pm.process.service;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.excel.xlsx.ExcelExporterX;
import aos.framework.core.exception.AOSException;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.typewrap.Dtos;
import aos.framework.core.utils.AOSJson;
import aos.framework.core.utils.AOSUtils;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;

import com.alibaba.druid.support.json.JSONUtils;
import com.bl3.pm.process.dao.ProblemTraceDao;
import com.bl3.pm.process.dao.po.ProblemTracePO;

/**
 * <b>pr_problem_trace[pr_problem_trace]业务逻辑层</b>
 * 
 * @author hanjin
 * @date 2019-10-31 10:33:56
 */
 @Service
 public class ProblemTraceService{
 	private static Logger logger = LoggerFactory.getLogger(ProblemTraceService.class);
 	@Autowired
	private ProblemTraceDao problemTraceDao;
	@Autowired
	private SqlDao sqlDao;
	@Autowired
	private IdService idService;
	
	/**
	 * 初始化视图
	 * 
	 * @param httpModel
	 * @return
	 */
	public void init(HttpModel httpModel) {
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		Dto inDto = httpModel.getInDto();
		int person_id = httpModel.getUserModel().getId();
		inDto.put("person_id", person_id);
		Dto getDto = sqlDao.selectDto("DailyReportDao.GetDefaultProject", inDto);
		String proj_id = "";
		String proj_name="";
		if(getDto.get("proj_id")!=null){
			proj_id = getDto.get("proj_id").toString();
		    proj_name= getDto.get("proj_name").toString();
		}
		httpModel.setAttribute("proj_id", proj_id);
		httpModel.setAttribute("proj_name", proj_name);
		httpModel.setViewPath("pm3/process/checkProblemTrace/problemTrace_list.jsp");
	}
	/**
	 * 新增
	 * 
	 * @param httpModel
	 * @return
	 */
	public void create(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		ProblemTracePO problemTracePO=new ProblemTracePO();
		problemTracePO.copyProperties(inDto);
		problemTraceDao.insert(problemTracePO);
		httpModel.setOutMsg("新增成功");
	}
	/**
	 * 新增问题跟踪
	 */
	public void createProblem(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		int create_user_id = httpModel.getUserModel().getId();
		Dto dto = sqlDao.selectDto("com.bl3.pm.process.dao.ProblemTraceDao.selectCheckMain", inDto.getString("check_id"));
		List<ProblemTracePO> POs = sqlDao.list("com.bl3.pm.process.dao.ProblemTraceDao.selectCheckDetail", inDto.getString("check_id"));
		for(ProblemTracePO po : POs){
			po.setCheck_code(dto.getString("check_code"));
			po.setCheck_name(dto.getString("check_name"));
			try {
				po.setCheck_time(sdf.parse(dto.getString("check_time")));
			} catch (ParseException e) {
				e.printStackTrace();
			}
			//po.setCheck_time(dto.getDate("check_time"));
			dto.getString("check_time");
			po.setCheck_id(inDto.getInteger("check_id"));
			po.setCreate_user_id(create_user_id);
			po.setCreate_time(new Date());
			problemTraceDao.insert(po);
		}
		httpModel.setOutMsg("新增成功");
	}
	/**
	 * 修改
	 * 
	 * @param httpModel
	 * @return
	 */
	public void update(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		ProblemTracePO problemTracePO=new ProblemTracePO();
		problemTracePO.copyProperties(inDto);
		problemTraceDao.updateByKey(problemTracePO);
		httpModel.setOutMsg("修改成功");
	}
	/**
	 * 统一保存
	 */
	public void updateGrid(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		SimpleDateFormat sdf = new SimpleDateFormat( "yyyy-MM-dd");
		Integer update_user_id = httpModel.getUserModel().getId();
		List<Dto> modifies = inDto.getRows();
		if(modifies.isEmpty()){
			httpModel.setOutMsg("请先选择需保存的检查项!");
			return;
		}
		for (Dto dto : modifies) {
			List<Date> checkDate = new ArrayList<Date>();
			if(AOSUtils.isNotEmpty(dto.getString("principal_org_name"))){
				if(isNumeric(dto.getString("principal_org_name"))){
					int principal_org = dto.getInteger("principal_org_name");
					dto.put("principal_org",principal_org);
				}
			}
			if(AOSUtils.isNotEmpty(dto.getString("principal_name"))){
				if(isNumeric(dto.getString("principal_name"))){
					int principal = dto.getInteger("principal_name");
					dto.put("principal",principal);
				}
			}
			if(AOSUtils.isNotEmpty(dto.getString("deal_man"))){
				//String deal_man=StringUtils.join(dto.getList("deal_man"),",");
				String deal_man = dto.getString("deal_man");
				dto.put("deal_man",deal_man);
			}
			if(AOSUtils.isNotEmpty(dto.getString("solve_time"))){
				try {
					Date check_time = sdf.parse(dto.getString("check_time"));
					Date solve_time = sdf.parse(dto.getString("solve_time"));
					List<Date> lDate = findDates(check_time,solve_time);
					for(Date da : lDate){
						 Calendar calendar = Calendar.getInstance();
					     calendar.setTime(da);
					     int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK)-1;
						if(dayOfWeek != 0 && dayOfWeek != 6){
							checkDate.add(da);
						}
					}
					long day = checkDate.size();
					dto.put("solve_day", day);
					if(day>dto.getLong("solve_times")){
						dto.put("solve_time_point", dto.get("solve_deduct_point"));
					}else{
						dto.put("solve_time_point", 0);
					}
				} catch (ParseException e) {
					e.printStackTrace();
				}
			}
			dto.put("update_user_id", update_user_id);
			problemTraceDao.problemUpdateByKey(dto);
		}
		httpModel.setOutMsg("保存成功");
	}
	/**
	 * 判断是否为数字（正则）
	 */
	public static boolean isNumeric(String str){
		Pattern pattern = Pattern.compile("[0-9]*");
		return pattern.matcher(str).matches();   
	}
	/**
	 * 初始和选择项目查询变更未解决的问题
	 */
	public void changeTimer(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		Date date = new Date();
		List<ProblemTracePO> problemTracePOs = problemTraceDao.searchChangeTrace(inDto);
		for(ProblemTracePO POs : problemTracePOs){
			List<Date> checkDate = new ArrayList<Date>();
			List<Date> lDate = findDates(POs.getCheck_time(),date);
			for(Date da : lDate){
				Calendar calendar = Calendar.getInstance();
			    calendar.setTime(da);
			    int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK)-1;
				if(dayOfWeek != 0 && dayOfWeek != 6){
					checkDate.add(da);
				}
			}
			long day = checkDate.size();
			if(day>Long.valueOf(POs.getSolve_times())){
				POs.setSolve_time_point(POs.getSolve_deduct_point());
				problemTraceDao.updateByKey(POs);
			}
		}
		httpModel.setOutMsg("查询完成");
	}
	/**
     * 获取某段时这里写代码片间内的所有日期
     * @param dBegin
     * @param dEnd
     * @return
     */
    public static List<Date> findDates(Date dBegin, Date dEnd) {
         List<Date> lDate = new ArrayList<Date>();
         lDate.add(dBegin);
         Calendar calBegin = Calendar.getInstance();
         // 使用给定的 Date 设置此 Calendar 的时间
         calBegin.setTime(dBegin);
         Calendar calEnd = Calendar.getInstance();
         // 使用给定的 Date 设置此 Calendar 的时间
         calEnd.setTime(dEnd);
         // 测试此日期是否在指定日期之后
         while (dEnd.after(calBegin.getTime()))  {
          // 根据日历的规则，为给定的日历字段添加或减去指定的时间量
              calBegin.add(Calendar.DAY_OF_MONTH, 1);
              lDate.add(calBegin.getTime());
         }
         return lDate;
    }
	/**
	 * 全部导出
	 */
	public void exportAllExcel(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		String problem_state = inDto.getString("problem_state");
		if(AOSUtils.isNotEmpty(problem_state)){
			List<String> problem_stateList =Arrays.asList(problem_state.split(","));
			inDto.put("problem_state", problem_stateList);
		}
		List<Dto> dtos = sqlDao.list("com.bl3.pm.process.dao.ProblemTraceDao.searchProblemTrace", inDto);
		for(int k=0;k<dtos.size();k++){
			Dto dto = dtos.get(k);
			if(AOSUtils.isNotEmpty(dto.get("process_product")) && dto.get("process_product") != ""){
				if(Integer.valueOf(dto.get("process_product").toString()) == 1001){
					dto.put("process_product", "进度计划");
				}else if(Integer.valueOf(dto.get("process_product").toString()) == 1002){
					dto.put("process_product", "周报");
				}else if(Integer.valueOf(dto.get("process_product").toString()) == 1003){
					dto.put("process_product", "配置管理");
				}else if(Integer.valueOf(dto.get("process_product").toString()) == 1004){
					dto.put("process_product", "过程");
				}else if(Integer.valueOf(dto.get("process_product").toString()) == 1005){
					dto.put("process_product", "计划变更");
				}else if(Integer.valueOf(dto.get("process_product").toString()) == 1006){
					dto.put("process_product", "需求变更");
				}else if(Integer.valueOf(dto.get("process_product").toString()) == 1007){
					dto.put("process_product", "问题管理");
				}else{
					dto.put("process_product", "");
				}
			}
			
			if(AOSUtils.isNotEmpty(dto.get("problem_level")) && dto.get("problem_level") != ""){
				if(Integer.valueOf(dto.get("problem_level").toString()) == 1001){
					dto.put("problem_level", "轻微");
				}else if(Integer.valueOf(dto.get("problem_level").toString()) == 1002){
					dto.put("problem_level", "中等");
				}else if(Integer.valueOf(dto.get("problem_level").toString()) == 1003){
					dto.put("problem_level", "严重");
				}else{
					dto.put("problem_level", "");
				}
			}
			
			if(AOSUtils.isNotEmpty(dto.get("problem_sources")) && dto.get("problem_sources") != ""){
				if(Integer.valueOf(dto.get("problem_sources").toString()) == 1001){
					dto.put("problem_sources", "项目组内部");
				}else if(Integer.valueOf(dto.get("problem_sources").toString()) == 1002){
					dto.put("problem_sources", "项目组外部");
				}else{
					dto.put("problem_sources", "");
				}
			}
			
			if(AOSUtils.isNotEmpty(dto.get("problem_state")) && dto.get("problem_state") != ""){
				if(Integer.valueOf(dto.get("problem_state").toString()) == 1001){
					dto.put("problem_state", "未处理");
				}else if(Integer.valueOf(dto.get("problem_state").toString()) == 1002){
					dto.put("problem_state", "已解决");
				}else if(Integer.valueOf(dto.get("problem_state").toString()) == 1003){
					dto.put("problem_state", "跟进中");
				}else if(Integer.valueOf(dto.get("problem_state").toString()) == 1004){
					dto.put("problem_state", "处理中");
				}else{
					dto.put("problem_state", "");
				}
			}
		}
		ExcelExporterX exporter = new ExcelExporterX();
		Dto pDto = Dtos.newDto();//头
		pDto.put("reportTitle", "QA问题跟踪");
		exporter.setData(pDto, dtos);
		exporter.setTemplatePath("/export/excel/problemTrace.xlsx");
		exporter.setFilename("QA问题跟踪.xlsx");
		try {
			exporter.export(httpModel.getRequest(), httpModel.getResponse());
		} catch (IOException e) {
			throw new AOSException("导出失败：" + e.getMessage());
		}
		
		/*List<ProblemTracePO> problemTracePOs = problemTraceDao.searchProblemTrace(inDto);
		for(int k=0;k<problemTracePOs.size();k++){
			ProblemTracePO faPO = problemTracePOs.get(k);
			//判断过程及产品
			if(Integer.valueOf(faPO.getProcess_product().toString())==1001){
				faPO.setProcess_product("进度计划");
			}else if(Integer.valueOf(faPO.getProcess_product().toString())==1002){
				faPO.setProcess_product("周报");
			}else if(Integer.valueOf(faPO.getProcess_product().toString())==1003){
				faPO.setProcess_product("配置管理");
			}else if(Integer.valueOf(faPO.getProcess_product().toString())==1004){
				faPO.setProcess_product("过程");
			}else if(Integer.valueOf(faPO.getProcess_product().toString())==1005){
				faPO.setProcess_product("计划变更");
			}else if(Integer.valueOf(faPO.getProcess_product().toString())==1006){
				faPO.setProcess_product("需求变更");
			}else if(Integer.valueOf(faPO.getProcess_product().toString())==1007){
				faPO.setProcess_product("问题管理");	
			}else{
				faPO.setProcess_product("");	
			}
			
			//判断问题等级
			if(Integer.valueOf(faPO.getProblem_level().toString())==1001){
				faPO.setProblem_level("轻微");
			}else if(Integer.valueOf(faPO.getProblem_level().toString())==1002){
				faPO.setProblem_level("中等");
			}else if(Integer.valueOf(faPO.getProblem_level().toString())==1003){
				faPO.setProblem_level("严重");
			}else{
				faPO.setProblem_level("");
			}
			
			if(AOSUtils.isNotEmpty(faPO.getProblem_sources()) && faPO.getProblem_sources() !=""){
				//判断问题来源
				if(Integer.valueOf(faPO.getProblem_sources().toString())==1001){
					faPO.setProblem_sources("项目组内部");
				}else if(Integer.valueOf(faPO.getProblem_sources().toString())==1002){
					faPO.setProblem_sources("项目组外部");
				}
			}
			
			if(AOSUtils.isNotEmpty(faPO.getProblem_state()) && faPO.getProblem_state() != ""){
				//判断问题状态
				if(Integer.valueOf(faPO.getProblem_state().toString())==1001){
					faPO.setProblem_state("未处理");
				}else if(Integer.valueOf(faPO.getProblem_state().toString())==1002){
					faPO.setProblem_state("已解决");
				}else if(Integer.valueOf(faPO.getProblem_state().toString())==1003){
					faPO.setProblem_state("跟进中");
				}else if(Integer.valueOf(faPO.getProblem_state().toString())==1004){
					faPO.setProblem_state("处理中");
				}
			}
		}
		ExcelExporterX exporter = new ExcelExporterX();
		Dto pDto = Dtos.newDto();//头
		pDto.put("reportTitle", "QA问题跟踪");
		exporter.setData(pDto, problemTracePOs);
		exporter.setTemplatePath("/export/excel/problemTrace.xlsx");
		exporter.setFilename("QA问题跟踪.xlsx");
		try {
			exporter.export(httpModel.getRequest(), httpModel.getResponse());
		} catch (IOException e) {
			throw new AOSException("导出失败：" + e.getMessage());
		}*/
	}
	/**
	 * 删除
	 * 
	 * @param httpModel
	 * @return
	 */
	public void delete(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String[] selectionIds = inDto.getRows();
		for (String id : selectionIds) {
			problemTraceDao.deleteByKey(Integer.valueOf(id));
		}
		httpModel.setOutMsg("删除成功");
	}
	/**
	 * 搜索框处理人下拉框
	 */
	public void listDealMan(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("com.bl3.pm.process.dao.ProblemTraceDao.listDealMan", inDto);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
	/**
	 * 负责人选择下拉框
	 */
	public void listPrincipal(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("com.bl3.pm.process.dao.ProblemTraceDao.listPrincipal", inDto);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
	/**
	 * 负责人部门下拉框
	 */
	public void listPrincipalOrg(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("com.bl3.pm.process.dao.ProblemTraceDao.listPrincipalOrg", inDto);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
	
	/**
	 * 获取项目经理
	 * @param httpModel
	 * @return
	 */
	@Transactional
	public void getProjManager(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		int str=(int) sqlDao.selectOne("com.bl3.pm.process.dao.ProblemTraceDao.getProjManager", inDto);
		httpModel.setOutMsg(String.valueOf(str));
	}
	
	/**
	 * 根据ID查询
	 * 
	 * @param httpModel
	 * @return
	 */
	public void get(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		ProblemTracePO problemTracePO=problemTraceDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(problemTracePO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String problem_states = inDto.getString("problem_state");
		if(AOSUtils.isNotEmpty(problem_states)){
			List<String> problem_stateList =AOSJson.getList(problem_states, String.class);
			inDto.put("problem_state", problem_stateList);
		}
		List<ProblemTracePO> problemTracePOs = problemTraceDao.likePage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(problemTracePOs, inDto.getPageTotal()));
	}
 }
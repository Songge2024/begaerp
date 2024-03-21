   package com.bl3.pm.quality.service;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.excel.xls.ExcelExporter;
import aos.framework.core.excel.xlsx.ExcelExporterX;
import aos.framework.core.excel.xlsx.ExcelReaderX;
import aos.framework.core.excel.xls.ExcelReader;
import aos.framework.core.exception.AOSException;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.typewrap.Dtos;
import aos.framework.core.utils.AOSJson;
import aos.framework.core.utils.AOSUtils;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;
import oracle.net.aso.h;

import com.bl3.pm.quality.dao.TestExampleDao;
import com.bl3.pm.quality.dao.po.BugManagePO;
import com.bl3.pm.quality.dao.po.TestExamplePO;
import com.mongodb.util.JSON;

/**
 * <b>qa_test_example[qa_test_example]业务逻辑层</b>
 * 
 * @author wjl
 * @date 2017-12-15 08:51:41
 */
 @Service
 public class TestExampleService{
 	private static Logger logger = LoggerFactory.getLogger(TestExampleService.class);
 	@Autowired
	private TestExampleDao testExampleDao;
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
		httpModel.setViewPath("pm3/quality/testexample/testExample.jsp");
	}
	
	/**
	 * 初始化测试用例导入模板视图
	 * @param httpModel
	 */
	public void initPage(HttpModel httpModel){
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
		httpModel.setViewPath("pm3/quality/testexample/testExampleTemplate.jsp");
	}
	/**
	 * 新增
	 * 
	 * @param httpModel
	 * @return
	 */
	public void create(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String name = httpModel.getUserModel().getName();
		int id = httpModel.getUserModel().getId();
		inDto.put("create_name", name);
		inDto.put("create_id", id);
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		inDto.put("create_time", sdf.format(date));
		if(AOSUtils.isEmpty(inDto.getInteger("pass_or_fail")) || inDto.getInteger("pass_or_fail")==0){
			inDto.put("pass_time", "1999-01-01 00:00:00");
		}else if(inDto.getInteger("pass_or_fail") == 1){
			inDto.put("pass_time", sdf.format(date));
		}
		TestExamplePO testExamplePO=new TestExamplePO();
		testExamplePO.copyProperties(inDto);
		//序号重新排序
		List<TestExamplePO> list = sqlDao.list("TestExampleDao.ListExecuteCode", inDto);
		for (int i = 0; i < list.size(); i++) {
			TestExamplePO testPO = list.get(i);
			testPO.setExecute_code(testPO.getExecute_code()+1);//序号加一
			testExampleDao.updateByKey(testPO);
		}
		testExampleDao.insert(testExamplePO);
		//修改当前测试编码下的所有公共信息（需求，测试sql。。。。）
		sqlDao.update("TestExampleDao.updateCommonalityInfo", inDto);
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
		//inDto.remove("id");
		String name = httpModel.getUserModel().getName();
		int id = httpModel.getUserModel().getId();
		inDto.put("update_name", name);
		inDto.put("update_id", id);
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		inDto.put("update_time", sdf.format(date));
		if(AOSUtils.isEmpty(inDto.getInteger("pass_or_fail")) || inDto.getInteger("pass_or_fail")==0){
			inDto.put("pass_time", "1999-01-01 00:00:00");
		}else if(inDto.getInteger("pass_or_fail") == 1){
			inDto.put("pass_time", sdf.format(date));
		}
		TestExamplePO testExamplePO=new TestExamplePO();
		testExamplePO.copyProperties(inDto);
		//序号重新排序
		if(inDto.getInteger("raw_execute_code") < inDto.getInteger("execute_code")){
			List<Dto> listMix = sqlDao.list("TestExampleDao.ListExecuteCodeMix", inDto);
			for (int i = 0; i < listMix.size(); i++) {
				Dto testPO = listMix.get(i);
				testPO.put("execute_code", testPO.getInteger("execute_code")-1);//序号减一
				sqlDao.update("TestExampleDao.updateByKey",testPO);
			}
		}else if(inDto.getInteger("raw_execute_code") > inDto.getInteger("execute_code")){
			List<Dto> listMax = sqlDao.list("TestExampleDao.ListExecuteCodeMax", inDto);
			for (int i = 0; i < listMax.size(); i++) {
				Dto testPO = listMax.get(i);
				testPO.put("execute_code", testPO.getInteger("execute_code")+1);//序号加一
				sqlDao.update("TestExampleDao.updateByKey",testPO);
			}
		}
		testExampleDao.updateByKey(testExamplePO);
		//修改当前测试编码下的所有公共信息（需求，测试sql。。。。）
		sqlDao.update("TestExampleDao.updateCommonalityInfo", inDto);
		httpModel.setOutMsg("修改成功");
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
		String[] execute_code = inDto.getString("execute_code").split(",");
		String[] standard_code = inDto.getString("standard_code").split(",");
		for (int i=0;i<selectionIds.length;i++) {
			//序号重新排序
			Dto dto = Dtos.newDto();
			dto.put("execute_code", execute_code[i]);
			dto.put("standard_code", standard_code[i]);
			List<TestExamplePO> list = sqlDao.list("TestExampleDao.ListExecuteCodeDelete", dto);
			for (int j = 0; j < list.size(); j++) {
				TestExamplePO testPO = list.get(j);
				testPO.setExecute_code(testPO.getExecute_code()-1);//序号减一
				testExampleDao.updateByKey(testPO);
			}
			testExampleDao.deleteByKey(Integer.valueOf(selectionIds[i]));
		}
		httpModel.setOutMsg("删除成功");
	}
	
	/**
	 * 查询项目版本号
	 */
	public void selectVersionId(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		int version_id = (int) sqlDao.selectOne("TestExampleDao.selectVersionId", inDto);
		httpModel.setOutMsg(AOSJson.toJson(version_id));
	}
	
	/**
	 * 测试用例模板导入
	 */
	public void importExampleModule(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		String[] selectionIds = inDto.getRows();
		for(String id : selectionIds){
			TestExamplePO testPO = testExampleDao.selectByStandardId(Integer.valueOf(id));
			TestExamplePO testExamplePO = new TestExamplePO();
			String create_name = httpModel.getUserModel().getName();
			Integer create_id = httpModel.getUserModel().getId();
			testExamplePO.setCreate_id(create_id);
			testExamplePO.setCreate_name(create_name);
			testExamplePO.setCreate_time(new Date());
			testExamplePO.setProj_id(inDto.getInteger("proj_id")); //项目id
			testExamplePO.setStand_id(inDto.getString("stand_id")); //模块ID
			testExamplePO.setTest_version_id(inDto.getInteger("test_version_id")); //测试版本号
			testExamplePO.setFrom_standard_id(testPO.getStandard_id()); //测试用例来源
			testExamplePO.setFrom_templete_proj_id(testPO.getProj_id()); //项目来源
			testExamplePO.setFrom_test_version_id(testPO.getTest_version_id()); //测试版本号来源
			testExamplePO.setExecute_code(testPO.getExecute_code()); //执行序号
			testExamplePO.setData_sql(testPO.getData_sql()); //测试数据sql
			testExamplePO.setPrecondition(testPO.getPrecondition()); //前置条件
			testExamplePO.setTest_premise(testPO.getTest_premise()); //测试前提
			testExamplePO.setPriority(testPO.getPriority()); //优先级
			testExamplePO.setDemand_id(inDto.getString("demand_id")); //需求ID——关联需求
			testExamplePO.setFunction_module(testPO.getFunction_module()); //功能模块
			testExamplePO.setStandard_detail(testPO.getStandard_detail()); //执行步骤
			testExamplePO.setExpected_results(testPO.getExpected_results()); //期望结果
			testExamplePO.setTest_environment(testPO.getTest_environment()); //测试环境
			testExamplePO.setStandard_name(testPO.getStandard_name());
			Dto dto = Dtos.newDto();
			dto.put("DM_CODE", inDto.getString("stand_id"));
			String standard_code = (String) sqlDao.selectOne("TestExampleDao.queryStandardCode", dto);
			testExamplePO.setStandard_code(standard_code);
			testExampleDao.insert(testExamplePO);
		}
		httpModel.setOutMsg("导入成功");
	}
	
	/**
	 * 导出模板下拉框
	 * @param httpModel
	 */
	public void exportTestVersionId(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("TestExampleDao.ListexportTestVersionId", inDto);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
	
	/**
	 * 导出Excel
	 * 
	 * @param httpModel
	 */
	public void exportExcel3(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String[] standardCodes = inDto.getString("standardCodes").split(",");
		String[] standard_ids = inDto.getString("standardIds").split(",");
		List paramsList = new ArrayList();//导出的头数据集
		List<List> faPOList = new ArrayList<List>();//导出的身体数据集
		String proj_name = "";
		for(int i=0;i<standardCodes.length;i++){
			boolean flag = true;
			for(int j=0;j<i;j++){//用i当前编码去判断是否和i之前的编码J相等
				if(standardCodes[i].equals(standardCodes[j])){//相等返回false
					flag = false;
				}
			}
			if(flag){
				Dto dto = Dtos.newDto();
				dto.put("standard_code", standardCodes[i]);
				dto.put("standard_id", standard_ids);
				List<Dto> faPOs = (List<Dto>) sqlDao.list("TestExampleDao.testExampleArrayList_3", dto);
				Dto paramsDto=Dtos.newDto();
				paramsDto.put("reportTitle","测试用例");
				paramsDto.put("dcr", httpModel.getUserModel().getName());
				paramsDto.put("dcsj", AOSUtils.getDateStr());
				int sum_pass = 0;//通过数量
				int sum_fail = 0;//失败数量
				int sum_undetermined = 0;//待定数量
				int amount = faPOs.size();
				for(int k=0;k<amount;k++){
				    Dto faPO = faPOs.get(k);
			    	if(Integer.valueOf(faPO.get("pass_or_fail").toString())==1){
						sum_pass++;//通过数量加1
						faPO.put("pass_or_fail", "执行通过");//1表示通过改为执行通过导出显示
					}else if(Integer.valueOf(faPO.get("pass_or_fail").toString())==0){
						sum_fail++;//失败数量加1
						faPO.put("pass_or_fail", "执行未通过");//0表示失败改为执行未通过导出显示
					}else{
				    	sum_undetermined++;//待定数加1
				    	faPO.put("pass_or_fail", "未执行");//-1表示未执行L导出显示
					}
			    	if(AOSUtils.isNotEmpty(faPO.getDate("pass_time"))){
				    	if(faPO.getDate("pass_time").equals(new Date("1999/01/01"))){
				    		faPO.put("pass_time", "");
				    	}
			    	}
					/*if(!AOSUtils.isEmpty(faPO.get("return_state"))){
						if(Integer.valueOf(faPO.get("return_state").toString())==1){
							faPO.put("return_state", "Y");//1表示是 改为Y导出显示
						}else if(Integer.valueOf(faPO.get("return_state").toString())==0){
							faPO.put("return_state", "N");//0表示是 改为N导出显示
						}
					}*/
				}
				paramsDto.put("statistics","总计TESTS:"+amount+" 已通过数："+sum_pass+
						" 已失败数："+sum_fail+
						" 待定数："+sum_undetermined);
				String dm_name = faPOs.get(0).getString("dm_name");
				if(AOSUtils.isEmpty(dm_name)){
					dm_name = faPOs.get(0).getString("standard_code");
				}
				paramsDto.put("tab_name",dm_name);//设置当前tab页的名称：模块名称
				paramsDto.put("dm_name",dm_name);
				paramsDto.put("standard_code",faPOs.get(0).get("standard_code"));
				paramsDto.put("create_name",faPOs.get(0).get("create_name"));
				paramsDto.put("create_id",faPOs.get(0).get("create_id"));
				paramsDto.put("demand_site",faPOs.get(0).get("demand_site"));
				paramsDto.put("data_sql",faPOs.get(0).get("data_sql"));
				paramsDto.put("test_environment",faPOs.get(0).get("test_environment"));
				paramsDto.put("precondition",faPOs.get(0).get("precondition"));
				paramsDto.put("priority", faPOs.get(0).get("priority"));
				paramsDto.put("function_module", faPOs.get(0).get("function_module"));
				paramsDto.put("test_premise", faPOs.get(0).get("test_premise"));
				paramsList.add(paramsDto);
				proj_name = faPOs.get(0).getString("proj_name");//提取项目名
				faPOList.add(faPOs);
			}
		}
		ExcelExporter exporter=new ExcelExporter();
		exporter.setData(paramsList, faPOList);
		exporter.setTemplatePath("/export/excel/testExampleReport.xls");
		exporter.setFilename(proj_name+"测试用例.xls");
		try {
			exporter.export_tab(httpModel.getRequest(), httpModel.getResponse());
		} catch (IOException e) {
			throw new AOSException("导出失败："+e.getMessage());
		}
	}
	
	/**
	 * 导出Excel
	 * 
	 * @param httpModel
	 */
	public void exportExcel(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String[] standardCodes = inDto.getString("standardCodes").split(",");
		String[] standard_ids = inDto.getString("standardIds").split(",");
		List paramsList = new ArrayList();//导出的头数据集
		List<List> faPOList = new ArrayList<List>();//导出的身体数据集
		String proj_name = "";
		for(int i=0;i<standardCodes.length;i++){
			boolean flag = true;
			for(int j=0;j<i;j++){//用i当前编码去判断是否和i之前的编码J相等
				if(standardCodes[i].equals(standardCodes[j])){//相等返回false
					flag = false;
				}
			}
			if(flag){
				Dto dto = Dtos.newDto();
				dto.put("standard_code", standardCodes[i]);
				dto.put("standard_id", standard_ids);
				List<Dto> faPOs = (List<Dto>) sqlDao.list("TestExampleDao.testExampleArrayList", dto);
				Dto paramsDto=Dtos.newDto();
				paramsDto.put("reportTitle","测试用例");
				paramsDto.put("dcr", httpModel.getUserModel().getName());
				paramsDto.put("dcsj", AOSUtils.getDateStr());
				String dm_name = faPOs.get(0).getString("dm_name");
				if(AOSUtils.isEmpty(dm_name)){
					dm_name = faPOs.get(0).getString("standard_code");
				}
				paramsDto.put("tab_name",dm_name);//设置当前tab页的名称：模块名称
				paramsDto.put("dm_name",dm_name);
				paramsDto.put("demand_site",faPOs.get(0).get("demand_site"));
				for(int k=0;k<faPOs.size();k++){
					Dto faPO = faPOs.get(k);
					if(Integer.valueOf(faPO.get("pass_or_fail").toString()) == 0){
						faPO.put("pass_or_fail", "FAIL");
					}else if(Integer.valueOf(faPO.get("pass_or_fail").toString()) == 1){
						faPO.put("pass_or_fail", "PASS");
					}else if(Integer.valueOf(faPO.get("pass_or_fail").toString()) == 2){
						faPO.put("pass_or_fail", "BLOCK");
					}else if(Integer.valueOf(faPO.get("pass_or_fail").toString()) == 3){
						faPO.put("pass_or_fail", "N/A");
					}	
				}
				paramsList.add(paramsDto);
				proj_name = faPOs.get(0).getString("proj_name");//提取项目名
				faPOList.add(faPOs);
			}
		}
		ExcelExporter exporter=new ExcelExporter();
		exporter.setData(paramsList, faPOList);
		//exporter.setTemplatePath("/export/excel/testExampleReport.xls");
		exporter.setTemplatePath("/export/excel/testExampleReport.xls");
		exporter.setFilename(proj_name+"测试用例.xls");
		try {
			exporter.export_tab(httpModel.getRequest(), httpModel.getResponse());
		} catch (IOException e) {
			throw new AOSException("导出失败："+e.getMessage());
		}
	}
	
	/**
	 * 全部导出
	 * @param httpModel
	 */
	public void allExportExcel(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		List<TestExamplePO> TestExamplePOs = testExampleDao.testSearch(inDto);
		String[] standardCodes = new String[TestExamplePOs.size()];
		String[] standard_ids = new String[TestExamplePOs.size()];
		int b = -1;
		for(TestExamplePO POs : TestExamplePOs){
			b++;
			standardCodes[b] = POs.getStandard_code();
			standard_ids[b] = POs.getStandard_id().toString();
		}
		List paramsList = new ArrayList();//导出的头数据集
		List<List> faPOList = new ArrayList<List>();//导出的身体数据集
		String proj_name = "";
		for(int i=0;i<standardCodes.length;i++){
			boolean flag = true;
			for(int j=0;j<i;j++){//用i当前编码去判断是否和i之前的编码J相等
				if(standardCodes[i].equals(standardCodes[j])){//相等返回false
					flag = false;
				}
			}
			if(flag){
				Dto dto = Dtos.newDto();
				dto.put("standard_code", standardCodes[i]);
				dto.put("standard_id", standard_ids);
				List<Dto> faPOs = (List<Dto>) sqlDao.list("TestExampleDao.testExampleArrayList", dto);
				Dto paramsDto=Dtos.newDto();
				paramsDto.put("reportTitle","测试用例");
				paramsDto.put("dcr", httpModel.getUserModel().getName());
				paramsDto.put("dcsj", AOSUtils.getDateStr());
				String dm_name = faPOs.get(0).getString("dm_name");
				if(AOSUtils.isEmpty(dm_name)){
					dm_name = faPOs.get(0).getString("standard_code");
				}
				paramsDto.put("tab_name",dm_name);//设置当前tab页的名称：模块名称
				paramsDto.put("dm_name",dm_name);
				paramsDto.put("demand_site",faPOs.get(0).get("demand_site"));
				for(int k=0;k<faPOs.size();k++){
					Dto faPO = faPOs.get(k);
					if(Integer.valueOf(faPO.get("pass_or_fail").toString()) == 0){
						faPO.put("pass_or_fail", "FAIL");
					}else if(Integer.valueOf(faPO.get("pass_or_fail").toString()) == 1){
						faPO.put("pass_or_fail", "PASS");
					}else if(Integer.valueOf(faPO.get("pass_or_fail").toString()) == 2){
						faPO.put("pass_or_fail", "BLOCK");
					}else if(Integer.valueOf(faPO.get("pass_or_fail").toString()) == 3){
						faPO.put("pass_or_fail", "N/A");
					}	
				}
				paramsList.add(paramsDto);
				proj_name = faPOs.get(0).getString("proj_name");//提取项目名
				faPOList.add(faPOs);
			}
		}
		ExcelExporter exporter=new ExcelExporter();
		exporter.setData(paramsList, faPOList);
		//exporter.setTemplatePath("/export/excel/testExampleReport.xls");
		exporter.setTemplatePath("/export/excel/testExampleReport.xls");
		exporter.setFilename(proj_name+"测试用例.xls");
		try {
			exporter.export_tab(httpModel.getRequest(), httpModel.getResponse());
		} catch (IOException e) {
			throw new AOSException("导出失败："+e.getMessage());
		}
	}
	
	/**
	 * 导出Excel
	 * 
	 * @param httpModel
	 */
	public void exportExcel2(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String[] standard_id = inDto.getString("standardIds").split(",");
		Dto dto = Dtos.newDto();
		dto.put("standard_id", standard_id);
		List<Dto> faPOs = (List<Dto>) sqlDao.list("TestExampleDao.testExampleArrayList", dto);
		ExcelExporter exporter=new ExcelExporter();
		Dto paramsDto=Dtos.newDto();
		paramsDto.put("reportTitle","测试用例");
		int sum_pass = 0;//通过数量
		int sum_fail = 0;//失败数量
		int sum_undetermined = 0;//待定数量
		int amount = faPOs.size();
		for(int i=0;i<amount;i++){
		    Dto faPO = faPOs.get(i);
		    if(!AOSUtils.isEmpty(faPO.get("pass_or_fail"))){
		    	if(Integer.valueOf(faPO.get("pass_or_fail").toString())==1){
					sum_pass++;//通过数量加1
					faPO.put("pass_or_fail", "执行通过");//1表示通过改为执行通过导出显示
				}else if(Integer.valueOf(faPO.get("pass_or_fail").toString())==0){
					sum_fail++;//失败数量加1
					faPO.put("pass_or_fail", "执行未通过");//0表示失败改为执行未通过导出显示
				}
		    }else{
		    	sum_undetermined++;//待定数加1
		    	faPO.put("pass_or_fail", "未执行");//-1表示失败改为未执行导出显示
		    }
		}
		paramsDto.put("sum_pass",sum_pass);
		paramsDto.put("sum_fail",sum_fail);
		paramsDto.put("sum_undetermined",sum_undetermined);
		paramsDto.put("dm_name",faPOs.get(0).get("dm_name"));
		paramsDto.put("standard_code",faPOs.get(0).get("standard_code"));
		paramsDto.put("create_name",faPOs.get(0).get("create_name"));
		paramsDto.put("demand_site",faPOs.get(0).get("demand_site"));
		paramsDto.put("data_sql",faPOs.get(0).get("data_sql"));
		paramsDto.put("test_browser",faPOs.get(0).get("test_browser"));
		paramsDto.put("test_resolution",faPOs.get(0).get("test_resolution"));
		paramsDto.put("precondition",faPOs.get(0).get("precondition"));
		paramsDto.put("tab_name",faPOs.get(0).get("dm_name"));
		exporter.setData(paramsDto, faPOs);
		exporter.setTemplatePath("/export/excel/testExampleReport2.xls");
		exporter.setFilename(faPOs.get(0).get("standard_code")+"测试用例.xls");
		try {
			exporter.export(httpModel.getRequest(), httpModel.getResponse());
		} catch (IOException e) {
			throw new AOSException("导出失败："+e.getMessage());
		}
		
	}
	/**
	 * 根据ID查询
	 * 
	 * @param httpModel
	 * @return
	 */
	public void get(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		TestExamplePO testExamplePO=testExampleDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(testExamplePO));
	}
	
	/**
	 * 分页查询导出的模板测试用例
	 * 
	 * @param httpModel
	 * @return TestExamplePO
	 */
	public void getExportModule(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		List<Dto> testExampleDtos = sqlDao.list("TestExampleDao.likeExportShow",inDto);
		httpModel.setOutMsg(AOSJson.toJson(testExampleDtos));
	}
	
	/**
	 * 分页查询被导入的模板测试用例
	 * 
	 * @param httpModel
	 * @return TestExamplePO
	 */
	public void getImportModule(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		List<Dto> testExampleDtos = sqlDao.list("TestExampleDao.likeImportShow",inDto);
		httpModel.setOutMsg(AOSJson.toJson(testExampleDtos));
	}
	
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> testExampleDtos = sqlDao.list("TestExampleDao.likePage",inDto);
		for (int i = 0; i < testExampleDtos.size(); i++) {
			String standard_detail = (String) testExampleDtos.get(i).get("standard_detail");
			String expected_results = (String) testExampleDtos.get(i).get("expected_results");
			if(AOSUtils.isNotEmpty(standard_detail)){
				standard_detail = standard_detail.replaceAll("\n", "<br>");
			}
			if(AOSUtils.isNotEmpty(expected_results)){
				expected_results = expected_results.replaceAll("\n", "<br>");
			}
			String actual_results = (String) testExampleDtos.get(i).get("actual_results");
			if(!AOSUtils.isEmpty(actual_results)){
				actual_results = actual_results.replaceAll("\n", "<br>");
				testExampleDtos.get(i).put("actual_results", actual_results);
			}
			testExampleDtos.get(i).put("standard_detail", standard_detail);
			testExampleDtos.get(i).put("expected_results", expected_results);
		}
		httpModel.setOutMsg(AOSJson.toGridJson(testExampleDtos, inDto.getPageTotal()));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void logPage(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> testExampleDtos = sqlDao.list("TestExampleDao.logPage",inDto);
		for (int i = 0; i < testExampleDtos.size(); i++) {
			String actual_results = (String) testExampleDtos.get(i).get("actual_results");
			if(!AOSUtils.isEmpty(actual_results)){
				actual_results = actual_results.replaceAll("\n", "<br>");
				testExampleDtos.get(i).put("actual_results", actual_results);
			}
		}
		httpModel.setOutMsg(AOSJson.toGridJson(testExampleDtos, inDto.getPageTotal()));
	}
	
	/**
	 * 导入
	 * 
	 * @param httpModel
	 */
	public void importFile(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		
		try{//使用Apache文件上传组件处理文件上传步骤：
			//1、创建一个DiskFileItemFactory工厂
		//	DiskFileItemFactory factory = new DiskFileItemFactory();
			//2、创建一个文件上传解析器
		//	ServletFileUpload upload = new ServletFileUpload(factory); 
			//解决上传文件名的中文乱码
		//	upload.setHeaderEncoding("UTF-8"); 
			//3、判断提交上来的数据是否是上传表单的数据
			boolean isMultipart = ServletFileUpload.isMultipartContent(httpModel.getRequest());
			if(!isMultipart){
				//按照传统方式获取数据
				return;
			}
			//4、使用ServletFileUpload解析器解析上传数据，解析结果返回的是一个List<FileItem>集合，每一个FileItem对应一个Form表单的输入项
		//	List<FileItem> list = upload.parseRequest(httpModel.getRequest());
			try{
				MultipartHttpServletRequest multipartRequest = null;
				if(httpModel.getRequest() instanceof MultipartHttpServletRequest){
					try{
						multipartRequest=(MultipartHttpServletRequest) httpModel.getRequest();
					}catch(Exception ex){
						ex.getMessage();
					}
				}
				if(multipartRequest!=null){
					Map<String,MultipartFile> fileMap =multipartRequest.getFileMap();
					for(Map.Entry<String,MultipartFile> entity:fileMap.entrySet()){
						//得到上传的文件
						MultipartFile myfile=entity.getValue();
						//创建字段名
						String metaData = "standard_code,execute_code,priority,function_module,standard_name,test_premise,standard_detail,expected_results";
						HSSFWorkbook workbook = new HSSFWorkbook(myfile.getInputStream());
						//读取当前excel的sheet数量
						int number = workbook.getNumberOfSheets();
						int i = 0;
						while (i<number) {
							ExcelReader excelReader = new ExcelReader(metaData,myfile.getInputStream());
							List<Dto> exclelist = excelReader.read(1,0,i);
							Date date = new Date();
							SimpleDateFormat sdf =  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
							//查询模块id
							inDto.put("test_code",exclelist.get(0).get("standard_code"));
							//String stand_id = (String)sqlDao.selectOne("TestExampleDao.queryTestCode", inDto);
							//String stand_id = testExampleDao.queryTestCode(inDto.getString("proj_id"), inDto.getString("test_code"));
							//获取当前模块测试用例最大序号
							int execute_code = (int) sqlDao.selectOne("TestExampleDao.queryExecuteCode", inDto);
							for(int a = 0;a< exclelist.size(); a++){
								Dto pdto=exclelist.get(a);
								if(AOSUtils.isEmpty(pdto.getInteger("execute_code"))){
									continue;
								}
								pdto.put("standard_code", pdto.get("standard_code"));
								pdto.put("execute_code", execute_code+1+a);
								pdto.put("priority", pdto.get("priority"));
								pdto.put("function_module", pdto.get("function_module"));
								pdto.put("standard_name", pdto.get("standard_name"));
								pdto.put("test_premise", pdto.get("test_premise"));
								pdto.put("standard_detail", pdto.get("standard_detail"));
								pdto.put("expected_results", pdto.get("expected_results"));
								pdto.put("create_name", httpModel.getUserModel().getName());
								pdto.put("create_id", httpModel.getUserModel().getId());
								pdto.put("create_time", sdf.format(date));
								pdto.put("proj_id", inDto.get("proj_id"));
								pdto.put("stand_id", inDto.get("stand_id"));
								pdto.put("demand_id", inDto.getString("demand_id"));
								pdto.put("test_version_id", inDto.getInteger("test_version_id"));
								TestExamplePO testExamplePO=new TestExamplePO();
								testExamplePO.copyProperties(pdto);
								testExampleDao.insert(testExamplePO);
							}
							i++;
						}
					}
				}
			}catch(Exception e){
				e.printStackTrace();
			}
		}catch (Exception e) {
			//message= "导入失败！";
			e.printStackTrace();
		}
		String message="{success:true,msg:'导入成功！'}";
		httpModel.setOutMsg(message);
	}
	
	/**
	 * 关联需求查询
	 * 
	 * @param httpModel
	 */
	public void demandSite(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> testExampleDtos = sqlDao.list("TestExampleDao.listDemandSite",inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(testExampleDtos));
	}

	/**
	 * 用例编码下拉框
	 * @param httpModel
	 * @return
	 */
	public void standardCode(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> list = null;
		if(inDto.getInteger("flag") != null && inDto.getInteger("flag") == 1){
			list = sqlDao.list("TestExampleDao.standardCodeTwo", inDto);
		}else{
			list = sqlDao.list("TestExampleDao.standardCodeOne", inDto);
		}
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
	
	/**
	 * 测试用例下拉框（供外部调用）
	 * @param httpModel
	 * @return
	 */
	public void listdemand(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("TestExampleDao.listdemand", inDto);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}

	/**
	 * 测试用例表（供缺陷调用）
	 * @param httpModel
	 * @return
	 */
	public void listdemandgrid(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("TestExampleDao.listdemandgrid", inDto);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
	/**
	 * 测试用例表（供缺陷详情调用）
	 * @param httpModel
	 * @return
	 */
	public void listbugnewdemandgrid(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("TestExampleDao.listbugnewdemandgrid", inDto);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
	/**
	 * 查询自定义下拉组件数据
	 * 
	 * @param httpModel
	 * @return
	 */
	public void listModuleDivideComboBox(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("TestExampleDao.listModuleDivideComboBox", inDto);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
	
	
	/**
	 * 查询自定义下拉组件数据
	 * 
	 * @param httpModel
	 * @return
	 */
	public void listVersionComboBox(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("TestExampleDao.queryVersion", inDto);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
	
	/**
	 * 执行用例状态
	 * 
	 * @param httpModel
	 * @return
	 */
	public void executeUpdate(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String name = httpModel.getUserModel().getName();
		int id = httpModel.getUserModel().getId();
		inDto.put("update_name", name);
		inDto.put("update_id", id);
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		inDto.put("update_time", sdf.format(date));
		if(AOSUtils.isEmpty(inDto.getInteger("pass_or_fail")) || inDto.getInteger("pass_or_fail")==0){
			inDto.put("pass_time", "1999-01-01 00:00:00");
		}else if(inDto.getInteger("pass_or_fail") == 1){
			inDto.put("pass_time", sdf.format(date));
		}
		//执行次数加一
		int number = testExampleDao.selectByKey(inDto.getInteger("standard_id")).getExecute_number()+1;
		inDto.put("execute_number", number);
		inDto.put("tester_name", name);
		inDto.put("tester_id", id);
		inDto.put("test_time", sdf.format(date));
		TestExamplePO testExamplePO=new TestExamplePO();
		testExamplePO.copyProperties(inDto);
		testExampleDao.updateByKey(testExamplePO);
		testExampleDao.insertIntoLog(testExamplePO);
		httpModel.setOutMsg("执行成功");
	}
	
	/**
	 * 批量处理PASS
	 */
	public void changePass(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		String [] selectionIds = inDto.getRows();
		String name = httpModel.getUserModel().getName();
		int id = httpModel.getUserModel().getId();
		for(int i=0;i<selectionIds.length;i++){
			TestExamplePO testExamplePO = new TestExamplePO();
			inDto.put("standard_id",selectionIds[i]);
			inDto.put("pass_or_fail",1);
			inDto.put("update_id",id);
			inDto.put("update_name",name);
			inDto.put("update_time",new Date());
			inDto.put("tester_id",id);
			inDto.put("tester_name",name);
			inDto.put("test_time",new Date());
			int number = testExampleDao.selectByKey(Integer.valueOf(selectionIds[i])).getExecute_number()+1;
			inDto.put("execute_number",number);
			inDto.put("standard_id",selectionIds[i]);
			inDto.put("actual_results","");
			testExamplePO.copyProperties(inDto);
			testExampleDao.insertIntoLog(testExamplePO);
			testExampleDao.updateByKey(testExamplePO);
		}
		httpModel.setOutMsg("操作成功");
	}
	
	/**
	 * 批量处理N/A
	 * @param httpModel
	 */
	public void changeNA(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		String [] selectionIds = inDto.getRows();
		String name = httpModel.getUserModel().getName();
		int id = httpModel.getUserModel().getId();
		for(int i=0;i<selectionIds.length;i++){
			TestExamplePO testExamplePO = new TestExamplePO();
			inDto.put("standard_id",selectionIds[i]);
			inDto.put("pass_or_fail",3);
			inDto.put("update_id",id);
			inDto.put("update_name",name);
			inDto.put("update_time",new Date());
			inDto.put("tester_id",id);
			inDto.put("tester_name",name);
			inDto.put("test_time",new Date());
			int number = testExampleDao.selectByKey(Integer.valueOf(selectionIds[i])).getExecute_number()+1;
			inDto.put("execute_number",number);
			inDto.put("standard_id",selectionIds[i]);
			testExamplePO.copyProperties(inDto);
			testExampleDao.insertIntoLog(testExamplePO);
			testExampleDao.updateByKey(testExamplePO);
		}
		httpModel.setOutMsg("操作成功");
	}
	
	/**
	 * 批量处理BLOCK
	 * @param httpModel
	 */
	public void changeBLOCK(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		String [] selectionIds = inDto.getRows();
		String name = httpModel.getUserModel().getName();
		int id = httpModel.getUserModel().getId();
		for(int i=0;i<selectionIds.length;i++){
			TestExamplePO testExamplePO = new TestExamplePO();
			inDto.put("standard_id",selectionIds[i]);
			inDto.put("pass_or_fail",2);
			inDto.put("update_id",id);
			inDto.put("update_name",name);
			inDto.put("update_time",new Date());
			inDto.put("tester_id",id);
			inDto.put("tester_name",name);
			inDto.put("test_time",new Date());
			int number = testExampleDao.selectByKey(Integer.valueOf(selectionIds[i])).getExecute_number()+1;
			inDto.put("execute_number",number);
			inDto.put("standard_id",selectionIds[i]);
			testExamplePO.copyProperties(inDto);
			testExampleDao.insertIntoLog(testExamplePO);
			testExampleDao.updateByKey(testExamplePO);
		}
		httpModel.setOutMsg("操作成功");
	}
	
	public void copy(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		String[] Ids = inDto.getRows();
		String create_name = httpModel.getUserModel().getName();
		int create_id = httpModel.getUserModel().getId();
		for (int i=0;i<Ids.length;i++){
			inDto.put("standard_id", Ids[i]);
			inDto.put("create_name", create_name);
			inDto.put("create_id", create_id);
			testExampleDao.copyTestExample(inDto);
		}
		httpModel.setOutMsg("复制成功");
	}
	
	public void copy2(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		String create_name = httpModel.getUserModel().getName();
		int create_id = httpModel.getUserModel().getId();
		inDto.put("create_name", create_name);
		inDto.put("create_id", create_id);
		testExampleDao.copyTestExample(inDto);
		httpModel.setOutMsg("复制成功");
	}
	
 }
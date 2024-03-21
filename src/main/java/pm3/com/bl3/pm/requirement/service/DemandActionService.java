package com.bl3.pm.requirement.service;

import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.excel.xls.ExcelExporter;
import aos.framework.core.excel.xls.ExcelReader;
import aos.framework.core.excel.xlsx.ExcelExporterX;
import aos.framework.core.exception.AOSException;
import aos.framework.core.redis.JedisUtil;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.typewrap.Dtos;
import aos.framework.core.utils.AOSCons;
import aos.framework.core.utils.AOSJson;
import aos.framework.core.utils.AOSUtils;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;
import aos.system.common.utils.SystemCons;

import com.bl3.pm.requirement.dao.DemandActionDao;
import com.bl3.pm.requirement.dao.po.DemandActionFilePO;
import com.bl3.pm.requirement.dao.po.DemandActionPO;
import com.bl3.pm.task.dao.po.TaskImportTemplatePO;

/**
 * <b>re_demand_action[re_demand_action]业务逻辑层</b>
 * 
 * @author hege
 * @date 2017-12-19 11:08:28
 */
@Service
public class DemandActionService {
	private static Logger logger = LoggerFactory.getLogger(DemandActionService.class);
	@Autowired
	private DemandActionDao demandActionDao;
	@Autowired
	private SqlDao sqlDao;
	@Autowired
	private IdService idService;

	/**
	 * 初始化需求变更视图
	 * 
	 * @param httpModel
	 * @return
	 */
	public void initDaisy(HttpModel httpModel) {
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
		httpModel.setViewPath("pm3/requirement/demandDaisy/demandDaisy.jsp");
	}

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
		httpModel.setViewPath("pm3/requirement/demandAction/demandAction_layout.jsp");
	}

	/**
	 * 新增
	 * 
	 * @param httpModel
	 * @return
	 */
	public void create(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		Dto queryDto = Dtos.newDto();
		queryDto.put("demand_code", inDto.getString("demand_code"));
		queryDto.put("proj_id", inDto.getString("proj_id"));
//		Integer rows = demandActionDao.getDemandCodeRows(queryDto);
//		if(rows > 0){
//			Dto outDto = Dtos.newOutDto();
//			outDto.setAppCode("-1");
//			outDto.setAppMsg("新增失败,该项目的需求编码已存在！");
//			httpModel.setOutMsg(AOSJson.toJson(outDto));
//		}else{
//		}
		String code = null;
		if (inDto.getString("dm_code").length() > 7) {
			String sb = inDto.getString("dm_code");
			code = sb.substring(0, 8);
			System.out.println(code);
		} else {
			code = inDto.getString("dm_code");
		}
		DemandActionPO demandActionPO = new DemandActionPO();
		demandActionPO.copyProperties(inDto);
		demandActionPO.setAd_code(idService.nextValue("seq_re_demand_action").toString());
		demandActionPO.setCreate_user_id(httpModel.getUserModel().getId());
		Date create_time = AOSUtils.getDateTime();
		demandActionPO.setCreate_time(create_time);
		demandActionPO.setState("0");
		demandActionPO.setDm_first_code(code);
		demandActionDao.insert(demandActionPO);
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
		// inDto.remove("id");
//		Dto queryDto = Dtos.newDto();
//		queryDto.put("demand_code", inDto.getString("demand_code"));
//		queryDto.put("proj_id", inDto.getString("proj_id"));
//		queryDto.put("ad_id", inDto.getString("ad_id"));
//		Integer rows = demandActionDao.getDemandCodeRows(queryDto);
//		if(rows > 0){
//			Dto outDto = Dtos.newOutDto();
//			outDto.setAppCode("-1");
//			outDto.setAppMsg("修改失败,该项目的需求编码已存在！");
//			httpModel.setOutMsg(AOSJson.toJson(outDto));
//		}else{
			DemandActionPO demandActionPO = new DemandActionPO();
			demandActionPO.copyProperties(inDto);
			demandActionPO.setUpdate_user_id(httpModel.getUserModel().getId());
			Date update_time = AOSUtils.getDateTime();
			demandActionPO.setUpdate_time(update_time);
			demandActionDao.updateByKey(demandActionPO);
			httpModel.setOutMsg("修改成功");
//		}
	}

	/**
	 * 数据状态修改
	 * 
	 * @param httpModel
	 * @return
	 */
	public void delete(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String[] selectionIds = inDto.getRows();
		String state = inDto.getString("state");
		for (String id : selectionIds) {
			DemandActionPO demandActionPO = new DemandActionPO();
			demandActionPO.setUpdate_user_id(httpModel.getUserModel().getId());
			Date update_time = AOSUtils.getDateTime();
			demandActionPO.setUpdate_time(update_time);
			demandActionPO.setState(state);
			demandActionPO.setAd_id(Integer.valueOf(id));
			demandActionDao.updateByKey(demandActionPO);
		}
		if (state.equals(1)) {
			final String cacheKey = SystemCons.KEYS.CARDLIST + "Token";
			String token = JedisUtil.getString(cacheKey);
			httpModel.setOutMsg(token.toString());
			return;
		}

		httpModel.setOutMsg("操作成功");
	}
	
	/**
	 * 需求导入
	 * @param httpModel
	 */
	public void importFile(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		try {//使用Apache文件上传组件处理文件上传步骤：
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
			try {
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
						String metaData = "firstName,secondName,thirdName,fourthName,fifthName,ad_type,demand_code,ad_name,is_product_satisfied,ad_source,ad_raise_date,ad_claim_start_date,ad_claim_finish_date,ad_priority,ad_content,development_member,ad_difficulty,ad_workload";
						HSSFWorkbook workbook = new HSSFWorkbook(myfile.getInputStream());
						//读取当前excel的sheet数量
						int number = workbook.getNumberOfSheets();
						int i = 0;
						while (i<number) {
							ExcelReader excelReader = new ExcelReader(metaData,myfile.getInputStream());
							List<Dto> exclelist = excelReader.read(1,0,i);
							Date date = new Date();
							SimpleDateFormat sdf =  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
							SimpleDateFormat asd =  new SimpleDateFormat("yyyy-MM-dd");
							for(int b = 0;b < exclelist.size(); b++) {
								Dto pdto=exclelist.get(b);
								pdto.put("proj_id", inDto.get("proj_id"));
								//查询dm_code
								String firstDmCode = (String) sqlDao.selectOne("com.bl3.pm.requirement.dao.DemandActionDao.firstDmCode", pdto);
								if(firstDmCode != null) {
									pdto.put("firstDmCode", firstDmCode);
									String secondDmCode = (String) sqlDao.selectOne("com.bl3.pm.requirement.dao.DemandActionDao.secondDmCode", pdto);
									if(secondDmCode != null) {
										pdto.put("secondDmCode", secondDmCode);
										String thirdDmCode = (String) sqlDao.selectOne("com.bl3.pm.requirement.dao.DemandActionDao.thirdDmCode", pdto);
										if(thirdDmCode != null) {
											pdto.put("thirdDmCode", thirdDmCode);
											String fourthDmCode = (String) sqlDao.selectOne("com.bl3.pm.requirement.dao.DemandActionDao.fourthDmCode", pdto);
											if(fourthDmCode != null) {
												pdto.put("fourthDmCode", fourthDmCode);
												String fifthDmCode = (String) sqlDao.selectOne("com.bl3.pm.requirement.dao.DemandActionDao.fifthDmCode", pdto);
												if(fifthDmCode != null) {
													pdto.put("dm_code", fifthDmCode);
												} else {
													pdto.put("dm_code", fourthDmCode);
												}
											} else {
												pdto.put("dm_code", thirdDmCode);
											}
										} else {
											pdto.put("dm_code", secondDmCode);
										}
									} else {
										pdto.put("dm_code", firstDmCode);
									}
								} else {
									pdto.put("dm_code", inDto.get("proj_id"));
								}
								Integer result = (int) sqlDao.selectOne("com.bl3.pm.requirement.dao.DemandActionDao.result", pdto);
								if(result > 0) {
									return;
								}
							}
							for(int a = 0;a< exclelist.size(); a++){
								Dto pdto=exclelist.get(a);
								pdto.put("proj_id", inDto.get("proj_id"));
								//查询dm_code
								String firstDmCode = (String) sqlDao.selectOne("com.bl3.pm.requirement.dao.DemandActionDao.firstDmCode", pdto);
								if(firstDmCode != null) {
									pdto.put("firstDmCode", firstDmCode);
									String secondDmCode = (String) sqlDao.selectOne("com.bl3.pm.requirement.dao.DemandActionDao.secondDmCode", pdto);
									if(secondDmCode != null) {
										pdto.put("secondDmCode", secondDmCode);
										String thirdDmCode = (String) sqlDao.selectOne("com.bl3.pm.requirement.dao.DemandActionDao.thirdDmCode", pdto);
										if(thirdDmCode != null) {
											pdto.put("thirdDmCode", thirdDmCode);
											String fourthDmCode = (String) sqlDao.selectOne("com.bl3.pm.requirement.dao.DemandActionDao.fourthDmCode", pdto);
											if(fourthDmCode != null) {
												pdto.put("fourthDmCode", fourthDmCode);
												String fifthDmCode = (String) sqlDao.selectOne("com.bl3.pm.requirement.dao.DemandActionDao.fifthDmCode", pdto);
												if(fifthDmCode != null) {
													pdto.put("dm_code", fifthDmCode);
												} else {
													pdto.put("dm_code", fourthDmCode);
												}
											} else {
												pdto.put("dm_code", thirdDmCode);
											}
										} else {
											pdto.put("dm_code", secondDmCode);
										}
									} else {
										pdto.put("dm_code", firstDmCode);
									}
								} else {
									pdto.put("dm_code", inDto.get("proj_id"));
								}
								//需求类型转换
								if(pdto.get("ad_type").equals("原始需求")) {
									pdto.put("ad_type", "1");
								} else if(pdto.get("ad_type").equals("变更需求")) {
									pdto.put("ad_type", "2");
								} else if(pdto.get("ad_type").equals("客户初始需求")) {
									pdto.put("ad_type", "3");
								} else if(pdto.get("ad_type").equals("新增需求")) {
									pdto.put("ad_type", "4");
								}
								//产品是否满足
								if(pdto.get("is_product_satisfied").equals("否")) {
									pdto.put("is_product_satisfied", "0");
								} else if(pdto.get("is_product_satisfied").equals("是")) {
									pdto.put("is_product_satisfied", "1");
								}
								//需求来源
								if(pdto.get("ad_source").equals("客户")) {
									pdto.put("ad_source", "1");
								} else if(pdto.get("ad_source").equals("用户")) {
									pdto.put("ad_source", "2");
								} else if(pdto.get("ad_source").equals("产品经理")) {
									pdto.put("ad_source", "3");
								} else if(pdto.get("ad_source").equals("市场")) {
									pdto.put("ad_source", "4");
								} else if(pdto.get("ad_source").equals("客服")) {
									pdto.put("ad_source", "5");
								} else if(pdto.get("ad_source").equals("运营")) {
									pdto.put("ad_source", "6");
								} else if(pdto.get("ad_source").equals("技术支持")) {
									pdto.put("ad_source", "7");
								} else if(pdto.get("ad_source").equals("竞争对手")) {
									pdto.put("ad_source", "8");
								} else if(pdto.get("ad_source").equals("合作伙伴")) {
									pdto.put("ad_source", "9");
								} else if(pdto.get("ad_source").equals("开发人员")) {
									pdto.put("ad_source", "10");
								} else if(pdto.get("ad_source").equals("测试人员")) {
									pdto.put("ad_source", "11");
								} else if(pdto.get("ad_source").equals("Bug")) {
									pdto.put("ad_source", "12");
								} else if(pdto.get("ad_source").equals("其他")) {
									pdto.put("ad_source", "13");
								}
								//优先级
								if(pdto.get("ad_priority").equals("特急")) {
									pdto.put("ad_priority", "1");
								} else if(pdto.get("ad_priority").equals("急")) {
									pdto.put("ad_priority", "2");
								} else if(pdto.get("ad_priority").equals("普通")) {
									pdto.put("ad_priority", "3");
								} else if(pdto.get("ad_priority").equals("不急")) {
									pdto.put("ad_priority", "4");
								}
								//难易程度
								if(pdto.get("ad_difficulty").equals("容易")) {
									pdto.put("ad_difficulty", "1");
								} else if(pdto.get("ad_difficulty").equals("有点难")) {
									pdto.put("ad_difficulty", "2");
								} else if(pdto.get("ad_difficulty").equals("难")) {
									pdto.put("ad_difficulty", "3");
								} else if(pdto.get("ad_difficulty").equals("困难")) {
									pdto.put("ad_difficulty", "4");
								}else if(pdto.get("ad_difficulty").equals("艰难")) {
									pdto.put("ad_difficulty", "5");
								}
								pdto.put("ad_code",idService.nextValue("seq_re_demand_action").toString());
								pdto.put("demand_code", pdto.get("demand_code"));
								pdto.put("ad_name", pdto.get("ad_name"));
								pdto.put("ad_raise_date", sdf.parse(pdto.get("ad_raise_date").toString()));
								pdto.put("ad_claim_start_date", asd.parse(pdto.get("ad_claim_start_date").toString()));
								pdto.put("ad_claim_finish_date", asd.parse(pdto.get("ad_claim_finish_date").toString()));
								pdto.put("ad_plan_finish_date", pdto.get("ad_claim_finish_date"));
								pdto.put("ad_content", pdto.get("ad_content"));
								pdto.put("development_member", pdto.get("development_member"));
								pdto.put("ad_workload", pdto.get("ad_workload"));
								pdto.put("proj_id", inDto.get("proj_id"));
								pdto.put("state", "0");
								pdto.put("create_user_id", httpModel.getUserModel().getId());
								pdto.put("create_time", new Date());
								DemandActionPO demandActionPO = new DemandActionPO();
								demandActionPO.copyProperties(pdto);
								demandActionDao.insert(demandActionPO);
							}
							i++;
						}
					}
				}
			}catch(Exception e){
				e.printStackTrace();
			}
		} catch (Exception e) {
			//message= "导入失败！";
			e.printStackTrace();
		}
		String message="{success:true,msg:'导入成功！'}";
		httpModel.setOutMsg(message);
	}

	/**
	 * 根据ID查询
	 * 
	 * @param httpModel
	 * @return
	 */
	public void get(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		DemandActionPO demandActionPO = demandActionDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(demandActionPO));
	}

	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("com.bl3.pm.requirement.dao.DemandActionDao.listModulesPage", httpModel.getInDto());
		httpModel.setOutMsg(AOSJson.toGridJson(list, inDto.getPageTotal()));
	}

	/**
	 * 查询模块名称下拉框
	 * 
	 * @param httpModel
	 * @return
	 */
	public void listComboBoxModelData(HttpModel httpModel) {
		List<Dto> list = sqlDao.list("com.bl3.pm.requirement.dao.DemandActionDao.listComboBoxModelData",
				httpModel.getInDto());
		httpModel.setOutMsg(AOSJson.toJson(list));
	}

	/**
	 * 查询需求页面
	 * 
	 * @param httpModel
	 * @return
	 */
	public void listDemandData(HttpModel httpModel) {
		Dto qDto = httpModel.getInDto();
		List<Dto> moduleDtos = sqlDao.list("com.bl3.pm.requirement.dao.DemandActionDao.listDemandData", qDto);
		httpModel.setOutMsg(AOSJson.toGridJson(moduleDtos, moduleDtos.size()));

	}

	/**
	 * 查询需求,设计，编码，测试，其他主界面数据
	 * 
	 * @param httpModel
	 * @return
	 */
	public void listMutiModelDemandState(HttpModel httpModel) {
		Dto qDto = httpModel.getInDto();
		List<Dto> moduleDtos = sqlDao.list("com.bl3.pm.requirement.dao.DemandActionDao.listMutiModelDemandState", qDto);
		httpModel.setOutMsg(AOSJson.toGridJson(moduleDtos, moduleDtos.size()));
	}
	
	public void listModuleDivideComboBox(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("com.bl3.pm.requirement.dao.DemandActionDao.listModuleDivideComboBox", inDto);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}

	/**
	 * 查询需求,设计，编码，测试详细数据
	 * 
	 * @param httpModel
	 * @return
	 */
	public void listDetailDemandData(HttpModel httpModel) {
		Dto qDto = httpModel.getInDto();
		List<Dto> moduleDtos = sqlDao.list("com.bl3.pm.requirement.dao.DemandActionDao.listDetailDemandData", qDto);
		httpModel.setOutMsg(AOSJson.toGridJson(moduleDtos, moduleDtos.size()));
	}

	/**
	 * 查询自定义下拉组件数据 项目需求下拉框
	 * 
	 * @param httpModel
	 * @return
	 */
	public void listdemand(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("DemandDao.listdemand", inDto);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}

	/**
	 * 查询自定义下拉组件数据 项目需求下拉框
	 * 
	 * @param httpModel
	 * @return
	 */
	public void listtaskgroup(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("DemandDao.listtaskgroup", inDto);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}

	/**
	 * 导出Excel
	 * 
	 * @param httpModel
	 */
	public void exportDemandExcel(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String task_type = inDto.getString("task_type");
		if (AOSUtils.isEmpty(task_type)) {
			return;
		}
		List<Dto> taDtos = sqlDao.list("com.bl3.pm.requirement.dao.DemandActionDao.listDetailDemandData", inDto);
		ExcelExporterX exporter = new ExcelExporterX();
		Dto paramsDto = Dtos.newDto();
		paramsDto.put("dcr", httpModel.getUserModel().getName());
		paramsDto.put("dcsj", AOSUtils.getDateStr());
		paramsDto.put("reportTitle",
				taDtos.get(0).getString("proj_name") + taDtos.get(0).getString("task_type_name") + "跟踪详情");
		paramsDto.put("countTask", taDtos.size());
		exporter.setData(paramsDto, taDtos);
		exporter.setTemplatePath("/export/excel/demandDaisyReport.xlsx");
		exporter.setFilename(
				taDtos.get(0).getString("proj_name") + taDtos.get(0).getString("task_type_name") + "跟踪详情.xlsx");

		try {
			exporter.export(httpModel.getRequest(), httpModel.getResponse());
		} catch (IOException e) {
			throw new AOSException("导出失败：" + e.getMessage());
		}
	}
	
	/**
	 * 查询需求关联任务
	 * 
	 * @param httpModel
	 */
	public void findTask(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("com.bl3.pm.requirement.dao.DemandActionDao.listFindTask", httpModel.getInDto());
		httpModel.setOutMsg(AOSJson.toGridJson(list, inDto.getPageTotal()));
	}
	
	/**
	 * 查询需求关联任务
	 * 
	 * @param httpModel
	 */
	public void findBug(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("com.bl3.pm.requirement.dao.DemandActionDao.listFindBug",
				httpModel.getInDto());
		httpModel.setOutMsg(AOSJson.toGridJson(list, inDto.getPageTotal()));
	}

}
package com.bl3.pm.basic.service;

import java.io.IOException;
import java.text.NumberFormat;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.bl3.pm.basic.dao.ModuleDivideDao;
import com.bl3.pm.basic.dao.po.ModuleDividePO;
import com.google.common.collect.Lists;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.excel.xls.ExcelReader;
import aos.framework.core.excel.xlsx.ExcelExporterX;
import aos.framework.core.exception.AOSException;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.typewrap.Dtos;
import aos.framework.core.utils.AOSCons;
import aos.framework.core.utils.AOSJson;
import aos.framework.core.utils.AOSUtils;
import aos.framework.taglib.core.model.TreeNode;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;
import aos.system.common.utils.SystemCons;
import aos.system.common.utils.SystemUtils;
import aos.system.dao.po.AosModulePO;
import sun.net.www.content.audio.basic;

import com.bl3.pm.basic.dao.ModuleDivideDao;
import com.bl3.pm.basic.dao.po.ModuleDividePO;
import com.bl3.pm.quality.dao.po.TestExamplePO;
import com.bl3.pm.task.dao.po.TaskGroupPO;
import com.google.common.collect.Lists;

/**
 * <b>re_module_divide[系统模块管理]业务逻辑层</b>
 * 
 * @author hege
 * @date 2017-12-11 11:17:18
 */
@Service
public class ModuleDivideService {
	private static Logger logger = LoggerFactory.getLogger(ModuleDivideService.class);
	@Autowired
	private ModuleDivideDao moduleDivideDao;
	@Autowired
	private SqlDao sqlDao;
	@Autowired
	private IdService idService;
	@Autowired
	private  ProjCommonsService projcommonsservice;
	public static Integer DEFAULT_ROOT_ID=0;

	/**
	 * 初始化视图
	 * 
	 * @param httpModel
	 * @return
	 */
	public void init(HttpModel httpModel) {
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		ModuleDividePO aosModulePO = moduleDivideDao
				.selectOne(Dtos.newDto("dm_parent_code", SystemCons.ROOTNODE_PARENT_ID));
		httpModel.setAttribute("rootPO", aosModulePO);
		
		Dto inDto = httpModel.getInDto();
		int person_id = httpModel.getUserModel().getId();
		inDto.put("person_id", person_id);
		Dto getDto = sqlDao.selectDto("DailyReportDao.GetDefaultProject", inDto);
		String proj_id  = "";
		String proj_name = "";
		if(getDto.get("proj_id")!=null){
	    proj_id = getDto.get("proj_id").toString();
	    proj_name = getDto.get("proj_name").toString();
		}
		httpModel.setAttribute("proj_id", proj_id);
		httpModel.setAttribute("proj_name", proj_name);
		
		httpModel.setViewPath("pm3/basic/codes/moduleDivide.jsp");
	}
	
	
	/**
	 * 获取已启用的模块导航树
	 * 
	 * @param httpModel
	 * @return
	 */
	public void getOnTreeData(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		// 获得排序号
		inDto.setOrder("dm_sort_no");
		List<ModuleDividePO> aosModulePOs = moduleDivideDao.listOnState(inDto);
		List<Dto> modelDtos = Lists.newArrayList();
		for (ModuleDividePO aosModulePO : aosModulePOs) {
			modelDtos.add(aosModulePO.toDto());
		}
		String treeJson = ModuleDivideService.toTreeModalAsyncLoad(modelDtos);
		httpModel.setOutMsg(treeJson);
	}

	/**
	 * 获取模块导航树
	 * 
	 * @param httpModel
	 * @return
	 */
	public void getTreeData(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		if (inDto.getString("type").equals("all")) {
			inDto.put("team_user_id", "1");
		} else {
			String userid = httpModel.getUserModel().getId().toString();
			inDto.put("team_user_id", userid);
		}
		List<Dto> list = sqlDao.list("ProjCommonsDao.listComboBoxUerid", inDto);
		if(list.size()==0){
			return;
		}
		if(inDto.getString("dm_parent_code").isEmpty()){
			inDto.put("dm_parent_code", "-1");
		}
		if(inDto.getString("dm_parent_code").equals("1")&&inDto.getString("proj_id").isEmpty()){
			inDto.put("dm_parent_code", "-1");
			inDto.put("proj_id", "-1");
		}
		// 获得排序号
		inDto.setOrder("dm_sort_no");
		List<ModuleDividePO> aosModulePOs = moduleDivideDao.list(inDto);
		List<Dto> modelDtos = Lists.newArrayList();
		for (ModuleDividePO aosModulePO : aosModulePOs) {
			String dm_is_leaf = aosModulePO.getDm_is_leaf();
			//不是叶节点情况
			if(dm_is_leaf.equals("0")){
				Dto moduleDto = Dtos.newDto();
				String dm_code = aosModulePO.getDm_code();
				moduleDto.put("proj_id", inDto.get("proj_id"));
				moduleDto.put("dm_code", dm_code);
				String module_percent = moduleDivideDao.completeQuery(moduleDto);
				aosModulePO.setModule_percent(module_percent);
			}
			modelDtos.add(aosModulePO.toDto());
		}
		String treeJson = ModuleDivideService.toTreeModalAsyncLoad(modelDtos);
		httpModel.setOutMsg(treeJson);
	}
	
	

	/**
	 * 将后台树结构转换为前端树模型 (异步加载)
	 * 
	 * @return
	 */
	public static String toTreeModalAsyncLoad(List<Dto> treeModels) {
		List<TreeNode> treeNodes = Lists.newArrayList();
		for (Dto model : treeModels) {
			TreeNode treeNode = new TreeNode();
			treeNode.setId(model.getString("dm_code"));
			if(AOSUtils.isNotEmpty(model.getString("module_percent"))){
				treeNode.setText(model.getString("dm_name") + "<span style='color:green;font-weight:bold;'>("+model.getString("module_percent")+"%)</span>");
			}else{
				treeNode.setText(model.getString("dm_name") + "<span style='color:green;font-weight:bold;'>(0%)</span>");
			}
			String is_leaf_ = model.getString("dm_is_leaf");
			treeNode.setLeaf(AOSCons.YES.equals(is_leaf_) ? true : false);
			treeNodes.add(treeNode);
		}
		return AOSJson.toJson(treeNodes);
	}

	/**
	 * 查询项目名称下拉框
	 * 
	 * @param httpModel
	 * @return
	 */
	public void listComboBoxCascadeData(HttpModel httpModel) {
		List<Dto> list = sqlDao.list("com.bl3.pm.basic.dao.ModuleDivideDao.listComboBoxCascadeData",
				httpModel.getInDto());
		httpModel.setOutMsg(AOSJson.toJson(list));
	}

	/**
	 * 保存功能模块
	 * 
	 * @param httpModel
	 * @return
	 */
	@Transactional
	public void saveModule(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		ModuleDividePO moduleDividePo = new ModuleDividePO();
		int result = (int) sqlDao.selectOne("ModuleDiviDao.selectTestCode", inDto);
		if(result > 0){
			httpModel.setOutMsg("测试编码已存在！");
			return;
		}
		moduleDividePo.copyProperties(inDto);
		String max_code = (String) sqlDao.selectOne("com.bl3.pm.basic.dao.ModuleDivideDao.dmCode", inDto);
		String prefixCode = "";
		if(max_code == null) {
			// 当为第一级节点时
			if ("1".equals(moduleDividePo.getDm_parent_code())) {
	            prefixCode = autoPrefixCode(moduleDividePo.getProj_id().toString(), 5);
	        } else {
	        	prefixCode = moduleDividePo.getDm_parent_code();
	        }
			moduleDividePo.setDm_code( prefixCode + "001");
		} else {
			moduleDividePo.setDm_code((String) sqlDao.selectOne("com.bl3.pm.basic.dao.ModuleDivideDao.maxDmCode", inDto));
		}
		moduleDividePo.setDm_is_leaf(SystemCons.IS.YES);
		moduleDividePo.setCreate_user_id(httpModel.getUserModel().getId());
		Date create_time = AOSUtils.getDateTime();
		moduleDividePo.setCreate_time(create_time);
		moduleDivideDao.insert(moduleDividePo);
		ModuleDividePO updatePO = new ModuleDividePO();
		updatePO.setDm_code(moduleDividePo.getDm_parent_code());
		updatePO.setDm_is_leaf(SystemCons.IS.NO);
		moduleDivideDao.updateByKey(updatePO);
		httpModel.setOutMsg("功能模块新增成功。");
	}

	/**
	 * 修改功能模块状态
	 * 
	 * @param httpModel
	 * @return
	 */
	@Transactional
	public void updateModuleState(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String[] selectionIds = httpModel.getInDto().getRows();
		for (String id : selectionIds) {
			ModuleDividePO upPO = moduleDivideDao.selectByKey(String.valueOf(id));
			upPO.copyProperties(inDto);
			if (AOSUtils.isEmpty(upPO)) {
				continue;
			}
			List<ModuleDividePO> subDelList = moduleDivideDao.like(Dtos.newDto("dm_code", id));
			for (ModuleDividePO subDelPO : subDelList) {
//				if (upPO.getDm_code().length() > 7 && upPO.getState().equals("1")) {
//					List<ModuleDividePO> pList = moduleDivideDao.list(
//							(Dtos.newDto("dm_code", upPO.getDm_code().substring(0, upPO.getDm_code().length() - 3))));
//					String p_state = pList.get(0).getState();
//					if (p_state.equals("0")) {
//						httpModel.setOutMsg("先启用父模块,才能启用子模块！");
//						return;
//					}
//				}	
				String dmCodeNum = upPO.getDm_parent_code();
				if(!dmCodeNum.equals("1")) {
					String p_state = (String) sqlDao.selectOne("com.bl3.pm.basic.dao.ModuleDivideDao.aList", upPO);
					if (p_state.equals("0")) {
						httpModel.setOutMsg("先启用父模块,才能启用子模块！");
						return;
					}
				}
				subDelPO.setState(inDto.getString("state"));
				moduleDivideDao.updateByKey(subDelPO);
			}
			upPO.setUpdate_user_id(httpModel.getUserModel().getId());
			Date update_time = AOSUtils.getDateTime();
			upPO.setUpdate_time(update_time);
			upPO.setState(inDto.getString("state"));
			moduleDivideDao.updateByKey(upPO);
		}
		httpModel.setOutMsg("启用成功");
	}
	
	/**
	 * 复制新增
	 * 
	 * @param httpModel
	 */
	public void copyCreate(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		Date create_time = AOSUtils.getDateTime();
		String proj_id = inDto.getString("proj_id");   //来源
		String copy_proj_id = inDto.getString("copy_proj_id");   //当前
		String[] dm_code = httpModel.getInDto().getRows();
		int dm_parent_code_count = 0;
		for (String str : dm_code) {
			List<ModuleDividePO> moduleDividePOs = sqlDao.list("com.bl3.pm.basic.dao.ModuleDivideDao.selectAll", str);
			for(ModuleDividePO moduleDividePO : moduleDividePOs){
					String dm_codes = moduleDividePO.getDm_code();
					String dm_parent_code = moduleDividePO.getDm_parent_code();
					StringBuilder copy_dm_code = new StringBuilder(dm_codes);
					int length = copy_proj_id.length();
					int value = 2 + length;
					dm_codes = copy_dm_code.replace(2, value, copy_proj_id).toString();
					if(!dm_parent_code.equals("1")){
						if(Arrays.asList(dm_code).contains(dm_parent_code)){
							StringBuilder copy_dm_parent_code = new StringBuilder(dm_parent_code);
							dm_parent_code = copy_dm_parent_code.replace(2, value, copy_proj_id).toString();
							moduleDividePO.setDm_parent_code(dm_parent_code);
						}else{
							//httpModel.setOutMsg("所选"+ moduleDividePO.getDm_name() +"模块存在异常！");
							int dm_parent_code_counts = moduleDivideDao.dmParentCodeCounts(moduleDividePO.getDm_code());
							dm_parent_code_count = dm_parent_code_count + dm_parent_code_counts;
							continue;
						}
					}
					moduleDividePO.setDm_code(dm_codes);
					moduleDividePO.setProj_id(Integer.valueOf(copy_proj_id));  
					moduleDividePO.setCreate_user_id(httpModel.getUserModel().getId());
					moduleDividePO.setCreate_time(create_time);
					moduleDivideDao.insert(moduleDividePO);
			}
		}
		httpModel.setOutMsg("功能模块新增成功,共有"+ dm_parent_code_count + "条数据异常！");
		}
		
		/*Date create_time = AOSUtils.getDateTime();
		String proj_id = inDto.getString("proj_id");   //来源
		String copy_proj_id = inDto.getString("copy_proj_id");   //当前
		List<ModuleDividePO> moduleDividePOs = sqlDao.list("com.bl3.pm.basic.dao.ModuleDivideDao.select_all", inDto);
		for(ModuleDividePO moduleDividePO : moduleDividePOs){
			String dm_code = moduleDividePO.getDm_code();
			String dm_parent_code = moduleDividePO.getDm_parent_code();
			StringBuilder copy_dm_code = new StringBuilder(dm_code);
			dm_code = copy_dm_code.replace(2, 4, copy_proj_id).toString();
			if(!dm_parent_code.equals("1")){
				StringBuilder copy_dm_parent_code = new StringBuilder(dm_parent_code);
				dm_parent_code = copy_dm_parent_code.replace(2, 4, copy_proj_id).toString();
				moduleDividePO.setDm_parent_code(dm_parent_code);
			}
			moduleDividePO.setDm_code(dm_code);
			moduleDividePO.setProj_id(Integer.valueOf(copy_proj_id));  
			moduleDividePO.setCreate_user_id(httpModel.getUserModel().getId());
			moduleDividePO.setCreate_time(create_time);
			moduleDivideDao.insert(moduleDividePO);
		}
		httpModel.setOutMsg("功能模块新增成功。");*/
	
	//导入
	public void importFile(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		Integer user_id = httpModel.getUserModel().getId();
		try{
			boolean isMultipart = ServletFileUpload.isMultipartContent(httpModel.getRequest());
			if(!isMultipart){
				return;
			}
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
						String metaData = "firstName,secondName,thirdName,fourthName,test_code";
						HSSFWorkbook workbook = new HSSFWorkbook(myfile.getInputStream());
						//XSSFWorkbook workbook = new XSSFWorkbook(myfile.getInputStream());
						//读取当前excel的sheet数量
						int number = workbook.getNumberOfSheets();
						int i = 0;
						while (i<number) {
							ExcelReader excelReader = new ExcelReader(metaData,myfile.getInputStream());
							List<Dto> exclelist = excelReader.read(1,0,i);
							List<Dto> oneModuleDivide = new ArrayList<Dto>();
							List<Dto> twoModuleDivide = new ArrayList<Dto>();
							List<Dto> threeModuleDivide = new ArrayList<Dto>();
							List<Dto> fourModuleDivide = new ArrayList<Dto>();
							//对所有数据进行分类
							for(Dto dto : exclelist){
								if(AOSUtils.isEmpty(dto.getString("secondName"))&&AOSUtils.isEmpty(dto.getString("thirdName")) && AOSUtils.isEmpty(dto.getString("fourthName"))){
									oneModuleDivide.add(dto);
								}else if(AOSUtils.isNotEmpty(dto.getString("secondName")) && AOSUtils.isEmpty(dto.getString("thirdName")) && AOSUtils.isEmpty(dto.getString("fourthName"))){
									twoModuleDivide.add(dto);
								}else if(AOSUtils.isNotEmpty(dto.getString("secondName")) && AOSUtils.isNotEmpty(dto.getString("thirdName")) && AOSUtils.isEmpty(dto.getString("fourthName"))){
									threeModuleDivide.add(dto);
								}else{
									fourModuleDivide.add(dto);
								}
							}
							//对一级进行新增
							for(Dto dto : oneModuleDivide){
								ModuleDividePO moduleDividePo = new ModuleDividePO();
								int result = (int) sqlDao.selectOne("ModuleDiviDao.selectTestCode", inDto);
								if(result > 0){
									httpModel.setOutMsg("测试编码已存在！");
									return;
								}
								moduleDividePo.copyProperties(inDto);
								inDto.put("dm_parent_code", "1");
								String max_code = (String) sqlDao.selectOne("com.bl3.pm.basic.dao.ModuleDivideDao.getNextCode", inDto);
								moduleDividePo.setDm_code(max_code);
								moduleDividePo.setState("0");
								moduleDividePo.setDm_parent_code("1");
								moduleDividePo.setDm_name(dto.getString("firstName"));
								moduleDividePo.setTest_code(dto.getString("test_code"));
								moduleDividePo.setDm_is_leaf(SystemCons.IS.YES);
								moduleDividePo.setCreate_user_id(httpModel.getUserModel().getId());
								Date create_time = AOSUtils.getDateTime();
								moduleDividePo.setCreate_time(create_time);
								moduleDivideDao.insert(moduleDividePo);
								
							}
							//对二级进行新增
							for(Dto dto : twoModuleDivide){
								ModuleDividePO moduleDividePO = new ModuleDividePO();
								int result = (int) sqlDao.selectOne("ModuleDiviDao.selectTestCode", inDto);
								if(result > 0){
									httpModel.setOutMsg("测试编码已存在！");
									return;
								}
								Dto queryDto=Dtos.newDto();
								String parent_id = moduleDivideDao.selectFirst_id(dto.getString("firstName"),inDto.getString("proj_id"));
								
								ModuleDividePO parentModulePO = moduleDivideDao.selectByFirstName(dto.getString("firstName"),inDto.getString("proj_id"));
								moduleDividePO.copyProperties(dto);
								queryDto.put("DM_PARENT_CODE", parent_id);
								queryDto.put("proj_id", inDto.get("proj_id"));
								
								inDto.put("dm_parent_code", parent_id);
								String max_code = (String) sqlDao.selectOne("com.bl3.pm.basic.dao.ModuleDivideDao.getNextCode", inDto);
								parentModulePO.setDm_code(max_code);
								parentModulePO.setDm_name(dto.getString("secondName"));
								parentModulePO.setDm_parent_code(parent_id);
								parentModulePO.setTest_code(dto.getString("test_code"));
								parentModulePO.setState("0");
								parentModulePO.setDm_is_leaf(SystemCons.IS.YES);
								parentModulePO.setCreate_user_id(httpModel.getUserModel().getId());
								parentModulePO.setProj_id(inDto.getInteger("proj_id"));
								Date create_time = AOSUtils.getDateTime();
								parentModulePO.setCreate_time(create_time);
								moduleDivideDao.insertByKey(parentModulePO);
								//修改父类节点为枝节点
								ModuleDividePO updatePO = new ModuleDividePO();
								updatePO.setDm_code(parentModulePO.getDm_parent_code());
								updatePO.setDm_is_leaf(SystemCons.IS.NO);
								updatePO.setUpdate_time(new Date());
								updatePO.setUpdate_user_id(user_id);
								moduleDivideDao.updatefirstByKey(updatePO);
							}
							//对三级进行新增
							for(Dto dto : threeModuleDivide){
								ModuleDividePO moduleDividePO = new ModuleDividePO();
								int result = (int) sqlDao.selectOne("ModuleDiviDao.selectTestCode", inDto);
								if(result > 0){
									httpModel.setOutMsg("测试编码已存在！");
									return;
								}
								Dto queryDto=Dtos.newDto();
								String first_id = moduleDivideDao.selectFirst_id(dto.getString("firstName"),inDto.getString("proj_id"));
								String parent_id = moduleDivideDao.selectSecond_id(first_id, dto.getString("secondName"),inDto.getString("proj_id"));
								
								ModuleDividePO parentModulePO = moduleDivideDao.selectBySecondName(first_id, dto.getString("secondName"),inDto.getString("proj_id"));
								moduleDividePO.copyProperties(dto);
								queryDto.put("DM_PARENT_CODE", parent_id);
								queryDto.put("proj_id", inDto.get("proj_id"));
								
								inDto.put("dm_parent_code", parent_id);
								String max_code = (String) sqlDao.selectOne("com.bl3.pm.basic.dao.ModuleDivideDao.getNextCode", inDto);
								parentModulePO.setDm_code(max_code);
								parentModulePO.setDm_name(dto.getString("thirdName"));
								parentModulePO.setDm_parent_code(parent_id);
								parentModulePO.setTest_code(dto.getString("test_code"));
								parentModulePO.setState("0");
								parentModulePO.setDm_is_leaf(SystemCons.IS.YES);
								parentModulePO.setCreate_user_id(httpModel.getUserModel().getId());
								parentModulePO.setProj_id(inDto.getInteger("proj_id"));
								Date create_time = AOSUtils.getDateTime();
								parentModulePO.setCreate_time(create_time);
								moduleDivideDao.insertByKey(parentModulePO);
								//修改父类节点为枝节点
								ModuleDividePO updatePO = new ModuleDividePO();
								updatePO.setDm_code(parentModulePO.getDm_parent_code());
								updatePO.setDm_is_leaf(SystemCons.IS.NO);
								updatePO.setUpdate_time(new Date());
								updatePO.setUpdate_user_id(user_id);
								moduleDivideDao.updatefirstByKey(updatePO);
							}
							//对四级进行新增
							for(Dto dto : fourModuleDivide){
								ModuleDividePO moduleDividePO = new ModuleDividePO();
								int result = (int) sqlDao.selectOne("ModuleDiviDao.selectTestCode", inDto);
								if(result > 0){
									httpModel.setOutMsg("测试编码已存在！");
									return;
								}
								Dto queryDto=Dtos.newDto();
								String first_id = moduleDivideDao.selectFirst_id(dto.getString("firstName"),inDto.getString("proj_id"));
								String second_id = moduleDivideDao.selectSecond_id(first_id, dto.getString("secondName"),inDto.getString("proj_id"));
								String parent_id = moduleDivideDao.selectSecond_id(second_id, dto.getString("thirdName"),inDto.getString("proj_id"));
								
								ModuleDividePO parentModulePO = moduleDivideDao.selectByKey(parent_id);
								moduleDividePO.copyProperties(dto);
								queryDto.put("DM_PARENT_CODE", parent_id);
								queryDto.put("proj_id", inDto.get("proj_id"));
								
								inDto.put("dm_parent_code", parent_id);
								String max_code = (String) sqlDao.selectOne("com.bl3.pm.basic.dao.ModuleDivideDao.getNextCode", inDto);
								parentModulePO.setDm_code(max_code);
								parentModulePO.setDm_name(dto.getString("thirdName"));
								parentModulePO.setDm_parent_code(parent_id);
								parentModulePO.setTest_code(dto.getString("test_code"));
								parentModulePO.setState("0");
								parentModulePO.setDm_is_leaf(SystemCons.IS.YES);
								parentModulePO.setCreate_user_id(httpModel.getUserModel().getId());
								parentModulePO.setProj_id(inDto.getInteger("proj_id"));
								Date create_time = AOSUtils.getDateTime();
								parentModulePO.setCreate_time(create_time);
								moduleDivideDao.insertByKey(parentModulePO);
								
								//修改父类节点为枝节点
								ModuleDividePO updatePO = new ModuleDividePO();
								updatePO.setDm_code(parentModulePO.getDm_parent_code());
								updatePO.setDm_is_leaf(SystemCons.IS.NO);
								updatePO.setUpdate_time(new Date());
								updatePO.setUpdate_user_id(user_id);
								moduleDivideDao.updatefirstByKey(updatePO);
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
	 * 统一保存
	 * 
	 * @param httpModel
	 */
	public void saveGrid(HttpModel httpModel) {
 		Dto inDto = httpModel.getInDto();
		Integer update_user_id = httpModel.getUserModel().getId();
		List<Dto> modifies = inDto.getRows();
		if(modifies.isEmpty()){
			httpModel.setOutMsg("请先选择需保存的检查项!");
			return;
		}
		for (Dto dto : modifies) {
			dto.put("update_user_id", update_user_id);
			moduleDivideDao.saveGrid(dto);
		}
		httpModel.setOutMsg("保存成功");
	}
	
	/**
	 * 全部导出
	 * 
	 * @param httpModel
	 */
	public void exportALLExcel(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String dm_code = inDto.getString("dm_code");
		if(dm_code.equals("1")){
			List<ModuleDividePO> moduleDividePOs = moduleDivideDao.exportAExcel(inDto);
			for(int k=0;k<moduleDividePOs.size();k++){
				ModuleDividePO faPO = moduleDividePOs.get(k);
				if(Integer.valueOf(faPO.getState().toString()) == 0){
					faPO.setState("未启用");
				}else if(Integer.valueOf(faPO.getState().toString()) == 1){
					faPO.setState("已启用");
				}else{
					faPO.setState("");
				}
				String codingUserNames = "";
				String testUserNames = "";
				List<ModuleDividePO> codingUserName = moduleDivideDao.codingUser(inDto);
				List<ModuleDividePO> testUserName = moduleDivideDao.testUser(inDto);
				for(ModuleDividePO codinglists : codingUserName){
					codingUserNames = codingUserNames + " " + codinglists.getCoding_user_name();
				}
				for(ModuleDividePO testlists : testUserName){
					testUserNames = testUserNames + " " + testlists.getTest_user_name();
				}
				faPO.setCoding_user_name(codingUserNames);
				faPO.setTest_user_name(testUserNames);
			}
			ExcelExporterX exporter = new ExcelExporterX();
			Dto pDto = Dtos.newDto();
			pDto.put("reportTitle", "系统功能模块");
			exporter.setData(pDto, moduleDividePOs);
			exporter.setTemplatePath("/export/excel/moduleDivide.xlsx");
			exporter.setFilename("系统功能模块.xlsx");
			try {
				exporter.export(httpModel.getRequest(), httpModel.getResponse());
			} catch (IOException e) {
				throw new AOSException("导出失败：" + e.getMessage());
			}
		}else{
			List<ModuleDividePO> moduleDividePOs = moduleDivideDao.exportALLExcel(inDto);
			for(int k=0;k<moduleDividePOs.size();k++){
				ModuleDividePO faPO = moduleDividePOs.get(k);
				if(Integer.valueOf(faPO.getState().toString()) == 0){
					faPO.setState("未启用");
				}else if(Integer.valueOf(faPO.getState().toString()) == 1){
					faPO.setState("已启用");
				}else{
					faPO.setState("");
				}
				String codingUserNames = "";
				String testUserNames = "";
				List<ModuleDividePO> codingUserName = moduleDivideDao.codingUser(inDto);
				List<ModuleDividePO> testUserName = moduleDivideDao.testUser(inDto);
				for(ModuleDividePO codinglists : codingUserName){
					codingUserNames = codingUserNames + " " + codinglists.getCoding_user_name();
				}
				for(ModuleDividePO testlists : testUserName){
					testUserNames = testUserNames + " " + testlists.getTest_user_name();
				}
				faPO.setCoding_user_name(codingUserNames);
				faPO.setTest_user_name(testUserNames);
			}
			ExcelExporterX exporter = new ExcelExporterX();
			Dto pDto = Dtos.newDto();
			pDto.put("reportTitle", "系统功能模块");
			exporter.setData(pDto, moduleDividePOs);
			exporter.setTemplatePath("/export/excel/moduleDivide.xlsx");
			exporter.setFilename("系统功能模块.xlsx");
			try {
				exporter.export(httpModel.getRequest(), httpModel.getResponse());
			} catch (IOException e) {
				throw new AOSException("导出失败：" + e.getMessage());
			}
		}
		/*List<Dto> dtos = sqlDao.list("com.bl3.pm.basic.dao.ModuleDivideDao.exportALLExcel", inDto);
		for(int k=0;k<dtos.size();k++){
			Dto dto = dtos.get(k);
			if(AOSUtils.isNotEmpty(dto.get("state")) && dto.get("state") != ""){
				if(Integer.valueOf(dto.get("state").toString()) == 0){
					dto.put("state", "未启用");
				}else if(Integer.valueOf(dto.get("state").toString()) == 1){
					dto.put("state", "已启用");
				}else{
					dto.put("state", "");
				}
			}
		}
		ExcelExporterX exporter = new ExcelExporterX();
		Dto pDto = Dtos.newDto();//头
		pDto.put("reportTitle", "系统功能模块");
		exporter.setData(pDto, dtos);
		exporter.setTemplatePath("/export/excel/moduleDivide.xlsx");
		exporter.setFilename("系统功能模块.xlsx");
		try {
			exporter.export(httpModel.getRequest(), httpModel.getResponse());
		} catch (IOException e) {
			throw new AOSException("导出失败：" + e.getMessage());
		}*/
	}

	/**
	 * 删除功能模块
	 * 
	 * @param httpModel
	 */
	@Transactional
	public void deleteModule(HttpModel httpModel) {
		Dto outDto = Dtos.newOutDto();
		Dto inDto = httpModel.getInDto();
		ModuleDividePO moduleDividePo = new ModuleDividePO();
		moduleDividePo.copyProperties(inDto);
		String[] selectionIds = httpModel.getInDto().getRows();
		ModuleDividePO aosModulePO = (ModuleDividePO) sqlDao.selectOne(
				"com.bl3.pm.basic.dao.ModuleDivideDao.checkRootNode",
				Dtos.newDto("ids", StringUtils.join(selectionIds, ",")));
		if (AOSUtils.isNotEmpty(aosModulePO)) {
			outDto.setAppCode(AOSCons.ERROR);
			outDto.setAppMsg(AOSUtils.merge("操作失败，根节点[{0}]不能删除。", aosModulePO.getDm_name()));
		} else {
			for (String id : selectionIds) {
				ModuleDividePO delPO = moduleDivideDao.selectByKey(String.valueOf(id));
				if (AOSUtils.isEmpty(delPO)) {
					continue;
				}
				List<ModuleDividePO> subDelList = moduleDivideDao.like(Dtos.newDto("dm_code", id));
				for (ModuleDividePO subDelPO : subDelList) {
					subDelPO.setState(moduleDividePo.getState());
					moduleDivideDao.updateByKey(subDelPO);
				}

				// 更需父节点的是否叶子节点属性
				if (moduleDivideDao.rows(Dtos.newDto("dm_parent_code", delPO.getDm_parent_code())) == 0) {
					ModuleDividePO updatePO = new ModuleDividePO();
					updatePO.setDm_code(delPO.getDm_parent_code());
					updatePO.setDm_is_leaf(SystemCons.IS.YES);
					moduleDivideDao.updateByKey(updatePO);
				}

			}
			outDto.setAppMsg("成功删除功能模块数据。");
		}
		httpModel.setOutMsg(AOSJson.toJson(outDto));
	}

	/**
	 * 修改
	 * 
	 * @param httpModel
	 * @return
	 */
	public void update(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		Dto outDto = Dtos.newDto();
		int result = (int) sqlDao.selectOne("ModuleDiviDao.selectTestCodeUpdate", inDto);
		if(result > 0){
			outDto.setAppCode(AOSCons.ERROR);
			outDto.setAppMsg("测试编码已存在！");
			httpModel.setOutMsg(AOSJson.toJson(outDto));
			return;
		}
		ModuleDividePO moduleDividePO = new ModuleDividePO();
		moduleDividePO.copyProperties(inDto);
		moduleDividePO.setUpdate_user_id(httpModel.getUserModel().getId());
		Date update_time = AOSUtils.getDateTime();
		moduleDividePO.setUpdate_time(update_time);
		moduleDivideDao.updateByKey(moduleDividePO);
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
		for (String id : selectionIds) {
			moduleDivideDao.deleteByKey(String.valueOf(id));
		}
		httpModel.setOutMsg("删除成功");
	}
	

	/**
	 * 根据ID查询
	 * 
	 * @param httpModel
	 * @return
	 */
	public void get(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		ModuleDividePO moduleDividePO = moduleDivideDao.selectByKey(inDto.getString("id"));
		httpModel.setOutMsg(AOSJson.toJson(moduleDividePO));
	}

	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<ModuleDividePO> moduleDividePOs = moduleDivideDao.likeOrPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(moduleDividePOs, inDto.getPageTotal()));
	}

	/**
	 * 查询功能模块列表
	 * 
	 * @param httpModel
	 * @return
	 */
	public void listModules(HttpModel httpModel) {
		Dto qDto = httpModel.getInDto();
		if (qDto.getString("root").equals("true")) {
			qDto.put("dm_code", "");
		}
		if(qDto.getString("proj_id").equals("")){
			return;
		}
		List<Dto> moduleDtos = sqlDao.list("com.bl3.pm.basic.dao.ModuleDivideDao.listModulesPage", qDto);
		for(Dto dto : moduleDtos){
			Dto mDto = Dtos.newDto();
			mDto.put("proj_id", qDto.get("proj_id"));
			List<Dto> codingUserName = moduleDivideDao.codingUserID(mDto);
			List<Dto> testUserName = moduleDivideDao.testUserID(mDto);
			String codingUserNames = "";
			String testUserNames = "";
			for(Dto codinglists : codingUserName){
				codingUserNames = codingUserNames + " " + codinglists.getString("coding_user_name");
			}
			for(Dto testlists : testUserName){
				testUserNames = testUserNames + " " + testlists.getString("test_user_name");
			}
			dto.put("coding_user_name", codingUserNames);
			dto.put("test_user_name", testUserNames);
		}
		httpModel.setOutMsg(AOSJson.toGridJson(moduleDtos, qDto.getPageTotal()));
	}
	
	/**
	 * 复制查询页面
	 * 
	 * @param httpModel
	 */
	public void copyListModules(HttpModel httpModel) {
		Dto qDto = httpModel.getInDto();
		if (qDto.getString("root").equals("true")) {
			qDto.put("dm_code", "");
		}
		if(qDto.getString("proj_id").equals("")){
			return;
		}
		List<Dto> moduleDtos = sqlDao.list("com.bl3.pm.basic.dao.ModuleDivideDao.copyListModules", qDto);
		for(Dto dto : moduleDtos){
			Dto mDto = Dtos.newDto();
			mDto.put("proj_id", qDto.get("proj_id"));
			List<Dto> codingUserName = moduleDivideDao.codingUserID(mDto);
			List<Dto> testUserName = moduleDivideDao.testUserID(mDto);
			String codingUserNames = "";
			String testUserNames = "";
			for(Dto codinglists : codingUserName){
				codingUserNames = codingUserNames + " " + codinglists.getString("coding_user_name");
			}
			for(Dto testlists : testUserName){
				testUserNames = testUserNames + " " + testlists.getString("test_user_name");
			}
			dto.put("coding_user_name", codingUserNames);
			dto.put("test_user_name", testUserNames);
		}
		int count = moduleDivideDao.count(qDto);
		//httpModel.setOutMsg(AOSJson.toGridJson(moduleDtos, qDto.getPageTotal()));
		httpModel.setOutMsg(AOSJson.toGridJson(moduleDtos, count));
	}
	
	/**
	 * 查询自定义下拉组件数据
	 * 
	 * @param httpModel
	 * @return
	 */
	public void listModuleDivideComboBox(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("ModuleDiviDao.listModuleDivideComboBox", inDto);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}

	/**
	 * 查询项目模块数据
	 * 
	 * @param httpModel
	 * @return
	 */
	public void listModuleNumber(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		// 查询模块列表
		List JsonList = new ArrayList();
		List<Dto> list = sqlDao.list("ModuleDiviDao.listModuleDivideComboBox2", inDto);
		List<Dto> testList = new ArrayList<Dto>();
		for (Dto dto : list) {
			Dto mDto = Dtos.newDto();
			mDto.put("value", dto.getString("display"));
			testList.add(mDto);
		}
		// 查询总缺陷、未完成缺陷、已完成缺陷
		List<Dto> list2 = sqlDao.list("ModuleDiviDao.listDefectNumber", inDto);
		List<Dto> totallist = new ArrayList<Dto>();
		List<Dto> not_finishedlist = new ArrayList<Dto>();
		List<Dto> completedlist = new ArrayList<Dto>();
		for (Dto dto : list2) {
			Dto total = Dtos.newDto();
			Dto not_finished = Dtos.newDto();
			Dto completed = Dtos.newDto();
			// 添加到DTo
			total.put("value", dto.getString("total"));
			not_finished.put("value", dto.getString("not_finished"));
			completed.put("value", dto.getString("completed"));
			// 添加到集合
			totallist.add(total);
			not_finishedlist.add(not_finished);
			completedlist.add(completed);
		}
		JsonList.add(totallist);
		JsonList.add(not_finishedlist);
		JsonList.add(completedlist);
		JsonList.add(testList);
		httpModel.setOutMsg(AOSJson.toJson(JsonList));
	}

	/**
	 * 查询项目团队人员待处置任务树
	 * 
	 * @param httpModel
	 * @return
	 */
	public void listPendingTask(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("ModuleDiviDao.listPendingTask", inDto);
		List<Dto> nameList = new ArrayList<Dto>();
		List<Dto> countList = new ArrayList<Dto>();
		for (Dto dto : list) {
			Dto countDto = Dtos.newDto();
			countDto.put("value", dto.getString("count"));
			countDto.put("name", dto.getString("name"));
			countList.add(countDto);

		}
		httpModel.setOutMsg(AOSJson.toJson(countList));
	}

	/**
	 * 查询项目团队人员待处置任务树
	 * 
	 * @param httpModel
	 * @return
	 */
	public void listProjectTaskDetails(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("ModuleDiviDao.listProjectTaskDetails", inDto);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}

	/**
	 * 查询项目过程文档完成情况
	 * 
	 * @param httpModel
	 * @return
	 */
	public void listProcessFileUpload(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("ModuleDiviDao.listProcessFileUpload", inDto);
		int a = 0, b = 0;
		for (Dto dto : list) {
			if (dto.getString("value").equals("1")) {
				a++;
			}
			if (dto.getString("value").equals("0")) {
				b++;
			}
		}
		Dto adto = Dtos.newDto();
		adto.put("name", "已上传过程文档类型");
		adto.put("value", a);
		Dto bdto = Dtos.newDto();
		bdto.put("name", "未上传过程文档类型");
		bdto.put("value", b);
		List<Dto> chatList = new ArrayList<Dto>();
		chatList.add(adto);
		chatList.add(bdto);
		httpModel.setOutMsg(AOSJson.toJson(chatList));
	}
	
	String autoPrefixCode(String projId, int bit) {
        String result = "";
//        保留num的位数 // 0 代表前面补充0     
//         num 代表长度为4     
//         d 代表参数为正数型 
        result = String.format("%0" + bit + "d", Integer.parseInt(projId));
        return result;
    }
}
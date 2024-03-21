package com.bl3.pm.process.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.excel.xls.ExcelReader;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.utils.AOSJson;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;


import com.bl3.pm.process.dao.CheckItemDao;
import com.bl3.pm.process.dao.po.CheckItemPO;

/**
 * <b>pr_check_item[pr_check_item]业务逻辑层</b>
 * 
 * @author hanjin
 * @date 2019-10-10 13:58:43
 */
 @Service
 public class CheckItemService{
 	private static Logger logger = LoggerFactory.getLogger(CheckItemService.class);
 	@Autowired
	private CheckItemDao checkItemDao;
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
		httpModel.setViewPath("checkItem/checkItem_list.jsp");
	}
	/**
	 * 新增
	 * 
	 * @param httpModel
	 * @return
	 */
	public void create(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		Integer id = httpModel.getUserModel().getId();
		int result = checkItemDao.itemCount(inDto.getString("check_cata_id"),inDto.getString("check_item_name"));
		if(result == 1){
			httpModel.setOutMsg("存在重名的检查项明细!");
			return;
		}
		CheckItemPO checkItemPO=new CheckItemPO();
		checkItemPO.copyProperties(inDto);
		checkItemPO.setCreate_user_id(id);
		checkItemPO.setCreate_time(new Date());
		checkItemPO.setState("0");
		checkItemDao.insert(checkItemPO);
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
		int result = checkItemDao.itemOtCount(inDto.getString("check_cata_id"),inDto.getString("check_item_name"),inDto.getString("check_item_id"));
		if(result == 0){
			CheckItemPO checkItemPO=new CheckItemPO();
			Integer id = httpModel.getUserModel().getId();
			checkItemPO.copyProperties(inDto);
			checkItemPO.setUpdate_user_id(id);
			checkItemPO.setUpdate_time(new Date());
			checkItemDao.updateByKey(checkItemPO);
			httpModel.setOutMsg("修改成功");
		}else{
			httpModel.setOutMsg("无法修改，检查项明细有重名!");
			return;
		}
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
		String state = inDto.getString("state");
		if(state.equals("-1")){
			for(String id : selectionIds){
				checkItemDao.deleteByKey(Integer.valueOf(id));
				httpModel.setOutMsg("删除成功");
			}
		}
		if(state.equals("0")){
			for (String id : selectionIds) {
				checkItemDao.itemStopByKey(Integer.valueOf(id));
			}
			httpModel.setOutMsg("停用成功");
		}
		if(state.equals("1")){
			for(String id : selectionIds) {
				checkItemDao.itemRunByKey(Integer.valueOf(id));
			}
			httpModel.setOutMsg("启用成功");
		}
	}
	/**
	 * 
	 * 检查单目录导入
	 * 
	 * @param httpModel
	 */
	public void importFile(HttpModel httpModel) {
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
						String metaData = "process_product,problem_level,sort_no,check_item_name,remark";
						HSSFWorkbook workbook = new HSSFWorkbook(myfile.getInputStream());
						//读取当前excel的sheet数量
						int number = workbook.getNumberOfSheets();
						int i = 0;
						while (i<number) {
							ExcelReader excelReader = new ExcelReader(metaData,myfile.getInputStream());
							List<Dto> exclelist = excelReader.read(1,0,i);
							Date date = new Date();
							SimpleDateFormat sdf =  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
							for(int a = 0;a< exclelist.size(); a++){
								Dto pdto=exclelist.get(a);
//								int result = checkItemDao.itemCount(inDto.getString("check_cata_id"),pdto.get("check_item_name").toString());
//								if(result == 1){
//									httpModel.setOutMsg("存在重名的检查项明细!");
//									return;
//								}
								if(pdto.get("process_product").equals("进度计划")) {
									pdto.put("process_product", "1001");
								}else if(pdto.get("process_product").equals("周报")) {
									pdto.put("process_product", "1002");
								}else if(pdto.get("process_product").equals("配置管理")) {
									pdto.put("process_product", "1003");
								}else if(pdto.get("process_product").equals("过程")) {
									pdto.put("process_product", "1004");
								}else if(pdto.get("process_product").equals("计划变更")) {
									pdto.put("process_product", "1005");
								}else if(pdto.get("process_product").equals("需求变更")) {
									pdto.put("process_product", "1006");
								}else if(pdto.get("process_product").equals("问题管理")) {
									pdto.put("process_product", "1007");
								}else if(pdto.get("process_product").equals("评审管理")) {
									pdto.put("process_product", "1008");
								}
								if(pdto.get("problem_level").equals("轻微")) {
									pdto.put("problem_level", "1001");
								}else if(pdto.get("problem_level").equals("中等")) {
									pdto.put("problem_level", "1002");
								}else if(pdto.get("problem_level").equals("严重")) {
									pdto.put("problem_level", "1003");
								}
								pdto.put("sort_no", pdto.get("sort_no"));
								pdto.put("check_item_name", pdto.get("check_item_name"));
								pdto.put("remark", pdto.get("remark"));
								pdto.put("check_cata_id", inDto.getInteger("check_cata_id"));
								pdto.put("type_code", inDto.getString("type_code"));
								pdto.put("state", "0");
								pdto.put("create_user_id", httpModel.getUserModel().getId());
								pdto.put("create_time", new Date());
								CheckItemPO checkItemPO=new CheckItemPO();
								checkItemPO.copyProperties(pdto);
								checkItemDao.insert(checkItemPO);
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
	 * 根据ID查询
	 * 
	 * @param httpModel
	 * @return
	 */
	public void get(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		CheckItemPO checkItemPO=checkItemDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(checkItemPO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<CheckItemPO> checkItemPOs = checkItemDao.likePage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(checkItemPOs, inDto.getPageTotal()));
	}
 }
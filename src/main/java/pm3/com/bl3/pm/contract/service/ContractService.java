package com.bl3.pm.contract.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.typewrap.Dtos;
import aos.framework.core.utils.AOSJson;
import aos.framework.core.utils.AOSUtils;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;


import com.bl3.pm.contract.dao.ContractDao;
import com.bl3.pm.contract.dao.ContractFileDao;
import com.bl3.pm.contract.dao.ProjContractDao;
import com.bl3.pm.contract.dao.po.ContractFilePO;
import com.bl3.pm.contract.dao.po.ContractPO;
import com.bl3.pm.contract.dao.po.ContractPaymentPO;
import com.bl3.pm.contract.dao.po.ProjContractPO;
import com.bl3.pm.process.dao.po.ReportFileManagePO;

/**
 * <b>bs_contract[bs_contract]业务逻辑层</b>
 * 
 * @author wangjl
 * @date 2018-01-17 17:29:20
 */
 @Service
 public class ContractService{
 	private static Logger logger = LoggerFactory.getLogger(ContractService.class);
 	@Autowired
	private ContractDao contractDao;
	@Autowired
	private SqlDao sqlDao;
	@Autowired
	private IdService idService;
	@Autowired
	private ContractFileDao contractFileDao;
	@Autowired
	private ProjContractDao projContractDao;
	
	/**
	 * 初始化视图
	 * 
	 * @param httpModel
	 * @return
	 */
	public void init(HttpModel httpModel) {
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		httpModel.setViewPath("pm3/contract/contractmanage/contract_manage.jsp");
	}
	/**
	 * 新增时默认显示百分比
	 */
	public void queryCreatePercent(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		Dto outDto=Dtos.newDto();
		List<Dto>percentDto=sqlDao.list("com.bl3.pm.contract.dao.ContractDao.queryCreateOrUpdatePercent", inDto);
		if(percentDto.get(0).getBigDecimal("percentage").doubleValue()<=0){
			httpModel.setOutMsg("总百分比已达到百分之百");
			return;
		}
			outDto.put("percentage", percentDto.get(0).getBigDecimal("percentage"));
		httpModel.setOutMsg(AOSJson.toJson(outDto));
	}
	/**
	 * 修改时默认显示百分比
	 */
	public void queryUpdatePercent(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		Dto outDto=Dtos.newDto();
		List<Dto>percentDto=sqlDao.list("com.bl3.pm.contract.dao.ContractDao.queryCreateOrUpdatePercent", inDto);
		if(percentDto.get(0).getBigDecimal("percentage").doubleValue()<0){
			httpModel.setOutMsg("总百分比不能超过百分之百");
			return;
		}
			outDto.put("percentage", percentDto.get(0).getBigDecimal("percentage").doubleValue());
		httpModel.setOutMsg(AOSJson.toJson(outDto));
	}
	/**
	 * 计算剩余百分比
	 * 
	 */
	public void queryOtherPercent(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		Dto outDto=Dtos.newDto();
		List<Dto>percentDto=sqlDao.list("com.bl3.pm.contract.dao.ContractDao.queryOtherPercent", inDto);
		List<Dto>perDto=sqlDao.list("com.bl3.pm.contract.dao.ContractDao.queryCreateOrUpdatePercent", inDto);
		if(perDto.get(0).getBigDecimal("percentage").doubleValue()<0){
			httpModel.setOutMsg("总百分比不能超过百分之百");
			return;
		}
			outDto.put("percentage", perDto.get(0).getBigDecimal("percentage").doubleValue());
		percentDto.get(0).getBigDecimal("syje").doubleValue();
		if(AOSUtils.isEmpty(inDto.getBigDecimal("percentage"))){
			return;
		}
		if(percentDto.get(0).getBigDecimal("percent").doubleValue()==inDto.getBigDecimal("percentage").doubleValue()){
			outDto.put("rece_amount", percentDto.get(0).getBigDecimal("syje"));
		}
		httpModel.setOutMsg(AOSJson.toJson(outDto));
	}
	
	/**
	 * 启用
	 * 
	 * @param httpModel
	 * @return
	 */
	public void enable(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String[] selectionIds = inDto.getRows();
		inDto.put("state", 2);
		for (String ct_id : selectionIds) {
			inDto.put("ct_id", ct_id);
			sqlDao.update("ContractDao.updateByKey",inDto);
		}
		httpModel.setOutMsg("启用成功");
	}
	/**
	 * 暂停
	 * 
	 * @param httpModel
	 * @return
	 */
	public void stop(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String[] selectionIds = inDto.getRows();
		inDto.put("state", 4);
		for (String ct_id : selectionIds) {
			inDto.put("ct_id", ct_id);
			sqlDao.update("ContractDao.updateByKey",inDto);
		}
		httpModel.setOutMsg("暂停成功");
	}
	/**
	 * 停用
	 * 
	 * @param httpModel
	 * @return
	 */
	public void disable(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String[] selectionIds = inDto.getRows();
		inDto.put("state", 0);
		for (String ct_id : selectionIds) {
			inDto.put("ct_id", ct_id);
			sqlDao.update("ContractDao.updateByKey",inDto);
		}
		httpModel.setOutMsg("停用成功");
	}
	
	
	/**
	 * 新增
	 * 
	 * @param httpModel
	 * @return
	 */
	public void create(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		inDto.put("create_user_id", httpModel.getUserModel().getId());
		inDto.put("create_date", AOSUtils.getDateTimeStr());
		inDto.put("ct_code", "CT-" + idService.code("ct_code","yyMMdd","999"));
		inDto.put("state", 1);
		ContractPO contractPO=new ContractPO();
		contractPO.copyProperties(inDto);
		contractDao.insert(contractPO);
		//合同关联项目
		String proj_ids = inDto.getString("proj_id");
		if(!AOSUtils.isEmpty(proj_ids)){
			proj_ids = proj_ids.replace("[", "");
			proj_ids = proj_ids.replace("]", "");
			proj_ids = proj_ids.replace(" ", "");
			String [] projIds = proj_ids.split(",");
			ContractPO cpo = contractDao.selectOne(inDto);
			ProjContractPO ppo = new  ProjContractPO();
			ppo.setCreate_date(AOSUtils.getDateTime());
			ppo.setCreate_user_id( httpModel.getUserModel().getId());
			ppo.setState("1");
			ppo.setCt_id(cpo.getCt_id());
			for(String proj_id:projIds){
				ppo.setProj_id(Integer.parseInt(proj_id));
				sqlDao.insert("com.bl3.pm.contract.dao.ProjContractDao.insert", ppo);
			}
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
		inDto.put("update_user_id", httpModel.getUserModel().getId());
		inDto.put("update_date", AOSUtils.getDateTimeStr());
		ContractPO contractPO=new ContractPO();
		contractPO.copyProperties(inDto);
		contractDao.updateByKey(contractPO);
		String proj_id = inDto.getString("proj_id");
		//直接删除项目合同关联表
		int ct_id = inDto.getInteger("ct_id");
		inDto.clear();
		inDto.put("ct_id", ct_id);
		sqlDao.delete("ContractDao.delete", inDto);
		//重新添加
		proj_id = proj_id.replace("[", "");
		proj_id = proj_id.replace("]", "");
		proj_id = proj_id.replace(" ", "");
		String [] projIds = proj_id.split(",");
		ProjContractPO ppo = new  ProjContractPO();
		ppo.setCt_id(ct_id);
		ppo.setCreate_date(AOSUtils.getDateTime());
		ppo.setCreate_user_id( httpModel.getUserModel().getId());
		ppo.setState("1");
		for(String id:projIds){
			if(AOSUtils.isEmpty(id)){
				break;
			}
			ppo.setProj_id(Integer.parseInt(id));
			sqlDao.insert("com.bl3.pm.contract.dao.ProjContractDao.insert", ppo);
		}
		/*//查出改合同在数据库关联了几个项目
		 * List<ProjContractPO> projCintractPOs = projContractDao.list(inDto);
		for(int i=0;i<projIds.length;i++){
			int proj_id1 = Integer.parseInt(projIds[i]);
			for(int j=0;j<projCintractPOs.size();j++){
				int proj_id2 = projCintractPOs.get(j).getProj_id();
				if(proj_id1 == proj_id2){
					break;
				}
				if(j == projCintractPOs.size()-1){//新的pro_id for到最后没有break执行
					
				}
			}
		}*/
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
		String ct_id = inDto.getString("ct_id");
		contractDao.deleteByKey(Integer.valueOf(ct_id));
		sqlDao.delete("ContractStageDao.deleteByCtKey", Integer.valueOf(ct_id));
		sqlDao.delete("ContractFileDao.deleteByCtKey", Integer.valueOf(ct_id));
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
		ContractPO contractPO=contractDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(contractPO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String [] proj_id = inDto.getString("proj_id").split(",");
		String proj_id_query="";
		if(proj_id.length>1){
			proj_id_query = inDto.getString("proj_id").substring(1, inDto.getString("proj_id").length()-1);
		}else if(proj_id.length==1){
			proj_id_query=inDto.getString("proj_id");
		}
		inDto.put("proj_id_query", proj_id_query);
		inDto.put("ct_code", inDto.get("keyWords"));
		inDto.put("ct_name", inDto.get("keyWords"));
		inDto.put("partya_name", inDto.get("keyWords"));
		List<Dto> contractDtos = sqlDao.list("ContractDao.likePage", inDto);
		for(int i=0;i<contractDtos.size();i++){
			String [] proj_ids = contractDtos.get(i).getString("proj_ids").split(",");
				Dto dto = Dtos.newDto();
				dto.put("proj_id", proj_ids);
				String proj_names = (String) sqlDao.selectOne("ContractDao.selectProjName",dto);
				contractDtos.get(i).put("proj_names", proj_names);
//			}
		}
		httpModel.setOutMsg(AOSJson.toGridJson(contractDtos, inDto.getPageTotal()));
	}
	
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void querySaveContract(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> contractDtos = sqlDao.list("ContractDao.querySaveContract", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(contractDtos, inDto.getPageTotal()));
	}
	
	/**
	 * 上传文件
	 * 
	 * @param httpModel
	 */
	public void importFile(HttpModel httpModel){
		Dto paramDto = httpModel.getInDto();
		int userid = httpModel.getUserModel().getId();
		String account = httpModel.getUserModel().getAccount();
		String username = httpModel.getUserModel().getName();
		ContractFilePO inDto = new ContractFilePO();
		// 获取web应用根路径,也可以直接指定服务器任意盘符路径
		String savePath = httpModel.getRequest()
				.getServletContext().getRealPath("uploaddata") + "/"
				+"合同管理/";

		//设置数据库保存路径
		String http = httpModel.getRequest().getScheme();
		String server = httpModel.getRequest().getServerName();
		int port = httpModel.getRequest().getServerPort(); 
		String path = httpModel.getRequest().getContextPath(); 
		String saveURL = http + "://" + server + ":" + port + path + "\\uploaddata/合同管理/";
		// String savePath = "d:/upload/";
		// 检查路径是否存在,如果不存在则创建之
		File file = new File(savePath);
		if (!file.exists()) {
			file.mkdir();
		}
		// 文件按天归档
		savePath = savePath + paramDto.get("ct_id") + "-" + userid + "/";
		saveURL = saveURL + paramDto.get("ct_id") + "-" + userid  + "/";
		File file1 = new File(savePath);
		if (!file1.exists()) {
			file1.mkdir();
		}
		//消息提示
		String message = "";
		try{//使用Apache文件上传组件处理文件上传步骤：
			//1、创建一个DiskFileItemFactory工厂
			DiskFileItemFactory factory = new DiskFileItemFactory();
			//2、创建一个文件上传解析器
			ServletFileUpload upload = new ServletFileUpload(factory);
			//解决上传文件名的中文乱码
			upload.setHeaderEncoding("UTF-8"); 
			//3、判断提交上来的数据是否是上传表单的数据
			boolean isMultipart = ServletFileUpload.isMultipartContent(httpModel.getRequest());
			if(!isMultipart){
				//按照传统方式获取数据
				return;
			}
			//4、使用ServletFileUpload解析器解析上传数据，解析结果返回的是一个List<FileItem>集合，每一个FileItem对应一个Form表单的输入项
			List<FileItem> list = upload.parseRequest(httpModel.getRequest());
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
						MultipartFile myfile=entity.getValue();
						//得到上传的文件名称，
						String filename = myfile.getOriginalFilename();
						System.out.println(filename);
						if(filename==null || filename.trim().equals("")){
							continue;
						}
						File fileToCreate = new File(savePath, filename);
						if (fileToCreate.exists()) {
							message="{success:true,msg:'该文件已经存在，请检查后再操作！'}";
							break;
						}
						//注意：不同的浏览器提交的文件名是不一样的，有些浏览器提交上来的文件名是带有路径的，如：  c:\a\b\1.txt，而有些只是单纯的文件名，如：1.txt
						//处理获取到的上传文件的文件名的路径部分，只保留文件名部分
						inDto.setCt_file_id(idService.nextValue("seq_pr_report_file_manage").intValue());
						filename = filename.substring(filename.lastIndexOf("\\")+1);
						inDto.setCt_file_title( filename);
						inDto.setCt_file_size(myfile.getSize()+"");
						inDto.setCt_file_path(savePath + filename);
						inDto.setCt_file_url(saveURL + filename);
						inDto.setCreate_user_id(userid);
						inDto.setCreate_time(AOSUtils.getDateTime());
						inDto.setState("1"); 
						inDto.setCt_id(paramDto.getInteger("ct_id"));
						inDto.setCt_file_remark(paramDto.getString("ct_file_remark"));
						contractFileDao.insert(inDto);
						inDto.clear();
						//获取item中的上传文件的输入流
						InputStream in = myfile.getInputStream();
						//创建一个文件输出流
						FileOutputStream out = new FileOutputStream(savePath + "\\" + filename);
						//创建一个缓冲区
						byte buffer[] = new byte[1024];
						//判断输入流中的数据是否已经读完的标识
						int len = 0;
						//循环将输入流读入到缓冲区当中，(len=in.read(buffer))>0就表示in里面还有数据
						while((len=in.read(buffer))>0){
							//使用FileOutputStream输出流将缓冲区的数据写入到指定的目录(savePath + "\\" + filename)当中
							out.write(buffer, 0, len);
						}
						//关闭输入流
						in.close();
						//关闭输出流
						out.close();
						//删除处理文件上传时生成的临时文件
						message="{success:true,msg:'上传成功！'}";

					}
				}
			}catch(Exception e){
				e.printStackTrace();
			}
		}catch (Exception e) {
			message= "文件上传失败！";
			e.printStackTrace();

		}
		httpModel.setOutMsg(message);
	}
	
	/**
	 * 新增
	 * 
	 * @param httpModel
	 * @return
	 */
	public void reason(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		inDto.put("state", 0);
		inDto.put("update_user_id",httpModel.getUserModel().getId());
		inDto.put("update_date", AOSUtils.getDateTimeStr());
		ContractPO contractPO=new ContractPO();
		contractPO.copyProperties(inDto);
		contractDao.updateByKey(contractPO);
		httpModel.setOutMsg("新增成功");
	}
	
	/**
	 * 确认合同完成
	 * 
	 * @param httpModel
	 */
	public void complete(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		inDto.put("update_user_id", httpModel.getUserModel().getId());
		inDto.put("update_date", AOSUtils.getDateTimeStr());
		ContractPO contractPO=new ContractPO();
		contractPO.copyProperties(inDto);
		contractDao.updateStateByKey(contractPO);
		httpModel.setOutMsg("合同确认完成");
	}
	
	/**
	 * 分页查询
	 * 查询项目基础信息管理的有效合同信息
	 * @param httpModel
	 */
	public void queryCommonContact(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String [] proj_id = inDto.getString("proj_id").split(",");
		List<Dto> contractDtos = sqlDao.list("ContractDao.likeCommonPage", inDto);
		for(int i=0;i<contractDtos.size();i++){
			String [] proj_ids = contractDtos.get(i).getString("proj_ids").split(",");
			int number = 0;
			if(!proj_id[0].equals("")){
				for(int j=0;j<proj_id.length;j++){
					for(int k=0;k<proj_ids.length;k++){
						if(proj_id[j].equals(proj_ids[k])){
							number++;
							break;
						}
					}
				}
			}
			if(!proj_id[0].equals("") && number<proj_id.length){
				contractDtos.remove(i);
				i--;
			}else{
				Dto dto = Dtos.newDto();
				dto.put("proj_id", proj_ids);
				String proj_names = (String) sqlDao.selectOne("ContractDao.selectProjName",dto);
				contractDtos.get(i).put("proj_names", proj_names);
			}
		}
		httpModel.setOutMsg(AOSJson.toGridJson(contractDtos, inDto.getPageTotal()));
	}
	/**
	 * 分页查询
	 * 查询项目下的链接合同
	 * @param httpModel
	 */
	public void queryProContact(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String [] proj_id = inDto.getString("proj_id").split(",");
		List<Dto> contractDtos = sqlDao.list("ContractDao.likePage", inDto);
		for(int i=0;i<contractDtos.size();i++){
			String [] proj_ids = contractDtos.get(i).getString("proj_ids").split(",");
			int number = 0;
			if(!proj_id[0].equals("")){
				for(int j=0;j<proj_id.length;j++){
					for(int k=0;k<proj_ids.length;k++){
						if(proj_id[j].equals(proj_ids[k])){
							number++;
							break;
						}
					}
				}
			}
			if(!proj_id[0].equals("") && number<proj_id.length){
				contractDtos.remove(i);
				i--;
			}else{
				Dto dto = Dtos.newDto();
				dto.put("proj_id", proj_ids);
				String proj_names = (String) sqlDao.selectOne("ContractDao.selectProjName",dto);
				contractDtos.get(i).put("proj_names", proj_names);
			}
		}
		httpModel.setOutMsg(AOSJson.toGridJson(contractDtos, inDto.getPageTotal()));
	}
 }
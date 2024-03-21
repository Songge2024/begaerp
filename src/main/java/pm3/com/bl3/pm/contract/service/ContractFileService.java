package com.bl3.pm.contract.service;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.typewrap.Dtos;
import aos.framework.core.utils.AOSJson;
import aos.framework.core.utils.AOSUtils;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;


import com.bl3.pm.contract.dao.ContractFileDao;
import com.bl3.pm.contract.dao.po.ContractFilePO;
import com.bl3.pm.process.dao.po.ProcessFileUploadPO;
import com.mchange.v2.c3p0.impl.NewProxyDatabaseMetaData;

/**
 * <b>bs_contract_file[bs_contract_file]业务逻辑层</b>
 * 
 * @author wangjl
 * @date 2018-01-17 17:29:20
 */
 @Service
 public class ContractFileService{
 	private static Logger logger = LoggerFactory.getLogger(ContractFileService.class);
 	@Autowired
	private ContractFileDao contractFileDao;
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
		httpModel.setViewPath("contractFile/contractFile_list.jsp");
	}
	/**
	 * 新增
	 * 
	 * @param httpModel
	 * @return
	 */
	public void create(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		//inDto.remove("id");
		ContractFilePO contractFilePO=new ContractFilePO();
		contractFilePO.setCt_file_id(idService.nextValue("seq_bs_contract_file").intValue());
		contractFilePO.copyProperties(inDto);
		contractFileDao.insert(contractFilePO);
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
		ContractFilePO contractFilePO=new ContractFilePO();
		contractFilePO.copyProperties(inDto);
		contractFileDao.updateByKey(contractFilePO);
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
		List<Dto>userList=sqlDao.list("ContractFileDao.queryLoginAdPm", inDto);
		String userid = httpModel.getUserModel().getId().toString();
		String[] selectionIds = inDto.getRows();
		for(int a=0;a<userList.size();a++){
			Dto userDto=userList.get(a);
			if(userid.equals(userDto.getString("id"))||userid.equals(inDto.getString("create_user_id"))){
				for (String ct_file_id : selectionIds) {
					contractFileDao.deleteByKey(Integer.valueOf(ct_file_id));
				}
				httpModel.setOutMsg("删除成功");
			}else{
				httpModel.setOutMsg("您没有权限删除该数据！");
				continue;
			}
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
		ContractFilePO contractFilePO=contractFileDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(contractFilePO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> contractFilePOs = sqlDao.list("ContractFileDao.list", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(contractFilePOs, inDto.getPageTotal()));
	}
	
	/**
	 * 文件下载
	 * @param httpModel
	 */
	public void downloadFile(HttpModel httpModel){
		// 这里只是演示获取httpmodel获取response对象，具体的表格生成请自行使用poi生成电子表格
		HttpServletResponse response = httpModel.getResponse();
		HttpServletRequest request = httpModel.getRequest();
		Dto inDto = httpModel.getInDto();
		String message="";
		ContractFilePO po = contractFileDao.selectByKey(inDto.getInteger("ct_file_id"));
		File file = new File(po.getCt_file_path());

		File fileToCreate = new File(po.getCt_file_path());
		if (!fileToCreate.exists()) {
			message="该文件不存在，请检查后再操作！";
			httpModel.setOutMsg(message);
		}else{
			String filename = AOSUtils.encodeChineseDownloadFileName(httpModel.getRequest().getHeader("USER-AGENT"),po.getCt_file_title());
			//中文乱码转化
			response.setHeader("Content-Disposition", "attachment; filename=" + filename + ";");
			BufferedInputStream in;
			ServletOutputStream os = null;
			try {
				in = new BufferedInputStream(new FileInputStream(file));
				ByteArrayOutputStream out = new ByteArrayOutputStream(1024);
				byte[] temp = new byte[1024];
				int size = 0;
				while ((size = in.read(temp)) != -1) {
					out.write(temp, 0, size);
				}
				in.close();
				os = response.getOutputStream();
				os.write(out.toByteArray());
				os.flush();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					os.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}

	public void downloadFileByZip(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		HttpServletResponse response = httpModel.getResponse();
		HttpServletRequest request = httpModel.getRequest();
		String ct_name = (String) inDto.get("ct_name");
		//把文件压缩成zip包，放在临时目录
		String tempPath = createZipFile(httpModel);
		File file = new File(tempPath);
		String filename = ct_name + AOSUtils.getDateTimeStr()+".zip";
		filename = AOSUtils.encodeChineseDownloadFileName(httpModel.getRequest().getHeader("USER-AGENT"),filename);
		//中文乱码转化
		response.setHeader("Content-Disposition", "attachment; filename=" + filename + ";");
		BufferedInputStream in;
		ServletOutputStream os = null;
		try {
			in = new BufferedInputStream(new FileInputStream(file));
			ByteArrayOutputStream out = new ByteArrayOutputStream(1024);
			byte[] temp = new byte[1024];
			int size = 0;
			while ((size = in.read(temp)) != -1) {
				out.write(temp, 0, size);
			}
			in.close();
			os = response.getOutputStream();
			os.write(out.toByteArray());
			os.flush();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				os.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * 创建zip文件,返回文件存放临时路径
	 * @param httpModel
	 * @return
	 */
	public String createZipFile(HttpModel httpModel){
		HttpServletResponse response = httpModel.getResponse();
		HttpServletRequest request = httpModel.getRequest();
		int flag = 0;
		Dto inDto = httpModel.getInDto();
		String[] selectionIds = httpModel.getInDto().getRows();
		String desPath="";
		//文件路径
		List<File> pathList = new ArrayList<File>();
		int index = 0;
		for (String ct_file_id : selectionIds) {
			ContractFilePO po = contractFileDao.selectByKey(Integer.valueOf(ct_file_id));
			if (AOSUtils.isEmpty(po)) {
				continue;
			}
			pathList.add(index, new File(po.getCt_file_path()));
			index++;
		}
		//String desPath = request.getSession().getServletContext().getRealPath("/upload/zip/");
		desPath = request.getSession().getServletContext().getRealPath("/zipdown//");
		String fileName = "temp.zip";
		File file = new File(desPath);
		if (!file.exists()) {
			file.mkdir();
		}
		desPath = desPath + fileName;
		//		System.out.println("临时文件="+desPath);
		File zipFile = new File(desPath);
		ZipOutputStream zipStream = null;
		FileInputStream zipSource = null;
		BufferedInputStream bufferStream = null;
		ServletOutputStream os = null;
		try {
			//构造最终压缩包的输出流
			zipStream = new ZipOutputStream(new FileOutputStream(zipFile));
			for(int i =0;i<pathList.size();i++){
				File filePath = pathList.get(i);
				//将需要压缩的文件格式化为输入流
				zipSource = new FileInputStream(filePath);
				//压缩条目不是具体独立的文件，而是压缩包文件列表中的列表项，称为条目，就像索引一样
				ZipEntry zipEntry = new ZipEntry(filePath.getName());
				//定位该压缩条目位置，开始写入文件到压缩包中
				zipStream.putNextEntry(zipEntry);
				//输入缓冲流
				bufferStream = new BufferedInputStream(zipSource, 1024 * 10);
				int read = 0;
				//创建读写缓冲区
				byte[] buf = new byte[1024 * 10];
				while((read = bufferStream.read(buf, 0, 1024 * 10)) != -1)
				{
					zipStream.write(buf, 0, read);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {

			//关闭流
			try {
				if(null != bufferStream) bufferStream.close();
				if(null != zipStream) zipStream.close();
				if(null != zipSource) zipSource.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return desPath;
	}
 }
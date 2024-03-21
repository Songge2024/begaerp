   package com.bl3.pm.process.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.utils.AOSJson;
import aos.framework.core.utils.AOSUtils;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;


import com.bl3.pm.process.dao.ProcessFiletypeDao;
import com.bl3.pm.process.dao.po.ProcessFiletypePO;
import com.bl3.pm.process.dao.po.ProcessPO;

/**
 * <b>pr_process_filetype[pr_process_filetype]业务逻辑层</b>
 * 
 * @author heying
 * @date 2017-12-14 16:24:05
 */
@Service
public class ProcessFiletypeService{
	private static Logger logger = LoggerFactory.getLogger(ProcessFiletypeService.class);
	@Autowired
	private ProcessFiletypeDao processFiletypeDao;
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
		httpModel.setViewPath("processFiletype/processFiletype_list.jsp");
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
		ProcessFiletypePO processFiletypePO=new ProcessFiletypePO();
		int create_user_id = httpModel.getUserModel().getId();
		int count = processFiletypeDao.countFiletypeId(inDto);
		if(count==0){
		//processFiletypePO.setProc_filetype_id(idService.nextValue("seq_pr_process_filetype").intValue());
		processFiletypePO.copyProperties(inDto);
		processFiletypePO.setCreate_user_id(create_user_id);
		processFiletypePO.setState("1");
		processFiletypeDao.insert(processFiletypePO);
		httpModel.setOutMsg("新增成功");
		}else{
			httpModel.setOutMsg("保存失败,存在相同的文件信息,请核对!");
		}
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
		ProcessFiletypePO processFiletypePO=new ProcessFiletypePO();
		processFiletypePO.copyProperties(inDto);
		processFiletypeDao.updateByKey(processFiletypePO);
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
			inDto.put("proc_filetype_id", Integer.valueOf(id));		
			int count =processFiletypeDao.countFiletype(inDto);
			if(count==0){
				processFiletypeDao.deleteByKey(Integer.valueOf(id));
			}else{
				httpModel.setOutMsg("删除失败!该文件信息已上传文件,不能进行删除!");
				return ;
			}
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
		ProcessFiletypePO processFiletypePO=processFiletypeDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(processFiletypePO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<ProcessFiletypePO> processFiletypePOs = processFiletypeDao.likeOrPage(inDto);//listPage
		httpModel.setOutMsg(AOSJson.toGridJson(processFiletypePOs, inDto.getPageTotal()));
	}

	/**
	 * grid变动保存
	 * 
	 * @param httpModel
	 */
	public void saveFiletypeGrid(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		List<Dto> modifies = inDto.getRows();
		ProcessFiletypePO processFiletypePO=new ProcessFiletypePO();
		int update_user_id = httpModel.getUserModel().getId();
		for (Dto dto : modifies) {
			processFiletypePO.copyProperties(dto);
			processFiletypePO.setUpdate_user_id(update_user_id);
			processFiletypeDao.updateByKey(processFiletypePO);
		}
		httpModel.setOutMsg("保存成功");
		
	}
	

	/**
	 * 根据项目ID 过程树分页查询
	 * 
	 * @param httpModel
	 */
	public void byProcPage(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String tree_param = (String) inDto.get("tree_param");
		if(AOSUtils.isNotEmpty(tree_param)){
			if(!tree_param.equals("0")){
				int index = tree_param.indexOf("-");
				if(index <= 0){
					inDto.put("rootdir_id", tree_param);
				}else{
					inDto.put("process_id", tree_param.substring(index+1));
				}

			}
		}

		List<ProcessFiletypePO> processFiletypePOs = processFiletypeDao.byProcListPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(processFiletypePOs, inDto.getPageTotal()));
	}

	/**
	 * 文件上传下载页面的文件类型分页查询
	 * 
	 * @param httpModel
	 */
	/*public void filetypePage(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<ProcessFiletypePO> processFiletypePOs = processFiletypeDao.likeOrPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(processFiletypePOs, inDto.getPageTotal()));
	}*/

	public static void main(String[] args) {
		String in = "122-212";
		System.out.println(in.substring(in.indexOf("-")+1));
	}

}
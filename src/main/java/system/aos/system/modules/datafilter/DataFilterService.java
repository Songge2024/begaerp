package aos.system.modules.datafilter;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.typewrap.Dtos;
import aos.framework.core.utils.AOSJson;
import aos.framework.core.utils.AOSUtils;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;
import aos.system.dao.AosDataFilterDao;
import aos.system.dao.AosRoleDataFilterDao;
import aos.system.dao.po.AosDataFilterPO;
import aos.system.dao.po.AosRoleDataFilterPO;

/**
 * <b>aos_data_filter[aos_data_filter]业务逻辑层</b>
 * 
 * @author Remexs
 * @date 2017-11-25 15:33:10
 */
@Service
public class DataFilterService {
	private static Logger logger = LoggerFactory.getLogger(DataFilterService.class);
	@Autowired
	private AosDataFilterDao aosDataFilterDao;
	@Autowired
	private AosRoleDataFilterDao aosRoleDataFilterDao;
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
		httpModel.setViewPath("aosDataFilter/aosDataFilter_list.jsp");
	}

	/**
	 * 新增
	 * 
	 * @param inDto
	 * @return
	 */
	@Transactional
	public Integer insert(Dto inDto) {
		AosDataFilterPO aosDataFilterPO = new AosDataFilterPO();
		aosDataFilterPO.setId(idService.nextValue("seq_data_filter").intValue());
		aosDataFilterPO.copyProperties(inDto);
		aosDataFilterDao.insert(aosDataFilterPO);
		return aosDataFilterPO.getId();
	}

	/**
	 * 根据sqlid查询指定 sql是否存在
	 * 
	 * @param inDto
	 * @return
	 */
	public boolean exist(String sqlid) {
		Integer count = aosDataFilterDao.rows(Dtos.newDto("sqlid", sqlid));
		return count > 0;
	}


	/**
	 * 删除
	 * 
	 * @param httpModel
	 * @return
	 */
	@Transactional
	public void deleteRoleRowsFilter(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String[] selectionIds = inDto.getRows();
		for (String id : selectionIds) {
			aosRoleDataFilterDao.deleteByKey(Integer.valueOf(id));
		}
		httpModel.setOutMsg("删除成功");
	}
	/**
	 * 保存行级过滤规则
	 * @param httpModel
	 */
	@Transactional
	public void saveRowsFilter(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> rowsFilters = AOSJson.fromJson(inDto.getString("rowsFilter"));
		for (Dto rowfilter : rowsFilters) {
			AosDataFilterPO aosDataFilterPO = new AosDataFilterPO();
			aosDataFilterPO.copyProperties(rowfilter);
			aosDataFilterDao.updateByKey(aosDataFilterPO);
		}
		httpModel.setOutMsg("保存成功");
	}
	/**
	 * 新增或修改过滤规则
	 * 
	 * @param httpModel
	 */
	@Transactional
	public void saveRoleRowsFilter(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> roleRowsFilters = AOSJson.fromJson(inDto.getString("role_rowsFilter"));
		for (Dto roleRowfilter : roleRowsFilters) {
			AosRoleDataFilterPO aosRoleDataFilterPO = new AosRoleDataFilterPO();
			aosRoleDataFilterPO.copyProperties(roleRowfilter);
			if (AOSUtils.isNotEmpty(roleRowfilter.get("id")) || aosRoleDataFilterDao.rows(roleRowfilter) > 0) {// 新增
				aosRoleDataFilterDao.updateByKey(aosRoleDataFilterPO);
			} else {// 修改
				aosRoleDataFilterPO.setId(idService.nextValue("seq_role_row_filter").intValue());
				aosRoleDataFilterDao.insert(aosRoleDataFilterPO);
			}
		}
		httpModel.setOutMsg("保存成功");
	}

	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void queryRowsFilterPage(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<AosDataFilterPO> aosDataFilterPOs = aosDataFilterDao.likeOrPage(inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(aosDataFilterPOs, inDto.getPageTotal()));
	}

	/**
	 * 根据指定sqlid和role_id 查询数据行过滤配置
	 * 
	 * @param httpModel
	 */
	public void queryRoleRowsFilterPage(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> roleDataFilters = sqlDao.list("DateFilter.queryRoleRowsFilterPage", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(roleDataFilters, inDto.getPageTotal()));
	}

	/**
	 * 根据指定sqlid和user_id 查询数据行过滤配置
	 * 
	 * @return
	 */
	public List<Dto> queryUserRowsFilter(Integer userid, String sqlid) {
		Dto queryDto = Dtos.newDto();
		queryDto.put("user_id", userid);
		queryDto.put("sqlid", sqlid);
		return sqlDao.list("DateFilter.queryUserRowsFilter", queryDto);
	}
}
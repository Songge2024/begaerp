package aos.system.modules.home;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.lang.math.RandomUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bl3.pm.task.dao.po.WeekReportPO;
import com.google.common.collect.Lists;
import com.google.gson.reflect.TypeToken;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.dao.asset.DBDialectUtils;
import aos.framework.core.redis.JedisUtil;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.typewrap.Dtos;
import aos.framework.core.utils.AOSCodec;
import aos.framework.core.utils.AOSCons;
import aos.framework.core.utils.AOSCxt;
import aos.framework.core.utils.AOSJson;
import aos.framework.core.utils.AOSUtils;
import aos.framework.dao.AosUserDao;
import aos.framework.dao.po.AosUserPO;
import aos.framework.web.router.HttpModel;
import aos.system.common.model.UserModel;
import aos.system.common.utils.ErrorCode;
import aos.system.common.utils.SystemCons;
import aos.system.common.utils.SystemUtils;
import aos.system.modules.cache.CacheUserDataService;

/**
 * 首页服务实现
 * 
 * @author xiongchun
 *
 */
@Service
public class HomeService {

	private static Logger logger = LoggerFactory.getLogger(HomeService.class);

	@Autowired
	private CacheUserDataService cacheUserDataService;
	@Autowired
	private AosUserDao aosUserDao;
	@Autowired
	private SqlDao sqlDao;

	/**
	 * 注册页面初始化
	 * 
	 * @param httpModel
	 * @return
	 */
	public void initLogin(HttpModel httpModel) {

		httpModel.setAttribute("app_title", AOSCxt.getParam("app_title"));
		httpModel.setAttribute("left_logo", AOSCxt.getParam("left_logo"));
		httpModel.setAttribute("vercode_characters", AOSCxt.getParam("vercode_characters"));
		httpModel.setAttribute("vercode_length", AOSCxt.getParam("vercode_length"));
		httpModel.setAttribute("is_show_vercode", AOSCxt.getParam("is_show_vercode"));
		httpModel.setAttribute("login_wait_msg", AOSCxt.getParam("login_wait_msg"));
		httpModel.setAttribute("north_back_img", AOSCxt.getParam("skin") + ".png");
		httpModel.setAttribute("login_dev", AOSCxt.getParam("login_dev"));
		httpModel.setAttribute("login_dev_account", AOSCxt.getParam("login_dev_account"));
		String login_back_img = AOSCxt.getParam("login_back_img");
		if (StringUtils.equals(login_back_img, "-1")) {
			int backImgIndex = RandomUtils.nextInt(3); // [0,3)
			login_back_img = backImgIndex + ".jpg";
		}
		httpModel.setAttribute("login_back_img", login_back_img);
		int row_space_ = 25, padding_ = 50;
		if (StringUtils.equals(AOSCxt.getParam("is_show_vercode"), SystemCons.IS.YES)) {
			row_space_ = 15;
			padding_ = 30;
		}
		httpModel.setAttribute("row_space", row_space_);
		httpModel.setAttribute("padding", padding_);
		// 用来标识登录页面校验验证码用的
		httpModel.setAttribute("vercode_uuid", UUID.randomUUID().toString());
		//httpModel.setViewPath("login.jsp");
		httpModel.setViewPath("login.html");
	}

	/**
	 * 首页页面初始化
	 * 
	 * @param httpModel
	 * @return
	 */
	public void initIndex(HttpModel httpModel) {
		UserModel userModel = httpModel.getUserModel();
		// 构造卡片菜单
		httpModel.setAttribute("cardDtos", getCardListFromCache(userModel.getId()));

		httpModel.setAttribute("north_back_img", userModel.getSkin() + ".png");
		httpModel.setAttribute("south_back_color", AOSCxt.getDicDesc("south_back_color", userModel.getSkin()));
		httpModel.setAttribute("copyright", AOSCxt.getParam("copyright"));
		httpModel.setAttribute("app_title", AOSCxt.getParam("app_title"));
		httpModel.setAttribute("welcome_page_title", AOSCxt.getParam("welcome_page_title"));
		httpModel.setAttribute("account", userModel.getAccount());
		httpModel.setAttribute("user_name", userModel.getName());
		httpModel.setAttribute("user_id", userModel.getId());
		httpModel.setAttribute("account", userModel.getAccount());
		httpModel.setAttribute("org_name", userModel.getAosOrgPO().getName());
		httpModel.setAttribute("welcome_msg", getWelcomeMsg());
		httpModel.setAttribute("date", AOSUtils.getDateStr());
		httpModel.setAttribute("week", AOSUtils.getWeekDayByDate(AOSUtils.getDateStr()));
		httpModel.setAttribute("main_text_color", AOSCxt.getDicDesc("main_text_color", userModel.getSkin()));
		httpModel.setAttribute("nav_text_color", AOSCxt.getDicDesc("nav_text_color", userModel.getSkin()));
		httpModel.setAttribute("page_load_msg", AOSCxt.getParam("page_load_msg"));
		httpModel.setAttribute("run_mode", AOSCxt.getParam("run_mode"));
		httpModel.setAttribute("page_load_gif", AOSCxt.getParam("page_load_gif"));
		httpModel.setAttribute("navDto", initNavBarStyle(userModel.getSkin()));
		httpModel.setAttribute("qq_group_link", AOSCxt.getParam("qq_group_link"));

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
			httpModel.setAttribute("proj_name", "当前项目："+proj_name);
		}



		httpModel.setViewPath("index.jsp");
	}
	/**
	 * Portal页面初始化
	 * 
	 * @param httpModel
	 * @return
	 */
	public void initRePortal(HttpModel httpModel) {
		UserModel userModel = httpModel.getUserModel();
		Dto inDto = httpModel.getInDto();
		Dto outDto =Dtos.newDto();
		inDto.put("handler_user_id", userModel.getId());
		inDto.put("create_time", inDto.getString("date"));
		String queryMonth = inDto.getString("date");
		int year = Integer.valueOf(queryMonth.substring(0, 4));
		int month = Integer.valueOf(queryMonth.substring(5, 7));
		int day = AOSUtils.getDaysInMonth(year, month);
		String plan_begin_time = queryMonth + "-01";
		String plan_end_time = queryMonth + "-"+day;
		inDto.put("plan_begin_time", plan_begin_time);
		inDto.put("plan_end_time", plan_end_time);
		httpModel.setAttribute("plan_begin_time", plan_begin_time);
		httpModel.setAttribute("plan_end_time", plan_end_time);
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		httpModel.setAttribute("curSkin", userModel.getSkin());
		httpModel.setAttribute("run_mode", AOSCxt.getParam("run_mode"));
		httpModel.setAttribute("daily_name", "工作日报_"+httpModel.getUserModel().getName()+"("+httpModel.getUserModel().getId()+")_");
		List<Dto>TaskTipList = sqlDao.list("Home.queryTaskTip", inDto);
		//      List<Dto>qaPinsList = sqlDao.list("Home.queryQaPins", inDto);
		//		List<Dto>sjWwcgzlList = sqlDao.list("Home.queryByWwcgzl", inDto);
		//		double wwcgzl=0.0;
		//		if(sjWwcgzlList.size()==1&&null==sjWwcgzlList.get(0)||sjWwcgzlList.size()==0){
		//			outDto.put("sjwwcgzl",wwcgzl);
		//			outDto.put("jhwwcgzl",wwcgzl);
		//		}else{
		//			outDto.put("sjwwcgzl", sjWwcgzlList.get(0).getBigDecimal("sjwwcgzl").doubleValue());
		//			outDto.put("jhwwcgzl", sjWwcgzlList.get(0).getBigDecimal("jhwwcgzl").doubleValue());
		//		}
		outDto.put("yfb", TaskTipList.get(0).get("yfb"));
		outDto.put("yjs",TaskTipList.get(0).get("yjs"));
		outDto.put("ywc", TaskTipList.get(0).get("ywc"));
		outDto.put("ygb", TaskTipList.get(0).get("ygb"));
		outDto.put("jhgzl", TaskTipList.get(0).get("jhgzl"));
		outDto.put("sjgzl", TaskTipList.get(0).get("sjgzl"));
//		if(TaskTipList.get(0).get("sjgzl") == null){
//			outDto.put("sjgzl", 0);
//		}else{
//			outDto.put("sjgzl", TaskTipList.get(0).get("sjgzl"));
//		}
//		double psgzl=0.0;
//		if(qaPinsList.size()>0){
//			psgzl=qaPinsList.get(0).getBigDecimal("psgzl").doubleValue();
//
//		}else{
//			psgzl=0.0;
//		}
//		outDto.put("jhgzl", String.format("%.1f",TaskTipList.get(0).getBigDecimal("jhgzl").doubleValue()+psgzl));
//		outDto.put("sjgzl", String.format("%.1f",TaskTipList.get(0).getBigDecimal("sjgzl").doubleValue()+psgzl));
		httpModel.setAttribute("sysdate", inDto.getString("create_time"));
		httpModel.setOutMsg(AOSJson.toJson(outDto));
	}

	/**
	 * Portal页面初始化
	 * 
	 * @param httpModel
	 * @return
	 * @throws ParseException 
	 */
	public void initPortal(HttpModel httpModel) throws ParseException {
		UserModel userModel = httpModel.getUserModel();
		Dto inDto = httpModel.getInDto();
		//日报名称拼接
		String name_report = "工作日报_" + httpModel.getUserModel().getName() + "("
				+ httpModel.getUserModel().getId() + ")_";
		httpModel.setAttribute("name_report", name_report);
		inDto.put("handler_user_id", userModel.getId());
		SimpleDateFormat fa=new SimpleDateFormat("YYYY-MM");
		if(AOSUtils.isEmpty(inDto.getString("date"))){
			inDto.put("create_time", fa.format(new Date()));
		}else{
			inDto.put("create_time", inDto.getString("date"));
		}
		String queryMonth = inDto.getString("create_time");
		int years = Integer.valueOf(queryMonth.substring(0, 4));
		int months = Integer.valueOf(queryMonth.substring(5, 7));
		int day = AOSUtils.getDaysInMonth(years, months);
		String plan_begin_time = queryMonth + "-01";
		String plan_end_time = queryMonth + "-"+day;
		inDto.put("plan_begin_time", plan_begin_time);
		inDto.put("plan_end_time", plan_end_time);
		httpModel.setAttribute("plan_begin_time", plan_begin_time);
		httpModel.setAttribute("plan_end_time", plan_end_time);
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		httpModel.setAttribute("curSkin", userModel.getSkin());
		httpModel.setAttribute("run_mode", AOSCxt.getParam("run_mode"));
		httpModel.setAttribute("daily_name", "工作日报_"+httpModel.getUserModel().getName()+"("+httpModel.getUserModel().getId()+")_");
		List<Dto>TaskTipList = sqlDao.list("Home.queryTaskTip", inDto);
		List<Dto>qaPinsList = sqlDao.list("Home.queryQaPins", inDto);
		//取任务log表中出本月外最新的历史纪录
		//		List<Dto>historyJlList = sqlDao.list("Home.queryWwcgzl", inDto);
		//查询本月的状态为1003最新的百分比
		//		List<Dto>sjWwcgzlList = sqlDao.list("Home.queryByWwcgzl", inDto);
		//		double wwcgzl=0.0;
		//		if(sjWwcgzlList.size()==1&&null==sjWwcgzlList.get(0)||sjWwcgzlList.size()==0){
		//			httpModel.setAttribute("sjwwcgzl",wwcgzl);
		//			httpModel.setAttribute("jhwwcgzl",wwcgzl);
		//		}else{
		//			httpModel.setAttribute("sjwwcgzl", sjWwcgzlList.get(0).getBigDecimal("sjwwcgzl").doubleValue());
		//			httpModel.setAttribute("jhwwcgzl", sjWwcgzlList.get(0).getBigDecimal("jhwwcgzl").doubleValue());
		//		}
		httpModel.setAttribute("yfb", TaskTipList.get(0).get("yfb"));
		httpModel.setAttribute("yjs",TaskTipList.get(0).get("yjs"));
		httpModel.setAttribute("ywc", TaskTipList.get(0).get("ywc"));
		httpModel.setAttribute("ygb", TaskTipList.get(0).get("ygb"));
		//		Dto outDto =Dtos.newDto();
		double psgzl=0.0;
		if(qaPinsList.size()>0){
			psgzl=qaPinsList.get(0).getBigDecimal("psgzl").doubleValue();
			httpModel.setAttribute("psgzl", psgzl);

		}else{
			psgzl=0.0;
			httpModel.setAttribute("psgzl", 0);
		}

		int person_id = httpModel.getUserModel().getId();
		Dto outDto_proj=Dtos.newDto();
		outDto_proj.put("person_id", person_id);
		List<Dto>pList = sqlDao.list("DailyReportDao.SelectDefaultProject", outDto_proj);
		String proj_id="";
		if(pList.size()!=0){
			proj_id=pList.get(0).getString("proj_id");
		}
//		httpModel.setAttribute("jhgzl", TaskTipList.get(0).getBigDecimal("jhgzl").doubleValue()+psgzl);
//		httpModel.setAttribute("sjgzl", TaskTipList.get(0).getBigDecimal("sjgzl").doubleValue()+psgzl);
		httpModel.setAttribute("jhgzl", TaskTipList.get(0).get("jhgzl"));
//		if(TaskTipList.get(0).get("sjgzl") == null){
//			httpModel.setAttribute("sjgzl", 0);
//		}else{
//			httpModel.setAttribute("sjgzl", TaskTipList.get(0).get("sjgzl"));
//		}
		httpModel.setAttribute("sjgzl", TaskTipList.get(0).get("sjgzl"));
		httpModel.setAttribute("sysdate", inDto.getString("create_time"));
		httpModel.setAttribute("proj_id__",proj_id);
		httpModel.setViewPath("system/portal.jsp");

		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String dateString = formatter.format(AOSUtils.getDateTime());
		int year = Integer.valueOf(dateString.substring(0, 4));
		int month = Integer.valueOf(dateString.substring(5, 7));
		if (month == 1) {
			int str = year - 1;
			String recently_begin_date1 = str + "-12-01";
			String recently_end_date1 = str + "-12-31";
			httpModel.setAttribute("recently_begin_date", recently_begin_date1);
			httpModel.setAttribute("recently_end_date", recently_end_date1);
		} else {
			String str1 = String.format("%02d", month - 1);
			String recently_begin_date = year + "-" + (str1) + "-" + "01";
			int recently_day = AOSUtils.getDaysInMonth(year, month - 1);
			String recently_end_date = year + "-" + (str1) + "-" + recently_day;
			httpModel.setAttribute("recently_begin_date", recently_begin_date);
			httpModel.setAttribute("recently_end_date", recently_end_date);
		}
		;
		// 本周
		Calendar cal = Calendar.getInstance();
		cal.setTime(new SimpleDateFormat("yyyy-MM-dd").parse(dateString));
		int d = 0;
		if (cal.get(Calendar.DAY_OF_WEEK) == 1) {
			d = -6;
		} else {
			d = 2 - cal.get(Calendar.DAY_OF_WEEK);
		}
		cal.add(Calendar.DAY_OF_WEEK, d);
		cal.add(Calendar.DAY_OF_WEEK, 6);
		// 所在周结束日期
		String week_end_date = new SimpleDateFormat("yyyy-MM-dd").format(cal
				.getTime());

		Calendar preWeekMondayCal = Calendar.getInstance();
		//设置时间成本周第一天(周日)
		preWeekMondayCal.set(Calendar.DAY_OF_WEEK,1);
		//上周一时间
		preWeekMondayCal.add(Calendar.DATE, -6);
		//转化为日期
		String preWeekMonday = new SimpleDateFormat("yyyy-MM-dd").format(preWeekMondayCal.getTime());
		httpModel.setAttribute("preWeekMonday", preWeekMonday);
		httpModel.setAttribute("week_end_date", week_end_date);


	}
	/**
	 * 用户登录
	 * 
	 * @param httpModel
	 * @return
	 */
	public void login(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		Dto outDto = Dtos.newDto();
		outDto.setAppCode(AOSCons.SUCCESS);
		String is_show_vercode_ = AOSCxt.getParam("is_show_vercode");
		// 配置为无验证码机制则跳过验证
		if (StringUtils.equals(is_show_vercode_, SystemCons.IS.YES)) {
			String cached_vercode_ = JedisUtil.getString(inDto.getString("vercode_uuid"));
			if (!StringUtils.equalsIgnoreCase(cached_vercode_, inDto.getString("vercode"))) {
				outDto.setAppCode(ErrorCode.VERCODE_ERROR);
				outDto.setAppMsg("验证码不对，请重新输入。");
				httpModel.setOutMsg(AOSJson.toJson(outDto));
				return;
			}
		}
		// 帐号存在校验
		Dto qDto = Dtos.newDto("account", inDto.getString("account"));
		qDto.put("is_del", SystemCons.IS.NO);
		AosUserPO aosUserPO = aosUserDao.selectOne(qDto);
		Boolean is_pass = true;
		if (AOSUtils.isEmpty(aosUserPO)) {
			outDto.setAppCode(ErrorCode.ACCOUNT_ERROR);
			outDto.setAppMsg("帐号输入错误，请重新输入。");
			is_pass = false;
		} else {
			// 密码校验
			String password = AOSCodec.password(inDto.getString("password"));
			if (!StringUtils.equals(password, aosUserPO.getPassword())) {
				outDto.setAppCode(ErrorCode.PASSWORD_ERROR);
				outDto.setAppMsg("密码输入错误，请重新输入。");
				is_pass = false;
			} else {
				// 状态校验
				if (!aosUserPO.getStatus().equals(SystemCons.USER_STATUS.NORMAL)) {
					outDto.setAppCode(ErrorCode.LOCKED_ERROR);
					outDto.setAppMsg("该帐号已锁定或已停用，请联系管理员。");
					is_pass = false;
				}
			}
		}

		if (!is_pass) {
			httpModel.setOutMsg(AOSJson.toJson(outDto));
			return;
		}

		// 通过检查
		outDto.setAppCode(AOSCons.SUCCESS);
		String juid = cacheUserDataService.login(aosUserPO, httpModel.getRequest());
		outDto.put("juid", juid);
		httpModel.setOutMsg(AOSJson.toJson(outDto));

	}

	/**
	 * 开发用户快捷登录
	 * 
	 * @param httpModel
	 * @return
	 */
	public void loginDev(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		Dto outDto = Dtos.newOutDto();
		AosUserPO aosUserPO = aosUserDao.selectOne(Dtos.newDto("account", inDto.getString("account")));
		outDto.setAppCode(AOSCons.SUCCESS);
		String juid = cacheUserDataService.login(aosUserPO, httpModel.getRequest());
		outDto.put("juid", juid);
		httpModel.setOutMsg(AOSJson.toJson(outDto));
	}

	/**
	 * 用户注销
	 * 
	 * @param httpModel
	 * @return
	 */
	public void logout(HttpModel httpModel) {
		String juid = httpModel.getInDto().getString("juid");
		if (AOSUtils.isNotEmpty(juid)) {
			logger.info(AOSUtils.merge("用户[{0}]成功注销。", httpModel.getUserModel().getName()));
			cacheUserDataService.logout(juid);
		}
	}

	/**
	 * 获取用户卡片菜单
	 * 
	 * @param inDto
	 * @return
	 */
	private List<Dto> getCardListFromCache(Integer user_id_) {
		final String cacheKey = SystemCons.KEYS.CARDLIST + user_id_;
		List<Dto> cardList = Lists.newArrayList();
		String cardListJson = JedisUtil.getString(cacheKey);
		if (AOSUtils.isNotEmpty(cardListJson)) {
			List<Map<String, String>> cardMapList = AOSJson.fromJson(cardListJson,
					new TypeToken<List<Map<String, String>>>() {
			}.getType());
			for (Map<String, String> map : cardMapList) {
				cardList.add(Dtos.newDto(map));
			}
		} else {
			Dto qDto = Dtos.newDto();
			qDto.put("user_id", user_id_);
			qDto.put("grant_type", SystemCons.GRANT_TYPE.BIZ);
			// 取CASCADE_ID长度为5的菜单出来作为卡片
			qDto.put("length", '5');
			//			qDto.put("is_leaf", '0');
			qDto.put("fnLength", DBDialectUtils.fnLength(sqlDao.getDatabaseId()));
			cardList = sqlDao.list("Home.selectModulesOfUser", qDto);
			if (AOSUtils.isNotEmpty(cardList)) {
				JedisUtil.setString(cacheKey, AOSJson.toJson(cardList), 0);
			}
		}
		return cardList;
	}

	/**
	 * 获取卡片导航菜单树
	 * 
	 * @param inDto
	 * @return
	 */
	public void getCardTree(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		Integer user_id_ = httpModel.getUserModel().getId();
		String cascade_id_ = inDto.getString("cascade_id");
		String cardTree = null;
		// 每个用户会有多个卡片树
		final String cacheKey = SystemCons.KEYS.CARD_TREE + user_id_ + "." + cascade_id_;
		List<Dto> moduleList = null;
		cardTree = JedisUtil.getString(cacheKey);
		if (AOSUtils.isEmpty(cardTree)) {
			Dto qDto = Dtos.newDto();
			qDto.put("user_id", user_id_);
			qDto.put("grant_type", SystemCons.GRANT_TYPE.BIZ);
			qDto.put("cascade_id", cascade_id_);
			qDto.put("is_leaf", '1');
			moduleList = sqlDao.list("Home.selectModulesOfUser", qDto);
			if (AOSUtils.isNotEmpty(moduleList)) {
				cardTree = SystemUtils.toTreeModalAllInOne(moduleList);
				JedisUtil.setString(cacheKey, cardTree, 0);
			}
		}
		httpModel.setOutMsg(cardTree);
	}

	/**
	 * 获取卡片导航菜单树
	 * 
	 * @param inDto
	 * @return
	 */
	public void getCardTreeCollect(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		Integer user_id_ = httpModel.getUserModel().getId();
		String cascade_id_ = inDto.getString("cascade_id");
		String cardTree = null;
		// 每个用户会有多个卡片树
		List<Dto> moduleList = null;
		if (AOSUtils.isEmpty(cardTree)) {
			Dto qDto = Dtos.newDto();
			qDto.put("user_id", user_id_);
			qDto.put("grant_type", SystemCons.GRANT_TYPE.BIZ);
			qDto.put("cascade_id", cascade_id_);
			moduleList = sqlDao.list("Home.selectCollectModulesOfUser", qDto);
			if (AOSUtils.isNotEmpty(moduleList)) {
				cardTree = SystemUtils.toTreeModalAllInOne(moduleList);
			}
		}
		httpModel.setOutMsg(cardTree);
	}

	/**
	 * 获取首选项页面的用户初始信息
	 * 
	 * @param inDto
	 * @return
	 */
	public void getUser(HttpModel httpModel) {
		AosUserPO aosUserPO = aosUserDao.selectByKey(httpModel.getUserModel().getId());
		aosUserPO.setPassword(StringUtils.EMPTY);
		Dto outDto = aosUserPO.toDto();
		outDto.put("org_name", httpModel.getUserModel().getAosOrgPO().getName());
		httpModel.setOutMsg(AOSJson.toJson(outDto));
	}

	/**
	 * 修改我的个人资料信息
	 * 
	 * @param httpModel
	 * @return
	 */
	public void updateMyInfo(HttpModel httpModel) {
		Dto outDto = Dtos.newOutDto();
		Dto inDto = httpModel.getInDto();
		AosUserPO aosUserPO = new AosUserPO();
		aosUserPO.copyProperties(inDto);
		aosUserPO.setId(httpModel.getUserModel().getId());
		aosUserDao.updateByKey(aosUserPO);
		if (!StringUtils.equals(aosUserPO.getSkin(), httpModel.getUserModel().getSkin())) {
			outDto.put("is_skin_changed", AOSCons.YES);
		}
		UserModel userModel = httpModel.getUserModel();
		AOSUtils.copyProperties(aosUserDao.selectByKey(aosUserPO.getId()), userModel);
		cacheUserDataService.cacheUserModel(userModel);
		outDto.setAppMsg("我的个人资料数据保存成功。");
		httpModel.setOutMsg(AOSJson.toJson(outDto));
	}

	/**
	 * 修改我的个人密码
	 * 
	 * @param httpModel
	 * @return
	 */
	public void updateMyPwd(HttpModel httpModel) {
		Dto outDto = Dtos.newOutDto();
		Dto inDto = httpModel.getInDto();
		if (!StringUtils.equals(inDto.getString("confirm_new_password"), inDto.getString("new_password"))) {
			outDto.setAppCode(AOSCons.NO);
			outDto.setAppMsg("两次密码输入不一致，请确认。");
		} else {
			AosUserPO aosUserPO = aosUserDao.selectByKey(httpModel.getUserModel().getId());
			if (!StringUtils.equals(aosUserPO.getPassword(), AOSCodec.password(inDto.getString("password")))) {
				outDto.setAppCode(AOSCons.NO);
				outDto.setAppMsg("原密码输入错误，请确认。");
			} else {
				aosUserPO.setPassword(AOSCodec.password(inDto.getString("new_password")));
				aosUserDao.updateByKey(aosUserPO);
				outDto.setAppMsg("密码修改成功。");
			}
		}
		httpModel.setOutMsg(AOSJson.toJson(outDto));
	}

	/**
	 * 计算水平导航条、banner右侧注销等按钮样式风格
	 * 
	 * @param curSkin
	 * @return
	 */
	private Dto initNavBarStyle(String curSkin) {
		Dto navDto = Dtos.newDto();
		navDto.put("is_show_top_nav", AOSCxt.getParam("is_show_top_nav"));
		String nav_button_style_ = AOSCxt.getParam("nav_button_style");
		navDto.put("nav_button_style", nav_button_style_);
		String nav_bar_style = StringUtils.EMPTY;
		String nav_bar_style_visited = StringUtils.EMPTY;
		String right_button_style = StringUtils.EMPTY;
		// 根据SKIN和navbar_btn_style_来判断
		if (curSkin.equalsIgnoreCase(AOSCons.SKIN.BLUE)) {
			if (nav_button_style_.equalsIgnoreCase("tight")) {
				nav_bar_style = "button button-pill button-border-blue";
				nav_bar_style_visited = "button button-pill button-border-blue button-border-blue-visited";
				right_button_style = "button-small button-pill button-small-blue";
			} else if (nav_button_style_.equalsIgnoreCase("standalone")) {
				nav_bar_style = "button button-rounded button-border-blue";
				nav_bar_style_visited = "button button-rounded button-border-blue button-border-blue-visited";
				right_button_style = "button-small button-rounded button-small-blue";
			}
		} else if (curSkin.equalsIgnoreCase(AOSCons.SKIN.GRAY)) {
			if (nav_button_style_.equalsIgnoreCase("tight")) {
				nav_bar_style = "button button-pill button-border-gray";
				nav_bar_style_visited = "button button-pill button-border-gray button-border-gray-visited";
				right_button_style = "button-small button-pill button-small-gray";
			} else if (nav_button_style_.equalsIgnoreCase("standalone")) {
				nav_bar_style = "button button-rounded button-border-gray";
				nav_bar_style_visited = "button button-rounded button-border-gray button-border-gray-visited";
				right_button_style = "button-small button-rounded button-small-gray";
			}
		}
		navDto.put("nav_bar_style", nav_bar_style);
		navDto.put("nav_bar_style_visited", nav_bar_style_visited);
		navDto.put("right_button_style", right_button_style);
		return navDto;
	}

	/**
	 * 生成问候信息
	 * 
	 * @return
	 */
	private String getWelcomeMsg() {
		String welcome = "晚上好";
		Integer timeInteger = new Integer(AOSUtils.getDateTimeStr("HH"));
		if (timeInteger.intValue() >= 7 && timeInteger.intValue() <= 12) {
			welcome = "上午好";
		} else if (timeInteger.intValue() > 12 && timeInteger.intValue() < 19) {
			welcome = "下午好";
		}
		return welcome;
	}

	/**
	 * 某项目组成员所在所有项目的工作量
	 * 
	 * 
	 * 
	 */
	public void initRe(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		//		if(inDto.getString("checked").equals("true")){
		//			inDto.put("check", "1");
		//		}else{
		//			inDto.put("check", "");
		//		}
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		httpModel.setAttribute("proj_id", httpModel.getInDto().getString("proj_id"));
		List<Dto> oneList = new ArrayList();
		List<Dto> userList = new ArrayList();
		//		 inDto.put("handler_user_id", httpModel.getUserModel().getId());
		//查询项目经理id
		List<Dto>pmList=sqlDao.list("Home.queryYoNPm",inDto);
		Dto newDto=Dtos.newDto();
		String pmname="";
		//如果是项目经理，查询对应的项目Id和名字
		for(int a=0;a<pmList.size();a++){
			newDto=pmList.get(a);
			pmname=newDto.getString("name");
			inDto.put("pmname", pmname);
		}
		List<Dto> projWwcList = sqlDao.list("Home.queryProjYON",inDto);
		List<Dto> percent = sqlDao.list("Home.queryTaskPercent",inDto);
		if(projWwcList.size()==0||projWwcList.get(0)==null){
			httpModel.setAttribute("wwc", 0);
		}else{
			httpModel.setAttribute("wwc",  projWwcList.get(0).get("wwc"));
		}
		if(percent.size()==0||percent.get(0)==null){
			httpModel.setAttribute("percent", 0);
			httpModel.setAttribute("total",  0);
		}else{
			httpModel.setAttribute("percent",  percent.get(0).get("percent"));
			httpModel.setAttribute("total",  percent.get(0).get("total"));
		}
		//查询项目经理组下成员id,分组名字name
		List<Dto>pmUserList=sqlDao.list("Home.queryPm2User", newDto);

		String handler_user_id="";
		Dto pmUserDto=Dtos.newDto();
		Dto countUserDto=Dtos.newDto();
		for(int a=0;a<pmUserList.size();a++){
			pmUserDto=pmUserList.get(a);
			handler_user_id=pmUserDto.getString("team_user_id");
			inDto.put("handler_user_id", handler_user_id);
			List<Dto> countList = sqlDao.list("Home.queryPmReUser",inDto);
			List<Dto> countTaList = sqlDao.list("Home.queryYnoTask",inDto);
			if(countTaList.size()>0){
				for(int b=0;b<countList.size();b++){
					countUserDto=countList.get(b);
					countUserDto.put("name", countUserDto.getString("name")
							+" "+"(总工作量:"+countUserDto.getString("task_amount")+" "+"总任务数:"
							+countUserDto.getString("task_total")+" "+"总完成数:"+countUserDto.getString("task_success")+" "+"未完成数:"+countUserDto.getString("task_undo")+")") ;
				}
			}else{
				continue;
			}

			List<Dto> faPOs_next = sqlDao.list("Home.TaskShow_ReList",inDto);
			if(faPOs_next.size()>0){
				countUserDto.put("faPO", faPOs_next);
				userList.add(countUserDto);
			}


		}
		List<Dto>projNameList=sqlDao.list("Home.queryProjName", inDto);
		httpModel.setAttribute("proj_name", projNameList.get(0).getString("proj_name"));
		httpModel.setAttribute("userList", userList);
		httpModel.setAttribute("pmname", inDto.getString("pmname"));
		httpModel.setViewPath("pmUserAllTask_list.jsp");
	}
	/**
	 * 工作台欢迎项目基本信息，分析项目组员一览表按年月查
	 * 
	 * 
	 * 
	 */
	public void initMonthChange(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		Dto outDto=Dtos.newDto();
		List<Dto>arryList=new ArrayList();
		httpModel.setAttribute("juid", inDto.getString("juid"));
		httpModel.setAttribute("proj_id", inDto.getString("proj_id"));
		List<Dto> oneList = new ArrayList();
		List<Dto> userList = new ArrayList();
		//查询项目经理id
		List<Dto>pmList=sqlDao.list("Home.queryYoNPm",inDto);
		Dto newDto=Dtos.newDto();
		String pmname="";
		//如果是项目经理，查询对应的项目Id和名字
		for(int a=0;a<pmList.size();a++){
			newDto=pmList.get(a);
			pmname=newDto.getString("name");
			inDto.put("pmname", pmname);
		}
		List<Dto> projWwcList = sqlDao.list("Home.queryProjYON",inDto);
		List<Dto> percent = sqlDao.list("Home.queryTaskPercent",inDto);
		if(projWwcList.size()==0||projWwcList.get(0)==null){
			outDto.put("wwc",  0);
		}else{
			outDto.put("wwc",  projWwcList.get(0).get("wwc"));
		}
		if(percent.size()==0||percent.get(0)==null){
			outDto.put("percent",  0);
			outDto.put("total",  0);
		}else{
			outDto.put("percent",  percent.get(0).get("percent"));
			outDto.put("total",  percent.get(0).get("total"));
		}
		//查询项目经理组下成员id,分组名字name
		List<Dto>pmUserList=sqlDao.list("Home.queryPm2User", newDto);
		String handler_user_id="";
		Dto pmUserDto=Dtos.newDto();
		for(int a=0;a<pmUserList.size();a++){
			pmUserDto=pmUserList.get(a);
			handler_user_id=pmUserDto.getString("team_user_id");
			inDto.put("handler_user_id", handler_user_id);
			List<Dto> faPOs_next = sqlDao.list("Home.TaskShow_List",inDto);
			if(faPOs_next.size()>0){
				pmUserDto.put("faPO", faPOs_next);
				pmUserDto.put("name", pmUserDto.getString("name")+"-"+pmUserDto.getString("team_user_id"));
				userList.add(pmUserDto);
			}
		}
		List<Dto>projNameList=sqlDao.list("Home.queryProjName", inDto);
		arryList.add(pmUserDto);
		arryList.add(outDto);
		httpModel.setOutMsg(AOSJson.toJson(arryList));
	}
	/**
	 * 工作台欢迎项目基本信息，分析项目组员一览表
	 * 
	 * 
	 * 
	 */
	public void init(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String proj_id = inDto.getString("proj_id");
		String proj_name = inDto.getString("proj_name");
		inDto.put("proj_name", proj_name);
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		httpModel.setAttribute("proj_id", httpModel.getInDto().getString("proj_id"));
		List<Dto> oneList = new ArrayList();
		List<Dto> userList = new ArrayList();
		//查询项目经理id
		List<Dto>pmList=sqlDao.list("Home.queryYoNPm",inDto);
		Dto newDto=Dtos.newDto();
		String pmname="";
		//如果是项目经理，查询对应的项目Id和名字
		for(int a=0;a<pmList.size();a++){
			newDto=pmList.get(a);
			pmname=newDto.getString("name");
			inDto.put("pmname", pmname);
		}
		List<Dto> projWwcList = sqlDao.list("Home.queryProjYON",inDto);
		List<Dto> percent = sqlDao.list("Home.queryTaskPercent",inDto);
		if(projWwcList.size()==0||projWwcList.get(0)==null){
			httpModel.setAttribute("wwc", 0);
		}else{
			httpModel.setAttribute("wwc",  projWwcList.get(0).get("wwc"));
		}
		if(percent.size()==0||percent.get(0)==null){
			httpModel.setAttribute("percent", 0);
			httpModel.setAttribute("total",  0);
		}else{
			httpModel.setAttribute("percent",  percent.get(0).get("percent"));
			httpModel.setAttribute("total",  percent.get(0).get("total"));
		}
		//查询项目经理组下成员id,分组名字name
		List<Dto>pmUserList=sqlDao.list("Home.queryPm2User", newDto);
		String handler_user_id="";
		Dto pmUserDto=Dtos.newDto();
		Dto wwcDto=Dtos.newDto();
		/*for(int a=0;a<pmUserList.size();a++){
			pmUserDto=pmUserList.get(a);
			handler_user_id=pmUserDto.getString("team_user_id");
			inDto.put("handler_user_id", handler_user_id);
			List<Dto> gzlList = sqlDao.list("Home.querySumWcgzl",inDto);
			httpModel.setAttribute("ywcgzl", String.format("%.1f", gzlList.get(0).getBigDecimal("ywcgzl").doubleValue()));
			httpModel.setAttribute("sjwcgzl", String.format("%.1f", gzlList.get(0).getBigDecimal("sjwcgzl").doubleValue()));
			List<Dto> faPOs_next = sqlDao.list("Home.TaskShow_List",inDto);
			List<Dto> wwc_next = sqlDao.list("Home.queryByWwcgzl",inDto);
			if(faPOs_next.size()>0){
				pmUserDto.put("name", pmUserDto.getString("name")+"-"+pmUserDto.getString("team_user_id"));
				if(faPOs_next.size()==1 ){
					if(faPOs_next.get(0).getString("state_name").equals("已完成")){
						wwcDto.put("userid", faPOs_next.get(0).getString("userid")) ;
						wwcDto.put("name", faPOs_next.get(0).getString("name")) ;
						wwcDto.put("proj_name", faPOs_next.get(0).getString("proj_name")) ;
						wwcDto.put("task_amount", 0.0) ;
						wwcDto.put("task_complete", 0.0) ;
						wwcDto.put("task_total", 0) ;
						wwcDto.put("state_name", "未完成") ;
						faPOs_next.add(wwcDto);
					}else if(faPOs_next.get(0).getString("state_name").equals("未完成")){
						//未完成
						if(faPOs_next.get(0).getBigDecimal("task_amount").doubleValue()>0){
							faPOs_next.get(0).put("task_amount", faPOs_next.get(0).getString("task_amount")+"("+String.format("%.1f", wwc_next.get(0).getBigDecimal("jhwwcgzl").doubleValue())+")");
							faPOs_next.get(0).put("task_complete", faPOs_next.get(0).getString("task_complete")+"("+String.format("%.1f", wwc_next.get(0).getBigDecimal("sjwcgzl").doubleValue())+")");
							
						}else{
							wwcDto.put("task_amount", 0.0);
							wwcDto.put("task_complete", 0.0) ;
						}
						wwcDto.put("userid", faPOs_next.get(0).getString("userid")) ;
						wwcDto.put("name", faPOs_next.get(0).getString("name")) ;
						wwcDto.put("proj_name", faPOs_next.get(0).getString("proj_name")) ;
						wwcDto.put("task_total", 0) ;
						wwcDto.put("state_name", "未完成") ;
						wwcDto.put("task_amount", 0.0) ;
						wwcDto.put("task_complete", 0.0) ;
						faPOs_next.add(wwcDto);
					}else{
						wwcDto.put("userid", faPOs_next.get(0).getString("userid")) ;
						wwcDto.put("name", faPOs_next.get(0).getString("name")) ;
						wwcDto.put("proj_name", faPOs_next.get(0).getString("proj_name")) ;
						wwcDto.put("task_amount", 0.0) ;
						wwcDto.put("task_complete", 0.0) ;
						wwcDto.put("task_total", 0) ;
						wwcDto.put("state_name", "暂停") ;
						faPOs_next.add(wwcDto);
					}
					
				}else if(faPOs_next.size()>1){
					for(Dto lDto:faPOs_next){
						if(lDto.getString("state_name").equals("未完成")){
							lDto.put("task_amount", lDto.getString("task_amount")+"("+String.format("%.1f", wwc_next.get(0).getBigDecimal("jhwwcgzl").doubleValue())+")");
							lDto.put("task_complete", lDto.getString("task_complete")+"("+String.format("%.1f", wwc_next.get(0).getBigDecimal("sjwwcgzl").doubleValue())+")");
						}
					}

				}
				userList.add(pmUserDto);
			}

			pmUserDto.put("faPO", faPOs_next);
		}*/
		
		List<Dto>projNameList=sqlDao.list("Home.queryProjName", inDto);
		httpModel.setAttribute("proj_name", projNameList.get(0).getString("proj_name"));
		httpModel.setAttribute("userList", userList);
		httpModel.setAttribute("pmname", inDto.getString("pmname"));
		
		
		
		String queryMonth = inDto.getString("create_time");
		Dto outDto = Dtos.newDto();
		if(AOSUtils.isEmpty(queryMonth) || queryMonth.length() != 7){
			outDto.setAppCode(AOSCons.ERROR);
			outDto.setAppMsg("请选择查询月份,查询月份格式不正确");
			httpModel.setOutMsg(AOSJson.toJson(outDto));
			return;
		}
		
		int year = Integer.valueOf(queryMonth.substring(0, 4));
		int month = Integer.valueOf(queryMonth.substring(5, 7));
		int day = AOSUtils.getDaysInMonth(year, month);
		
		String plan_begin_time = queryMonth + "-01";
		String plan_end_time = queryMonth + "-"+day;
		
		httpModel.setAttribute("plan_begin_time", plan_begin_time);
		httpModel.setAttribute("plan_end_time", plan_end_time);
		httpModel.setViewPath("pm3/task/projectManager_list.jsp");
	}

	public void initMes(HttpModel httpModel) throws ParseException{
		Dto inDto = httpModel.getInDto();
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		httpModel.setAttribute("proj_id", httpModel.getInDto().getString("proj_id"));
		httpModel.setAttribute("proj_name", httpModel.getInDto().getString("proj_name"));
		httpModel.setViewPath("system/moreMes.jsp");
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String dateString = formatter.format(AOSUtils.getDateTime());
		int year = Integer.valueOf(dateString.substring(0, 4));
		int month = Integer.valueOf(dateString.substring(5, 7));
		int day = AOSUtils.getDaysInMonth(year, month);
		String plan_begin_time = dateString.substring(0, 8) + "01";
		String plan_end_time = dateString.substring(0, 8) + day;
		String year_begin_date = dateString.substring(0, 5) + "01-01";
		String year_end_date = dateString.substring(0, 5) + "12-31";
		if (month == 1) {
			int str = year - 1;
			String recently_begin_date1 = str + "-12-01";
			String recently_end_date1 = str + "-12-31";
			httpModel.setAttribute("recently_begin_date", recently_begin_date1);
			httpModel.setAttribute("recently_end_date", recently_end_date1);
		} else {
			String str1 = String.format("%02d", month - 1);
			String recently_begin_date = year + "-" + (str1) + "-" + "01";
			int recently_day = AOSUtils.getDaysInMonth(year, month - 1);
			String recently_end_date = year + "-" + (str1) + "-" + recently_day;
			httpModel.setAttribute("recently_begin_date", recently_begin_date);
			httpModel.setAttribute("recently_end_date", recently_end_date);
		}
		;
		// 本周
		Calendar cal = Calendar.getInstance();
		cal.setTime(new SimpleDateFormat("yyyy-MM-dd").parse(dateString));
		int d = 0;
		if (cal.get(Calendar.DAY_OF_WEEK) == 1) {
			d = -6;
		} else {
			d = 2 - cal.get(Calendar.DAY_OF_WEEK);
		}
		cal.add(Calendar.DAY_OF_WEEK, d);
		// 所在周开始日期
		String week_begin_date = new SimpleDateFormat("yyyy-MM-dd").format(cal
				.getTime());
		cal.add(Calendar.DAY_OF_WEEK, 6);
		// 所在周结束日期
		String week_end_date = new SimpleDateFormat("yyyy-MM-dd").format(cal
				.getTime());
		httpModel.setAttribute("plan_begin_time", plan_begin_time);
		httpModel.setAttribute("plan_end_time", plan_end_time);
		httpModel.setAttribute("today_date", dateString);
		httpModel.setAttribute("year_begin_date", year_begin_date);
		httpModel.setAttribute("year_end_date", year_end_date);
		httpModel.setAttribute("week_begin_date", week_begin_date);
		httpModel.setAttribute("week_end_date", week_end_date);
	}

	/**
	 * 欢迎界面任务成果展
	 * 
	 * 
	 */
	public void initTaskShow(HttpModel httpModel)  throws ParseException{
		Dto inDto = httpModel.getInDto();
		Dto outDto=Dtos.newDto();
		List<Dto> oneList = new ArrayList();
		inDto.put("handler_user_id", httpModel.getUserModel().getId());
		inDto.put("create_time", inDto.getString("date"));
		List<Dto> faPOs_next = sqlDao.list("Home.TaskShow_List",inDto);
		List<Dto> proj_num = sqlDao.list("Home.queryProjNum",inDto);
		List<Dto> percent = sqlDao.list("Home.queryTaskPercent",inDto);
		List<Dto>qaPinsList = sqlDao.list("Home.queryQaPins", inDto);
		for (int j = 0; j < faPOs_next.size();j++) {
			Dto faPO = faPOs_next.get(j);
			faPO.put("rowno", j+1);
			oneList.add(faPO);
		}	
		double psgzl=0.0;
		if(qaPinsList.size()>0){
			psgzl=qaPinsList.get(0).getBigDecimal("psgzl").doubleValue();
		}else{
			psgzl=0.0;
		}
		if(percent.size()==0||percent.get(0)==null){
			httpModel.setAttribute("percent", 0);
			httpModel.setAttribute("total",  0);
		}else{
			httpModel.setAttribute("percent",  percent.get(0).get("percent"));
			httpModel.setAttribute("total",  percent.get(0).get("total"));
		}
		if(proj_num.size()==0){
			httpModel.setAttribute("proj_num",  0);
		}else{
			httpModel.setAttribute("proj_num",  proj_num.size());
		}
		httpModel.setAttribute("faPOss", oneList);
		httpModel.setAttribute("date",  inDto.getString("create_time"));
		httpModel.setAttribute("name",  httpModel.getUserModel().getName());
		httpModel.setAttribute("psgzl",  psgzl);
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		httpModel.setViewPath("achievementShow_list.jsp");

	}
	
	public void personalWorkloadList(HttpModel httpModel){
		
		//设置所属开始时间和结束时间
		Dto inDto = httpModel.getInDto();
		Dto outDto = Dtos.newDto();
		String queryMonth = inDto.getString("date");
		if(AOSUtils.isEmpty(queryMonth) || queryMonth.length() != 7){
			outDto.setAppCode(AOSCons.ERROR);
			outDto.setAppMsg("请选择查询月份,查询月份格式不正确");
			httpModel.setOutMsg(AOSJson.toJson(outDto));
			return;
		}
		//设置当前登录人姓名、部门名称
		Integer user_id = httpModel.getUserModel().getId();
		String user_name = httpModel.getUserModel().getName();
		String org_name = httpModel.getUserModel().getAosOrgPO().getName();
		
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		httpModel.setAttribute("user_id", user_id);
		httpModel.setAttribute("user_name", user_name);
		httpModel.setAttribute("org_name", org_name);
		
		int year = Integer.valueOf(queryMonth.substring(0, 4));
		int month = Integer.valueOf(queryMonth.substring(5, 7));
		int day = AOSUtils.getDaysInMonth(year, month);
		
		String plan_begin_time = queryMonth + "-01";
		String plan_end_time = queryMonth + "-"+day;
		
		httpModel.setAttribute("plan_begin_time", plan_begin_time);
		httpModel.setAttribute("plan_end_time", plan_end_time);
		httpModel.setViewPath("system/workbench/personalWorkloadList.jsp");
	}

	/**
	 * 项目经理工作台
	 * 项目组员任务一览表查询
	 * heying 2020-02-28
	 * @param httpModel
	 */
	public void projWorkloadList(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		Dto outDto = Dtos.newDto();
		if(AOSUtils.isEmpty(inDto.get("proj_id"))){
			outDto.setAppCode(AOSCons.ERROR);
			outDto.setAppMsg("所选项目不能为空");
			httpModel.setOutMsg(AOSJson.toJson(outDto));
			return;
		}
		
		if(AOSUtils.isEmpty(inDto.get("plan_begin_time")) || AOSUtils.isEmpty(inDto.get("plan_end_time"))){
			outDto.setAppCode(AOSCons.ERROR);
			outDto.setAppMsg("查询的开始时间或结束时间不能为空！");
			httpModel.setOutMsg(AOSJson.toJson(outDto));
			return;
		}
		List<Dto> projWorkloadList = sqlDao.list("Home.projWorkloadList",inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(projWorkloadList, inDto.getPageTotal()));
	}
	
	public void projWorkloadSummary(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		Dto outDto = Dtos.newDto();
		if(AOSUtils.isEmpty(inDto.get("proj_id"))){
			outDto.setAppCode(AOSCons.ERROR);
			outDto.setAppMsg("所选项目不能为空");
			httpModel.setOutMsg(AOSJson.toJson(outDto));
			return;
		}
		
		if(AOSUtils.isEmpty(inDto.get("plan_begin_time")) || AOSUtils.isEmpty(inDto.get("plan_end_time"))){
			outDto.setAppCode(AOSCons.ERROR);
			outDto.setAppMsg("查询的开始时间或结束时间不能为空！");
			httpModel.setOutMsg(AOSJson.toJson(outDto));
			return;
		}
		Dto projWorkloadSummary = sqlDao.selectDto("Home.projWorkloadSummary",inDto);
		httpModel.setOutMsg(AOSJson.toJson(projWorkloadSummary));
	}
	
}

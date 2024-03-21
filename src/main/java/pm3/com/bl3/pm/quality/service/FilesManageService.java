package com.bl3.pm.quality.service;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bl3.pm.mongodb.service.MongoDBService;
import com.bl3.pm.process.service.ReportFileManageService;
import com.bl3.pm.quality.dao.FilesManageDao;
import com.bl3.pm.quality.dao.MessageDao;
import com.bl3.pm.quality.dao.QaStorageDao;
import com.bl3.pm.quality.dao.ReplyNewsDao;
import com.bl3.pm.quality.dao.po.FilesManagePO;
import com.bl3.pm.quality.dao.po.MessagePO;
import com.bl3.pm.quality.dao.po.ReplyNewsPO;
import com.mongodb.gridfs.GridFSDBFile;

import aos.framework.core.dao.SqlDao;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.typewrap.Dtos;
import aos.framework.core.utils.AOSJson;
import aos.framework.core.utils.AOSUtils;
import aos.framework.web.router.HttpModel;
import aos.system.common.id.IdService;
import aos.system.common.utils.SystemCons;
import aos.system.dao.AosUploadDao;
import aos.system.dao.po.AosUploadPO;

/**
 * <b>qa_files_manage[qa_files_manage]业务逻辑层</b>
 * 
 * @author Z
 * @date 2017-12-11 22:48:33
 */
 @Service
 public class FilesManageService{
 	@Autowired
	private FilesManageDao filesManageDao;
	@Autowired
	private SqlDao sqlDao;
	@Autowired
	private IdService idService;
	@Autowired
	private QaStorageDao qaStorageDao;
	@Autowired
	private ReplyNewsDao replyNewsDao;
	@Autowired
	private MessageDao messageDao;  
	@Autowired
	private AosUploadDao aosUploadDao; 
	@Autowired
	private MongoDBService mongoDBService;
	@Autowired
	private FilesManageLogsService filesManageLogsService;
	/**
	 * 初始化视图
	 * 
	 * @param httpModel
	 * @return
	 */
	public void init(HttpModel httpModel) {
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		httpModel.setAttribute("initiator", httpModel.getUserModel().getId());
		httpModel.setAttribute("create_names", httpModel.getUserModel().getName());
		if(AOSUtils.isNotEmpty(httpModel.getInDto().getString("manage_code"))){
			httpModel.setAttribute("manage_code", httpModel.getInDto().getString("manage_code"));
		}
		httpModel.setViewPath("pm3/quality/filesManage.jsp");
	}
	
	/**
	 * 项目人员信息查询
	 * 
	 * @param httpModel
	 */
	public void query_aos_user(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("WeeklyStorage.query_aos_user", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(list, inDto.getPageTotal()));
	}
	
	/**
	 * 负责人部门下拉框
	 */
	public void listPrincipalOrg(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("WeeklyStorage.listPrincipalOrg", inDto);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
	
	/**
	 * 项目人员信息查询
	 * 
	 * @param httpModel
	 */
	public void query_aos_user_corp(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("WeeklyStorage.query_aos_user_corp", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(list, inDto.getPageTotal()));
	}
	
	/**
	 * 常用联系人列表
	 * 
	 * @param httpModel
	 */
	public void topContactsPage(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		List<Dto> list = sqlDao.list("WeeklyStorage.topContactsPage", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(list, inDto.getPageTotal()));
	}
	
	
	
	/**
	 * 消息初始化视图
	 * 
	 * @param httpModel
	 * @return
	 */
	public void initmessage(HttpModel httpModel) {
		httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		httpModel.setViewPath("pm3/quality/message/message_layout.jsp");
	}
	
	/**
	 * 获取综合意见信息
	 * @param httpModel
	 */
	public void getreplyNews(HttpModel httpModel){
		Dto dto=httpModel.getInDto();
		Dto inDto=Dtos.newDto();
		Dto obj=sqlDao.selectDto("WeeklyStorage.getpassDaitiel",dto);
		//不通过
		int notpass=obj.getInteger("notpass");
		//通过
		int pass=obj.getInteger("pass");
		//参与人数
		int num=obj.getInteger("num");
		StringBuilder sbd= new StringBuilder();
		sbd.append("参与人数:"+num+",通过:"+pass+",不通过:"+notpass);
		List<Dto>  _userText= qaStorageDao.userText(dto);
		   
		Iterator<Dto> ite=_userText.iterator(); 
		StringBuilder sb=new StringBuilder();
		int indexcode= 1;
		while(ite.hasNext()){
			Dto i=ite.next();
			String s=i.getString("text_note");
			String  index=indexcode +".";
			sb.append("<b>");
			sb.append(i.getString("text_name"));
			Dto pdto=Dtos.newDto();
			pdto.put("text_name", i.getString("text_name"));
			pdto.put("text_code", dto.getString("text_code"));
			Dto pass_falg_= sqlDao.selectDto("WeeklyStorage.getpassDaitieluser",pdto); 
			String pass_flag=pass_falg_.getString("pass_flag");
			if (AOSUtils.isNotEmpty(pass_flag)){
				sb.append("("+pass_flag+")");
			}
			sb.append("</b>");
			sb.append(index);
			sb.append(s);
			sb.append("<br>");
			indexcode++;
		  }
		inDto.put("resut", sb.toString());
		inDto.put("pass_daitil", sbd.toString());
		httpModel.setOutMsg(AOSJson.toJson(inDto));
	}
	 /**
     * 将时间转换为时间戳 ,入参规则 :测试 qa,任务  ta,过程pr,需求re. 
     * @return 21位的订单号。可以用来作为主题类型编码。
     */    
    public  String dateToStamp(String s){
	 	String  getD= AOSUtils.getDateTimeStr("yyyy");
	 	String getD_=getD.substring(2, 4);
	 	String  getD__= AOSUtils.getDateTimeStr("MMddHHmmss");
	 	AOSUtils.random();
	 	AOSUtils.random();
	 	AOSUtils.random();
	 	StringBuilder str=new StringBuilder();
	 	str.append(s);
	 	str.append(getD_);
	 	str.append(getD__);
	 	str.append(AOSUtils.random());
	 	str.append(AOSUtils.random());
        return str.toString();
    }
    /**
	 * 删除
	 * 
	 * @param httpModel
	 * @return
	 */
    @Transactional
	public void onhidedelete(HttpModel httpModel) {
	List<Dto> code= sqlDao.list("WeeklyStorage.selectUpload",httpModel.getInDto().getString("manage_code"));
	Iterator<Dto> it=code.iterator();
	while (it.hasNext()) {
		Dto dtos = (Dto) it.next();
		int fileid= dtos.getInteger("FILEID");
		AosUploadPO dto = new AosUploadPO();
		dto = aosUploadDao.selectByKey(fileid);
		if(AOSUtils.isNotEmpty(dto) && AOSUtils.isNotEmpty(dto.getPath())){
			String path = dto.getPath();
			File file = new File(path);
			file.delete();
		}
		aosUploadDao.deleteByKey(fileid);
	  }
    }
	/**
	 * 删除
	 * 
	 * @param httpModel
	 * @return
	 */
    @Transactional
	public void alldelete(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String[] selectionIds = inDto.getRows();
		for (String id : selectionIds) {
			FilesManagePO filesManagePOs=filesManageDao.selectByKey(Integer.valueOf(id));
			filesManageDao.deleteByKey(Integer.valueOf(id));
			String  Opinion_code   =    filesManagePOs.getOpinion_code();
		    MessagePO  messagePO =new MessagePO();
		    
		    messagePO.setOpinion_code(Opinion_code);
		    //删除消息
			sqlDao.delete("WeeklyStorage.updateFlagByKey",messagePO);
			//删除回复
			sqlDao.delete("WeeklyStorage.updateFlagrelyByKey",messagePO);
			//删除文件
			List<Dto> code= sqlDao.list("WeeklyStorage.selectUpload",filesManagePOs.getManage_code());
			
			Iterator<Dto> it=code.iterator();
			while (it.hasNext()) {
				Dto dtos = (Dto) it.next();
				int fileid= dtos.getInteger("FILEID");
				AosUploadPO dto = new AosUploadPO();
				dto = aosUploadDao.selectByKey(fileid);
				if(AOSUtils.isNotEmpty(dto) && AOSUtils.isNotEmpty(dto.getPath())){
					String path = dto.getPath();
					File file = new File(path);
					file.delete();
				}
				aosUploadDao.deleteByKey(fileid);
			}
			
		}
		httpModel.setOutMsg("删除成功");
	}
	/**
	 * 
	 * panel 数据
	 * @param httpModel
	 */
	public void  paneldata(HttpModel httpModel){
	Dto inDto = httpModel.getInDto();
	MessagePO messagePO =new MessagePO();
	messagePO.copyProperties(inDto);
	messagePO.setMsg_state(SystemCons.USER_STATUS.LOCK);
	messageDao.updateByKey(messagePO);
	httpModel.setOutMsg(AOSJson.toJson(inDto));
	}
	
	/**
	 * 
	 * panel 数据
	 * @param httpModel
	 */
	public void  isNoJudeg(HttpModel httpModel){
	Dto inDto = httpModel.getInDto();
	FilesManagePO filesManagePO=(FilesManagePO)sqlDao.selectOne("WeeklyStorage.isNoJudeg",inDto);
	String msg_state="0";
	if( filesManagePO.getManage_end_date()==null){
		msg_state="3";
		httpModel.setOutMsg("线下评审不允许发表意见!");
		return;
	}
	if( Long.valueOf(AOSUtils.date2String(filesManagePO.getManage_end_date(),"yyyyMMddHHmmss"))<=Long.valueOf(AOSUtils.getDateStr("yyyyMMddHHmmss"))){
		msg_state="1";
		httpModel.setOutMsg("评审已结束,不能回复了!");
		return;
	}
	if(filesManagePO.getState_flag().equals("3")){
		msg_state="2";
		httpModel.setOutMsg("评审已经关闭,不能回复了!");
		return;
	}
	inDto.put("msg_state", msg_state);
	httpModel.setOutMsg(AOSJson.toJson(inDto));
	}
	/**
	 * 获取用户回复内容
	 * 
	 * @param httpModel
	 * @return
	 */
	public void initRepanel(HttpModel httpModel) {
		Dto dto=httpModel.getInDto();
		int user_id = httpModel.getUserModel().getId();
		dto.put("user_id", user_id);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		//遍历回复内容
		List<Dto> messagePOs = sqlDao.list("com.bl3.pm.quality.dao.QaStorageDao.listMsgReply", dto);
		for(Dto dtos : messagePOs){
			int msg_id = dtos.getInteger("msg_id");
			int msg_state = dtos.getInteger("msg_state");
			int pass_flag = dtos.getInteger("pass_flag");
			String remarks = dtos.getString("remarks");
			String begin_date = sdf.format(dtos.getDate("begin_date"));
			String end_date = sdf.format(dtos.getDate("end_date"));
			httpModel.setAttribute("message", dtos);
			httpModel.setAttribute("msg_id", msg_id);
			httpModel.setAttribute("msg_state", msg_state);
			httpModel.setAttribute("pass_flag", pass_flag);
			httpModel.setAttribute("remarks",remarks);
			httpModel.setAttribute("begin_date", begin_date);
			httpModel.setAttribute("end_date",end_date);
			httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		}
		//主题内容传入
		httpModel.setViewPath("pm3/quality/replyNews.jsp");
	}
	/**
	 * 会议信息确认变更状态
	 */
	public void changeMsgState(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		sqlDao.update("com.bl3.pm.quality.dao.FilesManageDao.selectMsg", inDto);
		httpModel.setOutMsg("确认成功");
	}
	
	/**
	 * 拒绝会议状态
	 * @param httpModel
	 */
	public void changeRefuseState(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		sqlDao.update("com.bl3.pm.quality.dao.FilesManageDao.changeRefuseState", inDto);
		httpModel.setOutMsg("已拒绝该会议");
	}
	
	/**
	 * 点击会议主题进入会议详情
	 * 
	 * @param httpModel
	 */
	public void initMsgIdView(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		//遍历回复内容
		List<Dto> messagePOs=sqlDao.list("com.bl3.pm.quality.dao.FilesManageDao.selectManageID", inDto);
		for(Dto dtos : messagePOs){
			int msg_id = dtos.getInteger("msg_id");
			int msg_state = dtos.getInteger("msg_state");
			int pass_flag = dtos.getInteger("pass_flag");
			String remarks = dtos.getString("remarks");
			String begin_date = sdf.format(dtos.getDate("begin_date"));
			String end_date = sdf.format(dtos.getDate("end_date"));
			httpModel.setAttribute("message", dtos);
			httpModel.setAttribute("msg_id", msg_id);
			httpModel.setAttribute("msg_state", msg_state);
			httpModel.setAttribute("pass_flag", pass_flag);
			httpModel.setAttribute("remarks",remarks);
			httpModel.setAttribute("begin_date", begin_date);
			httpModel.setAttribute("end_date",end_date);
			httpModel.setAttribute("juid", httpModel.getInDto().getString("juid"));
		}
		//主题内容传入
		httpModel.setViewPath("pm3/quality/replyNews.jsp");
	}
	/**
	 * 获取用户回复内容
	 * 
	 * @param httpModel
	 * @return
	 */
	public void initpanel(HttpModel httpModel) {
		Dto dto=httpModel.getInDto();
		//遍历回复内容
		List<Dto> messagePOs = qaStorageDao.listMsgid(dto);
		Iterator<Dto> it=messagePOs.iterator();
		while (it.hasNext()) {
			Dto messagePO=	it.next();
			int pass_flag= messagePO.getInteger("pass_flag");
			String remarks=messagePO.getString("remarks");
			String opinion_code =  messagePO.getString("opinion_code");
			Dto d=Dtos.newDto();
			d.put("text_code", opinion_code);
			List<Dto> userTx=qaStorageDao.listText(d);
			Iterator<Dto> its =userTx.iterator();
			StringBuilder sb=new StringBuilder();
			while(its.hasNext()) {
				Dto i=its.next();
				sb.append("<font color=\"#3366ff\">"+"#"+i.getString("is_pass")+"#&nbsp&nbsp");
			//	sb.append(i.getString("text_name")+"&nbsp&nbsp");
				sb.append(i.getString("text_date")+"</font>."+"<br>");
				sb.append("&nbsp&nbsp&nbsp&nbsp"+i.getString("text_note")+"<br>");
			}
			httpModel.setAttribute("sb",sb);
			httpModel.setAttribute("Opinion_code",opinion_code);
			httpModel.setAttribute("remarks",remarks);
			httpModel.setAttribute("pass_flag",pass_flag);
			httpModel.setAttribute("juid",dto.getString("juid"));
		}
		//主题内容传入
		httpModel.setViewPath("pm3/quality/replyNews.jsp");
	}
	
	/**
	 * 获取用户回复内容 whx 20180201
	 * @param httpModel
	 */
	public void initpanel2Json(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String opinion_code= inDto.getString("opinion_code");
		
		Dto d=Dtos.newDto();
		d.put("text_code", opinion_code);
		List<Dto> userTx=qaStorageDao.listText(d);
		Iterator<Dto> its =userTx.iterator();
		StringBuilder sb=new StringBuilder();
		while(its.hasNext()) {
			Dto i=its.next();
			sb.append("<font color=\"#3366ff\">"+i.getString("is_pass")+"#&nbsp&nbsp");
			sb.append(i.getString("text_name")+"");
			sb.append(i.getString("text_date")+"</font>."+"<br>");
			sb.append("&nbsp&nbsp&nbsp&nbsp"+i.getString("text_note")+"<br>");
		}
		d.put("sb", sb);
		httpModel.setOutMsg(AOSJson.toJson(d));
	}
	
	/**
	 * 获取页面返回信息
	 */
	public   void  pagereturn(HttpModel httpModel ){
		Dto inDto = httpModel.getInDto();
		httpModel.setOutMsg(AOSJson.toJson(inDto));
	} 
	/**
	 * 参数传递值juid
	 * @param httpModel
	 */
	public   void  returnto(HttpModel httpModel ){
		httpModel.setViewPath("pm3/quality/filesManage.jsp");
	}

	/**
	 * 删除账户信息
	 * 
	 * @param httpModel
	 */
	public void delete(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		filesManageDao.deleteByKey(inDto.getInteger("manage_id"));
		httpModel.setOutMsg("账户信息删除成功");
	}
	
	/**
	 * 回复消息新增保存
	 * 
	 * @param httpModel
	 * @return
	 */
	@Transactional
	public void createUser(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		int  pass_flag= inDto.getInteger("pass_flag");
		String usertx_note= inDto.getString("text_note");
		String opinion_code= inDto.getString("opinion_code");
		if(AOSUtils.isEmpty(pass_flag)){
			httpModel.setOutMsg("请选择是否通过!");
			return;
		}
		if(AOSUtils.isEmpty(usertx_note)){
			httpModel.setOutMsg("内容不能为空!");
			return;
		}
		ReplyNewsPO ReplyNewsPO=new ReplyNewsPO();
		ReplyNewsPO.setText_name(httpModel.getUserModel().getName());
		ReplyNewsPO.setText_name_id(httpModel.getUserModel().getId());
		inDto.put("text_code", opinion_code);
		//获取索引  :AOSList 
		int getMaxIndex_=0;
		if(AOSUtils.isNotEmpty(opinion_code)){
		Integer getMaxIndex =(Integer) sqlDao.selectOne("WeeklyStorage.getMaxIndex",inDto);
		if(getMaxIndex==null){
			getMaxIndex_=1;
		}else{
		    getMaxIndex_ = getMaxIndex+1;
		   }
		}
		//取系统时间
		Date ss_dt=AOSUtils.getDateTime();
		ReplyNewsPO.setText_date(ss_dt); 
		ReplyNewsPO.setText_code(opinion_code);
		ReplyNewsPO.setIs_pass(getMaxIndex_);
		ReplyNewsPO.setText_note(usertx_note);
		ReplyNewsPO.setFlag_id(SystemCons.ROOTNODE_PARENT_ID);
		
		replyNewsDao .insert(ReplyNewsPO);
		//是否通过
		MessagePO messagePO =new MessagePO();
		messagePO.setUser_id(httpModel.getUserModel().getId());
		messagePO.setOpinion_code(inDto.getString("opinion_code"));
		messagePO.setPass_flag(inDto.getInteger("pass_flag"));
		sqlDao.update("WeeklyStorage.updateMessage",messagePO);
		
		Dto d=Dtos.newDto();
		d.put("text_code", opinion_code);
		List<Dto> userTx=qaStorageDao.listText(d);
		Iterator<Dto> its =userTx.iterator();
		StringBuilder sb=new StringBuilder();
		while(its.hasNext()) {
			Dto i=its.next();
			sb.append("<font color=\"#3366ff\">"+i.getString("is_pass")+"#&nbsp&nbsp");
		//	sb.append(i.getString("text_name")+"");
			sb.append(i.getString("text_date")+"</font>."+"<br>");
			sb.append("&nbsp&nbsp&nbsp&nbsp"+i.getString("text_note")+"<br>");
		}
		d.put("sb", sb);
		httpModel.setOutMsg(AOSJson.toJson(d));
	}
	/**
	 * 查询项目人员下拉组件数据
	 * 
	 * @param httpModel
	 * @return
	 */
	public void listComboBoxProjId(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> list = qaStorageDao.listComboBoxProjId(inDto);
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
	
	/**
	 * 查询项目列表自定义下拉组件数据
	 * 
	 * @param httpModel
	 * @return
	 */
	public void listComboBoxUerid(HttpModel httpModel) {
		List<Dto> list = qaStorageDao.listComboBoxUerid();
		httpModel.setOutMsg(AOSJson.toJson(list));
	}
	
	
	/**
	 * 获取消息
	 * 
	 */
	public void getMessage(HttpModel httpModel){
		//Dto inDto = httpModel.getInDto();
		Dto putDto=Dtos.newDto();
		int getId=httpModel.getUserModel().getId();
		      AOSUtils.getDateTimeStr();
		String getName=httpModel.getUserModel().getName();
		putDto.put("user_id", getId);
		putDto.put("flag", SystemCons.GRANT_TYPE.BIZ);
		putDto.put("msg_state", SystemCons.GRANT_TYPE.BIZ);
		String day= AOSUtils.getDateStr("HH");
		String str;
		int dayInt=Integer.parseInt(day);
		if(dayInt>=0 && dayInt <6){
			 str="凌晨好";
		}else if(dayInt>=6 && dayInt <12){
			 str="上午好";
		}else if(dayInt>=12 && dayInt <18){
			 str="下午好";
		}else {
			 str="晚上好";
		}
		List<Dto> getMsg= qaStorageDao.likePageMessage(putDto);
		int i=getMsg.size();
		String msg_="";
		if( i>0){
			 msg_=getName+"用户,"+str+",你有"+i+"条未读消息,请及时阅读，以免漏掉重要信息!!";
		}
		putDto.put("msg", msg_);
		putDto.put("count", i);
		httpModel.setOutMsg(AOSJson.toJson(putDto));;
	}

	//获取编码号
	public void getMange_id(HttpModel httpModel){
		 String qm= dateToStamp("qm");
		 httpModel.setOutMsg(qm);
	}
	
	/**
	 * 新增保存
	 * 
	 * @param httpModel
	 */
	public void importFile(HttpModel httpModel){
		Dto putdto= httpModel.getInDto();
		Integer user_id=httpModel.getUserModel().getId();
		String username=httpModel.getUserModel().getName();
		FilesManagePO filesManagePO=new FilesManagePO();
		filesManagePO.copyProperties(putdto);
		filesManagePO.setCreate_name(httpModel.getUserModel().getId());
		filesManagePO.setCreate_time(AOSUtils.getDateTime());
		String qo= dateToStamp("qo");
		//自定义一个字符串长度填充方法 str(xx，xx);
		filesManagePO.setState_flag(SystemCons.USER_STATUS.NORMAL);
		filesManagePO.setOpinion_code(qo);
		String attende_id=putdto.getString("attende_id");
		String attende_id_=attende_id.replace("[","");
		String _attende_id_=attende_id_.replace("]","");
		String[] str=_attende_id_.split(",");
		List<String> s=new  ArrayList<String>();
		for (int i=0 ; i<str.length;i++) {
			String id=str[i];
		    String id_= id.replaceAll(" ", "");
			System.out.print(str[i]);
			String list = qaStorageDao.returnUserName(Integer.parseInt(id_));
			s.add(list);
		}
		String s_=s.toString();
		String _s_=s_.replace("[","");
		String _s__=_s_.replace("]","");
		        filesManagePO.setAttende_mans(_s__);
				filesManageDao.insert(filesManagePO);
		   httpModel.setOutMsg("新增成功");
		 //记录任务日志
			Dto logsDto = Dtos.newDto("content", username + "于" + AOSUtils.getDateTimeStr() + "新增了" + filesManagePO.getTheme());
			logsDto.put("manage_id", filesManagePO.getManage_id());
			filesManageLogsService.create(user_id, logsDto);
	}
	
	/**
	 * 修改
	 * 
	 * @param httpModel
	 * @return
	 */
	public void update(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		Integer user_id=httpModel.getUserModel().getId();
		String username=httpModel.getUserModel().getName();
		FilesManagePO filesManagePO=new FilesManagePO();
		filesManagePO.copyProperties(inDto);
		filesManagePO.setUpdate_id(httpModel.getUserModel().getId());
		filesManagePO.setUpdate_time(new Date());
		String attende_id=inDto.getString("attende_id");
		
		if(AOSUtils.isNotEmpty(attende_id)){
        String attende_id_=attende_id.replace("[","");
        String _attende_id_=attende_id_.replace("]","");
        String[] str=_attende_id_.split(",");
        List<String> s=new  ArrayList<String>();
        for (int i=0 ; i<str.length;i++) {
        	String id=str[i];
            String id_= id.replaceAll(" ", "");
        	System.out.print(str[i]);
        	String list = qaStorageDao.returnUserName(Integer.parseInt(id_));
        	s.add(list);
      	}
        String s_=s.toString();
        String _s_=s_.replace("[","");
        String _s__=_s_.replace("]","");
        filesManagePO.setAttende_mans(_s__);
		}
		filesManageDao.updateByKey(filesManagePO);
		httpModel.setOutMsg("修改成功");
		//记录任务日志
		Dto logsDto = Dtos.newDto("content", username + "于" + AOSUtils.getDateTimeStr() + "修改了" + filesManagePO.getTheme());
		logsDto.put("manage_id", filesManagePO.getManage_id());
		filesManageLogsService.create(user_id, logsDto);
	}
	
	/**
	 * 修改总结
	 * 
	 * @param httpModel
	 * @return
	 */
	public void update_over(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		FilesManagePO filesManagePO=new FilesManagePO();
		filesManagePO.copyProperties(inDto);
		filesManagePO.setState_flag("3");
		filesManageDao.updateByKey(filesManagePO);
		httpModel.setOutMsg("修改成功");
	}
	/**
	 * 项目查询
	 * 
	 * @param httpModel
	 */
	public void getPoj(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto>  getProjN= qaStorageDao.getProjN();
		httpModel.setOutMsg(AOSJson.toGridJson(getProjN, inDto.getPageTotal()));
	}
	
	/**
	 * 批量评审状态变更
	 *
	 */
	public void ccommitCount(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		String name_=httpModel.getUserModel().getName();
		int id_=httpModel.getUserModel().getId();
		String[] selectionIds = inDto.getRows();
		int num=0;
		for (String manage_id_ : selectionIds) {
			String manage_id__ =manage_id_.replaceAll(" ","" );
			Integer	manage_id= Integer.valueOf(manage_id__);
			FilesManagePO dtoArray=qaStorageDao.listMange(manage_id);
			if(!dtoArray.getState_flag().equals("1")){
				continue;
			}
			//项目ID
			int proj_id = dtoArray.getProj_id();
			//评审说明
			String file_note_=dtoArray.getFile_note();
			//评审状态
			String state_flag=dtoArray.getState_flag();
			//评审编码
			String manage_code=dtoArray.getManage_code();
			//评审主题
			String theme=dtoArray.getTheme();
			//意见编码
			String opinion_code_=dtoArray.getOpinion_code();
			//评审编码
			String manage_code_=dtoArray.getManage_code();
			//获取一个拼接信息
			StringBuilder sb=new StringBuilder();
			Dto dtomc=Dtos.newDto("manin_id",manage_code) ;
			dtomc.put("start", 0);
			dtomc.put("limit", 50);
			List<AosUploadPO> aosUploadPOs = aosUploadDao.list(dtomc);
			Iterator<AosUploadPO> it= aosUploadPOs.iterator();
			num++;
			while (it.hasNext()) {
				AosUploadPO aosUploadPO = (AosUploadPO) it.next();
				aosUploadPO.getTitle();
				aosUploadPO.getFileid();
				aosUploadPO.getFilesize();
			}
			//获取工作量
			FilesManagePO filesManagePO=new FilesManagePO();
			filesManagePO.copyProperties(inDto);
			filesManagePO.setManage_id(manage_id);
			filesManagePO.setInitiator(httpModel.getUserModel().getId());
			filesManagePO.setState_flag(SystemCons.USER_STATUS.LOCK);
			filesManageDao.updateByKey(filesManagePO);
			httpModel.setOutMsg("修改成功");
			 //每个参与人录一条内容
			 String attende_id=dtoArray.getAttende_id();
			 String attende_id_=attende_id.replace("[","");
			 String _attende_id_=attende_id_.replace("]","");
			 String[] str=_attende_id_.split(",");
			 //遍历
			 for (int i=0 ; i<str.length;i++) {
			 	String id=str[i];
			    String id__= id.replaceAll(" ", "");
			 	System.out.print(str[i]);
			 	String list = qaStorageDao.returnUserName(Integer.parseInt(id__));
			 	MessagePO messagePO=new MessagePO();
				messagePO.setCreate_time(AOSUtils.getDateTime());
				messagePO.setCreate_id(id_);
				messagePO.setMsg_note(file_note_);
				messagePO.setMang_id(manage_code_);
				messagePO.setCreate_name(name_);
				messagePO.setMsg_state(SystemCons.USER_STATUS.NORMAL);
				messagePO.setEnd_date(dtoArray.getManage_end_date());
				messagePO.setBegin_date(dtoArray.getManage_begin_date());
				messagePO.setState_flag(state_flag);
				messagePO.setTheme(theme);
				messagePO.setProj_id(proj_id);
				messagePO.setWorkload(dtoArray.getWorkload());
				
				//评审编码
				messagePO.setOpinion_code(opinion_code_);
				messagePO.setUser_id(Integer.parseInt(id__));
				messagePO.setFlag(SystemCons.USER_STATUS.NORMAL);
				messagePO.setRemarks(sb.toString());
				messagePO.setUser_name(list);
				messageDao.insert(messagePO);
			  }
			 Integer user_id=httpModel.getUserModel().getId();
			 String username=httpModel.getUserModel().getName();
			//记录任务日志
			Dto logsDto = Dtos.newDto("content", username + "于" + AOSUtils.getDateTimeStr() + "发起了" + theme);
			logsDto.put("manage_id", filesManagePO.getManage_id());
			filesManageLogsService.create(user_id, logsDto);
		}
		 httpModel.setOutMsg("本次发起成功"+num+"条数据");
		
	}
	
	/**
	 * 撤回
	 * @param httpModel
	 * @throws ParseException
	 */
	public void recall(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		Integer user_id=httpModel.getUserModel().getId();
		String username=httpModel.getUserModel().getName();
		String mang_id = inDto.getString("mang_id");
		filesManageDao.deleteByManageCode(mang_id);
		int manage_id = inDto.getInteger("manage_id");
		FilesManagePO filesManagePO = filesManageDao.selectByKey(manage_id);
		filesManagePO.setRecall_id(httpModel.getUserModel().getId());
		filesManagePO.setRecall_time(AOSUtils.getDateTime());
		filesManagePO.setState_flag("1");
		filesManageDao.updateByKey(filesManagePO);
		httpModel.setOutMsg("撤回成功");
		//记录任务日志
		Dto logsDto = Dtos.newDto("content", username + "于" + AOSUtils.getDateTimeStr() + "撤回了" + filesManagePO.getTheme());
		logsDto.put("manage_id", filesManagePO.getManage_id());
		filesManageLogsService.create(user_id, logsDto);
	}
	
	//获取时间差
	public void  differDate(HttpModel httpModel) throws ParseException{
		Dto inDto = httpModel.getInDto();
		 SimpleDateFormat dt=new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss",Locale.UK);
		 String begin_date=   inDto.getString("begin_date");
		 String end_date =inDto.getString("end_date");
		int getDifferT;
		if( AOSUtils.isNotEmpty(begin_date)&&AOSUtils.isNotEmpty(end_date)){
			 Date begin_date_=dt.parse(begin_date);
			 Date end_date_= dt.parse(end_date);
		getDifferT =getIntervalDays(begin_date_,end_date_);
		httpModel.setOutMsg(String.valueOf(getDifferT));
	    }
		
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
		AosUploadPO po = aosUploadDao.selectByKey(inDto.getInteger("fileid"));
		
		/*****************************
		 * mongoDB 文件上传下载 begin
		 ******************************/
		String manageCode = po.getManage_code();
		if(AOSUtils.isEmpty(manageCode)){
			message="该文件不存在，或者已经被删除！";
        	httpModel.setOutMsg(message);
			return;
		};
		
		GridFSDBFile gfs = mongoDBService.findByFileCode(manageCode);
	
//		String filename = AOSUtils.encodeChineseDownloadFileName(httpModel.getRequest().getHeader("USER-AGENT"), gfs.getFilename());
//		//中文乱码转化
//		response.setHeader("Content-Disposition", "attachment; filename=" + filename + ";");
		try {
			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(po.getTitle(),"UTF-8") + ";");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		BufferedInputStream in;
		ServletOutputStream os = null;
		try {
			in = new BufferedInputStream(gfs.getInputStream());
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
		
		/*****************************
		 * mongoDB 文件上传下载 end
		 ******************************/
		
	}
	
	//批量打包下载
	public void downloadFileByZip(HttpModel httpModel){
		Dto inDto = httpModel.getInDto();
		HttpServletResponse response = httpModel.getResponse();
	//	String load_name = inDto.getString("load_name");
		//把文件压缩成zip包，放在临时目录
		String tempPath = createZipFile(httpModel);
		File file = new File(tempPath);
		String filename = "manageLoadZip" + AOSUtils.getDateTimeStr()+".zip";
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
		Dto inDto = httpModel.getInDto();
		String  fileid=  inDto.getString("fileid");
		//String  load_name=  inDto.getString("load_name");
		Dto dtomc=Dtos.newDto("manin_id",fileid);
		dtomc.put("start", 0);
		dtomc.put("limit", 50);
		List<AosUploadPO> aosUploadPOs = aosUploadDao.list(dtomc);
		Iterator<AosUploadPO> it= aosUploadPOs.iterator();
		String desPath="";
		List<File> pathList = new ArrayList<File>();
		while (it.hasNext()) {
			AosUploadPO aosUploadPO = (AosUploadPO) it.next();
			int fileids=aosUploadPO.getFileid();
		//文件路径
		int index = 0;
			AosUploadPO aosUpaloadPO = aosUploadDao.selectByKey(fileids);
			if (AOSUtils.isEmpty(aosUpaloadPO)) {
				continue;
			}
			pathList.add(index, new File(aosUpaloadPO.getPath()));
			index++;
		}
		
		desPath = httpModel.getRequest().getServletContext().getRealPath("uploaddata") + "/";
		
		// 检查路径是否存在,如果不存在则创建之
		File file = new File(desPath);
		if (!file.exists()) {
			file.mkdir();
		}
		// 文件按天归档
		desPath = desPath + AOSUtils.getDateStr() + "/";
		File file1 = new File(desPath);
		if (!file1.exists()) {
			file1.mkdir();
		}
		 desPath=desPath+"manageZip"+".zip";
		File zipFile = new File(desPath);
		ZipOutputStream zipStream = null;
		FileInputStream zipSource = null;
		BufferedInputStream bufferStream = null;
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

	
	//返回小时数
	public static int getIntervalDays(java.util.Date startDate, java.util.Date endDate){
		long startdate = startDate.getTime();
		long enddate = endDate.getTime();
		long interval = enddate - startdate;
		int intervalday = (int) (interval / (1000 * 60 * 60 ));
		return intervalday;
	}
	/**
	 * 根据ID查询
	 * 
	 * @param httpModel
	 * @return
	 */
	public void get(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		FilesManagePO filesManagePO=filesManageDao.selectByKey(inDto.getInteger("id"));
		httpModel.setOutMsg(AOSJson.toJson(filesManagePO));
	}
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void page(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> filesManagePOs = sqlDao.list("WeeklyStorage.getWeeklyPage",inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(filesManagePOs, inDto.getPageTotal()));
	}
	
	/**
	 * 分页查询
	 * 
	 * @param httpModel
	 */
	public void createMsg(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> filesManagePOs = sqlDao.list("WeeklyStorage.getWeeklyPage",inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(filesManagePOs, inDto.getPageTotal()));
	}
	
	/**
	 * 分页查询
	 * 附件详情
	 * @param httpModel
	 */
	public void meetingAttachmentPage(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> meetingAttachmentList = sqlDao.list("WeeklyStorage.meetingAttachmentPage", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(meetingAttachmentList, inDto.getPageTotal()));
	}
	
	/**
	 * 会议详情附件下载
	 * 
	 * @param httpModel
	 */
	public void replyDetailPage(HttpModel httpModel) {
		Dto inDto = httpModel.getInDto();
		List<Dto> meetingAttachmentList = sqlDao.list("WeeklyStorage.replyDetailPage", inDto);
		httpModel.setOutMsg(AOSJson.toGridJson(meetingAttachmentList, inDto.getPageTotal()));
	}
 }
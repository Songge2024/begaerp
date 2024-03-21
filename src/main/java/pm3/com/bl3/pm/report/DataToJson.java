package com.bl3.pm.report;

import java.util.List;

import aos.framework.core.typewrap.Dto;
import aos.framework.core.utils.AOSJson;

public class DataToJson {
	/**
	 * 
	 * @param Detail  循环使用的值(明细数据)
	 * @param Master  只使用一次的值(介绍数据)
	 * @return  JSON字符串
	 */
	 public  String reportData(List<Dto> Detail,List<Dto> Master){
		StringBuilder sb=new StringBuilder();
		String Detail_= AOSJson.toJson(Detail);
		String Master_= AOSJson.toJson(Master);
		sb.append("{");
		sb.append("\"Detail\":");
		sb.append(Detail_);
		sb.append(",");
		sb.append("\"Master\":");
		sb.append(Master_);
		sb.append("}");
		return sb.toString();
	}
	   /**
		 * 
		 * @param Detail  循环使用的值(明细数据)
		 * @return  JSON字符串
		 */
	 public  String reportData(List<Dto> Detail){
		StringBuilder sb=new StringBuilder();
		String Detail_= AOSJson.toJson(Detail);
		sb.append("{");
		sb.append("\"Detail\":");
		sb.append(Detail_);
		sb.append(",");
		sb.append("\"Master\":");
		sb.append("{}");
		sb.append("}");
		return sb.toString();
	}
}

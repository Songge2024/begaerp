package aos.framework.core.excel.xls;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.InputStream;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import jxl.Cell;
import jxl.Workbook;
import jxl.format.UnderlineStyle;
import jxl.write.Label;
import jxl.write.Number;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import aos.framework.core.excel.ExcelData;
import aos.framework.core.typewrap.Dto;
import aos.framework.core.typewrap.Dtos;
import aos.framework.core.typewrap.PO;
import aos.framework.core.typewrap.VO;
import aos.framework.core.utils.AOSUtils;

/**
 * Excel数据填充器
 * 
 * @author XiongChun
 * @since 2010-08-12
 */
public class ExcelFiller_week_old {

	private Log log = LogFactory.getLog(ExcelFiller_week_old.class);

	private ExcelTemplate_diy excelTemplate = null;

	private ExcelData excelData = null;

	public ExcelFiller_week_old() {
	}

	/**
	 * 构造函数
	 * 
	 * @param pExcelTemplate
	 * @param pExcelData
	 */
	public ExcelFiller_week_old(ExcelTemplate_diy pExcelTemplate, ExcelData pExcelData) {
		setExcelData(pExcelData);
		setExcelTemplate(pExcelTemplate);
	}

	/**
	 * 数据填充 将ExcelData填入excel模板
	 * 
	 * @return ByteArrayOutputStream
	 */
	public ByteArrayOutputStream fill(HttpServletRequest request) {
		WritableSheet wSheet = null;
		ByteArrayOutputStream bos = new ByteArrayOutputStream();
		try {
	        InputStream is = request.getSession().getServletContext().getResourceAsStream(getExcelTemplate().getTemplatePath()); 
			Workbook wb = Workbook.getWorkbook(is);
			WritableWorkbook wwb = Workbook.createWorkbook(bos, wb);
			wSheet = wwb.getSheet(0);
			fillStatics(wSheet);
			fillParameters(wSheet);
			fillFields(wSheet);
			if (AOSUtils.isNotEmpty(getExcelData().getFieldsList())) {
				// fillFields(wSheet);
			}
			wwb.write();
			wwb.close();
			wb.close();
		} catch (Exception e) {
			log.error("基于模板生成可写工作表出错了!");
			e.printStackTrace();
		}
		return bos;
	}

	/**
	 * 写入静态对象
	 * @throws WriteException 
	 */
	private void fillStatics(WritableSheet wSheet) throws WriteException {
		List statics = getExcelTemplate().getStaticObject();
		for (int i = 0; i < statics.size(); i++) {
			Cell cell = (Cell) statics.get(i);
			Label label = null;
			jxl.write.WritableFont wfc = new jxl.write.WritableFont(WritableFont.createFont(cell.getCellFormat().getFont().getName()), cell.getCellFormat().getFont().getPointSize(), 
					WritableFont.NO_BOLD, false, 
					UnderlineStyle.NO_UNDERLINE); 
					jxl.write.WritableCellFormat wcfFC = new jxl.write.WritableCellFormat(wfc);
					wcfFC.setAlignment(jxl.format.Alignment.CENTRE);//设置单元格居中
					wcfFC.setVerticalAlignment(jxl.format.VerticalAlignment.CENTRE);
					wcfFC.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN); //设置单元格边框
					wcfFC.setBackground(jxl.format.Colour.GRAY_25);
					wcfFC.setWrap(true);
				label = new Label(cell.getColumn(), cell.getRow(), cell.getContents(),wcfFC);
				wSheet.setRowView(cell.getRow(), 500);
			try {
				wSheet.addCell(label);
			} catch (Exception e) {
				log.error("写入静态对象发生错误!");
				e.printStackTrace();
			}
		}
	}

	/**
	 * 写入参数对象
	 * @throws WriteException 
	 */
	private void fillParameters(WritableSheet wSheet) throws WriteException {
		List parameters = getExcelTemplate().getParameterObjct();
		Dto parameterDto = getExcelData().getParametersDto();
		for (int i = 0; i < parameters.size(); i++) {
			Cell cell = (Cell) parameters.get(i);
			String key = getKey(cell.getContents().trim());
			String type = getType(cell.getContents().trim());
			jxl.write.WritableFont wfc = new jxl.write.WritableFont(WritableFont.createFont(cell.getCellFormat().getFont().getName()), cell.getCellFormat().getFont().getPointSize(), 
					WritableFont.NO_BOLD, false, 
					UnderlineStyle.NO_UNDERLINE); 
					jxl.write.WritableCellFormat wcfFC = new jxl.write.WritableCellFormat(wfc);
					wcfFC.setAlignment(jxl.format.Alignment.CENTRE);
					wcfFC.setVerticalAlignment(jxl.format.VerticalAlignment.CENTRE);
					wcfFC.setBackground(jxl.format.Colour.GRAY_25);
					wcfFC.setWrap(true);
					wcfFC.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN); 
			try {
				if (type.equalsIgnoreCase("number")) {
					Number number = new Number(cell.getColumn(), cell.getRow(), parameterDto.getBigDecimal(key).doubleValue());
//					number.setCellFormat(cell.getCellFormat());
					wSheet.addCell(number);
				} else {
					Label label = null;
					if(key.equals("reportTitle")){
						jxl.write.WritableFont wfc1 = new jxl.write.WritableFont(WritableFont.createFont(cell.getCellFormat().getFont().getName()), cell.getCellFormat().getFont().getPointSize(), 
								WritableFont.BOLD, false, 
								UnderlineStyle.NO_UNDERLINE); 
								jxl.write.WritableCellFormat wcfFC1 = new jxl.write.WritableCellFormat(wfc1);
								wcfFC1.setAlignment(jxl.format.Alignment.CENTRE);//设置单元格居中
								wcfFC1.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN); 
						label = new Label(cell.getColumn(), cell.getRow(), parameterDto.getString(key),wcfFC1);
					}else if(key.equals("reportTitle2")){
						jxl.write.WritableFont wfc1 = new jxl.write.WritableFont(WritableFont.createFont(cell.getCellFormat().getFont().getName()), cell.getCellFormat().getFont().getPointSize(), 
								WritableFont.NO_BOLD, false, 
								UnderlineStyle.NO_UNDERLINE); 
								jxl.write.WritableCellFormat wcfFC1 = new jxl.write.WritableCellFormat(wfc1);
								wcfFC1.setAlignment(jxl.format.Alignment.CENTRE);//设置单元格居中
								wcfFC1.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN); 
						label = new Label(cell.getColumn(), cell.getRow(), parameterDto.getString(key),wcfFC1);
					}else{
						label = new Label(cell.getColumn(), cell.getRow(), parameterDto.getString(key),wcfFC);
						wSheet.setRowView(cell.getRow(), 560);
//						label.setCellFormat(cell.getCellFormat());
					}
					wSheet.addCell(label);
				}
			} catch (Exception e) {
				log.error("写入表格参数对象发生错误!");
				e.printStackTrace();
			}
		}
	}

	/**
	 * 写入表格字段对象
	 * 
	 * @throws Exception
	 */
	private void fillFields(WritableSheet wSheet) throws Exception {
		List fields = getExcelTemplate().getFieldObjct();
		List fieldList = getExcelData().getFieldsList();
		Dto parameterDto = getExcelData().getParametersDto();
		int data_row = parameterDto.getInteger("data_row");
		Label label = null;
		
		Cell cell_wf = (Cell) fields.get(0);
		WritableFont wf = new WritableFont(WritableFont.TIMES, cell_wf.getCellFormat().getFont().getPointSize(),WritableFont.NO_BOLD,false);
//		WritableFont wf=new WritableFont(WritableFont.TIMES,18,WritableFont.NO_BOLD,false);
		jxl.write.WritableCellFormat wcf = new jxl.write.WritableCellFormat(wf); 
		wcf.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN);
		wcf.setAlignment(jxl.format.Alignment.CENTRE);
		
		int column_value=0;//保留列相同值行数
		Dto rowDto = Dtos.newDto();
		for (int j = 0; j < fieldList.size(); j++) {
			if(j==0){
				label = new Label(0, data_row, parameterDto.getString("rowTitle1"),wcf);
			}else if(j==1){
				label = new Label(0, data_row, parameterDto.getString("rowTitle2"),wcf);
			}else if(j==2){
				label = new Label(0, data_row, parameterDto.getString("rowTitle3"),wcf);
			}
			wSheet.addCell(label);
			wSheet.mergeCells(0, data_row, (fields.size()/3)-1, data_row);//合并单元格
			data_row++;
			List dataList = (List) fieldList.get(j);
			for(int a = 0;a<dataList.size();a++){
				column_value=0;
				Dto dataDto = Dtos.newDto();
				Object object = dataList.get(a);
				if (object instanceof PO) {
					PO po = (PO) object;
					dataDto.putAll(po.toDto());
				} else if (object instanceof VO) {
					VO vo = (VO) object;
					dataDto.putAll(vo.toDto());
				} else if (object instanceof Dto) {
					Dto dto = (Dto) object;
					dataDto.putAll(dto);
				} else {
					log.error("不支持的数据类型!");
				}
//				if(dataDto.getString("week").equals("4")){
//					wSheet.setColumnView(7,0);
//				}
				for (int i = 0; i < fields.size(); i++) {
					Cell cell = (Cell) fields.get(i);
					String key = getKey(cell.getContents().trim());
					String type = getType(cell.getContents().trim());
					
					if(dataDto.getString(key) == null || dataDto.getString(key).equals("")){
						if(dataList.size()>0){
							continue;
						}
					}
					
					String numString = dataDto.getString(key);
					boolean isNum = false;
					boolean isHB = false;
//					Pattern pattern = Pattern.compile("-?[0-9]*.?[0-9]*");   //正则表达式判断字符串是数字，可以为正数，可以为负数，可以为小数,不能含有字符。
//					Matcher sNum = pattern.matcher(numString);
//					if( sNum.matches() ){
//						isNum = true;
//					}
					isNum = numString.matches("^[-+]?(([0-9]+)([.]([0-9]+))?|([.]([0-9]+))?)$");
					
//					if(data_row>5){
//						isHB = true;
//					}
					try {
						if(a>0 && AOSUtils.isNotEmpty(rowDto.getInteger(key))){
							Dto dataDto2 = this.getDto(dataList.get(a-1));
							if(AOSUtils.isNotEmpty(dataDto.getString(key))&&dataDto.getString(key).equals(dataDto2.getString(key))){
								if(a == dataList.size()-1){
									wSheet.mergeCells(cell.getColumn(), rowDto.getInteger(key), cell.getColumn(), data_row);//合并单元格
									column_value = cell.getColumn()+1;
								}else{
									Dto dataDto3 = this.getDto(dataList.get(a+1));
									if(!dataDto.getString(key).equals(dataDto3.getString(key))){
										wSheet.mergeCells(cell.getColumn(), rowDto.getInteger(key), cell.getColumn(), data_row);//合并单元格
										column_value = cell.getColumn()+1;
									}else{
										column_value = cell.getColumn()+1;
									}
								}
							}else{
								rowDto.put(key, data_row);
								if(i>0){
									Cell cell2 = (Cell) fields.get(i-1);
									if(key.equals(getKey(cell2.getContents().trim()))){
										rowDto.remove(key);
										if(i%(fields.size()/3)==fields.size()/3-1){//判断是否是最后一个
											wSheet.mergeCells(column_value, data_row,cell.getColumn(), data_row);//合并单元格
											column_value = cell.getColumn()+1;
										}else{
											Cell cell3 = (Cell) fields.get(i+1);
											if(!key.equals(getKey(cell3.getContents().trim()))){
												wSheet.mergeCells(column_value, data_row,cell.getColumn(), data_row);//合并单元格
												column_value = cell.getColumn()+1;
											}
										}
									}else{
										if(i%(fields.size()/3)!=fields.size()/3-1){
											Cell cell3 = (Cell) fields.get(i+1);
											if(key.equals(getKey(cell3.getContents().trim()))){
												rowDto.remove(key);
											}else{
												column_value = cell.getColumn()+1;
											}
										}
									}
								}else{
									Cell cell4 = (Cell) fields.get(i+1);
									if(key.equals(getKey(cell4.getContents().trim()))){
										rowDto.remove(key);
									}
								}
							}

						} else {
							rowDto.put(key, data_row);
							if(i>0){
								Cell cell2 = (Cell) fields.get(i-1);
								if(key.equals(getKey(cell2.getContents().trim()))){
									rowDto.remove(key);
									if(i%(fields.size()/3)==fields.size()/3-1){//判断是否是最后一个
										wSheet.mergeCells(column_value, data_row,cell.getColumn(), data_row);//合并单元格
										column_value = cell.getColumn()+1;
									}else{
										Cell cell3 = (Cell) fields.get(i+1);
										if(!key.equals(getKey(cell3.getContents().trim()))){
											wSheet.mergeCells(column_value, data_row,cell.getColumn(), data_row);//合并单元格
											column_value = cell.getColumn()+1;
										}
									}
								}else{
									if(i%(fields.size()/3)!=fields.size()/3-1){
										Cell cell3 = (Cell) fields.get(i+1);
										if(key.equals(getKey(cell3.getContents().trim()))){
											rowDto.remove(key);
										}else{
											column_value = cell.getColumn()+1;
										}
									}
								}
							}else{
								Cell cell4 = (Cell) fields.get(i+1);
								if(key.equals(getKey(cell4.getContents().trim()))){
									rowDto.remove(key);
								}
							}
						}
						if (type.equalsIgnoreCase("number")) {
							Number number = new Number(cell.getColumn(), data_row, dataDto.getBigDecimal(key).doubleValue());
								number.setCellFormat(cell.getCellFormat());
							wSheet.addCell(number);
						} else {
//							if(dataDto.getString("appo_flag").equals("1")){
//								//定义分摊数据样式
//								jxl.write.WritableFont wfc1 = new jxl.write.WritableFont(WritableFont.createFont(cell.getCellFormat().getFont().getName()), cell.getCellFormat().getFont().getPointSize(), 
//										WritableFont.NO_BOLD, false, 
//										UnderlineStyle.NO_UNDERLINE,jxl.format.Colour.BLUE); 
//										jxl.write.WritableCellFormat wcfFC1 = new jxl.write.WritableCellFormat(wfc1); 
//										wcfFC1.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN);
//										wcfFC1.setVerticalAlignment(jxl.format.VerticalAlignment.CENTRE);//设置单元格竖直方向居中对齐
//								if(isNum == true){
//									wcfFC1.setAlignment(jxl.format.Alignment.RIGHT);//设置单元格居右
//								}else{
//									wcfFC1.setAlignment(jxl.format.Alignment.CENTRE);//设置单元格居中
//								}
//								label = new Label(cell.getColumn(), data_row, dataDto.getString(key),wcfFC1);
//							}else if(dataDto.getString("gs_remark")!=null && !dataDto.getString("gs_remark").equals("")){
//								//定义批注数据样式
//								jxl.write.WritableFont wfc2 = new jxl.write.WritableFont(WritableFont.createFont(cell.getCellFormat().getFont().getName()), cell.getCellFormat().getFont().getPointSize(), 
//										WritableFont.NO_BOLD, false, 
//										UnderlineStyle.NO_UNDERLINE,jxl.format.Colour.RED); 
//										jxl.write.WritableCellFormat wcfFC3 = new jxl.write.WritableCellFormat(wfc2); 
//										wcfFC3.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN);
//								if(isNum == true){
//									wcfFC3.setAlignment(jxl.format.Alignment.RIGHT);//设置单元格居右
//								}else if(key.equals("item_name")||key.equals("c_item_name")||key.equals("r_item_name")){
//									wcfFC3.setAlignment(jxl.format.Alignment.LEFT);//设置单元格居左
//								}else{
//									wcfFC3.setAlignment(jxl.format.Alignment.CENTRE);//设置单元格居中
//								}
//								label = new Label(cell.getColumn(), data_row, dataDto.getString(key),wcfFC3);
//								if(!key.equals("remark")&&!key.equals("c_remark")&&!key.equals("r_remark") ){
//									jxl.write.WritableCellFeatures cellFeatures = new jxl.write.WritableCellFeatures();
//									cellFeatures.setComment(dataDto.getString("gs_remark"));
//									label.setCellFeatures(cellFeatures);
//								}
								
//							}else {
								//定义一般数据样式
								jxl.write.WritableFont wfc = new jxl.write.WritableFont(WritableFont.createFont(cell.getCellFormat().getFont().getName()), cell.getCellFormat().getFont().getPointSize(), 
										WritableFont.NO_BOLD, false, 
										UnderlineStyle.NO_UNDERLINE); 
										jxl.write.WritableCellFormat wcfFC = new jxl.write.WritableCellFormat(wfc);
										wcfFC.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN); 
										wcfFC.setVerticalAlignment(jxl.format.VerticalAlignment.CENTRE);//设置单元格竖直方向居中对齐
								if(isNum == true){
									wcfFC.setAlignment(jxl.format.Alignment.RIGHT);//设置单元格居右
								}else if(key.equals("item_name")||key.equals("c_item_name")||key.equals("r_item_name")){
									wcfFC.setAlignment(jxl.format.Alignment.LEFT);//设置单元格居左
								}else{
									wcfFC.setAlignment(jxl.format.Alignment.CENTRE);//设置单元格水平居中对齐
								}
								label = new Label(cell.getColumn(), data_row, dataDto.getString(key),wcfFC);
//							}
							wSheet.addCell(label);
						}
					} catch (Exception e) {
						log.error("写入表格字段对象发生错误!");
						e.printStackTrace();
					}
				}
				data_row++;
			}
			
		}
	}

	/**
	 * 写入变量对象
	 * @throws WriteException 
	 */
	private void fillVariables(WritableSheet wSheet, int row) throws WriteException {
		List variables = getExcelTemplate().getVariableObject();
		Dto parameterDto = getExcelData().getParametersDto();
			for (int i = 0; i < variables.size(); i++) {
				Cell cell = (Cell) variables.get(i);
				String key = getKey(cell.getContents().trim());
				String type = getType(cell.getContents().trim());
				
				jxl.write.WritableFont wfc = new jxl.write.WritableFont(WritableFont.createFont(cell.getCellFormat().getFont().getName()), cell.getCellFormat().getFont().getPointSize(), 
						WritableFont.NO_BOLD, false, 
						UnderlineStyle.NO_UNDERLINE); 
				jxl.write.WritableCellFormat wcfFC = new jxl.write.WritableCellFormat(wfc);
				wcfFC.setAlignment(jxl.format.Alignment.CENTRE);
				
				
				try {
					if (type.equalsIgnoreCase("number")) {
						Number number = new Number(cell.getColumn(), row, parameterDto.getBigDecimal(key).doubleValue(),wcfFC);
	//					number.setCellFormat(cell.getCellFormat());
						wSheet.addCell(number);
					} else {
						String content = parameterDto.getString(key);
						if (AOSUtils.isEmpty(content) && !key.equalsIgnoreCase("nbsp")) {
							content = key;
						}
						Label label = new Label(cell.getColumn(), row, content,wcfFC);
	//					label.setCellFormat(cell.getCellFormat());
						wSheet.addCell(label);
					}
				} catch (Exception e) {
					log.error( "写入表格变量对象发生错误!");
					e.printStackTrace();
				}
			}
		}

	/**
	 * 获取模板键名
	 * 
	 * @param pKey
	 *            模板元标记
	 * @return 键名
	 */
	private static String getKey(String pKey) {
		String key = null;
		int index = pKey.indexOf(":");
		if (index == -1) {
			key = pKey.substring(3, pKey.length() - 1);
		} else {
			key = pKey.substring(3, index);
		}
		return key;
	}

	/**
	 * 获取模板单元格标记数据类型
	 * 
	 * @param pType
	 *            模板元标记
	 * @return 数据类型
	 */
	private static String getType(String pType) {
		String type = "label";
		if (pType.indexOf(":n") != -1 || pType.indexOf(":N") != -1) {
			type = "number";
		} else if (pType.indexOf(":df") != -1 || pType.indexOf(":DF") != -1) {
			type = "dateformat";
		} else if (pType.indexOf(":dtf") != -1 || pType.indexOf(":DTF") != -1) {
			type = "datetimeformat";
		}
		return type;
	}
	private static Dto getDto(Object object){
		Dto dataDto = Dtos.newDto();
		if (object instanceof PO) {
			PO po = (PO) object;
			dataDto.putAll(po.toDto());
		} else if (object instanceof VO) {
			VO vo = (VO) object;
			dataDto.putAll(vo.toDto());
		} else if (object instanceof Dto) {
			Dto dto = (Dto) object;
			dataDto.putAll(dto);
		}
		return dataDto;
	}
	public ExcelTemplate_diy getExcelTemplate() {
		return excelTemplate;
	}

	public void setExcelTemplate(ExcelTemplate_diy excelTemplate) {
		this.excelTemplate = excelTemplate;
	}

	public ExcelData getExcelData() {
		return excelData;
	}

	public void setExcelData(ExcelData excelData) {
		this.excelData = excelData;
	}
}

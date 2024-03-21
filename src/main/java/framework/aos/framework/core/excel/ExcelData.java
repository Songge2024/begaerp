package aos.framework.core.excel;

import java.util.List;

import aos.framework.core.typewrap.Dto;


/**
 * Excel数据对象
 * 
 * @author BLRISE
 * @since 2010-08-12
 */
public class ExcelData {

	/**
	 * Excel参数元数据对象
	 */
	private Dto parametersDto;
	
	/**
	 * Excel参数元数据集合对象
	 */
	private List parametersList;

	/**
	 * Excel集合元对象
	 */
	private List fieldsList;

	/**
	 * 构造函数
	 * 
	 * @param pDto
	 *            元参数对象
	 * @param pList
	 *            集合元对象
	 */
	public ExcelData(Dto pDto, List pList) {
		setParametersDto(pDto);
		setFieldsList(pList);
	}
	
	/**
	 * 构造函数
	 * 
	 * @param list
	 *            元参数对象
	 * @param pList
	 *            集合元对象
	 */
	public ExcelData(List list, List pList) {
		setParametersList(list);
		setFieldsList(pList);
	}

	public List getParametersList() {
		return parametersList;
	}

	public void setParametersList(List parametersList) {
		this.parametersList = parametersList;
	}

	public Dto getParametersDto() {
		return parametersDto;
	}

	public void setParametersDto(Dto parametersDto) {
		this.parametersDto = parametersDto;
	}

	public List getFieldsList() {
		return fieldsList;
	}

	public void setFieldsList(List fieldsList) {
		this.fieldsList = fieldsList;
	}

}

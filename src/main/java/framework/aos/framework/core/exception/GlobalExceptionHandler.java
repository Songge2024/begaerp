package aos.framework.core.exception;

import java.sql.SQLException;

import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.web.HttpMediaTypeNotSupportedException;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import aos.framework.core.typewrap.Dto;
import aos.framework.core.typewrap.Dtos;


/**
 * 统一错误处理
 * @author remexs
 *
 */
@ControllerAdvice
public class GlobalExceptionHandler{
	/**
	 * 自定义异常
	 */
	@ExceptionHandler(AOSException.class)
	public String handleRRException(AOSException e){
		 Dto error=Dtos.newDto();
	     error.put("errmsg", e.getMessage());
		return error.toString();
	}
	/**
     * 400 - Bad Request
     */
    @ExceptionHandler(HttpMessageNotReadableException.class)
    public String handleHttpMessageNotReadableException(Exception e) {
        return e.getMessage();

    }

    /**
     * 405 - Method Not Allowed
     */
    @ExceptionHandler(HttpRequestMethodNotSupportedException.class)
    public String handleHttpRequestMethodNotSupportedException(Exception e) {
        return e.getMessage();
    }

    /**
     * 415 - Unsupported Media Type
     */
    @ExceptionHandler(HttpMediaTypeNotSupportedException.class)
    public String handleHttpMediaTypeNotSupportedException(Exception e) {
        return e.getMessage();

    }

    /**
     * 500 - Internal Server Error
     */
    @ExceptionHandler(Exception.class)
    public String handleException(Exception e) {
        e.printStackTrace();
        Dto error=Dtos.newDto();
        error.put("errmsg", e.getMessage());
        return error.toString();
    }


    /**
     * sql 异常
     * @param e
     * @return
     */
    @ExceptionHandler(SQLException.class)
    public String handleSql(Exception e){
        return e.getCause().getMessage();
    }

}

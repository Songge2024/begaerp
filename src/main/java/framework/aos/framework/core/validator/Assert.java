package aos.framework.core.validator;

import org.apache.commons.lang.StringUtils;

import aos.framework.core.exception.AOSException;
import aos.framework.core.utils.AOSUtils;

/**
 * 数据校验
 * @author remexs
 * @email bigdrone@163.com
 * @date 2017-12-12 9:33
 */
public abstract class Assert {

    public static void isBlank(String str, String message) {
        if (StringUtils.isBlank(str)) {
            throw new AOSException(message);
        }
    }

    public static void isNull(Object object, String message) {
        if (AOSUtils.isEmpty(object)) {
            throw new AOSException(message);
        }
    }
}

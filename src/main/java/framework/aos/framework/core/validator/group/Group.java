package aos.framework.core.validator.group;

import javax.validation.GroupSequence;

/**
 * 定义校验顺序，如果AddGroup组失败，则UpdateGroup组不会再校验
 * 
 * @author remexs
 * @email bigdrone@163.com
 * @date 2017-12-12 9:33
 */
@GroupSequence({ AddGroup.class, UpdateGroup.class })
public interface Group {

}

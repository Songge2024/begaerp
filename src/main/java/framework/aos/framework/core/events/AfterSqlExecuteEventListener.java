package aos.framework.core.events;

import org.springframework.context.ApplicationListener;
import org.springframework.scheduling.annotation.Async;

import aos.framework.core.typewrap.Dto;
import aos.framework.core.typewrap.Dtos;
import aos.framework.core.utils.AOSCxt;

public class AfterSqlExecuteEventListener implements ApplicationListener<AfterSqlExecuteEvent> {
	
	@Async
	@Override
	public void onApplicationEvent(AfterSqlExecuteEvent event) {
		
	}

}
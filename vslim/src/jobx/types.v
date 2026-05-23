module jobx

import databasex

@[php_class: 'VSlim\\Job\\Dispatcher']
@[heap]
pub struct VSlimJobDispatcher {
mut:
	manager_ref &databasex.VSlimDatabaseManager = unsafe { nil } @[php_ignore]
}

@[php_class: 'VSlim\\Job\\Worker']
@[heap]
pub struct VSlimJobWorker {
mut:
	manager_ref          &databasex.VSlimDatabaseManager = unsafe { nil } @[php_ignore]
	worker_id            string = 'default' @[php_prop: workerId]
	retry_delay_seconds  int    = 60    @[php_prop: retryDelaySeconds]
	reserve_timeout_secs int    = 300    @[php_prop: reserveTimeoutSeconds]
}

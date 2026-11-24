module jobx

import databasex
import vphp

@[vphp.PhpExportClass(name: 'VSlim\\Job\\Dispatcher')]
@[heap]
pub struct VSlimJobDispatcher {
mut:
	manager_ref &databasex.VSlimDatabaseManager = unsafe { nil } @[vphp.PhpIgnoreField]
}

@[vphp.PhpExportClass(name: 'VSlim\\Job\\Worker')]
@[heap]
pub struct VSlimJobWorker {
mut:
	manager_ref          &databasex.VSlimDatabaseManager = unsafe { nil } @[vphp.PhpIgnoreField]
	worker_id            string = 'default' @[vphp.PhpProperty(name: 'workerId')]
	retry_delay_seconds  int    = 60        @[vphp.PhpProperty(name: 'retryDelaySeconds')]
	reserve_timeout_secs int    = 300       @[vphp.PhpProperty(name: 'reserveTimeoutSeconds')]
}

module rt

#include "zts_def.h"
#include "zts_inst.h"

@[c_extern]
fn C.php_embed_shutdown()
@[c_extern]
fn C.php2v_update_tsrm_cache()

// init 初始化 PHP embed 引擎运行上下文
pub fn init() {
	unsafe {
		C.php2v_update_tsrm_cache()
	}
}

// shutdown 释放 PHP embed 引擎运行上下文
pub fn shutdown() {
	unsafe {
		C.php_embed_shutdown()
	}
}


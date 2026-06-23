module rt

#include "zts_def.h"

@[c_extern]
fn C.php_embed_init(argc int, argv &&char) int
@[c_extern]
fn C.php_embed_shutdown()

// init 初始化 PHP embed 引擎运行上下文
pub fn init() {
	unsafe {
		argv := [&char(0)]
		C.php_embed_init(0, argv.data)
	}
}

// shutdown 释放 PHP embed 引擎运行上下文
pub fn shutdown() {
	unsafe {
		C.php_embed_shutdown()
	}
}


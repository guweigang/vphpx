module rt

import os

#include "zts_def.h"
#include "zts_inst.h"

@[c_extern]
fn C.php_embed_shutdown()
@[c_extern]
fn C.php2v_update_tsrm_cache()
@[c_extern]
fn C.php2v_refresh_request()
@[c_extern]
fn C.php2v_register_thread()

// init 初始化 PHP embed 引擎运行上下文
fn init() {
	unsafe {
		C.php2v_update_tsrm_cache()
	}
	// 检测是否处于 Web / CGI 环境中
	if os.getenv('REQUEST_METHOD') != '' {
		setup_web_environment()
	}
}

fn setup_web_environment() {
	// 1. 注入 $_SERVER
	mut server := new_array()
	for k, v in os.environ() {
		server.array_set(new_string(k), new_string(v))
	}
	register_global('_SERVER', server)

	// 2. 注入 $_GET
	mut get_arr := new_array()
	qs := os.getenv('QUERY_STRING')
	if qs != '' {
		for pair in qs.split('&') {
			parts := pair.split('=')
			if parts.len == 2 {
				get_arr.array_set(new_string(parts[0]), new_string(parts[1]))
			}
		}
	}
	register_global('_GET', get_arr)

	// 3. 注入空的 $_POST, $_COOKIE
	register_global('_POST', new_array())
	register_global('_COOKIE', new_array())
}

// shutdown 释放 PHP embed 引擎运行上下文
pub fn shutdown() {
	unsafe {
		C.php_embed_shutdown()
	}
}


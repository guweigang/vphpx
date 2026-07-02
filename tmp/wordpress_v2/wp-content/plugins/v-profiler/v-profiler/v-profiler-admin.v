import rt

fn v_profiler_render_admin_page() {
	mut var_is_vhttpd := rt.new_null()
	mut var_current_mode := rt.new_null()
	mut var_db_dst := rt.new_null()
	mut var_oc_dst := rt.new_null()
	mut var_db_active := rt.new_null()
	mut var_oc_active := rt.new_null()
	mut var_message := rt.new_null()
	mut var_message_type := ''
	mut var_suc := rt.new_null()
	mut var_err := rt.new_null()
	mut iife_temp_10 := Class_VHttpd_WordPress_ProfilerEnv{}
	mut iife_result_10 := iife_temp_10.isvhttpd()
	var_is_vhttpd = iife_result_10
	mut iife_temp_11 := Class_VHttpd_WordPress_ProfilerEnv{}
	mut iife_result_11 := iife_temp_11.getmode()
	var_current_mode = iife_result_11
	mut iife_temp_12 := Class_VHttpd_WordPress_ProfilerEnv{}
	mut iife_result_12 := iife_temp_12.getwpcontentdir()
	var_db_dst = rt.new_string(iife_result_12.str() + '/db.php')
	mut iife_temp_13 := Class_VHttpd_WordPress_ProfilerEnv{}
	mut iife_result_13 := iife_temp_13.getwpcontentdir()
	var_oc_dst = rt.new_string(iife_result_13.str() + '/object-cache.php')
	var_db_active = rt.call_function('is_file', [var_db_dst.clone()])
	var_oc_active = rt.call_function('is_file', [var_oc_dst.clone()])
	var_message = rt.new_string('')
	var_message_type = 'success'
	if rt.get_superglobal('_GET').array_isset(rt.new_string('v_success')) {
		var_suc = rt.call_function('sanitize_text_field', [
			rt.get_superglobal('_GET').array_get(rt.new_string('v_success')),
		])
		if rt.is_true(rt.identical(var_suc, rt.new_string('mode_upgraded'))) {
			var_message =
				rt.new_string('🚀 极速引擎已开启！长连接池与进程共享内存已接管 WordPress。')
		} else if rt.is_true(rt.identical(var_suc, rt.new_string('mode_downgraded'))) {
			var_message =
				rt.new_string('已回退至受限模式，所有极速 Drop-ins 已安全移除。')
		}
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('v_error')) {
		var_err = rt.call_function('sanitize_text_field', [
			rt.get_superglobal('_GET').array_get(rt.new_string('v_error')),
		])
		var_message_type = 'error'
		if rt.is_true(rt.identical(var_err, rt.new_string('dir_not_writable'))) {
			var_message = rt.new_string(
				'❌ 权限不足！ wp-content 目录不可写。请在终端执行：<br><code style="background:#f43f5e; color:#fff; padding:2px 6px; border-radius:4px;">chmod 775 ' +
				(rt.call_function('esc_html', [rt.get_constant('WP_CONTENT_DIR')])).str() +
				'</code>')
		} else if rt.is_true(rt.identical(var_err, rt.new_string('source_files_missing'))) {
			var_message =
				rt.new_string('❌ 部署失败：未能在插件目录中找到 db.php 或 object-cache.php 源文件备份。')
		} else if rt.is_true(rt.identical(var_err, rt.new_string('copy_failed'))) {
			var_message =
				rt.new_string('❌ 文件拷贝失败，请检查 wp-content 的属主或权限。')
		} else if rt.is_true(rt.identical(var_err, rt.new_string('delete_db_failed'))) {
			var_message = rt.new_string('❌ 移除 db.php 失败，请检查文件写入权限。')
		} else if rt.is_true(rt.identical(var_err, rt.new_string('delete_oc_failed'))) {
			var_message =
				rt.new_string('❌ 移除 object-cache.php 失败，请检查文件写入权限。')
		} else if rt.is_true(rt.identical(var_err, rt.new_string('not_vhttpd'))) {
			var_message =
				rt.new_string('❌ 切换失败：当前 Web 服务器并非 vhttpd，无法开启完整极速模式。')
		}
	}
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(var_message)) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_message_type.str()).clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses_post', [var_message.clone()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_db_active) { 'active' } else { 'inactive' })
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_db_active) { 'db.php (Pool Online)' } else { 'db.php (Direct MySQL)' })
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_oc_active) { 'active' } else { 'inactive' })
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_oc_active) {
		'object-cache.php (vhttpd Cache)'
	} else {
		'object-cache.php (Default Memory)'
	})
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(rt.identical(var_current_mode, rt.new_string('restricted'))) {
		'selected'
	} else {
		''
	})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('v_profiler_admin_action'),
		rt.new_string('v_profiler_nonce')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_is_vhttpd) {
		// unsupported statement: Stmt_InlineHTML
		print(if rt.is_true(rt.identical(var_current_mode, rt.new_string('full'))) {
			'selected'
		} else {
			''
		})
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_nonce_field', [rt.new_string('v_profiler_admin_action'),
			rt.new_string('v_profiler_nonce')])
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

struct Class_VHttpd_WordPress_ProfilerEnv {
	rt.PhpObjectBase
}

fn create_vhttpd_wordpress_profilerenv(_args ...rt.PhpVal) &Class_VHttpd_WordPress_ProfilerEnv {
	mut obj := &Class_VHttpd_WordPress_ProfilerEnv{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_VHttpd_WordPress_ProfilerEnv) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_VHttpd_WordPress_ProfilerEnv) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_VHttpd_WordPress_ProfilerEnv) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		rt.call_function('add_menu_page', [rt.new_string('v-Profiler Control Panel'),
			rt.new_string('📊 v-Profiler'), rt.new_string('manage_options'),
			rt.new_string('v-profiler-settings'), rt.new_string('v_profiler_render_admin_page'),
			rt.new_string('dashicons-performance'), rt.new_int(99)])
		return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('admin_menu'),
		rt.new_closure(closure_1_fn)])
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_actions := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_plugin_file := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		if rt.is_true(rt.identical(var_plugin_file, rt.new_string('v-profiler.php')))
			|| rt.is_true(rt.identical(var_plugin_file, rt.new_string('v-profiler/v-profiler.php')))
			|| rt.is_true(rt.identical(var_plugin_file, rt.new_string('v-profiler-loader.php'))) {
			mut var_settings_url := rt.call_function('admin_url', [
				rt.new_string('admin.php?page=v-profiler-settings'),
			])
			var_actions.array_set('settings', '<a href="' +
				(rt.call_function('esc_url', [var_settings_url.clone()])).str() + '">Settings</a>')
			var_actions.array_set('github',
				'<a href="https://github.com/guweigang/vhttpd" target="_blank" rel="noopener noreferrer">vhttpd GitHub</a>')
		}
		return var_actions.clone()
	}
	rt.call_function('add_filter', [rt.new_string('plugin_action_links'),
		rt.new_closure(closure_2_fn), rt.new_int(10), rt.new_int(2)])
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_actions := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_plugin_file := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		if rt.is_true(rt.identical(var_plugin_file, rt.new_string('v-profiler.php')))
			|| rt.is_true(rt.identical(var_plugin_file, rt.new_string('v-profiler/v-profiler.php')))
			|| rt.is_true(rt.identical(var_plugin_file, rt.new_string('v-profiler-loader.php'))) {
			mut var_settings_url := rt.call_function('admin_url', [
				rt.new_string('admin.php?page=v-profiler-settings'),
			])
			var_actions.array_set('settings', '<a href="' +
				(rt.call_function('esc_url', [var_settings_url.clone()])).str() + '">Settings</a>')
			var_actions.array_set('github',
				'<a href="https://github.com/guweigang/vhttpd" target="_blank" rel="noopener noreferrer">vhttpd GitHub</a>')
		}
		return var_actions.clone()
	}
	rt.call_function('add_filter', [rt.new_string('network_admin_plugin_action_links'),
		rt.new_closure(closure_3_fn), rt.new_int(10), rt.new_int(2)])
	closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut iife_temp_4 := Class_VHttpd_WordPress_ProfilerEnv{}
		mut iife_result_4 := iife_temp_4.isvhttpd()
		mut iife_temp_5 := Class_VHttpd_WordPress_ProfilerEnv{}
		mut iife_result_5 := iife_temp_5.getmode()
		if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_4))))
			&& rt.is_true(rt.identical(iife_result_5, rt.new_string('full'))) {
			mut iife_temp_6 := Class_VHttpd_WordPress_ProfilerEnv{}
			mut iife_result_6 := iife_temp_6.switchmode(rt.new_string('restricted'))
		}
		if !(rt.get_superglobal('_POST').array_isset(rt.new_string('v_profiler_action'))) {
			return rt.new_null()
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('manage_options'),
		])))))
		{
			rt.call_function('wp_die', [rt.new_string('Unauthorized action.')])
		}
		rt.call_function('check_admin_referer', [
			rt.new_string('v_profiler_admin_action'),
			rt.new_string('v_profiler_nonce'),
		])
		mut var_action := rt.call_function('sanitize_text_field', [
			rt.get_superglobal('_POST').array_get(rt.new_string('v_profiler_action')),
		])
		mut var_redirect_url := rt.call_function('admin_url', [
			rt.new_string('admin.php?page=v-profiler-settings'),
		])
		if rt.get_superglobal('_SERVER').array_isset(rt.new_string('REQUEST_URI')) {
			var_redirect_url = rt.call_function('remove_query_arg', [
				rt.create_array([rt.ArrayItem{ key: none, val: 'v_error' },
					rt.ArrayItem{ key: none, val: 'v_success' }]),
				rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')),
			])
		}
		if rt.is_true(rt.identical(var_action, rt.new_string('switch_mode'))) {
			mut var_target_mode := rt.call_function('sanitize_text_field', [if !(rt.get_superglobal('_POST').array_get(rt.new_string('target_mode'))).is_null() {
				rt.get_superglobal('_POST').array_get(rt.new_string('target_mode'))
			} else {
				rt.new_string('restricted')
			}])
			mut iife_temp_7 := Class_VHttpd_WordPress_ProfilerEnv{}
			mut iife_result_7 := iife_temp_7.isvhttpd()
			if rt.is_true(rt.identical(var_target_mode, rt.new_string('full')))
				&& rt.is_true(rt.new_bool(!(rt.is_true(iife_result_7)))) {
				rt.call_function('wp_safe_redirect', [
					rt.call_function('add_query_arg', [rt.new_string('v_error'),
						rt.new_string('not_vhttpd'), var_redirect_url.clone()]),
				])
				exit(0)
			}
			mut iife_temp_8 := Class_VHttpd_WordPress_ProfilerEnv{}
			mut iife_result_8 := iife_temp_8.getwpcontentdir()
			mut var_contentDir := iife_result_8
			if rt.is_true(rt.identical(var_target_mode, rt.new_string('full')))
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_writable', [var_contentDir.clone()]))))) {
				rt.call_function('wp_safe_redirect', [
					rt.call_function('add_query_arg', [rt.new_string('v_error'),
						rt.new_string('dir_not_writable'), var_redirect_url.clone()]),
				])
				exit(0)
			}
			mut iife_temp_9 := Class_VHttpd_WordPress_ProfilerEnv{}
			mut iife_result_9 := iife_temp_9.switchmode(var_target_mode.clone())
			if rt.is_true(iife_result_9) {
				mut var_suc_arg := rt.new_string((if rt.is_true(rt.identical(var_target_mode,
					rt.new_string('full')))
				{
					'mode_upgraded'
				} else {
					'mode_downgraded'
				}).str())
				rt.call_function('wp_safe_redirect', [
					rt.call_function('add_query_arg', [rt.new_string('v_success'),
						var_suc_arg.clone(), var_redirect_url.clone()]),
				])
			} else {
				mut var_err_arg := rt.new_string((if rt.is_true(rt.identical(var_target_mode,
					rt.new_string('full')))
				{
					'copy_failed'
				} else {
					'delete_db_failed'
				}).str())
				rt.call_function('wp_safe_redirect', [
					rt.call_function('add_query_arg', [rt.new_string('v_error'),
						var_err_arg.clone(), var_redirect_url.clone()]),
				])
			}
			exit(0)
		}
		return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('admin_init'),
		rt.new_closure(closure_10_fn)])
}

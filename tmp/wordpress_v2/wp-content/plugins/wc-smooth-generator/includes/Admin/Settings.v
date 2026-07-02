import rt

pub fn Class_WC_SmoothGenerator_Admin_Settings.default_num_products() i64 {
	return 10
}

pub fn Class_WC_SmoothGenerator_Admin_Settings.default_num_orders() i64 {
	return 10
}

struct Class_WC_SmoothGenerator_Admin_Settings {
	rt.PhpObjectBase
}

fn Class_WC_SmoothGenerator_Admin_Settings.init() {
	rt.call_function('add_action', [rt.new_string('admin_menu'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'register_admin_menu' }])])
	rt.call_function('add_filter', [rt.new_string('heartbeat_received'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'receive_heartbeat' }]),
		rt.new_int(10), rt.new_int(3)])
}

fn Class_WC_SmoothGenerator_Admin_Settings.register_admin_menu() {
	mut var_hook := rt.call_function('add_management_page', [
		rt.new_string('WooCommerce Smooth Generator'),
		rt.new_string('Smooth Generator'),
		rt.new_string('install_plugins'),
		rt.new_string('smoothgenerator'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'render_admin_page' }]),
	])
	rt.call_function('add_action', [rt.new_string('load-${var_hook.to_string()}'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'process_page_submit' }])])
}

fn Class_WC_SmoothGenerator_Admin_Settings.render_admin_page() {
	mut var_current_job := Class_WC_SmoothGenerator_Admin_Settings.get_current_job()
	mut var_generate_button_atts := if rt.is_true(rt.new_bool(rt.instance_of(var_current_job, 'WC_SmoothGenerator_Admin_AsyncJob'))) { rt.create_array([
			rt.ArrayItem{ key: 'disabled', val: true },
		]) } else { rt.new_array() }
	mut var_cancel_button_atts := if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_current_job, 'WC_SmoothGenerator_Admin_AsyncJob')))))) { rt.create_array([
			rt.ArrayItem{ key: 'disabled', val: true },
		]) } else { rt.new_array() }
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(Class_WC_SmoothGenerator_Admin_Settings.while_you_wait())
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(rt.instance_of(var_current_job, 'WC_SmoothGenerator_Admin_AsyncJob'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [rt.new_string('Generating %s %s&hellip;'),
			rt.call_function('number_format_i18n', [
				rt.get_property(var_current_job, 'amount'),
			]),
			rt.call_function('esc_html', [
				rt.get_property(var_current_job, 'generator_slug'),
			])])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.get_property(var_current_job, 'amount'),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(if rt.is_true(rt.get_property(var_current_job, 'processed')) { rt.call_function('esc_attr', [
				rt.get_property(var_current_job, 'processed'),
			]) } else { rt.new_string('') })
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [rt.new_string('%d out of %d'),
			rt.call_function('esc_html', [rt.get_property(var_current_job, 'processed')]),
			rt.call_function('esc_html', [rt.get_property(var_current_job, 'amount')])])
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.call_function('filter_input', [rt.get_constant('INPUT_POST'),
		rt.new_string('cancel_job')]))
	{
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('generate'),
		rt.new_string('smoothgenerator_nonce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		Class_WC_SmoothGenerator_Admin_WC_SmoothGenerator_Admin_Settings.default_num_products(),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('disabled', [
		rt.new_bool(rt.instance_of(var_current_job, 'WC_SmoothGenerator_Admin_AsyncJob')),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('submit_button', [rt.new_string('Generate'),
		rt.new_string('primary'), rt.new_string('generate_products'),
		rt.new_bool(false), var_generate_button_atts.clone()])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		Class_WC_SmoothGenerator_Admin_WC_SmoothGenerator_Admin_Settings.default_num_orders(),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('disabled', [
		rt.new_bool(rt.instance_of(var_current_job, 'WC_SmoothGenerator_Admin_AsyncJob')),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('submit_button', [rt.new_string('Generate'),
		rt.new_string('primary'), rt.new_string('generate_orders'),
		rt.new_bool(false), var_generate_button_atts.clone()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('disabled', [
		rt.new_bool(rt.instance_of(var_current_job, 'WC_SmoothGenerator_Admin_AsyncJob')),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('date', [rt.new_string('Y-m-d')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('disabled', [
		rt.new_bool(rt.instance_of(var_current_job, 'WC_SmoothGenerator_Admin_AsyncJob')),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('date', [rt.new_string('Y-m-d')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('disabled', [
		rt.new_bool(rt.instance_of(var_current_job, 'WC_SmoothGenerator_Admin_AsyncJob')),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('submit_button', [rt.new_string('Cancel current job'),
		rt.new_string('secondary'), rt.new_string('cancel_job'),
		rt.new_bool(true), var_cancel_button_atts.clone()])
	// unsupported statement: Stmt_InlineHTML
	Class_WC_SmoothGenerator_Admin_Settings.heartbeat_script()
	Class_WC_SmoothGenerator_Admin_Settings.date_range_toggle_script()
}

fn Class_WC_SmoothGenerator_Admin_Settings.date_range_toggle_script() {
	// unsupported statement: Stmt_InlineHTML
}

fn Class_WC_SmoothGenerator_Admin_Settings.heartbeat_script() {
	// unsupported statement: Stmt_InlineHTML
}

fn Class_WC_SmoothGenerator_Admin_Settings.receive_heartbeat(mut var_response Class_WC_SmoothGenerator_Admin_array, mut var_data Class_WC_SmoothGenerator_Admin_array, var_screen_id rt.PhpVal) rt.PhpVal {
	mut var_response_mutated := var_response
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('tools_page_smoothgenerator'), var_screen_id))))
		|| !rt.is_true(var_data.array_get(rt.new_string('smoothgenerator'))) {
		return rt.new_object('WC_SmoothGenerator_Admin_array', []string{}, var_response_mutated)
	}
	mut var_current_job := Class_WC_SmoothGenerator_Admin_Settings.get_current_job()
	if rt.is_true(rt.new_bool(rt.instance_of(var_current_job, 'WC_SmoothGenerator_Admin_AsyncJob'))) {
		var_response_mutated.array_set('smoothgenerator_async_job_progress',
			var_current_job.clone())
		var_response_mutated.array_set('smoothgenerator_ping_cron', rt.call_function('site_url', [
			rt.new_string('wp-cron.php'),
		]))
	} else {
		var_response_mutated.array_set('smoothgenerator_async_job_progress', 'complete')
	}
	return rt.new_object('WC_SmoothGenerator_Admin_array', []string{}, var_response_mutated)
}

fn Class_WC_SmoothGenerator_Admin_Settings.process_page_submit() {
	mut var_args := rt.new_array()
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('use_date_range')))) {
		var_args.array_set('date-start', rt.call_function('sanitize_text_field', [
			rt.get_superglobal('_POST').array_get(rt.new_string('start_date')),
		]))
		var_args.array_set('date-end', rt.call_function('sanitize_text_field', [
			rt.get_superglobal('_POST').array_get(rt.new_string('end_date')),
		]))
	}
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('generate_products'))))
		&& !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('num_products_to_generate')))) {
		rt.call_function('check_admin_referer', [rt.new_string('generate'),
			rt.new_string('smoothgenerator_nonce')])
		mut var_num_to_generate := rt.call_function('absint', [
			rt.get_superglobal('_POST').array_get(rt.new_string('num_products_to_generate')),
		])
		mut iife_temp_0 := Class_WC_SmoothGenerator_Admin_BatchProcessor{}
		mut iife_result_0 := iife_temp_0.create_new_job(rt.new_string('products'),
			var_num_to_generate.clone(), var_args.clone())
	} else {
		if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('generate_orders'))))
			&& !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('num_orders_to_generate')))) {
			rt.call_function('check_admin_referer', [rt.new_string('generate'),
				rt.new_string('smoothgenerator_nonce')])
			var_num_to_generate = rt.call_function('absint', [
				rt.get_superglobal('_POST').array_get(rt.new_string('num_orders_to_generate')),
			])
			mut iife_temp_1 := Class_WC_SmoothGenerator_Admin_BatchProcessor{}
			mut iife_result_1 := iife_temp_1.create_new_job(rt.new_string('orders'),
				var_num_to_generate.clone(), var_args.clone())
		} else {
			if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('cancel_job')))) {
				rt.call_function('check_admin_referer', [rt.new_string('generate'),
					rt.new_string('smoothgenerator_nonce')])
				mut iife_temp_2 := Class_WC_SmoothGenerator_Admin_BatchProcessor{}
				mut iife_result_2 := iife_temp_2.delete_current_job()
			}
		}
	}
}

fn Class_WC_SmoothGenerator_Admin_Settings.get_current_job() rt.PhpVal {
	mut iife_temp_3 := Class_WC_SmoothGenerator_Admin_BatchProcessor{}
	mut iife_result_3 := iife_temp_3.get_current_job()
	return iife_result_3
}

fn Class_WC_SmoothGenerator_Admin_Settings.while_you_wait() rt.PhpVal {
	mut var_current_job := Class_WC_SmoothGenerator_Admin_Settings.get_current_job()
	mut var_content := rt.new_string('')
	if rt.is_true(rt.call_function('filter_input', [rt.get_constant('INPUT_POST'), rt.new_string('smoothgenerator_nonce')]))
		|| rt.is_true(rt.new_bool(rt.instance_of(var_current_job, 'WC_SmoothGenerator_Admin_AsyncJob'))) {
		if rt.is_true(rt.call_function('filter_input', [rt.get_constant('INPUT_POST'),
			rt.new_string('cancel_job')]))
		{
			mut var_embed := rt.new_string('NF9Y3GVuPfY')
		} else {
			mut var_videos := rt.create_array([
				rt.ArrayItem{ key: none, val: '4TYv2PhG89A' },
				rt.ArrayItem{ key: none, val: '6Whgn_iE5uc' },
				rt.ArrayItem{ key: none, val: 'h_D3VFfhvs4' },
				rt.ArrayItem{ key: none, val: 'QcjAXI4jANw' },
			])
			mut var_next_wait := rt.call_function('filter_input', [
				rt.get_constant('INPUT_COOKIE'),
				rt.new_string('smoothgenerator_next_wait'),
			])
			if !(var_videos.array_isset(var_next_wait)) {
				var_next_wait = rt.new_int(0)
			}
			var_embed = var_videos.array_get(var_next_wait)
			rt.post_inc(var_next_wait)
			rt.call_function('setcookie', [rt.new_string('smoothgenerator_next_wait'),
				var_next_wait.clone(),
				rt.create_array([
					rt.ArrayItem{ key: 'expires', val: rt.add(rt.call_function('time',
						[]rt.PhpVal{}), rt.get_constant('WEEK_IN_SECONDS')) },
					rt.ArrayItem{ key: 'path', val: rt.get_constant('ADMIN_COOKIE_PATH') },
					rt.ArrayItem{ key: 'domain', val: rt.get_constant('COOKIE_DOMAIN') },
					rt.ArrayItem{ key: 'secure', val: rt.call_function('is_ssl', []rt.PhpVal{}) },
					rt.ArrayItem{ key: 'samesite', val: 'strict' },
				])])
		}
		var_content =
			rt.new_string("<h2>While you wait...</h2>\n<div class=\"wp-block-embed__wrapper\" style=\"margin: 2em 0;\"><iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/${var_embed.to_string()}?autoplay=1&fs=0&iv_load_policy=3&showinfo=0&rel=0&cc_load_policy=0&start=0&end=0\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share\" allowfullscreen>></iframe></div>")
	}
	return var_content.clone()
}

struct Class_WC_SmoothGenerator_Admin_BatchProcessor {
	rt.PhpObjectBase
}

fn create_wc_smoothgenerator_admin_settings(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Admin_Settings {
	mut obj := &Class_WC_SmoothGenerator_Admin_Settings{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_admin_batchprocessor(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Admin_BatchProcessor {
	mut obj := &Class_WC_SmoothGenerator_Admin_BatchProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_SmoothGenerator_Admin_Settings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_WC_SmoothGenerator_Admin_Settings.init()
			return rt.new_null()
		}
		'register_admin_menu' {
			Class_WC_SmoothGenerator_Admin_Settings.register_admin_menu()
			return rt.new_null()
		}
		'render_admin_page' {
			Class_WC_SmoothGenerator_Admin_Settings.render_admin_page()
			return rt.new_null()
		}
		'date_range_toggle_script' {
			Class_WC_SmoothGenerator_Admin_Settings.date_range_toggle_script()
			return rt.new_null()
		}
		'heartbeat_script' {
			Class_WC_SmoothGenerator_Admin_Settings.heartbeat_script()
			return rt.new_null()
		}
		'receive_heartbeat' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_SmoothGenerator_Admin_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WC_SmoothGenerator_Admin_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_WC_SmoothGenerator_Admin_Settings.receive_heartbeat(mut dispatch_arg_0, mut
				dispatch_arg_1, dispatch_arg_2)
		}
		'process_page_submit' {
			Class_WC_SmoothGenerator_Admin_Settings.process_page_submit()
			return rt.new_null()
		}
		'get_current_job' {
			return Class_WC_SmoothGenerator_Admin_Settings.get_current_job()
		}
		'while_you_wait' {
			return Class_WC_SmoothGenerator_Admin_Settings.while_you_wait()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_SmoothGenerator_Admin_Settings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Admin_Settings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_SmoothGenerator_Admin_BatchProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Admin_BatchProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Admin_BatchProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

import rt

fn wp_scripts() rt.PhpVal {
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_wp_scripts, 'WP_Scripts')))))) {
		mut var_wp_scripts := create_wp_scripts()
	}
	return var_wp_scripts.dup()
}

fn _wp_scripts_maybe_doing_it_wrong(var_function_name rt.PhpVal, handle string) {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('did_action', [rt.new_string('init')])) || rt.is_true(rt.call_function('did_action', [rt.new_string('wp_enqueue_scripts')])))) || rt.is_true(rt.call_function('did_action', [rt.new_string('admin_enqueue_scripts')])))) || rt.is_true(rt.call_function('did_action', [rt.new_string('login_enqueue_scripts')])))) {
		return rt.new_null()
	}
	mut var_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Scripts and styles should not be registered or enqueued until the %1$s, %2$s, or %3$s hooks.')]), rt.new_string('<code>wp_enqueue_scripts</code>'), rt.new_string('<code>admin_enqueue_scripts</code>'), rt.new_string('<code>login_enqueue_scripts</code>')])
	if var_handle.len > 0 && var_handle != '0' {
		// unsupported expression: Expr_AssignOp_Concat
	}
	rt.call_function('_doing_it_wrong', [var_function_name.dup(), var_message.dup(), rt.new_string('3.3.0')])
}

fn _wp_scripts_add_args_data(var_wp_scripts rt.PhpVal, handle string, var_args rt.PhpVal) {
	mut var_allowed_keys := ['strategy', 'in_footer', 'fetchpriority', 'module_dependencies']
	mut var_unknown_keys := rt.call_function('array_diff', [rt.func_array_keys(var_args.dup()), var_allowed_keys.dup()])
	if !(!rt.is_true(var_unknown_keys)) {
		mut var_trace := rt.call_function('debug_backtrace', [rt.get_constant('DEBUG_BACKTRACE_IGNORE_ARGS'), rt.new_int(2)])
		mut var_function_name := rt.new_string((if !(var_trace.array_get(1).array_get('class')).is_null() { var_trace.array_get(1).array_get('class') } else { rt.new_string('') }).str() + (if !(var_trace.array_get(1).array_get('type')).is_null() { var_trace.array_get(1).array_get('type') } else { rt.new_string('') }).str() + (if !(var_trace.array_get(1).array_get('function')).is_null() { var_trace.array_get(1).array_get('function') } else { rt.new_string(@FN) }).str())
		rt.call_function('_doing_it_wrong', [var_function_name.dup(), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Unrecognized key(s) in the %1$s param: %2$s. Supported keys: %3$s')]), rt.new_string('$args'), rt.call_function('implode', [rt.call_function('wp_get_list_item_separator', []rt.PhpVal{}), var_unknown_keys.dup()]), rt.call_function('implode', [rt.call_function('wp_get_list_item_separator', []rt.PhpVal{}), var_allowed_keys.dup()])]), rt.new_string('7.0.0')])
	}
	mut var_in_footer := !(!rt.is_true(var_args.array_get('in_footer')))
	if var_in_footer {
		rt.call_method(var_wp_scripts, 'add_data', [rt.new_string(handle), rt.new_string('group'), rt.new_int(1)])
	}
	if !(!rt.is_true(var_args.array_get('strategy'))) {
		rt.call_method(var_wp_scripts, 'add_data', [rt.new_string(handle), rt.new_string('strategy'), var_args.array_get('strategy')])
	}
	if !(!rt.is_true(var_args.array_get('fetchpriority'))) {
		rt.call_method(var_wp_scripts, 'add_data', [rt.new_string(handle), rt.new_string('fetchpriority'), var_args.array_get('fetchpriority')])
	}
	if !(!rt.is_true(var_args.array_get('module_dependencies'))) {
		rt.call_method(var_wp_scripts, 'add_data', [rt.new_string(handle), rt.new_string('module_dependencies'), var_args.array_get('module_dependencies')])
		mut var_is_deferred := (rt.identical(rt.new_string('defer'), if !(var_args.array_get('strategy')).is_null() { var_args.array_get('strategy') } else { rt.new_null() })).to_bool()
		if !(var_in_footer) && !(var_is_deferred) {
			var_trace = rt.call_function('debug_backtrace', [rt.get_constant('DEBUG_BACKTRACE_IGNORE_ARGS'), rt.new_int(2)])
			var_function_name = rt.new_string((if !(var_trace.array_get(1).array_get('class')).is_null() { var_trace.array_get(1).array_get('class') } else { rt.new_string('') }).str() + (if !(var_trace.array_get(1).array_get('type')).is_null() { var_trace.array_get(1).array_get('type') } else { rt.new_string('') }).str() + (if !(var_trace.array_get(1).array_get('function')).is_null() { var_trace.array_get(1).array_get('function') } else { rt.new_string(@FN) }).str())
			rt.call_function('_doing_it_wrong', [var_function_name.dup(), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('When the %1$s arg is provided, the "%2$s" script must either be printed in the footer (%3$s set to true) or use a deferred loading %4$s (%5$s) so that the import map is printed before the script is evaluated.')]), rt.new_string('<code>module_dependencies</code>'), rt.new_string(handle), rt.new_string('<code>in_footer</code>'), rt.new_string('<code>strategy</code>'), rt.new_string('<code>defer</code>')]), rt.new_string('7.0.0')])
		}
	}
}

fn wp_print_scripts(handles bool) rt.PhpVal {
	mut var_wp_scripts := rt.new_null()
	// unsupported statement: Stmt_Global
	rt.call_function('do_action', [rt.new_string('wp_print_scripts')])
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_bool(handles))) {
		handles = false
	}
	_wp_scripts_maybe_doing_it_wrong(rt.new_string(@FN), '')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_wp_scripts, 'WP_Scripts')))))) {
		if !(var_handles) {
			return rt.new_array()
			// unsupported statement: Stmt_Nop
		}
	}
	return rt.call_method(wp_scripts(), 'do_items', [rt.new_bool(handles)])
}

fn wp_add_inline_script(var_handle rt.PhpVal, var_data rt.PhpVal, position string) rt.PhpVal {
	_wp_scripts_maybe_doing_it_wrong(rt.new_string(@FN), var_handle.dup())
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Do not pass %1$s tags to %2$s.')]), rt.new_string('<code>&lt;script&gt;</code>'), rt.new_string('<code>wp_add_inline_script()</code>')]), rt.new_string('4.5.0')])
		var_data = // unsupported expression: Expr_Cast_String.to_string().trim_space()
	}
	return rt.call_method(wp_scripts(), 'add_inline_script', [var_handle.dup(), rt.new_string(var_data).dup(), rt.new_string(position)])
}

fn wp_register_script(var_handle rt.PhpVal, var_src rt.PhpVal, var_deps rt.PhpVal, ver bool, var_args rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args.dup().is_array()))))) {
		var_args = { 'in_footer': // unsupported expression: Expr_Cast_Bool }
	}
	_wp_scripts_maybe_doing_it_wrong(rt.new_string(@FN), var_handle.dup())
	mut var_wp_scripts := wp_scripts()
	mut var_registered := rt.call_method(var_wp_scripts, 'add', [var_handle.dup(), var_src.dup(), var_deps.dup(), rt.new_bool(ver)])
	_wp_scripts_add_args_data(var_wp_scripts.dup(), var_handle.dup(), var_args.dup())
	return var_registered.dup()
}

fn wp_localize_script(var_handle rt.PhpVal, var_object_name rt.PhpVal, var_l10n rt.PhpVal) rt.PhpVal {
	mut var_wp_scripts := wp_scripts()
	return rt.call_method(var_wp_scripts, 'localize', [var_handle.dup(), var_object_name.dup(), var_l10n.dup()])
}

fn wp_set_script_translations(var_handle rt.PhpVal, domain string, path string) bool {
	mut var_wp_scripts := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_wp_scripts, 'WP_Scripts')))))) {
		_wp_scripts_maybe_doing_it_wrong(rt.new_string(@FN), var_handle.dup())
		return false
	}
	return (rt.call_method(var_wp_scripts, 'set_translations', [var_handle.dup(), rt.new_string(domain), rt.new_string(path)])).to_bool()
}

fn wp_deregister_script(var_handle rt.PhpVal) {
	mut var_pagenow := rt.new_null()
	// unsupported statement: Stmt_Global
	_wp_scripts_maybe_doing_it_wrong(rt.new_string(@FN), var_handle.dup())
	mut var_current_filter := rt.call_function('current_filter', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) || rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('wp-login.php'), var_pagenow)) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))))) {
		mut var_not_allowed := ['jquery', 'jquery-core', 'jquery-migrate', 'jquery-ui-core', 'jquery-ui-accordion', 'jquery-ui-autocomplete', 'jquery-ui-button', 'jquery-ui-datepicker', 'jquery-ui-dialog', 'jquery-ui-draggable', 'jquery-ui-droppable', 'jquery-ui-menu', 'jquery-ui-mouse', 'jquery-ui-position', 'jquery-ui-progressbar', 'jquery-ui-resizable', 'jquery-ui-selectable', 'jquery-ui-slider', 'jquery-ui-sortable', 'jquery-ui-spinner', 'jquery-ui-tabs', 'jquery-ui-tooltip', 'jquery-ui-widget', 'underscore', 'backbone']
		if rt.is_true(rt.call_function('in_array', [var_handle.dup(), var_not_allowed.dup(), rt.new_bool(true)])) {
			rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Do not deregister the %1$s script in the administration area. To target the front-end theme, use the %2$s hook.')]), rt.new_string("<code>${var_handle.to_string()}</code>"), rt.new_string('<code>wp_enqueue_scripts</code>')]), rt.new_string('3.6.0')])
			return rt.new_null()
		}
	}
	rt.call_method(wp_scripts(), 'remove', [var_handle.dup()])
}

fn wp_enqueue_script(var_handle rt.PhpVal, src string, var_deps rt.PhpVal, ver bool, var_args rt.PhpVal) {
	_wp_scripts_maybe_doing_it_wrong(rt.new_string(@FN), var_handle.dup())
	mut var_wp_scripts := wp_scripts()
	if var_src.len > 0 && var_src != '0' || !(!rt.is_true(var_args)) {
		mut var__handle := rt.call_function('explode', [rt.new_string('?'), var_handle.dup()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args.dup().is_array()))))) {
			var_args = { 'in_footer': // unsupported expression: Expr_Cast_Bool }
		}
		if var_src.len > 0 && var_src != '0' {
			rt.call_method(var_wp_scripts, 'add', [var__handle.array_get(0), rt.new_string(src), var_deps.dup(), rt.new_bool(ver)])
		}
		if !(!rt.is_true(var_args)) {
			_wp_scripts_add_args_data(var_wp_scripts.dup(), var__handle.array_get(0), var_args.dup())
		}
	}
	rt.call_method(var_wp_scripts, 'enqueue', [var_handle.dup()])
}

fn wp_dequeue_script(var_handle rt.PhpVal) {
	_wp_scripts_maybe_doing_it_wrong(rt.new_string(@FN), var_handle.dup())
	rt.call_method(wp_scripts(), 'dequeue', [var_handle.dup()])
}

fn wp_script_is(var_handle rt.PhpVal, status string) rt.PhpVal {
	_wp_scripts_maybe_doing_it_wrong(rt.new_string(@FN), var_handle.dup())
	return // unsupported expression: Expr_Cast_Bool
}

fn wp_script_add_data(var_handle rt.PhpVal, var_key rt.PhpVal, var_value rt.PhpVal) rt.PhpVal {
	return rt.call_method(wp_scripts(), 'add_data', [var_handle.dup(), var_key.dup(), var_value.dup()])
}

struct Class_WP_Scripts {
	rt.PhpObjectBase
}

fn create_wp_scripts() &Class_WP_Scripts {
	mut obj := &Class_WP_Scripts{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Scripts) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Scripts) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Scripts) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_functions_wp_scripts_php() {
}

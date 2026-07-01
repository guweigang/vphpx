import rt

fn wp_styles() rt.PhpVal {
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_wp_styles, 'WP_Styles')))))) {
		mut var_wp_styles := create_wp_styles()
	}
	return var_wp_styles.dup()
}

fn wp_print_styles(handles bool) rt.PhpVal {
	mut var_wp_styles := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_bool(handles))) {
		handles = false
	}
	if !(var_handles) {
		rt.call_function('do_action', [rt.new_string('wp_print_styles')])
	}
	rt.call_function('_wp_scripts_maybe_doing_it_wrong', [rt.new_string(@FN)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_wp_styles, 'WP_Styles')))))) {
		if !(var_handles) {
			return rt.new_array()
			// unsupported statement: Stmt_Nop
		}
	}
	return rt.call_method(wp_styles(), 'do_items', [rt.new_bool(handles)])
}

fn wp_add_inline_style(var_handle rt.PhpVal, var_data rt.PhpVal) rt.PhpVal {
	rt.call_function('_wp_scripts_maybe_doing_it_wrong', [rt.new_string(@FN), var_handle.dup()])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Do not pass %1$s tags to %2$s.')]), rt.new_string('<code>&lt;style&gt;</code>'), rt.new_string('<code>wp_add_inline_style()</code>')]), rt.new_string('3.7.0')])
		var_data = // unsupported expression: Expr_Cast_String.to_string().trim_space()
	}
	return rt.call_method(wp_styles(), 'add_inline_style', [var_handle.dup(), rt.new_string(var_data).dup()])
}

fn wp_register_style(var_handle rt.PhpVal, var_src rt.PhpVal, var_deps rt.PhpVal, ver bool, media string) rt.PhpVal {
	rt.call_function('_wp_scripts_maybe_doing_it_wrong', [rt.new_string(@FN), var_handle.dup()])
	return rt.call_method(wp_styles(), 'add', [var_handle.dup(), var_src.dup(), var_deps.dup(), rt.new_bool(ver), rt.new_string(media)])
}

fn wp_deregister_style(var_handle rt.PhpVal) {
	rt.call_function('_wp_scripts_maybe_doing_it_wrong', [rt.new_string(@FN), var_handle.dup()])
	rt.call_method(wp_styles(), 'remove', [var_handle.dup()])
}

fn wp_enqueue_style(var_handle rt.PhpVal, src string, var_deps rt.PhpVal, ver bool, media string) {
	rt.call_function('_wp_scripts_maybe_doing_it_wrong', [rt.new_string(@FN), var_handle.dup()])
	mut var_wp_styles := wp_styles()
	if var_src.len > 0 && var_src != '0' {
		mut var__handle := rt.call_function('explode', [rt.new_string('?'), var_handle.dup()])
		rt.call_method(var_wp_styles, 'add', [var__handle.array_get(0), rt.new_string(src), var_deps.dup(), rt.new_bool(ver), rt.new_string(media)])
	}
	rt.call_method(var_wp_styles, 'enqueue', [var_handle.dup()])
}

fn wp_dequeue_style(var_handle rt.PhpVal) {
	rt.call_function('_wp_scripts_maybe_doing_it_wrong', [rt.new_string(@FN), var_handle.dup()])
	rt.call_method(wp_styles(), 'dequeue', [var_handle.dup()])
}

fn wp_style_is(var_handle rt.PhpVal, status string) rt.PhpVal {
	rt.call_function('_wp_scripts_maybe_doing_it_wrong', [rt.new_string(@FN), var_handle.dup()])
	return // unsupported expression: Expr_Cast_Bool
}

fn wp_style_add_data(var_handle rt.PhpVal, var_key rt.PhpVal, var_value rt.PhpVal) rt.PhpVal {
	return rt.call_method(wp_styles(), 'add_data', [var_handle.dup(), var_key.dup(), var_value.dup()])
}

struct Class_WP_Styles {
	rt.PhpObjectBase
}

fn create_wp_styles() &Class_WP_Styles {
	mut obj := &Class_WP_Styles{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Styles) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Styles) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Styles) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_functions_wp_styles_php() {
}

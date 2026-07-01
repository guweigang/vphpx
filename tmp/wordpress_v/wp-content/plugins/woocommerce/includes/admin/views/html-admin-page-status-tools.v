import rt

struct Class_Automattic_WooCommerce_Utilities_ArrayUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_utilities_arrayutil() &Class_Automattic_WooCommerce_Utilities_ArrayUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_ArrayUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Utilities_ArrayUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_ArrayUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_ArrayUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_admin_views_html_admin_page_status_tools_php() {
	mut var_tools := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	{
		mut iter_1 := var_tools.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_tool := item_1.val
			mut var_action_name := item_1.key
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', ['form_' + (var_action_name).str()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('admin.php?foo=bar')])])]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('wp_nonce_field', [rt.new_string('debug_action'), rt.new_string('_wpnonce'), rt.new_bool(false)])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_action_name.dup()]))
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := var_tools.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_tool := item_1.val
			mut var_action_name := item_1.key
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('sanitize_html_class', [var_action_name.dup()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [var_tool.array_get('name')]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wp_kses_post', [var_tool.array_get('desc')]))
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}; return temp.get_value_or_default(arg_0, arg_1) }(var_tool.dup(), rt.new_string('selector')).is_null()))))) {
				mut var_selector := var_tool.array_get('selector')
				if var_selector.array_isset(rt.new_string('description')) {
					print('</p><p class="description">')
					rt.echo_val(rt.call_function('wp_kses_post', [var_selector.array_get('description')]))
				}
				print(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('&nbsp;&nbsp;<select style=\'width: 300px;\' form=\'form_'), var_action_name), rt.new_string('\' id=\'selector_')), var_action_name), rt.new_string('\' data-allow_clear=\'true\' class=\'')), var_selector.array_get('class')), rt.new_string('\' name=\'')), var_selector.array_get('name')), rt.new_string('\' data-placeholder=\'')), var_selector.array_get('placeholder')), rt.new_string('\' data-action=\'')), var_selector.array_get('search_action')), rt.new_string('\'></select>')))
			}
			// unsupported statement: Stmt_InlineHTML
			if !(!rt.is_true(var_tool.array_get('status_text'))) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('wp_kses_post', [var_tool.array_get('status_text')]))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
			// unsupported statement: Stmt_Nop
			// unsupported statement: Stmt_InlineHTML
			print(if rt.is_true(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}; return temp.is_truthy(arg_0, arg_1) }(var_tool.dup(), rt.new_string('disabled'))) { 'disabled' } else { '' })
			// unsupported statement: Stmt_InlineHTML
			print('form_' + (var_action_name).str())
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_tool.array_get('button')]))
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
}

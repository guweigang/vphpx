import rt

struct Class_Automattic_WooCommerce_Utilities_ArrayUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_utilities_arrayutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_ArrayUtil {
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

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_tools := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	mut iter_1 := var_tools.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_tool := item_1.val
		mut var_action_name := item_1.key
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.new_string('form_' + var_action_name.str()),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.call_function('esc_url', [
				rt.call_function('admin_url', [rt.new_string('admin.php?foo=bar')]),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_nonce_field', [rt.new_string('debug_action'),
			rt.new_string('_wpnonce'), rt.new_bool(false)])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_action_name.clone()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	mut iter_2 := var_tools.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_tool := item_2.val
		mut var_action_name := item_2.key
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('sanitize_html_class', [
			var_action_name.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_tool.array_get(rt.new_string('name'))]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses_post', [
			var_tool.array_get(rt.new_string('desc')),
		]))
		mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
		mut iife_result_0 := iife_temp_0.get_value_or_default(var_tool.clone(),
			rt.new_string('selector'))
		mut iife_temp_1 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
		mut iife_result_1 := iife_temp_1.get_value_or_default(var_tool.clone(),
			rt.new_string('selector'))
		if !(iife_result_0.is_null()) {
			mut var_selector := var_tool.array_get(rt.new_string('selector'))
			if var_selector.array_isset(rt.new_string('description')) {
				print('</p><p class="description">')
				rt.echo_val(rt.call_function('wp_kses_post', [
					var_selector.array_get(rt.new_string('description')),
				]))
			}
			print(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string("&nbsp;&nbsp;<select style='width: 300px;' form='form_"),
				var_action_name), rt.new_string("' id='selector_")), var_action_name),
				rt.new_string("' data-allow_clear='true' class='")),
				var_selector.array_get(rt.new_string('class'))), rt.new_string("' name='")),
				var_selector.array_get(rt.new_string('name'))),
				rt.new_string("' data-placeholder='")),
				var_selector.array_get(rt.new_string('placeholder'))),
				rt.new_string("' data-action='")),
				var_selector.array_get(rt.new_string('search_action'))),
				rt.new_string("'></select>")))
		}
		// unsupported statement: Stmt_InlineHTML
		if !(!rt.is_true(var_tool.array_get(rt.new_string('status_text')))) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wp_kses_post', [
				var_tool.array_get(rt.new_string('status_text')),
			]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_InlineHTML
		mut iife_temp_2 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
		mut iife_result_2 := iife_temp_2.is_truthy(var_tool.clone(), rt.new_string('disabled'))
		print(if rt.is_true(iife_result_2) { 'disabled' } else { '' })
		// unsupported statement: Stmt_InlineHTML
		print('form_' + var_action_name.str())
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_tool.array_get(rt.new_string('button'))]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

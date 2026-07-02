import rt

struct Class_ {
	rt.PhpObjectBase
}

fn create_(_args ...rt.PhpVal) &Class_ {
	mut obj := &Class_{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_product_object := rt.new_null()
	mut var_post := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Product Type'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut iter_1 := rt.call_function('wc_get_product_types', []rt.PhpVal{}).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_label := item_1.val
		mut var_value := item_1.key
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_value.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('selected', [
			rt.call_method(var_product_object, 'get_type', []rt.PhpVal{}),
			var_value.clone(),
			rt.new_bool(false),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_label.clone()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	mut iife_temp_0 := Class_{}
	mut iife_result_0 := iife_temp_0.get_product_type_options()
	mut iter_2 := iife_result_0.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_option := item_2.val
		mut var_key := item_2.key
		if rt.is_true(rt.call_function('metadata_exists', [rt.new_string('post'),
			rt.get_property(var_post, 'ID'), rt.new_string('_' + var_key.str())]))
		{
			mut var_selected_value := if rt.call_function('is_callable', [
				rt.create_array([rt.ArrayItem{ key: none, val: var_product_object },
					rt.ArrayItem{ key: none, val: 'is_${var_key.to_string()}' }]),
			])
			{ rt.call_method(var_product_object, 'is_${var_key.to_string()}', []rt.PhpVal{}) } else { rt.identical(rt.new_string('yes'), rt.call_function('get_post_meta', [
					rt.get_property(var_post, 'ID'),
					rt.new_string('_' + var_key.str()),
					rt.new_bool(true),
				])) }
		} else {
			var_selected_value = rt.identical(rt.new_string('yes'), if var_option.array_isset(rt.new_string('default')) {
				var_option.array_get(rt.new_string('default'))
			} else {
				rt.new_string('no')
			})
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_option.array_get(rt.new_string('id'))]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			var_option.array_get(rt.new_string('wrapper_class')),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			var_option.array_get(rt.new_string('description')),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_option.array_get(rt.new_string('id'))]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_option.array_get(rt.new_string('id'))]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_option.array_get(rt.new_string('id'))]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('checked', [var_selected_value.clone(),
			rt.new_bool(true), rt.new_bool(false)]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_option.array_get(rt.new_string('label'))]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	mut iife_temp_1 := Class_{}
	mut iife_result_1 := iife_temp_1.get_product_data_tabs()
	mut iter_3 := iife_result_1.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_tab := item_3.val
		mut var_key := item_3.key
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_key.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_key.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [if var_tab.array_isset(rt.new_string('class')) { rt.call_function('implode', [
				rt.new_string(' '),
				rt.cast_array(var_tab.array_get(rt.new_string('class'))),
			]) } else { rt.new_string('') }]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_tab.array_get(rt.new_string('target'))]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_tab.array_get(rt.new_string('label'))]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_product_write_panel_tabs')])
	// unsupported statement: Stmt_InlineHTML
	mut iife_temp_2 := Class_{}
	mut iife_result_2 := iife_temp_2.output_tabs()
	mut iife_temp_3 := Class_{}
	mut iife_result_3 := iife_temp_3.output_variations()
	rt.call_function('do_action', [rt.new_string('woocommerce_product_data_panels')])
	rt.call_function('wc_do_deprecated_action', [
		rt.new_string('woocommerce_product_write_panels'),
		rt.new_array(),
		rt.new_string('2.6'),
		rt.new_string('Use woocommerce_product_data_panels action instead.'),
	])
	// unsupported statement: Stmt_InlineHTML
}

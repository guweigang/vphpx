import rt

struct Class_ {
	rt.PhpObjectBase
}

fn create_() &Class_ {
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



pub fn init_wp_content_plugins_woocommerce_includes_admin_meta_boxes_views_html_product_data_panel_php() {
	mut var_product_object := rt.new_null()
	mut var_post := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Product Type'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := rt.call_function('wc_get_product_types', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_label := item_1.val
			mut var_value := item_1.key
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_value.dup()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('selected', [rt.call_method(var_product_object, 'get_type', []rt.PhpVal{}), var_value.dup(), rt.new_bool(false)]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [var_label.dup()]))
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := fn () rt.PhpVal { mut temp := Class_{}; return temp.get_product_type_options() }().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_option := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.call_function('metadata_exists', [rt.new_string('post'), rt.get_property(var_post, 'ID'), '_' + (var_key).str()])) {
				mut var_selected_value := if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_product_object }, rt.ArrayItem{ key: none, val: "is_${var_key.to_string()}" }])])) { rt.call_method(var_product_object, "is_${var_key.to_string()}", []rt.PhpVal{}) } else { rt.identical(rt.new_string('yes'), rt.call_function('get_post_meta', [rt.get_property(var_post, 'ID'), '_' + (var_key).str(), rt.new_bool(true)])) }
			} else {
				var_selected_value = rt.identical(rt.new_string('yes'), if var_option.array_isset(rt.new_string('default')) { var_option.array_get('default') } else { rt.new_string('no') })
			}
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_option.array_get('id')]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_option.array_get('wrapper_class')]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_option.array_get('description')]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_option.array_get('id')]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_option.array_get('id')]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_option.array_get('id')]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('checked', [var_selected_value.dup(), rt.new_bool(true), rt.new_bool(false)]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [var_option.array_get('label')]))
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := fn () rt.PhpVal { mut temp := Class_{}; return temp.get_product_data_tabs() }().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_tab := item_1.val
			mut var_key := item_1.key
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_key.dup()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_key.dup()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [if var_tab.array_isset(rt.new_string('class')) { rt.call_function('implode', [rt.new_string(' '), rt.cast_array(var_tab.array_get('class'))]) } else { rt.new_string('') }]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_tab.array_get('target')]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [var_tab.array_get('label')]))
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_product_write_panel_tabs')])
	// unsupported statement: Stmt_InlineHTML
	fn () rt.PhpVal { mut temp := Class_{}; return temp.output_tabs() }()
	fn () rt.PhpVal { mut temp := Class_{}; return temp.output_variations() }()
	rt.call_function('do_action', [rt.new_string('woocommerce_product_data_panels')])
	rt.call_function('wc_do_deprecated_action', [rt.new_string('woocommerce_product_write_panels'), rt.new_array(), rt.new_string('2.6'), rt.new_string('Use woocommerce_product_data_panels action instead.')])
	// unsupported statement: Stmt_InlineHTML
}

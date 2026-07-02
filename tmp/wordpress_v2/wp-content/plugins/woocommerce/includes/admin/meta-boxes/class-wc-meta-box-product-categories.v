import rt

struct Class_WC_Meta_Box_Product_Categories {
	rt.PhpObjectBase
}

fn Class_WC_Meta_Box_Product_Categories.output(var_post rt.PhpVal, var_box rt.PhpVal) rt.PhpVal {
	mut var_categories_count := rt.new_int((rt.call_function('wp_count_terms', [
		rt.new_string('product_cat'),
	])).to_i64())
	if rt.is_true(rt.less_equal(var_categories_count, rt.call_function('apply_filters', [rt.new_string('woocommerce_product_category_metabox_search_threshold'), rt.new_int(5)])))
		&& rt.is_true(rt.call_function('function_exists', [rt.new_string('post_categories_meta_box')])) {
		return rt.call_function('post_categories_meta_box', [
			var_post.clone(), var_box.clone()])
	}
	mut var_defaults := {
		'taxonomy': 'category'
	}
	if !(var_box.array_isset(rt.new_string('args')))
		|| !(var_box.array_get(rt.new_string('args')).is_array()) {
		mut var_args := rt.new_array()
	} else {
		var_args = var_box.array_get(rt.new_string('args'))
	}
	mut var_parsed_args := rt.call_function('wp_parse_args', [
		var_args.clone(), rt.create_array_from_native_map(var_defaults)])
	mut var_tax_name := var_parsed_args.array_get(rt.new_string('taxonomy'))
	mut var_selected_categories := rt.call_function('wp_get_object_terms', [
		rt.get_property(var_post, 'ID'),
		rt.new_string('product_cat'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_tax_name.clone()]))
	// unsupported statement: Stmt_InlineHTML
	mut iter_1 := rt.cast_array(var_selected_categories).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_term := item_1.val
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_term, 'term_id')]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr', [var_tax_name.clone()])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_term, 'name')]))
		// unsupported statement: Stmt_InlineHTML
	}
	return rt.new_null()
}

fn create_wc_meta_box_product_categories(_args ...rt.PhpVal) &Class_WC_Meta_Box_Product_Categories {
	mut obj := &Class_WC_Meta_Box_Product_Categories{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Meta_Box_Product_Categories) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'output' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Meta_Box_Product_Categories.output(dispatch_arg_0, dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Meta_Box_Product_Categories) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Meta_Box_Product_Categories) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
}

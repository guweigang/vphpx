import rt

struct Class_WC_Product_Cat_Dropdown_Walker {
	rt.PhpObjectBase
pub mut:
		tree_type rt.PhpVal = rt.new_string('category')
		db_fields rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Product_Cat_Dropdown_Walker) start_el(var_output rt.PhpVal, var_cat rt.PhpVal, depth i64, var_args rt.PhpVal, current_object_id i64)  {
	if !(!rt.is_true(var_args.array_get('hierarchical'))) {
		mut var_pad := rt.call_function('str_repeat', [rt.new_string('&nbsp;'), depth * 3])
	} else {
		var_pad = rt.new_string(rt.new_string(''))
	}
	mut var_cat_name := rt.call_function('apply_filters', [rt.new_string('list_product_cats'), rt.get_property(var_cat, 'name'), var_cat.dup()])
	mut var_value := if rt.is_true(rt.new_bool(var_args.array_isset(rt.new_string('value')) && rt.is_true(rt.identical(rt.new_string('id'), var_args.array_get('value'))))) { rt.get_property(var_cat, 'term_id') } else { rt.get_property(var_cat, 'slug') }
	// unsupported expression: Expr_AssignOp_Concat
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_value, var_args.array_get('selected'))) || rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_args.array_get('selected').is_array())) && rt.is_true(rt.call_function('in_array', [var_value.dup(), var_args.array_get('selected'), rt.new_bool(true)])))))) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	if !(!rt.is_true(var_args.array_get('show_count'))) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	// unsupported expression: Expr_AssignOp_Concat
}

fn (mut this Class_WC_Product_Cat_Dropdown_Walker) display_element(var_element rt.PhpVal, var_children_elements rt.PhpVal, var_max_depth rt.PhpVal, var_depth rt.PhpVal, var_args rt.PhpVal, var_output rt.PhpVal)  {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_element)))) || rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_int(0), rt.get_property(var_element, 'count'))) && !(!rt.is_true(var_args.array_get(0).array_get('hide_empty'))))))) {
		return rt.new_null()
	}
	this.Class_Walker.display_element(var_element.dup(), var_children_elements.dup(), var_max_depth.dup(), var_depth.dup(), var_args.dup(), var_output.dup())
}

struct Class_Walker {
	rt.PhpObjectBase
}

fn create_wc_product_cat_dropdown_walker() &Class_WC_Product_Cat_Dropdown_Walker {
	mut obj := &Class_WC_Product_Cat_Dropdown_Walker{
		PhpObjectBase: rt.PhpObjectBase{}
		tree_type: rt.new_string('category')
		db_fields: rt.new_array()
	}
	return obj
}

fn create_walker() &Class_Walker {
	mut obj := &Class_Walker{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Product_Cat_Dropdown_Walker) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'start_el' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_i64()
			this.start_el(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
			return rt.new_null()
		}
		'display_element' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			dispatch_arg_5 := if args.len > 5 { args[5] } else { rt.new_null() }
			this.display_element(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_Product_Cat_Dropdown_Walker) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'tree_type' { return this.tree_type }
		'db_fields' { return this.db_fields }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Product_Cat_Dropdown_Walker) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'tree_type' { this.tree_type = val; return true }
		'db_fields' { this.db_fields = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Walker) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Walker) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Walker) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_walkers_class_wc_product_cat_dropdown_walker_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Product_Cat_Dropdown_Walker'), rt.new_bool(false)])) {
		return rt.new_null()
	}
}

import rt

struct Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Component {
	rt.PhpObjectBase
pub mut:
		additional_args rt.PhpVal = rt.new_null()
		required_arguments rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Component) construct(var_id rt.PhpVal, var_plugin_id rt.PhpVal, var_additional_args rt.PhpVal)  {
	this.dispatch_set_prop('id', var_id.dup())
	this.dispatch_set_prop('plugin_id', var_plugin_id.dup())
	this.additional_args = var_additional_args.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Component) get_additional_args() rt.PhpVal {
	return this.additional_args
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Component) get_additional_argument(var_key rt.PhpVal) rt.PhpVal {
	mut var_key_mutated := var_key
	return Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Component.get_argument_from_path((this.additional_args).str(), var_key_mutated.dup())
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Component) get_json() rt.PhpVal {
	return rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'id', val: this.get_id() }, rt.ArrayItem{ key: 'plugin_id', val: this.get_plugin_id() }]), this.get_additional_args()])
}

fn Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Component.sort(var_a rt.PhpVal, var_b rt.PhpVal, var_sort_by rt.PhpVal) rt.PhpVal {
	mut var_key := var_sort_by.array_get('key')
	mut var_a_val := rt.call_method(var_a, 'get_additional_argument', [var_key.dup()])
	mut var_b_val := rt.call_method(var_b, 'get_additional_argument', [var_key.dup()])
	if rt.is_true(rt.identical(rt.new_string('asc'), var_sort_by.array_get('order'))) {
		return // unsupported expression: Expr_BinaryOp_Spaceship
	} else {
		return // unsupported expression: Expr_BinaryOp_Spaceship
	}
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Component.get_argument_from_path(var_arguments rt.PhpVal, var_path rt.PhpVal, delimiter string) rt.PhpVal {
	mut var_path_keys := rt.call_function('explode', [rt.new_string(delimiter), var_path.dup()])
	mut var_num_keys := rt.new_int(if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { rt.new_int(var_path_keys.dup().array_count()) } else { rt.new_int(0) })
	mut var_val := var_arguments
	{
		mut var_i := rt.new_int(rt.new_int(0))
		for {
			if !(rt.is_true(rt.less(var_i, var_num_keys))) { break }
			mut var_key := var_path_keys.array_get(var_i)
			if rt.is_true(rt.new_bool(var_val.dup().array_isset(var_key.dup()))) {
				var_val = var_val.array_get(var_key)
			} else {
				var_val = rt.new_null()
				break
			}
			rt.post_inc(var_i)
		}
	}
	return var_val.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Component) get_missing_arguments(var_args rt.PhpVal) rt.PhpVal {
	closure_2_fn := fn [var_args] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn [var_args] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_arg_key := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.identical(rt.new_null(), Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Component.get_argument_from_path((var_args).str(), var_arg_key.dup()))
	}
	mut var_arg_key := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.identical(rt.new_null(), Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Component.get_argument_from_path((var_args).str(), var_arg_key.dup()))
	}
	return rt.call_function('array_values', [rt.call_function('array_filter', [this.required_arguments, rt.new_closure(closure_1_fn)])])
}

fn create_automattic_woocommerce_internal_admin_productform_component(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Component {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Component{
		PhpObjectBase: rt.PhpObjectBase{}
		additional_args: rt.new_null()
		required_arguments: rt.new_array()
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Component) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'get_additional_args' {
			return this.get_additional_args()
		}
		'get_additional_argument' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_additional_argument(dispatch_arg_0)
		}
		'get_json' {
			return this.get_json()
		}
		'sort' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Component.sort(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_argument_from_path' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Component.get_argument_from_path(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_missing_arguments' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_missing_arguments(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Component) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'additional_args' { return this.additional_args }
		'required_arguments' { return this.required_arguments }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Component) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'additional_args' { this.additional_args = val; return true }
		'required_arguments' { this.required_arguments = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_productform_component_php() {
}

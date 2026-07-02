import rt

struct Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_internal_admin_productform_formfactory() {
		rt.init_static_prop('Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory', 'instance', rt.new_null())
		rt.init_static_prop('Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory', 'form_fields', rt.new_array())
		rt.init_static_prop('Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory', 'form_subsections', rt.new_array())
		rt.init_static_prop('Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory', 'form_sections', rt.new_array())
		rt.init_static_prop('Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory', 'form_tabs', rt.new_array())
}

fn Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory.instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory', 'instance'))))) {
		rt.set_static_prop('Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory', 'instance', rt.new_object('Automattic_WooCommerce_Internal_Admin_ProductForm_static', []string{}, create_automattic_woocommerce_internal_admin_productform_static()))
	}
	return rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory', 'instance')
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory) init() {
}

fn Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory.add_field(var_id rt.PhpVal, var_plugin_id rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_new_field := Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory.create_item(rt.new_string('field'), rt.new_string('Field'), var_id.clone(), var_plugin_id.clone(), var_args.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_new_field.clone()])) {
		return var_new_field.clone()
	}
	rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory', 'form_fields').array_set(var_id, var_new_field.clone())
	return var_new_field.clone()
}

fn Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory.add_subsection(var_id rt.PhpVal, var_plugin_id rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_new_subsection := Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory.create_item(rt.new_string('subsection'), rt.new_string('Subsection'), var_id.clone(), var_plugin_id.clone(), var_args.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_new_subsection.clone()])) {
		return var_new_subsection.clone()
	}
	rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory', 'form_subsections').array_set(var_id, var_new_subsection.clone())
	return var_new_subsection.clone()
}

fn Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory.add_section(var_id rt.PhpVal, var_plugin_id rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_new_section := Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory.create_item(rt.new_string('section'), rt.new_string('Section'), var_id.clone(), var_plugin_id.clone(), var_args.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_new_section.clone()])) {
		return var_new_section.clone()
	}
	rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory', 'form_sections').array_set(var_id, var_new_section.clone())
	return var_new_section.clone()
}

fn Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory.add_tab(var_id rt.PhpVal, var_plugin_id rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_new_tab := Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory.create_item(rt.new_string('tab'), rt.new_string('Tab'), var_id.clone(), var_plugin_id.clone(), var_args.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_new_tab.clone()])) {
		return var_new_tab.clone()
	}
	rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory', 'form_tabs').array_set(var_id, var_new_tab.clone())
	return var_new_tab.clone()
}

fn Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory.get_fields(var_sort_by rt.PhpVal) rt.PhpVal {
	return Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory.get_items(rt.new_string('field'), rt.new_string('Field'), var_sort_by.clone())
}

fn Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory.get_subsections(var_sort_by rt.PhpVal) rt.PhpVal {
	return Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory.get_items(rt.new_string('subsection'), rt.new_string('Subsection'), var_sort_by.clone())
}

fn Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory.get_sections(var_sort_by rt.PhpVal) rt.PhpVal {
	return Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory.get_items(rt.new_string('section'), rt.new_string('Section'), var_sort_by.clone())
}

fn Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory.get_tabs(var_sort_by rt.PhpVal) rt.PhpVal {
	return Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory.get_items(rt.new_string('tab'), rt.new_string('Tab'), var_sort_by.clone())
}

fn Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory.get_item_list(var_type rt.PhpVal) rt.PhpVal {
	mut var_mapping := rt.create_array([rt.ArrayItem{ key: 'field', val: rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory', 'form_fields') }, rt.ArrayItem{ key: 'subsection', val: rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory', 'form_subsections') }, rt.ArrayItem{ key: 'section', val: rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory', 'form_sections') }, rt.ArrayItem{ key: 'tab', val: rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory', 'form_tabs') }])
	if rt.is_true(rt.new_bool(var_mapping.clone().array_isset(var_type.clone()))) {
		return var_mapping.array_get(var_type)
	}
	return rt.new_array()
}

fn Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory.get_items(var_type rt.PhpVal, var_class_name rt.PhpVal, var_sort_by rt.PhpVal) rt.PhpVal {
	mut var_item_list := Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory.get_item_list(var_type.clone())
	mut var_class := rt.new_string('Automattic\\WooCommerce\\Internal\\Admin\\ProductForm\\' + (var_class_name).str())
	mut var_items := rt.call_function('array_values', [var_item_list.clone()])
	if rt.is_true(rt.call_function('class_exists', [var_class.clone()])) && rt.is_true(rt.call_function('method_exists', [var_class.clone(), rt.new_string('sort')])) {
		closure_2_fn := fn [var_sort_by, var_class] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_a := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			mut var_b := if args.len > 1 { args[1].clone() } else { rt.new_null() }
			mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_Admin_ProductForm_{"nodeType":"Expr_Variable","line":231,"name":"class"}{}
			mut iife_result_1 := iife_temp_1.sort(var_a.clone(), var_b.clone(), var_sort_by.clone())
			return iife_result_1
			}
		rt.call_function('usort', [var_items.clone(), rt.new_closure(closure_2_fn)])
	}
	return var_items.clone()
}

fn Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory.create_item(var_type rt.PhpVal, var_class_name rt.PhpVal, var_id rt.PhpVal, var_plugin_id rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_item_list := Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory.get_item_list(var_type.clone())
	mut var_class := rt.new_string('Automattic\\WooCommerce\\Internal\\Admin\\ProductForm\\' + (var_class_name).str())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [var_class.clone()]))))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error('wc_product_form_' + (var_type).str() + '_missing_form_class', rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('%1$s class does not exist.'), rt.new_string('woocommerce')]), var_class.clone()])))
	}
	if var_item_list.array_isset(var_id) {
		return rt.new_object('WP_Error', []string{}, create_wp_error('wc_product_form_' + (var_type).str() + '_duplicate_field_id', rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('You have attempted to register a duplicate form %1$s with WooCommerce Form: %2$s'), rt.new_string('woocommerce')]), var_type.clone(), rt.new_string('`' + (var_id).str() + '`')])))
	}
	mut var_defaults := rt.create_array([rt.ArrayItem{ key: 'order', val: 20 }])
	mut var_item_arguments := rt.call_function('wp_parse_args', [var_args.clone(), var_defaults.clone()])
	return rt.new_object('', []string{}, rt.create_object_dynamically(var_class, [var_id.clone(), var_plugin_id.clone(), var_item_arguments.clone()]))
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_Admin_ProductForm_Exception') {
		mut var_e := var_e_1.clone()
		return rt.new_object('WP_Error', []string{}, create_wp_error('wc_product_form_' + (var_type).str() + '_class_creation', rt.call_method(var_e, 'getMessage', []rt.PhpVal{})))
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Internal_Admin_ProductForm_static {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_ProductForm_{"nodeType":"Expr_Variable","line":231,"name":"class"} {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_productform_formfactory(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_productform_static(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_ProductForm_static {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_ProductForm_static{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_productform_{"nodetype":"expr_variable","line":231,"name":"class"}(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_ProductForm_{"nodeType":"Expr_Variable","line":231,"name":"class"} {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_ProductForm_{"nodeType":"Expr_Variable","line":231,"name":"class"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'instance' {
			return Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory.instance()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'add_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory.add_field(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'add_subsection' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory.add_subsection(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'add_section' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory.add_section(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'add_tab' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory.add_tab(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory.get_fields(dispatch_arg_0)
		}
		'get_subsections' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory.get_subsections(dispatch_arg_0)
		}
		'get_sections' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory.get_sections(dispatch_arg_0)
		}
		'get_tabs' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory.get_tabs(dispatch_arg_0)
		}
		'get_item_list' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory.get_item_list(dispatch_arg_0)
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory.get_items(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'create_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory.create_item(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductForm_static) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_ProductForm_static) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductForm_static) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductForm_{"nodeType":"Expr_Variable","line":231,"name":"class"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_ProductForm_{"nodeType":"Expr_Variable","line":231,"name":"class"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductForm_{"nodeType":"Expr_Variable","line":231,"name":"class"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_class_factory('Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_admin_productform_formfactory()
		return rt.new_object('Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Internal_Admin_ProductForm_static', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_admin_productform_static()
		return rt.new_object('Automattic_WooCommerce_Internal_Admin_ProductForm_static', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Internal_Admin_ProductForm_{"nodeType":"Expr_Variable","line":231,"name":"class"}', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_admin_productform_{"nodetype":"expr_variable","line":231,"name":"class"}()
		return rt.new_object('Automattic_WooCommerce_Internal_Admin_ProductForm_{"nodeType":"Expr_Variable","line":231,"name":"class"}', []string{}, obj)
	})
	rt.register_class_factory('WP_Error', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_error()
		return rt.new_object('WP_Error', []string{}, obj)
	})
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

}

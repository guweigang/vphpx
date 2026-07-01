import rt

struct Class_Automattic_WooCommerce_LayoutTemplates_LayoutTemplateRegistry {
	rt.PhpObjectBase
pub mut:
		instance rt.PhpVal = rt.new_null()
		layout_templates_info rt.PhpVal = rt.new_array()
		layout_template_instances rt.PhpVal = rt.new_array()
}

fn Class_Automattic_WooCommerce_LayoutTemplates_LayoutTemplateRegistry.get_instance() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), // unsupported expression: Expr_StaticPropertyFetch)) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn (mut this Class_Automattic_WooCommerce_LayoutTemplates_LayoutTemplateRegistry) unregister_all()  {
	this.layout_templates_info = rt.new_array()
	this.layout_template_instances = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_LayoutTemplates_LayoutTemplateRegistry) is_registered(var_layout_template_id rt.PhpVal) bool {
	mut var_layout_template_id_mutated := var_layout_template_id
	return (rt.new_bool(this.layout_templates_info.array_isset(var_layout_template_id_mutated))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_LayoutTemplates_LayoutTemplateRegistry) register(var_layout_template_id rt.PhpVal, var_layout_template_area rt.PhpVal, var_layout_template_class_name rt.PhpVal)  {
	mut var_layout_template_id_mutated := var_layout_template_id
	if this.is_registered(var_layout_template_id_mutated.dup()) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_LayoutTemplates_ValueError', []string{}, create_automattic_woocommerce_layouttemplates_valueerror(rt.new_string('A layout template with the specified ID already exists in the registry.'))))
	}
	if !rt.is_true(var_layout_template_area) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_LayoutTemplates_ValueError', []string{}, create_automattic_woocommerce_layouttemplates_valueerror(rt.new_string('The specified layout template area is empty.'))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [var_layout_template_class_name.dup()]))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_LayoutTemplates_ValueError', []string{}, create_automattic_woocommerce_layouttemplates_valueerror(rt.new_string('The specified layout template class does not exist.'))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_subclass_of', [var_layout_template_class_name.dup(), Class_Automattic_WooCommerce_Admin_BlockTemplates_BlockTemplateInterface.class()]))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_LayoutTemplates_ValueError', []string{}, create_automattic_woocommerce_layouttemplates_valueerror(rt.new_string('The specified layout template class does not implement the BlockTemplateInterface.'))))
	}
	this.layout_templates_info.array_set(var_layout_template_id_mutated, rt.create_array([rt.ArrayItem{ key: 'id', val: var_layout_template_id_mutated }, rt.ArrayItem{ key: 'area', val: var_layout_template_area }, rt.ArrayItem{ key: 'class_name', val: var_layout_template_class_name }]))
}

fn (mut this Class_Automattic_WooCommerce_LayoutTemplates_LayoutTemplateRegistry) instantiate_layout_templates(mut var_query_params Class_Automattic_WooCommerce_LayoutTemplates_array) rt.PhpVal {
	mut var_logger := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplateLogger{}; return temp.get_instance() }()
	mut var_layout_templates := rt.new_array()
	mut var_layout_templates_info := this.get_matching_layout_templates_info(mut var_query_params)
	{
		mut iter_1 := var_layout_templates_info.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_layout_template_info := item_1.val
			mut var_layout_template := this.get_layout_template_instance(var_layout_template_info.dup())
			mut var_layout_template_id := rt.call_method(var_layout_template, 'get_id', []rt.PhpVal{})
			var_layout_templates.array_set(var_layout_template_id, var_layout_template.dup())
			rt.call_method(var_logger, 'log_template_events_to_file', [var_layout_template_id.dup()])
		}
	}
	return var_layout_templates.dup()
}

fn (mut this Class_Automattic_WooCommerce_LayoutTemplates_LayoutTemplateRegistry) get_layout_template_instance(var_layout_template_info rt.PhpVal) rt.PhpVal {
	mut var_class_name := var_layout_template_info.array_get('class_name')
	mut var_layout_template_instance := if this.layout_template_instances.array_isset(var_class_name) { this.layout_template_instances.array_get(var_class_name) } else { rt.new_null() }
	if !(!rt.is_true(var_layout_template_instance)) {
		return var_layout_template_instance.dup()
	}
	var_layout_template_instance = rt.create_object_dynamically(var_class_name, []rt.PhpVal{})
	this.layout_template_instances.array_set(var_class_name, var_layout_template_instance.dup())
	rt.call_function('do_action', [rt.new_string('woocommerce_layout_template_after_instantiation'), var_layout_template_info.array_get('id'), var_layout_template_info.array_get('area'), var_layout_template_instance.dup()])
	rt.call_function('wc_do_deprecated_action', [rt.new_string('woocommerce_block_template_register'), rt.create_array([rt.ArrayItem{ key: none, val: var_layout_template_instance }]), rt.new_string('8.6.0'), rt.new_string('woocommerce_layout_template_after_instantiation')])
	return var_layout_template_instance.dup()
}

fn (mut this Class_Automattic_WooCommerce_LayoutTemplates_LayoutTemplateRegistry) get_matching_layout_templates_info(mut var_query_params Class_Automattic_WooCommerce_LayoutTemplates_array) rt.PhpVal {
	mut var_area_to_match := if var_query_params.array_isset(rt.new_string('area')) { var_query_params.array_get('area') } else { rt.new_null() }
	mut var_id_to_match := if var_query_params.array_isset(rt.new_string('id')) { var_query_params.array_get('id') } else { rt.new_null() }
	mut var_matching_layout_templates_info := rt.new_array()
	{
		mut iter_1 := this.layout_templates_info.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_layout_template_info := item_1.val
			if rt.is_true(rt.new_bool(!(!rt.is_true(var_area_to_match)) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
				continue
			}
			if rt.is_true(rt.new_bool(!(!rt.is_true(var_id_to_match)) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
				continue
			}
			var_matching_layout_templates_info.array_push(var_layout_template_info.dup())
		}
	}
	return var_matching_layout_templates_info.dup()
}

struct Class_Automattic_WooCommerce_LayoutTemplates_ValueError {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplateLogger {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_layouttemplates_layouttemplateregistry() &Class_Automattic_WooCommerce_LayoutTemplates_LayoutTemplateRegistry {
	mut obj := &Class_Automattic_WooCommerce_LayoutTemplates_LayoutTemplateRegistry{
		PhpObjectBase: rt.PhpObjectBase{}
		instance: rt.new_null()
		layout_templates_info: rt.new_array()
		layout_template_instances: rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_layouttemplates_valueerror() &Class_Automattic_WooCommerce_LayoutTemplates_ValueError {
	mut obj := &Class_Automattic_WooCommerce_LayoutTemplates_ValueError{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_blocktemplates_blocktemplatelogger() &Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplateLogger {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplateLogger{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_LayoutTemplates_LayoutTemplateRegistry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_instance' {
			return Class_Automattic_WooCommerce_LayoutTemplates_LayoutTemplateRegistry.get_instance()
		}
		'unregister_all' {
			this.unregister_all()
			return rt.new_null()
		}
		'is_registered' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_registered(dispatch_arg_0))
		}
		'register' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.register(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'instantiate_layout_templates' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_LayoutTemplates_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.instantiate_layout_templates(mut dispatch_arg_0)
		}
		'get_layout_template_instance' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_layout_template_instance(dispatch_arg_0)
		}
		'get_matching_layout_templates_info' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_LayoutTemplates_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_matching_layout_templates_info(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_LayoutTemplates_LayoutTemplateRegistry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'instance' { return this.instance }
		'layout_templates_info' { return this.layout_templates_info }
		'layout_template_instances' { return this.layout_template_instances }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_LayoutTemplates_LayoutTemplateRegistry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'instance' { this.instance = val; return true }
		'layout_templates_info' { this.layout_templates_info = val; return true }
		'layout_template_instances' { this.layout_template_instances = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_LayoutTemplates_ValueError) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_LayoutTemplates_ValueError) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_LayoutTemplates_ValueError) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplateLogger) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplateLogger) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplateLogger) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_class_factory('Automattic_WooCommerce_LayoutTemplates_LayoutTemplateRegistry', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_layouttemplates_layouttemplateregistry()
		return rt.new_object('Automattic_WooCommerce_LayoutTemplates_LayoutTemplateRegistry', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_LayoutTemplates_ValueError', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_layouttemplates_valueerror()
		return rt.new_object('Automattic_WooCommerce_LayoutTemplates_ValueError', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplateLogger', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_admin_blocktemplates_blocktemplatelogger()
		return rt.new_object('Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplateLogger', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_src_layouttemplates_layouttemplateregistry_php() {
}

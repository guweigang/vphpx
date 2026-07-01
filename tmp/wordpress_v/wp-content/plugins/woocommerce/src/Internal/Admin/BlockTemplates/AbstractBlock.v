import rt

struct Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock {
	rt.PhpObjectBase
pub mut:
		name rt.PhpVal = rt.new_null()
		id rt.PhpVal = rt.new_null()
		order rt.PhpVal = rt.new_int(10000)
		attributes rt.PhpVal = rt.new_array()
		hide_conditions rt.PhpVal = rt.new_array()
		hide_conditions_counter rt.PhpVal = rt.new_int(0)
		disable_conditions rt.PhpVal = rt.new_array()
		disable_conditions_counter rt.PhpVal = rt.new_int(0)
		root_template rt.PhpVal = rt.new_null()
		parent rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock) construct(mut var_config Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_array, mut var_root_template Class_Automattic_WooCommerce_Admin_BlockTemplates_BlockTemplateInterface, mut var_parent Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_?ContainerInterface)  {
	this.validate(mut var_config, mut var_root_template, mut var_parent)
	this.root_template = var_root_template.dup()
	this.parent = if rt.is_true(rt.new_bool(var_parent.is_null())) { var_root_template } else { var_parent }
	this.name = var_config.array_get(Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock.name_key())
	if !(var_config.array_isset(Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock.id_key())) {
		this.id = rt.call_method(this.root_template, 'generate_block_id', [this.get_name()])
	} else {
		this.id = var_config.array_get(Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock.id_key())
	}
	if var_config.array_isset(Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock.order_key()) {
		this.order = var_config.array_get(Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock.order_key())
	}
	if var_config.array_isset(Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock.attributes_key()) {
		this.attributes = var_config.array_get(Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock.attributes_key())
	}
	if var_config.array_isset(Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock.hide_conditions_key()) {
		{
			mut iter_1 := var_config.array_get(Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock.hide_conditions_key()).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_hide_condition := item_1.val
				this.add_hide_condition((var_hide_condition.array_get('expression')).str())
			}
		}
	}
	if var_config.array_isset(Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock.disable_conditions_key()) {
		{
			mut iter_1 := var_config.array_get(Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock.disable_conditions_key()).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_disable_condition := item_1.val
				this.add_disable_condition((var_disable_condition.array_get('expression')).str())
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock) validate(mut var_config Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_array, mut var_root_template Class_Automattic_WooCommerce_Admin_BlockTemplates_BlockTemplateInterface, mut var_parent Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_?ContainerInterface)  {
	if rt.is_true(rt.new_bool(!(var_parent).is_null() && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Admin_BlockTemplates_ValueError', []string{}, create_automattic_woocommerce_internal_admin_blocktemplates_valueerror(rt.new_string('The parent block must belong to the same template as the block.'))))
	}
	if rt.is_true(rt.new_bool(!(var_config.array_isset(Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock.name_key())) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_config.array_get(Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock.name_key()).is_string()))))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Admin_BlockTemplates_ValueError', []string{}, create_automattic_woocommerce_internal_admin_blocktemplates_valueerror(rt.new_string('The block name must be specified.'))))
	}
	if rt.is_true(rt.new_bool(var_config.array_isset(Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock.order_key()) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_config.array_get(Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock.order_key()).is_long()))))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Admin_BlockTemplates_ValueError', []string{}, create_automattic_woocommerce_internal_admin_blocktemplates_valueerror(rt.new_string('The block order must be an integer.'))))
	}
	if rt.is_true(rt.new_bool(var_config.array_isset(Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock.attributes_key()) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_config.array_get(Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock.attributes_key()).is_array()))))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Admin_BlockTemplates_ValueError', []string{}, create_automattic_woocommerce_internal_admin_blocktemplates_valueerror(rt.new_string('The block attributes must be an array.'))))
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock) get_name() string {
	return (this.name).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock) get_id() string {
	return (this.id).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock) get_order() i64 {
	return (this.order).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock) set_order(order i64)  {
	this.order = rt.new_int(order).dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock) get_attributes() rt.PhpVal {
	return this.attributes
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock) set_attributes(mut var_attributes Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_array)  {
	this.attributes = var_attributes.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock) set_attribute(key string, var_value rt.PhpVal)  {
	mut key_mutated := key
	this.attributes.array_set(key_mutated, var_value.dup())
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock) get_root_template() rt.PhpVal {
	return this.root_template
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock) get_parent() rt.PhpVal {
	return this.parent
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock) remove()  {
	rt.call_method(this.parent, 'remove_block', [this.id])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock) is_detached() bool {
	mut var_is_in_parent := rt.identical(rt.call_method(this.parent, 'get_block', [this.id]), rt.new_object('Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock', ['BlockInterface'], &this))
	mut var_is_in_root_template := rt.identical(rt.call_method(this.get_root_template(), 'get_block', [this.id]), rt.new_object('Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock', ['BlockInterface'], &this))
	return !(rt.is_true(rt.new_bool(rt.is_true(var_is_in_parent) && rt.is_true(var_is_in_root_template))))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock) add_hide_condition(expression string) string {
	mut var_key := rt.new_string('k' + (this.hide_conditions_counter).str())
	rt.post_inc(this.hide_conditions_counter)
	this.hide_conditions.array_set(var_key, rt.create_array([rt.ArrayItem{ key: 'expression', val: expression }]))
	rt.call_function('do_action', [rt.new_string('woocommerce_block_template_after_add_hide_condition'), rt.new_object('Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock', ['BlockInterface'], &this)])
	return (var_key).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock) remove_hide_condition(key string)  {
	mut key_mutated := key
	this.hide_conditions.array_unset(rt.new_string(key_mutated))
	rt.call_function('do_action', [rt.new_string('woocommerce_block_template_after_remove_hide_condition'), rt.new_object('Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock', ['BlockInterface'], &this)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock) get_hide_conditions() rt.PhpVal {
	return this.hide_conditions
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock) add_disable_condition(expression string) string {
	mut var_key := rt.new_string('k' + (this.disable_conditions_counter).str())
	rt.post_inc(this.disable_conditions_counter)
	this.disable_conditions.array_set(var_key, rt.create_array([rt.ArrayItem{ key: 'expression', val: expression }]))
	return (var_key).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock) remove_disable_condition(key string)  {
	mut key_mutated := key
	this.disable_conditions.array_unset(rt.new_string(key_mutated))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock) get_disable_conditions() rt.PhpVal {
	return this.disable_conditions
}

struct Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_ValueError {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_blocktemplates_abstractblock(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
		name: rt.new_null()
		id: rt.new_null()
		order: rt.new_int(10000)
		attributes: rt.new_array()
		hide_conditions: rt.new_array()
		hide_conditions_counter: rt.new_int(0)
		disable_conditions: rt.new_array()
		disable_conditions_counter: rt.new_int(0)
		root_template: rt.new_null()
		parent: rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn create_automattic_woocommerce_internal_admin_blocktemplates_valueerror() &Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_ValueError {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_ValueError{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_BlockTemplates_BlockTemplateInterface](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_?ContainerInterface](if args.len > 2 { args[2] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'validate' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_BlockTemplates_BlockTemplateInterface](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_?ContainerInterface](if args.len > 2 { args[2] } else { rt.new_null() })
			this.validate(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'get_name' {
			return rt.new_string(this.get_name())
		}
		'get_id' {
			return rt.new_string(this.get_id())
		}
		'get_order' {
			return rt.new_int(this.get_order())
		}
		'set_order' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.set_order(dispatch_arg_0)
			return rt.new_null()
		}
		'get_attributes' {
			return this.get_attributes()
		}
		'set_attributes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.set_attributes(mut dispatch_arg_0)
			return rt.new_null()
		}
		'set_attribute' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_attribute(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_root_template' {
			return this.get_root_template()
		}
		'get_parent' {
			return this.get_parent()
		}
		'remove' {
			this.remove()
			return rt.new_null()
		}
		'is_detached' {
			return rt.new_bool(this.is_detached())
		}
		'add_hide_condition' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.add_hide_condition(dispatch_arg_0))
		}
		'remove_hide_condition' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.remove_hide_condition(dispatch_arg_0)
			return rt.new_null()
		}
		'get_hide_conditions' {
			return this.get_hide_conditions()
		}
		'add_disable_condition' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.add_disable_condition(dispatch_arg_0))
		}
		'remove_disable_condition' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.remove_disable_condition(dispatch_arg_0)
			return rt.new_null()
		}
		'get_disable_conditions' {
			return this.get_disable_conditions()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'name' { return this.name }
		'id' { return this.id }
		'order' { return this.order }
		'attributes' { return this.attributes }
		'hide_conditions' { return this.hide_conditions }
		'hide_conditions_counter' { return this.hide_conditions_counter }
		'disable_conditions' { return this.disable_conditions }
		'disable_conditions_counter' { return this.disable_conditions_counter }
		'root_template' { return this.root_template }
		'parent' { return this.parent }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'name' { this.name = val; return true }
		'id' { this.id = val; return true }
		'order' { this.order = val; return true }
		'attributes' { this.attributes = val; return true }
		'hide_conditions' { this.hide_conditions = val; return true }
		'hide_conditions_counter' { this.hide_conditions_counter = val; return true }
		'disable_conditions' { this.disable_conditions = val; return true }
		'disable_conditions_counter' { this.disable_conditions_counter = val; return true }
		'root_template' { this.root_template = val; return true }
		'parent' { this.parent = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_ValueError) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_ValueError) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_ValueError) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_blocktemplates_abstractblock_php() {
}

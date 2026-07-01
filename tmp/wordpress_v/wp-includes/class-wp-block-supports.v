import rt

struct Class_WP_Block_Supports {
	rt.PhpObjectBase
pub mut:
		block_supports rt.PhpVal = rt.new_array()
		block_to_render rt.PhpVal = rt.new_null()
		instance rt.PhpVal = rt.new_null()
}

fn Class_WP_Block_Supports.get_instance() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), // unsupported expression: Expr_StaticPropertyFetch)) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn Class_WP_Block_Supports.init()  {
	mut var_instance := Class_WP_Block_Supports.get_instance()
	rt.call_method(var_instance, 'register_attributes', []rt.PhpVal{})
}

fn (mut this Class_WP_Block_Supports) register(var_block_support_name rt.PhpVal, var_block_support_config rt.PhpVal)  {
	this.block_supports.array_set(var_block_support_name, rt.call_function('array_merge', [var_block_support_config.dup(), rt.create_array([rt.ArrayItem{ key: 'name', val: var_block_support_name }])]))
}

fn (mut this Class_WP_Block_Supports) apply_block_supports() rt.PhpVal {
	mut var_block_type := rt.call_method(fn () rt.PhpVal { mut temp := Class_WP_Block_Type_Registry{}; return temp.get_instance() }(), 'get_registered', [// unsupported expression: Expr_StaticPropertyFetch.array_get('blockName')])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_block_type)))) || !rt.is_true(var_block_type))) {
		return rt.new_array()
	}
	mut var_block_attributes := if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(// unsupported expression: Expr_StaticPropertyFetch.array_isset(rt.new_string('attrs')))) && rt.is_true(rt.new_bool(// unsupported expression: Expr_StaticPropertyFetch.array_get('attrs').is_array())))) { rt.call_method(var_block_type, 'prepare_attributes_for_render', [// unsupported expression: Expr_StaticPropertyFetch.array_get('attrs')]) } else { rt.new_array() }
	mut var_output := rt.new_array()
	{
		mut iter_1 := this.block_supports.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_block_support_config := item_1.val
			if !(var_block_support_config.array_isset(rt.new_string('apply'))) {
				continue
			}
			mut var_new_attributes := rt.call_function('call_user_func', [var_block_support_config.array_get('apply'), var_block_type.dup(), var_block_attributes.dup()])
			if !(!rt.is_true(var_new_attributes)) {
				{
					mut iter_2 := var_new_attributes.iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_attribute_value := item_2.val
						mut var_attribute_name := item_2.key
						if !rt.is_true(var_output.array_get(var_attribute_name)) {
							var_output.array_set(var_attribute_name, var_attribute_value.dup())
						} else {
							// unsupported expression: Expr_AssignOp_Concat
						}
					}
				}
			}
		}
	}
	return var_output.dup()
}

fn (mut this Class_WP_Block_Supports) register_attributes()  {
	mut var_block_registry := fn () rt.PhpVal { mut temp := Class_WP_Block_Type_Registry{}; return temp.get_instance() }()
	mut var_registered_block_types := rt.call_method(var_block_registry, 'get_all_registered', []rt.PhpVal{})
	{
		mut iter_1 := var_registered_block_types.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_block_type := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_block_type, 'WP_Block_Type')))))) {
				continue
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_block_type, 'attributes'))))) {
				rt.set_property(var_block_type, 'attributes', rt.new_array())
			}
			{
				mut iter_2 := this.block_supports.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_block_support_config := item_2.val
					if !(var_block_support_config.array_isset(rt.new_string('register_attribute'))) {
						continue
					}
					rt.call_function('call_user_func', [var_block_support_config.array_get('register_attribute'), var_block_type.dup()])
				}
			}
		}
	}
}

fn get_block_wrapper_attributes(var_extra_attributes rt.PhpVal) string {
	mut var_new_attributes := rt.call_method(Class_WP_Block_Supports.get_instance(), 'apply_block_supports', []rt.PhpVal{})
	if !rt.is_true(var_new_attributes) && !rt.is_true(var_extra_attributes) {
		return ''
	}
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_new_attribute := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_extra_attribute := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	mut var_styles := rt.call_function('array_filter', [rt.create_array([rt.ArrayItem{ key: none, val: var_new_attribute.dup().to_string().trim_space().trim_right(' \t\n\r') }, rt.ArrayItem{ key: none, val: var_extra_attribute.dup().to_string().trim_space().trim_right(' \t\n\r') }])])
	return (rt.call_function('safecss_filter_attr', [rt.call_function('implode', [rt.new_string(';'), rt.call_function('array_filter', [var_styles.dup()])])])).str()
	}
	mut var_new_attribute := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_extra_attribute := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	mut var_classes := rt.call_function('array_merge', [rt.cast_array(rt.call_function('preg_split', [rt.new_string('/\\s+/'), var_extra_attribute.dup(), // unsupported expression: Expr_UnaryMinus, rt.get_constant('PREG_SPLIT_NO_EMPTY')])), rt.cast_array(rt.call_function('preg_split', [rt.new_string('/\\s+/'), var_new_attribute.dup(), // unsupported expression: Expr_UnaryMinus, rt.get_constant('PREG_SPLIT_NO_EMPTY')]))])
	var_classes = rt.call_function('array_unique', [rt.call_function('array_filter', [var_classes.dup()])])
	return (rt.call_function('implode', [rt.new_string(' '), var_classes.dup()])).str()
	}
	mut var_new_attribute := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_extra_attribute := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	return (if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { var_extra_attribute } else { var_new_attribute }).str()
	}
	mut var_new_attribute := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_extra_attribute := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	return (if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { var_extra_attribute } else { var_new_attribute }).str()
	}
	mut var_attribute_merge_callbacks := { 'style': rt.new_closure(closure_1_fn), 'class': rt.new_closure(closure_2_fn), 'id': rt.new_closure(closure_3_fn), 'aria-label': rt.new_closure(closure_4_fn) }
	mut var_attributes := rt.new_array()
	for var_attribute_name, var_merge_callback in var_attribute_merge_callbacks {
		mut var_new_attribute := if !(var_new_attributes.array_get(attribute_name)).is_null() { var_new_attributes.array_get(attribute_name) } else { rt.new_string('') }
		mut var_extra_attribute := if !(var_extra_attributes.array_get(attribute_name)).is_null() { var_extra_attributes.array_get(attribute_name) } else { rt.new_string('') }
		var_new_attribute = if rt.is_true(rt.new_bool(var_new_attribute.dup().is_string())) { var_new_attribute } else { rt.new_string('') }
		var_extra_attribute = if rt.is_true(rt.new_bool(var_extra_attribute.dup().is_string())) { var_extra_attribute } else { rt.new_string('') }
		if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string(''), var_new_attribute)) && rt.is_true(rt.identical(rt.new_string(''), var_extra_attribute)))) {
			continue
		}
		var_attributes.array_set(attribute_name, rt.call_callable(var_merge_callback, [var_new_attribute.dup(), var_extra_attribute.dup()]))
	}
	{
		mut iter_1 := var_extra_attributes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_attribute_name := item_1.key
			if !(var_attribute_merge_callbacks.array_isset(var_attribute_name)) {
				var_attributes.array_set(var_attribute_name, var_value.dup())
			}
		}
	}
	if !rt.is_true(var_attributes) {
		return ''
	}
	mut var_normalized_attributes := rt.new_array()
	{
		mut iter_1 := var_attributes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			var_normalized_attributes << (var_key).str() + '="' + (rt.call_function('esc_attr', [var_value.dup()])).str() + '"'
		}
	}
	return (rt.call_function('implode', [rt.new_string(' '), var_normalized_attributes.dup()])).str()
}

struct Class_WP_Block_Type_Registry {
	rt.PhpObjectBase
}

fn create_wp_block_supports() &Class_WP_Block_Supports {
	mut obj := &Class_WP_Block_Supports{
		PhpObjectBase: rt.PhpObjectBase{}
		block_supports: rt.new_array()
		block_to_render: rt.new_null()
		instance: rt.new_null()
	}
	return obj
}

fn create_wp_block_type_registry() &Class_WP_Block_Type_Registry {
	mut obj := &Class_WP_Block_Type_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Block_Supports) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_instance' {
			return Class_WP_Block_Supports.get_instance()
		}
		'init' {
			Class_WP_Block_Supports.init()
			return rt.new_null()
		}
		'register' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.register(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'apply_block_supports' {
			return this.apply_block_supports()
		}
		'register_attributes' {
			this.register_attributes()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WP_Block_Supports) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_supports' { return this.block_supports }
		'block_to_render' { return this.block_to_render }
		'instance' { return this.instance }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Block_Supports) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'block_supports' { this.block_supports = val; return true }
		'block_to_render' { this.block_to_render = val; return true }
		'instance' { this.instance = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_Block_Type_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Type_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Type_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_func('get_block_wrapper_attributes', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(get_block_wrapper_attributes(arg_0))
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_includes_class_wp_block_supports_php() {
}

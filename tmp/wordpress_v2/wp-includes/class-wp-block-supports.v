import rt

struct Class_WP_Block_Supports {
	rt.PhpObjectBase
pub mut:
	block_supports rt.PhpVal = rt.new_array()
}

fn init_static_wp_block_supports() {
	rt.init_static_prop('WP_Block_Supports', 'block_to_render', rt.new_null())
	rt.init_static_prop('WP_Block_Supports', 'instance', rt.new_null())
}

fn Class_WP_Block_Supports.get_instance() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), rt.get_static_prop('WP_Block_Supports', 'instance'))) {
		rt.set_static_prop('WP_Block_Supports', 'instance', rt.new_object('WP_Block_Supports',
			[]string{}, create_wp_block_supports()))
	}
	return rt.get_static_prop('WP_Block_Supports', 'instance')
}

fn Class_WP_Block_Supports.init() {
	mut var_instance := Class_WP_Block_Supports.get_instance()
	rt.call_method(var_instance, 'register_attributes', []rt.PhpVal{})
}

fn (mut this Class_WP_Block_Supports) register(var_block_support_name rt.PhpVal, var_block_support_config rt.PhpVal) {
	this.block_supports.array_set(var_block_support_name, rt.call_function('array_merge', [
		var_block_support_config.clone(),
		rt.create_array([rt.ArrayItem{ key: 'name', val: var_block_support_name }]),
	]))
}

fn (mut this Class_WP_Block_Supports) apply_block_supports() rt.PhpVal {
	mut iife_temp_0 := Class_WP_Block_Type_Registry{}
	mut iife_result_0 := iife_temp_0.get_instance()
	mut var_block_type := rt.call_method(iife_result_0, 'get_registered', [
		rt.get_static_prop('WP_Block_Supports', 'block_to_render').array_get(rt.new_string('blockName')),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_block_type)))) || !rt.is_true(var_block_type) {
		return rt.new_array()
	}
	mut var_block_attributes := if rt.is_true(rt.new_bool(rt.get_static_prop('WP_Block_Supports', 'block_to_render').array_isset(rt.new_string('attrs')))) && rt.get_static_prop('WP_Block_Supports', 'block_to_render').array_get(rt.new_string('attrs')).is_array() { rt.call_method(var_block_type, 'prepare_attributes_for_render', [
			rt.get_static_prop('WP_Block_Supports', 'block_to_render').array_get(rt.new_string('attrs')),
		]) } else { rt.new_array() }
	mut var_output := rt.new_array()
	mut iter_1 := this.block_supports.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_block_support_config := item_1.val
		if !(var_block_support_config.array_isset(rt.new_string('apply'))) {
			continue
		}
		mut var_new_attributes := rt.call_function('call_user_func', [
			var_block_support_config.array_get(rt.new_string('apply')),
			var_block_type.clone(),
			var_block_attributes.clone(),
		])
		if !(!rt.is_true(var_new_attributes)) {
			mut iter_2 := var_new_attributes.iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_attribute_value := item_2.val
				mut var_attribute_name := item_2.key
				if !rt.is_true(var_output.array_get(var_attribute_name)) {
					var_output.array_set(var_attribute_name, var_attribute_value.clone())
				} else {
					var_output.array_get(var_attribute_name) = rt.concat(var_output.array_get(var_attribute_name),
						rt.new_string(' ${var_attribute_value.to_string()}'))
				}
			}
		}
	}
	return var_output.clone()
}

fn (mut this Class_WP_Block_Supports) register_attributes() {
	mut iife_temp_1 := Class_WP_Block_Type_Registry{}
	mut iife_result_1 := iife_temp_1.get_instance()
	mut var_block_registry := iife_result_1
	mut var_registered_block_types := rt.call_method(var_block_registry, 'get_all_registered',
		[]rt.PhpVal{})
	mut iter_3 := var_registered_block_types.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_block_type := item_3.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_block_type,
			'WP_Block_Type'))))))
		{
			continue
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_block_type, 'attributes'))))) {
			rt.set_property(var_block_type, 'attributes', rt.new_array())
		}
		mut iter_4 := this.block_supports.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_block_support_config := item_4.val
			if !(var_block_support_config.array_isset(rt.new_string('register_attribute'))) {
				continue
			}
			rt.call_function('call_user_func', [
				var_block_support_config.array_get(rt.new_string('register_attribute')),
				var_block_type.clone(),
			])
		}
	}
}

fn get_block_wrapper_attributes(var_extra_attributes rt.PhpVal) string {
	mut var_new_attributes := rt.new_null()
	mut var_attribute_merge_callbacks := map[string]rt.PhpVal{}
	mut var_attributes := rt.new_null()
	mut var_merge_callback := rt.new_null()
	mut var_attribute_name := rt.new_null()
	mut var_new_attribute := rt.new_null()
	mut var_extra_attribute := rt.new_null()
	mut var_value := rt.new_null()
	mut var_normalized_attributes := []rt.PhpVal{}
	mut var_key := rt.new_null()
	var_new_attributes = rt.call_method(Class_WP_Block_Supports.get_instance(),
		'apply_block_supports', []rt.PhpVal{})
	if !rt.is_true(var_new_attributes) && !rt.is_true(var_extra_attributes) {
		return ''
	}
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_new_attribute := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_extra_attribute := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_styles := rt.call_function('array_filter', [
			rt.create_array([
				rt.ArrayItem{
					key: none
					val: var_new_attribute.clone().to_string().trim_space().trim_right(' \t\n\r')
				},
				rt.ArrayItem{
					key: none
					val: var_extra_attribute.clone().to_string().trim_space().trim_right(' \t\n\r')
				},
			]),
		])
		return (rt.call_function('safecss_filter_attr', [
			rt.call_function('implode', [rt.new_string(';'),
				rt.call_function('array_filter', [var_styles.clone()])]),
		])).str()
	}
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_new_attribute := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_extra_attribute := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_classes := rt.call_function('array_merge', [
			rt.cast_array(rt.call_function('preg_split', [rt.new_string('/\\s+/'),
				var_extra_attribute.clone(), rt.new_int(-1), rt.get_constant('PREG_SPLIT_NO_EMPTY')])),
			rt.cast_array(rt.call_function('preg_split', [rt.new_string('/\\s+/'),
				var_new_attribute.clone(), rt.new_int(-1), rt.get_constant('PREG_SPLIT_NO_EMPTY')])),
		])
		var_classes = rt.call_function('array_unique', [
			rt.call_function('array_filter', [var_classes.clone()]),
		])
		return (rt.call_function('implode', [rt.new_string(' '),
			var_classes.clone()])).str()
	}
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_new_attribute := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_extra_attribute := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		return (if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''),
			var_extra_attribute))))
		{
			var_extra_attribute
		} else {
			var_new_attribute
		}).str()
	}
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_new_attribute := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_extra_attribute := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		return (if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''),
			var_extra_attribute))))
		{
			var_extra_attribute
		} else {
			var_new_attribute
		}).str()
	}
	var_attribute_merge_callbacks = {
		'style':      rt.new_closure(closure_3_fn)
		'class':      rt.new_closure(closure_4_fn)
		'id':         rt.new_closure(closure_5_fn)
		'aria-label': rt.new_closure(closure_6_fn)
	}
	var_attributes = rt.new_array()
	for var_attribute_name_shadow, var_merge_callback_shadow in var_attribute_merge_callbacks {
		var_new_attribute = if !(var_new_attributes.array_get(rt.new_string(var_attribute_name_shadow.str()))).is_null() {
			var_new_attributes.array_get(rt.new_string(var_attribute_name_shadow.str()))
		} else {
			rt.new_string('')
		}
		var_extra_attribute = if !(var_extra_attributes.array_get(rt.new_string(var_attribute_name_shadow.str()))).is_null() {
			var_extra_attributes.array_get(rt.new_string(var_attribute_name_shadow.str()))
		} else {
			rt.new_string('')
		}
		var_new_attribute = if var_new_attribute.clone().is_string() {
			var_new_attribute
		} else {
			rt.new_string('')
		}
		var_extra_attribute = if var_extra_attribute.clone().is_string() {
			var_extra_attribute
		} else {
			rt.new_string('')
		}
		if rt.is_true(rt.identical(rt.new_string(''), var_new_attribute))
			&& rt.is_true(rt.identical(rt.new_string(''), var_extra_attribute)) {
			continue
		}
		var_attributes.array_set(rt.new_string(var_attribute_name_shadow.str()), rt.call_callable(var_merge_callback_shadow, [
			var_new_attribute.clone(),
			var_extra_attribute.clone(),
		]))
	}
	mut iter_5 := var_extra_attributes.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_value_shadow := item_5.val
		mut var_attribute_name_shadow := item_5.key
		if !(var_attribute_merge_callbacks.array_isset(var_attribute_name_shadow)) {
			var_attributes.array_set(var_attribute_name_shadow, var_value_shadow.clone())
		}
	}
	if !rt.is_true(var_attributes) {
		return ''
	}
	var_normalized_attributes = rt.new_array()
	mut iter_6 := var_attributes.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_value_shadow := item_6.val
		mut var_key_shadow := item_6.key
		var_normalized_attributes << var_key_shadow.str() + '="' +
			(rt.call_function('esc_attr', [var_value_shadow.clone()])).str() + '"'
	}
	return (rt.call_function('implode', [rt.new_string(' '),
		rt.create_array_from_list(var_normalized_attributes)])).str()
}

struct Class_WP_Block_Type_Registry {
	rt.PhpObjectBase
}

fn create_wp_block_supports(_args ...rt.PhpVal) &Class_WP_Block_Supports {
	mut obj := &Class_WP_Block_Supports{
		PhpObjectBase:  rt.PhpObjectBase{}
		block_supports: rt.new_array()
	}
	return obj
}

fn create_wp_block_type_registry(_args ...rt.PhpVal) &Class_WP_Block_Type_Registry {
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
		else {
			return none
		}
	}
}

fn (this &Class_WP_Block_Supports) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_supports' { return this.block_supports }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Block_Supports) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'block_supports' {
			this.block_supports = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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
	rt.register_func('get_block_wrapper_attributes', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(get_block_wrapper_attributes(arg_0))
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

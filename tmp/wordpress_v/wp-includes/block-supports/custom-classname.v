import rt

fn wp_register_custom_classname_support(var_block_type rt.PhpVal) {
	mut var_has_custom_classname_support := rt.call_function('block_has_support', [
		var_block_type.dup(),
		rt.new_string('customClassName'),
		rt.new_bool(true),
	])
	if rt.is_true(var_has_custom_classname_support) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_block_type, 'attributes'))))) {
			rt.set_property(var_block_type, 'attributes', rt.new_array())
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_block_type,
			'attributes').array_isset(rt.new_string('className')))))))
		{
			rt.get_property(var_block_type, 'attributes').array_set('className', rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
			]))
		}
	}
}

fn wp_apply_custom_classname_support(var_block_type rt.PhpVal, var_block_attributes rt.PhpVal) rt.PhpVal {
	mut var_has_custom_classname_support := rt.call_function('block_has_support', [
		var_block_type.dup(),
		rt.new_string('customClassName'),
		rt.new_bool(true),
	])
	mut var_attributes := rt.new_array()
	if rt.is_true(var_has_custom_classname_support) {
		mut var_has_custom_classnames :=
			var_block_attributes.dup().array_isset(rt.new_string('className'))
		if var_has_custom_classnames {
			var_attributes['class'] = var_block_attributes.array_get('className')
		}
	}
	return var_attributes.dup()
}

struct Class_WP_Block_Supports {
	rt.PhpObjectBase
}

fn create_wp_block_supports() &Class_WP_Block_Supports {
	mut obj := &Class_WP_Block_Supports{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Block_Supports) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Supports) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Supports) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_block_supports_custom_classname_php() {
	rt.call_method(fn () rt.PhpVal {
		mut temp := Class_WP_Block_Supports{}
		return temp.get_instance()
	}(), 'register', [rt.new_string('custom-classname'),
		rt.create_array([
			rt.ArrayItem{ key: 'register_attribute', val: 'wp_register_custom_classname_support' },
			rt.ArrayItem{ key: 'apply', val: 'wp_apply_custom_classname_support' },
		])])
}

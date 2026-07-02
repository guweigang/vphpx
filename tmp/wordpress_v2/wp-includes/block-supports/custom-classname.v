import rt

fn wp_register_custom_classname_support(var_block_type rt.PhpVal) {
	mut var_has_custom_classname_support := rt.new_null()
	var_has_custom_classname_support = rt.call_function('block_has_support', [
		var_block_type.clone(), rt.new_string('customClassName'),
		rt.new_bool(true)])
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
	mut var_has_custom_classname_support := rt.new_null()
	mut var_attributes := map[string]rt.PhpVal{}
	mut var_has_custom_classnames := false
	var_has_custom_classname_support = rt.call_function('block_has_support', [
		var_block_type.clone(), rt.new_string('customClassName'),
		rt.new_bool(true)])
	var_attributes = rt.new_array()
	if rt.is_true(var_has_custom_classname_support) {
		var_has_custom_classnames =
			rt.create_array_from_native_map(var_block_attributes).array_isset(rt.new_string('className'))
		if var_has_custom_classnames {
			var_attributes['class'] = var_block_attributes.array_get(rt.new_string('className'))
		}
	}
	return var_attributes.clone()
}

struct Class_WP_Block_Supports {
	rt.PhpObjectBase
}

fn create_wp_block_supports(_args ...rt.PhpVal) &Class_WP_Block_Supports {
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

fn main() {
	defer {
		rt.shutdown()
	}

	mut iife_temp_0 := Class_WP_Block_Supports{}
	mut iife_result_0 := iife_temp_0.get_instance()
	rt.call_method(iife_result_0, 'register', [rt.new_string('custom-classname'),
		rt.create_array([
			rt.ArrayItem{ key: 'register_attribute', val: 'wp_register_custom_classname_support' },
			rt.ArrayItem{ key: 'apply', val: 'wp_apply_custom_classname_support' },
		])])
}

import rt

fn wp_register_anchor_support(var_block_type rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('block_has_support', [
		var_block_type.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'anchor' }]),
	])))))
	{
		return
	}
	if !(!(rt.get_property(var_block_type, 'attributes')).is_null()) {
		rt.set_property(var_block_type, 'attributes', rt.new_array())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_block_type, 'attributes').array_isset(rt.new_string('anchor'))))))) {
		rt.get_property(var_block_type, 'attributes').array_set('anchor', rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
		]))
	}
}

fn wp_apply_anchor_support(var_block_type rt.PhpVal, var_block_attributes rt.PhpVal) rt.PhpVal {
	if !rt.is_true(var_block_attributes) {
		return rt.new_array()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('block_has_support', [
		var_block_type.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'anchor' }]),
	])))))
	{
		return rt.new_array()
	}
	if !(var_block_attributes.array_isset(rt.new_string('anchor')))
		|| !(var_block_attributes.array_get(rt.new_string('anchor')).is_string())
		|| rt.is_true(rt.identical(rt.new_string(''), var_block_attributes.array_get(rt.new_string('anchor')))) {
		return rt.new_array()
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'id', val: var_block_attributes.array_get(rt.new_string('anchor')) },
	])
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
	rt.call_method(iife_result_0, 'register', [rt.new_string('anchor'),
		rt.create_array([
			rt.ArrayItem{ key: 'register_attribute', val: 'wp_register_anchor_support' },
			rt.ArrayItem{ key: 'apply', val: 'wp_apply_anchor_support' },
		])])
}

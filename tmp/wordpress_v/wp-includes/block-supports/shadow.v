import rt

fn wp_register_shadow_support(var_block_type rt.PhpVal) {
	mut var_has_shadow_support := rt.call_function('block_has_support', [
		var_block_type.dup(), rt.new_string('shadow'), rt.new_bool(false)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_has_shadow_support)))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_block_type, 'attributes'))))) {
		rt.set_property(var_block_type, 'attributes', rt.new_array())
	}
	if rt.is_true(rt.new_bool(rt.get_property(var_block_type, 'attributes').array_isset(rt.new_string('style')))) {
		rt.get_property(var_block_type, 'attributes').array_set('style', rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'object' },
		]))
	}
	if rt.is_true(rt.new_bool(rt.get_property(var_block_type, 'attributes').array_isset(rt.new_string('shadow')))) {
		rt.get_property(var_block_type, 'attributes').array_set('shadow', rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
		]))
	}
}

fn wp_apply_shadow_support(var_block_type rt.PhpVal, var_block_attributes rt.PhpVal) rt.PhpVal {
	mut var_has_shadow_support := rt.call_function('block_has_support', [
		var_block_type.dup(), rt.new_string('shadow'), rt.new_bool(false)])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_has_shadow_support))))
		|| rt.is_true(rt.call_function('wp_should_skip_block_supports_serialization', [var_block_type.dup(), rt.new_string('shadow')]))))
	{
		return rt.new_array()
	}
	mut var_shadow_block_styles := rt.new_array()
	mut var_custom_shadow := if !(var_block_attributes.array_get('style').array_get('shadow')).is_null() {
		var_block_attributes.array_get('style').array_get('shadow')
	} else {
		rt.new_null()
	}
	var_shadow_block_styles['shadow'] = var_custom_shadow.dup()
	mut var_attributes := rt.new_array()
	mut var_styles := rt.call_function('wp_style_engine_get_styles', [
		var_shadow_block_styles.dup()])
	if !(!rt.is_true(var_styles.array_get('css'))) {
		var_attributes['style'] = var_styles.array_get('css')
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

pub fn init_wp_includes_block_supports_shadow_php() {
	rt.call_method(fn () rt.PhpVal {
		mut temp := Class_WP_Block_Supports{}
		return temp.get_instance()
	}(), 'register', [rt.new_string('shadow'),
		rt.create_array([
			rt.ArrayItem{ key: 'register_attribute', val: 'wp_register_shadow_support' },
			rt.ArrayItem{ key: 'apply', val: 'wp_apply_shadow_support' },
		])])
}

import rt

fn wp_register_alignment_support(var_block_type rt.PhpVal) {
	mut var_has_align_support := rt.call_function('block_has_support', [
		var_block_type.dup(), rt.new_string('align'), rt.new_bool(false)])
	if rt.is_true(var_has_align_support) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_block_type, 'attributes'))))) {
			rt.set_property(var_block_type, 'attributes', rt.new_array())
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_block_type,
			'attributes').array_isset(rt.new_string('align')))))))
		{
			rt.get_property(var_block_type, 'attributes').array_set('align', rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'enum', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'left' },
					rt.ArrayItem{ key: none, val: 'center' },
					rt.ArrayItem{ key: none, val: 'right' },
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
					rt.ArrayItem{ key: none, val: '' },
				]) },
			]))
		}
	}
}

fn wp_apply_alignment_support(var_block_type rt.PhpVal, var_block_attributes rt.PhpVal) rt.PhpVal {
	mut var_attributes := rt.new_array()
	mut var_has_align_support := rt.call_function('block_has_support', [
		var_block_type.dup(), rt.new_string('align'), rt.new_bool(false)])
	if rt.is_true(var_has_align_support) {
		mut var_has_block_alignment :=
			var_block_attributes.dup().array_isset(rt.new_string('align'))
		if var_has_block_alignment {
			var_attributes['class'] = rt.call_function('sprintf', [
				rt.new_string('align%s'),
				var_block_attributes.array_get('align'),
			])
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

pub fn init_wp_includes_block_supports_align_php() {
	rt.call_method(fn () rt.PhpVal {
		mut temp := Class_WP_Block_Supports{}
		return temp.get_instance()
	}(), 'register', [rt.new_string('align'),
		rt.create_array([
			rt.ArrayItem{ key: 'register_attribute', val: 'wp_register_alignment_support' },
			rt.ArrayItem{ key: 'apply', val: 'wp_apply_alignment_support' },
		])])
}

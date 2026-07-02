import rt

fn wp_mark_auto_generate_control_attributes(var_args rt.PhpVal) rt.PhpVal {
	mut var_has_auto_register := false
	mut var_attr_schema := map[string]rt.PhpVal{}
	mut var_attr_key := rt.new_null()
	mut var_type := rt.new_null()
	if !rt.is_true(var_args.array_get(rt.new_string('attributes')))
		|| !(var_args.array_get(rt.new_string('attributes')).is_array()) {
		return var_args.clone()
	}
	var_has_auto_register = !(!rt.is_true(var_args.array_get(rt.new_string('supports')).array_get(rt.new_string('autoRegister'))))
	if !var_has_auto_register {
		return var_args.clone()
	}
	mut iter_1 := var_args.array_get(rt.new_string('attributes')).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_attr_schema_shadow := item_1.val
		mut var_attr_key_shadow := item_1.key
		if !(!rt.is_true(var_attr_schema_shadow['source'])) {
			continue
		}
		if var_attr_schema_shadow.array_isset(rt.new_string('role'))
			&& rt.is_true(rt.identical(rt.new_string('local'), var_attr_schema_shadow['role'])) {
			continue
		}
		var_type = if !(var_attr_schema_shadow['type']).is_null() {
			var_attr_schema_shadow['type']
		} else {
			rt.new_null()
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			var_type.clone(),
			rt.create_array([rt.ArrayItem{ key: none, val: 'string' },
				rt.ArrayItem{ key: none, val: 'number' }, rt.ArrayItem{ key: none, val: 'integer' },
				rt.ArrayItem{ key: none, val: 'boolean' }]),
			rt.new_bool(true)])))))
		{
			continue
		}
		var_args.array_get_mut('attributes').array_get_mut(var_attr_key_shadow).array_set('autoGenerateControl',
			true)
	}
	return var_args.clone()
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_filter', [rt.new_string('register_block_type_args'),
		rt.new_string('wp_mark_auto_generate_control_attributes'),
		rt.new_int(5)])
}

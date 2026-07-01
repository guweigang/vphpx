import rt

fn wp_mark_auto_generate_control_attributes(var_args rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(var_args.array_get('attributes'))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args.array_get('attributes').is_array())))))))
	{
		return var_args.dup()
	}
	mut var_has_auto_register := !(!rt.is_true(var_args.array_get('supports').array_get('autoRegister')))
	if !var_has_auto_register {
		return var_args.dup()
	}
	{
		mut iter_1 := var_args.array_get('attributes').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_attr_schema := item_1.val
			mut var_attr_key := item_1.key
			if !(!rt.is_true(var_attr_schema.array_get('source'))) {
				continue
			}
			if rt.is_true(rt.new_bool(var_attr_schema.array_isset(rt.new_string('role'))
				&& rt.is_true(rt.identical(rt.new_string('local'), var_attr_schema.array_get('role')))))
			{
				continue
			}
			mut var_type := if !(var_attr_schema.array_get('type')).is_null() {
				var_attr_schema.array_get('type')
			} else {
				rt.new_null()
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
				var_type.dup(),
				rt.create_array([rt.ArrayItem{ key: none, val: 'string' },
					rt.ArrayItem{ key: none, val: 'number' },
					rt.ArrayItem{ key: none, val: 'integer' },
					rt.ArrayItem{ key: none, val: 'boolean' }]),
				rt.new_bool(true),
			])))))
			{
				continue
			}
			var_args.array_get_mut('attributes').array_get_mut(var_attr_key).array_set('autoGenerateControl',
				true)
		}
	}
	return var_args.dup()
}

pub fn init_wp_includes_block_supports_auto_register_php() {
	rt.call_function('add_filter', [rt.new_string('register_block_type_args'),
		rt.new_string('wp_mark_auto_generate_control_attributes'),
		rt.new_int(5)])
}

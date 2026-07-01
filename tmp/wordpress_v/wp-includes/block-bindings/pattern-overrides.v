import rt

fn _block_bindings_pattern_overrides_get_value(var_source_args rt.PhpVal, var_block_instance rt.PhpVal, attribute_name string) rt.PhpVal {
	if !rt.is_true(rt.get_property(var_block_instance, 'attributes').array_get('metadata').array_get('name')) {
		return rt.new_null()
	}
	mut var_metadata_name :=
		rt.get_property(var_block_instance, 'attributes').array_get('metadata').array_get('name')
	return rt.call_function('_wp_array_get', [
		rt.get_property(var_block_instance, 'context'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'pattern/overrides' },
			rt.ArrayItem{ key: none, val: var_metadata_name },
			rt.ArrayItem{ key: none, val: attribute_name }]),
		rt.new_null(),
	])
}

fn _register_block_bindings_pattern_overrides_source() {
	rt.call_function('register_block_bindings_source', [
		rt.new_string('core/pattern-overrides'),
		rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Pattern Overrides'),
				rt.new_string('block bindings source'),
			]) },
			rt.ArrayItem{
				key: 'get_value_callback'
				val: '_block_bindings_pattern_overrides_get_value'
			},
			rt.ArrayItem{ key: 'uses_context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'pattern/overrides' },
			]) },
		]),
	])
}

pub fn init_wp_includes_block_bindings_pattern_overrides_php() {
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('_register_block_bindings_pattern_overrides_source')])
}

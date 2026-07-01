import rt

fn wp_should_skip_block_supports_serialization(var_block_type rt.PhpVal, var_feature_set rt.PhpVal, var_feature rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_block_type.dup().is_object())))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_feature_set))))))
	{
		return false
	}
	mut var_path := [var_feature_set, rt.new_string('__experimentalSkipSerialization')]
	mut var_skip_serialization := rt.call_function('_wp_array_get', [
		rt.get_property(var_block_type, 'supports'),
		var_path.dup(),
		rt.new_bool(false),
	])
	if rt.is_true(rt.new_bool(var_skip_serialization.dup().is_array())) {
		return (rt.call_function('in_array', [var_feature.dup(),
			var_skip_serialization.dup(), rt.new_bool(true)])).to_bool()
	}
	return var_skip_serialization.to_bool()
}

pub fn init_wp_includes_block_supports_utils_php() {
}

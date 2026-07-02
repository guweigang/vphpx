import rt

fn wp_should_skip_block_supports_serialization(var_block_type rt.PhpVal, var_feature_set rt.PhpVal, var_feature rt.PhpVal) bool {
	mut var_path := []rt.PhpVal{}
	mut var_skip_serialization := rt.new_null()
	if !(var_block_type.clone().is_object())
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_feature_set)))) {
		return false
	}
	var_path = [var_feature_set, rt.new_string('__experimentalSkipSerialization')]
	var_skip_serialization = rt.call_function('_wp_array_get', [
		rt.get_property(var_block_type, 'supports'),
		rt.create_array_from_list(var_path),
		rt.new_bool(false),
	])
	if rt.is_true(rt.new_bool(var_skip_serialization.clone().is_array())) {
		return (rt.call_function('in_array', [var_feature.clone(),
			var_skip_serialization.clone(), rt.new_bool(true)])).to_bool()
	}
	return var_skip_serialization.to_bool()
}

fn main() {
	defer {
		rt.shutdown()
	}
}

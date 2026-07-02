import rt

fn wp_get_block_default_classname(var_block_name rt.PhpVal) rt.PhpVal {
	mut var_classname := rt.new_null()
	var_classname =
		rt.new_string('wp-block-' +(rt.call_function('preg_replace', [rt.new_string('/^core-/'), rt.new_string(''), rt.call_function('str_replace', [rt.new_string('/'), rt.new_string('-'), var_block_name.clone()])])).str())
	var_classname = rt.call_function('apply_filters', [
		rt.new_string('block_default_classname'),
		var_classname.clone(),
		var_block_name.clone(),
	])
	return var_classname.clone()
}

fn wp_apply_generated_classname_support(var_block_type rt.PhpVal) rt.PhpVal {
	mut var_attributes := map[string]rt.PhpVal{}
	mut var_has_generated_classname_support := rt.new_null()
	mut var_block_classname := rt.new_null()
	var_attributes = map[string]rt.PhpVal{}
	var_has_generated_classname_support = rt.call_function('block_has_support', [
		var_block_type.clone(),
		rt.new_string('className'),
		rt.new_bool(true),
	])
	if rt.is_true(var_has_generated_classname_support) {
		var_block_classname =
			wp_get_block_default_classname(rt.get_property(var_block_type, 'name'))
		if rt.is_true(var_block_classname) {
			var_attributes['class'] = var_block_classname.clone()
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
	rt.call_method(iife_result_0, 'register', [rt.new_string('generated-classname'),
		rt.create_array([
			rt.ArrayItem{ key: 'apply', val: 'wp_apply_generated_classname_support' },
		])])
}

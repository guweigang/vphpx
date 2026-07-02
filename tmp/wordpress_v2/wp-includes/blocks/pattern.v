import rt

fn register_block_core_pattern() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/pattern'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_pattern' },
		]),
	])
}

fn render_block_core_pattern(var_attributes rt.PhpVal) string {
	mut var_seen_refs := rt.new_null()
	mut var_wp_embed := rt.new_null()
	mut var_slug := rt.new_null()
	mut var_registry := rt.new_null()
	mut var_is_debug := false
	mut var_pattern := rt.new_null()
	mut var_content := rt.new_null()
	if !rt.is_true(var_attributes.array_get(rt.new_string('slug'))) {
		return ''
	}
	var_slug = var_attributes.array_get(rt.new_string('slug'))
	mut iife_temp_0 := Class_WP_Block_Patterns_Registry{}
	mut iife_result_0 := iife_temp_0.get_instance()
	var_registry = iife_result_0
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_registry, 'is_registered', [
		var_slug.clone(),
	])))))
	{
		return ''
	}
	if var_seen_refs.array_isset(var_attributes.array_get(rt.new_string('slug'))) {
		var_is_debug = rt.is_true(rt.get_constant('WP_DEBUG'))
			&& rt.is_true(rt.get_constant('WP_DEBUG_DISPLAY'))
		return (if var_is_debug {
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('[block rendering halted for pattern "%s"]'),
				]),
				var_slug.clone(),
			])
		} else {
			rt.new_string('')
		}).str()
	}
	var_pattern = rt.call_method(var_registry, 'get_registered', [
		var_slug.clone()])
	var_content = var_pattern.array_get(rt.new_string('content'))
	var_seen_refs.array_set(var_attributes.array_get(rt.new_string('slug')), true)
	var_content = rt.call_function('do_blocks', [var_content.clone()])
	var_content = rt.call_method(var_wp_embed, 'autoembed', [
		var_content.clone()])
	var_seen_refs.array_unset(var_attributes.array_get(rt.new_string('slug')))
	return var_content.str()
}

struct Class_WP_Block_Patterns_Registry {
	rt.PhpObjectBase
}

fn create_wp_block_patterns_registry(_args ...rt.PhpVal) &Class_WP_Block_Patterns_Registry {
	mut obj := &Class_WP_Block_Patterns_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Block_Patterns_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Patterns_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Patterns_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action',
		[rt.new_string('init'), rt.new_string('register_block_core_pattern')])
}

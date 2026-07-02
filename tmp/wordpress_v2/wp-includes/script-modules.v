import rt

fn wp_script_modules() rt.PhpVal {
	mut var_wp_script_modules := rt.new_null()
	if !(true) {
		var_wp_script_modules = create_wp_script_modules()
	}
	return mut var_wp_script_modules
}

fn wp_register_script_module(id string, src string, var_deps rt.PhpVal, version bool, var_args rt.PhpVal) {
	mut var_id := id
	mut var_src := src
	mut var_version := version
	rt.call_method(wp_script_modules(), 'register', [rt.new_string(id),
		rt.new_string(src), var_deps.clone(), rt.new_bool(version),
		rt.create_array_from_native_map(var_args)])
}

fn wp_enqueue_script_module(id string, src string, var_deps rt.PhpVal, version bool, var_args rt.PhpVal) {
	mut var_id := id
	mut var_src := src
	mut var_version := version
	rt.call_method(wp_script_modules(), 'enqueue', [rt.new_string(id),
		rt.new_string(src), var_deps.clone(), rt.new_bool(version),
		rt.create_array_from_native_map(var_args)])
}

fn wp_dequeue_script_module(id string) {
	mut var_id := id
	rt.call_method(wp_script_modules(), 'dequeue', [rt.new_string(id)])
}

fn wp_deregister_script_module(id string) {
	mut var_id := id
	rt.call_method(wp_script_modules(), 'deregister', [rt.new_string(id)])
}

fn wp_set_script_module_translations(id string, domain string, path string) bool {
	mut var_id := id
	mut var_domain := domain
	mut var_path := path
	return (rt.call_method(wp_script_modules(), 'set_translations', [
		rt.new_string(id), rt.new_string(domain), rt.new_string(path)])).to_bool()
}

fn wp_default_script_modules() {
	mut var_suffix := rt.new_null()
	mut var_assets_file := rt.new_null()
	mut var_assets := rt.new_null()
	mut var_script_module_data := map[string]rt.PhpVal{}
	mut var_file_name := rt.new_null()
	mut var_script_module_id := rt.new_null()
	mut var_args := map[string]rt.PhpVal{}
	mut var_path := rt.new_null()
	mut var_module_deps := rt.new_null()
	var_suffix = if rt.is_true(rt.call_function('defined', [
		rt.new_string('WP_RUN_CORE_TESTS'),
	]))
	{ rt.new_string('.min') } else { rt.call_function('wp_scripts_get_suffix', []rt.PhpVal{}) }
	var_assets_file = rt.new_string(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/assets/script-modules-packages.php')
	var_assets = if rt.is_true(rt.call_function('file_exists', [
		var_assets_file.clone()]))
	{ rt.include_file(var_assets_file.to_string(), '1') } else { rt.new_array() }
	mut iter_1 := var_assets.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_script_module_data_shadow := item_1.val
		mut var_file_name_shadow := item_1.key
		var_script_module_id =
			rt.new_string('@wordpress/' +(rt.call_function('preg_replace', [rt.new_string('~(?:/index)?(?:\\.min)?\\.js$~D'), rt.new_string(''), var_file_name_shadow.clone(), rt.new_int(1)])).str())
		var_args = rt.new_array()
		if rt.is_true(rt.call_function('str_starts_with', [var_script_module_id.clone(), rt.new_string('@wordpress/interactivity')]))
			|| rt.is_true(rt.call_function('str_starts_with', [var_script_module_id.clone(), rt.new_string('@wordpress/block-library')]))
			|| rt.is_true(rt.identical(rt.new_string('@wordpress/a11y'), var_script_module_id)) {
			var_args['fetchpriority'] = rt.new_string('low')
			var_args['in_footer'] = rt.new_bool(true)
		}
		if rt.is_true(rt.call_function('str_starts_with', [var_script_module_id.clone(),
			rt.new_string('@wordpress/block-library')]))
		{
			rt.call_method(rt.call_function('wp_interactivity', []rt.PhpVal{}),
				'add_client_navigation_support_to_script_module', [
				var_script_module_id.clone()])
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_suffix)))) {
			var_file_name_shadow = rt.call_function('str_replace', [
				rt.new_string('.js'), rt.new_string(var_suffix.str() + '.js'),
				var_file_name_shadow.clone()])
		}
		var_path = rt.call_function('includes_url', [
			rt.new_string('js/dist/script-modules/${var_file_name.to_string()}'),
		])
		var_module_deps = if !(var_script_module_data_shadow['module_dependencies']).is_null() {
			var_script_module_data_shadow['module_dependencies']
		} else {
			rt.new_array()
		}
		wp_register_script_module(var_script_module_id.clone(), var_path.clone(),
			var_module_deps.clone(), var_script_module_data_shadow['version'],
			rt.create_array_from_native_map(var_args))
	}
}

fn wp_enqueue_block_editor_script_modules() {
	wp_enqueue_script_module('@wordpress/latex-to-mathml/loader', '', rt.new_null(), false,
		rt.new_null())
}

struct Class_WP_Script_Modules {
	rt.PhpObjectBase
}

fn create_wp_script_modules(_args ...rt.PhpVal) &Class_WP_Script_Modules {
	mut obj := &Class_WP_Script_Modules{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Script_Modules) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Script_Modules) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Script_Modules) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

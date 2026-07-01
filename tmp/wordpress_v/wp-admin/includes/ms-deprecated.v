import rt

fn wpmu_menu() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('3.0.0')])
	// unsupported statement: Stmt_Nop
}

fn wpmu_checkAvailableSpace() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('3.0.0'), rt.new_string('is_upload_space_available()')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_upload_space_available', []rt.PhpVal{}))))) {
		rt.call_function('wp_die', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Sorry, you have used your space allocation of %s. Please delete some files to upload more files.')]), rt.call_function('size_format', [rt.mul(rt.call_function('get_space_allowed', []rt.PhpVal{}), rt.get_constant('MB_IN_BYTES'))])])])
	}
}

fn mu_options(var_options rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('3.0.0')])
	return var_options.dup()
}

fn activate_sitewide_plugin() bool {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('3.0.0'), rt.new_string('activate_plugin()')])
	return false
}

fn deactivate_sitewide_plugin(plugin bool) {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('3.0.0'), rt.new_string('deactivate_plugin()')])
}

fn is_wpmu_sitewide_plugin(var_file rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('3.0.0'), rt.new_string('is_network_only_plugin()')])
	return rt.call_function('is_network_only_plugin', [var_file.dup()])
}

fn get_site_allowed_themes() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('3.4.0'), rt.new_string('WP_Theme::get_allowed_on_network()')])
	return rt.call_function('array_map', [rt.new_string('intval'), fn () rt.PhpVal { mut temp := Class_WP_Theme{}; return temp.get_allowed_on_network() }()])
}

fn wpmu_get_blog_allowedthemes(blog_id i64) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('3.4.0'), rt.new_string('WP_Theme::get_allowed_on_site()')])
	return rt.call_function('array_map', [rt.new_string('intval'), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Theme{}; return temp.get_allowed_on_site(arg_0) }(rt.new_int(blog_id))])
}

fn ms_deprecated_blogs_file() {
}

fn install_global_terms() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('6.1.0')])
}

fn sync_category_tag_slugs(var_term rt.PhpVal, var_taxonomy rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('6.1.0')])
	return var_term.dup()
}

struct Class_WP_Theme {
	rt.PhpObjectBase
}

fn create_wp_theme() &Class_WP_Theme {
	mut obj := &Class_WP_Theme{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Theme) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Theme) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Theme) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_admin_includes_ms_deprecated_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('install_global_terms')]))))) {
	}
}

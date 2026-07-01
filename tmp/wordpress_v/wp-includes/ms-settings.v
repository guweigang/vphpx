import rt

struct Class_WP_Network {
	rt.PhpObjectBase
}

struct Class_WP_Site {
	rt.PhpObjectBase
}

fn create_wp_network() &Class_WP_Network {
	mut obj := &Class_WP_Network{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_site() &Class_WP_Site {
	mut obj := &Class_WP_Site{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Network) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Network) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Network) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Site) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Site) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Site) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_ms_settings_php() {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	// unsupported statement: Stmt_Global
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-network.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-site.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/ms-load.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/ms-default-constants.php', '4')
	if rt.is_true(rt.call_function('defined', [rt.new_string('SUNRISE')])) {
		rt.include_file((rt.get_constant('WP_CONTENT_DIR')).str() + '/sunrise.php', '2')
	}
	rt.call_function('ms_subdomain_constants', []rt.PhpVal{})
	if !(!(var_current_site).is_null()) || !(!(var_current_blog).is_null()) {
		mut var_domain := rt.new_string(rt.new_string(rt.call_function('stripslashes', [if !(rt.get_superglobal('_SERVER').array_get('HTTP_HOST')).is_null() { rt.get_superglobal('_SERVER').array_get('HTTP_HOST') } else { rt.new_string('') }]).to_string().to_lower()))
		if rt.is_true(rt.call_function('str_ends_with', [var_domain.dup(), rt.new_string(':80')])) {
			var_domain = rt.call_function('substr', [var_domain.dup(), rt.new_int(0), // unsupported expression: Expr_UnaryMinus])
			rt.get_superglobal('_SERVER').array_set('HTTP_HOST', rt.call_function('substr', [rt.get_superglobal('_SERVER').array_get('HTTP_HOST'), rt.new_int(0), // unsupported expression: Expr_UnaryMinus]))
		} else if rt.is_true(rt.call_function('str_ends_with', [var_domain.dup(), rt.new_string(':443')])) {
			var_domain = rt.call_function('substr', [var_domain.dup(), rt.new_int(0), // unsupported expression: Expr_UnaryMinus])
			rt.get_superglobal('_SERVER').array_set('HTTP_HOST', rt.call_function('substr', [rt.get_superglobal('_SERVER').array_get('HTTP_HOST'), rt.new_int(0), // unsupported expression: Expr_UnaryMinus]))
		}
		mut var_path := rt.call_function('stripslashes', [rt.get_superglobal('_SERVER').array_get('REQUEST_URI')])
		if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
			var_path = rt.call_function('preg_replace', [rt.new_string('#(.*)/wp-admin/.*#'), rt.new_string('$1/'), var_path.dup()])
		}
		// unsupported assign target: Expr_List
		mut var_bootstrap_result := rt.call_function('ms_load_current_site_and_network', [var_domain.dup(), var_path.dup(), rt.call_function('is_subdomain_install', []rt.PhpVal{})])
		if rt.is_true(rt.identical(rt.new_bool(true), var_bootstrap_result)) {
			// unsupported statement: Stmt_Nop
		} else if rt.is_true(rt.identical(rt.new_bool(false), var_bootstrap_result)) {
			rt.call_function('ms_not_installed', [var_domain.dup(), var_path.dup()])
		} else {
			rt.call_function('header', ['Location: ' + (var_bootstrap_result).str()])
			// unsupported expression: Expr_Exit
		}
		var_bootstrap_result = rt.new_null()
		mut var_blog_id := rt.get_property(var_current_blog, 'blog_id')
		mut var_public := rt.get_property(var_current_blog, 'public')
		if !rt.is_true(rt.get_property(var_current_blog, 'site_id')) {
			rt.set_property(var_current_blog, 'site_id', rt.new_int(1))
		}
		mut var_site_id := rt.get_property(var_current_blog, 'site_id')
		rt.call_function('wp_load_core_site_options', [var_site_id.dup()])
	}
	rt.call_method(var_wpdb, 'set_prefix', [var_table_prefix.dup(), rt.new_bool(false)])
	rt.call_method(var_wpdb, 'set_blog_id', [rt.get_property(var_current_blog, 'blog_id'), rt.get_property(var_current_blog, 'site_id')])
	mut var_table_prefix := rt.call_method(var_wpdb, 'get_blog_prefix', []rt.PhpVal{})
	mut var__wp_switched_stack := rt.new_array()
	mut var_switched := false
	rt.call_function('wp_start_object_cache', []rt.PhpVal{})
	if !(true) {
		mut var_current_site := create_wp_network(var_current_site.dup())
	}
	if !(true) {
		mut var_current_blog := create_wp_site(var_current_blog.dup())
	}
	rt.call_function('ms_upload_constants', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('ms_loaded')])
}

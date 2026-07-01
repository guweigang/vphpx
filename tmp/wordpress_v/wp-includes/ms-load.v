import rt

fn is_subdomain_install() bool {
	if rt.is_true(rt.call_function('defined', [rt.new_string('SUBDOMAIN_INSTALL')])) {
		return (rt.get_constant('SUBDOMAIN_INSTALL')).to_bool()
	}
	return rt.is_true(rt.call_function('defined', [rt.new_string('VHOST')])) && rt.is_true(rt.identical(rt.new_string('yes'), rt.get_constant('VHOST')))
}

fn wp_get_active_network_plugins() rt.PhpVal {
	mut var_active_plugins := rt.cast_array(rt.call_function('get_site_option', [rt.new_string('active_sitewide_plugins'), rt.new_array()]))
	if !rt.is_true(var_active_plugins) {
		return rt.new_array()
	}
	mut var_plugins := rt.new_array()
	var_active_plugins = rt.func_array_keys(var_active_plugins.dup())
	rt.call_function('sort', [var_active_plugins.dup()])
	{
		mut iter_1 := var_active_plugins.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_plugin := item_1.val
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('validate_file', [var_plugin.dup()]))))) && rt.is_true(rt.call_function('str_ends_with', [var_plugin.dup(), rt.new_string('.php')])))) && rt.is_true(rt.call_function('file_exists', [(rt.get_constant('WP_PLUGIN_DIR')).str() + '/' + (var_plugin).str()])))) {
				var_plugins << (rt.get_constant('WP_PLUGIN_DIR')).str() + '/' + (var_plugin).str()
			}
		}
	}
	return var_plugins.dup()
}

fn ms_site_check() rt.PhpVal {
	mut var_check := rt.call_function('apply_filters', [rt.new_string('ms_site_check'), rt.new_null()])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_bool(true)
	}
	if rt.is_true(rt.call_function('is_super_admin', []rt.PhpVal{})) {
		return rt.new_bool(true)
	}
	mut var_blog := rt.call_function('get_site', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_string('1'), rt.get_property(var_blog, 'deleted'))) {
		if rt.is_true(rt.call_function('file_exists', [(rt.get_constant('WP_CONTENT_DIR')).str() + '/blog-deleted.php'])) {
			return rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + '/blog-deleted.php')
		} else {
			rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('This site is no longer available.')]), rt.new_string(''), rt.create_array([rt.ArrayItem{ key: 'response', val: 410 }])])
		}
	}
	if rt.is_true(rt.identical(rt.new_string('2'), rt.get_property(var_blog, 'deleted'))) {
		if rt.is_true(rt.call_function('file_exists', [(rt.get_constant('WP_CONTENT_DIR')).str() + '/blog-inactive.php'])) {
			return rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + '/blog-inactive.php')
		} else {
			mut var_admin_email := rt.call_function('str_replace', [rt.new_string('@'), rt.new_string(' AT '), rt.call_function('get_site_option', [rt.new_string('admin_email'), 'support@' + (rt.get_property(rt.call_function('get_network', []rt.PhpVal{}), 'domain')).str()])])
			rt.call_function('wp_die', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('This site has not been activated yet. If you are having problems activating your site, please contact %s.')]), rt.call_function('sprintf', [rt.new_string('<a href="mailto:%1$s">%1$s</a>'), var_admin_email.dup()])])])
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('1'), rt.get_property(var_blog, 'archived'))) || rt.is_true(rt.identical(rt.new_string('1'), rt.get_property(var_blog, 'spam'))))) {
		if rt.is_true(rt.call_function('file_exists', [(rt.get_constant('WP_CONTENT_DIR')).str() + '/blog-suspended.php'])) {
			return rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + '/blog-suspended.php')
		} else {
			rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('This site has been archived or suspended.')]), rt.new_string(''), rt.create_array([rt.ArrayItem{ key: 'response', val: 410 }])])
		}
	}
	return rt.new_bool(true)
}

fn get_network_by_path(var_domain rt.PhpVal, var_path rt.PhpVal, var_segments rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Network{}; return temp.get_by_path(arg_0, arg_1, arg_2) }(var_domain.dup(), var_path.dup(), var_segments.dup())
}

fn get_site_by_path(var_domain rt.PhpVal, var_path rt.PhpVal, var_segments rt.PhpVal) bool {
	mut var_path_segments := rt.call_function('array_filter', [rt.call_function('explode', [rt.new_string('/'), rt.new_string(var_path.dup().to_string().trim_space())])])
	var_segments = rt.call_function('apply_filters', [rt.new_string('site_by_path_segments_count'), var_segments.dup(), var_domain.dup(), var_path.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.greater(rt.new_int(var_path_segments.dup().array_count()), var_segments)))) {
		var_path_segments = rt.call_function('array_slice', [var_path_segments.dup(), rt.new_int(0), var_segments.dup()])
	}
	mut var_paths := rt.new_array()
	for rt.is_true(rt.new_int(var_path_segments.dup().array_count())) {
		var_paths << '/' + (rt.call_function('implode', [rt.new_string('/'), var_path_segments.dup()])).str() + '/'
		rt.call_function('array_pop', [var_path_segments.dup()])
	}
	var_paths << '/'
	mut var_pre := rt.call_function('apply_filters', [rt.new_string('pre_get_site_by_path'), rt.new_null(), var_domain.dup(), var_path.dup(), var_segments.dup(), var_paths.dup()])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_pre, 'WP_Site')))))))) {
			var_pre = create_wp_site(var_pre.dup())
		}
		return (var_pre).to_bool()
	}
	mut var_domains := [var_domain]
	if rt.is_true(rt.call_function('str_starts_with', [var_domain.dup(), rt.new_string('www.')])) {
		var_domains << rt.call_function('substr', [var_domain.dup(), rt.new_int(4)])
	}
	mut var_args := { 'number': rt.new_int(1), 'update_site_meta_cache': rt.new_bool(false) }
	if var_domains.len > 1 {
		var_args['domain__in'] = var_domains.dup()
		var_args.array_get_mut('orderby').array_set('domain_length', 'DESC')
	} else {
		var_args['domain'] = rt.call_function('array_shift', [var_domains.dup()])
	}
	if var_paths.len > 1 {
		var_args['path__in'] = var_paths.dup()
		var_args.array_get_mut('orderby').array_set('path_length', 'DESC')
	} else {
		var_args['path'] = rt.call_function('array_shift', [var_paths.dup()])
	}
	mut var_result := rt.call_function('get_sites', [var_args.dup()])
	mut var_site := rt.call_function('array_shift', [var_result.dup()])
	if rt.is_true(var_site) {
		return (var_site).to_bool()
	}
	return false
}

fn ms_load_current_site_and_network(var_domain rt.PhpVal, var_path rt.PhpVal, subdomain bool) bool {
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('DOMAIN_CURRENT_SITE')])) && rt.is_true(rt.call_function('defined', [rt.new_string('PATH_CURRENT_SITE')])))) {
		mut var_current_site := create_stdclass()
		rt.set_property(var_current_site, 'id', if rt.is_true(rt.call_function('defined', [rt.new_string('SITE_ID_CURRENT_SITE')])) { rt.get_constant('SITE_ID_CURRENT_SITE') } else { rt.new_int(1) })
		rt.set_property(var_current_site, 'domain', rt.get_constant('DOMAIN_CURRENT_SITE'))
		rt.set_property(var_current_site, 'path', rt.get_constant('PATH_CURRENT_SITE'))
		if rt.is_true(rt.call_function('defined', [rt.new_string('BLOG_ID_CURRENT_SITE')])) {
			rt.set_property(var_current_site, 'blog_id', rt.get_constant('BLOG_ID_CURRENT_SITE'))
		} else if rt.is_true(rt.call_function('defined', [rt.new_string('BLOGID_CURRENT_SITE')])) {
			rt.set_property(var_current_site, 'blog_id', rt.get_constant('BLOGID_CURRENT_SITE'))
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strcasecmp', [rt.get_property(var_current_site, 'domain'), var_domain.dup()]))) && rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strcasecmp', [rt.get_property(var_current_site, 'path'), var_path.dup()]))))) {
			mut var_current_blog := rt.new_bool(rt.new_bool(get_site_by_path(var_domain.dup(), var_path.dup(), rt.new_null())))
		} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strcasecmp', [rt.get_property(var_current_site, 'domain'), var_domain.dup()]))))) && rt.is_true(rt.identical(rt.new_int(0), rt.call_function('stripos', [var_path.dup(), rt.get_property(var_current_site, 'path')]))))) {
			var_current_blog = rt.new_bool(rt.new_bool(get_site_by_path(var_domain.dup(), var_path.dup(), 1 + rt.call_function('explode', [rt.new_string('/'), rt.new_string(rt.get_property(var_current_site, 'path').to_string().trim_space())]).array_count())))
		} else {
			var_current_blog = rt.new_bool(rt.new_bool(get_site_by_path(var_domain.dup(), var_path.dup(), rt.new_int(1))))
		}
	} else if !(var_subdomain) {
		var_current_site = rt.call_function('wp_cache_get', [rt.new_string('current_network'), rt.new_string('site-options')])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_current_site)))) {
			mut var_networks := rt.call_function('get_networks', [rt.create_array([rt.ArrayItem{ key: 'number', val: 2 }])])
			if var_networks.dup().array_count() == 1 {
				var_current_site = rt.call_function('array_shift', [var_networks.dup()])
				rt.call_function('wp_cache_add', [rt.new_string('current_network'), var_current_site.dup(), rt.new_string('site-options')])
			} else if !rt.is_true(var_networks) {
				return false
			}
		}
		if !rt.is_true(var_current_site) {
			var_current_site = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Network{}; return temp.get_by_path(arg_0, arg_1, arg_2) }(var_domain.dup(), var_path.dup(), rt.new_int(1))
		}
		if !rt.is_true(var_current_site) {
			rt.call_function('do_action', [rt.new_string('ms_network_not_found'), var_domain.dup(), var_path.dup()])
			return false
		} else if rt.is_true(rt.identical(var_path, rt.get_property(var_current_site, 'path'))) {
			var_current_blog = rt.new_bool(rt.new_bool(get_site_by_path(var_domain.dup(), var_path.dup(), rt.new_null())))
		} else {
			var_current_blog = rt.new_bool(rt.new_bool(get_site_by_path(var_domain.dup(), var_path.dup(), rt.call_function('substr_count', [rt.get_property(var_current_site, 'path'), rt.new_string('/')]))))
		}
	} else {
		var_current_blog = rt.new_bool(rt.new_bool(get_site_by_path(var_domain.dup(), var_path.dup(), rt.new_int(1))))
		if rt.is_true(var_current_blog) {
			var_current_site = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Network{}; return temp.get_instance(arg_0) }(if rt.is_true(rt.get_property(var_current_blog, 'site_id')) { rt.get_property(var_current_blog, 'site_id') } else { rt.new_int(1) })
		} else {
			var_current_site = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Network{}; return temp.get_by_path(arg_0, arg_1, arg_2) }(var_domain.dup(), var_path.dup(), rt.new_int(1))
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_current_blog) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_current_site = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Network{}; return temp.get_instance(arg_0) }(rt.get_property(var_current_blog, 'site_id'))
	}
	if !rt.is_true(var_current_site) {
		rt.call_function('do_action', [rt.new_string('ms_network_not_found'), var_domain.dup(), var_path.dup()])
		return false
	}
	if rt.is_true(rt.new_bool(!rt.is_true(var_current_blog) && rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{})))) {
		var_current_blog = create_stdclass()
		rt.set_property(var_current_blog, 'blog_id', rt.new_int(1))
		mut var_blog_id := 1
		rt.set_property(var_current_blog, 'public', rt.new_int(1))
	}
	if !rt.is_true(var_current_blog) {
		mut var_scheme := if rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{})) { 'https' } else { 'http' }
		mut var_destination := rt.new_string(rt.concat(rt.concat(rt.concat(rt.new_string(var_scheme), rt.new_string('://')), rt.get_property(var_current_site, 'domain')), rt.get_property(var_current_site, 'path')))
		rt.call_function('do_action', [rt.new_string('ms_site_not_found'), var_current_site.dup(), var_domain.dup(), var_path.dup()])
		if rt.is_true(rt.new_bool(var_subdomain && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('NOBLOGREDIRECT')]))))))) {
			var_path = rt.new_string('wp-signup.php?new=' + (rt.call_function('str_replace', ['.' + (rt.get_property(var_current_site, 'domain')).str(), rt.new_string(''), var_domain.dup()])).str())
			var_destination = rt.call_function('apply_filters', [rt.new_string('network_site_url'), rt.concat(var_destination, var_path), var_path.dup(), rt.new_string(var_scheme).dup()])
		} else if var_subdomain {
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				var_destination = rt.get_constant('NOBLOGREDIRECT')
			}
		} else if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strcasecmp', [rt.get_property(var_current_site, 'domain'), var_domain.dup()]))) {
			return false
		}
		return (var_destination).to_bool()
	}
	if !rt.is_true(rt.get_property(var_current_site, 'blog_id')) {
		rt.set_property(var_current_site, 'blog_id', rt.call_function('get_main_site_id', [rt.get_property(var_current_site, 'id')]))
	}
	return true
}

fn ms_not_installed(var_domain rt.PhpVal, var_path rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		rt.call_function('dead_db', []rt.PhpVal{})
	}
	rt.call_function('wp_load_translations_early', []rt.PhpVal{})
	mut var_title := rt.call_function('__', [])
	mut var_msg := rt.new_string()
	
}

struct Class_WP_Network {
	rt.PhpObjectBase
}

struct Class_WP_Site {
	rt.PhpObjectBase
}

struct Class_stdClass {
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

fn create_stdclass() &Class_stdClass {
	mut obj := &Class_stdClass{
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


fn (mut this Class_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_ms_load_php() {
}
